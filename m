From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v3 1/1] virtio: rng: add derating factor for use by hwrng core
Date: Fri, 15 Aug 2014 10:46:36 +0530
Message-ID: <d05dff370dcac5aa2ce4e41a3936543253565d89.1408078439.git.amit.shah@redhat.com>
References: <cover.1408078439.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1408078439.git.amit.shah@redhat.com>
In-Reply-To: <cover.1408078439.git.amit.shah@redhat.com>
References: <cover.1408078439.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: torvalds@linux-foundation.org
Cc: jgarzik@bitpay.com, tytso@mit.edu, herbert@gondor.apana.org.au, kvm list <kvm@vger.kernel.org>, ricardo.neri-calderon@linux.intel.com, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, duwe@lst.de, Amit Shah <amit.shah@redhat.com>, hpa@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

The khwrngd thread is started when a hwrng device of sufficient
quality is registered.  The virtio-rng device is backed by the
hypervisor, and we trust the hypervisor to provide real entropy.

A malicious or badly-implemented hypervisor is a scenario that's
irrelevant -- such a setup is bound to cause all sorts of badness, and a
compromised hwrng is the least of the user's worries.

Given this, we might as well assume that the quality of randomness we
receive is perfectly trustworthy.  Hence, we use 100% for the factor,
indicating maximum confidence in the source.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Reviewed-by: H. Peter Anvin <hpa@linux.intel.com>
Reviewed-by: Amos Kong <akong@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
Pretty small and contained patch; would be great if it is picked up for
3.17.

v2: re-word commit msg (hpa)
v3: re-word commit msg (tytso)
---
 drivers/char/hw_random/virtio-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 0027137..2e3139e 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -116,6 +116,7 @@ static int probe_common(struct virtio_device *vdev)
 		.cleanup = virtio_cleanup,
 		.priv = (unsigned long)vi,
 		.name = vi->name,
+		.quality = 1000,
 	};
 	vdev->priv = vi;
 
-- 
1.9.3
