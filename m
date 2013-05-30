From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 30 May 2013 11:47:27 +0930
Message-ID: <871u8pmcso.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <87zkf3fiu2.fsf@rustcorp.com.au>
	<20111211094256.GB11504@redhat.com>
	<87boreohhs.fsf@rustcorp.com.au> <20111212114912.GA7946@redhat.com>
	<20130528075613.GA23148@redhat.com>
	<874ndmoa7z.fsf@rustcorp.com.au> <20130529102100.GQ4472@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130529102100.GQ4472@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sasha Levin <levinsasha928@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Wed, May 29, 2013 at 10:47:52AM +0930, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > On Mon, Dec 12, 2011 at 01:49:13PM +0200, Michael S. Tsirkin wrote:
>> >> On Mon, Dec 12, 2011 at 09:15:03AM +1030, Rusty Russell wrote:
>> >> > On Sun, 11 Dec 2011 11:42:56 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> > > On Thu, Dec 08, 2011 at 09:09:33PM +1030, Rusty Russell wrote:
>> >> > > > +/* There is no iowrite64.  We use two 32-bit ops. */
>> >> > > > +static void iowrite64(u64 val, const __le64 *addr)
>> >> > > > +{
>> >> > > > +	iowrite32((u32)val, (__le32 *)addr);
>> >> > > > +	iowrite32(val >> 32, (__le32 *)addr + 1);
>> >> > > > +}
>> >> > > > +
>> >> > > 
>> >> > > Let's put addr_lo/addr_hi in the structure then,
>> >> > > to make the fact this field is not atomic explicit?
>> >> > 
>> >> > Good point, assuming I haven't missed something.
>> >> > 
>> >> > Are 64-bit accesses actually unknown in PCI-land?  Or is this a limited
>> >> > availability thing?
>> >> > 
>> >> > Thanks,
>> >> > Rusty.
>> >> 
>> >> I think PCI can optionally support atomic 64 bit accesses, but not all
>> >> architectures can generate them.
>> >
>> > Ping. Going to change this in the layout struct?
>> 
>> Not sure what you mean....  We use a queue_enable field, so it doesn't
>> matter if the accesses aren't atomic for that.
>> 
>> Cheers,
>> Rusty.
>
> I mean the struct should have separate _lo and _hi fields.
>
> Otherwise I have to do:
>
> +    case offsetof(struct virtio_pci_common_cfg, queue_desc):
> +	 assert(size == 4);
> +        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & low;
> +    case offsetof(struct virtio_pci_common_cfg, queue_desc) + 4:
> +	 assert(size == 4);
> +        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) >> 32;
>
> Would be nicer as:
>
> +    case offsetof(struct virtio_pci_common_cfg, queue_desc_lo):
> +	 assert(size == sizeof cfg.queue_desc_lo);
> +        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & low;
> +    case offsetof(struct virtio_pci_common_cfg, queue_desc_hi):
> +	 assert(size ==  sizeof cfg.queue_desc_hi);
> +        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) >> 32;
>
> Agree?

Indeed.  Sorry for being obtuse!

Split into _lo and _hi fields:

Subject: virtio_pci: split u64 fields into u32.

MST points out that since we write them as two u32s, and the backend has
to handle that, let's not fool ourselves and just make it two u32s.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 8b35c2e..b5bb348 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -37,17 +37,16 @@ static DEFINE_PCI_DEVICE_TABLE(virtio_pci_id_table) = {
 
 MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);
 
-/* There is no general iowrite64.  We use two 32-bit ops. */
-static void iowrite64_twopart(u64 val, const __le64 *addr)
+static void iowrite64_twopart(u64 val, __le32 *lo, __le32 *hi)
 {
-	iowrite32((u32)val, (__le32 *)addr);
-	iowrite32(val >> 32, (__le32 *)addr + 1);
+	iowrite32((u32)val, lo);
+	iowrite32(val >> 32, hi);
 }
 
 /* There is no ioread64.  We use two 32-bit ops. */
-static u64 ioread64_twopart(__le64 *addr)
+static u64 ioread64_twopart(__le32 *lo, __le32 *hi)
 {
-	return ioread32(addr) | ((u64)ioread32((__le32 *)addr + 1) << 32);
+	return ioread32(lo) | ((u64)ioread32(hi) << 32);
 }
 
 /* config->{get,set}_status() implementations */
@@ -145,14 +144,16 @@ static u64 vp_get64(struct virtio_device *vdev, unsigned offset)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	return ioread64_twopart(vp_dev->device + offset);
+	return ioread64_twopart(vp_dev->device + offset,
+				vp_dev->device + offset + 4);
 }
 
 static void vp_set64(struct virtio_device *vdev, unsigned offset, u64 val)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	iowrite64_twopart(val, vp_dev->device + offset);
