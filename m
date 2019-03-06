From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [PATCH] vsock/virtio: fix kernel panic from
	virtio_transport_reset_no_sock
Date: Wed, 06 Mar 2019 10:53:32 +0200
Message-ID: <46463.0110118137$1555717253@news.gmane.org>
References: <20190305180145.27161-1-alazar@bitdefender.com>
	<20190306081236.mcd4o27yw67euzgv@steredhat.homenet.telecomitalia.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190306081236.mcd4o27yw67euzgv@steredhat.homenet.telecomitalia.it>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 6 Mar 2019 09:12:36 +0100, Stefano Garzarella <sgarzare@redhat.com> wrote:
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -662,6 +662,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> >   */
> >  static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
> >  {
> > +	const struct virtio_transport *t;
> >  	struct virtio_vsock_pkt_info info = {
> >  		.op = VIRTIO_VSOCK_OP_RST,
> >  		.type = le16_to_cpu(pkt->hdr.type),
> > @@ -680,7 +681,11 @@ static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
> >  	if (!pkt)
> >  		return -ENOMEM;
> >  
> > -	return virtio_transport_get_ops()->send_pkt(pkt);
> > +	t = virtio_transport_get_ops();
> > +	if (!t)
> > +		return -ENOTCONN;
> 
> Should be better to do this check before the virtio_transport_alloc_pkt?
> 
> Otherwise, I think we should free that packet before to return -ENOTCONN.

Right! :D
I will send a second version.
