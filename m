From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with CONFIG_PARAVIRT
Date: Sat, 17 Mar 2007 00:09:19 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0703170008380.23117@yvahk01.tjqt.qr>
References: <45FA054F.6020107@vmware.com> <45FA0D13.6080601@goop.org>
 <45FA16FE.7010805@vmware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753666AbXCPX0U@vger.kernel.org>
In-Reply-To: <45FA16FE.7010805@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Jan Beulich <jbeulich@novell.com>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


On Mar 15 2007 20:03, Zachary Amsden wrote:
> Well testing that is not so fun.  I installed SUSE Pro 9.0, and strings on
> ld.so contains the magic at_sysinfo assert!  But it doesn't install TLS
> libraries, so I'll have to install them by hand.

9.0 is kinda old. And if you want some TLS libs, install the _i686_ glibc
package (not done by default).


Jan
-- 
