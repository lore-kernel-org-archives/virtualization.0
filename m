From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 1/8] vsock/virtio: limit the memory used per-socket
Date: Fri, 17 May 2019 10:25:05 +0200
Message-ID: <20190517082505.ibjkuh7zibumen77__9602.5323540502$1558081524$gmane$org@steredhat>
References: <20190510125843.95587-1-sgarzare@redhat.com>
	<20190510125843.95587-2-sgarzare@redhat.com>
	<20190516152533.GB29808@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190516152533.GB29808@stefanha-x1.localdomain>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 16, 2019 at 04:25:33PM +0100, Stefan Hajnoczi wrote:
> On Fri, May 10, 2019 at 02:58:36PM +0200, Stefano Garzarella wrote:
> > +struct virtio_vsock_buf {
> 
> Please add a comment describing the purpose of this struct and to
> differentiate its use from struct virtio_vsock_pkt.
> 

Sure, I'll fix it.

> > +static struct virtio_vsock_buf *
> > +virtio_transport_alloc_buf(struct virtio_vsock_pkt *pkt, bool zero_copy)
> > +{
> > +	struct virtio_vsock_buf *buf;
> > +
> > +	if (pkt->len == 0)
> > +		return NULL;
> > +
> > +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> > +	if (!buf)
> > +		return NULL;
> > +
> > +	/* If the buffer in the virtio_vsock_pkt is full, we can move it to
> > +	 * the new virtio_vsock_buf avoiding the copy, because we are sure that
> > +	 * we are not use more memory than that counted by the credit mechanism.
> > +	 */
> > +	if (zero_copy && pkt->len == pkt->buf_len) {
> > +		buf->addr = pkt->buf;
> > +		pkt->buf = NULL;
> > +	} else {
> > +		buf->addr = kmalloc(pkt->len, GFP_KERNEL);
> 
> buf and buf->addr could be allocated in a single call, though I'm not
> sure how big an optimization this is.
> 

IIUC, in the case of zero-copy I should allocate only the buf,
otherwise I should allocate both buf and buf->addr in a single call
when I'm doing a full-copy.

Is it correct?

> > @@ -841,20 +882,24 @@ virtio_transport_recv_connected(struct sock *sk,
> >  {
> >  	struct vsock_sock *vsk = vsock_sk(sk);
> >  	struct virtio_vsock_sock *vvs = vsk->trans;
> > +	struct virtio_vsock_buf *buf;
> >  	int err = 0;
> >  
> >  	switch (le16_to_cpu(pkt->hdr.op)) {
> >  	case VIRTIO_VSOCK_OP_RW:
> >  		pkt->len = le32_to_cpu(pkt->hdr.len);
> > -		pkt->off = 0;
> > +		buf = virtio_transport_alloc_buf(pkt, true);
> >  
> > -		spin_lock_bh(&vvs->rx_lock);
> > -		virtio_transport_inc_rx_pkt(vvs, pkt);
> > -		list_add_tail(&pkt->list, &vvs->rx_queue);
> > -		spin_unlock_bh(&vvs->rx_lock);
> > +		if (buf) {
> > +			spin_lock_bh(&vvs->rx_lock);
> > +			virtio_transport_inc_rx_pkt(vvs, pkt->len);
> > +			list_add_tail(&buf->list, &vvs->rx_queue);
> > +			spin_unlock_bh(&vvs->rx_lock);
> >  
> > -		sk->sk_data_ready(sk);
> > -		return err;
> > +			sk->sk_data_ready(sk);
> > +		}
> 
> The return value of this function isn't used but the code still makes an
> effort to return errors.  Please return -ENOMEM when buf == NULL.
> 
> If you'd like to remove the return value that's fine too, but please do
> it for the whole function to be consistent.

I'll return -ENOMEM when the allocation fails.

Thanks,
Stefano
