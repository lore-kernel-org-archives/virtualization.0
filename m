Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4512C327A
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026479; cv=none; b=iqABOjNSdV5Ky4Xypx7OrcAx+r4EtIBrUbkzlMlkk8svh0BgFqSxTkI6B5rmmLtGXtH2e5IR8qKgUO0Y93tnS5U4vu87S5T3LIHl23ozUkuB//grBE/o8oBip9b7uQgj+o47PWvdgN6dYGO0DOJKYzaZff0DVcRm34fg9MwfK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026479; c=relaxed/simple;
	bh=kjrUKosoH2VXUs3fSIWEtTAoeG02LoiL///bz2ZXM4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GdDEg6O7Qe3EM9MYEr4HloL0d7SJdv6mdXnHyBhWZWKFxpe6qv4Zk6M+9z/5rImG+8+x94tkUnQAPfIgJrGAHOtQhR+d9PphxYXe/zM+3dl4Z1xaexgZwebHhS6T8wX4MkdvH1eKD7WHeXVh0PrUcRYNWyIuXpUbkqwTd9iwevA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmgzvVA1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmgzvVA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FN+8TdeE9rBb1ts17t7km+0CBPBVtlQA4WgPCGrmer4=;
	b=fmgzvVA10kBoSuJaAJmYZ/3dGK6eACsDadfgwaxMb32dcibarO+Xt+JLpCpn92P86RRO9n
	+cERW1EZf9NNqCwzaR1co6LtdfRfh/x5S5p55gVNaZnfqweogmU2DLxM1SMWqlCYiubUuI
	tm5L+d0RC3FacZmgCnDX0u4nX+sXhMQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-IDTTLM8vNr6NeMiFOU6cOA-1; Thu, 13 Nov 2025 04:34:35 -0500
X-MC-Unique: IDTTLM8vNr6NeMiFOU6cOA-1
X-Mimecast-MFC-AGG-ID: IDTTLM8vNr6NeMiFOU6cOA_1763026474
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106a388cfso3628765e9.0
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 01:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026474; x=1763631274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN+8TdeE9rBb1ts17t7km+0CBPBVtlQA4WgPCGrmer4=;
        b=u12pksO27k/Y+tFKx09LZNvH/aw+FcKM+gbuyGtG+46jJ5hUpPenX1ZV5/Fo9Ns+ml
         Uz053XNvsdOq8Z8PrzH5SvmADglkYwEu51kV1yrBKqTiwb6yUOkJGanCazmmY+xKkXY9
         oHWBuICYhoJeKtfBvjAkH3oRYGDN3aQV/1U0YzEerdQVs2R7YjdtU+2SAKNkX6/FzNhi
         7uEaIy9gjOpaRoGnlCEoz/FxTM+/rekP+olv5Q2zwQNu10/WwP2uaNQET3ZJxg/Iul7Y
         B9zR/2ZMqrDkSDNINFkn3dq9qP82aQkCF5qVQKgu0pIw2jWKy8RnG1dcAoQzz++2jWuU
         bxMg==
X-Forwarded-Encrypted: i=1; AJvYcCUw3OkEG2QTBn1nIEJpdruXHBfLEJXfzIxiFg2uGZxH7PK0x3OLNBGkXmgjcMQ+N9vmSKytmlGeT+AxlmVE0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH8oMR1qV5Lc4kjs/jdq4bFfXypVBaUodaahoclNgBCRzGrNqq
	6YOtMP7q1GfUgt5VXitYhAKQu52cleh4Ybn6zVyzQW9T1FGxZKkYrLhxXvzE6Xz9iwXfBoI/1bt
	hNpgPMivRUGakb92IoVBDmb9Sw9IhE+K2esutMQ3dpHb3xlrZQZXPV3U4vHcpU6825yXU
X-Gm-Gg: ASbGncuq/JaEG3RKomPmQqMNB11bEjUY2U0l3gb5WMLYPn9WYfAZ6sR9+GNko+MxKAv
	fzHeKKs6/9NUmV5CuP6ZlRc1Hlr5DsUfPPmM8iuMHF1pL670HilnmTVyD7Z98W4Rl1/tDseAyUc
	fBTPgHphmhM3aX2s3DiuVUnBIjAbbOGxQdA5Ku4UQwKphVdymGwmTCXKB0C4+W6XbXMTpyz8wEa
	Ca7Tl81EuZeIiTU9C8e26/IVcsQChzWcyfJmolnBUYyv8bc2fcoF2w7x2YJvDOVIeOs2DcmdFAC
	q9+mvUaSK+7FNy0MB9+KOY8EzIv19iAuK+OsZJYfyverbpE/0gnBT3O38HiI6ZAtdNs4bdDV2AE
	flLD8Dmp46/J6u6dAStM=
X-Received: by 2002:a05:600c:a41:b0:477:589e:6c2f with SMTP id 5b1f17b1804b1-477870c6610mr55286295e9.22.1763026474328;
        Thu, 13 Nov 2025 01:34:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4WCYMpLpC8f9yzg1P8DvxA/UpKXTqph+vWP9aurFB6/f8uzYw+O0yjkaAHN+c9PD8/Fj0fQ==
X-Received: by 2002:a05:600c:a41:b0:477:589e:6c2f with SMTP id 5b1f17b1804b1-477870c6610mr55286015e9.22.1763026473808;
        Thu, 13 Nov 2025 01:34:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bd27ad5sm15790875e9.16.2025.11.13.01.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:33 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 1/8] virtio: fix typo in virtio_device_ready() comment
Message-ID: <db286e9a65449347f6584e68c9960fd5ded2b4b0.1763026134.git.mst@redhat.com>
References: <cover.1763026134.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1763026134.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nomqo1yv5dKl-i2PYPFU68RcJTN-y8A0W4u0D8Lh2mA_1763026474
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

"coherenct" -> "coherent"

Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 16001e9f9b39..1ea5baa62141 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -362,7 +362,7 @@ void virtio_device_ready(struct virtio_device *dev)
 	 * specific set_status() method.
 	 *
 	 * A well behaved device will only notify a virtqueue after
-	 * DRIVER_OK, this means the device should "see" the coherenct
+	 * DRIVER_OK, this means the device should "see" the coherent
 	 * memory write that set vq->broken as false which is done by
 	 * the driver when it sees DRIVER_OK, then the following
 	 * driver's vring_interrupt() will see vq->broken as false so
-- 
MST

