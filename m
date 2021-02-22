Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A9CC433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 08:47:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A3764E4B
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 08:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A3764E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 597EB85C95;
	Mon, 22 Feb 2021 08:47:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hvhu9rF7sn35; Mon, 22 Feb 2021 08:47:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 726E285C7A;
	Mon, 22 Feb 2021 08:47:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B56AC000B;
	Mon, 22 Feb 2021 08:47:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE248C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96CAC838CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HMOeECCt2Xyo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:46:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20D8F838C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613983617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BRBKKPTDQQSllyCSH6Sx8yz6rlC3+XTAEeNCR0qemEM=;
 b=YYwGLuw5xnY/L30V2FocN0w5UaxtyyUdPk9+kacrMN91IDmJUExqhwkY+X4Cd2z1pmZjAr
 Y2EWz5+b6uFtQhaVhMqe++317Pc3aBDllawiCi1kpxdE15E6/JXMbbZ+LHS0igTt6Gt3mF
 SE0tKuYpH2TVv3JxpXVOKuIuGX+cmeI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-2RLxjnZdNXWeOhd_YB3yCw-1; Mon, 22 Feb 2021 03:46:55 -0500
X-MC-Unique: 2RLxjnZdNXWeOhd_YB3yCw-1
Received: by mail-wr1-f71.google.com with SMTP id p18so5813525wrt.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 00:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BRBKKPTDQQSllyCSH6Sx8yz6rlC3+XTAEeNCR0qemEM=;
 b=szq75Nbh8fBuBIxCjkY7DUdPwVdKlHSB1ywCSncQX9bRkJVbC00hrI742hS/V5cX3J
 uKPtaS6+sUAejoX2H6LkH3zdmSSA23KIOxYhDLWrS1CkYBLB9v/J7GcSdRm1tZb6legZ
 ymbWaQlRARCFr/oBKs1YAetAHys4EICwfOB5RawCINOPkJRHAHQfcj20+n3GVoyIqrm3
 bpflabTkYAKIPuYRUMcy3Ks65W1CH7kzBZV5Pha5doD5nCJUoQlcf/2AEz0zSG46o9GB
 YZOfpD0OpNxDZx5a5gfA9JGz9cLCjzWRH4a4l7tR9rO9vw+CDgoLhCBhjNvRD3FqvHE1
 9h1g==
X-Gm-Message-State: AOAM532DaT4xCes0Q0nHq+izUfSj3AHJnB+fGkO3m3kDg0tQTZUtOWDt
 R20jCoR1+1ZdakAFHjFXmcSjPfHUPV83PdTkrMh5uUXB7TAdj0GrIG8mAkCEsFTJbS9It0jvAS1
 Ot0nt5tC72jp3T/g0G7c8gQDsY/10NfebpHqqMLkoJA==
X-Received: by 2002:adf:fb03:: with SMTP id c3mr20643866wrr.395.1613983614628; 
 Mon, 22 Feb 2021 00:46:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxso7Sr1Tgz8UcTmO5FG5UogUyBcOr7mfqVBOmevYIAsC4BHg0yeyu1Ro/ag5hcPy9v1x+WZw==
X-Received: by 2002:adf:fb03:: with SMTP id c3mr20643853wrr.395.1613983614420; 
 Mon, 22 Feb 2021 00:46:54 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id f7sm28032616wre.78.2021.02.22.00.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 00:46:54 -0800 (PST)
Date: Mon, 22 Feb 2021 09:46:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 1/2] vdpa: set the virtqueue num during register
Message-ID: <20210222084651.rj5q2q7k2kz7h7ic@steredhat>
References: <20210220084629.282432-1-jasowang@redhat.com>
 <20210220084629.282432-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210220084629.282432-2-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, mst@redhat.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Feb 20, 2021 at 04:46:28PM +0800, Jason Wang wrote:
