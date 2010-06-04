From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 1/2] virtio: support layout with avail ring before idx
Date: Fri, 4 Jun 2010 13:35:43 +0300
Message-ID: <20100604103543.GA22270__21144.5025670857$1275648047$gmane$org@redhat.com>
References: <cover.1275403477.git.mst@redhat.com>
	<10a74b58c908bad64ff890c881e2b2de88687f0e.1275403477.git.mst@redhat.com>
	<201006041204.57973.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006041204.57973.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: qemu-devel@nongnu.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 04, 2010 at 12:04:57PM +0930, Rusty Russell wrote:
> On Wed, 2 Jun 2010 12:17:12 am Michael S. Tsirkin wrote:
> > This adds an (unused) option to put available ring before control (avail
> > index, flags), and adds padding between index and flags. This avoids
> > cache line sharing between control and ring, and also makes it possible
> > to extend avail control without incurring extra cache misses.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> No no no no.  254?  You're trying to Morton me![1]

Hmm, I wonder what will we do if we want a 3rd field on
a separate chacheline. But ok.

> How's this (untested):

I think we also want to put flags there as well,
they are used on interrupt path, together with last used index.

> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -74,8 +74,8 @@ struct vring {
>  /* The standard layout for the ring is a continuous chunk of memory which looks
>   * like this.  We assume num is a power of 2.
>   *
> - * struct vring
> - * {
> + * struct vring {
> + *	*** The driver writes to this part.
>   *	// The actual descriptors (16 bytes each)
>   *	struct vring_desc desc[num];
>   *
> @@ -84,9 +84,11 @@ struct vring {
>   *	__u16 avail_idx;
>   *	__u16 available[num];
>   *
> - *	// Padding to the next align boundary.
> + *	// Padding so used_flags is on the next align boundary.
>   *	char pad[];
> + *	__u16 last_used; // On a cacheline of its own.
>   *
> + *	*** The device writes to this part.
>   *	// A ring of used descriptor heads with free-running index.
>   *	__u16 used_flags;
>   *	__u16 used_idx;
> @@ -110,6 +112,12 @@ static inline unsigned vring_size(unsign
>  		+ sizeof(__u16) * 2 + sizeof(struct vring_used_elem) * num;
>  }
>  
> +/* Last used index sits at the very end of the driver part of the struct */
> +static inline __u16 *vring_last_used_idx(const struct vring *vr)
> +{
> +	return (__u16 *)vr->used - 1;
> +}
> +
>  #ifdef __KERNEL__
>  #include <linux/irqreturn.h>
>  struct virtio_device;
> 
> Cheers,
> Rusty.
> [1] Andrew Morton has this technique where he posts a solution so ugly it
>     forces others to fix it properly.  Ego-roping, basically.
