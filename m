From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Mon, 01 Nov 2010 08:28:48 -0500
Message-ID: <4CCEC090.3050009@codemonkey.ws>
References: <1097264455.965471288612409433.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1097264455.965471288612409433.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alon Levy <alevy@redhat.com>
Cc: Ian Molton <ian.molton@collabora.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On 11/01/2010 06:53 AM, Alon Levy wrote:
>> The alternative proposal is Spice which so far noone has mentioned.
>> Right now, Spice seems to be taking the right approach to guest 3d
>> support.
>>
>>      
> While we (speaking as part of the SPICE developers) want to have the same
> support in our virtual GPU for 3d as we have for 2d, we just don't at this
> point of time.
>    

Yes, but I think the point is that are two general approaches to 
supporting 3d that are being proposed.  One approach is to an RPC layer 
at the OpenGL level which essentially passes through the host OpenGL 
stack.  That's what virtio-gl is.  This has existed for quite a while 
and there are multiple transports for it.  It supports serial ports, TCP 
sockets, a custom ISA extension for x86, and now a custom virtio transport.

Another approach would be to have a virtual GPU and to implement 
GPU-level commands for 3d.  I have been repeated told that much of the 
complexity of Spice is absolutely needed for 3d and that that's a major 
part of the design.

GPU-level support for 3d operations has a number of advantages mainly 
that it's more reasonably portable to things like Windows since the 3d 
commands can be a superset of both OpenGL and Direct3d.

Also, Spice has an abstraction layer that doesn't simply passthrough 
graphics commands, but translates/sanitizes them first.   That's another 
advantage over OpenGL passthrough.  Without a layer to sanitize 
commands, a guest can do funky things with the host or other guests.

I think a Spice-like approach is the best thing long term.  In the short 
term, I think doing the GL marshalling over virtio-serial makes a ton of 
sense since the kernel driver is already present upstream.  It exists 
exactly for things like this.

In the very, very short term, I think an external backend to QEMU also 
makes a lot of sense because that's something that Just Works today.  I 
think we can consider integrating it into QEMU (or at least simplifying 
the execution of the backend) but integrating into QEMU is going to 
require an awful lot of the existing code to be rewritten.  Keeping it 
separate has the advantage of allowing something to Just Work as an 
interim solution as we wait for proper support in Spice.

Regards,

Anthony Liguori

>    
>> Regards,
>>
>> Anthony Liguori
>>
>>      
>>>     I understand others are skeptical,
>>> but this seems simple and if it works and you're happy to maintain
>>>        
>> it I'm
>>      
>>> happy to let you do it :)
>>>
>>> Cheers,
>>> Rusty.
>>>
>>>
>>>        
