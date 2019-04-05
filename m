From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
	allowed
Date: Fri, 5 Apr 2019 12:07:47 +0200
Message-ID: <20190405100747.dbwi3sjaudp3d2wa__42135.7881555863$1555717965$gmane$org@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-4-sgarzare@redhat.com>
	<20190405082447.GD25152@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190405082447.GD25152@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 05, 2019 at 09:24:47AM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 04, 2019 at 12:58:37PM +0200, Stefano Garzarella wrote:
> > Since now we are able to split packets, we can avoid limiting
> > their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> > Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> > packet size.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index f32301d823f5..822e5d07a4ec 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -167,8 +167,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >  	vvs = vsk->trans;
> >  
> >  	/* we can send less than pkt_len bytes */
> > -	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
> > -		pkt_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> > +	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> > +		pkt_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> 
> The next line limits pkt_len based on available credits:
> 
>   /* virtio_transport_get_credit might return less than pkt_len credit */
>   pkt_len = virtio_transport_get_credit(vvs, pkt_len);
> 
> I think drivers/vhost/vsock.c:vhost_transport_do_send_pkt() now works
> correctly even with pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.

Correct.

> 
> The other ->send_pkt() callback is
> net/vmw_vsock/virtio_transport.c:virtio_transport_send_pkt_work() and it
> can already send any size packet.
> 
> Do you remember why VIRTIO_VSOCK_MAX_PKT_BUF_SIZE still needs to be the
> limit?  I'm wondering if we can get rid of it now and just limit packets
> to the available credits.

There are 2 reasons why I left this limit:
1. When the host receives a packets, it must be <=
   VIRTIO_VSOCK_MAX_PKT_BUF_SIZE [drivers/vhost/vsock.c:vhost_vsock_alloc_pkt()]
   So in this way we can limit the packets sent from the guest.

2. When the host send packets, it help us to increase the parallelism
   (especially if the guest has 64 KB RX buffers) because the user thread
   will split packets, calling multiple times transport->stream_enqueue()
   in net/vmw_vsock/af_vsock.c:vsock_stream_sendmsg() while the
   vhost_transport_send_pkt_work() send them to the guest.


Do you think make sense?

Thanks,
Stefano
