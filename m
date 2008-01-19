From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 1/6] explicitly use ktime.h include
Date: Fri, 18 Jan 2008 23:59:05 -0200
Message-ID: <12007079562927-git-send-email-gcosta__42904.7267804437$1200708087$gmane$org@redhat.com>
References: <1200707950911-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200707950911-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch adds the ktime.h header explicitly to hypercalls file,
and avoid depending on it being included somewhere else.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/lguest/hypercalls.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/lguest/hypercalls.c b/drivers/lguest/hypercalls.c
index 32666d0..0f2cb4f 100644
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
 #include <linux/mm.h>
+#include <linux/ktime.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include "lg.h"
-- 
1.5.0.6
