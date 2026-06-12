Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869533F8A4
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239954; cv=none; b=DT/vcyX74DOfmIPZ3Agt4H+S1bMNuoH9CFFc8YQArnGJad5JA8aYwxX+GgseRLUFt0GXL781kz199a4Ece4tcgpbN7YWJE1Y5/vMpJj2aHhTukPbh6hikh7TMUxSuY1kySOoHCxzapOv9zQansqSiFVIoGDhS/qA4pI8tRqxHN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239954; c=relaxed/simple;
	bh=cbDh3+Ett4EFXrSYF+MJAdUmc1MZBb2RkAYnqpX/M8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWtFW36caCUKZjAJh9/+V3iCAeR8ePK27oNADPjFg7UX+upeA8fPRHpiuy0egsR/3f2Ne7BHrTCTbfRHeaCQpLeUdukdzDNYzzxJamiUjXMw+7Fm+BruDDXYxQtpFV4n7DdVnVKvlD/tc9y/teR97DaCItzKvBou8jrGASIIy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLGa7qum; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLGa7qum"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c858961a8efso232495a12.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 21:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239951; x=1781844751; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oa0NGe5E4LAL8RcdBAbNfYk6ilQOe1pmPOc/Xo2zQts=;
        b=LLGa7quma8oF9X0scFM6BTtNsIqibCzxnYvD0Dr+hffCz7XoGf6a2YFdZGr9gRXLSN
         VhrGIGmhzvoVmH73+BxAGXCM8+4WzephC7h7OJggvA69cQUTB8ab5buQmGnqkiQnJ1Cg
         ZVxpBNG88kPZNGn60dhPGgF2ACUQ3DrY+wpQg+benk6dWQcUlZfSmyKlCUaqXLreEDbT
         8NJk6msvxRXHupLiDTMrX1JyWo9h7nqs0rnTL9edtCYP9x9kOZg41NgcQYjWQQe5YvIE
         qbVTI8zA2kXblu+Z+iGMCc3Ic8pK8Yk/o6kxIkqCN4j/RmCBuk+FbRh172CMvLFVv5ee
         k7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239951; x=1781844751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa0NGe5E4LAL8RcdBAbNfYk6ilQOe1pmPOc/Xo2zQts=;
        b=DfMb0r3ip3HKVspBZHil1uFy2HY7uIAC+/M09vYI666BXCKvb1C+UVKaYKJUedfNnT
         3rUBTO/3WJ//CuSgzfmD18MMMnobNSuTODxJX3N8/ROenxUP+fQfW2vLIGJJXWFrYtJW
         YNAdkBRy1nMT+o8wsDjAMJ75cIEBOI+Wo9MmEGLfKKUZ8Kan/I6YKLmNH1EH5MXowZ6Q
         0XcsLEnb9kjvJdmwngbVT9rr/7vLIqZx4SYDMy2mnf6Zujg1BJxK+jqw+dK2imKSNYmU
         n7eijIOCFCngMxgQdWXyyowfd1DTc6737uZLKcTgMRjo2dnlhuTkjVcydgBc8hwNuyuF
         dIRA==
X-Forwarded-Encrypted: i=1; AFNElJ8tL5w77nXu9wHka+FhJ0eyGiDvQnN2ww3ZVB/AbmBJnS32wIyoLZPF1uFtR5Nf/yCUAcvhfjl90HQkOaxvzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg7W++8PeizrKQTkPD4mRHxJydI5Wmd5SznRJ8pRWKNF7CNMMn
	lXdNDO49vWNzNfFy5mcn/FaYfIqnYwsCFUlejx4LDKMc7PILxSyLlQQ=
X-Gm-Gg: Acq92OG6CYfEASY9W2C+um4RtoIWQy5mUWTJw6SilcVX+VutBThOu+DBLX3WIV37fNK
	HOeuISCxIIxFiG/fdbMKgduC4wE8IGBYhANN8Larh1qOAdvlR2iZL8ucRIinqWXl/L3RRTMlbG3
	JcEU1ZZByJKJLhCyen9g5n4yddFw6aHQSOEfVbTAkG6f/fmcMSmMJKQWD+vIu1cn+y2X+lRiReG
	MrZVWfouyO2VlVTzQALbQOtOdGjjlKSBGFfwks80mzj+8Mgq/4rI3H/GQYldFNu7pKwV4aCLq75
	QXs1Vk2B6WdS8qP3NcH8YD+WJ6bAujon+Ue+A3j2ej6nUv3VJvr+0ApJO24d3zlQT+NUiiQsOqO
	PlNtMBCaCXnd4WePja0Mb775LbABDKthAcM/RSAEnmNsc2Fnhv46eNTM1ARe6jNkD49w62njPEB
	vuqlALpigKs6oGGP5ZUEyxIRwenCSsFfjVJxUaY6EW/T0Asl0fsynbmvtc1b3ymBLiU20=
X-Received: by 2002:a17:903:1acb:b0:2c2:245a:3364 with SMTP id d9443c01a7336-2c41217016cmr17829695ad.32.1781239951370;
        Thu, 11 Jun 2026 21:52:31 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:30 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v3 0/4] vsock: consolidate acceptq accounting into core helpers
Date: Fri, 12 Jun 2026 04:52:12 +0000
Message-ID: <20260612045216.105796-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches follow up on commit c05fa14db43e
("vsock/vmci: fix sk_ack_backlog leak on failed handshake")
by consolidating sk_acceptq_added() and sk_acceptq_removed() into
the core vsock helpers so transports cannot forget them.

Changes since v2:
  - Add vsock_pending_to_accept() helper for the vmci pending->accept
    transition, avoiding a double sk_acceptq_added() (Stefano Garzarella)
  - Split into 4 patches for bisectability (Stefano Garzarella)
  - Fold sk_acceptq_added() into vsock_add_pending() as a separate patch

Link: https://lore.kernel.org/netdev/20260611021317.69362-1-rafdog35@gmail.com/

Raf Dickson (4):
  vsock: introduce vsock_pending_to_accept() helper
  vsock: fold sk_acceptq_added() into vsock_add_pending()
  vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
  vsock: fold sk_acceptq_removed() into vsock_remove_pending()

 include/net/af_vsock.h                  |  1 +
 net/vmw_vsock/af_vsock.c                | 14 +++++++++++++-
 net/vmw_vsock/hyperv_transport.c        |  1 -
 net/vmw_vsock/virtio_transport_common.c |  1 -
 net/vmw_vsock/vmci_transport.c          |  8 ++------
 5 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.54.0

