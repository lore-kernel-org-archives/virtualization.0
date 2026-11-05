Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891390;
	b=0FKiR7OVaXg3HoV9K2nZWdgOVBQydUbXKdJwhrhsm/iFIIKK3L9epD+4ER0o/zE053kA
	 Jkeayk2oxg+liHoU6rzFt1T1S7F6//G36XP+1HOJZXKkJ68oaqbNz20gjEQhU4PZ8vpN/
	 JoIPAEWhKpTuor2sFCGR8jz9B5Tn3vUXXDbEqSVEt6bczHf1C7AKgvUEPnosK8Z3KCl7P
	 JaR2XyJi1+kOMZCXqAvIjJIeztqjjZqdgidBXzvFQIbzBfezuqOErQDQmidO3mQ9jdb7Z
	 rt5EZNJ48bkWNE113IExCrXNz8qk+M7e+MQzSFzvHr+6gKy0DfGkuCosWJ+pwIR7e/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891390;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
	bh=6igLeCdyvx1mvf1ZSjuMUxGb5XzaqkxPYrbkgHbNZGI=;
	b=n95GM1u5vB+5gFNImuwPV2rvnOpeNrDnSC9dLix/t3lJLU9ovki6NfcI6R+oOA6Zwvd/
	 b1JM3X1CusTSn1MzpOslNKFVcA9nEk/rVftovizv4cXXiNw+ruHYpmgxyi7U66b3bJ5QN
	 93vIdldZovbtQXfvKXGdlidDjTWcrRDR7dqDx6nzcVn2qFo0rcMCi7ZsWJgIM1lnN81tl
	 NcGgGKg95UbR9EhXiNvx059OU0YsvJ3I+l1MtOjszmaDvM52dJEloG1ooybr7/dNu/Grr
	 D5amh3lPXyTkNl3CzqNMyAEMIgmZt89B2IC3m+VbWfFg9XZ/2VWa3GKyvq2hIsy0cdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Bf+reH0/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9E606D805
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92B9E606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bf+reH0/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793891388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6igLeCdyvx1mvf1ZSjuMUxGb5XzaqkxPYrbkgHbNZGI=;
	b=Bf+reH0/kYJaEnfgsb9fbRjOvZN5OkZvK/uI/Ff9AH87Ql5N/Rk3qqHoc9H+Er3Ptqpv59
	Z2BUqbJ9clVHnWeKHQ2ljefSbKBBTSl1pM/APSuXo0sGuw7Vygt/77u0mvOpLGP2TsxLq9
	7par2yZaWexJtY4UgZq6r0jvxYfGnis=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Ni38mFjzPyeGAI5m9BreMQ-1; Thu, 05 Nov 2026 10:09:47 -0500
X-MC-Unique: Ni38mFjzPyeGAI5m9BreMQ-1
X-Mimecast-MFC-AGG-ID: Ni38mFjzPyeGAI5m9BreMQ_1793891386
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so15350965e9.2
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 07:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891386; x=1794496186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6igLeCdyvx1mvf1ZSjuMUxGb5XzaqkxPYrbkgHbNZGI=;
        b=DEKRPUQ3tHIYCpdObHhfmVdY2mY4FvAzwbAFaSwxP1u8uubtzgj3Jt/nSz4DS8VEPg
         oL0s1ifq3NuTidWx2csyWOq3a7UQ8SlaUZnYIOU8F+mZqxjiIQ6FtHyjUvev2vQcvnrM
         cxZXHiGhZX2gC9A+ESZXe89zeOX36A99CdqKWrkaKNaaGxeX/XpdVrq5Q8aPZ84RfcME
         fEuQJ4IPOTkzvn2CdGIye0SmGFB5qXDOag2gzXvykFAusonT/zH+r+NdDAmemz3D3LNs
         NoBCesxwa48T3XUEHfD36LnPAljHocAXGtJ4Kpk3rRNg8GuwwW+vuqgBPGymktUgFAi9
         kyKw==
X-Forwarded-Encrypted: i=1; AKwUvBwesHu2KqLKcl3PupFzOWC6bhO+yUpZTwMElbAImF8sjTJLtx+Yn43gmDdf45XZvRrge/QcuhX3TBSTdLCn3Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/N9BtPIpZ8Z+yT72Wl7uXUrG0TRR6+xw9X5n74eMQnjxl3Pw4p
	hy2hKZA850p6IFF8F49q6OpQO88y1WKiajeN0CEDhhaQQ6HpXjGDic6P/RAh5GVshqxheSbpKng
	Bae7Y4KyDXkM22xzMwDqxgaZTQ9P8aV+2nLo2C/rcBmeW7DUFH4JNC1KpLQaQqEqog140
X-Gm-Gg: AYBFou1M/kXmSxmfRauqn9VaOg20mSythuAZpN6W4KfT8FrdCms2HOkDE4TXp+XXqmP
	04UJ54Ib3JobS8YqRiozNYITU9Qahcr7CmVFBUyBKmaBnj0TgqNSyKSprNLRvFRY6Uf96i5sNQY
	MKdOsQSUbWzMH4COWCFSimz5whYcdqnDzlXb9Ber5jeDjGD+HwwCTqKNK9M3sMIkvYo+MFy18Gk
	vkLfv91PT3H2fxoF/PY8FJ0JxUPRNPyZ0x0Oz8gM6XDHyoGbZfpPJdGxg8TLCksIClQYGZ7OCNX
	LiIjvCRytNobqvIKfV4mtJBFc46Wrv2UyUyERZz/v8rFqXjH5xHnWsn/iME/W58woB4dcD/C8qU
	Q5wCcezC4xFvL1oyukkNaHvU7a/hiGW6tPS9E8FXveWhMpnGbEOyJTBGM/KcpJ6s+PuWy1D1Yug
	HjuH7bjUlqDQLZ+gwF0akjcRAqzL9f+gkOomu4lwrKqNw=
X-Received: by 2002:a05:600c:674a:b0:4a1:fb23:68f0 with SMTP id 5b1f17b1804b1-4ac14ec788emr427673895e9.3.1793891386175;
        Thu, 05 Nov 2026 07:09:46 -0800 (PST)
X-Received: by 2002:a05:600c:674a:b0:4a1:fb23:68f0 with SMTP id 5b1f17b1804b1-4ac14ec788emr427673555e9.3.1793891385879;
        Thu, 05 Nov 2026 07:09:45 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (188-142-154-142.pool.digikabel.hu. [188.142.154.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda207d8sm9961340f8f.52.2026.11.05.07.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:09:44 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 0/3] virtiofs: fix sashiko reported bugs
Date: Thu,  5 Nov 2026 16:09:39 +0100
Message-ID: <20261105150943.86650-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O7PriGJ3LZ1eW23vbA7nGtNeopndmEA6LYx6Ye9BvXI_1793891386
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

---
Miklos Szeredi (3):
  virtiofs: fix use-after-free of fs->tag on device removal
  virtiofs: disable request timeout
  virtiofs: zero the reply region of the argument buffer

 fs/fuse/fuse_i.h    | 10 ++++++++++
 fs/fuse/inode.c     |  9 ++++++---
 fs/fuse/virtio_fs.c | 33 +++++++++++++++++++++++++++------
 3 files changed, 43 insertions(+), 9 deletions(-)

-- 
2.56.0

