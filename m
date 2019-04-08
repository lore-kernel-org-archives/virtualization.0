From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
	allowed
Date: Mon, 8 Apr 2019 16:55:31 +0200
Message-ID: <20190408145531.yreyawkn5vjqj7sl__12140.4828548961$1555717976$gmane$org@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-4-sgarzare@redhat.com>
	<20190405082447.GD25152@stefanha-x1.localdomain>
	<20190405100747.dbwi3sjaudp3d2wa@steredhat>
	<20190408093723.GP15001@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190408093723.GP15001@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 08, 2019 at 10:37:23AM +0100, Stefan Hajnoczi wrote:
> On Fri, Apr 05, 2019 at 12:07:47PM +0200, Stefano Garzarella wrote:
> > On Fri, Apr 05, 2019 at 09:24:47AM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Apr 04, 2019 at 12:58:37PM +0200, Stefano Garzarella wrote:
> > > > Since now we are able to split packets, we can avoid limiting
> > > > their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> > > > Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> > > > packet size.
> > > > 
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > >  net/vmw_vsock/virtio_transport_common.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > index f32301d823f5..822e5d07a4ec 100644
> > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > @@ -167,8 +167,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > >  	vvs = vsk->trans;
> > > >  
> > > >  	/* we can send less than pkt_len bytes */
> > > > -	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
> > > > -		pkt_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> > > > +	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> > > > +		pkt_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> > > 
> > > The next line limits pkt_len based on available credits:
> > > 
> > >   /* virtio_transport_get_credit might return less than pkt_len credit */
> > >   pkt_len = virtio_transport_get_credit(vvs, pkt_len);
> > > 
> > > I think drivers/vhost/vsock.c:vhost_transport_do_send_pkt() now works
> > > correctly even with pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
> > 
> > Correct.
> > 
> > > 
> > > The other ->send_pkt() callback is
> > > net/vmw_vsock/virtio_transport.c:virtio_transport_send_pkt_work() and it
> > > can already send any size packet.
> > > 
> > > Do you remember why VIRTIO_VSOCK_MAX_PKT_BUF_SIZE still needs to be the
> > > limit?  I'm wondering if we can get rid of it now and just limit packets
> > > to the available credits.
> > 
> > There are 2 reasons why I left this limit:
> > 1. When the host receives a packets, it must be <=
> >    VIRTIO_VSOCK_MAX_PKT_BUF_SIZE [drivers/vhost/vsock.c:vhost_vsock_alloc_pkt()]
> >    So in this way we can limit the packets sent from the guest.
> 
> The general intent is to prevent the guest from sending huge buffers.
> This is good.
> 
> However, the guest must already obey the credit limit advertized by the
> host.  Therefore I think we should be checking against that instead of
> an arbitrary constant limit.
> 
> So I think the limit should be the receive buffer size, not
> VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.  But at this point the code doesn't know
> which connection the packet is associated with and cannot check the
> receive buffer size. :(
> 
> Anyway, any change to this behavior requires compatibility so new guest
> drivers work with old vhost_vsock.ko.  Therefore we should probably just
> leave the limit for now.

I understood your point of view and I completely agree with you.
But, until we don't have a way to expose features/versions between guest
and host, maybe is better to leave the limit in order to be compatible
with old vhost_vsock.

> 
> > 2. When the host send packets, it help us to increase the parallelism
> >    (especially if the guest has 64 KB RX buffers) because the user thread
> >    will split packets, calling multiple times transport->stream_enqueue()
> >    in net/vmw_vsock/af_vsock.c:vsock_stream_sendmsg() while the
> >    vhost_transport_send_pkt_work() send them to the guest.
> 
> Sorry, I don't understand the reasoning.  Overall this creates more
> work.  Are you saying the benefit is that
> vhost_transport_send_pkt_work() can run "early" and notify the guest of
> partial rx data before all of it has been enqueued?

Something like that. Your reasoning is more accurate.
Anyway, I'll do some tests in order to understand better the behaviour!

Thanks,
Stefano
