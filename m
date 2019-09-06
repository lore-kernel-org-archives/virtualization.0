From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: add VIRTIO_RING_NO_LEGACY
Date: Fri, 6 Sep 2019 10:06:36 -0400
Message-ID: <20190906100456-mutt-send-email-mst__27099.5333603182$1567778814$gmane$org@kernel.org>
References: <20190906124130.129870-1-matej.genci@nutanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190906124130.129870-1-matej.genci@nutanix.com>
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

On Fri, Sep 06, 2019 at 12:42:14PM +0000, Matej Genci wrote:
> Add macro to disable legacy functions vring_init and vring_size.
> 
> Signed-off-by: Matej Genci <matej.genci@nutanix.com>
> ---
>  include/uapi/linux/virtio_ring.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 4c4e24c291a5..496db2f33830 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -164,6 +164,8 @@ struct vring {
>  #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
>  #define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
>  
> +#ifndef VIRTIO_RING_NO_LEGACY
> +
>  static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>  			      unsigned long align)
>  {
> @@ -181,6 +183,8 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
>  		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
>  }
>  
> +#endif
> +
>  /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
>  /* Assuming a given event_idx value from the other side, if
>   * we have just incremented index from old to new_idx,

Thanks!
I am guessing vring_used_event/vring_avail_event should be within
this ifndef too? How about struct vring?


> -- 
> 2.22.0
> 
