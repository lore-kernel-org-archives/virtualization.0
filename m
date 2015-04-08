From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: Update weak barriers to use dma_wmb/rmb
Date: Wed, 8 Apr 2015 10:42:55 +0200
Message-ID: <20150408093032-mutt-send-email-mst@redhat.com>
References: <20150408004742.2112.25484.stgit@ahduyck-vm-fedora22>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150408004742.2112.25484.stgit@ahduyck-vm-fedora22>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Duyck <alexander.h.duyck@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 07, 2015 at 05:47:42PM -0700, Alexander Duyck wrote:
> This change makes it so that instead of using smp_wmb/rmb which varies
> depending on the kernel configuration we can can use dma_wmb/rmb which for
> most architectures should be equal to or slightly more strict than
> smp_wmb/rmb.
> 
> The advantage to this is that these barriers are available to uniprocessor
> builds as well so the performance should improve under such a
> configuration.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>

Well the generic implementation has:
#ifndef dma_rmb
#define dma_rmb()       rmb()
#endif

#ifndef dma_wmb
#define dma_wmb()       wmb()
#endif

So for these arches you are slightly speeding up UP but slightly hurting SMP -
I think we did benchmark the difference as measureable in the past.

Additionally, isn't this relying on undocumented behaviour?
The documentation says:
	"These are for use with consistent memory"
and virtio does not bother to request consistent memory
allocations.

One wonders whether these will always be strong enough.



> ---
>  include/linux/virtio_ring.h |   23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 67e06fe18c03..8e50888a6d59 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -21,19 +21,20 @@
>   * actually quite cheap.
>   */
>  
> -#ifdef CONFIG_SMP
>  static inline void virtio_mb(bool weak_barriers)
>  {
> +#ifdef CONFIG_SMP
>  	if (weak_barriers)
>  		smp_mb();
>  	else
> +#endif
>  		mb();
>  }
>  
>  static inline void virtio_rmb(bool weak_barriers)
>  {
>  	if (weak_barriers)
> -		smp_rmb();
> +		dma_rmb();
>  	else
>  		rmb();
>  }
> @@ -41,26 +42,10 @@ static inline void virtio_rmb(bool weak_barriers)
>  static inline void virtio_wmb(bool weak_barriers)
>  {
>  	if (weak_barriers)
> -		smp_wmb();
> +		dma_wmb();
>  	else
>  		wmb();
>  }
> -#else
> -static inline void virtio_mb(bool weak_barriers)
> -{
> -	mb();
> -}
> -
> -static inline void virtio_rmb(bool weak_barriers)
> -{
> -	rmb();
> -}
> -
> -static inline void virtio_wmb(bool weak_barriers)
> -{
> -	wmb();
> -}
> -#endif
>  
>  struct virtio_device;
>  struct virtqueue;
