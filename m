From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Date: Thu, 1 Aug 2019 12:47:54 +0200
Message-ID: <20190801104754.lb3ju5xjfmnxioii__41020.7893861056$1564657188$gmane$org@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-2-sgarzare@redhat.com>
	<20190729095956-mutt-send-email-mst@kernel.org>
	<20190729153656.zk4q4rob5oi6iq7l@steredhat>
	<20190729114302-mutt-send-email-mst@kernel.org>
	<20190729161903.yhaj5rfcvleexkhc@steredhat>
	<20190729165056.r32uzj6om3o6vfvp@steredhat>
	<20190729143622-mutt-send-email-mst@kernel.org>
	<20190730093539.dcksure3vrykir3g@steredhat>
	<20190730163807-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190730163807-mutt-send-email-mst@kernel.org>
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

On Tue, Jul 30, 2019 at 04:42:25PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 30, 2019 at 11:35:39AM +0200, Stefano Garzarella wrote:

(...)

> > 
> > The problem here is the compatibility. Before this series virtio-vsock
> > and vhost-vsock modules had the RX buffer size hard-coded
> > (VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE = 4K). So, if we send a buffer smaller
> > of 4K, there might be issues.
> 
> Shouldn't be if they are following the spec. If not let's fix
> the broken parts.
> 
> > 
> > Maybe it is the time to add add 'features' to virtio-vsock device.
> > 
> > Thanks,
> > Stefano
> 
> Why would a remote care about buffer sizes?
> 
> Let's first see what the issues are. If they exist
> we can either fix the bugs, or code the bug as a feature in spec.
> 

The vhost_transport '.stream_enqueue' callback
[virtio_transport_stream_enqueue()] calls the virtio_transport_send_pkt_info(),
passing the user message. This function allocates a new packet, copying
the user message, but (before this series) it limits the packet size to
the VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE (4K):

static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
					  struct virtio_vsock_pkt_info *info)
{
 ...
	/* we can send less than pkt_len bytes */
	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
		pkt_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;

	/* virtio_transport_get_credit might return less than pkt_len credit */
	pkt_len = virtio_transport_get_credit(vvs, pkt_len);

	/* Do not send zero length OP_RW pkt */
	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
		return pkt_len;
 ...
}

then it queues the packet for the TX worker calling .send_pkt()
[vhost_transport_send_pkt() in the vhost_transport case]

The main function executed by the TX worker is
vhost_transport_do_send_pkt() that picks up a buffer from the virtqueue
and it tries to copy the packet (up to 4K) on it.  If the buffer
allocated from the guest will be smaller then 4K, I think here it will
be discarded with an error:

static void
vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
				struct vhost_virtqueue *vq)
{
 ...
		nbytes = copy_to_iter(pkt->buf, pkt->len, &iov_iter);
		if (nbytes != pkt->len) {
			virtio_transport_free_pkt(pkt);
			vq_err(vq, "Faulted on copying pkt buf\n");
			break;
		}
 ...
}


This series changes this behavior since now we will split the packet in
vhost_transport_do_send_pkt() depending on the buffer found in the
virtqueue.

We didn't change the buffer size in this series, so we still backward
compatible, but if we will use buffers smaller than 4K, we should
encounter the error described above.

How do you suggest we proceed if we want to change the buffer size?
Maybe adding a feature to "support any buffer size"?

Thanks,
Stefano
