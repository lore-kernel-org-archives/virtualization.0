Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11E131E49
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296418; cv=none; b=eCv5M+oL/geRkNmh7+IWzVPmaiGoX2UnGhORdJjMQYyNkrWxeNtsFJMJ31Y4SHkHLhYbb8rnOfaraGT2upQGaOe90LmyJCv7iEvPih1z0HmnGxIPzBobjZPhHR01MwUWSFFdZhxkWksg84/NhGuX0SXfAOG3d6bVPqjPBnSjIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296418; c=relaxed/simple;
	bh=k58GZuJHYrRAhM90IDPE06kWAdBsf2cIPBiCOV5OIrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tn8ebZSuAtPCogSevmU7v1SYGPA9NxmiPrEC5jMjzCua8TLUftsz06nxItfddbBDC7IsA8w5L1S4uPDfvHn2j9FiEylWHUUrPWfK8pBsUgzjYO1IqjP4KNjCoyPbFHa4oaiOOqF7vjhmuqjbrPlazJ1xQbJ6zTNOk3KvfFaZDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfqaBwmT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfqaBwmT"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b1fd59851baso1813064a12.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751296416; x=1751901216; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlH2qMX5NPIfuMoovjH0+8ChqNtC7Dxioix+iTeV5vU=;
        b=VfqaBwmTmEz2FqzBp7CKVImckezfFdzwoAse0tf4CAiXxxVF6+BNeTUV9yQzTEYglx
         mdv3XK5cimDu9sUhQEIDICxbdtxANCASfqAsvX5zdNDqLdhxRHGxIyD0087OVuESnYy5
         JN3GUkwGdsZbwV6YTDpB7074kSaUsOaGuV74CgCVO/um51/obftChkPlgYl3kT3DQ9tB
         sn9260UUoDYwgo614kWpOd4ddOqRxGf26aWyQiXeFHaFEQq7yITZ+58ag35oW4AXGjtG
         3vUjILF78hyiuaVYN9vU5HN14X445Bvn1H/QWS1MkF20sJ8fMEMft5wfQT12Aoq9sBGn
         SXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296416; x=1751901216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlH2qMX5NPIfuMoovjH0+8ChqNtC7Dxioix+iTeV5vU=;
        b=Y/D/Z3DkPnMgx5emO3fp/ynaeZZrjYMCHTHJkW4J6KQlYtMFCkJrqL5LRBNjMPNLEp
         0Ncvy9DmYzDbL90uwIgErpaxU2ZeesrmsgWIvmaKnzpirCd70otH632bMLmZXkwGkHZp
         c3yvzGTmYb8qiQvmv/yvU4wC6xjIprtcHV88oJpnoX6bWWUcl0xBzxxx+3Y0uzavsOTs
         IgLBGiGRCN2OYWEkl72gu0DJU6+MtCrVubOBLNtBnWqfmNB6FBWxs6iWK+BBDJgdtWFF
         mdzJxI6+K1ZypBveEnfjOxLEq+cV7R7DtckA82iBIAWATSwJuMuJAWBvQW4jselm1rx2
         3rDA==
X-Forwarded-Encrypted: i=1; AJvYcCVf3WxE1x0vVn1M1zL1drNdjmSxDA68cqKXfvJ+1JOYL0f2s9rISZ4DYmlmeBtv4TLtBzHi1Az4weSATEwXyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmDhI3ZpglxMJvvpm4cRq2wPKN83f9J1baSK7XE+oJQdFWnhhA
	P2OWZBWZ2a5Z4ZTXdaTh6m5mdijgBqaFTZOyon+MHnwfWDHJi6UX+PKB
X-Gm-Gg: ASbGncscokNxCdtNktvi+bODLOwA/YLOtfEm33xgHNerGzGJptK4nBe7ulsDTYxAZfK
	BEIahvWFguwsxq8Lv0j5AWEDjtjz4wJgZpA2YPpfhMO0NN9NIwfR/Y0T8JKYnoUPIrpDVDFDbys
	wRht7LCT5EvwC86jJAHzK1pDg9et8e5TybHFNSf+lYGhd8Uxr4IHm2flhL0bld07ze1Cd+u80mq
	7ayBd+xdrHE+p5PjJSyjZsYSNBvL1ruFx0+/PWkxzHtLxjk9l/1e/eACNCOd27j0ysORDPVv1XU
	oRQcjvVZ7taOEoTT4nzSqtBQ1CnNd4zWVQi+tv3h5CJ8IJK+xEIGhfsD0EdvAF7qM/HoXTW3cnJ
	l2WdcuLuEVWU=
X-Google-Smtp-Source: AGHT+IEHjdsV4PX3mnbaFgc3eupt/9KtFkjn673YTl/KgF76XdRC/TOJHwt51lirmUp+LYcjy0ZpgQ==
X-Received: by 2002:a05:6a21:9ccb:b0:21c:f778:6736 with SMTP id adf61e73a8af0-220a16ebad9mr20642436637.27.1751296416016;
        Mon, 30 Jun 2025 08:13:36 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b34e31bea17sm8323340a12.46.2025.06.30.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:13:35 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] virtio-net: xsk: rx: fix the frame's length check
Date: Mon, 30 Jun 2025 22:13:13 +0700
Message-ID: <20250630151315.86722-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series contains 2 patches for the zerocopy XDP receive path in virtio
net
- Patch 1: there is a difference between first buffer and the following
buffers in this receive path. While the first buffer contains virtio
header, the following ones do not. So the length of the remaining region
for frame data is also different in 2 cases. The current maximum frame's
length check is only correct for the following buffers not the first one.
- Patch 2: no functional change. The tricky xdp->data adjustment due to
the above difference is moved to buf_to_xdp() so that this helper contains
all logic to build xdp_buff and the tricky adjustment does not scatter
over different functions.

Version 3 changes:
- Patch 2: use xdp_prepare_buff helper to initialize xdp_buff

Version 2 changes:
- Patch 1: fix kdoc

Thanks,
Quang Minh.

Bui Quang Minh (2):
  virtio-net: xsk: rx: fix the frame's length check
  virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()

 drivers/net/virtio_net.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

-- 
2.43.0

