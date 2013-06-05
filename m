From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 05 Jun 2013 17:53:44 -0500
Message-ID: <87obbk88zr.fsf@codemonkey.ws>
References: <20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
	<20130605140936.GB10604@redhat.com> <87ehcgr3wq.fsf@codemonkey.ws>
	<20130605151953.GA25987@redhat.com> <87bo7ktvaw.fsf@codemonkey.ws>
	<20130605162029.GB26561@redhat.com> <87li6obd2r.fsf@codemonkey.ws>
	<20130605194317.GA30923@redhat.com> <87k3m8qofi.fsf@codemonkey.ws>
	<20130605211405.GA31928@redhat.com> <87d2s0mdh8.fsf@codemonkey.ws>
	<1370470797.3766.231.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1370470797.3766.231.camel@pasglop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2013-06-05 at 16:53 -0500, Anthony Liguori wrote:
>
>> A smart BIOS can also use MMIO to program virtio.
>
> Indeed :-)
>
> I see no reason why not providing both access path though. Have the PIO
> BAR there for compatibility/legacy/BIOS/x86 purposes and *also* have the
> MMIO window which I'd be happy to favor on power.
>
> We could even put somewhere in there a feature bit set by qemu to
> indicate whether it thinks PIO or MMIO is faster on a given platform if
> you really think that's worth it (I don't).

That's okay, but what I'm most concerned about is compatibility.

A virtio PCI device that's a "native endpoint" needs to have a different
device ID than one that is a "legacy endpoint".  The current drivers
have no hope of working (well) with virtio PCI devices exposed as native
endpoints.

I don't care if the native PCI endpoint also has a PIO bar.  But it
seems silly (and confusing) to me to make that layout be the "legacy"
layout verses a straight mirror of the new layout if we're already
changing the device ID.

In addition, it doesn't seem at all necessary to have an MMIO bar to the
legacy device.  If the reason you want MMIO is to avoid using PIO, then
you break existing drivers because they assume PIO.  If you are breaking
existing drivers then you should change the device ID.

If strictly speaking it's just that MMIO is a bit faster, I'm not sure
that complexity is worth it without seeing performance numbers first.

Regards,

Anthony Liguori

>
> Cheers,
> Ben.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
