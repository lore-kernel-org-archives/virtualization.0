Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C81FF7DA
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498120; cv=none; b=lzHizhBf64yk0ZnxBZcMPUgmEC13zEIiqNTGWEDSEev0+Gh7eB7sOCYH0GwogupcHQUAgWSZUOQHpxM2zUnQFlCeD54L6aJSa49wmWk+NaCiqKXEU3qIcUgK4c5lXScRMctqy0S582vU62euWASnmW8PTf6/Sc/+/G3iE6R/pGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498120; c=relaxed/simple;
	bh=QijatkL6bTXb4QjXb8f+a6DCbXKfBlg4o0lO26tSjvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KiL+G9kS6b8NZC84Bi+pHuO+abeWH9azw68yYV6vLjfguhZgG358cKuWOFifpEal1MSxJbJ69DQnOCjul4NEK1x+tcCzXAjTz6Q4iUORL7wqOyqrzo3mGuRiF2wlktZfAje0A+B7bnBK9o0T1tfjVufa5weq/0EX7j71Yub5aSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1KLGp/6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1KLGp/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yzh6BESNkCmUyBWDujO38MFMNfd269W0kyJHQMOPcgo=;
	b=Q1KLGp/6jBPTukyqyao4cRj8eZwT7TwMKr+U/54CnE13KfTZ2Y6C28vHJPI7CbB7aCtnEE
	HChrjDtnX8R7n6DrMaPYb2Ijk9SRjR6c2ViF3eC7JM2Mq1ZB4kYd9P2y46zCbFwzyTfp8k
	LeBmiVjz68zQ+RnzcRkGdmTBkmkIX1Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-AoC2XyYuMLCsq5IAVjEvTA-1; Fri, 10 Jan 2025 03:35:17 -0500
X-MC-Unique: AoC2XyYuMLCsq5IAVjEvTA-1
X-Mimecast-MFC-AGG-ID: AoC2XyYuMLCsq5IAVjEvTA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436248d1240so8722385e9.0
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 00:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498116; x=1737102916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yzh6BESNkCmUyBWDujO38MFMNfd269W0kyJHQMOPcgo=;
        b=r/dOZSvVREyWO+9HDOlXKR58/IlWWpiSPKgllcKAxGvN9HXv1ZGt4/9wQuyCZA80GL
         xhtSLHVDwAaAtoc4/HNfyK88tgY0G990KKy+8rKr2NS1Urt3BCW3y/1zhUhgzbSCcnu7
         A7s8D6atw2RX1RlAW3flr0YxYHeG4LVcH9kwcbGKpPKmDe6JyCyoUojqY4qTXGOlox2q
         GjbIanaKzpWHoWTtrPXo/hDXCI0kakYbt9mFjmAVBwkT9iBNRjbGZN0OVA/ozXzzyPq3
         J20zyYce30AJeu2ABOSc439hfUB6lQo6aA9oYQF13yVs75o00JP+ysZzDLDJA5Pq/njy
         KIRg==
X-Forwarded-Encrypted: i=1; AJvYcCVN2XUJYqAFtEci2H/+QxDXq5akGXikeDHGNn79n3v0FBymjHi2IBj+sxnCIKvSDT8Bcaaz2gQyh/pKH0Caww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpHcAiZM8c05woCu0i+ULR/lZiW55JDwyRNRalsiF3v1j3JH3L
	2bVAEJyMgAkBhiefAfzXHkey4Mh5hGoYuwbqT3eWRdZeccEMcXPvpHZqBpLx3ByTmoS8w+AIsR7
	KvJXVKn1TiWBV8GxqAK4fA+mZEg8FsHOe71zkj8iir2k8ERijmwGSfkBmkZ37a67G
X-Gm-Gg: ASbGncv1cKCw2nxvHGZjI+tBipkoFkoKdygv3FRQxG+2B5FXuJHmhqAHLxMauB9M3pQ
	1I6yB7Kuh00O3VQYFj9k4EG+rBznFpqkcS1w9ZssfPHLIozlFnKO7cvte3sLTG+6rCFR/52TXUJ
	xYD6lFpPtzF7YCPwaVhhuarN29lYCxETpZLdAJ59rKCdgPnjV0bV4QiHjf+1G3K45uzXxR8cu/v
	zS5XTSSMP9Qi7+frdhDcFtdp26PMC7eD6shVd0G3bJkxqA=
X-Received: by 2002:a05:600c:1e0e:b0:434:fd01:2e5f with SMTP id 5b1f17b1804b1-436e26ef441mr85679715e9.29.1736498115838;
        Fri, 10 Jan 2025 00:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXWC3jUEXmmFtLxV2Q6VbhhNg8qt0/mZE4AbvDPzxpMk49Vg8ocWzwB7SpzfJcC2i53xpVFg==
X-Received: by 2002:a05:600c:1e0e:b0:434:fd01:2e5f with SMTP id 5b1f17b1804b1-436e26ef441mr85679275e9.29.1736498115183;
        Fri, 10 Jan 2025 00:35:15 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8a326sm79953575e9.35.2025.01.10.00.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:14 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hyunwoo Kim <v4bel@theori.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net v2 0/5] vsock: some fixes due to transport de-assignment
Date: Fri, 10 Jan 2025 09:35:06 +0100
Message-ID: <20250110083511.30419-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mFbcEjiguBuByRJvU6M5tV1NGlsVol74A10BbWbea2w_1736498116
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/netdev/20250108180617.154053-1-sgarzare@redhat.com/
v2:
- Added patch 3 to cancel the virtio close delayed work when de-assigning
  the transport
- Added patch 4 to clean the socket state after de-assigning the transport
- Added patch 5 as suggested by Michael and Hyunwoo Kim. It's based on
  Hyunwoo Kim and Wongi Lee patch [1] but using WARN_ON and covering more
  functions
- Added R-b/T-b tags

This series includes two patches discussed in the thread started by
Hyunwoo Kim a few weeks ago [1], plus 3 more patches added after some
discussions on v1 (see changelog). All related to the case where a vsock
socket is de-assigned from a transport (e.g., because the connect fails
or is interrupted by a signal) and then assigned to another transport
or to no-one (NULL).

I tested with usual vsock test suite, plus Michal repro [2]. (Note: the repo
works only if a G2H transport is not loaded, e.g. virtio-vsock driver).

The first patch is a fix more appropriate to the problem reported in
that thread, the second patch on the other hand is a related fix but
of a different problem highlighted by Michal Luczaj. It's present only
in vsock_bpf and already handled in af_vsock.c
The third patch is to cancel the virtio close delayed work when de-assigning
the transport, the fourth patch is to clean the socket state after de-assigning
the transport, the last patch adds warnings and prevents null-ptr-deref in
vsock_*[has_data|has_space].

Hyunwoo Kim, Michal, if you can test and report your Tested-by that
would be great!

[1] https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/
[2] https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/

Stefano Garzarella (5):
  vsock/virtio: discard packets if the transport changes
  vsock/bpf: return early if transport is not assigned
  vsock/virtio: cancel close work in the destructor
  vsock: reset socket state when de-assigning the transport
  vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]

 net/vmw_vsock/af_vsock.c                | 18 +++++++++++++
 net/vmw_vsock/virtio_transport_common.c | 36 ++++++++++++++++++-------
 net/vmw_vsock/vsock_bpf.c               |  9 +++++++
 3 files changed, 53 insertions(+), 10 deletions(-)


base-commit: fbfd64d25c7af3b8695201ebc85efe90be28c5a3
-- 
2.47.1

