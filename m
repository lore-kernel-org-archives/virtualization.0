From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Tue, 20 Dec 2011 13:37:18 +0200
Message-ID: <20111220113718.GF3913@redhat.com>
References: <20111211094256.GB11504@redhat.com>
	<87boreohhs.fsf@rustcorp.com.au>
	<20111212182533.GB25916@redhat.com>
	<87liqhtdnj.fsf@rustcorp.com.au> <20111215063004.GA3630@redhat.com>
	<87zketp9nz.fsf@rustcorp.com.au>
	<20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <871us0om2t.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 19, 2011 at 09:38:42PM +1030, Rusty Russell wrote:
> On Mon, 19 Dec 2011 11:13:26 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Dec 19, 2011 at 04:36:38PM +1030, Rusty Russell wrote:
> > > On Sun, 18 Dec 2011 12:18:32 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Fri, Dec 16, 2011 at 12:20:08PM +1030, Rusty Russell wrote:
> > > > > Perhaps a new feature VIRTIO_F_UNSTABLE?  Which (unlike other features)
> > > > > appears and vanishes around config writes by either side?  Kind of a
> > > > > hack though...
> > > > 
> > > > Not sure how this can work in such a setup: when would guest
> > > > check this bit to avoid races?
> > > > A separate registers also seems nicer than a flag.
> > > > 
> > > > Some other possible design choices:
> > > > - a flag to signal config accesses in progress by guest
> > > >   host would need to buffer changes and apply them in one go
> > > >   when flag is cleared
> > > > - a register to make host get/set config in guest memory
> > > > - use a control vq for all devices
> > > 
> > > - seqlock-style generation count register(s)?
> > >   Has the advantage of
> > >   being a noop if things never change.
> 
> Actually, the host doesn't need anything, since it can always lock out
> the guest while it updates the area.
> It's the guest which can't do atomic updates.

There are 2 cases
- updates by guest accesses by host
- accesses by guest updates by host

Both are problematic because the guest accesses are split.
Consider the example I gave at the beginning was with capacity read
by guest. Host can not solve it without guest changes, right?

> > The counter can be in guest memory, right? So we don't pay extra
> > exits.
> 
> Could be, but I'm not delighted about the design.

OK, so this is an argument for always using a control vq, right?

> What does the host do
> if the guest screws things up?  How long do you wait for them to
> complete the seqlock?  Or does it save the old version for use in the
> duration?

Yes, it will have to only apply the change when seqlock is dropped.

> And we don't have any atomic guest write problems that I know of.  We
> can solve it in future (by specifying a config queue).

Don't have == not reported as observed in the field?
It seems clear from code that we do have a race, correct?

> > > - continue to ignore it ;)
> > 
> > Since you decided on a config layout redesign it seems a good time to
> > fix architectural problems ...
> 
> Yes, indeed.
> 
> Cheers,
> Rusty.
