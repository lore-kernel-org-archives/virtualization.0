From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] virtio-serial: A guest <-> host interface for simple
	communication
Date: Wed, 24 Jun 2009 20:20:27 +0100
Message-ID: <20090624192027.GT14121__3209.41761970079$1245871311$gmane$org@shareable.org>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<20090624164049.GE14121@shareable.org>
	<20090624170632.GA24285@amit-x200.redhat.com>
	<20090624175002.GJ14121@shareable.org>
	<20090624180114.GA24906@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090624180114.GA24906@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> On (Wed) Jun 24 2009 [18:50:02], Jamie Lokier wrote:
> > Amit Shah wrote:
> > > On (Wed) Jun 24 2009 [17:40:49], Jamie Lokier wrote:
> > > > Amit Shah wrote:
> > > > > A few sample uses for a vmchannel are to share the host and guest
> > > > > clipboards (to allow copy/paste between a host and a guest), to
> > > > > lock the screen of the guest session when the vnc viewer is closed,
> > > > > to find out which applications are installed on a guest OS even when
> > > > > the guest is powered down (using virt-inspector) and so on.
> > > > 
> > > > Those all look like useful features.
> > > > 
> > > > Can you run an application to provide those features on a guest which
> > > > _doesn't_ have a vmchannel/virtio-serial support in the kernel?
> > > > 
> > > > Or will it be restricted only to guests which have QEMU-specific
> > > > support in their kernel?
> > > 
> > > libguestfs currently uses the -net user based vmchannel interface that
> > > exists in current qemu. That doesn't need a kernel that doesn't have
> > > support for virtio-serial.
> > 
> > That's great!
> > 
> > If that works fine, and guest apps/libraries are using that as a
> > fallback anyway, what benefit do they get from switching to
> > virtio-serial when they detect that instead, given they still have
> > code for the -net method?
> 
> Speed is the biggest benefit.

Fair enough, sounds good, and I can see how it's more usable than a
network interface in many respects.

> > Is the plan to remove -net user based support from libguestfs?
> 
> I don't know what Richard's plan is, but if the kernel that libguestfs
> deploys in the appliance gains support for virtio-serial, there's no
> reason it shouldn't switch.
> 
> > Is virtio-serial significantly simpler to use?
> 
> I think the interface from the guest POV stays the same: reads / writes
> to char devices. With virtio-serial, though, we can add a few other
> interesting things like names to ports, ability to hot-add ports on
> demand, request notifications when either end goes down, etc.

Good features, useful for a lot of handy things.  I think it would be
handy if the same features were available to the guest application
generally, not just on guest kernels with a specific driver though.

As we talked before, about things like boot loaders and kernel
debuggers, and installing the support applications on old guests.

Is it possible to support access to the same capabilities through a
well known IO/MMIO address, in the same way that VGA and IDE are both
ordinary PCI devices, but also can be reached easily through well
known IO/MMIO addresses in simple code?

-- Jamie
