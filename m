Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A573D6689
	for <virtualization@lists.linux.dev>; Wed,  8 Apr 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661674; cv=none; b=HHuxMOPDkCRzPOhcO2PZIVjN+rMwgk1awfVgNOc0VLZuBfyxGyhwMH6xpsYccNPIwP+08xlYR5DzkG99FfDLAKO2e5r8kLZEeg/MbjjSj4fF9+S5E/iuZparwIz8CgOVxXFABNwK/04XusPyDiKgc05t0jObz6AEeQHRaTuBEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661674; c=relaxed/simple;
	bh=JWryo19XSS+EbbXgCTnUDuve7zD+psGcWk4bJFoTzeQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=hqcOchWQ3LYv4HpR6wFMXv8Oi8/i77d0L7Nhgawhxm2JGxLZWBgmuXVECMaR3YI1vpWC0Re2k87kvObWkdCX3nVPaEkItW/HoHhbWuGzlnrs8P5HykuMKmpPpJNtSYbAqOXP9uJ8wTEYUAVOdrw0oJewkMiOwPCIqByn8mNXGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUVA/nJp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUVA/nJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775661672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bxgs/94flkc5gzjvGkdrpP39nvy7O6M4eR7c4f7iyik=;
	b=PUVA/nJprJlfjN/WzEEye+0DccBziq5C6VmMdZW0TiY3Wnv7G371QNK0x3dtB8tVJuJ1L0
	jCBVxBKzYy+z/3ERJ1SFRhX+8N21pdYfOUcWy/P631mwXWHkyXHBJ/fnHFThF6qOz9rQKS
	hSGqKlyiNQEJpn2RoYGfCyokIG9uGTA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-RKfzaqydMduLV6miVZhwDQ-1; Wed, 08 Apr 2026 11:21:08 -0400
X-MC-Unique: RKfzaqydMduLV6miVZhwDQ-1
X-Mimecast-MFC-AGG-ID: RKfzaqydMduLV6miVZhwDQ_1775661667
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43cfb72377bso4325556f8f.2
        for <virtualization@lists.linux.dev>; Wed, 08 Apr 2026 08:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661667; x=1776266467;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bxgs/94flkc5gzjvGkdrpP39nvy7O6M4eR7c4f7iyik=;
        b=HuQHAHMJDVRg7f2D5B5LWrMSvVLBKWRF8UvOxWMWHTinAzCZz8lnX4uEFpLalOPXAe
         /d3BadWhbi0HXWLSSvk7DEMAH/CWm9e6n8ZT9ASa9uA4hbeGQYDa+IDdwrfnCo5fxKdN
         1+4aLax91/ZqJWOdDoaVO7pzNVP4LZmLn3nT2Bgmrz1h5YLaNRoZBkWQ5C/ggyIcNL+P
         LSO5pGhSuw4Ohqmtnncjx6qsXKIUcjcuNY8tABG7odXPshgf+vQnYSOIMt2D1JKLN5F6
         EotIVwL4pQG8e04J4kOtnqKf2z3zx4KcocjpAjz93/5FeKii6Ho9NOoPgWq9hbL+1aD8
         ZgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzAMFEWVQlL2PSHiavex+AMxlcMLpwasigy8Kj4PSFiDDAeQf6ZVXve2TO2vfa6kHJcsO0/F6NNxSMDciBdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsLQBnbQPDbh8gPb2i01BrK3TPPBIenIpiJKQ2rvczL7qK7YTH
	ePP5sMUMjUflorKQ99fchJZek3oc15KrmELnjmDLfdh6qWjPFLCgicx0BFjCMS6BxmuFG4/c0bc
	6ISXbfxJDFlQJm4VAin9DPkSRzjLTuX9deZpYgwitqTt3Du9NGWBrILdIIkg77gBDp/wR
X-Gm-Gg: AeBDievxG5FjT9pzDnfmbOUWNduBlFn3MHA80DuHx9uCCqIEyRJD7rKUFFsXOwWg0ey
	fmMeoJkBsZh/0oeMQ4hNPb6Pxk0hw28tkljnuNheIStJuDkmkH+1XG8OJKtRtOQbtjhjX57futQ
	+1DDHrFMfgpgFdgCUrlm/Q1nG0YLFaWJfjdrAvpLQNqV+PKRInWXC6PMb/WNh2nRNG8Pis+asz0
	B+TNFz2kL34LcS/OYkwMSvlJCeBB/9Vopqe5xz0dFFlzrZKxqovRodxp7jI3aaki/eruDDBCqjP
	SWP8v3PuJ2dYFA920hBai8ptn+KIUfTknYL8lxOAndQXVZaPLrd2uJJ+gi4KeUtyHeoO+FtXqHi
	nB68SD4pvb7tyWZxbnVVrRJNhy7gMWmoyRG/U8HcKWzxcKxwO17XrAt+NxwYV
X-Received: by 2002:a05:6000:1842:b0:43c:f3c9:3815 with SMTP id ffacd0b85a97d-43d29277055mr30965427f8f.3.1775661666624;
        Wed, 08 Apr 2026 08:21:06 -0700 (PDT)
X-Received: by 2002:a05:6000:1842:b0:43c:f3c9:3815 with SMTP id ffacd0b85a97d-43d29277055mr30965363f8f.3.1775661666078;
        Wed, 08 Apr 2026 08:21:06 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm60446899f8f.21.2026.04.08.08.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:21:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 08 Apr 2026 17:21:02 +0200
Subject: [PATCH net-next v2] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQqDMBQFryJ/3ZQkimJXvYdISfVZszCRnxAsk
 rs3uO9yGN68kwLYItCjOomRbLDeFdC3iqbVuA+EnQuTlrqVjewEY/MJr92w2RDBYmmVqdHIaek
 lldnOWOxxJQdyiMLhiDQWs9oQPX+vr6Qu/z+blFACfaf7upVGv/FkzKuJ98lvNOacfz4Fg2q7A
 AAA
X-Change-ID: 20260407-remove_parameter-f61a3e40cf90
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OPkmEauGAgveLXLJD6vOZcCqtpNAZrXdkJAgDsxSgdk_1775661667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`virtio_transport_send_pkt_info` gets all the transport information
from the parameter `t_ops`. There is no need to call
`virtio_transport_get_ops()`.

Remove it.

Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Removed Fixes tag.
- Picked up RoBs
- Rebased to latest net-next
- Link to v1: https://lore.kernel.org/r/20260407-remove_parameter-v1-1-e9729360a2be@redhat.com
---
 net/vmw_vsock/virtio_transport_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..a152a9e208d0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 		return false;
 
 	/* Check that transport can send data in zerocopy mode. */
-	t_ops = virtio_transport_get_ops(info->vsk);
-
 	if (t_ops->can_msgzerocopy) {
 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
 

---
base-commit: 4c2ffb3ea8a601bb3730754cfaa433e673037cda
change-id: 20260407-remove_parameter-f61a3e40cf90

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