>This patch delay the queue number setting to vDPA device
>registering. This allows us to probe the virtqueue numbers between
>device allocation and registering.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/ifcvf/ifcvf_main.c      |  5 ++---
> drivers/vdpa/mlx5/net/mlx5_vnet.c    |  4 ++--
> drivers/vdpa/vdpa.c                  | 18 ++++++++++--------
> drivers/vdpa/vdpa_sim/vdpa_sim.c     |  2 +-
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
> include/linux/vdpa.h                 | 10 +++++-----
> 6 files changed, 21 insertions(+), 20 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index 7c8bbfcf6c3e..d555a6a5d1ba 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -431,8 +431,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	}
>
> 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
>-				    dev, &ifc_vdpa_ops,
>-				    IFCVF_MAX_QUEUE_PAIRS * 2, NULL);
>+				    dev, &ifc_vdpa_ops, NULL);
> 	if (adapter == NULL) {
> 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
> 		return -ENOMEM;
>@@ -456,7 +455,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++)
> 		vf->vring[i].irq = -EINVAL;
>
>-	ret = vdpa_register_device(&adapter->vdpa);
>+	ret = vdpa_register_device(&adapter->vdpa, IFCVF_MAX_QUEUE_PAIRS * 2);
> 	if (ret) {
> 		IFCVF_ERR(pdev, "Failed to register ifcvf to vdpa bus");
> 		goto err;
>diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>index 10e9b09932eb..71397fdafa6a 100644
>--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>@@ -1982,7 +1982,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
> 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>
> 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>-				 2 * mlx5_vdpa_max_qps(max_vqs), NULL);
>+				 NULL);
> 	if (IS_ERR(ndev))
> 		return PTR_ERR(ndev);
>
>@@ -2009,7 +2009,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
> 	if (err)
> 		goto err_res;
>
>-	err = vdpa_register_device(&mvdev->vdev);
>+	err = vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
> 	if (err)
> 		goto err_reg;
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index 3d997b389345..55a15c51e243 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -69,7 +69,6 @@ static void vdpa_release_dev(struct device *d)
>  * initialized but before registered.
>  * @parent: the parent device
>  * @config: the bus operations that is supported by this device
>- * @nvqs: number of virtqueues supported by this device
>  * @size: size of the parent structure that contains private data
>  * @name: name of the vdpa device; optional.
>  *
>@@ -81,7 +80,7 @@ static void vdpa_release_dev(struct device *d)
>  */
> struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 					const struct vdpa_config_ops *config,
>-					int nvqs, size_t size, const char *name)
>+					size_t size, const char *name)
> {
> 	struct vdpa_device *vdev;
> 	int err = -EINVAL;
>@@ -107,7 +106,6 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 	vdev->index = err;
> 	vdev->config = config;
> 	vdev->features_valid = false;
>-	vdev->nvqs = nvqs;
>
> 	if (name)
> 		err = dev_set_name(&vdev->dev, "%s", name);
>@@ -136,10 +134,12 @@ static int vdpa_name_match(struct device *dev, const void *data)
> 	return (strcmp(dev_name(&vdev->dev), data) == 0);
> }
>
>-static int __vdpa_register_device(struct vdpa_device *vdev)
>+static int __vdpa_register_device(struct vdpa_device *vdev, int nvqs)
> {
> 	struct device *dev;
>
>+	vdev->nvqs = nvqs;
>+
> 	lockdep_assert_held(&vdpa_dev_mutex);
> 	dev = bus_find_device(&vdpa_bus, NULL, dev_name(&vdev->dev), vdpa_name_match);
> 	if (dev) {
>@@ -155,15 +155,16 @@ static int __vdpa_register_device(struct vdpa_device *vdev)
>  * Caller must invoke this routine in the management device dev_add()
>  * callback after setting up valid mgmtdev for this vdpa device.
>  * @vdev: the vdpa device to be registered to vDPA bus
>+ * @nvqs: number of virtqueues supported by this device
>  *
>  * Returns an error when fail to add device to vDPA bus
>  */
>-int _vdpa_register_device(struct vdpa_device *vdev)
>+int _vdpa_register_device(struct vdpa_device *vdev, int nvqs)
> {
> 	if (!vdev->mdev)
> 		return -EINVAL;
>
>-	return __vdpa_register_device(vdev);
>+	return __vdpa_register_device(vdev, nvqs);
> }
> EXPORT_SYMBOL_GPL(_vdpa_register_device);
>
>@@ -171,15 +172,16 @@ EXPORT_SYMBOL_GPL(_vdpa_register_device);
>  * vdpa_register_device - register a vDPA device
>  * Callers must have a succeed call of vdpa_alloc_device() before.
>  * @vdev: the vdpa device to be registered to vDPA bus
>+ * @nvqs: number of virtqueues supported by this device
>  *
>  * Returns an error when fail to add to vDPA bus
>  */
>-int vdpa_register_device(struct vdpa_device *vdev)
>+int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
> {
> 	int err;
>
> 	mutex_lock(&vdpa_dev_mutex);
>-	err = __vdpa_register_device(vdev);
>+	err = __vdpa_register_device(vdev, nvqs);
> 	mutex_unlock(&vdpa_dev_mutex);
> 	return err;
> }
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index d5942842432d..5b6b2f87d40c 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -235,7 +235,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
> 		ops = &vdpasim_config_ops;
>
> 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
>-				    dev_attr->nvqs, dev_attr->name);
>+				    dev_attr->name);
> 	if (!vdpasim)
> 		goto err_alloc;
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index d344c5b7c914..702be74877d2 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -147,7 +147,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
> 	if (IS_ERR(simdev))
> 		return PTR_ERR(simdev);
>
>-	ret = _vdpa_register_device(&simdev->vdpa);
>+	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
> 	if (ret)
> 		goto reg_err;
>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 4ab5494503a8..15fa085fab05 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -250,20 +250,20 @@ struct vdpa_config_ops {
>
> struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 					const struct vdpa_config_ops *config,
>-					int nvqs, size_t size, const char *name);
>+					size_t size, const char *name);
>
>-#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs, name)   \
>+#define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
> 			  container_of(__vdpa_alloc_device( \
>-				       parent, config, nvqs, \
>+				       parent, config, \
> 				       sizeof(dev_struct) + \
> 				       BUILD_BUG_ON_ZERO(offsetof( \
> 				       dev_struct, member)), name), \
> 				       dev_struct, member)
>
>-int vdpa_register_device(struct vdpa_device *vdev);
>+int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
> void vdpa_unregister_device(struct vdpa_device *vdev);
>
>-int _vdpa_register_device(struct vdpa_device *vdev);
>+int _vdpa_register_device(struct vdpa_device *vdev, int nvqs);
> void _vdpa_unregister_device(struct vdpa_device *vdev);
>
> /**
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
