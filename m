From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use correct macros in raid code, not raw asm
Date: Thu, 08 Feb 2007 17:43:34 -0800
Message-ID: <45CBD1C6.1020403@zytor.com>
References: <1167348861.30506.46.camel@localhost.localdomain>	<20061228155659.462eaa9c.akpm@osdl.org>	<1167350803.30506.49.camel@localhost.localdomain>	<20061229111355.GA82929@muc.de>	<45CBCC72.6080409@zytor.com> <17867.53342.333989.501336@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946000AbXBIBoK@vger.kernel.org>
In-Reply-To: <17867.53342.333989.501336@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Neil Brown wrote:
> 
> So does this look right (no, I haven't compiled it yet)
> 

No, the whole raid6_*_save_t should be removed.  I'll try to have a 
patch for you later.

	-hpa
