From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Change typecasts in vring_init()
Date: Fri, 30 Aug 2019 10:02:32 -0400
Message-ID: <20190830095928-mutt-send-email-mst__23882.6452916086$1567173883$gmane$org@kernel.org>
References: <20190827152000.53920-1-matej.genci@nutanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190827152000.53920-1-matej.genci@nutanix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matej Genci <matej.genci@nutanix.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 27, 2019 at 03:20:57PM +0000, Matej Genci wrote:
> Compilers such as g++ 7.3 complain about assigning void* variable to
> a non-void* variable (like struct pointers) and pointer arithmetics
> on void*.
> 
> Signed-off-by: Matej Genci <matej.genci@nutanix.com>
> ---
>  include/uapi/linux/virtio_ring.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 4c4e24c291a5..2c339b9e2923 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -168,10 +168,11 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>  			      unsigned long align)
>  {
>  	vr->num = num;
> -	vr->desc = p;
> -	vr->avail = p + num*sizeof(struct vring_desc);
> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> -		+ align-1) & ~(align - 1));
> +	vr->desc = (struct vring_desc *)p;
> +	vr->avail = (struct vring_avail *)((uintptr_t)p
> +		+ num*sizeof(struct vring_desc));
> +	vr->used = (struct vring_used *)(((uintptr_t)&vr->avail->ring[num]
> +		+ sizeof(__virtio16) + align-1) & ~(align - 1));
>  }
>  
>  static inline unsigned vring_size(unsigned int num, unsigned long align)

I'm not really interested in building with g++, sorry.
Centainly not if it makes code less robust by forcing
casts where they weren't previously necessary.

However, vring_init and vring_size are legacy APIs anyway,
so I'd be happy to add ifndefs that will allow userspace
simply hide these functions if it does not need them.


> -- 
> 2.22.0
> 
