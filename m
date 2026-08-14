Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61101411FA6
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692556; cv=none; b=PBqd/EQIPERoJpp64362lklkmvV3yfFSRw3cW0o11RTZssH1DXsJ5qdCg8PuVw8gGK85bMDLjTIKgXfF8RX2wTz1tu9/Ss5Bz2rCB4MECtgJHcfi8MphecB6GDQInpknltXYe0Bd3YBdo5zEcSkHGzqakjNDaLH+iNMDKnyCVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692556; c=relaxed/simple;
	bh=AwI8bMlXLv3wxhinvie/tZxTYnyJT1R3jenyE5i/EFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tocLK9NmTMD59iqVwUZ0nZi2mJksjajmtURPbg2KZs88Tsh6bx/NtS/vbogKUknPVCarFKlu7k9sFPdu6mpdQdbzvWyviI/xkoHhpkzSC/0K6nahA+c53JezxAEjdKpm5BMbr0238MvfCARLjaBMQcL/zeaoP5fIeElZmO+pMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGk/qb1f; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGk/qb1f"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e88b60121so578472a91.3
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692550; x=1787297350; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQpd4eRSV0dJsL+ykEn9cs9mcA6G8jtpyBsR3LcTcRs=;
        b=PGk/qb1fGw/y2VmbgkdR9fuV6C18Nx5f1P6869AcHyzUcCxHVDMtQ8uReCsB3F+tCg
         NAm1Dqmvj1iMlNW5P+nFrA+Y7MLuaNtuKmTXiNhzCrm9kIhdIWJ6p+qbSA8rU+lUsB1Z
         y7SbH0vB3hRKhoDMJXIqJt7TKIjVovO1njd34Pepuu8JcPKkW2ww8x2Spe7LXynEl0N6
         o4VxSdMzpb5OE7ZlwYHqqdUPNqwMg/i0+/i5CfrYOOth8kNFi1j6rINbZos6cegv4Bx8
         HIwQKazFmoCmgXNHIDKDBnSHMlvy4hfv9hDPs/ASTGFGTvtgUgeM0459CW2+I7thPpUa
         8AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692550; x=1787297350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQpd4eRSV0dJsL+ykEn9cs9mcA6G8jtpyBsR3LcTcRs=;
        b=Ia8VHhLA7h2PIpoQcgBigpbbfyxzs3gk3lBUNB9yIfeoVwby5dCYDN+jKaAAgfmhf6
         RPwCM8MjNowXwAg8cK89i+XSg4YisP4NWN+EkOrojjI81JksTRkArK3OV8lTUN7tlQN4
         bWzEhKXUUfPur9E4rde3BwtpDjRBlmGJvXtwNTc+kdXalTt0R5cq1LCy97FC84LMPf+c
         W5Fd2GAu/eCE2pxHC+mD2J9JErVJ6SUp2PQ7j7W0q8GmPQEUmbsqU2jkAx7bdKaAB2pp
         4+5GmbWm0t/6LLkW0UVi6yAeFFJbBFov8GpiOhx/TrKwlpVp/HvxHbfVk79prl//14vv
         0EKg==
X-Forwarded-Encrypted: i=1; AHgh+RrulDUOAexLq7zcGGVinYEllxnHBrXzxIHhWaXwskc7isbwBzwhZTW7U3JbRYaPyYtZQmwGfCa+rwDhLaMDTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp5HmRsvs2lolB9pAYSO8EbPtwFF+PE4JEcOzy7vRC2guRNvGA
	tNZkSSm5qzmNdiOK8Q56/kY9BcSCFqGn66SeZmTqL4wX2sf00INFkc5x
X-Gm-Gg: AR+sD13S+basbS1CSEbTP/59lGopUVwSgTXEiDCnHe0Gfvz6xx57ij5aoICdZosSjvi
	d9HZ2QC9f/pXp4smTWri9h1/zsm44RmqqUXBEEyYcRpZfdhBRz4SMcP4qUquz2fT11M15FPiGOK
	b0lrhnGsdT2gJQuCAg+L4QuBrhkQs18VHVuUEu4C7Rp1qUduy/T4hw9e06J/3qO41bMev0u0SmG
	3RN0JxpbGpHoBAgHbUZ/3LL8vNJKav3BcAY590uD7Qy75MLX1v25AeGtgesd00AiLf43KvVzyfK
	Z+TDmMQUny6g7b7zOERoOtqxCfwLVWq2TeZVbBRIbquQHeXNcCjCldFOtANrRiY+JmaWVyOY1mc
	v/Wbi00XdL5S7ez1J2j2uSmJ+9f8MlwPJEhXOP72Udoq3wfxfWidr79jmM02sJG2Np07m+ycbQ8
	P+pVmMzLODywemOiKTJKKqIuO44DBdu+mIBpGfEiKVqsThzTUMrYbzomly+/sAVBOYItNuFN5to
	tI=
X-Received: by 2002:a17:90b:3c02:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-3933b6e9788mr4544657a91.2.1786692550314;
        Fri, 14 Aug 2026 00:29:10 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb752fd7sm1483477a91.13.2026.08.14.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] vhost/vsock: fix device IOTLB feature lifecycle
Date: Fri, 14 Aug 2026 15:29:00 +0800
Message-Id: <20260814072903.124991-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-vsock leaves the device IOTLB attached when userspace clears
VIRTIO_F_ACCESS_PLATFORM. It also replaces an existing IOTLB with an
empty one whenever a later feature update keeps ACCESS_PLATFORM enabled.

Patch 1 adds a common vhost helper that detaches the device IOTLB from
all virtqueues, clears their metadata caches, drops queued IOTLB miss
messages, and frees the old table after all virtqueues have released
their pointers.

Patch 2 uses the helper when vhost-vsock clears ACCESS_PLATFORM. The
acked_features update remains in the vhost-vsock-specific loop.

Patch 3 avoids replacing an existing IOTLB when ACCESS_PLATFORM remains
enabled across a feature update.

Changes since v3:
- move the IOTLB teardown helper from vhost-vsock into common vhost code
- keep acked_features updates in the backend-specific loop
- add the common helper as a separate first patch

Jia Jia (3):
  vhost: add helper to clear device IOTLB
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/vsock: keep IOTLB across feature updates

 drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c |  7 ++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.34.1
