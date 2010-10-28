From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Thu, 28 Oct 2010 16:24:04 +0200
Message-ID: <4CC98784.7020907@redhat.com>
References: <4CAC9CD1.2050601@collabora.co.uk> <4CB1D79A.6070805@redhat.com>	<4CBD739A.2010500@collabora.co.uk> <4CBD7560.6080207@redhat.com> <4CC8226F.5080807@collabora.co.uk> <4CC94203.1080207@redhat.com> <4CC9647A.50108@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CC9647A.50108@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: linux-kernel@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

  On 10/28/2010 01:54 PM, Ian Molton wrote:
>> Well, I like to review an implementation against a spec.
>
>
> True, but then all that would prove is that I can write a spec to 
> match the code.

It would also allow us to check that the spec matches the requirements.  
Those two steps are easier than checking that the code matches the 
requirements.

> The code is proof of concept. the kernel bit is pretty simple, but I'd 
> like to get some idea of whether the rest of the code will be accepted 
> given that theres not much point in having any one (or two) of these 
> components exist without the other.

I guess some graphics people need to be involved.

>
>> Better, but still unsatisfying. If the server is busy, the caller would
>> block. I guess it's expected since it's called from ->fsync(). I'm not
>> sure whether that's the best interface, perhaps aio_writev is better.
>
> The caller is intended to block as the host must perform GL rendering 
> before allowing the guests process to continue.

Why is that?  Can't we pipeline the process?

>
> The only real bottleneck is that processes will block trying to submit 
> data if another process is performing rendering, but that will only be 
> solved when the renderer is made multithreaded. The same would happen 
> on a real GPU if it had only one queue too.
>
> If you look at the host code, you can see that the data is already 
> buffered per-process, in a pretty sensible way. if the renderer itself 
> were made a seperate thread, then this problem magically disappears 
> (the queuing code on the host is pretty fast).

Well, this is out of my area of expertise.  I don't like it, but if it's 
acceptable to the gpu people, okay.

>
> In testing, the overhead of this was pretty small anyway. Running a 
> few dozen glxgears and a copy of ioquake3 simultaneously on an intel 
> video card managed the same framerate with the same CPU utilisation, 
> both with the old code and the version I just posted. Contention 
> during rendering just isn't much of an issue.

-- 
error compiling committee.c: too many arguments to function
