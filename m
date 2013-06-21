From: Christopher Covington <cov@codeaurora.org>
Subject: Re: what should a virtio-mmio transport without a backend look like?
Date: Fri, 21 Jun 2013 14:01:19 -0400
Message-ID: <51C494EF.4060509@codeaurora.org>
References: <CAFEAcA9qCUQLZho8wJvewYJ0AEhDBc37_LpZWs8XBV1U7RVZgA@mail.gmail.com>
	<1371726501.3231.22.camel@hornet> <51C2FC5B.7080406@codeaurora.org>
	<CAFEAcA98py6MHQih8y0Vfr1T1PQj-Cy54cOzPbMfAOH3Xnf+Tw@mail.gmail.com>
	<51C4792F.6010709@codeaurora.org>
	<CAFEAcA9SM7K=-UFAkFOzRX0jcc5yJj6jAw4QFhWwC8VBO8SggA@mail.gmail.com>
	<1371833230.3155.19.camel@hornet>
	<CAFEAcA-iBduDCbwHYYe7BhAXoBx2A5EgZ6_251B3vMuODewxvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA-iBduDCbwHYYe7BhAXoBx2A5EgZ6_251B3vMuODewxvQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Pawel Moll <pawel.moll@arm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Peter,

On 06/21/2013 01:01 PM, Peter Maydell wrote:
> On 21 June 2013 17:47, Pawel Moll <pawel.moll@arm.com> wrote:
>> On Fri, 2013-06-21 at 17:41 +0100, Peter Maydell wrote:
>>> As it happens, if you use the command line to specify
>>> a virtio device it doesn't make the same complaint about
>>> bad magic number as if you specify it via dtb, but that
>>> should probably be fixed in the kernel :-)
>>
>> I don't really see how this would be possible - the "complaining code"
>> is just a normal platform device probe function.
> 
> Sorry, you're correct and I misremembered. I just retested
> with specifying via command line and it behaves the same
> way as via dtb.

I was going to say something. I see that complaint all the time.

Anyhow, I just did a quick experiment with 0-size block devices, and they seem
to work for me, although trying to mount the device yields the confusing
message, "mount: mounting /dev/vda on mount failed: Invalid argument".

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
