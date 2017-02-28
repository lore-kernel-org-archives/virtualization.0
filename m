From: Lennart Poettering <lennart@poettering.net>
Subject: Re: [systemd-devel] udev virtio by-path naming
Date: Tue, 28 Feb 2017 20:39:07 +0100
Message-ID: <20170228193907.GA26268@gardel-login>
References: <de55b0f4-4582-cf06-4b0d-12c2282406a8@linux.vnet.ibm.com>
	<20170220151432.GA15888@gardel-login>
	<20170228192851.GC10067@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170228192851.GC10067@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: virtualization@lists.linux-foundation.org, systemd-devel@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 28.02.17 19:28, Daniel P. Berrange (berrange@redhat.com) wrote:

> > Even better would be if the kernel would do the naming on its own, and
> > maybe just provide us with a sysattr on the relevant devices that we
> > can read to determine the path from, so that we don#t have to maintain
> > this at all in userspace. That way, the driver folks on the kernel
> > side can use any naming they like without ever having to patch this
> > into systemd or udev.
> > 
> > This is similar to SCSI stuff and all things like that: the more
> > exotic it gets the less place this really has in systemd, we are not
> > the right maintainers for this. And given that this is all nicely
> > pluggable (you can ship your own udev extensions externally very
> > easily), there's really no reason for this to be in systemd/udev.
> 
> The other post about ptp-kvm rules reminded me that I wanted to
> respond to this mail too.
> 
> The problem with splitting these rules out into a separate project
> is that there's no other existing place that they would live. The
> "virtio people" as a group merely write specifications. The actual
> implementation of those specs is done by multiple other independant
> groups - QEMU (for host side, though other host side impls exist
> too) and Linux (for guest side). The udev rules are Linux guest
> support pieces, but of course Linux itself doesn't distribute udev
> rules - it delegated that job to the udev package hence why they
> are here currently. So I don't see that pushing the rules out of
> the udev repo would be beneficial to people building VMs.
> 
> > Anyway, I fear you're going to have a hard time involving us in a
> > technical discussions about the issue you are raising, since quite
> > frankly we have no clue about virtio...
> 
> Could it be as simple as having a couple of people nominated as the
> technical point of contact for the virtio rules, who can be CC'd
> to get answers any questions that may need answering ? I don't have
> time to actively monitor systemd pull requests for changes affecting
> virtio, but I'd be ok with being pinged if issues come up that need
> assistance & can pull in other virt experts where needed.

Well, yes, it boils down to having capable and interested maintainers
for this, who know the relevant udev bits well (or at least are
willing to figure out what they need ot know) and also knows virtio,
and will review these patches thoroughly, make sure they following
CODING_STYLE and so on..

The thing is simply that for these kinds of things it's not done with
drive-by patches simply because we have noone right now who can review
them with the right technical expertise.

So yeah, I am not totally against leaving them in the udev repo (Or to
say this differently, I am much more interested to see the scsi stuff
go somewhere else than the virtion stuff), but only if somebody steps
up and takes up ownership of this, and does so continously.

No, this doesn't mean you have to subscribe to all systemd
PRs/issues. It just means that this someone will react to being /cc'ed
in the github repo sooner or later, and say something.

Lennart

-- 
Lennart Poettering, Red Hat
