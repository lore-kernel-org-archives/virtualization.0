From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Wed, 03 Nov 2010 18:03:50 +0000
Message-ID: <4CD1A406.3090909@collabora.co.uk>
References: <1097264455.965471288612409433.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <4CCEC090.3050009@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CCEC090.3050009@codemonkey.ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Alon Levy <alevy@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On 01/11/10 13:28, Anthony Liguori wrote:
> On 11/01/2010 06:53 AM, Alon Levy wrote:

>> While we (speaking as part of the SPICE developers) want to have the same
>> support in our virtual GPU for 3d as we have for 2d, we just don't at
>> this point of time.

Would it be helpful to you to have /something/ that works in the 
interim? I'm happy to work with you guys so that we dont need to 
reinvent the wheel ;-)

> Yes, but I think the point is that are two general approaches to
> supporting 3d that are being proposed. One approach is to an RPC layer
> at the OpenGL level which essentially passes through the host OpenGL
> stack. That's what virtio-gl is. This has existed for quite a while and
> there are multiple transports for it.

Well, sort of. this version is heavily modified and only the virtio 
transport is supported in it. Its quite a large code cleanup.

> It supports serial ports, TCP sockets, a custom ISA extension for x86,

The custom ISA idea is cut too since it fails to play nice with KVM. 
Virtio-gl offers better security too.

> Another approach would be to have a virtual GPU and to implement
> GPU-level commands for 3d. I have been repeated told that much of the
> complexity of Spice is absolutely needed for 3d and that that's a major
> part of the design.

I've not seen any implementations of this type that are even close to 
useable.

> GPU-level support for 3d operations has a number of advantages mainly
> that it's more reasonably portable to things like Windows since the 3d
> commands can be a superset of both OpenGL and Direct3d.

Agreed.

> Also, Spice has an abstraction layer that doesn't simply passthrough
> graphics commands, but translates/sanitizes them first. That's another
> advantage over OpenGL passthrough.

I'm not sure that thats actually needed if you are careful about what 
commands you implement on the virtual GPU (and how)

> Without a layer to sanitize commands,
> a guest can do funky things with the host or other guests.

It shouldnt be possible for the guest to hurt other guests actual GL 
rendering (or the hosts) as each PID is handed a context (or contexts) 
of its own. It is possible for the guest to cause the host problems 
though. this is a design flaw in the whole idea of GL RPC. It *isnt* 
reasonable to make it secure, but it certainly is useful right now since 
theres no alternative available.

> I think a Spice-like approach is the best thing long term. In the short
> term, I think doing the GL marshalling over virtio-serial makes a ton of
> sense since the kernel driver is already present upstream. It exists
> exactly for things like this.

The virtio driver enfoces the PID field and understands the packet 
format used. Its better than using serial. Its also just one driver - 
which doesnt have any special interdependencies and can be extended or 
got rid of in future if and when better things come along.

> In the very, very short term, I think an external backend to QEMU also
> makes a lot of sense because that's something that Just Works today.

Whos written that? The 2007 patch I've been working on and updating 
simply fails to work altogether without huge alterations on current qemu.

My current patch touches a tiny part of the qemu sources. It works today.

> I
> think we can consider integrating it into QEMU (or at least simplifying
> the execution of the backend) but integrating into QEMU is going to
> require an awful lot of the existing code to be rewritten. Keeping it
> separate has the advantage of allowing something to Just Work as an
> interim solution as we wait for proper support in Spice.

I dont know why you think integrating it into qemu is hard? I've already 
done it. I added one virtio driver and a seperate offscreen renderer. it 
touches the qemu code in *one* place. There should be no need to rewrite 
anything.
