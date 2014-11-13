From: Shannon Zhao <zhaoshenglong@huawei.com>
Subject: Re: [RFC PATCH] virtio-mmio: support for multiple irqs
Date: Thu, 13 Nov 2014 17:39:06 +0800
Message-ID: <54647C3A.6050106@huawei.com>
References: <1415093712-15156-1-git-send-email-zhaoshenglong@huawei.com>	
	<1415718700.3929.11.camel@arm.com> <54631B0F.7080804@huawei.com>
	<1415817209.3929.31.camel@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1415817209.3929.31.camel@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "john.liuli@huawei.com" <john.liuli@huawei.com>, "remy.gauguey@cea.fr" <remy.gauguey@cea.fr>, "joel.schopp@amd.com" <joel.schopp@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "n.nikolaev@virtualopensystems.com" <n.nikolaev@virtualopensystems.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Paul.Mundt@huawei.com" <Paul.Mundt@huawei.com>, "peter.huangpeng@huawei.com" <peter.huangpeng@huawei.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 2014/11/13 2:33, Pawel Moll wrote:
> On Wed, 2014-11-12 at 08:32 +0000, Shannon Zhao wrote:
>> On 2014/11/11 23:11, Pawel Moll wrote:
>>> On Tue, 2014-11-04 at 09:35 +0000, Shannon Zhao wrote:
>>>> As the current virtio-mmio only support single irq,
>>>> so some advanced features such as vhost-net with irqfd
>>>> are not supported. And the net performance is not
>>>> the best without vhost-net and irqfd supporting.
>>>
>>> Could you, please, help understanding me where does the main issue is?
>>> Is it about:
>>>
>>> 1. The fact that the existing implementation blindly kicks all queues,
>>> instead only of the updated ones?
>>>
>>> or:
>>>
>>> 2. Literally having a dedicated interrupt line (remember, we're talking
>>> "real" interrupts here, not message signalled ones) per queue, so they
>>> can be handled by different processors at the same time?
>>>
>> The main issue is that current virtio-mmio only support one interrupt which is shared by
>> config and queues. 
> 
> Yes.
> 
> Additional question: is your device changing the configuration space
> often? Other devices (for example block devices) change configuration
> very rarely (eg. change of the media size, usually meaning
> hot-un-plugging), so unless you tell me that the config space is
> frequently changes, I'll consider the config event irrelevant from the
> performance point of view.
> 

No, change the configuration space not often.

>> Therefore the virtio-mmio driver should read the
>> "VIRTIO_MMIO_INTERRUPT_STATUS" to get the interrupt reason and check whom this interrupt is to.
> 
> Correct.
> 
>> If we use vhost-net which uses irqfd to inject interrupt, the
>> vhost-net doesn't update "VIRTIO_MMIO_INTERRUPT_STATUS", then the
>> guest driver can't read the interrupt reason and doesn't call a
>> handler to process.
> 
> Ok, so this is the bit I don't understand. Explain, please how does this
> whole thing work. And keep in mind that I've just looked up "irqfd" for
> the first time in my life, so know nothing about its implementation. The
> same applies to "vhost-net". I'm simply coming from a completely
> different background, so bear with me on this.
> 

Ok, sorry. I ignored this.

When we use only virtio-mmio or vhost-net without irqfd, the device uses qemu_set_irq(within qemu)
to inject interrupt and at the same time qemu update "VIRTIO_MMIO_INTERRUPT_STATUS" to tell guest
driver whom this interrupt to. All these things are done by qemu. Though qemu_set_irq will call
kvm_set_irq to do the real interrupt inject, but the trigger is qemu and it can update the
"VIRTIO_MMIO_INTERRUPT_STATUS" register before injecting the interrupt.

But if we use vhost-net with irqfd, the device uses ioeventfd mechanism to inject interrupt.
When an interrupt happened, it doesn't transfer to qemu, while the irqfd finally call kvm_set_irq
to inject the interrupt directly. All these things are done in kvm and it can't update the
"VIRTIO_MMIO_INTERRUPT_STATUS" register.
So if the guest driver still uses the old interrupt handler, it has to read the
"VIRTIO_MMIO_INTERRUPT_STATUS" register to get the interrupt reason and run different handlers
for different reasons. But the register has nothing and none of handlers will be called.

