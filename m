From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for June 13 (XEN)
Date: Fri, 13 Jun 2008 10:13:16 -0700
Message-ID: <20080613101316.1c228fe7.randy.dunlap@oracle.com>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080613232214.394fd6fd.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, jeremy@xensource.com, chrisw@sous-sol.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


next-20080613 on x86_32 has lots of xen build errors like this:

linux-next-20080613/arch/x86/xen/mmu.c: In function 'drop_mm_ref':
linux-next-20080613/arch/x86/xen/mmu.c:759: error: implicit declaration of function 'xen_smp_call_function_mask'
make[2]: *** [arch/x86/xen/mmu.o] Error 1


---
~Randy
'"Daemon' is an old piece of jargon from the UNIX operating system,
where it referred to a piece of low-level utility software, a
fundamental part of the operating system."
