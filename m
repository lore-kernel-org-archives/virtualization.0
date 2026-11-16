Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821090;
	b=KTYDVVv9pdqF1rTZ+fwd7FsobEUHn6Zt3OWZC7XeNi6njCHqQ21al9sCu3tFT09Ct/YQ
	 1hFGNRSQiFXrghDlEbZip3fbk20R5jREt/pOmV7Jj6JMKNoRKLOYErjVFpk61+K3ML1UI
	 MdlQ/SY8hKaHHd1XIFoj75tYyZMU/71V3F2MLgR2CJ8wIFtuwUPbzEoLHx1g/8HMKz3yo
	 Gc3ASad9N8glY2zzOxuUq6fk3NOb7eYkn7shioJ7yAS+yGMGk3hTEG+AC1Em8ts94ukHs
	 RBph4kTreu4oLFYCM64R12kEAkFFNeU4Fx7ArhP6FjFpU9nrzBHGCzJiTQM4su1e53g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2e8OfKa72MuG5l//Gx+5Pa5JLpMbf0mtMmXDlvYAirg=;
	b=QXj5CEGoqaqtrx3JDPDMMgeLmqijLeLE6ayCQlKyVHwqhftlPioRbc5OT+N7FWNc5uZA
	 C0OzYlO7aFhE+GLaS9x6MLUZkg8OVnDjD1WOB5ULr8y6KxkEHKNTwkNHacTJ2lGyXwCxT
	 vJgChJ7hIKLDcHm+d82rrpQp7ovb699bs/Zv28JcCSH18gx0S4h1Q/vkxowqZoVT2wR7a
	 36QPfF5Lqvu2S46tLDTHno9GBZ6rxbl+aUx+0xYNav/8nRduJ0eV6CkIunh1m5Bqy9ShB
	 RLOuflxtSEkrJ5H+9cD9To/3FkbV2wLhsZjFnt4GyyD8+VGrC+Au4EQ1IDdxgPTxUAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=Mnprid53;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFF606A329
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28CFF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=Mnprid53
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-37986eb6fa2so3878228eec.0
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794821089; x=1795425889; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2e8OfKa72MuG5l//Gx+5Pa5JLpMbf0mtMmXDlvYAirg=;
        b=Mnprid53+pL613XI6LrMr8eaKOuD+q/iF8MO5mXO80z1sap/YkV/i/h+X18nzHrQUH
         6bYLREe81MA5uGIQKyqe+KUcjM7L8EEgXgZWzqNBMe5M/WhkuPKOWa5NX6nUl1xTzLKi
         t1Bqj1dRs+IKiU1mpgfMsBrBsAF97inWKA8h4SBxMedbgzprwL3mgkncvd15tCoMJWkx
         SZLgOfBnWHXhkluctzWEfeEztAyBpsvY1+j1COJMTkwAy/m6wd7Mve4dCzF7Wjj12ffT
         yvd3Qf+w4zc0QUwgLwUfWr/AKfc0n8ViN315vGRBdahNXP0LRpYBx1+d5dzQyI/1Hdl+
         OmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794821089; x=1795425889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2e8OfKa72MuG5l//Gx+5Pa5JLpMbf0mtMmXDlvYAirg=;
        b=Z0IYtjOcsZqpzDmP+isHy0833ye1eXgJ6FAGNMv2XxEBn3OqBA05y0oPoiERJQyJ77
         5fBnCjqym4XLGWPGeXy07vpn9X5x5rdpk2O1bs5EqqinnuvlqbP8mghfLalRlW2PjaFx
         Z6CP6Gswn2nBM1EdQA0/vycRzI08qdzSxqCskY40JgEQC9vZXZF4eWsOBIKaNqgsMoEJ
         +gwEWEYRAK+F9y6M5hLfp9yui23BpUfnKNbiPVobe8UfaZqIkNxuHc3eeiuvq//cWhiR
         JNyCGNzwo0u75QRcB+k06lZCIsucAj34Nkxdxz9h6Uqt7vHyuwRBVfT086Q8LbWUuQOR
         5kwg==
X-Forwarded-Encrypted: i=1; AL+hErG9dbEvevcNS4mDDmzpLTVDzzHDJUkNf767iy9IY7hYg3fQQHD/YePor99piG4bCA8B1xT1zCRCxkyTz5GbaQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8IDFK55xlFW31tSBzIYCnNuMot7DbudGGTtVlL6xItbkCC725c
	y/7+tWaGBOGNPhnSnJ7i71RlmrGzN34wi5UxMYgejAIFjlBeRj3LBqC6+i5OfOW9iA==
X-Gm-Gg: AYBFou0nU0n59jg77yrgE/GvfLuloo8ecUsIercEi3r/tWtPgOwXXbL/4kNm7HMUwsf
	K/nQSs/3ez0DFNtpLttLaT4rKIU41dd+1Osng8PGyjdtEcvuKMEKX3hw9sVoB8PkUwEkO/757C6
	9KE6wvzNjYFUpG/Z1kCzcF06SMWtPygUUEmrwpYqASdHT0cKq514sZBcQHqeKqO+mmDlLWcC5Zd
	vq4ACdVnq3xBwkp+sCfV9sea7KQr1mk+iKuPbGpRpcAOa5wS7I4R/eL7Z/po0SvUrpC5qdgxojT
	shfpA6eo3b9GYV0ro//91BmCJJhKk/VdX4o1tZAD57jEwM5se1zdT0s7OsMxA2Qam5iVzoZmbeF
	p9RsFYynfdA+ScsrESU+QzlRD7vuUi0ch+sNP7ZtbeCD7bI2PtxACTUJovkTGjnh+Yh34Na9ylt
	yvv7BleZ943OHBEN21VYCOnl6dHWAzieqJKUJed4HKsekmLsHEYx6qI8Z5LA+ghfRbolPEharmK
	hJzsB0GUIA281b03TQX5V3xoQGJ6wA4u+zq3xAz9VDlno6SjxXb0RgsV4ik8pbhWf8ZhsVQIuMq
	xRATCeRKUW5i+lZsah+4BPl14vS0RpUqJPZLCA==
X-Received: by 2002:a05:7300:dd03:b0:351:2958:1740 with SMTP id 5a478bee46e88-379681c67bfmr9514769eec.37.1794821089011;
        Mon, 16 Nov 2026 01:24:49 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32056314eec.26.2026.11.16.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:24:48 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>
Subject: [PATCH net v3 0/4] virtio_net: fix out-of-bounds accesses and a heap info leak via the device stats reply
Date: Mon, 16 Nov 2026 18:24:41 +0900
Message-ID: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.1
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

With the statistics reply, a device can make the driver write past the
ethtool -S output array (patch 1), leak stale heap or loop forever
(patch 2), and read past the reply buffer (patch 3). Patch 4 returns an
error when the statistics command fails.

Claude Opus 5.5 was used to audit the driver and draft the patches.

v3:
- Rebase onto v7.4-rc3.
- Add patches 2 to 4 for the issues raised in the review [1].

[1] https://lore.kernel.org/all/20261110001659.1654289-2-kuba@kernel.org/
v2: https://lore.kernel.org/all/20261102205550.4148064-1-lian@is.s.u-tokyo.ac.jp/
v1: https://lore.kernel.org/all/20261022182710.2055771-1-karin0.zst@gmail.com/

Lianjie Wang (4):
  virtio_net: reject stats replies for queues outside the request
  virtio_net: zero the stats reply buffer
  virtio_net: keep reads of stats records within the reply buffer
  virtio_net: report a failed stats command as an error

 drivers/net/virtio_net.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.1

