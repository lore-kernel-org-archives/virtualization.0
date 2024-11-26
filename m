Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997121DDA24
	for <virtualization@lists.linux-foundation.org>; Tue, 26 Nov 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656717; cv=none; b=s/ikiSuLq66PvncO61/ulNF8+ZcKKeR+69bVTsDPZh6hLwpa/e32JY9855jPRSxik1wvFJ5/puhTy0yw4UEJLm0laus15u3l4MTTDSz9IMWTtAZwxpnLDpEQ/VVGsFax0hHzLb+fGFOiQ6nH5FgSwiuF6/QTynD7PpeheodfKUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656717; c=relaxed/simple;
	bh=8OMHRkiCi97ruiJcLVrr97YdpLfrt/TPA63KIH/nLmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZUnoCgntBFmqA48ThQ3ANgCr2xF1J6AiNpoXxmnArTcJDGO1BLBx1qq6YMJf48B4iCLRYokZCRAq3X9slxvnuFWHmFQDLmBL1DBvRw3S31030KymWIH6LDW3BVRQPAmHPTxS6/hXdFN9ZS4Vws6EWc1LgdJZvPMWYJuX3KbhmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TH+I7DPX; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TH+I7DPX"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3273E854DE
	for <virtualization@lists.linux-foundation.org>; Tue, 26 Nov 2024 21:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fj8VCea1RZE5 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Nov 2024 21:31:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3DFE8854DA
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DFE8854DA
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TH+I7DPX
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3DFE8854DA
	for <virtualization@lists.linux-foundation.org>; Tue, 26 Nov 2024 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732656713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=xkqp9/xR3kyxpno6c2H9dhk0sKgUGZ+r9W/EPsgXUW8=;
	b=TH+I7DPXfI/L3L2ujyi1K1Ldz4qWOJbRRIaHA89c0qDBLTeeBtQYbwl+oZo7QQPMC0xTUS
	hi8xwpjV6AbrohHzHV/nMvEI5Z9fJ/9+rByaQGZjYTpVO0Gn8eM9xkW7KNu/RWRD2BTD6W
	hGSD6bl+f8G4iRWbOMtl56XUAmc/y1U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-RkeMPI1ZPkWRX5Oval8BUw-1; Tue, 26 Nov 2024 16:31:52 -0500
X-MC-Unique: RkeMPI1ZPkWRX5Oval8BUw-1
X-Mimecast-MFC-AGG-ID: RkeMPI1ZPkWRX5Oval8BUw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a4ad4798so11552855e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 26 Nov 2024 13:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656711; x=1733261511;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkqp9/xR3kyxpno6c2H9dhk0sKgUGZ+r9W/EPsgXUW8=;
        b=sCjbcujLwIrPoaEJFv9HF4Hzl8Bx6X0KAcbg/OdV+Xy0D+9pNwRjZ6p/LSiUM0UTu+
         dFHRpaU/VBvJS72T9oabQHuoUrxt11bsPUDkM8JuI0fETRnXnXGUNGUZV/W7yt/sLU8a
         q4JNI0ybU4aBx3F/xWnSrBpbZ+jCju2NqoA8WMkT5aBNyqnq7FrjeS+pzqlhN9BhBeQm
         rPZ8bQ/dewNIvXMeIpE/j5aNa/ug7O56PJlEFwg/kq5vRWhderARAKbtCnxav24v6Mfk
         xuc+c642RaktbsgdxHKqSk3THvlz9x3LIFWsXEjerRv2ntDzt5GWQUbTFs4EQONWz6BT
         0hmA==
