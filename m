Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418197;
	b=ZWZ/c4O2/q5v1262Nm2yi7f90TvMIljdwKwAlxbaY00mQWG15rRTVBbPiH9EabMBycwx
	 eCfhGGsSxqjHadtzaGIJBhw0cTZBRMiHE4UXvurylREk3tIVTU18fssfVeZ61KrbbdaO1
	 Z5xVvSqIBxruXFyAF+NN4S10qz0RKSVs7aTLGDiscr3uRq/z4dPjjVOahsOk0O1iN8cky
	 nLcrnLkFrcW7V1FNZRCzaGN26ESZRkRwC19roFGHdckgRyYmbj7dXTctSc2e1/aHknqI/
	 asUxjHFZcN+uCqAxp5h4cQhPF2frP2ULgJH69tl5Rsbe09P7SQqT2JK7jPQznMz2O7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qb4IaH1Y+NwiJfbuO8J0Ntl3vMKNwARo+dMo50vQgyw=;
	b=cA9Om+rGNpdvawb+tWv/xVM6qT/dSNVjnKeB0X2jyOcVeDjNrD6HrgRoyo5R8MeMSywt
	 K+YeCRv74QQ3L9eBZHS2wGXRHGwg9625VIIjjCWidMrwdoSzrJQlgHqSuod6zOTTSOJul
	 /zXZlcMdPrMKuSTV/wS23AaWEYGkXBDsVWgBFK7rmMtEZlRl86rboFtUeEwe6tvytFPwq
	 rBLE6ArUJ/b+jAUzxLnPtsqLGQzcxdYi+gUWjWGm7ZZY9ikoeqvEfpCgofeBvtQ7Gkbdx
	 VXIrHsb5rqmSpD7GjQkZ/g487j3wY1Y+SSpDV0z/MLQDK5sH5QIFSrCFDJLkK560WrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8hgZ+YC;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B60606A32D
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 17:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B60606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8hgZ+YC
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b467581b98so31487155e9.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 09:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794418195; x=1795022995; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qb4IaH1Y+NwiJfbuO8J0Ntl3vMKNwARo+dMo50vQgyw=;
        b=p8hgZ+YCpuScsBfWe/ZzvTq++T+kxplVxk6rs7jEOEUN1elL/Ef/msb+a7rI4VwO7b
         msotV9QMWk1OR/ycMBHHSQAlaB3mEd41kAURJAf6mUChJ5bZjfG2368I/PnjqYoheM8Z
         PdnNbsYI1nnXgMEZR8HB0wu9ToiTpyHnwWUCnjdd+9f2J42OTKZOlWWKNiajoVqnH4Cn
         pklty8gdQGra288itIfbjZL5m5IgasU7ghydCgZclEvr6cv5tQEpE3TGTI+EOpbNPLQV
         kUQLgReHbJ+fV8ig/QQkrqkgsZx7uGyVYXXNsnaRHAoxtJZoH7ram91uPJZNQiY0ebBX
         2WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418195; x=1795022995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qb4IaH1Y+NwiJfbuO8J0Ntl3vMKNwARo+dMo50vQgyw=;
        b=Z0ogpD5Fh4rdOv5U+PZ6/pz0ecqMvtRpPX8I9VU2hvKehClvBJGsEXO47gQRFSfTgC
         sjOtfDBdsowTijJCEppSp/dLawKpyou2HRNj95uDaRatoLiPmjHZsO0mO8E1Y0RUn1+c
         oJyFWGDTcm/yue1JAIwjZuZEwR5HProxBc8J5FLsG13oB767jOKy4gpvxRIBtkVf6VrZ
         jJ9WNiruKwamQWwx3Z6TrXeHX1n7u8TWDc2r1NYdzW9y27jOfuRYqCrXHhda+4jYTr9K
         HJZRuNcemNTvDZWtpDFVlnRyscGhahy/SYu8lzOTNubvsu5S+3U4zGv/suD7DhO7hKT2
         wxmw==
