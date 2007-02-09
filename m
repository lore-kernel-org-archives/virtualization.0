From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use correct macros in raid code, not raw asm
Date: Thu, 08 Feb 2007 17:20:50 -0800
Message-ID: <45CBCC72.6080409@zytor.com>
References: <1167348861.30506.46.camel@localhost.localdomain> <20061228155659.462eaa9c.akpm@osdl.org> <1167350803.30506.49.camel@localhost.localdomain> <20061229111355.GA82929@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1945951AbXBIBVW@vger.kernel.org>
In-Reply-To: <20061229111355.GA82929@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>, Neil Brown <neilb@suse.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>Neil Brown <neilb@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> The code looks like it's designed to be included from userspace for
>> testing; as it compiles without this include (and has no other
>> includes), I chose not to add it.
>>
>> Linus makes a good point, but someone who actually knows the code
>> should, y'know, test it and stuff...
> 
> It should use kernel_fpu_begin() imho. If someone wants to test
> it in user space again they can add dummy definitions of that
> to their user space  header.

I hadn't seen this thread until now, when Neil pointed me to the thread.

Using kernel_fpu_begin() ... kernel_fpu_end() is probably indeed the 
best option.

	-hpa
