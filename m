From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/10] Tree fixes for PARAVIRT
Date: Fri, 18 Jan 2008 23:02:00 +0100
Message-ID: <20080118220200.GA1071__40214.2196232036$1200693971$gmane$org@elte.hu>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<20080118203259.GA3079@elte.hu> <20080118213711.GA24979@elte.hu>
	<1200693248.21817.157.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1200693248.21817.157.camel@bodhitayantram.eng.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Zachary Amsden <zach@vmware.com> wrote:

> > but in exchange you broke all of 32-bit with CONFIG_PARAVIRT=y. 
> > Which means you did not even build-test it on 32-bit, let alone boot 
> > test it...
> 
> Why are we rushing so much to do 64-bit paravirt that we are breaking 
> working configurations?  If the developement is going to be this 
> chaotic, it should be done and tested out of tree until it can 
> stabilize.

what you see is a open feedback cycle conducted on lkml. People send 
patches for arch/x86, and we tell them if it breaks something. The bug 
was found before i pushed out the x86.git devel tree (and the fix is 
below - but this shouldnt matter to you because the bug never hit a 
public x86.git tree).

	Ingo

Index: linux/include/asm-x86/paravirt.h
===================================================================
--- linux.orig/include/asm-x86/paravirt.h
+++ linux/include/asm-x86/paravirt.h
@@ -619,6 +619,7 @@ static inline void write_cr4(unsigned lo
 	PVOP_VCALL1(pv_cpu_ops.write_cr4, x);
 }
 
+#ifdef CONFIG_X86_64
 static inline unsigned long read_cr8(void)
 {
 	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr8);
@@ -628,6 +629,7 @@ static inline void write_cr8(unsigned lo
 {
 	PVOP_VCALL1(pv_cpu_ops.write_cr8, x);
 }
+#endif
 
 static inline void raw_safe_halt(void)
 {
