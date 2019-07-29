From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Date: Mon, 29 Jul 2019 18:50:56 +0200
Message-ID: <20190729165056.r32uzj6om3o6vfvp__47727.6606646896$1564419240$gmane$org@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-2-sgarzare@redhat.com>
	<20190729095956-mutt-send-email-mst@kernel.org>
	<20190729153656.zk4q4rob5oi6iq7l@steredhat>
	<20190729114302-mutt-send-email-mst@kernel.org>
	<20190729161903.yhaj5rfcvleexkhc@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190729161903.yhaj5rfcvleexkhc@steredhat>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 29, 2019 at 06:19:03PM +0200, Stefano Garzarella wrote:
> On Mon, Jul 29, 2019 at 11:49:02AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 29, 2019 at 05:36:56PM +0200, Stefano Garzarella wrote:
> > > On Mon, Jul 29, 2019 at 10:04:29AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Jul 17, 2019 at 01:30:26PM +0200, Stefano Garzarella wrote:
> > > > > Since virtio-vsock was introduced, the buffers filled by the host
> > > > > and pushed to the guest using the vring, are directly queued in
> > > > > a per-socket list. These buffers are preallocated by the guest
> > > > > with a fixed size (4 KB).
> > > > > 
> > > > > The maximum amount of memory used by each socket should be
> > > > > controlled by the credit mechanism.
> > > > > The default credit available per-socket is 256 KB, but if we use
> > > > > only 1 byte per packet, the guest can queue up to 262144 of 4 KB
> > > > > buffers, using up to 1 GB of memory per-socket. In addition, the
> > > > > guest will continue to fill the vring with new 4 KB free buffers
> > > > > to avoid starvation of other sockets.
> > > > > 
> > > > > This patch mitigates this issue copying the payload of small
> > > > > packets (< 128 bytes) into the buffer of last packet queued, in
> > > > > order to avoid wasting memory.
> > > > > 
> > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > 
> > > > This is good enough for net-next, but for net I think we
> > > > should figure out how to address the issue completely.
> > > > Can we make the accounting precise? What happens to
> > > > performance if we do?
> > > > 
> > > 
> > > In order to do more precise accounting maybe we can use the buffer size,
> > > instead of payload size when we update the credit available.
> > > In this way, the credit available for each socket will reflect the memory
> > > actually used.
> > > 
> > > I should check better, because I'm not sure what happen if the peer sees
> > > 1KB of space available, then it sends 1KB of payload (using a 4KB
> > > buffer).
> > > 
> > > The other option is to copy each packet in a new buffer like I did in
> > > the v2 [2], but this forces us to make a copy for each packet that does
> > > not fill the entire buffer, perhaps too expensive.
> > > 
> > > [2] https://patchwork.kernel.org/patch/10938741/
> > > 
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Interesting. You are right, and at some level the protocol forces copies.
> > 
> > We could try to detect that the actual memory is getting close to
> > admin limits and force copies on queued packets after the fact.
> > Is that practical?
> 
> Yes, I think it is doable!
> We can decrease the credit available with the buffer size queued, and
> when the buffer size of packet to queue is bigger than the credit
> available, we can copy it.
> 
> > 
> > And yes we can extend the credit accounting to include buffer size.
> > That's a protocol change but maybe it makes sense.
> 
> Since we send to the other peer the credit available, maybe this
> change can be backwards compatible (I'll check better this).

What I said was wrong.

We send a counter (increased when the user consumes the packets) and the
"buf_alloc" (the max memory allowed) to the other peer.
It makes a difference between a local counter (increased when the
packets are sent) and the remote counter to calculate the credit available:

    u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
    {
    	u32 ret;

    	spin_lock_bh(&vvs->tx_lock);
    	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
    	if (ret > credit)
    		ret = credit;
    	vvs->tx_cnt += ret;
    	spin_unlock_bh(&vvs->tx_lock);

    	return ret;
    }

Maybe I can play with "buf_alloc" to take care of bytes queued but not
used.

Thanks,
Stefano
