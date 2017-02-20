From: Lennart Poettering <lennart@poettering.net>
Subject: Re: [systemd-devel] udev virtio by-path naming
Date: Mon, 20 Feb 2017 16:14:32 +0100
Message-ID: <20170220151432.GA15888__5722.87658365003$1487967495$gmane$org@gardel-login>
References: <de55b0f4-4582-cf06-4b0d-12c2282406a8@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <de55b0f4-4582-cf06-4b0d-12c2282406a8@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: systemd-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 20.02.17 15:34, Viktor Mihajlovski (mihajlov@linux.vnet.ibm.com) wrote:

> But then, I find this naming scheme somewhat weird.
> A virtio disk shows up as a regular PCI function on the PCI
> bus side by side with other (non-virtio) devices. The naming otoh
> suggests that virtio-pci is a subsystem of its own, which is simply
> incorrect from a by-path perspective.
> 
> Using just the plain PCI path id is actually sufficient to identify
> a virtio disk by its path. This would be in line with virtio
> network interface path names which use the plain PCI naming.
> 
> One could argue about back-level compatibility, but virtio by-path
> naming has changed multiple times. We have seen virtio-pci-virtio<n>
> (not predictable), pci-<busid> and virtio-pci-<busid> already. It
> might be a good time now to settle on a common approach for all
> virtio types.
> 
> For the reasons above, I'd vote for <subsystem>-<busid>, which
> would work for PCI and CCW, not sure about ARM MMIO though.
> Opinions?

So, to make this clear, we in systemd are kinda interested in
splitting out these virtio helpers into some external project
maintained by virtio peopl. We as systemd/udev maintainers have very
little understanding of the underlying technology, so we can't really
be any good maintainers of this, and we can't really comment on this
stuff, in particular when it gets more exotic, like the CCW stuff.

Even better would be if the kernel would do the naming on its own, and
maybe just provide us with a sysattr on the relevant devices that we
can read to determine the path from, so that we don#t have to maintain
this at all in userspace. That way, the driver folks on the kernel
side can use any naming they like without ever having to patch this
into systemd or udev.

This is similar to SCSI stuff and all things like that: the more
exotic it gets the less place this really has in systemd, we are not
the right maintainers for this. And given that this is all nicely
pluggable (you can ship your own udev extensions externally very
easily), there's really no reason for this to be in systemd/udev.

Anyway, I fear you're going to have a hard time involving us in a
technical discussions about the issue you are raising, since quite
frankly we have no clue about virtio...

Lennart

-- 
Lennart Poettering, Red Hat