+	iowrite64_twopart(val, vp_dev->device + offset,
+			  vp_dev->device + offset + 4);
 }
 
 static void vp_reset(struct virtio_device *vdev)
@@ -198,17 +199,18 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 {
 	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq;
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 	u16 num, off;
 	int err;
 
-	if (index >= ioread16(&vp_dev->common->num_queues))
+	if (index >= ioread16(&cfg->num_queues))
 		return ERR_PTR(-ENOENT);
 
 	/* Select the queue we're interested in */
-	iowrite16(index, &vp_dev->common->queue_select);
+	iowrite16(index, &cfg->queue_select);
 
 	/* Sanity check */
-	switch (ioread64_twopart(&vp_dev->common->queue_desc)) {
+	switch (ioread64_twopart(&cfg->queue_desc_lo, &cfg->queue_desc_hi)) {
 		/* Uninitialized.  Excellent. */
 		break;
 	default:
@@ -217,7 +219,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	/* Maximum size must be a power of 2. */
-	num = ioread16(&vp_dev->common->queue_size);
+	num = ioread16(&cfg->queue_size);
 	if (num & (num - 1)) {
 		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
 		return ERR_PTR(-EINVAL);
@@ -233,7 +235,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	info->desired_num = num;
 
 	/* get offset of notification word for this vq (shouldn't wrap) */
-	off = ioread16(&vp_dev->common->queue_notify_off);
+	off = ioread16(&cfg->queue_notify_off);
 	if ((u64)off * vp_dev->notify_offset_multiplier + 2
 	    > vp_dev->notify_len) {
 		dev_warn(&vp_dev->pci_dev->dev,
@@ -264,8 +266,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	info->vq = vq;
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-		iowrite16(msix_vec, &vp_dev->common->queue_msix_vector);
-		msix_vec = ioread16(&vp_dev->common->queue_msix_vector);
+		iowrite16(msix_vec, &cfg->queue_msix_vector);
+		msix_vec = ioread16(&cfg->queue_msix_vector);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto out_new_virtqueue;
@@ -282,14 +284,14 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	/* Activate the queue. */
-	iowrite16(num, &vp_dev->common->queue_size);
+	iowrite16(num, &cfg->queue_size);
 	iowrite64_twopart(virt_to_phys(vq->vring.desc),
-			  &vp_dev->common->queue_desc);
+			  &cfg->queue_desc_lo, &cfg->queue_desc_hi);
 	iowrite64_twopart(virt_to_phys(vq->vring.avail),
-			  &vp_dev->common->queue_avail);
+			  &cfg->queue_avail_lo, &cfg->queue_avail_hi);
 	iowrite64_twopart(virt_to_phys(vq->vring.used),
-			  &vp_dev->common->queue_used);
-	iowrite8(1, &vp_dev->common->queue_enable);
+			  &cfg->queue_used_lo, &cfg->queue_used_hi);
+	iowrite8(1, &cfg->queue_enable);
 
 	return vq;
 
@@ -352,9 +354,9 @@ static void del_vq(struct virtqueue *vq)
 
 	/* This is for our own benefit, not the device's! */
 	iowrite16(info->desired_num, &vp_dev->common->queue_size);
-	iowrite64_twopart(0, &vp_dev->common->queue_desc);
-	iowrite64_twopart(0, &vp_dev->common->queue_avail);
-	iowrite64_twopart(0, &vp_dev->common->queue_used);
+	iowrite64_twopart(0, &vp_dev->common->queue_desc_lo, &vp_dev->common->queue_desc_hi);
+	iowrite64_twopart(0, &vp_dev->common->queue_avail_lo, &vp_dev->common->queue_avail_hi);
+	iowrite64_twopart(0, &vp_dev->common->queue_used_lo, &vp_dev->common->queue_used_hi);
 
 	free_pages_exact(info->queue, size);
 	kfree(info);
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 591eb0e5..a23226b 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -159,8 +159,11 @@ struct virtio_pci_common_cfg {
 	__le16 queue_msix_vector;	/* read-write */
 	__le16 queue_enable;		/* read-write */
 	__le16 queue_notify_off;	/* read-only */
-	__le64 queue_desc;		/* read-write */
-	__le64 queue_avail;		/* read-write */
-	__le64 queue_used;		/* read-write */
+	__le32 queue_desc_lo;		/* read-write */
+	__le32 queue_desc_hi;		/* read-write */
+	__le32 queue_avail_lo;		/* read-write */
+	__le32 queue_avail_hi;		/* read-write */
+	__le32 queue_used_lo;		/* read-write */
+	__le32 queue_used_hi;		/* read-write */
 };
 #endif /* _UAPI_LINUX_VIRTIO_PCI_H */
