Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716294;
	b=kKBcvft+w4s/65H5Rr16pCJnf1qVXaPsFvoTQc0kCyjVqm0e9sHmL20orhJEOIe0KrIB
	 na7tHKtZAbgXb0mb+sx/ursRTEvqR26f2u6iqoRqjTqF1eXdOInWO/+S8j5Y1IMRulmnV
	 NHjJ2/I+cMcR9zwEtMBcug5mMXSFI64320E6O1ZVuHMmQRSaP5MqWtoZK4+CsZWCll+1X
	 ykinvv5bLD3cx9x7e8Er6M4p8NuowQkoNBnFcB8EyQMTdQN5Gbbp/Hl0I6wwsb7+gMIFD
	 Sw14qRxd1tIIdJXQUVwjSiBcuFvUT824sPVIIFzzZyvQx9hQK3PMj3yNgQ1c09c23vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=EKlM9iD6F1gyXy04opeEG9+C51VAWggNyeLVBX+b5pY=;
	b=fnoQoXVIcDGcdOT46t3kIIK/YzTcrkbv/oOiGODpDuXQcW2aRXT+dAs7j/gxjBhc7mX1
	 kXn5t++oyq+pNDYn3LpvF1v8o70RZDktUWyQ/cJ3/3yv3LWFXMGYC4l9aIly/M+IeJ5Hc
	 +yUlcaWJTYJxlfmf271gTbefZfoRTe/hmpcLZm0Otgbk2pOZzEnWea+fP2rWV5q8Vcw/q
	 xHkcHAJvvOZvtzcZ04K2XtRPFnxujAKkkwYnAeEaKrt4x/C1QJNFOfjMkI6mQ5PorvxEJ
	 qceCKKE4+KGV5Pdir38nCegIYCsY0yPADGa9YivacGfeDfhsoDjR6LG1IWpE2gD6PLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SeX4Ngp4;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE0608508F
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 14:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FFE0608508F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SeX4Ngp4
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so5954852eec.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 06:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716293; x=1794321093; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EKlM9iD6F1gyXy04opeEG9+C51VAWggNyeLVBX+b5pY=;
        b=SeX4Ngp4cuQu5dNC+rcEluV9bGK3QARW7jp5a6Epo0TSUehLhDQvlhe2DxrrTJOqVI
         yo5PzshfngDpys1qLH2ZGQtMor3OOWwuogmdDcJ7La5Vnr0ginXCLDXZIraiVM836W+M
         2PgzUPWZk7648ig0dbpldab9bJTbLhXJvfvpSZJiNHsAkdyvsYwQ6qR6Ol1CKRK4/QNF
         8IXNBMRkQ6Kzwea3nI+c6pp3Ny+yZP6NB/cFLozmqit81rFtl8y88YTNi73Lg171b1/W
         KIv0d7MzrtDGWU8KO//QB8alA7fvo8HYGvRjemZLwdI46ca9Rk47vRmhQUVLdc3FP0YT
         icCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716293; x=1794321093;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKlM9iD6F1gyXy04opeEG9+C51VAWggNyeLVBX+b5pY=;
        b=DKk+9Usw92RfaD0yF1zT1A6ErDZciUIhVOxs79H9rXuOBuKuBqWwJut4StcJiogPQ4
         /9gVcRU90Y8Jllo0f0pJWK+7h7rXD43Xgo55fc+c8ZtoNN+l8oNX5Bp0B2ljLIp4NwmI
         jSiq34FRGNfb2fAiKPxu+rzXnY60/Ks+uwO6z7Ns7Oj/ipk9WG0PLRMsFaTEak5YItg2
         39PCaLl+MGjskpZh5A/xIr10iE1WICLld51jgqMeiHD+w/mKFV0oyWapi3bUTeRPCYAO
         2uh7lpWIJLdpusLFpyb6yQyosj9d91VoDcQzNQySkg1oNDhVxcLvh46ejcnm5QuCp3xx
         xZyQ==
