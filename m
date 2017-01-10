From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v8 1/1] crypto: add virtio-crypto driver
Date: Tue, 10 Jan 2017 13:56:56 +0100
Message-ID: <c4282723-2afb-1764-2431-ef41f7126371__7840.3954081752$1484053039$gmane$org@de.ibm.com>
References: <1481767396-187748-1-git-send-email-arei.gonglei@huawei.com>
	<1481767396-187748-2-git-send-email-arei.gonglei@huawei.com>
	<e235caf4-f51c-dccf-4eb7-548d3fa71644@de.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA182B83@DGGEMA505-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA182B83@DGGEMA505-MBX.china.huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "Hanweidong (Randy)" <hanweidong@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mst@redhat.com" <mst@redhat.com>, Luonengjun <luonengjun@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay,
	Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "davem@davemloft.net" <davem@davemloft.net>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/10/2017 01:36 PM, Gonglei (Arei) wrote:
> Hi,
> 
>>
>> On 12/15/2016 03:03 AM, Gonglei wrote:
>> [...]
>>> +
>>> +static struct crypto_alg virtio_crypto_algs[] = { {
>>> +	.cra_name = "cbc(aes)",
>>> +	.cra_driver_name = "virtio_crypto_aes_cbc",
>>> +	.cra_priority = 501,
>>
>>
>> This is still higher than the hardware-accelerators (like intel aesni or the
>> s390 cpacf functions or the arm hw). aesni and s390/cpacf are supported by the
>> hardware virtualization and available to the guests. I do not see a way how
>> virtio
>> crypto can be faster than that (in the end it might be cpacf/aesni + overhead)
>> instead it will very likely be slower.
>> So we should use a number that is higher than software implementations but
>> lower than the hw ones.
>>
>> Just grepping around, the software ones seem be be around 100 and the
>> hardware
>> ones around 200-400. So why was 150 not enough?
>>
> I didn't find a documentation about how we use the priority, and I assumed
> people use virtio-crypto will configure hardware accelerators in the
> host. So I choosed the number which bigger than aesni's priority.

Yes, but the aesni driver will only bind if there is HW support in the guest.
And if aesni is available in the guest (or the s390 aes function from cpacf)
it will always be faster than the same in the host via virtio.So your priority
should be smaller.
