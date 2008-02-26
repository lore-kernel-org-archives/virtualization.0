From: Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH 4/8] ia64/pv_ops: paravirtualize
	arch/ia64/kernel/switch_leave.S
Date: Wed, 27 Feb 2008 08:14:21 +1100
Message-ID: <4471.1204060461__20399.2524104708$1204060784$gmane$org@ocs10w>
References: <12040343393726-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: Your message of "Tue, 26 Feb 2008 22:58:55 +0900."
	<12040343393726-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata (on Tue, 26 Feb 2008 22:58:55 +0900) wrote:
> /*
>  * ia64_leave_syscall(): Same as ia64_leave_kernel, except that it doesn't
>@@ -153,7 +165,8 @@ END(__ia64_switch_to)
>  *	      ar.csd: cleared
>  *	      ar.ssd: cleared
>  */
>-GLOBAL_ENTRY(__ia64_leave_syscall)
>+GLOBAL_ENTRY(__paravirt_leave_syscall)
>+	BR_IF_NATIVE(__ia64_leave_syscall, r22, p7)
> 	PT_REGS_UNWIND_INFO(0)

Move BR_IF_NATIVE after PT_REGS_UNWIND_INFO.  PT_REGS_UNWIND_INFO must
define the unwind state at slot 0 of this function to get correct
unwind state.  When virtualized, BR_IF_NATIVE will generate extra code
and move the unwind data past slot 0, breaking the backtrace.

>-GLOBAL_ENTRY(__ia64_leave_kernel)
>+GLOBAL_ENTRY(__paravirt_leave_kernel)
>+	BR_IF_NATIVE(__ia64_leave_kernel, r22, p7)
> 	PT_REGS_UNWIND_INFO(0)

Ditto.
