Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE082957C2
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995156; cv=none; b=KRZ2rCrzYzKyUOxJSEqHFp4eD6CVMJbqJj6Q0Tw0MTkSGvRFuwLZqYEZi8f/5WehGpDyn4dJNZwRyAr+z04WKIweJinhR3LJmCF0+fI27XVAFdcGWqbTSDYRLYrcNdJkXNoijNgJI00xq/QBJn9TLHe9Y12z7CPbQEHKOph+ZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995156; c=relaxed/simple;
	bh=+7N+VHpTGzHKRYSzDk2OOTGyoErfwnToIvY7+I5OyWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tr5yBePLXZjjgwHVUYYbbZlEIjhTFP9Dn8m/VKlmIhxalmLHQ12jfgEITFU560bxCYojew4nKcc0PzNYdB+D8D2SoBgD3z/zIQwt7cZT0RPFr8Z1LMeXxlOG2zHLQNMbNhsqU8oFk6rw5PM981sDt+Lf16x4XcQX/XmUumlb1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvJjRF2q; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvJjRF2q"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59431f57bf6so6597741e87.3
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995149; x=1766599949; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFgy+A0O8xnRgJd7v+RUa9QU+8qq09tdOiliLPIqEb4=;
        b=TvJjRF2qwaK4S9fICejfA6I7Gva2NDWiJJu0CP50gXpCAvaBMj3rXXg9AGoaqnS5gf
         Dt4ewjBhILE0PEilJJSy411XvFar/AQAlVy++xULqVH8tePu4BZh6tEAW2iDpoKktUIJ
         eMMQN4V3tCdedZTA5nUVKQoEBoKy2jnxWeXElrdfJSJ3OX6asgKe4n3N1bdoVVhP189K
         wliclUFTyfKTNru3t/aNzIgWHzKffBxC4eRd5PRud5Hw/JJUIy/hF1kbHoHGCoeIFfgN
         3WOLGJj9/Btk+Bhp4sGEqWIxOxCGfG2KXgNF/M7mnmT+Q7pnHuS0O3bM0Qpzbykq56/b
         Dk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995149; x=1766599949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFgy+A0O8xnRgJd7v+RUa9QU+8qq09tdOiliLPIqEb4=;
        b=Mdu2/EJsj6cn1mNkrc4uuMUX8Cln0OTavpf1WYuNpYs1l3/kNcMwvw23EJjAKb2x7D
         HQWmx2a+bIEgvBDhVPCqJk7q0XDdKbOMVse39radjcZTU+0QYn3NNVQUjLhYJVuYAspM
         W8UHEVtuNe6MJ1en8H3QCUQ4kxRwoMb3hQvdxvwKxRxYU+oTzkfR3tzWU0JbynppewkK
         /UoSWn0zhAY7bAlVN7H3/bTVhhDMEzsGMC7vr5Rj8Te6VO2kB6KeOWs557WmiTapBYZs
         QAdwS8A7UxizeNZozvx+QdSvQCd4/CR54oLSZtThslEbInMKPdF1l/cHINX665aKi9RJ
         D19g==
X-Forwarded-Encrypted: i=1; AJvYcCUiwDKY7IBldJ+us5Sjukb8Mm5Kqd5WcB1R+3iNbbowqk5wNNi9/GA2q/i9kEdwCS0AjSQVdlXZcS9Sd6pdpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCXSa3aNXQkAa4P6mDDQn+UG7on4efeKigyO0W7S41NdrPfRVK
	D1YlyO76dtjssJlkcHvBHOYLrmFxWXypbAuvYxnfMebBslSsslJfOQ/9
X-Gm-Gg: AY/fxX6c1rGFPK4b8e25FrtErtoJabxm8ielxkt1N6nTyxkGlaQg6adFCJXCwKyAMk/
	oayAY6w9DpSTK52meJKP9YWJLQEOf7o/Zb/vsa59llmAIQe0IzztdNHC7jMKICI2anUuJhE8Xs3
	8FhN0u+6yCB/WOu7WBW3cjkG47RIGSBiXaMGgRdPdPpyqmryh4mwQwoh4yJiMWzfsV+oQh+zqR9
	xaL8x8z1sdN+h3YClRyjc3OCYBHaCw5uiPcN/GxfaoKyvxur0NAziowR1Q3RTntDydclq+x6lAZ
	l8LK9zRkaDr0TIuj2OZ2YFVaSk1PPOUpWKKkwI8lHumpDp0esoV46cJBc+EsHloBZyxsfxxfN88
	/BUR0jztudOJ8sTLj+88RIzEqfk+29vUkRGxF7oGYp1QR6vBzA541EGjH+NfS8LX7MlamK0RrbR
	O8kU5gtAg/i4U=
X-Google-Smtp-Source: AGHT+IFfAzzjL2doo80fXCqAexQGKSYqtRni1yb9UdVue4KNR9zAwS0Jwg1qOwIOBuF7UQ4BiHcjjQ==
X-Received: by 2002:a19:f60b:0:b0:598:ffd9:9da with SMTP id 2adb3069b0e04-598ffd90b06mr3767074e87.7.1765995148960;
        Wed, 17 Dec 2025 10:12:28 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:28 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v4 0/4] vsock/virtio: fix TX credit handling
Date: Wed, 17 Dec 2025 19:12:02 +0100
Message-Id: <20251217181206.3681159-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes TX credit handling in virtio-vsock:

Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
Patch 2: Cap TX credit to local buffer size (security hardening)
Patch 3: Fix vsock_test seqpacket bounds test
Patch 4: Add stream TX credit bounds regression test

The core issue is that a malicious guest can advertise a huge buffer
size via SO_VM_SOCKETS_BUFFER_SIZE, causing the host to allocate
excessive sk_buff memory when sending data to that guest.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
recovered after killing the QEMU process.

With this series applied, the same PoC shows only ~35 MiB increase in
Slab/SUnreclaim, no host OOM, and the guest remains responsive.
-- 
2.34.1
