From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 06 Jun 2013 08:19:57 +1000
Message-ID: <1370470797.3766.231.camel@pasglop>
References: <20130604064216.GD19433@redhat.com>
	<871u8g67d6.fsf@codemonkey.ws> <20130605140936.GB10604@redhat.com>
	<87ehcgr3wq.fsf@codemonkey.ws> <20130605151953.GA25987@redhat.com>
	<87bo7ktvaw.fsf@codemonkey.ws> <20130605162029.GB26561@redhat.com>
	<87li6obd2r.fsf@codemonkey.ws> <20130605194317.GA30923@redhat.com>
	<87k3m8qofi.fsf@codemonkey.ws> <20130605211405.GA31928@redhat.com>
	<87d2s0mdh8.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d2s0mdh8.fsf@codemonkey.ws>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2013-06-05 at 16:53 -0500, Anthony Liguori wrote:

> Existing PowerPC remaps PIO to MMAP so it works fine today.
> 
> Future platforms may not do this but future platforms can use a
> different device.  They certainly won't be able to use the existing
> drivers anyway.
> 
> Ben, am I wrong here?

Well, we do remap PIO, though it's ugly and annoying so we'd rather
avoid it alltogether :-)

Our latest HW PHBs don't support PIO at all, so while we can still
support it in the virtual ones in the guest for ever, it's becoming
pretty clear that PIO is on the way out ...

> >> > 	- we won't be able to drop IO BAR from virtio
> >> 
> >> An IO BAR is useless if it means we can't have more than 12 devices.
> >
> >
> > It's not useless. A smart BIOS can enable devices one by one as
> > it tries to boot from them.
> 
> A smart BIOS can also use MMIO to program virtio.

Indeed :-)

I see no reason why not providing both access path though. Have the PIO
BAR there for compatibility/legacy/BIOS/x86 purposes and *also* have the
MMIO window which I'd be happy to favor on power.

We could even put somewhere in there a feature bit set by qemu to
indicate whether it thinks PIO or MMIO is faster on a given platform if
you really think that's worth it (I don't).

Cheers,
Ben.
