From: Christopher Covington <cov@codeaurora.org>
Subject: Re: what should a virtio-mmio transport without a backend look like?
Date: Fri, 21 Jun 2013 14:45:38 -0400
Message-ID: <51C49F52.1070906@codeaurora.org>
References: <CAFEAcA9qCUQLZho8wJvewYJ0AEhDBc37_LpZWs8XBV1U7RVZgA@mail.gmail.com>
	<1371726501.3231.22.camel@hornet> <51C2FC5B.7080406@codeaurora.org>
	<CAFEAcA98py6MHQih8y0Vfr1T1PQj-Cy54cOzPbMfAOH3Xnf+Tw@mail.gmail.com>
	<51C4792F.6010709@codeaurora.org>
	<CAFEAcA9SM7K=-UFAkFOzRX0jcc5yJj6jAw4QFhWwC8VBO8SggA@mail.gmail.com>
	<1371833230.3155.19.camel@hornet>
	<CAFEAcA-iBduDCbwHYYe7BhAXoBx2A5EgZ6_251B3vMuODewxvQ@mail.gmail.com>
	<51C494EF.4060509@codeaurora.org>
	<CAFEAcA9VjH7DhKnFTK-CjnQPOV8vqduLjuQgWMrOzuz2V1VgwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA9VjH7DhKnFTK-CjnQPOV8vqduLjuQgWMrOzuz2V1VgwQ@mail.gmail.com>
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

On 06/21/2013 02:28 PM, Peter Maydell wrote:
> On 21 June 2013 19:01, Christopher Covington <cov@codeaurora.org> wrote:
>> Anyhow, I just did a quick experiment with 0-size block devices, and they seem
>> to work for me, although trying to mount the device yields the confusing
>> message, "mount: mounting /dev/vda on mount failed: Invalid argument".
> 
> I'm confused -- what's the significance of zero size
> block devices?

You were proposing to use a valid/existing MagicValue/Version/VendorID with a
special DeviceID that does nothing. I'm saying why not use a valid/existing
MagicValue/Version/VendorID/DeviceID with a special parameter setting, size=0,
that does nothing?

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
