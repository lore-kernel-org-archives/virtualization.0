From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio: add VIRTIO_RING_NO_LEGACY
Date: Wed, 11 Sep 2019 05:31:25 -0400
Message-ID: <20190911053030-mutt-send-email-mst@kernel.org>
References: <20190910175335.231660-1-matej.genci@nutanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190910175335.231660-1-matej.genci@nutanix.com>
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

On Tue, Sep 10, 2019 at 05:53:44PM +0000, Matej Genci wrote:
> Add macro to disable legacy functions vring_init and vring_size.
> 
> Signed-off-by: Matej Genci <matej.genci@nutanix.com>

And I guess we should be able to define this macro in
drivers/virtio/virtio_pci_modern.c
?

Will be handy to make sure we don't mask too much.

> ---
> 
> V2: Put all legacy APIs inside guards.
> 
> ---
>  include/uapi/linux/virtio_ring.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 4c4e24c291a5..efe5a421b4ea 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -118,6 +118,8 @@ struct vring_used {
>  	struct vring_used_elem ring[];
>  };
>  
> +#ifndef VIRTIO_RING_NO_LEGACY
> +
>  struct vring {
>  	unsigned int num;
>  
> @@ -128,6 +130,8 @@ struct vring {
>  	struct vring_used *used;
>  };
>  
> +#endif /* VIRTIO_RING_NO_LEGACY */
> +
>  /* Alignment requirements for vring elements.
>   * When using pre-virtio 1.0 layout, these fall out naturally.
>   */
> @@ -135,6 +139,8 @@ struct vring {
>  #define VRING_USED_ALIGN_SIZE 4
>  #define VRING_DESC_ALIGN_SIZE 16
>  
> +#ifndef VIRTIO_RING_NO_LEGACY
> +
>  /* The standard layout for the ring is a continuous chunk of memory which looks
>   * like this.  We assume num is a power of 2.
>   *
> @@ -195,6 +201,8 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
>  	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
>  }
>  
> +#endif /* VIRTIO_RING_NO_LEGACY */
> +
>  struct vring_packed_desc_event {
>  	/* Descriptor Ring Change Event Offset/Wrap Counter. */
>  	__le16 off_wrap;
> -- 
> 2.22.0
> 
