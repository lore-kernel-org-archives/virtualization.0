From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Mon, 3 Jun 2013 13:11:36 +0300
Message-ID: <20130603101136.GB8649@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<87wqqhktjx.fsf@rustcorp.com.au> <87fvx460ba.fsf@codemonkey.ws>
	<20130530140132.GC21440@redhat.com>
	<874ndgujiw.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <874ndgujiw.fsf@rustcorp.com.au>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 03, 2013 at 09:56:15AM +0930, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Thu, May 30, 2013 at 08:53:45AM -0500, Anthony Liguori wrote:
> >> Rusty Russell <rusty@rustcorp.com.au> writes:
> >> 
> >> > Anthony Liguori <aliguori@us.ibm.com> writes:
> >> >> Forcing a guest driver change is a really big
> >> >> deal and I see no reason to do that unless there's a compelling reason
> >> >> to.
> >> >>
> >> >> So we're stuck with the 1.0 config layout for a very long time.
> >> >
> >> > We definitely must not force a guest change.  The explicit aim of the
> >> > standard is that "legacy" and 1.0 be backward compatible.  One
> >> > deliverable is a document detailing how this is done (effectively a
> >> > summary of changes between what we have and 1.0).
> >> 
> >> If 2.0 is fully backwards compatible, great.  It seems like such a
> >> difference that that would be impossible but I need to investigate
> >> further.
> >> 
> >> Regards,
> >> 
> >> Anthony Liguori
> >
> > If you look at my patches you'll see how it works.
> > Basically old guests use BAR0 new ones don't, so
> > it's easy: BAR0 access means legacy guest.
> > Only started testing but things seem to work
> > fine with old guests so far.
> >
> > I think we need a spec, not just driver code.
> >
> > Rusty what's the plan? Want me to write it?
> 
> We need both, of course, but the spec work will happen in the OASIS WG.
> A draft is good, but let's not commit anything to upstream QEMU until we
> get the spec finalized.  And that is proposed to be late this year.

Well that would be quite sad really.

This means we can't make virtio a spec compliant pci express device,
and we can't add any more feature bits, so no
flexible buffer optimizations for virtio net.

There are probably more projects that will be blocked.

So how about we keep extending legacy layout for a bit longer:
- add a way to access device with MMIO
- use feature bit 31 to signal 64 bit features
  (and shift device config accordingly)

No endian-ness rework, no per queue enable etc.


Then when we start discussions we will have a working
express and working 64 bit feature support,
and it will be that much easier to make it pretty it.


> Since I'm going to have to reformat the spec and adapt it into OASIS
> style anyway, perhaps you should prepare a description as a standalone
> text document.  Easier to email and work with...
> 
> Now, the idea is that if you want to support 0.9 and 1.0 (or whatever we
> call them; I used the term "legacy" for existing implementations in the
> OASIS WG proposal), you add capabilities and don't point them into (the
> start of?) BAR0.  Old drivers use BAR0 as now.
> 
> One trick to note: while drivers shouldn't use both old and new style on
> the same device, you need to allow it for kexec, particularly reset via
> BAR0.
> 
> Cheers,
> Rusty.
