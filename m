Return-Path: <SRS0=+X4x=F3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011C7C433DB
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 14:36:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E179222B3
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 14:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E179222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 220762DE3B;
	Wed, 23 Dec 2020 14:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FSmj0wDug8dX; Wed, 23 Dec 2020 14:36:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 223ED203E8;
	Wed, 23 Dec 2020 14:36:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0209DC1787;
	Wed, 23 Dec 2020 14:36:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58E17C0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 14:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3FA9686FA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 14:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CGMO7KJaor+d
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 14:36:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2694586FA5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608734213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dUU452tRqrvkfJMA+eezzExr3vkzl56EFOyXCB1EYnQ=;
 b=ZU3/CSMDhow18S+Maf1HEuJM9sMcHZXY62P3WszdU6DFIP69+72iz/QcAnE9S19MhYaqYu
 1m4sozdviREq4kiVR1jwfMI5OtLWA7C7oMm/MsfxRh2nTXaZjojVBo96/VwuFcLiTlB7/j
 uSbnvspCEn75inU0umM0jNWS4Skls/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462--u0xtbG2N-2sRj1vrceUuw-1; Wed, 23 Dec 2020 09:36:49 -0500
X-MC-Unique: -u0xtbG2N-2sRj1vrceUuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9091E180A097;
 Wed, 23 Dec 2020 14:36:48 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-112-247.ams2.redhat.com
 [10.36.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89294614F5;
 Wed, 23 Dec 2020 14:36:39 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2] vhost/vsock: add IOTLB API support
Date: Wed, 23 Dec 2020 15:36:38 +0100
Message-Id: <20201223143638.123417-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This patch enables the IOTLB API support for vhost-vsock devices,
allowing the userspace to emulate an IOMMU for the guest.

These changes were made following vhost-net, in details this patch:
- exposes VIRTIO_F_ACCESS_PLATFORM feature and inits the iotlb
  device if the feature is acked
- implements VHOST_GET_BACKEND_FEATURES and
  VHOST_SET_BACKEND_FEATURES ioctls
- calls vq_meta_prefetch() before vq processing to prefetch vq
  metadata address in IOTLB
- provides .read_iter, .write_iter, and .poll callbacks for the
  chardev; they are used by the userspace to exchange IOTLB messages

This patch was tested specifying "intel_iommu=strict" in the guest
kernel command line. I used QEMU with a patch applied [1] to fix a
simple issue (that patch was merged in QEMU v5.2.0):
    $ qemu -M q35,accel=kvm,kernel-irqchip=split \
           -drive file=fedora.qcow2,format=qcow2,if=virtio \
           -device intel-iommu,intremap=on,device-iotlb=on \
           -device vhost-vsock-pci,guest-cid=3,iommu_platform=on,ats=on

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg09077.html

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

The patch is the same of v1, but I re-tested it with:
- QEMU v5.2.0-551-ga05f8ecd88
- Linux 5.9.15 (host)
- Linux 5.9.15 and 5.10.0 (guest)
Now, enabling 'ats' it works well, there are just a few simple changes.

v1: https://www.spinics.net/lists/kernel/msg3716022.html
v2:
- updated commit message about QEMU version and string used to test
- rebased on mst/vhost branch

Thanks,
Stefano
---
 drivers/vhost/vsock.c | 68 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index a483cec31d5c..5e78fb719602 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -30,7 +30,12 @@
 #define VHOST_VSOCK_PKT_WEIGHT 256
 
 enum {
-	VHOST_VSOCK_FEATURES = VHOST_FEATURES,
+	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
+			       (1ULL << VIRTIO_F_ACCESS_PLATFORM)
+};
+
+enum {
+	VHOST_VSOCK_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
 };
 
 /* Used to track all the vhost_vsock instances on the system. */
@@ -94,6 +99,9 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 	if (!vhost_vq_get_backend(vq))
 		goto out;
 
+	if (!vq_meta_prefetch(vq))
+		goto out;
+
 	/* Avoid further vmexits, we're already processing the virtqueue */
 	vhost_disable_notify(&vsock->dev, vq);
 
@@ -449,6 +457,9 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 	if (!vhost_vq_get_backend(vq))
 		goto out;
 
+	if (!vq_meta_prefetch(vq))
+		goto out;
+
 	vhost_disable_notify(&vsock->dev, vq);
 	do {
 		u32 len;
@@ -766,8 +777,12 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	mutex_lock(&vsock->dev.mutex);
 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
 	    !vhost_log_access_ok(&vsock->dev)) {
-		mutex_unlock(&vsock->dev.mutex);
-		return -EFAULT;
+		goto err;
+	}
+
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+		if (vhost_init_device_iotlb(&vsock->dev, true))
+			goto err;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
@@ -778,6 +793,10 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
+
+err:
+	mutex_unlock(&vsock->dev.mutex);
+	return -EFAULT;
 }
 
 static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
@@ -811,6 +830,18 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 		if (copy_from_user(&features, argp, sizeof(features)))
 			return -EFAULT;
 		return vhost_vsock_set_features(vsock, features);
+	case VHOST_GET_BACKEND_FEATURES:
+		features = VHOST_VSOCK_BACKEND_FEATURES;
+		if (copy_to_user(argp, &features, sizeof(features)))
+			return -EFAULT;
+		return 0;
+	case VHOST_SET_BACKEND_FEATURES:
+		if (copy_from_user(&features, argp, sizeof(features)))
+			return -EFAULT;
+		if (features & ~VHOST_VSOCK_BACKEND_FEATURES)
+			return -EOPNOTSUPP;
+		vhost_set_backend_features(&vsock->dev, features);
+		return 0;
 	default:
 		mutex_lock(&vsock->dev.mutex);
 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
@@ -823,6 +854,34 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 	}
 }
 
+static ssize_t vhost_vsock_chr_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *file = iocb->ki_filp;
+	struct vhost_vsock *vsock = file->private_data;
+	struct vhost_dev *dev = &vsock->dev;
+	int noblock = file->f_flags & O_NONBLOCK;
+
+	return vhost_chr_read_iter(dev, to, noblock);
+}
+
+static ssize_t vhost_vsock_chr_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct vhost_vsock *vsock = file->private_data;
+	struct vhost_dev *dev = &vsock->dev;
+
+	return vhost_chr_write_iter(dev, from);
+}
+
+static __poll_t vhost_vsock_chr_poll(struct file *file, poll_table *wait)
+{
+	struct vhost_vsock *vsock = file->private_data;
+	struct vhost_dev *dev = &vsock->dev;
+
+	return vhost_chr_poll(file, dev, wait);
+}
+
 static const struct file_operations vhost_vsock_fops = {
 	.owner          = THIS_MODULE,
 	.open           = vhost_vsock_dev_open,
@@ -830,6 +889,9 @@ static const struct file_operations vhost_vsock_fops = {
 	.llseek		= noop_llseek,
 	.unlocked_ioctl = vhost_vsock_dev_ioctl,
 	.compat_ioctl   = compat_ptr_ioctl,
+	.read_iter      = vhost_vsock_chr_read_iter,
+	.write_iter     = vhost_vsock_chr_write_iter,
+	.poll           = vhost_vsock_chr_poll,
 };
 
 static struct miscdevice vhost_vsock_misc = {
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
