Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6E3B6346
	for <virtualization@lists.linux.dev>; Sat,  8 Aug 2026 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786185270; cv=none; b=LGlAUaEIvhsKcqP06e+6wF2urtsZBXM0eQBX3CRrOSmlo9v9lmIATz+v1RaM8P5VzdxTQK/FZBFmZw0zNXqGij8CbttbeMW16N0iGnzU3vS2WhJjOjcM4w1Ad+maqeHGaJWytaCaYHBF5powXeC3Y6g3/GraqJg2XblVgT2dfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786185270; c=relaxed/simple;
	bh=8cLsyOrjXGvoCCKeyA9EG98ua8ktDWJeJNjwpR7WQKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQUVe/GihfP0Dn8nxiRYAjhW4dohf1l2Jqiwp4MtLl25pWDoL3SCI/l8Di4jwwoN8JdIuuLAdxsiZZoAT7sMmW+CSgjIHKPpyOiqUHgQILK3OlRaVe6yeVm7HwlIgwQnvuhPYiN7e80yM1p4ch3nqwIVgtgQqKUEMLyOAScTY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbpH3GFq; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbpH3GFq"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e7391839cso306184a12.0
        for <virtualization@lists.linux.dev>; Sat, 08 Aug 2026 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786185268; x=1786790068; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMt2HBv95FWkEezOYc96XrHhu7tFutq5B2cwfp/ralY=;
        b=nbpH3GFqqSU26kl02uZLKrcwZ8pRwT/OcH61ukg23uWeBhZei6q1eM3w71fM4dhFWI
         XctBM9JfZurgHMX3OCIH7jPC0WKxZJwAi4wNhEqruPt8mifDV0EpR4gBLzHERhZYS9y/
         3r+47gQ4uawxw4P66qvvk9afl34FDDljFFSabFzStPMPpdsmROXP0bCcY3NS6qoxWW/T
         AHROc70foUi5Ld08F22XjGKJuR7SomIAAhxyfQcQa6HPK0ff6RXEvTUxI4JMLlxvbePu
         NflqrbYZjo3XppYszDdQQZ9700aijbUZckcKlOSxV1RN+GLv3dHvQH5YW24RSUp/C4al
         PJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786185268; x=1786790068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMt2HBv95FWkEezOYc96XrHhu7tFutq5B2cwfp/ralY=;
        b=LRqjuhYeXPj5sLx6VnyZz1PkngwOuYeSjJLet7L2MzTEnUzdBcLrvREawvu4oK2tR3
         WPolwgYpsUBhhpjNflO+CaNsRVkJ6lWxBsGtlD5edUVD03GY8n1t+wp0ro9sy7FrXY1X
         PPDQ/fXm7WRVxCC56kkMh65BB0/EmZirPJ1FZeBAYIFptCEYd67AnPOrZoHTrNGw2kBu
         Hf+sA6ThbqEF0eDRC4S/N/G61DPvj1cUs53a94qQYvZq9IsjI2b6UPrcBztIFDY7i9f4
         y+E2NHRwKTYmU3ovDuHvUvjlr+QL3p+4NuhU9KoKOuBYnZqWptCNti/FWfAepfQRiIe4
         2Qfg==
X-Forwarded-Encrypted: i=1; AHgh+Rrx4zwRfpfQpamwDprz2RK13XwJhj7E0XakjGsRUL1L8DNE8L726/8J1K/y4vG0UpqNPxLbY3slwV+HZro6Dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiOGugaV946a+wX1U7CzHd3CMHZcASPS8jpBaG2Xu3HU9uJkiL
	FQaUKyXU8IgMWDMwsZyoL42HNaDfjLTh/b6RdKnDu0Xqk7ESuEnLQ0zD
X-Gm-Gg: AR+sD10knyqpcjznNjFS3zS68/ezFA1Emx0Yugu5H3AH6YlPXd6scPACFQld0bDHLtb
	8H4AdMEWhLr0Fl03F/w9CDOT1AnkAEbJhohFewp88edUMsUdgaK/nIHefFKLJGr24z3ZT4CSodO
	8+kpG9siLFclyTwE+EmnvuokO4L1h87bV+1o7gxwgCBLt2+jlvTbrAFyLAp0IXA3zJO8lffXT+v
	jgxIkwGB0pGGHVyB5dfXZskzsyQJs2c3pBHtW6co7uHdd99Gh8/r+HCns2+RTcbwZnxI9yXl4hc
	/U8iV6kQ29sQuJPFC7JGOMhVfCqqxU5BdJnJDoZpICKz2I+yLRbCeptH6OV+6zJgaACdZhyqq2J
	ZSM0fqIIWAEzffGRM/psvQPGmBPyjCNgXEi/iSavCVLD2Niv80KilJw7uo0MgvNQEKGlNJrns3f
	cCXJdAlYfKDFF/gNl1JAITDumZD7xlvloGkIZsdzXN1J7hXRn3eusF0qZdyQDhpZh8GJQTTuY=
X-Received: by 2002:a05:6a20:3d0b:b0:3bf:b1d3:393e with SMTP id adf61e73a8af0-3cbc01011aemr11771109637.2.1786185267762;
        Sat, 08 Aug 2026 03:34:27 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86d3fcsm18060034eec.4.2026.08.08.03.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 03:34:27 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vdpa: reject VRING_NUM larger than device max
Date: Sat,  8 Aug 2026 18:34:15 +0800
Message-Id: <20260808103415.101261-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vring_set_num() only requires a non-zero power-of-two that fits
in 16 bits. vhost-vdpa then hands that value to the backend through
set_vq_num() without comparing it to get_vq_num_max().

A local process with access to /dev/vhost-vdpa-* can therefore set a
queue size larger than the device advertises. On the vdpa_sim backend,
the worker then walks descriptors beyond the mapped descriptor ring.
KASAN reports a 16-byte out-of-bounds read, corresponding to one
vring_desc, in the vringh IOTLB path:

  BUG: KASAN: out-of-bounds in _copy_from_iter
  Read of size 16
  copy_from_iotlb
  copydesc_iotlb
  vringh_getdesc_iotlb
  vdpasim_net_work

Check the requested size against get_vq_num_max() in
vhost_vdpa_vring_ioctl() before calling vhost_vring_ioctl(), and return
-EINVAL when the request is too large.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
---
 drivers/vhost/vdpa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa0d0..b2083e1ef150 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -716,6 +716,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				vhost_vdpa_unsetup_vq_irq(v, idx);
 		}
 		break;
+	case VHOST_SET_VRING_NUM:
+		/* Reject sizes above the max reported by the device. */
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		if (s.num > ops->get_vq_num_max(vdpa))
+			return -EINVAL;
+		break;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
-- 
2.34.1
