Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95341F7E9
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506558; cv=none; b=DN8o+w/8hkijTHz+sNKNi80xsfhd37JjARXVHhRcX7je1kj5wb2SlBQRGdf55tTOfBXBQNo4rgzZfG0EF3MCNGxsjPpQs2Ek8l4bF7RYE2zlB6WILPVGoqZAHMMf74Hyj/BwE70XBeu4YaBMZ5NZ5mz7wh/sYa/nhzpFtI8xW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506558; c=relaxed/simple;
	bh=5P3Ch4NcxEeqmveBzaLX+zkEGpQ11ii8Z8OoJFfzhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sDqtYWmj9ldDokYrNA0HCBDS6EzytLKEn5RQaPyZd+XJqTC4qOhkjS4TXGgn7hvVMIK19qk5/r+virq3v3LHW9M1EneOf1Za1NHYQYK84JGnDuBU4pc0VPfNx0etE2CRbVpI00McQ2yn81S2mhxdhiQz3do+JSJOeX6IEBqKEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Brgnmhvb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Brgnmhvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783506550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VKbeenKshINiNwrwcYYrN7tTsXlZGXZFYsepVeLpk40=;
	b=Brgnmhvb/sheH5PKXxStzbRIcZefcVi0qbhZOeMflyLOWXU7EvbXKhLLlQdYKo9WM6lUhi
	B6fAG8O09TrnhgZnhtc7B9ZzXbtuLjgNG3ZNzsKSWoUnQ78wPLH6jEQpV4+zsM+LJq6lJ5
	OLon/VWA2Cf22bHXZ5hPHwuODTPb06g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-yHWiGkjxNP-NqpZ4iV8eCQ-1; Wed, 08 Jul 2026 06:29:08 -0400
X-MC-Unique: yHWiGkjxNP-NqpZ4iV8eCQ-1
X-Mimecast-MFC-AGG-ID: yHWiGkjxNP-NqpZ4iV8eCQ_1783506548
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49244130073so4212155e9.1
        for <virtualization@lists.linux.dev>; Wed, 08 Jul 2026 03:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506547; x=1784111347;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VKbeenKshINiNwrwcYYrN7tTsXlZGXZFYsepVeLpk40=;
        b=mMJ32Vpwq/P0fUS/fbGdrb9hOF0an+zPxnKBlFixBUpo9SatAnk+2lS9eIJx9UIXGO
         bxxfYWVZFNsAKUEgSTFSsFS2sc0Jp+zC6OiUG8Jwv6yj+8jcZ4eFCe7ob2o6WSlQ9PaC
         aI0/NcWNhnXcdiKMsfx3cJGXRiDeG5ohYjp6flPzV0+TJSRRLZzmpSb4zgtqvdq3Qetm
         vu5pFvVbZbIxd0LUDb1HIZaKnQp0beNaweQXFnsyIZ8Y8A53dp/oAWFPswW14md0HEf6
         Vw2FjGa+xIRY2M1D1LkCiAQwSfhvJm61rc0KRryqs6/8mjs/ofRdXvNSpJq2Wy2TUKKm
         SpmQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJDxVPMbPYXZIKxdKU7NvcmPTtr6VNsnMYKGDUgfvaki+apN8zGdztWG/OwajcmC1v9mNfBuVJT1hOFZiHHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwteytgBHRWtlMrdhKYiMs85NzduT6KfFvvTRJaEGXmV8O31swu
	X8aMCvOruQ8hqI0GyvpR2tdRfyeRSPzTjI3WAzgV1SvMBQd/QxAvcX9mMwZsex1MvANl+JXZsp5
	/asnUpTHo4gmi4DkmNcsMvLVKtwaZfyUgcN+5P0poMtGV0EKdI5HMWTyrcwUADYCv6TmH
X-Gm-Gg: AfdE7cmlWhKBXE7BOaCkRGKT1pYpNtKKoFX6OOWg2yvzKrnn9X9nWZfixOxz/EviMvf
	foYCNOeHWNeg5Xgbppchk6QE4SvzyYVGxrkRiNGZvM+MFYB1Y/M4AXZqSnlmSDA9CBaGp68AuVp
	WOSsOD6W4rSQNqMlOfUR1BuAx2fhRgNnU8e6uaVxPUVQ7SKwHy/vbqmoPQ8MHhmzGYbON8+FK+9
	StyA6VtIKacbBHgAjCxjavUYpT53Vrc+G4+IHSHgZuWc3fWF9KxSkEtSeb25IMnodjqP+hhfu4d
	315ZP+nkUEr2EUBR6KoZVglceHtiP+i+9sc5R9QzgwiWsA+Dx4ISG0/psw0fhHh4EK2aE63WRXk
	M6SLcTC8zDRUQ5kTlL7+Tdl1d+4bGCSYJLouYUrAfGZ0FM4g=
X-Received: by 2002:a05:600c:628e:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-493e68cfbbcmr20997235e9.17.1783506547617;
        Wed, 08 Jul 2026 03:29:07 -0700 (PDT)
X-Received: by 2002:a05:600c:628e:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-493e68cfbbcmr20996675e9.17.1783506547139;
        Wed, 08 Jul 2026 03:29:07 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0ebf593sm135475255e9.0.2026.07.08.03.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:29:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net v2 0/2] vsock/virtio: collapse receive queue under memory pressure
Date: Wed,  8 Jul 2026 12:29:02 +0200
Message-ID: <20260708102904.50732-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: quML7-49z8jtIGkvOBb4_X9wkv305vl-hzjqP2QbSP4_1783506548
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series contains a patch (the first one) that is part of work I'm
doing to improve the tracking of memory used by AF_VSOCK sockets.
The second patch is a test for our suite that highlights the issue.

Since Brien reported an issue with his environment (based on Linux 6.12.y)
related to the work I’m doing, I extracted this patch and tried to make it
as easy as possible to backport. Brien tested it by backporting it to
6.12.y, which now contains the backport of the 059b7dbd20a6
("vsock/virtio: fix potential unbounded skb queue").

This patch primarily fixes STREAM sockets, but also partially fixes
SEQPACKET (with the exception of EOMs, which are kept in separate skbs to
avoid overcomplicating the code).

The rest of the work, I feel, is more net-next material and still needs
some work to be completed.

Changelog
---------

v2:
- defined MAX_COLLAPSE_LEN macro instead of using a variable [Paolo]
- added a threshold to avoid walking all the queue while collapsing
  [Paolo]
- collapsed the queue before calling virtio_transport_inc_rx_pkt().
  While working on the threshold, I figured out that the check I was
  introducing can also be used to proactively trigger the collapse, so I
  moved the call to virtio_transport_collapse_rx_queue() before acquiring
  the rx_lock to have also a better diff to simplify backports
- improved code readability (removed `out` label, `keep` initialization,
  etc.) [Paolo + other small stuff]
- Brien kindly retested this version as well (thank you so much)

v1: https://lore.kernel.org/netdev/20260626134823.206676-1-sgarzare@redhat.com/

Thanks,
Stefano

Stefano Garzarella (2):
  vsock/virtio: collapse receive queue under memory pressure
  vsock/test: add test for small packets under pressure

 net/vmw_vsock/virtio_transport_common.c | 165 +++++++++++++++++++++++-
 tools/testing/vsock/vsock_test.c        |  87 +++++++++++++
 2 files changed, 251 insertions(+), 1 deletion(-)

-- 
2.55.0

