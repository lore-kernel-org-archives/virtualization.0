From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/6] virtio_balloon: virtio 1 support
Date: Tue, 14 Apr 2015 11:21:11 +0200
Message-ID: <20150414103036-mutt-send-email-mst__14337.0117912584$1429003302$gmane$org@redhat.com>
References: <1427884468-23930-1-git-send-email-mst@redhat.com>
	<20150412170141-mutt-send-email-mst@redhat.com>
	<87h9sjtsvb.fsf@rustcorp.com.au>
	<20150414102438.11d12347.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150414102438.11d12347.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 14, 2015 at 10:24:38AM +0200, Cornelia Huck wrote:
> On Tue, 14 Apr 2015 10:42:56 +0930
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > > On Wed, Apr 01, 2015 at 02:57:35PM +0200, Michael S. Tsirkin wrote:
> > >> Virtio 1.0 doesn't include a modern balloon device.  At some point we'll likely
> > >> define an incompatible interface with a different ID and different
> > >> semantics.  But for now, it's not a big effort to support a transitional
> > >> balloon device: this has the advantage of supporting existing drivers,
> > >> transparently, as well as transports that don't allow mixing virtio 0 and
> > >> virtio 1 devices. And balloon is an easy device to test, so it's also useful
> > >> for people to test virtio core handling of transitional devices.
> > >> 
> > >> The only interface issue is with the stats buffer, which has misaligned
> > >> fields. We could leave it as is, but this sets a bad precedent that
> > >> others might copy by mistake.
> > >> 
> > >> As we need to change stats code to do byteswaps for virtio 1.0, it seems easy
> > >> to fix by prepending a 6 byte reserved field.  I also had to change config
> > >> structure field types from __le32 to __u32 to match other devices. This means
> > >> we need a couple of __force tags for legacy path but that seems minor.
> > >
> > > Rusty, what are your thoughts here?
> > > How about merging this for 4.1?
> > 
> > I disagree with making any changes, other than allowing it to be used
> > with VIRTIO_F_VERSION_1.
> > 
> > However it doesn't seem to bother anyone else, so I've applied it for
> > 4.1.
> 
> I'm still not really convinced about the stats change either, FWIW.
> Still time to reconsider?
>
> And should we perhaps wait with merging until
> the spec change allowing version 1 has been accepted?

That's not how we did this historically: we require all parts
(spec,qemu,linux) to be available, but don't create specific order
between them.  In particular, I'd strongly prefer not waiting until 4.2,
that would interfere with putting virtio 1 out to use in the field.

Since both Rusty and Cornelia are against virtio_balloon_stat_modern,
I accept this as the majority decision. And switching
over to __virtio tags found a bug, so I'm convinced now.

--->

virtio_balloon: drop virtio_balloon_stat_modern

Looks like we are better off sticking with the misaligned stat struct,
to reduce the amount of virtio 1 specific code in balloon.  So let's do
it.

Add a detailed comment to reduce the chance people copy this bad example.

This also fixes a bug on BE architectures: tag should use
cpu_to_le16, not cpu_to_le32.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----


diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index f81b220..164e0c2 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -52,15 +52,31 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_NR       6
 
+/*
+ * Memory statistics structure.
+ * Driver fills an array of these structures and passes to device.
+ *
+ * NOTE: fields are laid out in a way that would make compiler add padding
+ * between and after fields, so we have to use compiler-specific attributes to
+ * pack it, to disable this padding. This also often causes compiler to
+ * generate suboptimal code.
+ *
+ * We maintain this for backwards compatibility, but don't follow this example.
+ *
+ * Do something like the below instead:
+ *     struct virtio_balloon_stat {
+ *         __virtio16 tag;
+ *         __u8 reserved[6];
+ *         __virtio64 val;
+ *     };
+ *
+ * In other words, add explicit reserved fields to align field and
+ * structure boundaries at field size, avoiding compiler padding
+ * without the packed attribute.
+ */
 struct virtio_balloon_stat {
-	__u16 tag;
-	__u64 val;
+	__virtio16 tag;
+	__virtio64 val;
 } __attribute__((packed));
 
-struct virtio_balloon_stat_modern {
-	__le16 tag;
-	__u8 reserved[6];
-	__le64 val;
-};
-
 #endif /* _LINUX_VIRTIO_BALLOON_H */
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 0583720..9db546e 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -77,10 +77,7 @@ struct virtio_balloon {
 
 	/* Memory statistics */
 	int need_stats_update;
-	union {
-		struct virtio_balloon_stat_modern stats[VIRTIO_BALLOON_S_NR];
-		struct virtio_balloon_stat legacy_stats[VIRTIO_BALLOON_S_NR];
-	};
+	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
 
 	/* To register callback in oom notifier call chain */
 	struct notifier_block nb;
@@ -93,10 +90,7 @@ static struct virtio_device_id id_table[] = {
 
 static void stats_sg_init(struct virtio_balloon *vb, struct scatterlist *sg)
 {
-	if (virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
-		sg_init_one(sg, vb->stats, sizeof(vb->stats));
-	else
-		sg_init_one(sg, vb->legacy_stats, sizeof(vb->legacy_stats));
+	sg_init_one(sg, vb->stats, sizeof(vb->stats));
 }
 
 static u32 page_to_balloon_pfn(struct page *page)
@@ -225,13 +219,8 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
 			       u16 tag, u64 val)
 {
 	BUG_ON(idx >= VIRTIO_BALLOON_S_NR);
-	if (virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1)) {
-		vb->stats[idx].tag = cpu_to_le32(tag);
-		vb->stats[idx].val = cpu_to_le64(val);
-	} else {
-		vb->legacy_stats[idx].tag = tag;
-		vb->legacy_stats[idx].val = val;
-	}
+	vb->stats[idx].tag = cpu_to_virtio16(vb->vdev, tag);
+	vb->stats[idx].val = cpu_to_virtio64(vb->vdev, val);
 }
 
 #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)

-- 
MST
