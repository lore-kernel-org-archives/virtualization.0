From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Lguest32 print hex on bad reads and writes
Date: Wed, 04 Apr 2007 23:17:58 -0700
Message-ID: <46149496.5050503@zytor.com>
References: <1175714071.9371.31.camel@localhost.localdomain>	<1175742090.12230.630.camel@localhost.localdomain>	<72C854B9-1A7F-44C5-9D62-B6B63F3A6DE7@mac.com>	<1175742848.9371.33.camel@localhost.localdomain> <1175744057.12230.632.camel@localhost.localdomain> <46149000.40200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1945893AbXDEGST@vger.kernel.org>
In-Reply-To: <46149000.40200@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Rusty Russell wrote:
>> On Wed, 2007-04-04 at 23:14 -0400, Steven Rostedt wrote:
>>> On Wed, 2007-04-04 at 23:06 -0400, Kyle Moffett wrote:
>>>
>>>>> (Erk, I wonder what I was thinking when I wrote that?) Can I ask  
>>>>> for %#x (or 0x%x)?  I'm easily confused.
>>>> How about "%p" for pointers?
>>> But that would require casting the numbers to pointers.
>>
>> And the kernel's printk doesn't put 0x on pointers anyway, last I
>> checked 8(
>>
> 
> That's really the bug.  Let's fix it.
> 
>     -hpa

Okay, git tree at:

http://git.kernel.org/?p=linux/kernel/git/hpa/linux-2.6-printk.git;a=summary
git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-printk.git

... will do actual testing and post it to LKML tomorrow.

	-hpa
