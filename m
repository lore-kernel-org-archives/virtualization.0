Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295617B505
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323808; cv=none; b=qI2ouj9VEvGmI4VUumcB3PPDC5l5JkWvtffxGD0QDzNCkJjFLO3zdrD/4CG2lXTrUN38jx2xcTjCecoynSyIr0KTkpHOnytnlIOEBMujq4qGaWQcvhImy+OE3w56rN/qXF0BWYHcLfZEsQoKleSXSx5AJJ8pKqmYjf5pZgIGCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323808; c=relaxed/simple;
	bh=/UNLEhTBAnch36SgaK4rfVGlQTG/rEakKekLFDXlBQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upk4C7vAAWZw0VWJDLwbUzFwO4PoActwh5nyOJsbppo5aIMZrDoqC8NwoTtlROOUiVWK+QSJ9OWxHFfDJzlj9Cny9bxGUmwqAg8X/jG/O4WMYr6USkUu6nosDJSNZVrMm7Zq8fKTmEFhIwXSgr4tvs7O6wshIZMwKyT/Nq6doOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhT5Oxgj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhT5Oxgj"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e88b60121so1094631a91.3
        for <virtualization@lists.linux.dev>; Sun, 09 Aug 2026 18:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786323807; x=1786928607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbbU/F/djf22NMRk+tFA6K7hMv5blZDiEPyCufD11oE=;
        b=FhT5Oxgjqwg2lWE4qiJyc/Ok2p3R5Ef+jz7+MPeBEb8PiBhwdmF7H0IIHRtSmrhEsc
         a9iif8xr1QAH6BSyjFHO81/jjBd4CTtYeAOooq3nEC3Pehe4PZLrOn52e9NHe+XhQ6Jq
         KG1Tzm00qZy/Db/EF7CxiKr/g7EchASPQKXqNWK/hP30l53OIpnkmAb1p/E4JVaHONrM
         P71+ar+jfQPmZ4NISLggLkb2KDTwhTreHeZnBNohFWJJdt25Bym5VfZv07CeBY+P97KW
         n0Xm8YCf+Yqg9qH1xbhQKNTX8QOaUSFwIalZrqTOVNO+0djSGHgY7pzaugHKra8qrpwD
         I2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786323807; x=1786928607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbbU/F/djf22NMRk+tFA6K7hMv5blZDiEPyCufD11oE=;
        b=jldxGCOtT/VtVzmo6JqNYVwVgMftUy3YCwCRXYRN5VgmXGsx8z7ykJxAiFXKBjEtkD
         ghG8AIiLOIRdCVC9A2z0IpUdGyvgVmKkWCGNCpqPllzlkS+S2JwPu8iI5vQFyum6Fo0r
         LtrW5BGtIkwJ73u6ixMIHBpVsBiZm88GEq6mJsBiUphYlsDfIWpoc+UryM54Gwkk5jjZ
         rKXR6wh5SpU2HvxtmHEj1qSsSuy+kBXNuIs5rZ3zpQpKB1vX2UeMGiIk065MDOhf1SGu
         5OL7kNXDRg09hMVxwPGJTs8LccDDySXvhfuCvowoGbiic/fTX+vTHOafFBiKZhQHOXzb
         quzA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9G9k/+CyBN+owMZSmDS7UB8KsjsPKyVyNdur+oGV/KtWp60lLVdL2k70LwBiyfWIm0kck7zTR7bvZ6XNGyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh96fjeVexk8vP5Tfqb7AIR7EEemJVsh+sXHwJfIBPcuGFZVJ2
	1h1lUcyu1Aib3GT2yaNnEP8mDwYG2JEORe7/1TsU0HEMByr1BA+qFoC8
X-Gm-Gg: AR+sD13i37bFhTdjRAZQW0HMlMCe1dNpqIFGLo82C13Xow3NkNl3sr1LI6erTH9pi9t
	j8ofNwQOH1tVlEcSdql1KMHeX0ATpvI9l9AkzFfi0641eYK7mUSgx/xQzxq6hxPk+h9I9ee6HQk
	O40A/mqNVY0BUKXVZms0+2Bz3EOKkKeD68rWVmzCca6byU3a8nya0LWtEU3GR5pbBBQc4JaBn62
	aLG0fGHfrcX4JNiTBmU0SbQ4M7nYQ+66RZAexH9eO+WGW52xbDav2dhK6JOgZTZd7rsFMqMfYKV
	y9w3xo4xum0DtMHV5OUWnaz9yl3frJwnCwPtsgTGgZOHyL1DWdHXvQsRJyr3uEROJgwE81T8Gpu
	MHbpeD/kR5VQXMauCZdfpE7oLncC6K8MSjzQKXl25z5R8lUs7ZCslpI/DqnW6K0ZK5Fgwrep8XC
	BVrXgKrdciXlmyHs5N0YOnScgKAG0TBWb8SNbVKB3RT89syLqXq1CSRn0y3jU=
