From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/7] Using %gs for per-cpu areas on x86
Date: Fri, 22 Sep 2006 21:51:00 +1000
Message-ID: <1158925861.26261.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932298AbWIVLvG@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: virtualization <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

OK, here it is.  Benchmarks still coming.  This is against Andi's
2.6.18-rc7-git3 tree, and replaces the patches between (and not
including) i386-pda-asm-offsets and i386-early-fault.

One patch is identical, one is mildly modified, the rest are
re-implemented but inspired by Jeremy's PDA work.

Thanks,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