X-Forwarded-Encrypted: i=1; AJvYcCXFnqeaQcUf2GggSbRUIJMPgGB575ES/UPh0JShkx7ct+anqLnO83FqOav9m1SunB1QGf0SJ8QEB4H3kqCVng==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwFuKQk/al+NHBRALVKV9TmGeilarCOTFF9Q0+tOOiAOPpWiI1g
	CUKM1zUXDmQ1zCwLjvV+pOui4HPfDIgR1atgbrCMCMHaXfq9LnqKuNN1gIiLRopX16tHW7blV8Q
	0sKWryWQhFnKS7mJ8vjDiqzPeVitxVyi8gD0ZEMATTwn+J3xxQaDFKBswMsdjc5VmocQGul//GX
	PqOwo=
X-Gm-Gg: ASbGncuHJxJqkRZK+iD3UtImuGTkjjcViH9xTJnBnBLkVtWbPdTHwHgGqabktf4Pqaj
	xpNQaU/OttJIjTBRG9HyXGLJHFoEZeLsArf5XoCMVYxF06uUh4gvY5WyCwNVU7ip2QNNo9v0sPA
	vaYR/+D6qp1+PySCF/Nv6uY8gW3W0qT5Hi89YsBevTAg/mLfdRIsvruJlcX98+F2LQ7PQbKSx5O
	rvMACyL42QjFOk9F0yEwMTILJCfmQaQfW+ZM5mAdA==
X-Received: by 2002:a05:600c:5253:b0:434:9da3:602b with SMTP id 5b1f17b1804b1-434a9dbc410mr6492355e9.5.1732656711120;
        Tue, 26 Nov 2024 13:31:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5nabcDgZfdqXrFryICIVujIiggOe3vuLNf1LLX2fotJEhYc502dQloNv4ULPkl7YTJzP9XA==
X-Received: by 2002:a05:600c:5253:b0:434:9da3:602b with SMTP id 5b1f17b1804b1-434a9dbc410mr6492185e9.5.1732656710752;
        Tue, 26 Nov 2024 13:31:50 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:4654:4e59:b33:d0e:9273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78c202sm90855e9.26.2024.11.26.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:31:49 -0800 (PST)
Date: Tue, 26 Nov 2024 16:31:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	colin.i.king@gmail.com, dtatulea@nvidia.com, eperezma@redhat.com,
	huangwenyu1998@gmail.com, jasowang@redhat.com, mgurtovoy@nvidia.com,
	mst@redhat.com, philipchen@chromium.org, si-wei.liu@oracle.com
Subject: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20241126163144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sa-foHCffE7s7EyKxhXqrG2f-Lnc8H3OVlX4mG-DRG8_1732656711
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I was hoping to get vhost threading compat fixes in but no luck.
A very quiet merge cycle - I guess it's a sign we got a lot merged
last time, and everyone is busy testing. Right, guys?

The following changes since commit 83e445e64f48bdae3f25013e788fcf592f142576:

  vdpa/mlx5: Fix error path during device add (2024-11-07 16:51:16 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6a39bb15b3d1c355ab198d41f9590379d734f0bb:

  virtio_vdpa: remove redundant check on desc (2024-11-12 18:07:46 -0500)

----------------------------------------------------------------
virtio: features, fixes, cleanups

A small number of improvements all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Colin Ian King (1):
      virtio_vdpa: remove redundant check on desc

Max Gurtovoy (2):
      virtio_fs: add informative log for new tag discovery
      virtio_fs: store actual queue index in mq_map

Philip Chen (1):
      virtio_pmem: Add freeze/restore callbacks

Si-Wei Liu (2):
      vdpa/mlx5: Fix PA offset with unaligned starting iotlb map
      vdpa/mlx5: Fix suboptimal range on iotlb iteration

Wenyu Huang (1):
      virtio: Make vring_new_virtqueue support packed vring

 drivers/nvdimm/virtio_pmem.c |  24 +++++
 drivers/vdpa/mlx5/core/mr.c  |  12 +--
 drivers/virtio/virtio_ring.c | 227 +++++++++++++++++++++++--------------------
 drivers/virtio/virtio_vdpa.c |   3 +-
 fs/fuse/virtio_fs.c          |  13 +--
 5 files changed, 159 insertions(+), 120 deletions(-)

