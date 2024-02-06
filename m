Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E413248D
	for <virtualization@lists.linux.dev>; Tue,  6 Feb 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231124; cv=none; b=f7UfCmcIk/2fNzsG0ctR4oRcnMhXk6uLHJjXnqri5SkIMSnJcb/DrxaVrVwhvTrzym5BPsWsrVfSb08rtv4ifOPI8nOtlkU5EiNqepMjWlrcYSrwQZtX7vNQ0zTnhVw/ywNKYDBHRCNg1RNvLUNPYaknNv4dV6bUJPc4pLeNtXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231124; c=relaxed/simple;
	bh=R/o5EP7C+JnoxFgZaYwDA4ls6GyyKFxMVhJAZddFp0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=KEovYWJL+ytbNx2PgZ7xKQJm6lqM4o58HtaeTtk5FzgzvuHBiwUI/+Zrl6EJ0FzoAF1BxwH/ze2vEEQcsYo2rP7knAVg7/lvE7d9ynr2IzUyoVkSNwyIK9LtdcbE4BKnqVZj+aNVgbxoVL5CRQXshXFwmuBC90It0JPhYyPvIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3GtIuNc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3GtIuNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707231121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dQIKoNOJmX8VRVk5/I0n1vx+OMQlaoxl3aigw5zkfn8=;
	b=M3GtIuNcrkaLuuKbLsufc6LHzmQaCS1Vng0oR0emc4pYP4QmdfgBquDU3joazvUwgIBFjO
	c6Le4uvu9V0j4CDfQVaw6anOuOh0WPfCK2ABKCjS0FPXxp2T+J+CWj00rKwNNObJumnmPm
	nWJQUv4WyRCxwKPnxkTLN10MnHNa/ho=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-1mfweWDJPwSxGJrrFtxyRg-1; Tue, 06 Feb 2024 09:52:00 -0500
X-MC-Unique: 1mfweWDJPwSxGJrrFtxyRg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-219688c2d4cso4232901fac.1
        for <virtualization@lists.linux.dev>; Tue, 06 Feb 2024 06:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231119; x=1707835919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQIKoNOJmX8VRVk5/I0n1vx+OMQlaoxl3aigw5zkfn8=;
        b=IzHu9RbOMcxVhA+3p85soFze5UmoekfhHIdci1XXf1OVGXsdPGf8+OKdlbI17YoeBV
         UaSgxe+9zjn2B/e7goVX1EU94w5ui9Um6Cc71zmBJNFvxYauUkgvVi/xCtsfoKS3LB39
         aFQTZYRF1GSPj8HfHOk6S73zPlwmSsl4+6NwGMWL5KjsgZfNsqWNn/pW705KC/5XAffD
         A6VewjG8j5sWYbqSH0mafQPzOCTMwll3FCMyiBphe/Jjxvm9axU+aJ9U4/GZsfIQ/ULE
         ZoowS2maT+IhfynIgDWe5D87XRfDsS5IT3b2ebAk9CvG23TEHRvx8zFhv8uXQbpuLTnt
         X+eQ==
X-Gm-Message-State: AOJu0YzhGwCczixUMvRNpf3QeauMaEiqvaMZ56hsOiqvdxbdm9U1zSWL
	B7hyCFNU0KlPi2pYYeKfe9aG4ekOYgdCmkdZY0/hA06h1v2KBgf5COLllDdCQs4Sjo0FSSvn/Ti
	B5MIrbcX0r/L8KuQFQqpsMGlB396FYQ9QWw+7t6IXwLPphUlbrDbIh819spiNHC43fE+YPsHkTr
	wrX12p766pZ6ECVu+2lYyI5JM/Qyv9ENQwAkL2AoDtEN6dxr3v
X-Received: by 2002:a05:6870:164d:b0:210:8802:786a with SMTP id c13-20020a056870164d00b002108802786amr3275752oae.53.1707231119025;
        Tue, 06 Feb 2024 06:51:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLCyho5u5y4dZMOsWQV1AaVbjSFpDdh6YZMYgsdjNzX2ck/ywfHH/5T/kc/2KHsZrayoPM0A==
X-Received: by 2002:a05:6870:164d:b0:210:8802:786a with SMTP id c13-20020a056870164d00b002108802786amr3275728oae.53.1707231118721;
        Tue, 06 Feb 2024 06:51:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6YVTF3BXfxD7oGuNc/5i4fJi9lzUP0v2EuV9vQ2uYj3WVgVJCvsEX8TROSCzAqDs5ebrmUOfU/S/j7kp3jXPim8rxZSbJKSJVXStktmV2oqMTXILCaFK8Q7/Dm4SdzEV1oi2ax7XvIFESMcCV8iCOJSstM1x0ffCK9wzkBPAe4UiZZyES5vihMsa0sRYoqZu0wDySrdl+bWTxhpQjZZsre7Rw5ZHednIiXPP1W399e2EE8jsT8XU9D+7TeQhQE87br0/am75tATSNqLHpbPwm+dZTE8klIcCGRw==
Received: from step1.redhat.com (host-87-12-25-87.business.telecomitalia.it. [87.12.25.87])
        by smtp.gmail.com with ESMTPSA id k19-20020ac84793000000b0042a9b28733fsm930742qtq.89.2024.02.06.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:51:58 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Kevin Wolf <kwolf@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-vdpa: fail enabling virtqueue in certain conditions
Date: Tue,  6 Feb 2024 15:51:54 +0100
Message-ID: <20240206145154.118044-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

If VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated, we expect
the driver to enable virtqueue before setting DRIVER_OK. If the driver
tries anyway, better to fail right away as soon as we get the ioctl.
Let's also update the documentation to make it clearer.

We had a problem in QEMU for not meeting this requirement, see
https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.com/

Fixes: 9f09fd6171fe ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature")
Cc: eperezma@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/vhost_types.h | 3 ++-
 drivers/vhost/vdpa.c             | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index d7656908f730..5df49b6021a7 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -182,7 +182,8 @@ struct vhost_vdpa_iova_range {
 /* Device can be resumed */
 #define VHOST_BACKEND_F_RESUME  0x5
 /* Device supports the driver enabling virtqueues both before and after
- * DRIVER_OK
+ * DRIVER_OK. If this feature is not negotiated, the virtqueues must be
+ * enabled before setting DRIVER_OK.
  */
 #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
 /* Device may expose the virtqueue's descriptor area, driver area and
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bc4a51e4638b..1fba305ba8c1 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -651,6 +651,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	case VHOST_VDPA_SET_VRING_ENABLE:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
+		if (!vhost_backend_has_feature(vq,
+			VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) &&
+		    (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
+			return -EINVAL;
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
 	case VHOST_VDPA_GET_VRING_GROUP:
-- 
2.43.0

