From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Fri, 29 Oct 2010 08:05:19 -0500
Message-ID: <4CCAC68F.7050903@codemonkey.ws>
References: <4CAC9CD1.2050601@collabora.co.uk> <4CBD7560.6080207@redhat.com>	<4CC8226F.5080807@collabora.co.uk> <201010292148.01167.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201010292148.01167.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, QEMU Developers <qemu-devel@nongnu.org>, virtualization@lists.osdl.org, Ian Molton <ian.molton@collabora.co.uk>, Avi Kivity <avi@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/29/2010 06:18 AM, Rusty Russell wrote:
>> Fixed - updated patch tested and attached.
>>      
> OK. FWIW, I think this is an awesome idea.

Paravirtual OpenGL or the actual proposed implementation?  Have you 
looked at the actual code?

If I understand correctly, the implementation is an RPC of opengl 
commands across virtio that are then rendered on the host to an 
offscreen buffer.  The buffer is then sent back to the guest in rendered 
form.

But it's possible to mess around with other guests because the opengl 
commands are not scrubbed. There have been other proposals in the past 
that include a mini JIT that would translate opengl commands into a safe 
form.

Exposing just an opengl RPC transport doesn't seem that useful either.  
It ought to be part of a VGA card in order for it to be integrated with 
the rest of the graphics system without a round trip.

The alternative proposal is Spice which so far noone has mentioned.  
Right now, Spice seems to be taking the right approach to guest 3d support.

Regards,

Anthony Liguori

>    I understand others are skeptical,
> but this seems simple and if it works and you're happy to maintain it I'm
> happy to let you do it :)
>
> Cheers,
> Rusty.
>
>    
