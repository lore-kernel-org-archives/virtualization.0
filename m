From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Date: Mon, 29 Jul 2019 18:41:27 +0200
Message-ID: <CAGxU2F5F1KcaFNJ6n7++ApZiYMGnoEWKVRgo3Vc4h5hpxSJEZg__39569.3956919544$1564418646$gmane$org@mail.gmail.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-2-sgarzare@redhat.com>
	<20190729095956-mutt-send-email-mst@kernel.org>
	<20190729153656.zk4q4rob5oi6iq7l@steredhat>
	<20190729115904-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190729115904-mutt-send-email-mst@kernel.org>
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

On Mon, Jul 29, 2019 at 12:01:37PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 29, 2019 at 05:36:56PM +0200, Stefano Garzarella wrote:
> > On Mon, Jul 29, 2019 at 10:04:29AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 17, 2019 at 01:30:26PM +0200, Stefano Garzarella wrote:
> > > > Since virtio-vsock was introduced, the buffers filled by the host
> > > > and pushed to the guest using the vring, are directly queued in
> > > > a per-socket list. These buffers are preallocated by the guest
> > > > with a fixed size (4 KB).
> > > >
> > > > The maximum amount of memory used by each socket should be
> > > > controlled by the credit mechanism.
> > > > The default credit available per-socket is 256 KB, but if we use
> > > > only 1 byte per packet, the guest can queue up to 262144 of 4 KB
> > > > buffers, using up to 1 GB of memory per-socket. In addition, the
> > > > guest will continue to fill the vring with new 4 KB free buffers
> > > > to avoid starvation of other sockets.
> > > >
> > > > This patch mitigates this issue copying the payload of small
> > > > packets (< 128 bytes) into the buffer of last packet queued, in
> > > > order to avoid wasting memory.
> > > >
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > This is good enough for net-next, but for net I think we
> > > should figure out how to address the issue completely.
> > > Can we make the accounting precise? What happens to
> > > performance if we do?
> > >
> >
> > In order to do more precise accounting maybe we can use the buffer size,
> > instead of payload size when we update the credit available.
> > In this way, the credit available for each socket will reflect the memory
> > actually used.
> >
> > I should check better, because I'm not sure what happen if the peer sees
> > 1KB of space available, then it sends 1KB of payload (using a 4KB
> > buffer).
> > The other option is to copy each packet in a new buffer like I did in
> > the v2 [2], but this forces us to make a copy for each packet that does
> > not fill the entire buffer, perhaps too expensive.
> >
> > [2] https://patchwork.kernel.org/patch/10938741/
> >
>
> So one thing we can easily do is to under-report the
> available credit. E.g. if we copy up to 256bytes,
> then report just 256bytes for every buffer in the queue.
>

Ehm sorry, I got lost :(
Can you explain better?


Thanks,
Stefano
