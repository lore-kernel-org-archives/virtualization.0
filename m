Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F303B95FA
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082829; cv=none; b=Ym+ut0FeZP/YOoAWYeMS9aBszSXBBSpq+TJvTQIFozctXlP6ffsIDKMBKGuLet9YWBo3h/kEG7nmCz2EU6xzko80Y5ZRmOJd9Ytiw0bwx945zwCSAYXUpAt2LAiLHHwh19mA6FKz+qtP7an9QU3IehUcytqilHWecarA+yL9X90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082829; c=relaxed/simple;
	bh=W463cXGnAz82EOi9NNWV1+60CJES5ZJg/EZH0EXdgIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KyzMoAJ4ZCXQvgGwqHnHYJGv+HeatksIC25VK0a15AE4i/x/wkP4jVKE73xNNnJa+ZDGkrpZZpw1EbmJkpyhbMpNhAOyjmWAhFBylWZK7oSSj47S/LzWAfBn6DbtBEUkfbHuzZMbidBBuv8UqSsUaLFrqKjkcBsInqHWmnmfgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptg3iweR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptg3iweR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0b944f6edso66668145ad.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082826; x=1781687626; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIQzRtgrJxYlcRBc/QwiLdrLM17LYdrQBecKZn+GnnI=;
        b=ptg3iweRoqGTVIGY1lffzhwl3xrATWNBHJtgPStLPR75nUu/dGtCv9kdfyAtYpSdqH
         RWBj4CBJ5/G2mk0LGfSIhQ20gvCS350Gfztb1fZPuumvSdswIPyaW+l1bxoEHe7U2B+E
         1/SwjVP6UanwIdBDLamAqnY5M7W+jfnD1w+WeNAjKTYX3TXJG6t+W6jzQQ+C+pvks2FA
         mC4wg0CfcTqHBhb12rE3mAHkzo5RoFX4y8KB3hhPj5uvCMkHhmCcWi9VyixDBG8chluR
         1lOrAhGMu15yRUPrHuEBWePmP+GgkFix+jQTQYfJlRQUUIuLcASLsizr5Qg72nJewmxO
         nL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082826; x=1781687626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIQzRtgrJxYlcRBc/QwiLdrLM17LYdrQBecKZn+GnnI=;
        b=SpZALpC4iD8nMtgHM04cW5qZRym1UOkQYJcS2m8+S0JZKuGA0HoE53QMJ6aPk0rMnN
         GJXVX76Xo0hx94ZNVP5hWcEAQ5p27pk+YblGLSqTr5KZreLm9yFMgmlS4neZDrbyjzOd
         sTOtXe5TG5j55Bf+L1ffrYiJm4vGsjqM2SPW8gYTlCeBBgi0SGzv9aliJ37cxkMcEuRv
         RJZ4UExoPN6sE1JZeGtmJnS5G5ciTsgBG3S8fMv6Jov0bKcwmpSNKRYswpxATAVkf8oS
         tuJpO+BojrRDKcO8dgUTwByWRqq3qF5l1YbrcpJuj0xev9z1gXJZ2bEHbrq3gH5KZBpn
         Yj0A==
X-Forwarded-Encrypted: i=1; AFNElJ+JLkfjSI1D9zz0YIiCPLZVt08rqILO4Xt037GbJD4pEwX/rsPartexX3y5g42M/Z1sYGUfbrBZIgecWw74Og==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKca4ygf5vU2mMmXJ1MdWv4x7ZA1bhkEtLa6sO8/hNu6IExqHx
	Kh23CHBiBblx7HqdI7/EUIjFgEwseDKNx7LL7oHT5S1RHY2B1FosV5A=
X-Gm-Gg: Acq92OFohqI9um+t8YZ44TWFuO42JOYAyhOZ9RQ/k+xpi3CGTRPl0hs7BAfxpkp2ZlL
	Loa2V7LrCJGFfN5OyoOguZXdPNOZbLADSgWH77xSKGEDwy0VMoQeK7vTZptI6ozV6UgKfwXolNA
	K+/fIjyPEvcGZFWZkwDeLxFrAVBQDXf/eUI92Sm+9Vfwhf/5zcC7kns/NQ9tvxXoipEs5JXYsln
	yhysagOJTFo5Ko/fGwRZxmU2j9AQQRpNKGTdsXs9CnUCZ80cVbMbe32n//MAd6kN42FXpeqtKGn
	EUArhK1E5GLyAJUg243ftLxExXr/db0B1NlBvrfr/SDsg0z5jWmQOWoux1BhwSXNxy3ivRCU92K
	wG/mAyywWDDC1KA8UrTboF8sWJjdU38rN5ot6cS56EPquPrlsL95YR2alEZKf9nqqg6M0aJobD5
	OjfvWTfkGv54yBD24Yw0BHwN9dh+4mnfRtF7BUAbGbXbY2TgyhUky8fngC4J7zNCy0/jELWbcT7
	npdjz1/OkTxh4H2
X-Received: by 2002:a17:903:248:b0:2c1:d49c:8396 with SMTP id d9443c01a7336-2c1e7b35a28mr281851875ad.1.1781082826002;
        Wed, 10 Jun 2026 02:13:46 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm242991765ad.44.2026.06.10.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:13:45 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next 0/2] vsock: fold acceptq accounting into core helpers
Date: Wed, 10 Jun 2026 09:11:19 +0000
Message-ID: <20260610091121.213324-1-rafdog35@gmail.com>
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

This makes the accounting automatic and prevents future callers
from forgetting it.

Raf Dickson (2):
  vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
  vsock: fold sk_acceptq_removed() into vsock_remove_pending()

 net/vmw_vsock/af_vsock.c                | 4 ++--
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 net/vmw_vsock/vmci_transport.c          | 6 +-----
 4 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.54.0

