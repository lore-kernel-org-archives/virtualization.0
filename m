From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] lguest: fix obscure but nasty cow bug
Date: Sat, 05 May 2007 01:00:31 +1000
Message-ID: <1178290831.23670.120.camel__24063.7432937094$1178291054$gmane$org@localhost.localdomain>
References: <1178290638.23670.114.camel@localhost.localdomain>
	<1178290730.23670.117.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1178290730.23670.117.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Nasty bug where the host is the first to write a MAP_PRIVATE page: the
guest still references the old one and won't see the write.  This can
happen with just the wrong data layouts for the initial setup
hypercall (the other places in the code are always written
guest-first).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 drivers/lguest/hypercalls.c |    6 ++++++
 1 file changed, 6 insertions(+)

===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -144,6 +144,12 @@ static void initialize(struct lguest *lg
 	/* We reserve the top pgd entry. */
 	put_user(4U*1024*1024, &lg->lguest_data->reserve_mem);
 	put_user(lg->guestid, &lg->lguest_data->guestid);
+
+	/* This is the one case where the above accesses might have
+	 * been the first write to a Guest page.  This may have caused
+	 * a copy-on-write fault, but the Guest might be referring to
+	 * the old (read-only) page. */
+	guest_pagetable_clear_all(lg);
 }
 
 /* Even if we go out to userspace and come back, we don't want to do
