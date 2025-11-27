Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C5221DB6
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764225636; cv=none; b=cVa4dsZOdjYakTE4+q1+ahK6xNcmIam94RIGnQHPht3m6YaDGqogPEBGlhrLTjXMa/BR6aLZEahV1WVS2Nsvrs1j9/SSywCwGo3ojS9u3lAdpaJtTG3IRgiLoCzHbbnGGKIyI/Av9pm0gaSuvLzSOybkVCqXYkeBV72lbczhR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764225636; c=relaxed/simple;
	bh=xBu9C98zr/V8IIqIfOuYV/Prmm6s8GMzcQJGTf+3eXY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IQsd6Ip4i9VKYziOY4josLApDcQFK6J3jtmzhYqO0eEPeebKQjuRsS/+N/7oslL8l7lus4ytQE/zA3jQnvRmnmUKTogIulvop928ItVxrz5uXmWZB1kl6XHrs51ZrfcFdTbkDQyrYLx9isaoHEU30IxAYq8TIWzQHlgqYt9EkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ij5e97Wb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ij5e97Wb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764225633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wuT94p1p5YoZPXiJ9LxCEueq/01SlG2osUN2E2cz8Ic=;
	b=ij5e97Wbbqq3MHE1rEQ/yG2NXd5nxLPoX6gsWdq3ofd6RZIu/Xk6+PSpn+q798hduUUJMo
	99OsBs5lyp6IfYUFLBv+JjVb7ZaWRPcMoMmTUXSvi1TbuETG+MzqEbESYZtL45x2oA/LrZ
	s8PVMEY4BFo/odTvaHyKmo6+hnA+MkE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Y001S4skOgScDTaTpWBpVg-1; Thu, 27 Nov 2025 01:40:32 -0500
X-MC-Unique: Y001S4skOgScDTaTpWBpVg-1
X-Mimecast-MFC-AGG-ID: Y001S4skOgScDTaTpWBpVg_1764225631
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso2167865e9.1
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 22:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764225631; x=1764830431;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuT94p1p5YoZPXiJ9LxCEueq/01SlG2osUN2E2cz8Ic=;
        b=mQULVVkaKD+0ba0bONnGwecsOIGPt3floOz2K73heRtFRwDn0jgEXSrnn5c4eUDi+I
         ZOyCBI8k8SMX1dcs6nu2bbqZbG0FVbO80cnbIWqQnjlnGWw4COVNvhmzlo+sRmPQ1pG+
         pNG2apWxUVMusG+cEBWIxUKmQh7VmPE6WMMfIovXfSnAeqsUU7YhRdCRaSNh9dqHEDgm
         glnuvKAr/2IKiSWEi2Plm5+FfZWILrQSdl55uW9n8yoOthLYPNzWcNI7VJOATX01ooG8
         LBYMeHkHsGbRsnhXTCuqBzeh2SkUbGMqcYPzCATl195NhePFNy+qij7u7KIWz2WHjfyo
         sp/A==
X-Forwarded-Encrypted: i=1; AJvYcCWKYNO/SgwVGb3cPBo9t4VZVUHra5+SpuqZ1N7WQ5xg76fC1brADqSMY9dh6ksdftxZMdBBRhxiTYOUCpcoWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWDGmWZs8r4BtQNRXg63WLV0xMgmB8+MxbjhayL1tM3+2pBl2K
	/NIVe6xr1z4TuzC8JWQj2tUZ6TrbFuEwiXfN69uwe6rSyeH5M6sgNDg//rDPgWazHFjJT+NvnsE
	+HI0XkKh73Cb3AicSinRpf7uWyCSPhqM73NYYmnnVyVAOwcZFlXF6j5fBD2r5YC6oqB9k
X-Gm-Gg: ASbGnct0MKoAgqe00V6UfKdDNUg26PXkCXofHbDPvbXgz/ta+/Pq0grxJr+9Vyti/YU
	YH37xIjBLdRc7555eQT3mtsUSIBTAVbt7/EU6WSVnRdJZDTS8+tZTCl2MICdvjkw5RE0fWrlmTr
	thaZGxR1DerpoRVMImrD+srQRrNR7nW+AGqDcBS4Bq44C0vaLCryLScf6mWmb5ngmQ5K3fPLxbU
	i9kntWMvduV5DtNM9NFk96KbKob4BaOGKkiXlt2e6bPnOj63v0bsEGsSvhFaPRJN7iYND6S70a7
	inrJPxuMHraEjX4oSBu3STTDLQv1Y6l4YeQTgOhRnQFHjMKpoZuaVPGItThHflh2blrd0r0g251
	6EbtsbeIc9nMxr02RPspxTJoq6DX/ZA==
X-Received: by 2002:a05:600c:1f85:b0:471:793:e795 with SMTP id 5b1f17b1804b1-477b9e61f7cmr222173665e9.0.1764225630960;
        Wed, 26 Nov 2025 22:40:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF76KdhGXjY5ZtkUCvZbpceqilnQQdcgRmkvzsAfI7e3ekqqLFi6fdFkjz6br0cokEu+iwVsw==
X-Received: by 2002:a05:600c:1f85:b0:471:793:e795 with SMTP id 5b1f17b1804b1-477b9e61f7cmr222173475e9.0.1764225630563;
        Wed, 26 Nov 2025 22:40:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0cc186sm76113625e9.13.2025.11.26.22.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 22:40:30 -0800 (PST)
Date: Thu, 27 Nov 2025 01:40:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v6 0/3] virtio: feature related cleanups
Message-ID: <cover.1764225384.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 95vifajDr405z913l7DqlS9g931KkLoGMT4W80tw39M_1764225631
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Cleanup around handling of feature bits:
- address word/dword/qword confusion
- simplify interfaces so callers do not need to
  remember in which 64 bit chunk each bit belongs

changes from v5:
  rename variables in vhost to make the diff much smaller
changes from v4: address comments by Jason
  move features variable to beginning of block
  unsigned long -> u64 - they are not the same
changes from v3:
  drop an out of date unnecessary kdoc parser change

changes from v2:
- drop unnecessary casts
- rework the interface to use array of bits not


Michael S. Tsirkin (3):
  virtio: clean up features qword/dword terms
  vhost/test: add test specific macro for features
  vhost: switch to arrays of feature bits

 drivers/vhost/net.c                    | 29 +++++++++---------
 drivers/vhost/scsi.c                   |  9 ++++--
 drivers/vhost/test.c                   | 10 ++++--
 drivers/vhost/vhost.h                  | 42 +++++++++++++++++++++-----
 drivers/vhost/vsock.c                  | 10 +++---
 drivers/virtio/virtio.c                | 12 ++++----
 drivers/virtio/virtio_debug.c          | 10 +++---
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++--
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 29 +++++++++---------
 include/linux/virtio_pci_modern.h      |  8 ++---
 12 files changed, 104 insertions(+), 65 deletions(-)

-- 
MST

