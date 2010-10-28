From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Thu, 28 Oct 2010 22:41:10 +0100
Message-ID: <4CC9EDF6.4050303@collabora.co.uk>
References: <4CAC9CD1.2050601@collabora.co.uk>	<4CB1D79A.6070805@redhat.com>	<4CBD739A.2010500@collabora.co.uk>	<4CBD7560.6080207@redhat.com> <4CC8226F.5080807@collabora.co.uk>	<4CC94203.1080207@redhat.com> <4CC9647A.50108@collabora.co.uk> <4CC98784.7020907@redhat.com> <4CC98C25.9010207@codemonkey.ws> <4CC9D403.2010805@collabora.co.uk> <4CC9D9B9.10601@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CC9D9B9.10601@codemonkey.ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Avi Kivity <avi@redhat.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>
List-Id: virtualization@lists.linuxfoundation.org

On 28/10/10 21:14, Anthony Liguori wrote:

>> If this code was invasive to qemus core, I'd say 'no way' but its just
>> not. and as the GL device is versioned, we can keep using it even if
>> the passthrough is replaced by a virtual GPU.
>
> The virtio-gl implementation is basically duplicating virtio-serial. It
> looks like ti creates a totally separate window for the GL session. In
> the current form, is there really any advantage to having the code in
> QEMU? It could just as easily live outside of QEMU.

you could say much the same about any driver in qemu... you could 
serialise up the registers and ship the data off to be processed on 
another PC if you wanted to...

The code does not, however, create a seperate window for the GL session. 
the GL scene is rendered offscreen, and then piped back to the guest for 
display, so that it is fully composited into the guests graphical 
environment. From a user perspective, its as if the guest had hardware 
3D. Performance is very reasonable, around 40fps in ioquake3 on modest 
(host) hardware.

In theory, the code *could* use a serial transport and render in a 
seperate process, but then that would make it much harder to evolve it 
into a GPU-like system in future.

-Ian