X-Gm-Message-State: APuU4Z845KWJw6eT5EnCRC8Ok/NWdwnEqpA6C1GS4+KUMOstVU+wSuhA
	0qJGatXb5YYR/L+85ozvyz5x3LZbC02NjfN5Jb0pqHacgTJun6US5L8k/an9sN+28tQ=
X-Gm-Gg: AYBFou38ML6b0lCViS5Aq8FawcP7DwPwURzdNxK/pSMj+4kC03zb/cORSFqg4uouEQ+
	T8v8+ULiTz8cw+OeIHdeUrLOhHU2RBrubzsl+pI8YYNxZLeesQPwGqL/wcNU+DgTOzm+CqsOn3H
	RqnpGrVJaAGUXLs7qeK8Y1XGi8vUeozsGYqJY6H/euRt+uRFe0fq1kOnKZyP3CawCR+qDH1zwOq
	3jz4Rm5D7aFumCfEH00OlaoXHLKxpM/f970ttWHBMmMZz2dnXKset7/pZ7IZolCV/GSTwSuebL1
	XaOX6j2IexrxI4rNAm9CoS9YzZZvCxmNwog5eZJR/RmW5MLbdZBomuuBvLLKvTVXHq9LucmyBOS
	pYV/m0e5ZqckFQQ1u7jX+ux47trBXpN/DQJXTJGZ3Pfhyf39v2ZEciQKkvljL8d9lmOxAPk7bDl
	zqEdAsDAWzvZhHzNolrX/wrGzE8LALyc1jzE1ifgKagSjGKpAeB4uh06DbcyNQofMl+pxyOQY7L
	5F+qaQ8N9YRk262X5XxOAOK4r/InVkyvPtx1spkxoocwitZWJVuuJyJnBeKEwpHye0MeRugvYeb
	e3xGMccr1uWphVJFei5spDfeJx2q27C8N9TQ8SVYqxDzCGYIn1xcbc5olymTbY2X5AjbIHd5F3C
	/FotJa8Rh3Wfe
X-Received: by 2002:a05:7022:1706:b0:1ac:7044:2bad with SMTP id a92af1059eb24-1ac70442d69mr16914729c88.36.1793716292497;
        Tue, 03 Nov 2026 06:31:32 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: mst@redhat.com, stefanha@redhat.com, hch@lst.de, 
 Sergii Ushakov <sergiiushakov@google.com>
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, pbonzini@redhat.com, Jason Wang <jasowangio@gmail.com>
In-Reply-To: <20260918135120.1261150-1-sergiiushakov@google.com>
References: <20260918135120.1261150-1-sergiiushakov@google.com>
Subject: Re: [PATCH v4] virtio-blk: clamp max_segments to virtqueue ring
 size
Message-Id: <179371629139.3691261.5658135029894981037.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:31 -0700
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 18 Sep 2026 15:51:20 +0200, Sergii Ushakov wrote:
> In virtblk_add_req(), each request consumes 2 extra descriptors (out_hdr
> and in_hdr) in addition to the data scatter-gather segments.
> 
> When a hypervisor (e.g. QNX Hypervisor) advertises VIRTIO_BLK_F_SEG_MAX
> with seg_max = 1024 alongside a 1024-entry split ring (vring.num = 1024)
> and VIRTIO_RING_F_INDIRECT_DESC disabled, lim->max_segments is set to
> 1024. When the block layer submits requests with 1023 or 1024 data
> segments, total_sg reaches 1025 or 1026. This exceeds vring.num (1024),
> causing virtqueue_add_split() to return -ENOSPC and permanently wedge
> the blk-mq queue.
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: clamp max_segments to virtqueue ring size
      commit: 603e66e8dd6adf2bad54bb27f4b690eacba3745e

Best regards,
-- 
Jens Axboe



