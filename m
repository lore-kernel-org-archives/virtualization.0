From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/6] virtio_balloon: virtio 1 support
Date: Tue, 14 Apr 2015 11:58:32 +0200
Message-ID: <20150414115440-mutt-send-email-mst@redhat.com>
References: <1427884468-23930-1-git-send-email-mst@redhat.com>
	<20150412170141-mutt-send-email-mst@redhat.com>
	<87h9sjtsvb.fsf@rustcorp.com.au>
	<20150414102438.11d12347.cornelia.huck@de.ibm.com>
	<20150414103036-mutt-send-email-mst@redhat.com>
	<20150414115053.78189c71.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150414115053.78189c71.cornelia.huck@de.ibm.com>
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

On Tue, Apr 14, 2015 at 11:50:53AM +0200, Cornelia Huck wrote:
> On Tue, 14 Apr 2015 11:21:11 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> > index f81b220..164e0c2 100644
> > --- a/include/uapi/linux/virtio_balloon.h
> > +++ b/include/uapi/linux/virtio_balloon.h
> > @@ -52,15 +52,31 @@ struct virtio_balloon_config {
> >  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
> >  #define VIRTIO_BALLOON_S_NR       6
> > 
> > +/*
> > + * Memory statistics structure.
> > + * Driver fills an array of these structures and passes to device.
> > + *
> > + * NOTE: fields are laid out in a way that would make compiler add padding
> > + * between and after fields, so we have to use compiler-specific attributes to
> > + * pack it, to disable this padding. This also often causes compiler to
> > + * generate suboptimal code.
> > + *
> > + * We maintain this for backwards compatibility, but don't follow this example.
> 
> s/this/the existing statistics structure/

existing seems redundant. What else? non-existing?

> > + *
> > + * Do something like the below instead:
> 
> If you want to implement a similar structure, do...
> 
> Just that nobody gets the idea that they are supposed to implement new
> balloon statistics ;)
> 
> > + *     struct virtio_balloon_stat {
> > + *         __virtio16 tag;
> > + *         __u8 reserved[6];
> > + *         __virtio64 val;
> > + *     };
> 
> (...)
> 
> > @@ -225,13 +219,8 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
> >  			       u16 tag, u64 val)
> >  {
> >  	BUG_ON(idx >= VIRTIO_BALLOON_S_NR);
> > -	if (virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1)) {
> > -		vb->stats[idx].tag = cpu_to_le32(tag);
> > -		vb->stats[idx].val = cpu_to_le64(val);
> > -	} else {
> > -		vb->legacy_stats[idx].tag = tag;
> > -		vb->legacy_stats[idx].val = val;
> > -	}
> > +	vb->stats[idx].tag = cpu_to_virtio16(vb->vdev, tag);
> 
> Seems that nobody seemed to care much about statistics...

Or about BE guests ;)

> > +	vb->stats[idx].val = cpu_to_virtio64(vb->vdev, val);
> >  }
> > 
> >  #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
> > 
> 
> With these changes merged in:
> 
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>


OK, here's an updated incremental patch: only comment
changed.



diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index f81b220..984169a 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -52,15 +52,32 @@ struct virtio_balloon_config {
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
+ * We maintain this statistics structure format for backwards compatibility,
+ * but don't follow this example.
+ *
+ * If implementing a similar structure, do something like the below instead:
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
