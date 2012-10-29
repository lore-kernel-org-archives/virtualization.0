From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH] virtio-ccw: Clarifications.
Date: Mon, 29 Oct 2012 14:02:38 +0100
Message-ID: <1351515758-22295-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1351515758-22295-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1351515758-22295-1-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Clarify how indicator location is communicated and that the
feature bits are little-endian.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 virtio-spec.lyx |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index b0532ef..83f2771 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -9973,9 +9973,10 @@ Handling Device Features
 
 \begin_layout Standard
 
-\change_inserted -385801441 1345027079
+\change_inserted -385801441 1351067713
 Feature bits are arranged in an array of 32 bit values, making for a total
  of 8192 feature bits.
+ Feature bits are in little-endian byte order.
 \end_layout
 
 \begin_layout Standard
@@ -10112,10 +10113,10 @@ Setting Up Indicators
 
 \begin_layout Standard
 
-\change_inserted -385801441 1347015710
+\change_inserted -385801441 1351067651
 To communicate the location of the indicator bits for host->guest notification,
- the guest uses the CCW_CMD_SET_IND command which sends the guest address
- of the indicators in a 64 bit value.
+ the guest uses the CCW_CMD_SET_IND command, pointing to a location containing
+ the guest address of the indicators in a 64 bit value.
 \end_layout
 
 \begin_layout Standard
-- 
1.7.5.4
