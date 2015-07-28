From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] virtio_mmio: add ACPI probing
Date: Tue, 28 Jul 2015 21:12:02 +0100
Message-ID: <CAFEAcA9x5kcojVAm-n4ycXQTK3yePqqv9DKvtREfpe5newAZvg@mail.gmail.com>
References: <1438076642-12080-1-git-send-email-graeme.gregory@linaro.org>
	<20150728130604-mutt-send-email-mst@redhat.com>
	<CAFEAcA9H6_oEFKFFNhcGW-8Yy8ng9iNnPbweTvMC46fwLmwA0w@mail.gmail.com>
	<20150728132113-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150728132113-mutt-send-email-mst@redhat.com>
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
Cc: Shannon Zhao <shannon.zhao@linaro.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 28 July 2015 at 11:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Jul 28, 2015 at 11:12:33AM +0100, Peter Maydell wrote:
>> On 28 July 2015 at 11:08, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Tue, Jul 28, 2015 at 10:44:02AM +0100, Graeme Gregory wrote:
>> >> Added the match table and pointers for ACPI probing to the driver.
>> >>
>> >> This uses the same identifier for virt devices as being used for qemu
>> >> ARM64 ACPI support.
>> >>
>> >> http://git.linaro.org/people/shannon.zhao/qemu.git/commit/d0bf1955a3ecbab4b51d46f8c5dda02b7e14a17e
>> >>
>> >> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>

>> >> +#ifdef CONFIG_ACPI
>> >> +static const struct acpi_device_id virtio_mmio_acpi_match[] = {
>> >> +     { "LNRO0005", },
>> >> +     { }
>> >> +};
>> >
>> > Hmm - we have reserved QEMUXXXX in ASWG explicitly for this purpose.
>> >
>> > Pater - do you think it's a good idea to change this before QEMU 2.4
>> > is released?
>>
>> Shannon's call, I guess. I don't know enough about ACPI to say.
>> I thought these ACPI IDs were already fixed because they were
>> what the kernel was looking for...

> Apparently not :)

Mmm. I'm not terribly happy about stuff being in QEMU before the
ACPI spec for it has been finalised. We should not be picking
stuff randomly on the fly...

If we want to fix the ACPI IDs QEMU is using for 2.4 then we
really need to do that now (ie within the next day or two).

-- PMM
