From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 06/14] virtio: console: Make read() return -ENODEV on
	hot-unplug
Date: Thu,  2 Sep 2010 18:11:45 +0530
Message-ID: <d2cff941794b7dcfbf583e9e191905e8ee912bd3.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

When a port is hot-unplugged while an app was blocked on a read() call,
the call was unblocked but would not get an error returned.

Return -ENODEV to ensure the app knows the port has gone away.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c8a5678..7fa3c26 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -579,6 +579,9 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 		if (ret < 0)
 			return ret;
 	}
+	/* Port got hot-unplugged. */
+	if (!port->guest_connected)
+		return -ENODEV;
 	/*
 	 * We could've received a disconnection message while we were
 	 * waiting for more data.
-- 
1.7.2.2
