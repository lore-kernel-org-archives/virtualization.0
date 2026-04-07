Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050B39B97C
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553246; cv=none; b=Ql2SWsyMBmYgzI/Z601QGGO0d3O1vktnAaL3CD/fTnyFowGdMMoBv1GxOv46fqhpEvL/3zhycqrqJXms3cjYrG8+KMJGaiHo2tCyOK2+imQ0BrhqId1NT/93XgtnwiEEx0ZYogQYl7abDSta3ZnOJbvXzFNrjWnFbYJdRSy9ylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553246; c=relaxed/simple;
	bh=WrKcD5DGESE+UFTxVGGlNaua3CHVe5XplrOEYz1KMWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=hFjADh+3Ra9sYB0WqFqB2sNaZ7HF/2KSVf1P6YBMtekEyxxH4qpYlWhnm3EeykEuu18GxpXqGwApksA8DTtRc4hAaEa7n+r68idBPUMmHReirimcU5gwF1qG+cdxiv0Q7dxCnPlZk/+xrlyHxaKbgfbUsYVpvrJGuGSHk9hd4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6MUXma3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6MUXma3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CkyC2WPd3q09yVYMuwvcFXlfB6s2u063IAioO/76CZw=;
	b=O6MUXma3dtz0hj0+liQquyyclOunb7m5Bc3fyO4WKXLdK6YcA4Y2GkqZ91I00WlaalTCKV
	g2pRtmKh2MhHK2/M611kvnitGnv/JwB3zDOxY/FaOP4UrrAvWq8ePHWK5HwMdtCyq+1mbJ
	97fiF3LhEUq8lv3vXEI8/Mtm/a1jm/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-5H-M-5ncNAq4tb3admtqiw-1; Tue, 07 Apr 2026 05:14:02 -0400
X-MC-Unique: 5H-M-5ncNAq4tb3admtqiw-1
X-Mimecast-MFC-AGG-ID: 5H-M-5ncNAq4tb3admtqiw_1775553242
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836abfc742so41609635e9.0
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 02:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553242; x=1776158042;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkyC2WPd3q09yVYMuwvcFXlfB6s2u063IAioO/76CZw=;
        b=VdE6Z1oluYaPb4CK8ZZU8uxLZfRTl2rkGpwTfONA5u24eCJLUM3n3QYrMjGEKZW7PC
         LW7h62OndveSI1/6psGBEPsdsVb9InOvY8ZI3Kmjf1rPDjW+DYigk9l6oh2d6a2n0KQ1
         ARUu4sCvZFJ0zs+P8F4Ccuhy62IHOmxEMKTF0nlKNgCLzMUdA0ALc3VtcnbPBLoBVBEz
         J15b44PMSEjEoXYZhSzamTbxoK1yIFGo0x8RD6Z/520rQxmIiw0UhZ+UXv8FEB9c0SJE
         Ce86t938gL9n3t+bxrPvM0TSSPvtjA0a7PlvRSKufFTW7QyZEruAMUy/MXJG/GOt89J2
         pf7A==
X-Forwarded-Encrypted: i=1; AJvYcCXUHPFdn4Le0jgxaOQDAKbzBBNhaROYteZszFNMcCf2gPpUNp4BHDcw2IBkmaLF6pbOvmP7qDqqK2acZeIQsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxE/ZsXSBpPi1aqKS2G5q5KW6i1xpweo9vHsSouNVnxLny/6V6z
	JLvGkVlo5fobONvKcxGJ2fWe4bIAOyMC99d+QtM4Mijiuoxd84VRAacGTzH0cHLWJBAXnY80Iqk
	jHtrDyQfMpJ4VhOHz8uulSJF5QYFyiLGOHqO0M/ajeJ3OtnFZGka02IG+fetEz2bZnKe2
X-Gm-Gg: AeBDiev3YspeUnC604PTEcNk1vkjt3fw4JuQqzdtNhCu7OPMmYe40D//7zgxo8yZzK8
	JFW/6x84mTO9aHJX6mnDrOofDVdDuNJExWyaOmM9D87IW8FpYKcCcNHQBlcHpUE9u8wD13LcvCP
	QrcSnw2SO0oGVS/83H8byRdrR3PUnqXsSD5kBwgLsR6sJL0QsiwQFuwf9gC9M9JWigKDncrQ2ro
	yeA7CaxezfrDaJ73HyCBdE50jApJ7vQFSPcWxuoNBZRVnRJYdRGyLyBFGf5OUQfUBc6wm+DvXCH
	w45U+9a9jt+fqn1zBbvartIBQpmulzR9xeqU6rMPVCziU4Pe+rhNQI6sXEPqQ+XQI+/SS6+sOM1
	Uv3t8GIeQkPpF1pJ2TXMef2SUYH+9tMuKjg+KxabJheYKI8yVki+YK1SHi/dJ
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr218428985e9.13.1775553241648;
        Tue, 07 Apr 2026 02:14:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr218428565e9.13.1775553241110;
        Tue, 07 Apr 2026 02:14:01 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:00 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v2 0/3] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Date: Tue, 07 Apr 2026 11:13:54 +0200
Message-Id: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WMywrDIBQFfyXcdS0+gqZd5T9KKEm8VinVoCItI
 f9ekUKXc+YwOySMDhNcux0iFpdc8BX4qYPVzv6BxOnKwCmXtKeMGPe+b4hPIgehlkH08oIC6n2
 LWF1L3cBjhqmO1qUc4qflC2vqV+L/UmGEkllz1ZsVjVLLGFHbOZ/X8ILpOI4vE0qtOKYAAAA=
X-Change-ID: 20260401-fix_peek-6837b83469e3
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ImCNk6XfvjJITJjuIqGppJbWjb2dPDR6VjtJj4xLL48_1775553242
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`virtio_transport_stream_do_peek`, when calculating the number of bytes to
copy, didn't consider the `offset`, caused by partial reads that happened
before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commits.

Commit 1 introduces the fix
Commit 2 introduces some preliminary work for adding a test
Commit 3 introduces a test that checks for this bug to avoid future
regressions.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Addressed reviewers comment
    - Test now uses the recv_buf utils.
    - Removed unnecessary barrier
    - Checkpatch warnings.
- Added new commit that allows to use recv_buf with MSG_PEEK
- Picked up RoBs
- Link to v1: https://lore.kernel.org/r/20260402-fix_peek-v1-0-ad274fcef77b@redhat.com

---
Luigi Leonardi (3):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: handle MSG_PEEK in `recv_buf`
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++-
 tools/testing/vsock/util.c              |  8 +++++
 tools/testing/vsock/vsock_test.c        | 56 ++++++++++++++++++++++++++-------
 3 files changed, 54 insertions(+), 15 deletions(-)
---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

