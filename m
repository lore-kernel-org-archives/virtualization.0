From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 2/4] vhost/vsock: split packets to send using
	multiple buffers
Date: Fri, 5 Apr 2019 11:36:08 +0200
Message-ID: <20190405093608.f2zsyxnjxcba5v6r__14338.673201722$1555717951$gmane$org@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-3-sgarzare@redhat.com>
	<20190405081356.GC25152@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190405081356.GC25152@stefanha-x1.localdomain>
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

On Fri, Apr 05, 2019 at 09:13:56AM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 04, 2019 at 12:58:36PM +0200, Stefano Garzarella wrote:
> > @@ -139,8 +139,18 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> >  			break;
> >  		}
> >  
> > -		len = iov_length(&vq->iov[out], in);
> > -		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, len);
> > +		payload_len = pkt->len - pkt->off;
> > +		iov_len = iov_length(&vq->iov[out], in);
> > +		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, iov_len);
> > +
> > +		/* If the packet is greater than the space available in the
> > +		 * buffer, we split it using multiple buffers.
> > +		 */
> > +		if (payload_len > iov_len - sizeof(pkt->hdr))
> 
> Integer underflow.  iov_len is controlled by the guest and therefore
> untrusted.  Please validate iov_len before assuming it's larger than
> sizeof(pkt->hdr).
> 

Okay, I'll do it!

> > -		vhost_add_used(vq, head, sizeof(pkt->hdr) + pkt->len);
> > +		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
> >  		added = true;
> >  
> > +		pkt->off += payload_len;
> > +
> > +		/* If we didn't send all the payload we can requeue the packet
> > +		 * to send it with the next available buffer.
> > +		 */
> > +		if (pkt->off < pkt->len) {
> > +			spin_lock_bh(&vsock->send_pkt_list_lock);
> > +			list_add(&pkt->list, &vsock->send_pkt_list);
> > +			spin_unlock_bh(&vsock->send_pkt_list_lock);
> > +			continue;
> 
> The virtio_transport_deliver_tap_pkt() call is skipped.  Packet capture
> should see the exact packets that are delivered.  I think this patch
> will present one large packet instead of several smaller packets that
> were actually delivered.

I'll modify virtio_transport_build_skb() to take care of pkt->off
and reading the payload size from the virtio_vsock_hdr.
Otherwise, should I introduce another field in virtio_vsock_pkt to store
the payload size?

Thanks,
Stefano