X-Forwarded-Encrypted: i=1; AL+hErFQjCr0wDv+Wit5JX83A4CAQsu0xvCvVYd4n3l2S4wsam1QhYZdjNeSblRw5MfocRldFJ0x8ap7g25nSxAHNg==@lists.linux.dev
X-Gm-Message-State: APuU4Z94CxqYZ6TgtV/MObDwKgGGHAZHl/9LysA7jjpwNyCdQIbqoCyr
	BZHkxBl/DRtaVQRCELL2mJBNBm3tVOUqwjk0h0sp3d5s06UoBC+XwvaS
X-Gm-Gg: AYBFou3ni9tJAjrJxlPGdC6khTBbWRXdAoGda8WH+QQ1RSA8dMV4aeRS60aseqQ9ixD
	jGFWRVZsvWJMczkxUPgzHf42f6WJLBF+JDXnBcesneX/7OCNcByEnjDgE7TrqabWQNaC3Inot4d
	DKU4kL2IRrvi/kocERgffsabiI+GcWCH2f1AM0rxwSGgyZmEtlDoK1oiiTmsYZSgllR1NNYH/Dr
	xYvHC0jaeZFlEzUj9fpf5aseaoKTbXx/6fVQ8Sr4oFWLmddWm1aqx44U7tb/JyYYL3hgJndw+mY
	vfym1l8u14oJZPx/OlVAAUpIZ0tkHpnFg35qdV8HQgLIKtjpCmid5URN69oqRRsITW9ow3KkMFI
	4pA94+Jr6v8T3ON2M+CHwe7fmEuU+lW1NE3mRrpz+/EyxDF2SNm3+tIuoB8pC4k4tZGZmrD+Ctq
	8voUMCjyLWxEK9zQ6D1wxyLb273Qj4Ixp9NSur5OnOKB8p6blT3UKUiYJldw7iD+IRu01yNuUYc
	IA39WbF+TSI0bI9qvXIo6higrfo/1VuXcak6viEgjFycuPxjmJZcsb8Y513tT92bz+s+xDyoHVD
	EdAaDk9SkOt71HkFHJEci6T6gdxXeUPS9Sk+HLEKSSNzH3DB6/TFur6c8xixdRuQAJ2h6oLSw5v
	g
X-Received: by 2002:a05:600c:3144:b0:4a1:a45a:88f with SMTP id 5b1f17b1804b1-4ba0939ccc5mr56490335e9.20.1794418195313;
        Wed, 11 Nov 2026 09:29:55 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:d655:6a9b:5ab8:7f68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e26700fsm3134525e9.10.2026.11.11.09.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:29:54 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] virtio_ring: reject a split ring size that is not a power of two again
Date: Wed, 11 Nov 2026 18:29:36 +0100
Message-ID: <20261111172947.3579982-1-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The split ring indexes its rings with num - 1 as a mask, so its size
must be a power of two. vring_new_virtqueue() lost that check in v4.6,
with commit 2a2d1382fe9d ("virtio: Add improved queue allocation API"),
and remoteproc passes it a ring size taken from firmware. A firmware
that asks for, e.g. 100 entries gets a ring on which the driver and
the device disagree on where the buffers are, so the device can read
the wrong ones. The only thing remoteproc checks is that ring size
and alignment are not zero. The other caller, mlxbf-tmfifo, uses a
hardcoded size of 1024, so it is not affected unless that value is
changed.

Patch 1 puts the check back; patch 2 adds a vringh_test case for it.

Tested in userspace with tools/virtio only, not on remoteproc hardware.

Stjepan Poljak (2):
  virtio_ring: reject a split ring size that is not a power of two again
  tools/virtio: vringh_test: check that a split ring must be a power of
    two

 drivers/virtio/virtio_ring.c |  6 ++++++
 tools/virtio/vringh_test.c   | 11 +++++++++++
 2 files changed, 17 insertions(+)


base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
-- 
2.53.0

