From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 1/4] vsock/virtio: reduce credit update messages
Date: Fri, 5 Apr 2019 10:16:48 +0200
Message-ID: <20190405081648.2zflr7gxknk4q3a2__47078.1653116987$1555717940$gmane$org@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-2-sgarzare@redhat.com>
	<20190404191539.GB25152@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190404191539.GB25152@stefanha-x1.localdomain>
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

On Thu, Apr 04, 2019 at 08:15:39PM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 04, 2019 at 12:58:35PM +0200, Stefano Garzarella wrote:
> > @@ -256,6 +257,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >  	struct virtio_vsock_sock *vvs = vsk->trans;
> >  	struct virtio_vsock_pkt *pkt;
> >  	size_t bytes, total = 0;
> > +	s64 free_space;
> 
> Why s64?  buf_alloc, fwd_cnt, and last_fwd_cnt are all u32.  fwd_cnt -
> last_fwd_cnt <= buf_alloc is always true.
> 

Right, I'll use a u32 for free_space!
Is is a leftover because initially I implemented something like
virtio_transport_has_space().

> >  	int err = -EFAULT;
> >  
> >  	spin_lock_bh(&vvs->rx_lock);
> > @@ -288,9 +290,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >  	}
> >  	spin_unlock_bh(&vvs->rx_lock);
> >  
> > -	/* Send a credit pkt to peer */
> > -	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
> > -					    NULL);
> > +	/* We send a credit update only when the space available seen
> > +	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> > +	 */
> > +	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> 
> Locking?  These fields should be accessed under tx_lock.
> 

Yes, we need a lock, but looking in the code, vvs->fwd_cnd is written
taking rx_lock (virtio_transport_dec_rx_pkt) and it is read with the
tx_lock (virtio_transport_inc_tx_pkt).

Maybe we should use another spin_lock shared between RX and TX for those
fields or use atomic variables.

What do you suggest?

Thanks,
Stefano
