From: Alon Levy <alevy@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Mon, 1 Nov 2010 07:53:29 -0400 (EDT)
Message-ID: <1097264455.965471288612409433.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <4CCAC68F.7050903@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CCAC68F.7050903@codemonkey.ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Ian Molton <ian.molton@collabora.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org


----- "Anthony Liguori" <anthony@codemonkey.ws> wrote:

> On 10/29/2010 06:18 AM, Rusty Russell wrote:
> >> Fixed - updated patch tested and attached.
> >>      
> > OK. FWIW, I think this is an awesome idea.
> 
> Paravirtual OpenGL or the actual proposed implementation?  Have you 
> looked at the actual code?
> 
> If I understand correctly, the implementation is an RPC of opengl 
> commands across virtio that are then rendered on the host to an 
> offscreen buffer.  The buffer is then sent back to the guest in
> rendered 
> form.
> 
> But it's possible to mess around with other guests because the opengl
> 
> commands are not scrubbed. There have been other proposals in the past
> 
> that include a mini JIT that would translate opengl commands into a
> safe 
> form.
> 
> Exposing just an opengl RPC transport doesn't seem that useful either.
>  
> It ought to be part of a VGA card in order for it to be integrated
> with 
> the rest of the graphics system without a round trip.
> 
> The alternative proposal is Spice which so far noone has mentioned.  
> Right now, Spice seems to be taking the right approach to guest 3d
> support.
> 

While we (speaking as part of the SPICE developers) want to have the same
support in our virtual GPU for 3d as we have for 2d, we just don't at this
point of time.

> Regards,
> 
> Anthony Liguori
> 
> >    I understand others are skeptical,
> > but this seems simple and if it works and you're happy to maintain
> it I'm
> > happy to let you do it :)
> >
> > Cheers,
> > Rusty.
> >
> >
