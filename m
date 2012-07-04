From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] virtio-blk spec: document topology fields
Date: Wed,  4 Jul 2012 16:02:36 +0200
Message-ID: <1341410556-5791-1-git-send-email-pbonzini@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: virtualization@lists.osdl.org, kvm@vger.kernel.org, rusty@rustcorp.com.au
List-Id: virtualization@lists.linuxfoundation.org

This completes the changes from yesterday.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virtio-spec.lyx |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 440af3e..905e619 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -5211,34 +5211,88 @@ struct virtio_blk_config {
 
 \begin_layout Plain Layout
 
-\change_inserted 1531152142 1341301807
+\change_inserted 1531152142 1341409825
 
     struct virtio_blk_topology {
 \end_layout
 
 \begin_layout Plain Layout
 
-\change_inserted 1531152142 1341301810
+\change_inserted 1531152142 1341409827
+
+        // # of logical blocks per physical block (log2)
+\change_inserted 1531152142 1341410119
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341409834
 
         u8 physical_block_exp;
 \end_layout
 
 \begin_layout Plain Layout
 
-\change_inserted 1531152142 1341301817
+\change_inserted 1531152142 1341409834
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341409836
+
+        // offset of first aligned logical block
+\change_inserted 1531152142 1341410122
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341409840
 
         u8 alignment_offset;
 \end_layout
 
 \begin_layout Plain Layout
 
-\change_inserted 1531152142 1341301822
+\change_inserted 1531152142 1341409840
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341409842
+
+        // suggested minimum I/O size in blocks
+\change_inserted 1531152142 1341410124
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341409846
 
         u16 min_io_size;
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_inserted 1531152142 1341409846
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341409848
+
+        // optimal (suggested maximum) I/O size in blocks
+\change_inserted 1531152142 1341410126
+
+\end_layout
+
+\begin_layout Plain Layout
+
 \change_inserted 1531152142 1341301827
 
         u32 opt_io_size;
-- 
1.7.10.2

