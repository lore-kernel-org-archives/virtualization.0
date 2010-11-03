From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Wed, 03 Nov 2010 13:17:31 -0500
Message-ID: <4CD1A73B.2010406@codemonkey.ws>
References: <1097264455.965471288612409433.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <4CCEC090.3050009@codemonkey.ws> <4CD1A406.3090909@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CD1A406.3090909@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: Alon Levy <alevy@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On 11/03/2010 01:03 PM, Ian Molton wrote:
>
> The virtio driver enfoces the PID field and understands the packet 
> format used. Its better than using serial. Its also just one driver - 
> which doesnt have any special interdependencies and can be extended or 
> got rid of in future if and when better things come along.

Why is it better than using virtio-serial?

>
>> In the very, very short term, I think an external backend to QEMU also
>> makes a lot of sense because that's something that Just Works today.
>
> Whos written that? The 2007 patch I've been working on and updating 
> simply fails to work altogether without huge alterations on current qemu.
>
> My current patch touches a tiny part of the qemu sources. It works today.

But it's not at all mergable in the current form.  If you want to do the 
work of getting it into a mergable state (cleaning up the coding style, 
moving it to hw/, etc.) than I'm willing to consider it.  But I don't 
think a custom virtio transport is the right thing to do here.

However, if you want something that Just Works with the least amount of 
code possible, just split it into a separate process and we can stick it 
in a contrib/ directory or something.

>
>> I
>> think we can consider integrating it into QEMU (or at least simplifying
>> the execution of the backend) but integrating into QEMU is going to
>> require an awful lot of the existing code to be rewritten. Keeping it
>> separate has the advantage of allowing something to Just Work as an
>> interim solution as we wait for proper support in Spice.
>
> I dont know why you think integrating it into qemu is hard? I've 
> already done it. 

Adding a file that happens to compile as part of qemu even though it 
doesn't actually integrate with qemu in any meaningful way is not 
integrating.  That's just build system manipulation.

Regards,

Anthony Liguori

> I added one virtio driver and a seperate offscreen renderer. it 
> touches the qemu code in *one* place. There should be no need to 
> rewrite anything.
