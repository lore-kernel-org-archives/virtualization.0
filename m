From: Gleb Natapov <gleb@cloudius-systems.com>
Subject: Re: vhost + multiqueue + RSS question.
Date: Mon, 17 Nov 2014 14:22:14 +0200
Message-ID: <20141117122214.GK7589__34157.0770288401$1416325606$gmane$org@cloudius-systems.com>
References: <20141116161818.GD7589@cloudius-systems.com>
	<20141116185604.GA12839@redhat.com>
	<20141117074423.GG7589@cloudius-systems.com>
	<20141117103816.GA20638@redhat.com>
	<20141117112207.GJ7589@cloudius-systems.com>
	<20141117115820.GA10709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141117115820.GA10709@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 17, 2014 at 01:58:20PM +0200, Michael S. Tsirkin wrote:
> On Mon, Nov 17, 2014 at 01:22:07PM +0200, Gleb Natapov wrote:
> > On Mon, Nov 17, 2014 at 12:38:16PM +0200, Michael S. Tsirkin wrote:
> > > On Mon, Nov 17, 2014 at 09:44:23AM +0200, Gleb Natapov wrote:
> > > > On Sun, Nov 16, 2014 at 08:56:04PM +0200, Michael S. Tsirkin wrote:
> > > > > On Sun, Nov 16, 2014 at 06:18:18PM +0200, Gleb Natapov wrote:
> > > > > > Hi Michael,
> > > > > > 
> > > > > >  I am playing with vhost multiqueue capability and have a question about
> > > > > > vhost multiqueue and RSS (receive side steering). My setup has Mellanox
> > > > > > ConnectX-3 NIC which supports multiqueue and RSS. Network related
> > > > > > parameters for qemu are:
> > > > > > 
> > > > > >    -netdev tap,id=hn0,script=qemu-ifup.sh,vhost=on,queues=4
> > > > > >    -device virtio-net-pci,netdev=hn0,id=nic1,mq=on,vectors=10
> > > > > > 
> > > > > > In a guest I ran "ethtool -L eth0 combined 4" to enable multiqueue.
> > > > > > 
> > > > > > I am running one tcp stream into the guest using iperf. Since there is
> > > > > > only one tcp stream I expect it to be handled by one queue only but
> > > > > > this seams to be not the case. ethtool -S on a host shows that the
> > > > > > stream is handled by one queue in the NIC, just like I would expect,
> > > > > > but in a guest all 4 virtio-input interrupt are incremented. Am I
> > > > > > missing any configuration?
> > > > > 
> > > > > I don't see anything obviously wrong with what you describe.
> > > > > Maybe, somehow, same irqfd got bound to multiple MSI vectors?
> > > > It does not look like this is what is happening judging by the way
> > > > interrupts are distributed between queues. They are not distributed
> > > > uniformly and often I see one queue gets most interrupt and others get
> > > > much less and then it changes.
> > > 
> > > Weird. It would happen if you transmitted from multiple CPUs.
> > > You did pin iperf to a single CPU within guest, did you not?
> > > 
> > No, I didn't because I didn't expect it to matter for input interrupts.
> > When I run iperf on a host rx queue that receives all packets depends
> > only on a connection itself, not on a cpu iperf is running on (I tested
> > that).
> 
> This really depends on the type of networking card you have
> on the host, and how it's configured.
> 
> I think you will get something more closely resembling this
> behaviour if you enable RFS in host.
> 
> > When I pin iperf in a guest I do indeed see that all interrupts
> > are arriving to the same irq vector. Is a number after virtio-input
> > in /proc/interrupt any indication of a queue a packet arrived to (on
> > a host I can use ethtool -S to check what queue receives packets, but
> > unfortunately this does not work for virtio nic in a guest)?
> 
> I think it is.
> 
> > Because if
> > it is the way RSS works in virtio is not how it works on a host and not
> > what I would expect after reading about RSS. The queue a packets arrives
> > to should be calculated by hashing fields from a packet header only.
> 
> Yes, what virtio has is not RSS - it's an accelerated RFS really.
> 
OK, if what virtio has is RFS and not RSS my test results make sense.
Thanks!

--
			Gleb.
