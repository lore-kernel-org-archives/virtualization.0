Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C326C3A5
	for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867800; cv=none; b=bjWbYUSm9Mb30Po75W8I0S0eoP4wdHNeY/8pf6Pct5UjpZyMvZGv3uU2V8hRUNiO4Kce6vTYZXURakNXwcLbAcp0zvHanloxcdk64wuPguQMUYOAIThxtr1859+hbzazbHEakxoisKO4Rj/J2akcIYWZBEXCFJbFYDia59Epu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867800; c=relaxed/simple;
	bh=Bts4sKMHlh38RUT+rVnq3w77/m2jbHWWcUQgUFHHQww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdmPihL5EJCUp2UmYozENaYUoar96C2qJW50SBcFZpNNSg8gnbqZS5kww8PsdLGHw1vtdV46PaXy4R54LGrilSvQU83wQmBGP712X0UWIlebWIvPYRckjjRP3jWE0N4tZrrUko3U9vWbphKakiFf39sYETiYMUw+HDyf6l5nfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUSX3tYF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUSX3tYF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234f17910d8so710685ad.3
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867798; x=1751472598; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb0acdpdU/b+qFj+DYgvVF8IZl61dx31CclH/vhkiBE=;
        b=GUSX3tYF7pMfIQbomAI45HHLJEPIflZQJAzeT5/G2vb4vPj4cnSbj9V53jzaawrIJR
         qOodLa4rGRV+xy50mJoN1R1DJK8luGE5CYhZRgGGjgyP3maw+Tbg+M4HjA30NNFgSSdB
         V5CUkGQC807PjV0xLbqy9U2QDiIXVXC/bb+ie16hgO86asvzYhPo/bEbRhy1xIccK/BH
         ZmXcEsgk5FL1eJ65n/WQQ6jL64ePsI173bJw5ehs6HTxIIslve95E5NauYHvauMZ1F0O
         lpaWIiiLNmxUZl2MzO6w2/NPpmu2UOMw8Et1YqIvncxoup4EKkChUg24r4UHPbzr3NS2
         /gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867798; x=1751472598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eb0acdpdU/b+qFj+DYgvVF8IZl61dx31CclH/vhkiBE=;
        b=o8KTOvJlnei1+lNexKgzjjB9pVnOwAqNCp1SfZO/KC+4gBKvAwgAX/8VSiDXLG8xGe
         LYlZh4JEIv2RnlXmRfP8cOCUfMpfp2vIcU9CqIAKBrnDkwsaaQP8ZuzImGbzj3YgXOWG
         go2+kfMJFS1UTt8VQds4R747rJXlmLd/JlskC0244v3E0mcdJSGvVh4qP9BdlNrlNgMt
         RWWrGs9L1Tycb8wYiBrjX426MC1yyOngLJKTS9cy7rj5PjHRyDgqJi6H3b9zaBnvpD9v
         jNdrvkSpjuQSHl5HHKcxRppA7+MNShh+OPXo6PUMonfhd22VmHTbXPdeNFLnYF5CPGMA
         btYg==
X-Forwarded-Encrypted: i=1; AJvYcCVQR4Htbh12GNgXd67FYrytLlpFehNeH9cPGshSjoniT9m0PxzFQDajfjC6lkEXqdPs7IWuGkZ2Jov1glfzMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyclHVWHp0AFhRuZXl2hcFAJfyVRwztprUklDwrnaa0ELRl1RWk
	wSy7Pm6ingG6bOmRLGkmE7b7alzNnp21fC9RVmSR8pCd/DscODwg8ZpX
X-Gm-Gg: ASbGncudAet2xsNlDhTa9AyGIreCuCUEf9/bifpLZQQwfZ4DRGGva6B2oxzEQEE7Tbm
	98EZBIzbQhYrGgDn+5SgyBgdR0NjCbeunczaXgGJg2AMGIFsGRtCBPhvIPiCevrwS0Qj0mQCWft
	E0acorViMN3rm6IGDxeH3FTvrIEA95CIo9oWBXAxbWX4FOEprVilpiQ3ctArdTqgbQpYUaZh2TX
	zZ7CR3JgEY9NkDzuxae7T8THKCLZZsXOJc4qWLhB7klRe/u6vEDhNHVK5iWCsOUXpu0UDelyetl
	NVctmbrXX2lV9UXW3dsoOlDLo980cML3Xg06t+6hiTX3WAZtz7NnsXv5HjihHRQqGW8Un5LWDDc
	bIQ==
X-Google-Smtp-Source: AGHT+IFGkbVCJI4WQD7GIL1MO4VOQNGAkZ5VrytP8PK7QMxS5HOrsRj0liKcJ/cDXDkibp5t5sKjLA==
X-Received: by 2002:a17:903:42cf:b0:236:15b7:62f6 with SMTP id d9443c01a7336-2382424be2amr48545785ad.34.1750867797808;
        Wed, 25 Jun 2025 09:09:57 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1cf0:45c2:bdd1:b92d])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d873845esm143219175ad.243.2025.06.25.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:09:49 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 0/4] virtio-net: fixes for mergeable XDP receive path
Date: Wed, 25 Jun 2025 23:08:45 +0700
Message-ID: <20250625160849.61344-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series contains fixes for XDP receive path in virtio-net
- Patch 1: add a missing check for the received data length with our
allocated buffer size in mergeable mode
- Patch 2: remove a redundant truesize check with PAGE_SIZE in mergeable
mode
- Patch 3: add a helper for mergeable received data length check to avoid
repeated code
- Patch 4: fix the flaky drivers/net/ping.py selftest due to frame drop
when the receive buffer is prefilled before XDP is set but is used after
XDP is set. It's because of current restriction that
headroom + frame's length + tailroom < PAGE_SIZE. XDP does not have this
restriction, so we can lift the restriction here and continue processing
the frame.

Thanks,
Quang Minh.

Bui Quang Minh (4):
  virtio-net: ensure the received length does not exceed allocated size
  virtio-net: remove redundant truesize check with PAGE_SIZE
  virtio-net: create a helper to check received mergeable buffer's
    length
  virtio-net: allow more allocated space for mergeable XDP

 drivers/net/virtio_net.c | 91 ++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 37 deletions(-)

-- 
2.43.0