X-Received: by 2002:a17:90b:4a0f:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-392823340e5mr16894066a91.5.1786323806331;
        Sun, 09 Aug 2026 18:03:26 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff64b1dsm10138275a91.13.2026.08.09.18.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 18:03:25 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] vhost/vdpa: reject VRING_NUM larger than device max
Date: Mon, 10 Aug 2026 09:03:00 +0800
Message-Id: <20260810010300.132959-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vring_set_num() accepts any non-zero power-of-two queue size that
fits in 16 bits. vhost-vdpa then passes that value to set_vq_num()
without comparing it with get_vq_num_max().

A process with access to /dev/vhost-vdpa-* can therefore configure a
queue larger than the device advertises. With vdpa_sim, the worker can
walk descriptors beyond the mapped descriptor ring. KASAN reports a
16-byte out-of-bounds read, corresponding to one vring_desc, in the
vringh IOTLB path:

  BUG: KASAN: out-of-bounds in _copy_from_iter
  Read of size 16
  copy_from_iotlb
  copydesc_iotlb
  vringh_getdesc_iotlb
  vdpasim_net_work

Cache get_vq_num_max() immediately after reset. Some backends derive
it from writable queue-size state, so querying it after SET_NUM may
return the current size instead of the device capability. Invalidate
the cached value before reset so a failed reset leaves SET_NUM
disabled.

For VHOST_SET_VRING_NUM, copy the complete vring state once and use
the same index and size for validation, vq->num, and set_vq_num().
This ensures that validation and use operate on the same copied values.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v3:
- Copy VHOST_SET_VRING_NUM once and use the copied values throughout,
  avoiding the double-fetch race in v2.
- Cache the device-wide maximum after reset so mutable queue state
  cannot break a later legal resize; fail closed if reset fails.

v2:
- Add the missing Signed-off-by tag.

 drivers/vhost/vdpa.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 692564b1bcbb..f2eedb0464c2 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -53,6 +53,7 @@ struct vhost_vdpa {
 	struct cdev cdev;
 	atomic_t opened;
 	u32 nvqs;
+	u16 vq_num_max;
 	int virtio_id;
 	int minor;
 	struct eventfd_ctx *config_ctx;
@@ -229,7 +230,9 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 static int _compat_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
 	u32 flags = 0;
+	int ret;
 
 	v->suspended = false;
 
@@ -239,7 +242,14 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
 			 VDPA_RESET_F_CLEAN_MAP : 0;
 	}
 
-	return vdpa_reset(vdpa, flags);
+	v->vq_num_max = 0;
+	ret = vdpa_reset(vdpa, flags);
+	if (!ret) {
+		/* Some backends derive the max from mutable queue state. */
+		v->vq_num_max = ops->get_vq_num_max(vdpa);
+	}
+
+	return ret;
 }
 
 static int vhost_vdpa_reset(struct vhost_vdpa *v)
@@ -641,9 +651,15 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	u32 idx;
 	long r;
 
-	r = get_user(idx, (u32 __user *)argp);
-	if (r < 0)
-		return r;
+	if (cmd == VHOST_SET_VRING_NUM) {
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		idx = s.index;
+	} else {
+		r = get_user(idx, (u32 __user *)argp);
+		if (r < 0)
+			return r;
+	}
 
 	if (idx >= v->nvqs)
 		return -ENOBUFS;
@@ -652,6 +668,23 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	vq = &v->vqs[idx];
 
 	switch (cmd) {
+	case VHOST_SET_VRING_NUM:
+		mutex_lock(&vq->mutex);
+		if (vq->private_data) {
+			r = -EBUSY;
+		} else if (!s.num || s.num > 0xffff ||
+			   s.num > v->vq_num_max ||
+			   (s.num & (s.num - 1))) {
+			r = -EINVAL;
+		} else {
+			vq->num = s.num;
+			r = 0;
+		}
+		mutex_unlock(&vq->mutex);
+		if (r)
+			return r;
+		ops->set_vq_num(vdpa, idx, s.num);
+		return 0;
 	case VHOST_VDPA_SET_VRING_ENABLE:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
@@ -765,9 +798,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		ops->set_vq_cb(vdpa, idx, &cb);
 		break;
 
-	case VHOST_SET_VRING_NUM:
-		ops->set_vq_num(vdpa, idx, vq->num);
-		break;
 	}
 
 	return r;
-- 
2.34.1
