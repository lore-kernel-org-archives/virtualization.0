From: Christopher Covington <cov@codeaurora.org>
Subject: Re: what should a virtio-mmio transport without a backend look like?
Date: Thu, 20 Jun 2013 08:58:03 -0400
Message-ID: <51C2FC5B.7080406@codeaurora.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?S09OUkFEIEZyw6lkw6ly?= =?UTF-8?B?aWM=?= <fred.konrad@greensocs.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Peter,

On 06/20/2013 07:08 AM, Pawel Moll wrote:
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

Might it be reasonably easy to just not enumerate unused transports in the
device tree or kernel parameters?

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
