From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/2] rngd: add udev rule to source from hwrng if virtio-rng
	present
Date: Thu,  7 Aug 2014 18:38:59 +0530
Message-ID: <dd2ddb8458e5ab5cffceb7fac2e3f71e9e2197f3.1407416628.git.amit.shah@redhat.com>
References: <cover.1407416628.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1407416628.git.amit.shah@redhat.com>
In-Reply-To: <cover.1407416628.git.amit.shah@redhat.com>
References: <cover.1407416628.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jgarzik@bitpay.com
Cc: linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>, hpa@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

On KVM guests where the virtio-rng device is available, and set as the
current rng, this udev rule will start rngd which will feed in the
host-provided entropy to /dev/random.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 90-virtio-rng.rules | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 90-virtio-rng.rules

diff --git a/90-virtio-rng.rules b/90-virtio-rng.rules
new file mode 100644
index 0000000..07f2f9c
--- /dev/null
+++ b/90-virtio-rng.rules
@@ -0,0 +1 @@
+KERNEL=="hw_random", ATTR{rng_current}=="virtio*", RUN+="/sbin/rngd -r /dev/hwrng"
-- 
1.9.3
