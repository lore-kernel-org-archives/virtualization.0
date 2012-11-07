From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH v2] virtio-mmio: Fix irq parsing in the command line
Date: Wed,  7 Nov 2012 14:18:12 +0000
Message-ID: <1352297892-27838-1-git-send-email-pawel.moll@arm.com>
References: <1352120572-16256-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1352120572-16256-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 64-bit machines resource_size_t is a 64-bit value, while
sscanf() format for this argument was defined as "%u". Fixed
by using an intermediate local value of a known length.

Also added cleaned up the resource creation and adde extra
comments to make the parameters parsing easier to follow.

Reported-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/virtio/virtio_mmio.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

Comparing to v1 I've simply "polished" the size assignment
(moved -1 from one place to another) and removed two of the
new comments, as they weren't really useful any more.

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 6b1b7e1..e807c2a 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -521,25 +521,33 @@ static int vm_cmdline_set(const char *device,
 	int err;
 	struct resource resources[2] = {};
 	char *str;
-	long long int base;
+	long long int base, size;
+	unsigned int irq;
 	int processed, consumed = 0;
 	struct platform_device *pdev;
 
-	resources[0].flags = IORESOURCE_MEM;
-	resources[1].flags = IORESOURCE_IRQ;
-
-	resources[0].end = memparse(device, &str) - 1;
+	/* Consume "size" part of the command line parameter */
+	size = memparse(device, &str);
 
+	/* Get "@<base>:<irq>[:<id>]" chunks */
 	processed = sscanf(str, "@%lli:%u%n:%d%n",
-			&base, &resources[1].start, &consumed,
+			&base, &irq, &consumed,
 			&vm_cmdline_id, &consumed);
 
+	/*
+	 * sscanf() processes 3 chunks if "<id>" is given, 2 if not;
+	 * also there must be no extra characters after the last
+	 * chunk, so str[consumed] should be '\0'
+	 */
 	if (processed < 2 || processed > 3 || str[consumed])
 		return -EINVAL;
 
+	resources[0].flags = IORESOURCE_MEM;
 	resources[0].start = base;
-	resources[0].end += base;
-	resources[1].end = resources[1].start;
+	resources[0].end = base + size - 1;
+
+	resources[1].flags = IORESOURCE_IRQ;
+	resources[1].start = resources[1].end = irq;
 
 	if (!vm_cmdline_parent_registered) {
 		err = device_register(&vm_cmdline_parent);
-- 
1.7.10.4
