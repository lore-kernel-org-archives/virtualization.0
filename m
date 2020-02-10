From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH] virtio: Work around frames incorrectly marked as gso
Date: Mon, 10 Feb 2020 16:55:44 +0000
Message-ID: <57230228-7030-c65f-a24f-910ca52bbe9e@cambridgegreys.com>
References: <20191209104824.17059-1-anton.ivanov@cambridgegreys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191209104824.17059-1-anton.ivanov@cambridgegreys.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-um@lists.infradead.org, jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 09/12/2019 10:48, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Some of the frames marked as GSO which arrive at
> virtio_net_hdr_from_skb() have no GSO_TYPE, no
> fragments (data_len = 0) and length significantly shorter
> than the MTU (752 in my experiments).
> 
> This is observed on raw sockets reading off vEth interfaces
> in all 4.x and 5.x kernels I tested.
> 
> These frames are reported as invalid while they are in fact
> gso-less frames.
> 
> This patch marks the vnet header as no-GSO for them instead
> of reporting it as invalid.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   include/linux/virtio_net.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 0d1fe9297ac6..d90d5cff1b9a 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -112,8 +112,12 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>   			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
>   		else if (sinfo->gso_type & SKB_GSO_TCPV6)
>   			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> -		else
> -			return -EINVAL;
> +		else {
> +			if (skb->data_len == 0)
> +				hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
> +			else
> +				return -EINVAL;
> +		}
>   		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>   			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
>   	} else
> 

ping.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
