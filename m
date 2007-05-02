From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [RELEASE] Lguest for 2.6.21
Date: Thu, 3 May 2007 03:59:31 +0800
Message-ID: <20070502195931.GB1502__31248.5021343038$1178152567$gmane$org@localhost.localdomain>
References: <1178117028.19815.14.camel@localhost.localdomain>
	<20070502193303.GA1502@localhost.localdomain>
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070502193303.GA1502@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 03, 2007 at 03:33:03AM +0800, WANG Cong wrote:
>Hi Rusty!
>
>I found you forgot to check the return value of copy_from_user, and here is the fix for drivers/lguest/interrupts_and_traps.c.
>

Also this one, in drivers/lguest/hypercalls.c.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

--- linux-2.6.21-rc7-mm2/drivers/lguest/hypercalls.c.orig	2007-05-03 03:45:53.000000000 +0800
+++ linux-2.6.21-rc7-mm2/drivers/lguest/hypercalls.c	2007-05-03 03:46:20.000000000 +0800
@@ -102,7 +102,8 @@ static void do_async_hcalls(struct lgues
 	unsigned int i;
 	u8 st[LHCALL_RING_SIZE];
 
-	copy_from_user(&st, &lg->lguest_data->hcall_status, sizeof(st));
+	if (copy_from_user(&st, &lg->lguest_data->hcall_status, sizeof(st)))
+		return;
 	for (i = 0; i < ARRAY_SIZE(st); i++) {
 		struct lguest_regs regs;
 		unsigned int n = lg->next_hcall;
