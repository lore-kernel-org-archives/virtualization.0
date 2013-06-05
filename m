From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 5 Jun 2013 17:09:36 +0300
Message-ID: <20130605140936.GB10604@redhat.com>
References: <87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<87wqqhktjx.fsf@rustcorp.com.au> <87fvx460ba.fsf@codemonkey.ws>
	<20130530140132.GC21440@redhat.com>
	<874ndgujiw.fsf@rustcorp.com.au> <20130603101136.GB8649@redhat.com>
	<87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <871u8g67d6.fsf@codemonkey.ws>
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

On Wed, Jun 05, 2013 at 07:59:33AM -0500, Anthony Liguori wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Tue, Jun 04, 2013 at 03:01:50PM +0930, Rusty Russell wrote:
> > You mean make BAR0 an MMIO BAR?
> > Yes, it would break current windows guests.
> > Further, as long as we use same address to notify all queues,
> > we would also need to decode the instruction on x86 and that's
> > measureably slower than PIO.
> > We could go back to discussing hypercall use for notifications,
> > but that has its own set of issues...
> 
> So... does "violating the PCI-e" spec really matter?  Is it preventing
> any guest from working properly?

Yes, absolutely, this wording in spec is not there without reason.

Existing guests allocate io space for PCI express ports in
multiples on 4K.

Since each express device is behind such a port, this means
at most 15 such devices can use IO ports in a system.

That's why to make a pci express virtio device,
we must allow MMIO and/or some other communication
mechanism as the spec requires.

That's on x86.

Besides x86, there are achitectures where IO is unavailable or very slow.

> I don't think we should rush an ABI breakage if the only benefit is
> claiming spec compliance.
> 
> Regards,
> 
> Anthony Liguori

Why do you bring this up? No one advocates any ABI breakage,
I only suggest extensions.


> >
> > -- 
> > MST
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
