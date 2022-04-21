from collections import Counter
import numpy as np
import matplotlib.pyplot as plt
import PIL
from sklearn.cluster import KMeans

N=10

def get_cluster_results(k_cluster):
    n_pixels = len(k_cluster.labels_)
    counter = Counter(k_cluster.labels_) # count how many pixels per cluster
    perc = {}
    for i in counter:
        perc[i] = np.round(counter[i]/n_pixels, 2)
    perc = dict(sorted(perc.items()))
        
    return k_cluster.cluster_centers_, perc    

def get_image_color_features(masked_img):
    
    #extract the pixels with alpha values lower than 50
    image_arr = np.array(masked_img)
    image_arr = np.reshape(image_arr, (-1, 4))
    image_arr = image_arr[image_arr[:,3] > 50][:,:3]
    
    clt = KMeans(n_clusters=N)
    clt_1 = clt.fit(image_arr)
    colors, percentages = get_cluster_results(clt_1)
    return colors, percentages

def color_pair_score(color1, color2):
    color1 = np.array(color1)
    color2 = np.array(color2)
    color_distance = np.linalg.norm(color1 - color2)
    #print(color_distance)
    return -color_distance**2

def create_score_matrix(color_arr_1, color_arr_2):
    score_arr = np.zeros((len(color_arr_1), len(color_arr_2)))
    for x, color1 in enumerate(color_arr_1):
        for y, color2 in enumerate(color_arr_2):
            score = color_pair_score(color1, color2)
            score_arr[x, y] = score
    return score_arr    

def wPrefersM1OverM(color_pair_matrix, w, m, m1):
    if(color_pair_matrix[w][m1] > color_pair_matrix[w][m]):
         return True
    else:
        return False

def find_color_pairs(color_pair_matrix):
     
    # Stores partner of women. This is our output
    # array that stores passing information.
    # The value of wPartner[i] indicates the partner
    # assigned to woman N+i. Note that the woman numbers
    # between N and 2*N-1. The value -1 indicates
    # that (N+i)'th woman is free
    wPartner = [-1 for i in range(N)]
 
    # An array to store availability of men.
    # If mFree[i] is false, then man 'i' is free,
    # otherwise engaged.
    mFree = [False for i in range(N)]
 
    freeCount = N
 
    # While there are free men
    while (freeCount > 0):
         
        # Pick the first free man (we could pick any)
        m = 0
        while (m < N):
            if (mFree[m] == False):
                break
            m += 1
 
        # One by one go to all women according to
        # m's preferences. Here m is the picked free man
        i = 0
        m_pref = np.flip(np.argsort(color_pair_matrix[:, m]))
        while i < N and mFree[m] == False:
            w = m_pref[i]
 
            # The woman of preference is free,
            # w and m become partners (Note that
            # the partnership maybe changed later).
            # So we can say they are engaged not married
            if (wPartner[w] == -1):
                wPartner[w] = m
                mFree[m] = True
                freeCount -= 1
 
            else:
                 
                # If w is not free
                # Find current engagement of w
                m1 = wPartner[w]
 
                # If w prefers m over her current engagement m1,
                # then break the engagement between w and m1 and
                # engage m with w.
                if (wPrefersM1OverM(color_pair_matrix, w, m, m1) == False):
                    wPartner[w] = m
                    mFree[m] = True
                    mFree[m1] = False
            i += 1
 
            # End of Else
        # End of the for loop that goes
        # to all women in m's list
    # End of main while loop
 
    return wPartner
        
def color_similarity_score(img1_pairs, color_pair_matrix, img_per_1, img_per_2):
    score = 0
    for i, m in enumerate(img1_pairs):
        score += color_pair_matrix[i, m] * img_per_1[i] * img_per_2[m]
    return score


def find_similiarity_score(colors1, perc1, colors2, perc2):
    color_pair_matrix = create_score_matrix(colors1, colors2)
    img1_pairs = find_color_pairs(color_pair_matrix)
    score = color_similarity_score(img1_pairs, color_pair_matrix, perc1, perc2)  
    return score