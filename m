From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Wed, 03 Nov 2010 17:50:31 +0000
Message-ID: <4CD1A0E7.8050602@collabora.co.uk>
References: <4CAC9CD1.2050601@collabora.co.uk> <4CBD7560.6080207@redhat.com> <4CC8226F.5080807@collabora.co.uk> <201010292148.01167.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201010292148.01167.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>
List-Id: virtualization@lists.linuxfoundation.org

On 29/10/10 12:18, Rusty Russell wrote:
> On Wed, 27 Oct 2010 11:30:31 pm Ian Molton wrote:
>> On 19/10/10 11:39, Avi Kivity wrote:
>>> On 10/19/2010 12:31 PM, Ian Molton wrote:
>>
>>>>> 2. should start with a patch to the virtio-pci spec to document what
>>>>> you're doing
>>>>
>>>> Where can I find that spec?
>>>
>>> http://ozlabs.org/~rusty/virtio-spec/
>>
>> Ok, but I'm not patching that until theres been some review.
>
> Fair enough; it's a bit of a PITA to patch, so it makes sense to get the
> details nailed down first.

I thought so :)

>> Fixed - updated patch tested and attached.
>
> OK. FWIW, I think this is an awesome idea.  I understand others are skeptical,
> but this seems simple and if it works and you're happy to maintain it I'm
> happy to let you do it :)

Awesoe, thanks Rusty :)
