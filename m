From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Thu, 28 Oct 2010 15:14:49 -0500
Message-ID: <4CC9D9B9.10601@codemonkey.ws>
References: <4CAC9CD1.2050601@collabora.co.uk>	<4CB1D79A.6070805@redhat.com>	<4CBD739A.2010500@collabora.co.uk>	<4CBD7560.6080207@redhat.com>
	<4CC8226F.5080807@collabora.co.uk>	<4CC94203.1080207@redhat.com>
	<4CC9647A.50108@collabora.co.uk> <4CC98784.7020907@redhat.com>
	<4CC98C25.9010207@codemonkey.ws> <4CC9D403.2010805@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CC9D403.2010805@collabora.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, virtualization@lists.osdl.org, Avi Kivity <avi@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/28/2010 02:50 PM, Ian Molton wrote:
> On 28/10/10 15:43, Anthony Liguori wrote:
>> On 10/28/2010 09:24 AM, Avi Kivity wrote:
>>> On 10/28/2010 01:54 PM, Ian Molton wrote:
>>
>>>> True, but then all that would prove is that I can write a spec to
>>>> match the code.
>>>
>>> It would also allow us to check that the spec matches the
>>> requirements. Those two steps are easier than checking that the code
>>> matches the requirements.
>
> There was no formal spec for this. The code was written to replace 
> nasty undefined-instruction based data transport hacks in the (already 
> existing) GL passthrough code.
>
>> I'm extremely sceptical of any GL passthrough proposal. There have
>> literally been half a dozen over the years and they never seem to leave
>> proof-of-concept phase. My (limited) understanding is that it's a
>> fundamentally hard problem that no one has adequately solved yet.
>
> The code in this case has been presented as a patch to qemu nearly 3 
> years ago. I've taken the patches and refactored them to use virtio 
> rather than an undefined instruction (which fails under KVM, unlike my 
> approach).
>
> Its in use testing meego images and seems to be fairly reliable. it 
> can handle compositing window managers, games, video, etc. We're 
> currently supporting OpenGL 1.4 including shaders.
>
>> A specifically matters an awful lot less than an explanation of how the
>> problem is being solved in a robust fashion such that it can be reviewed
>> by people with a deeper understanding of the problem space.
>
> I'm not sure there is a way to prevent nefarious tasks upsetting the 
> hosts OpenGL with carefully crafted strings of commands, short of 
> inspecting every single command, which is insane.
>
> Really this needs to be done at a lower level by presenting a virtual 
> GPU to the guest OS but I am not in a position to code that right now.
>
> The code as it is is useful, and can always be superceeded by a 
> virtual GPU implementation in future.
>
> At least this breaks the chicken / egg cycle of people wanting GL 
> support on virtual machines, but not writing stuff to take advantage 
> of it because the support isn't there. its also a neatly encapsulated 
> solution - if you dont want people to have access to the passthrough, 
> simply tell qemu not to present the virtio-gl device to the guest, via 
> qemus existing commandline options.
>
> If this code was invasive to qemus core, I'd say 'no way' but its just 
> not. and as the GL device is versioned, we can keep using it even if 
> the passthrough is replaced by a virtual GPU.

The virtio-gl implementation is basically duplicating virtio-serial.  It 
looks like ti creates a totally separate window for the GL session.    
In the current form, is there really any advantage to having the code in 
QEMU?  It could just as easily live outside of QEMU.

Regards,

Anthony Liguori
