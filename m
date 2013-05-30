From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 30 May 2013 17:01:32 +0300
Message-ID: <20130530140132.GC21440@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<87wqqhktjx.fsf@rustcorp.com.au> <87fvx460ba.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87fvx460ba.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 30, 2013 at 08:53:45AM -0500, Anthony Liguori wrote:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> 
> > Anthony Liguori <aliguori@us.ibm.com> writes:
> >> Forcing a guest driver change is a really big
> >> deal and I see no reason to do that unless there's a compelling reason
> >> to.
> >>
> >> So we're stuck with the 1.0 config layout for a very long time.
> >
> > We definitely must not force a guest change.  The explicit aim of the
> > standard is that "legacy" and 1.0 be backward compatible.  One
> > deliverable is a document detailing how this is done (effectively a
> > summary of changes between what we have and 1.0).
> 
> If 2.0 is fully backwards compatible, great.  It seems like such a
> difference that that would be impossible but I need to investigate
> further.
> 
> Regards,
> 
> Anthony Liguori

If you look at my patches you'll see how it works.
Basically old guests use BAR0 new ones don't, so
it's easy: BAR0 access means legacy guest.
Only started testing but things seem to work
fine with old guests so far.

I think we need a spec, not just driver code.

Rusty what's the plan? Want me to write it?

> >
> > It's a delicate balancing act.  My plan is to accompany any changes in
> > the standard with a qemu implementation, so we can see how painful those
> > changes are.  And if there are performance implications, measure them.
> >
> > Cheers,
> > Rusty.
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
