From: Christopher Covington <cov@codeaurora.org>
Subject: Re: what should a virtio-mmio transport without a backend look like?
Date: Fri, 21 Jun 2013 12:02:55 -0400
Message-ID: <51C4792F.6010709@codeaurora.org>
References: <CAFEAcA9qCUQLZho8wJvewYJ0AEhDBc37_LpZWs8XBV1U7RVZgA@mail.gmail.com>
	<1371726501.3231.22.camel@hornet> <51C2FC5B.7080406@codeaurora.org>
	<CAFEAcA98py6MHQih8y0Vfr1T1PQj-Cy54cOzPbMfAOH3Xnf+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA98py6MHQih8y0Vfr1T1PQj-Cy54cOzPbMfAOH3Xnf+Tw@mail.gmail.com>
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

On 06/21/2013 11:23 AM, Peter Maydell wrote:
> On 20 June 2013 13:58, Christopher Covington <cov@codeaurora.org> wrote:
>>> On Thu, 2013-06-20 at 11:29 +0100, Peter Maydell wrote:
>>>> 1. One question I've run into is: what should a virtio-mmio transport
>>>> with no backend look like to the guest OS? The spec as written
>>>> seems to assume that there's always some backend present.
>>>> (The idea is that QEMU might just always instantiate say 8
>>>> mmio transports, and then whether they actually have a
>>>> blk/net/whatever backend depends on user options).
> 
>> Might it be reasonably easy to just not enumerate unused transports
>> in the device tree or kernel parameters?
> 
> At least for QEMU, the backend that plugs into the transport
> isn't created until after the machine model has created
> transports and put together the device tree blob. So we don't
> really have the information about what devices are going to
> appear at the point we're doing this.

Would using CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES enumeration instead of device
tree be any easier?

How does the back end know which devices to create?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
