From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Ringbuffer usage in Linux Hyper-V drivers
Date: Wed, 03 Mar 2010 09:49:04 -0800
Message-ID: <4B8EA110.1040200@goop.org>
References: <1FB5E1D5CA062146B38059374562DF725A908A11@TK5EX14MBXC126.redmond.corp.microsoft.com>	<20100217235223.GG12197@kroah.com> <8AFC7968D54FB448A30D8F38F259C56212EE39C0@TK5EX14MBXC116.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56212EE39C0@TK5EX14MBXC116.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Hashir Abdi <habdi@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/03/2010 08:42 AM, Hank Janssen wrote:
> There is a pretty good chance that ring buffer on Hyper-V will change to support
> additional functionality. I did further investigations to check on other
> virtualization technologies. And this same things seems to be true for XEN,
> they also implemented their own ring buffer implementation on the guest side
> because of their host side implementation.
>    

Yes.  The cross-domain producer-consumer ringbuffer is a pretty specific 
protocol.  Not only is the data format an ABI, but the exact protocol 
for what pointers get updated when, etc.  Its not at all obvious how we 
could reuse the kernel ringbuffer implementation, since it assumes its 
implementing both the producer and consumer ends.

> So my question is to the community at large, am I missing something that would
> enable me to use an existing ring buffer functionality somehow in the kernel?
> If not, I want to remove the line from the TODO file that is requesting to use the
> in-kernel ring buffer functionality.
>
> Finally, while checking this out, I looked at a bunch of non virtualization device
> drivers currently in the kernel. And all the ones I looked at have
> implemented their own ring buffer. Is there a reason why this might be the case?
>    

linux/ring_buffer.h is relatively new, and probably post-dates most of 
the driver ringbuffers.  If the ringbuffer is entirely within the kernel 
(say, between an ISR and the rest of the kernel) then I guess it might 
be possible to use the standard functions.  But if half the ringbuffer 
is being managed by the device itself, then that will define the protocol.

     J
