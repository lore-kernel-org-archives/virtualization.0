Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853047D94B
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351548; cv=none; b=qMpq/P0Whma/Crfs0rTDynXgkzIR0nW8PB6Asw7ZVh18q5m+H3h/0mfO4UtOVHQv66//8mBrhFxQXmMAYZTMJ2jKdjzniLIVJ2LmPlxVqi1O5E18Me+Du7E7oaa3SD5qkle+BGc/jXfxYwDxL180OQ7KaUW+8FVFcmYSJAjpQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351548; c=relaxed/simple;
	bh=6OQPemUbrtEvn35mHWX6wGaAzq7fYLjqo+G0OX7yMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mz8Oi2HUIlLTx0423lCEs/ikgCNLv0snrdbf7APUpWJtGGftq5nqzPJBCsKUV++j/z3Ws89Bmhp5HDOrms0VWWnAnAaQYm9We6bw2ad/1/LME3uommXDgMjPvsKYaTaO/aKjqf570BbKZXeQggSVKj32Trl87/aeffj00Ne/uX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8kn/ufh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8kn/ufh"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848d21bbaffso1481351b3a.0
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351547; x=1785956347; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCI3GixEP2KXXtfpULqWtW8LurdBltars+anz7Y6MWw=;
        b=Z8kn/ufhzp65A+63Tmy4GipJFMBoe5OgMTySeu1qMwBYmlK8OnRfyUPufx9Tfj44Ei
         keRNiR2/LvD/K0RuDdw/Q4aUzlYKPWOvnz52RUee2/jt1MC+dbDpI2AaBYapE+zbu6nc
         770uzBwPFm1r5kZjHmkzpklxxbM9ytD3QEiABdNH4w+qyefnYtrHGm1B8VfVeV/sTlDA
         iSeSCq2DXD5sEWd3nxnLjPf/2Rk1kiwVvFz1dx2mVg1+qQwtbERWACqmhtAZi86+xlo7
         X2Cv/BWRVkQFA1pG90egaQd432MKA6pcfzj5hUbIcSZjxBkW3NRji0C4Bl10cQvr0f2d
         VQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351547; x=1785956347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SCI3GixEP2KXXtfpULqWtW8LurdBltars+anz7Y6MWw=;
        b=DbivrSIOAP+NKYh+yJeJ+FezJ5HfywjwBHKLZSOfv81FWQ2GCANublHktKu6/QVN1g
         AuJID6GIw6MU98bA1t7oZ8O6jCWD+T1gYPg3/SnUpVQv5Ma+4otTK6H+4M1gCEISMEJu
         4QaHpNeNPpun9G0PgrUE4QYNu7BPsgUOjKTMkJUCYhS5coqtXM+b1oKnkZe7qaJSIKJi
         A1l2CkmjRZS0GXLISjWRZG4qJd0jl7q46ZeVviG8Fe00KFo/2pftZB7kaqlKzNQGz2zn
         iS7Sdwqhm6E+JkbcwMXp8Ry+Oln43dzrmEQtiUpHMKm2jSWtJWksybDPcn7zglmeRdlx
         AdzA==
X-Gm-Message-State: AOJu0Yx8J74bkrLdYL4hW+QMitxAi3EEHdKZZtDnl2gaqHI4cvNtC54O
	Xtia+o6+C2dgMnWutdUoKLghJItYeU8PBa445c+XKZPgsdEfVEnGPaGA
X-Gm-Gg: AR+sD10n1wkvGWpJam/UhdXS4cYi14TvkTaershmFqQ3YlS12nD5MzAkfj9tUic4GzR
	ehtXP7WAb8F1XsrzI/ANfClFbE7xgJJhKMP1c57t2+USWmMm3vzFot6apU7AxXe2PVkgOYdZKIL
	UzOvTilCgE0SFshvF0G8HMdcfKR9SQQ92eZ9m/kdqQ6TTEB7XExrGCU2UKsPh/12fMpZsGfZ3wi
	WpP2IsK8ZDR8fcyKf5frdyGsIalAI2lIaD2eLkcBdvzrTXRdcpCWn2kqF4EbQd24JF9sMACm6tX
	ZCDF4/7oY87P6DuT6U60cCJyUpbNeOCne4SPBDkAWpixp9hDVgtLRDpDJBCeNUzhdjJNZO5+yqY
	re6ydYydO0Zhjpytj3Fs7igeMNm91PLA3FivTzGkQrONnPUTpk4NCHFueZ9xL1iAVSrTixsJTTV
	0BOkVYrotvwRJ5Hp5Kzocr5UoWZoeR1RFUW1eQFmxDLG9Ze4pvcRSAmzvVjW/rl5XGGAuX2jDwo
	v7mvDk=
X-Received: by 2002:a05:6a21:730c:b0:3c0:9c19:6586 with SMTP id adf61e73a8af0-3c8ba5daf6dmr9429868637.64.1785351546675;
        Wed, 29 Jul 2026 11:59:06 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba447107sm1237829a12.21.2026.07.29.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:59:05 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v2 0/2] vsock/virtio: fix worker access after virtqueue teardown
Date: Wed, 29 Jul 2026 11:58:26 -0700
Message-ID: <20260729185831.3247971-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio-vsock workers can remain queued while freeze deletes the
virtqueues.  This series prevents workers delayed across freeze and
restore from retaining pointers to deleted queues, and prevents the RX
worker from refilling its queue after teardown.

Changes in v2:
- Split the worker pointer changes from the RX refill fix because they
  fix different commits.
- Use bd50c5dc182b as the Fixes tag for the worker pointer changes.
- Keep b917507e5ad9 as the Fixes tag for the RX refill fix.
- Use the suggested out_nofill label when rx_run is clear.

Weiming Shi (2):
  vsock/virtio: read virtqueues under worker locks
  vsock/virtio: avoid refilling the RX queue after teardown

 net/vmw_vsock/virtio_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)


base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.55.0
