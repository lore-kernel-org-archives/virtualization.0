From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Mon, 7 Sep 2009 13:15:37 +0300
Message-ID: <20090907101537.GH3031__26967.9119381637$1252318908$gmane$org@redhat.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090903183945.GF28651@ovro.caltech.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 03, 2009 at 11:39:45AM -0700, Ira W. Snyder wrote:
> On Thu, Aug 27, 2009 at 07:07:50PM +0300, Michael S. Tsirkin wrote:
> > What it is: vhost net is a character device that can be used to reduce
> > the number of system calls involved in virtio networking.
> > Existing virtio net code is used in the guest without modification.
> > 
> > There's similarity with vringfd, with some differences and reduced scope
> > - uses eventfd for signalling
> > - structures can be moved around in memory at any time (good for migration)
> > - support memory table and not just an offset (needed for kvm)
> > 
> > common virtio related code has been put in a separate file vhost.c and
> > can be made into a separate module if/when more backends appear.  I used
> > Rusty's lguest.c as the source for developing this part : this supplied
> > me with witty comments I wouldn't be able to write myself.
> > 
> > What it is not: vhost net is not a bus, and not a generic new system
> > call. No assumptions are made on how guest performs hypercalls.
> > Userspace hypervisors are supported as well as kvm.
> > 
> > How it works: Basically, we connect virtio frontend (configured by
> > userspace) to a backend. The backend could be a network device, or a
> > tun-like device. In this version I only support raw socket as a backend,
> > which can be bound to e.g. SR IOV, or to macvlan device.  Backend is
> > also configured by userspace, including vlan/mac etc.
> > 
> > Status:
> > This works for me, and I haven't see any crashes.
> > I have done some light benchmarking (with v4), compared to userspace, I
> > see improved latency (as I save up to 4 system calls per packet) but not
> > bandwidth/CPU (as TSO and interrupt mitigation are not supported).  For
> > ping benchmark (where there's no TSO) troughput is also improved.
> > 
> > Features that I plan to look at in the future:
> > - tap support
> > - TSO
> > - interrupt mitigation
> > - zero copy
> > 
> 
> Hello Michael,
> 
> I've started looking at vhost with the intention of using it over PCI to
> connect physical machines together.
> 
> The part that I am struggling with the most is figuring out which parts
> of the rings are in the host's memory, and which parts are in the
> guest's memory.

All rings are in guest's memory, to match existing virtio code.  vhost
assumes that the memory space of the hypervisor userspace process covers
the whole of guest memory. And there's a translation table.
Ring addresses are userspace addresses, they do not undergo translation.

> If I understand everything correctly, the rings are all userspace
> addresses, which means that they can be moved around in physical memory,
> and get pushed out to swap.

Unless they are locked, yes.

> AFAIK, this is impossible to handle when
> connecting two physical systems, you'd need the rings available in IO
> memory (PCI memory), so you can ioreadXX() them instead. To the best of
> my knowledge, I shouldn't be using copy_to_user() on an __iomem address.
> Also, having them migrate around in memory would be a bad thing.
> 
> Also, I'm having trouble figuring out how the packet contents are
> actually copied from one system to the other. Could you point this out
> for me?

The code in net/packet/af_packet.c does it when vhost calls sendmsg.

> Is there somewhere I can find the userspace code (kvm, qemu, lguest,
> etc.) code needed for interacting with the vhost misc device so I can
> get a better idea of how userspace is supposed to work?

Look in archives for kvm@vger.kernel.org. the subject is qemu-kvm: vhost net.

> (Features
> negotiation, etc.)
> 
> Thanks,
> Ira

That's not yet implemented as there are no features yet.  I'm working on
tap support, which will add a feature bit.  Overall, qemu does an ioctl
to query supported features, and then acks them with another ioctl.  I'm
also trying to avoid duplicating functionality available elsewhere.  So
that to check e.g. TSO support, you'd just look at the underlying
hardware device you are binding to.

-- 
MST
