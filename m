From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 32/32] ia64/pv_ops: paravirtualized istruction checker.
Date: Tue, 14 Oct 2008 14:58:48 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA353274D37@orsmsx505.amr.corp.intel.com>
References: <1223963507-28056-1-git-send-email-yamahata@valinux.co.jp>
	<1223963507-28056-33-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1223963507-28056-33-git-send-email-yamahata@valinux.co.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Cc: "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> This patch implements a checker to detect instructions which
> should be paravirtualized instead of direct writing raw instruction.
> This patch does rough check so that it doesn't fully cover all cases,
> but it can detects most cases of paravirtualization breakage of hand
> written assembly codes.

There are still some "itc.d" instructions in ivt.S (in the #ifndef
CONFIG_SMP code).  This checker caught them ... but the error messages
from the build were not as elegant as they might be

  AS      arch/ia64/kernel/pvchk-ivt.o
arch/ia64/kernel/ivt.S: Assembler messages:
arch/ia64/kernel/ivt.S:583: Warning: itc.d should not be used directly.
arch/ia64/kernel/ivt.S:583: Error: junk at end of line, first unrecognized character is `r'
arch/ia64/kernel/ivt.S:649: Warning: itc.i should not be used directly.
arch/ia64/kernel/ivt.S:649: Error: junk at end of line, first unrecognized character is `r'
arch/ia64/kernel/ivt.S:701: Warning: itc.d should not be used directly.
arch/ia64/kernel/ivt.S:701: Error: junk at end of line, first unrecognized character is `r'
make[1]: *** [arch/ia64/kernel/pvchk-ivt.o] Error 1
make: *** [arch/ia64/kernel] Error 2


I'll hold off on applying part32/32 until the CONFIG_SMP=n case
is fixed.

-Tony
