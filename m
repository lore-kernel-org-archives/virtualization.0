From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] virtio-serial: A guest <-> host interface for
	simple communication
Date: Thu, 25 Jun 2009 10:11:57 +0530
Message-ID: <20090625044157.GB26664__26830.1263604828$1245905051$gmane$org@amit-x200.redhat.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<20090624164049.GE14121@shareable.org>
	<20090624170632.GA24285@amit-x200.redhat.com>
	<20090624175002.GJ14121@shareable.org>
	<20090624180114.GA24906@amit-x200.redhat.com>
	<20090624192027.GT14121@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090624192027.GT14121@shareable.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jamie Lokier <jamie@shareable.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Jun 24 2009 [20:20:27], Jamie Lokier wrote:
> Amit Shah wrote:
> > 
> > I think the interface from the guest POV stays the same: reads / writes
> > to char devices. With virtio-serial, though, we can add a few other
> > interesting things like names to ports, ability to hot-add ports on
> > demand, request notifications when either end goes down, etc.
> 
> Good features, useful for a lot of handy things.  I think it would be
> handy if the same features were available to the guest application
> generally, not just on guest kernels with a specific driver though.
> 
> As we talked before, about things like boot loaders and kernel
> debuggers, and installing the support applications on old guests.

The -net vmchannel offers that option. Can't see how to do it other way.

> Is it possible to support access to the same capabilities through a
> well known IO/MMIO address, in the same way that VGA and IDE are both
> ordinary PCI devices, but also can be reached easily through well
> known IO/MMIO addresses in simple code?

The exits caused by accessing IO/MMIO regions are costlier than using
PV. So using the current vmchannel option would be almost similar in
those respects.

Also, virtio is the almost standard way these days to get performance.
We already have block, net drivers over virtio and they have been ported
to older kernels as well.

		Amit
