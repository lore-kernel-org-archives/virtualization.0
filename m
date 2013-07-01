From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: what should a virtio-mmio transport without a backend look like?
Date: Mon, 01 Jul 2013 09:37:59 +0930
Message-ID: <87mwq7ta5c.fsf@rustcorp.com.au>
References: <CAFEAcA9qCUQLZho8wJvewYJ0AEhDBc37_LpZWs8XBV1U7RVZgA@mail.gmail.com>
	<1371726501.3231.22.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1371726501.3231.22.camel@hornet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: virtualization@lists.linux-foundation.org, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Pawel Moll <pawel.moll@arm.com> writes:
> On Thu, 2013-06-20 at 11:29 +0100, Peter Maydell wrote:
>> I'm (finally) trying to add virtio-mmio support properly to
>> QEMU now Fred has put all the refactoring foundations in place.
>> 
>> 1. One question I've run into is: what should a virtio-mmio transport
>> with no backend look like to the guest OS? The spec as written
>> seems to assume that there's always some backend present.
>> (The idea is that QEMU might just always instantiate say 8
>> mmio transports, and then whether they actually have a
>> blk/net/whatever backend depends on user options).
>> 
>> It looks as if the current linux driver insists (if it sees a
>> device tree node) that the MagicValue register at least is
>> correct (otherwise it complains). So one possibility would
>> be "MagicValue/Version/VendorID must read as usual, DeviceID
>> should read as some special "nothing here" value (0?), everything
>> else can RAZ/WI".
>> 
>> We could just say "all RAZ/WI", since this merely causes Linux
>> currently to print a warning about the bad magic number, and
>> then subsequently make Linux less alarmist about the zero.
>> 
>> We could also define that the transport should look as if
>> there's some sort of 'null' backend plugged in. This would
>> be more effort on the qemu side though, I think.
>
> There are two aspects of the problem:
>
> 1. Current implementation of the virtio core won't do anything to the
> device if the device/vendor IDs don't match with any of the drivers.
>
> 2. All that current virtio-mmio implementation will do is:
> * read magic
> * read device & vendor id
> * write page size
>
> So, a device behaving as you mentioned - magic ok, all register read as
> zero, all writes ignored, will do exactly what you want.
>
> Now, as to mandating this:
>
> 1. We could mandate device ID 0 (zero) as "NOOP". This is in line with
> current ID numbers allocation, just needs formalizing at the top level
> of the spec.

FWIW, I'm happy to bless 0 as "no device present".

Cheers,
Rusty.
