From: Laszlo Ersek <lersek@redhat.com>
Subject: [virtio-spec PATCH 2/5] Receiving Used Buffers: re-disable interrupts
	when staying in the loop
Date: Sat,  8 Jun 2013 19:39:25 +0200
Message-ID: <1370713168-20624-3-git-send-email-lersek@redhat.com>
References: <1370713168-20624-1-git-send-email-lersek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1370713168-20624-1-git-send-email-lersek@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, Jordan Justen <jordan.l.justen@intel.com>, Laszlo Ersek <lersek@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 virtio-spec.lyx |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 41a763c..851a0cf 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -2967,6 +2967,11 @@ for (;;) {
 
 \begin_layout Plain Layout
 
+		vring_disable_interrupts(vq);
+\end_layout
+
+\begin_layout Plain Layout
+
     }
 \end_layout
 
-- 
1.7.1
