From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 3/6] IOPL handling for paravirt guests
Date: Thu, 14 Dec 2006 22:52:09 -0800
Message-ID: <200612150652.kBF6q9e0025520@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

I found a clever way to make the extra IOPL switching invisible to
non-paravirt compiles - since kernel_rpl is statically defined to
be zero there, and only non-zero rpl kernel have a problem restoring IOPL,
as popf does not restore IOPL flags unless run at CPL-0.

Subject: IOPL handling for paravirt guests
Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 8110943fd7ad arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Thu Dec 14 16:15:20 2006 -0800
+++ b/arch/i386/kernel/process.c	Thu Dec 14 16:21:57 2006 -0800
@@ -665,6 +665,15 @@ struct task_struct fastcall * __switch_t
 	load_TLS(next, cpu);
 =

 	/*
+	 * Restore IOPL if needed.  In normal use, the flags restore
+	 * in the switch assembly will handle this.  But if the kernel
+	 * is running virtualized at a non-zero CPL, the popf will
+	 * not restore flags, so it must be done in a separate step.
+	 */
+	if (get_kernel_rpl() && unlikely(prev->iopl !=3D next->iopl))
+		set_iopl_mask(next->iopl);
+
+	/*
 	 * Now maybe handle debug registers and/or IO bitmaps
 	 */
 	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
