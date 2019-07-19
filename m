From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 5/5] vsock/virtio: change the maximum packet size
	allowed
Date: Fri, 19 Jul 2019 10:29:54 +0200
Message-ID: <20190719082954.m2lw77adpp5dylxw__25728.8287671813$1563525029$gmane$org@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-6-sgarzare@redhat.com>
	<20190717105703-mutt-send-email-mst@kernel.org>
	<CAGxU2F5ybg1_8VhS=COMnxSKC4AcW4ZagYwNMi==d6-rNPgzsg@mail.gmail.com>
	<20190718083105-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190718083105-mutt-send-email-mst@kernel.org>
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

On Thu, Jul 18, 2019 at 08:33:40AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 18, 2019 at 09:52:41AM +0200, Stefano Garzarella wrote:
> > On Wed, Jul 17, 2019 at 5:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Jul 17, 2019 at 01:30:30PM +0200, Stefano Garzarella wrote:
> > > > Since now we are able to split packets, we can avoid limiting
> > > > their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> > > > Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> > > > packet size.
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > >
> > > OK so this is kind of like GSO where we are passing
> > > 64K packets to the vsock and then split at the
> > > low level.
> > 
> > Exactly, something like that in the Host->Guest path, instead in the
> > Guest->Host we use the entire 64K packet.
> > 
> > Thanks,
> > Stefano
> 
> btw two allocations for each packet isn't great. How about
> allocating the struct linearly with the data?

Are you referring to the kzalloc() to allocate the 'struct
virtio_vsock_pkt', followed by the kmalloc() to allocate the buffer?

Actually they don't look great, I will try to do a single allocation.

> And all buffers are same length for you - so you can actually
> do alloc_pages.

Yes, also Jason suggested it and we decided to postpone since we will
try to reuse the virtio-net where it comes for free.

> Allocating/freeing pages in a batch should also be considered.

For the allocation of guest rx buffers we do some kind of batching (we
refill the queue when it reaches the half), but only it this case :(

I'll try to do more alloc/free batching.

Thanks,
Stefano
