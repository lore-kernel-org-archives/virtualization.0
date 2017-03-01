From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [systemd-devel] udev virtio by-path naming
Date: Wed, 1 Mar 2017 03:43:21 +0000
Message-ID: <20170301034321.GH29552__13071.6865569868$1488675820$gmane$org@in.waw.pl>
References: <de55b0f4-4582-cf06-4b0d-12c2282406a8@linux.vnet.ibm.com>
	<20170220151432.GA15888@gardel-login>
	<20170228192851.GC10067@redhat.com>
	<20170228193907.GA26268@gardel-login>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170228193907.GA26268@gardel-login>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Lennart Poettering <lennart@poettering.net>
Cc: systemd-devel@lists.freedesktop.org, "Daniel P. Berrange" <berrange@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 28, 2017 at 08:39:07PM +0100, Lennart Poettering wrote:
> On Tue, 28.02.17 19:28, Daniel P. Berrange (berrange@redhat.com) wrote:
> > The problem with splitting these rules out into a separate project
> > is that there's no other existing place that they would live. The
> > "virtio people" as a group merely write specifications. The actual
> > implementation of those specs is done by multiple other independant
> > groups - QEMU (for host side, though other host side impls exist
> > too) and Linux (for guest side). The udev rules are Linux guest
> > support pieces, but of course Linux itself doesn't distribute udev
> > rules - it delegated that job to the udev package hence why they
> > are here currently. So I don't see that pushing the rules out of
> > the udev repo would be beneficial to people building VMs.

Yeah, that's my view too. Those by-path symlinks are parts of the
basic functionality of the system, and it'd be unfortunate to require
yet another package to make them appear.

We've been there, done that, and too much fragmentation causes more
issues than it solves. The issue with those patches seems to be that
it's hard to find knowledgeable people to review them, but telling
those people to start a project of their own doesn't really help with
that, it just pushes the work around while adding overhead.

> The thing is simply that for these kinds of things it's not done with
> drive-by patches simply because we have noone right now who can review
> them with the right technical expertise.
> 
> So yeah, I am not totally against leaving them in the udev repo (Or to
> say this differently, I am much more interested to see the scsi stuff
> go somewhere else than the virtion stuff), but only if somebody steps
> up and takes up ownership of this, and does so continously.
> 
> No, this doesn't mean you have to subscribe to all systemd
> PRs/issues. It just means that this someone will react to being /cc'ed
> in the github repo sooner or later, and say something.

We could keep an informal list of people who care about specific areas.
This already functions to some extent, and we should just be more
consistent: for any issue, see who touched the code recently, and
mention them in the PR or issue, and for PRs, add people to the
reviewers list. Github the social coding site, ftw!

Zbyszek
