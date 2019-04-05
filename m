From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
	throughput
Date: Fri, 5 Apr 2019 09:49:17 +0200
Message-ID: <20190405074917.ooftpalmploq6x3b__32026.3661955082$1555717930$gmane$org@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404114643-mutt-send-email-mst@kernel.org>
	<20190404164715.sycigtccwq2rziuz@steredhat>
	<20190404140345-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190404140345-mutt-send-email-mst@kernel.org>
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

On Thu, Apr 04, 2019 at 02:04:10PM -0400, Michael S. Tsirkin wrote:
> On Thu, Apr 04, 2019 at 06:47:15PM +0200, Stefano Garzarella wrote:
> > On Thu, Apr 04, 2019 at 11:52:46AM -0400, Michael S. Tsirkin wrote:
> > > I simply love it that you have analysed the individual impact of
> > > each patch! Great job!
> > 
> > Thanks! I followed Stefan's suggestions!
> > 
> > > 
> > > For comparison's sake, it could be IMHO benefitial to add a column
> > > with virtio-net+vhost-net performance.
> > > 
> > > This will both give us an idea about whether the vsock layer introduces
> > > inefficiencies, and whether the virtio-net idea has merit.
> > > 
> > 
> > Sure, I already did TCP tests on virtio-net + vhost, starting qemu in
> > this way:
> >   $ qemu-system-x86_64 ... \
> >       -netdev tap,id=net0,vhost=on,ifname=tap0,script=no,downscript=no \
> >       -device virtio-net-pci,netdev=net0
> > 
> > I did also a test using TCP_NODELAY, just to be fair, because VSOCK
> > doesn't implement something like this.
> 
> Why not?
> 

I think because originally VSOCK was designed to be simple and
low-latency, but of course we can introduce something like that.

Current implementation directly copy the buffer from the user-space in a
virtio_vsock_pkt and enqueue it to be transmitted.

Maybe we can introduce a buffer per socket where accumulate bytes and
send it when it is full or when a timer is fired . We can also introduce
a VSOCK_NODELAY (maybe using the same value of TCP_NODELAY for
compatibility) to send the buffer immediately for low-latency use cases.

What do you think?

Thanks,
Stefano
