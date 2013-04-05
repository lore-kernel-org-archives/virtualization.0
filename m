From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Fri, 05 Apr 2013 11:55:44 +1030
Message-ID: <874nfln4yv.fsf@rustcorp.com.au>
References: <8738vjer43.fsf@rustcorp.com.au>
	<20130326193911.GA19251@redhat.com>
	<87ip4d4sef.fsf@rustcorp.com.au>
	<20130327112535.GE24243@redhat.com>
	<5153CC2E.3090908@zytor.com> <878v554lsr.fsf@rustcorp.com.au>
	<515B610C.9000802@zytor.com> <8738v85elm.fsf@rustcorp.com.au>
	<20130403112216.GB19122@redhat.com>
	<87obdu3kz0.fsf@rustcorp.com.au>
	<20130404082559.GA10369@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130404082559.GA10369@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> By the way, Gleb pointed out that on older hosts MMIO will
> always be slower since we need to do a shadow page walk to
> translate virtual to physical address.
> Hopefully not a big concern, and after all we are still
> keeping PIO around for use by BIOS ...

Yeah, slow hosts will be slow :)

>> +	/* get offset of notification byte for this virtqueue */
>> +	off = ioread16(&vp_dev->common->queue_notify_off);
>> +	if (off * vp_dev->notify_offset_multiplier > vp_dev->notify_len) {
>
> maybe check there's no overflow too?
> if (UINT32_MAX / vp_dev->notify_offset_multiplier > off)
> 	return -EINVAL;

I think it's clearer to just do:

        if ((u64)off * vp_dev->notify_offset_multiplier > vp_dev->notify_len) {

Since off is 16 bits and notify_offset_multiplier is 32, this catches
overflow.

>> +		dev_warn(&vp_dev->pci_dev->dev,
>> +			 "bad notification offset %u for queue %u (> %u)",
>> +			 off, index, vp_dev->notify_len);
>> +		err = -EINVAL;
>> +		goto out_info;
>> +	}
>
> I don't know if you want to limit this to "0 or power of two",
> if yes you'd do
> 	if (vp_dev->notify_offset_multiplier & (vp_dev->notify_offset_multiplier - 1))
> 		return -EINVAL;
>
>> +	info->notify = vp_dev->notify_base + off * vp_dev->notify_offset_multiplier;
>>  
>>  	info->queue = alloc_virtqueue_pages(&num);
>>  	if (info->queue == NULL) {

I don't see a reason to restrict it.  It's not like you'll be
calculating this value more than once even in a micro implementation...

Also, let's add 2, since we write a word in there...

Cheers,
Rusty.

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 3d0318d..1c3591a 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -502,12 +502,14 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 
 	info->msix_vector = msix_vec;
 
-	/* get offset of notification byte for this virtqueue */
+	/* get offset of notification word for this vq (shouldn't wrap) */
 	off = ioread16(&vp_dev->common->queue_notify_off);
-	if (off * vp_dev->notify_offset_multiplier + 2 > vp_dev->notify_len) {
+	if ((u64)off * vp_dev->notify_offset_multiplier + 2
+	    > vp_dev->notify_len) {
 		dev_warn(&vp_dev->pci_dev->dev,
-			 "bad notification offset %u for queue %u (> %u)",
-			 off, index, vp_dev->notify_len);
+			 "bad notification offset %u (x %u) for queue %u > %u",
+			 off, vp_dev->notify_offset_multiplier, 
+			 index, vp_dev->notify_len);
 		err = -EINVAL;
 		goto out_info;
 	}
