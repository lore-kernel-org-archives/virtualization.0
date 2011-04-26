From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio, ring: Use ALIGN macros in virtio_ring.h
Date: Tue, 26 Apr 2011 10:42:30 +0300
Message-ID: <20110426074230.GA10364__8230.1470371478$1303803817$gmane$org@redhat.com>
References: <1303791070-15196-1-git-send-email-namei.unix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1303791070-15196-1-git-send-email-namei.unix@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liu Yuan <namei.unix@gmail.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 26, 2011 at 12:11:10PM +0800, Liu Yuan wrote:
> From: Liu Yuan <tailai.ly@taobao.com>
> 
> 
> Signed-off-by: Liu Yuan <tailai.ly@taobao.com>

Issue is, these functions are exported to userspace,
which does not have these macros.

> ---
>  include/linux/virtio_ring.h |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index e4d144b..6299050 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -99,15 +99,13 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>  	vr->num = num;
>  	vr->desc = p;
>  	vr->avail = p + num*sizeof(struct vring_desc);
> -	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + align-1)
> -			    & ~(align - 1));
> +	vr->used = (void *)PTR_ALIGN(&vr->avail->ring[num], align);
>  }
>  
>  static inline unsigned vring_size(unsigned int num, unsigned long align)
>  {
> -	return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (2 + num)
> -		 + align - 1) & ~(align - 1))
> -		+ sizeof(__u16) * 2 + sizeof(struct vring_used_elem) * num;
> +	return ((sizeof(struct vring_desc) * num + ALIGN(sizeof(__u16) * (2 + num), align))
> +		+ sizeof(__u16) * 2 + sizeof(struct vring_used_elem) * num);
>  }
>  
>  #ifdef __KERNEL__
> -- 
> 1.7.1
