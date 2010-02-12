From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 6/6] Add MAINTAINERS entry for virtio_console
Date: Fri, 12 Feb 2010 10:32:19 +0530
Message-ID: <1265950939-12359-7-git-send-email-amit.shah@redhat.com>
References: <1265950939-12359-1-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-2-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-3-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-4-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-5-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-6-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1265950939-12359-6-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I'm taking ownership of the virtio_console module; but I'll continue
feeding patches via Rusty.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03f38c1..3118dfa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2394,6 +2394,12 @@ L:	linuxppc-dev@ozlabs.org
 S:	Odd Fixes
 F:	drivers/char/hvc_*
 
+VIRTIO CONSOLE DRIVER
+M:	Amit Shah <amit.shah@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/char/virtio_console.c
+
 GSPCA FINEPIX SUBDRIVER
 M:	Frank Zago <frank@zago.net>
 L:	linux-media@vger.kernel.org
-- 
1.6.2.5
