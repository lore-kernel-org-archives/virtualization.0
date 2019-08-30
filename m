From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Date: Fri, 30 Aug 2019 11:40:59 +0200
Message-ID: <20190830094059.c7qo5cxrp2nkrncd__17976.2745088496$1567158193$gmane$org@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-2-sgarzare@redhat.com>
	<20190729095956-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190729095956-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 29, 2019 at 10:04:29AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 17, 2019 at 01:30:26PM +0200, Stefano Garzarella wrote:
> > Since virtio-vsock was introduced, the buffers filled by the host
> > and pushed to the guest using the vring, are directly queued in
> > a per-socket list. These buffers are preallocated by the guest
> > with a fixed size (4 KB).
> > 
> > The maximum amount of memory used by each socket should be
> > controlled by the credit mechanism.
> > The default credit available per-socket is 256 KB, but if we use
> > only 1 byte per packet, the guest can queue up to 262144 of 4 KB
> > buffers, using up to 1 GB of memory per-socket. In addition, the
> > guest will continue to fill the vring with new 4 KB free buffers
> > to avoid starvation of other sockets.
> > 
> > This patch mitigates this issue copying the payload of small
> > packets (< 128 bytes) into the buffer of last packet queued, in
> > order to avoid wasting memory.
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> This is good enough for net-next, but for net I think we
> should figure out how to address the issue completely.
> Can we make the accounting precise? What happens to
> performance if we do?
> 

Since I'm back from holidays, I'm restarting this thread to figure out
how to address the issue completely.

I did a better analysis of the credit mechanism that we implemented in
virtio-vsock to get a clearer view and I'd share it with you:

    This issue affect only the "host->guest" path. In this case, when the
    host wants to send a packet to the guest, it uses a "free" buffer
    allocated by the guest (4KB).
    The "free" buffers available for the host are shared between all
    sockets, instead, the credit mechanism is per-socket, I think to
    avoid the starvation of others sockets.
    The guests re-fill the "free" queue when the available buffers are
    less than half.

    Each peer have these variables in the per-socket state:
       /* local vars */
       buf_alloc        /* max bytes usable by this socket
                           [exposed to the other peer] */
       fwd_cnt          /* increased when RX packet is consumed by the
                           user space [exposed to the other peer] */
       tx_cnt 	        /* increased when TX packet is sent to the other peer */

       /* remote vars  */
       peer_buf_alloc   /* peer's buf_alloc */
       peer_fwd_cnt     /* peer's fwd_cnt */

    When a peer sends a packet, it increases the 'tx_cnt'; when the
    receiver consumes the packet (copy it to the user-space buffer), it
    increases the 'fwd_cnt'.
    Note: increments are made considering the payload length and not the
    buffer length.

    The value of 'buf_alloc' and 'fwd_cnt' are sent to the other peer in
    all packet headers or with an explicit CREDIT_UPDATE packet.

    The local 'buf_alloc' value can be modified by the user space using
    setsockopt() with optname=SO_VM_SOCKETS_BUFFER_SIZE.

    Before to send a packet, the peer checks the space available:
    	credit_available = peer_buf_alloc - (tx_cnt - peer_fwd_cnt)
    and it will send up to credit_available bytes to the other peer.

Possible solutions considering Michael's advice:
1. Use the buffer length instead of the payload length when we increment
   the counters:
  - This approach will account precisely the memory used per socket.
  - This requires changes in both guest and host.
  - It is not compatible with old drivers, so a feature should be negotiated.

2. Decrease the advertised 'buf_alloc' taking count of bytes queued in
   the socket queue but not used. (e.g. 256 byte used on 4K available in
   the buffer)
  - pkt->hdr.buf_alloc = buf_alloc - bytes_not_used.
  - This should be compatible also with old drivers.

Maybe the second is less invasive, but will it be too tricky?
Any other advice or suggestions?

Thanks in advance,
Stefano
