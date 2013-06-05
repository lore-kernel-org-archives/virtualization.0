From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 05 Jun 2013 16:53:07 -0500
Message-ID: <87d2s0mdh8.fsf__46538.1263442852$1370469233$gmane$org@codemonkey.ws>
References: <20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
	<20130605140936.GB10604@redhat.com> <87ehcgr3wq.fsf@codemonkey.ws>
	<20130605151953.GA25987@redhat.com> <87bo7ktvaw.fsf@codemonkey.ws>
	<20130605162029.GB26561@redhat.com> <87li6obd2r.fsf@codemonkey.ws>
	<20130605194317.GA30923@redhat.com> <87k3m8qofi.fsf@codemonkey.ws>
	<20130605211405.GA31928@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130605211405.GA31928@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Jun 05, 2013 at 03:42:57PM -0500, Anthony Liguori wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> Can you explain?  I thought the whole trick with separating out the
>> virtqueue notification register was to regain the performance?
>
> Yes but this trick only works well with NPT (it's still a bit
> slower than PIO but not so drastically).
> Without NPT you still need a page walk so it will be slow.

Do you mean NPT/EPT?

If your concern is shadow paging, then I think you're concerned about
hardware that is so slow to start with that it's not worth considering.

>> >> It also maps to what regular hardware does.  I highly doubt that there
>> >> are any real PCI cards that made the shift from PCI to PCI-e without
>> >> bumping at least a revision ID.
>> >
>> > Only because the chance it's 100% compatible on the software level is 0.
>> > It always has some hardware specific quirks.
>> > No such excuse here.
>> >
>> >> It also means we don't need to play games about sometimes enabling IO
>> >> bars and sometimes not.
>> >
>> > This last paragraph is wrong, it ignores the issues 3) to 5) 
>> > I added above.
>> >
>> > If you do take them into account:
>> > 	- there are reasons to add MMIO BAR to PCI,
>> > 	  even without PCI express
>> 
>> So far, the only reason you've provided is "it doesn't work on some
>> architectures."  Which architectures?
>
> PowerPC wants this.

Existing PowerPC remaps PIO to MMAP so it works fine today.

Future platforms may not do this but future platforms can use a
different device.  They certainly won't be able to use the existing
drivers anyway.

Ben, am I wrong here?

>> > 	- we won't be able to drop IO BAR from virtio
>> 
>> An IO BAR is useless if it means we can't have more than 12 devices.
>
>
> It's not useless. A smart BIOS can enable devices one by one as
> it tries to boot from them.

A smart BIOS can also use MMIO to program virtio.

Regards,

Anthony Liguori
