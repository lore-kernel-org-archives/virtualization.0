From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 3/6] explicitly use sched.h include
Date: Fri, 18 Jan 2008 23:59:07 -0200
Message-ID: <12007079663929-git-send-email-gcosta__43270.8824555904$1200708441$gmane$org@redhat.com>
References: <1200707950911-git-send-email-gcosta@redhat.com>
	<12007079562927-git-send-email-gcosta@redhat.com>
	<12007079613080-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12007079613080-git-send-email-gcosta@redhat.com>
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

This patch adds the sched.h header explicitly to lguest_user file,
and avoid depending on it being included somewhere else.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/lguest/lguest_user.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/lguest/lguest_user.c b/drivers/lguest/lguest_user.c
index a87fca6..85d42d3 100644
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -6,6 +6,7 @@
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include "lg.h"
 
 /*L:055 When something happens, the Waker process needs a way to stop the
-- 
1.5.0.6
