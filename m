From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Lguest32, use guest page tables to find paddr for
	emulated instructions
Date: Thu, 05 Apr 2007 12:59:36 +1000
Message-ID: <1175741976.12230.627.camel@localhost.localdomain>
References: <1175713626.9371.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1160993AbXDEC7j@vger.kernel.org>
In-Reply-To: <1175713626.9371.28.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Glauber de Oliveira Costa <glommer@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-04-04 at 15:07 -0400, Steven Rostedt wrote:
> [Bug that was found by my previous patch]
> 
> This patch allows things like modules, which don't have a direct
> __pa(EIP) mapping to do emulated instructions.
> 
> Sure, the emulated instruction probably should be a paravirt_op, but
> this patch lets you at least boot a kernel that has modules needing
> emulated instructions.

Yeah, I haven't tried loading random modules but I can imagine this does
happen (what module was it, BTW?)

I used to have a function just like this, but managed to get rid of
it.  

Hmm, perhaps we should have an "int lgread_virt_byte(u8 *)" which does
the pgtable walk and read all in one?  It won't be efficient, but it'll
be more correct and maybe even fewer lines 8)

Thanks for the patch!
Rusty.
