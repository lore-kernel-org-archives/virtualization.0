Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C681314B8C
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144020; cv=none; b=LuyxuEHenNC117J8BYvYp0dVMY0ke13bEwbU8E8N0mTxlmbDN5rbLcaVQEBpkNoB+Zuqwo55S/c2ZB+4j7g0iR0XjzbFkI84Mf9nKcW6BFFz1/+3qkVeA1qn6fQaHsZ+gydrr9VQ84bFkssjLig65hX6QMzaq8D++zquPFAfBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144020; c=relaxed/simple;
	bh=QVnhuMzdUwNHmvsxo1WC+MtfAlAGVAzmGjI+6rh1pko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ke3wjZWWYZjgZ3B20d/3X2bhRiaqi157R7TLFfAlmQZy5d3ypHvnKdJ3mUCf1nAUPzGjLpifKnVVow3YAr8HBxC2EF5kQa/N3QuyhUYlEMuSOO87f+Fw11GLU9fOkKoEM1Z57aYU8usHiNUBmi3lhGTVT0ecjRBUTdasKL7BIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0+cPZ2Q; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0+cPZ2Q"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b9d265355so4557393a91.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781144015; x=1781748815; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZGIg+TSBMH1y+DPOSnGtaBlpfe4SMWXOyP2aITu4mo=;
        b=L0+cPZ2Q3GEfzL28GuIItNcQEWEfJP+FWfc+w+zUkdYINzzMd7u0QqkvxaGPMy7IbT
         W/oD8X7RLl8+yvPAchSydyS70MsH9JJl7r/rTK7G6ZKsGqU+0ej+hkYgxQy65iFWZB9d
         7qh2SK2Mm3ToMXOMC4Ty913HyrrD/YKcC758N0QCdujgPA1oVjXr+fkUeKSoX44G9Wbm
         Nb3W0YLUDFC5ShnlYMOio2w+/2EaX/9m8yTUj0kKJR2BmbvxZoh0gNXtdXnNbx6yOUdI
         m2v5acroFRe2MycX3ibZEuyV4X7dZBeTqWl12b20uaXYu8ULvDqXSVjxJZIT2VWSYnLF
         AD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781144015; x=1781748815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZGIg+TSBMH1y+DPOSnGtaBlpfe4SMWXOyP2aITu4mo=;
        b=B7J1E3quflNWGigtoVS35SU/Achb0KeAEUaCZSlpxD673Pk+silYLJyLo5zSe688Bt
         srfLMFsoLuP6HC+U0ulQOPtBJMVNN6eKlxDddFOCYZOJ5nfnwynoXq6ZYrpTT2zMRjop
         UDFU5JbG/sYpsSps+qf/3ZO6g/44+UlV51cbSJXvUBSIO0ggPWFksw1exsTYjzIPICQO
         u1KDYE2uHCO0rVc6+66RD0SLFgDnoPK01lzhhVXztDtgtE3rPdR2TSDuHRNJH9/E152F
         NuFvkrNx3h9xAfY3gRjQ992tipPOA2BtXRH3FwMAj5IgcWOeq84bCa3bnM/RPJVxIdxB
         SVaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XtYifW/zp4JII9F7npoqUOdSM55FoDxbcawz3Kd/05j5RYbFt4lGy2M/8YnsNx+tWeECaT3r3CLYbrEStfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSbeIa7+SunWruBAnzERJK0eTOLduZMJEHZNYiEyXdvu2IH2vR
	M5ys0nbnSFuCapNtvTZjZOfAn2eYgbHjg0ONIrXZno6+52qkjeMgQgI=
X-Gm-Gg: Acq92OGtAth6SrhW8/kjXee+ytP30/pss3P6UGFAC30YALfQVxuv9CbtlXi8IGW3P98
	C7UGlClvnO3dK7Dv2Hzft36BMB1IjgPC1fQgScVrh1CWUR0pm+cnI9dgz+PSW87pJY76aYqtH47
	WTkqZ0My2MOJzQLmrqvOsmrV90O/hQWbjAseiM1IxDQrMXWxnFHO7M9Sk/m2V1uLjAm7wnYWaAl
	EOt/+tMnPdcMD2rOIoDkk3dfwslv3uo5xTnxSWi0cyLXDoj8kqeSgEif4e5wfym/mIonLYP0K2Z
	+UplszvhMao4fkDwtm+0Wt/yl9u+MQozcPn+BUZue4bPLFayRtXNJfNqJusC5jaQcrikfI545IR
	SlHw0HoByVyR2zy3JWII3LvitzMWUQ0MPTeeP7mLrXik3EN035zpVi2SQjqF8j74K77I4tq9CSH
	vDvf39LUfX8rA3PwEc36yQOcFpPaJdaeiQuyEw0LhQb3ZF0CcSSykrXvY9eXSgkpy0qZXvELLsc
	axTfw==
X-Received: by 2002:a17:90b:390a:b0:36d:b818:f848 with SMTP id 98e67ed59e1d1-3779bade6f1mr972308a91.5.1781144015048;
        Wed, 10 Jun 2026 19:13:35 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a0eb9sm732006a91.4.2026.06.10.19.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:13:34 -0700 (PDT)
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
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v2 0/2] vsock: fold acceptq accounting into core helpers
Date: Thu, 11 Jun 2026 02:13:15 +0000
Message-ID: <20260611021317.69362-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches follow up on commit c05fa14db43e
("vsock/vmci: fix sk_ack_backlog leak on failed handshake")
by folding sk_acceptq_added() and sk_acceptq_removed() into
vsock_enqueue_accept() and vsock_remove_pending() respectively,
as suggested by Paolo Abeni and Stefano Garzarella.

Changes since v1:
  - Keep sk_acceptq_added() explicit in vmci, where it pairs with
    vsock_add_pending() rather than vsock_enqueue_accept() (Bobby Eshleman)

Link: https://lore.kernel.org/netdev/20260610091121.213324-1-rafdog35@gmail.com/


Raf Dickson (2):
  vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
  vsock: fold sk_acceptq_removed() into vsock_remove_pending()

 net/vmw_vsock/af_vsock.c                | 4 ++--
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 net/vmw_vsock/vmci_transport.c          | 5 +----
 4 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.54.0

