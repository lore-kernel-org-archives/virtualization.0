From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: fix typo in vring_need_event() doc comment
Date: Sun, 19 Apr 2015 14:36:38 +0930
Message-ID: <878udor9k1.fsf@rustcorp.com.au>
References: <1429101336-13100-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1429101336-13100-1-git-send-email-stefanha@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Stefan Hajnoczi <stefanha@redhat.com> writes:
> Here the "other side" refers to the guest or host.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Applied.

Thanks!
Rusty.

> ---
>  include/uapi/linux/virtio_ring.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index a3318f3..915980a 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -155,7 +155,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
>  }
>  
>  /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
> -/* Assuming a given event_idx value from the other size, if
> +/* Assuming a given event_idx value from the other side, if
>   * we have just incremented index from old to new_idx,
>   * should we trigger an event? */
>  static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
> -- 
> 2.1.0
