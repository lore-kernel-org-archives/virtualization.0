Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A471F3D56
	for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763279124; cv=none; b=p9EtQz2Th4jbiLWqZVhGk1qg9StSQVyQneYyNiaoEDYhyn7yc6Z2y6TTVNiUJKbX7a4mEmlVEYQ8+kbM6LFDzLkFN7NejGMnHxY5utlZQi/Gq1s3j3RjXdBm4SsTXqgPVlfRRVq4ygWbIkDCASH8V2LU8H3caGfUpt43mHm5+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763279124; c=relaxed/simple;
	bh=YVrAdAzCc2XLQIIceUnkGGP63U/MW+iwXEhmvrkh+/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hw8ps4trbvo+o7jqhk5PrmONeWghdMTDlliIaIySPfPK2UY+dX3PmmNbfp9loWtt8pp+nsvG5ksCekeWgzPFhX0G+EUvovRu1CLreClvNhkAzdO8OlhmJwIMaeyTJVVdnCMglojbvyb6XkQWZ5ufrO2azxRY2u2X4LgSiTDQRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW83ZUhC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW83ZUhC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763279121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6EMg3NX6c6HdI7rjPLbQWwYtnFdehdSrlUN2EHSpFLI=;
	b=NW83ZUhC98ACU+mAkr7+Zc9INZMIpX/m4RD6qEv9HTLdjXGznAX0lmMl66olpTWHnvXekT
	3URgRUr7pWWgPPkRQWDnRtx7/4c0CydBeDz/HrlhTxuMRa84F4loSG64DUlcKgHJVXuGbK
	xBv3ZvFFDJ9sq2r9QcYGSAsUb4ynuPo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-OGXL71T1P3O0iJsVA_n7hw-1; Sun, 16 Nov 2025 02:45:20 -0500
X-MC-Unique: OGXL71T1P3O0iJsVA_n7hw-1
X-Mimecast-MFC-AGG-ID: OGXL71T1P3O0iJsVA_n7hw_1763279119
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so1238061f8f.2
        for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 23:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763279119; x=1763883919;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EMg3NX6c6HdI7rjPLbQWwYtnFdehdSrlUN2EHSpFLI=;
        b=C+VefgnSHA6CSBF+HwgxW/uvjkvCIpe0eVFaETnsl8SuSsOsViUX+mVmku/vov6xBy
         YsmbtBO2a5eXP11uREwKnenILc6lAVmXa1BQyh9ax9bF5zSK/duGyzg/5hewGJJjdmRy
         /UC3x2p535+KXLl+egx8r24ZhL+7e/GO0xrfNfm2CMRxlnSOFLYQCTFFvWWqladKhjk7
         Ck9t3FmX+YqQguNjrJ7eZ38sQ5zQ7f0oh3nrUg3m59FdXedbyVfmRUoIk/mUs0ZaLPhL
         V7DqQfeAtRjyAUPPgBCs0Z4WKqU7JlDc3zzhJHfyWFGL/4BU87oKMT6a+oDmGDOYO7f/
         cHCg==
X-Forwarded-Encrypted: i=1; AJvYcCWGTGvf57MUOUBEoU3dXJEvY1blLINVZwu7TxVdPzLpSGDP36QVrQuboLZasfobl97TQNwjptOFIQIENUwIlg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8Ng9PvPQ0KN9SczzuEPf8MiTjGogtA9YbR9WvywhiF4Ph2XDW
	bn+Rh0R0SMmlsbw4jIwgFv9ErBMj/wWf7tVOV4/nDtR1Kpu8/hEhCGfMAKV2wT0OZUswayzobec
	79b7QHajX0I4vqL+t0AN92FsatCi/VbUyOpwkvsmkmXN+JgBiLyIgBfZZfAXkphWsm0wo
X-Gm-Gg: ASbGnctjHWF4l3bq9eO4xWNTf0vK2H1ITQhW+wQBFJPCwc1dCnLmVk3GYptIgIGVqt+
	WhndyqWQugye5L0soT1EIrrMNPWmUJLPuTz0xumjp5f78cvgi3cwmL8Xg+orz1qIDz1mdIB7s3U
	YxXKkyPFbXmKAKYj/ti7hfK2kEiOpkV8EkoP0ZutjKSOx8QOh4xH7/gIyOJ4dGuq913m1szEqr2
	9gvA5p4c6+JYYl89rCcSA0Ikgk+uyxXLkE1l1oTGwiva90Ejl4Cb+Cc8Yu9tC+yMZRxJKGh6TSX
	8qffpfzoAbAd83b+gnpGXUU83LsHEKnVYCKD/h1iQMLBSiUOotD6PIgsV2QRCvC6MgNSKmpmDEV
	BYMCx4Y2rOleodPI8XsU=
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4778fea8ab2mr86894015e9.33.1763279118957;
        Sat, 15 Nov 2025 23:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm2k2Zhl26gIjz/7McugHmf2Kikp5zoKyp0v+rWLB1S2WlAgfk8AyjDIjgk38rvSQc724vmQ==
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4778fea8ab2mr86893775e9.33.1763279118556;
        Sat, 15 Nov 2025 23:45:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779a684202sm64265025e9.10.2025.11.15.23.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 23:45:18 -0800 (PST)
Date: Sun, 16 Nov 2025 02:45:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 0/2] virtio: feature related cleanups
Message-ID: <cover.1763278904.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1EmY4L_t8f26D3qngFlePv4NDYKu5m5mIEICTdWH7ks_1763279119
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry about sending a bad v3, there was a chunk there
that does not belong at all.
Lightly tested.

Cleanup around handling of feature bits:
- address word/dword/qword confusion
- simplify interfaces so callers do not need to
  remember in which 64 bit chunk each bit belongs

changes from v3:
  drop an out of date unnecessary kdoc parser change

changes from v2:
- drop unnecessary casts
- rework the interface to use array of bits not


Michael S. Tsirkin (2):
  virtio: clean up features qword/dword terms
  vhost: switch to arrays of feature bits

 drivers/vhost/net.c                    | 44 ++++++++++++++------------
 drivers/vhost/scsi.c                   |  9 ++++--
 drivers/vhost/test.c                   | 10 ++++--
 drivers/vhost/vhost.h                  | 42 +++++++++++++++++++-----
 drivers/vhost/vsock.c                  | 10 +++---
 drivers/virtio/virtio.c                | 12 +++----
 drivers/virtio/virtio_debug.c          | 10 +++---
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++--
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 29 +++++++++--------
 include/linux/virtio_pci_modern.h      |  8 ++---
 12 files changed, 113 insertions(+), 71 deletions(-)

-- 
MST

