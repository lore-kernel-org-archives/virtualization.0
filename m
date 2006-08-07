From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] Slight cleanups for x86 ring macros (against rc3-mm2)
Date: Mon, 7 Aug 2006 10:51:52 +0200
Message-ID: <200608071051.52727.ak@muc.de>
References: <1154925522.21647.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751172AbWHGIwF@vger.kernel.org>
In-Reply-To: <1154925522.21647.25.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 07 August 2006 06:38, Rusty Russell wrote:
> Clean up of patch for letting kernel run other than ring 0:
> 
> a. Add some comments about the SEGMENT_IS_*_CODE() macros.
> b. Add a USER_RPL macro.  (Code was comparing a value to a mask
>    in some places and to the magic number 3 in other places.)
> c. Add macros for table indicator field and use them.
> d. Change the entry.S tests for LDT stack segment to use the macros.

If you submit a patch that actually applies I would apply it :)

Applying patch patches/slight-cleanups-for-x86-ring-macros-against-rc3-mm2
patching file arch/i386/kernel/entry.S
Hunk #1 FAILED at 237.
Hunk #2 succeeded at 367 (offset -7 lines).
1 out of 2 hunks FAILED -- rejects in file arch/i386/kernel/entry.S
patching file include/asm-i386/ptrace.h
patch: **** malformed patch at line 52: 3);

-Andi