I make myself clear? :-)

> Now, the virtio-mmio device *must* behave in a certain way, as specified
> in both the old and the new version of the spec. If a Used Ring of *any*
> of the queues has been updated the device *must* set bit 0 of the
> interrupt status register, and - in effect - generate the interrupt.
> 
> But you are telling me that in some circumstances the interrupt is *not*
> generated when a queue requires handling. Sounds like a bug to me, as it
> is not following the requirements of the device specification.
> 
> It is quite likely that I simply don't see some facts which are obvious
> for you, so please - help me understand.
> 
>> So we can assign a dedicated interrupt line per queue for virtio-mmio
>> and it can work with irqfd.
>>
> If my reasoning above is correct, I'd say that you are just working
> around a functional bug, not improving performance. And this is a wrong
> way of solving the problem.
> 
>> Theoretically the number of interrupts has no limit, but as the limit
>> of ARM interrupt line, the number should  be less than ARM interrupt
>> lines. 
> 
> Let me just emphasize the fact that virtio-mmio is not related to ARM in
> any way, it's just a memory mapped device with a generic interrupt
> output. Any limitations of a particular hardware platform (I guess
> you're referring to the maximum number of peripheral interrupts a GIC
> can take) are irrelevant - if we go with multiple interrupts, it must
> cater for as many interrupt lines as one wishes... :-)
> 
>> In the real situation, I think, the number
>> is generally less than 17 (8 pairs of vring interrupts and one config
>> interrupt).
> 
> ... but of course we could optimize for the real scenarios. And I'm glad
> to hear that the number you quoted is less then 30 :-)
> 
>>>> we use GSI for multiple irq. 
>>>
>>> I'm not sure what GSI stands for, but looking at the code I assume it's
>>> just a "normal" peripheral interrupt.
>>>
>>>> In this patch we use "vm_try_to_find_vqs"
>>>> to check whether multiple irqs are supported like
>>>> virtio-pci.
>>>
>>> Yeah, I can see that you have followed virtio-pci quite literally. I'm
>>> particularly not convinced to the one interrupt for config, one for all
>>> queues option. Doesn't make any sense to me here.
>>>
>> About one interrupt for all queues, it's not a typical case. But just offer
>> one more choice for users. Users should configure the number of interrupts
>> according to their situation.
> 
> 
>>>> Is this the right direction? is there other ways to
>>>> make virtio-mmio support multiple irq? Hope for feedback.
>>>
>>> One point I'd like to make is that the device was intentionally designed
>>> with simplicity in mind first, performance later (something about
>>> "embedded" etc" :-). Changing this assumption is of course possible, but
>> Ah, I think ARM is not only about embedded things. Maybe it could has a wider application
>> such as micro server. Just my personal opinion.
>>
>>> - I must say - makes me slightly uncomfortable... The extensions we're
>>> discussing here seem doable, but I've noticed your other patches doing
>>> with a shared memory region and I didn't like them at all, sorry.
>>>
>> The approach with a shared memory region is dropped as you can see from the mailing list.
> 
> Glad to hear that :-)
> 
>> The approach of this patch get a net performance improvement about 30%.
>> This maybe makes sense to the paltform without MSI support(e.g ARM with GICv2).
> 
> I appreciate the improvement. I'm just cautions when it comes to
> significant changes to the standard so late in the process.
> 

Sorry, I didn't notice it's at the final phase of the process. It's the first time in my life
to make a change for virtio-spec like you first time saw irqfd.:-)

In a word, the Multi-IRQ make vhost-net with irqfd based on virtio-mmio work and the irqfd reduces
vm-exit and context switch between qemu and kvm. So it can bring performance improvement.


> Pawel
> 
> 
> .
> 


-- 
Shannon
