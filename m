From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] virtio: Update spec address
Date: Tue,  3 Dec 2013 12:40:21 +0000
Message-ID: <1386074421-20662-1-git-send-email-broonie__5462.8802267418$1386087597$gmane$org@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Mark Brown <broonie@linaro.org>

According to the README at the existing URL the spec has moved to github
so update the documentation to match.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 Documentation/devicetree/bindings/virtio/mmio.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/virtio/mmio.txt b/Documentation/devicetree/bindings/virtio/mmio.txt
index 5069c1b8e193..0648851d2a25 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.txt
+++ b/Documentation/devicetree/bindings/virtio/mmio.txt
@@ -1,6 +1,6 @@
 * virtio memory mapped device
 
-See http://ozlabs.org/~rusty/virtio-spec/ for more details.
+See https://github.com/rustyrussell/virtio-spec for more details.
 
 Required properties:
 
-- 
1.8.5
