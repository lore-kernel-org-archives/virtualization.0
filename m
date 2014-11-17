From: Gleb Natapov <gleb@cloudius-systems.com>
Subject: Re: vhost + multiqueue + RSS question.
Date: Mon, 17 Nov 2014 09:26:18 +0200
Message-ID: <20141117072618.GE7589__33532.1866361939$1416325583$gmane$org@cloudius-systems.com>
References: <20141116161818.GD7589@cloudius-systems.com>
	<20141116185604.GA12839@redhat.com> <546987DE.2010701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <546987DE.2010701@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 17, 2014 at 01:30:06PM +0800, Jason Wang wrote:
> On 11/17/2014 02:56 AM, Michael S. Tsirkin wrote:
> > On Sun, Nov 16, 2014 at 06:18:18PM +0200, Gleb Natapov wrote:
> >> Hi Michael,
> >>
> >>  I am playing with vhost multiqueue capability and have a question about
> >> vhost multiqueue and RSS (receive side steering). My setup has Mellanox
> >> ConnectX-3 NIC which supports multiqueue and RSS. Network related
> >> parameters for qemu are:
> >>
> >>    -netdev tap,id=hn0,script=qemu-ifup.sh,vhost=on,queues=4
> >>    -device virtio-net-pci,netdev=hn0,id=nic1,mq=on,vectors=10
> >>
> >> In a guest I ran "ethtool -L eth0 combined 4" to enable multiqueue.
> >>
> >> I am running one tcp stream into the guest using iperf. Since there is
> >> only one tcp stream I expect it to be handled by one queue only but
> >> this seams to be not the case. ethtool -S on a host shows that the
> >> stream is handled by one queue in the NIC, just like I would expect,
> >> but in a guest all 4 virtio-input interrupt are incremented. Am I
> >> missing any configuration?
> > I don't see anything obviously wrong with what you describe.
> > Maybe, somehow, same irqfd got bound to multiple MSI vectors?
> > To see, can you try dumping struct kvm_irqfd that's passed to kvm?
> >
> >
> >> --
> >> 			Gleb.
> 
> This sounds like a regression, which kernel/qemu version did you use?
Sorry, should have mentioned it from the start. Host is a fedora 20 with
kernel 3.16.6-200.fc20.x86_64 and qemu-system-x86-1.6.2-9.fc20.x86_64.
Guest is also fedora 20 but with an older kernel 3.11.10-301.

--
			Gleb.
