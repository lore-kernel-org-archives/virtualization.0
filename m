From: Laszlo Ersek <lersek@redhat.com>
Subject: [virtio-spec PATCH 5/5] Receiving Used Buffers: prevent speculative
	load when not sequentially consistent
Date: Sat,  8 Jun 2013 19:39:28 +0200
Message-ID: <1370713168-20624-6-git-send-email-lersek@redhat.com>
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

The example code in "Receiving Used Buffers From The Device" goes as
follows:

    vring_disable_interrupts(vq);
    for (;;) {
        if (vq->last_seen_used == vring->used.idx) {
            vring_enable_interrupts(vq);
            mb();
            if (vq->last_seen_used == vring->used.idx)
                break;
            vring_disable_interrupts(vq);
        }
        struct vring_used_elem *e =
            &vring->used.ring[vq->last_seen_used % qsz];
        process_buffer(e);
        vq->last_seen_used++;
    }

Suppose that process_buffer() does something like this:

    process_buffer(struct vring_used_elem *e)
    {
        u32 id;
        u32 len;

        id = e->id;
        len = e->len;

        /* go on to process the descriptor chain starting at "id" */
        process_desc_chain(id, len);
    }

On an architecture that is not sequentially consistent, the "e->id"
load could be executed out of order, speculatively; for example:

    vring_disable_interrupts(vq);
    for (;;) {
        struct vring_used_elem *e =
            &vring->used.ring[vq->last_seen_used % qsz];
        u32 id = e->id;
        u32 len = e->len;

        if (vq->last_seen_used == vring->used.idx) {
            vring_enable_interrupts(vq);
            mb();
            if (vq->last_seen_used == vring->used.idx)
                break;
            vring_disable_interrupts(vq);
        }

        process_desc_chain(id, len);
        vq->last_seen_used++;
    }

The (*e) pointer dereferences are OK, but the pointer targets could be
stale at the time of the speculative load (just adding comments):

    vring_disable_interrupts(vq);
    for (;;) {

        /* ring is empty, load stale data into "id" and "len" */

        struct vring_used_elem *e =
            &vring->used.ring[vq->last_seen_used % qsz];
        u32 id = e->id;
        u32 len = e->len;

        /* at this point the host goes through all of the following:
         * - fill in a descriptor chain
         * - place the index of its head descriptor on the used ring
         * - store the number of processed bytes too
         * - mb()
         * - bump used index
         * - mb()
         *
         * and the used index happens to become visible to the guest,
         * enabling it to move past the next check:
         */

        if (vq->last_seen_used == vring->used.idx) {
            vring_enable_interrupts(vq);
            mb();
            if (vq->last_seen_used == vring->used.idx)
                break;
            vring_disable_interrupts(vq);
        }

        /* use stale "id" and "len" */

        process_desc_chain(id, len);
        vq->last_seen_used++;
    }

Prevent this by adding a barrier between the ring emptiness check and the
access to the used element.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 virtio-spec.lyx |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 51f41dc..2186d35 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -2982,6 +2982,11 @@ for (;;) {
 
 \begin_layout Plain Layout
 
+    mb();
+\end_layout
+
+\begin_layout Plain Layout
+
     process_buffer(e);
 \end_layout
 
-- 
1.7.1
