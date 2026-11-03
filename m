Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716267;
	b=siMYQAbu8JE9YVDVwdbOUHoczjgP/871iQLafny+CuJsI/StblMeaNjAjGrPnVejYIjw
	 KRJQZmlA56NcEegISNMxJpBOjxnS0s35tdwYOjxrsUVQbhwcmBnNCHVPuHqYeNaupKZ9z
	 vzeV5IT19RTyO/LLGTwndjBnTzT6f4a2Qw1WfgZiEUwHes2qVeP2AuaycxWU144SG1BZj
	 GtbgNSW/JGNly246B/Gxd5h8GHk4oXyS4nvrH6h5JbI3nw4/TolFOnuGe8KtlYRJiqb/M
	 oDNPFsorkdgnGYxttnbx1oe6yChVjGBbZ07/AEU2IwmugjiYqeGavPxVDqyOP2hTCTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=+GXjmDSpdPKSM3dvXbu3WCZAHTmv+G6w0ssCMfJAnCM=;
	b=VZtnZnQJxX9Q9tf2XvzEke3mNWw+gXTmaFSAwZPv6skOR+Q2Oaszy/3dqzWKvTawXa0z
	 3Q0uGwktbFXOAIh15U/9kFN6kIquZnxvpCzj07vas+WrOxEsWV/fisVb6sDWmSS6/VN5d
	 qtLmq4F6Nyji3kuR3x2eq4PdoZccZ21gUZgDxYjCVubEYnAYWhHAMO380XHo3jm280ic9
	 72nis6pTdGfWmO5Fgwcy/Vqu5mRHdqk7RZLjBJYe2ePAP8zZ1cGV0mm+R+mmXomsM7qLf
	 q/WrVRaVwCRPQW2a3G4NwqW/RJfkEBdpM4N9dDJb2cMK0NSvXujzQ+gdLCJtt71gxoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=D2W3IN2t;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3C606D810
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 14:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB3C606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=D2W3IN2t
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1931ff67a29so8730433c88.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716266; x=1794321066; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+GXjmDSpdPKSM3dvXbu3WCZAHTmv+G6w0ssCMfJAnCM=;
        b=D2W3IN2tboyIk0IrsM3MQfFUMI033ltvq0t/VxySZEDHDzlP0AgSbWYVzCo+OKLSz9
         5aiQwLVhDBDTrjIQmGGPu5AdJpzs/swK++6QPcv8LJX2+NozDJgPuQWXIhq+mUd3UGcv
         L9ZQPzj4Z26xpeffP79V+NPyG02DoApb1ewzzwnSJH3XgZLit0jM4hN7JGExbS4ftHh7
         2XgcJR41jqlLD1DWAwaKQMEorLeOCLraksaPgh22IzcRBgoSIODX6Nms3IWzHmIjRQ8v
         G6Utgq5SIKnrf46JgEi9fVqGPfquPM8hv6txPTBOdQ+l2e7bLMBhecBsz0q8KujWwfLn
         /Frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716266; x=1794321066;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GXjmDSpdPKSM3dvXbu3WCZAHTmv+G6w0ssCMfJAnCM=;
        b=wswn7dIWverC1tev/rOBxa29xXphnbh+q5cEWy57r5pYZ8jQoGk7ZfkpaVDRv4uVDM
         YsZLlMEWZX+DFxaS+LoFdo8abByz1dQUHK0dMNS6QwLs+lok/uNaLQk92d+sEKqhJp5Z
         K3LAIL42P5S+SFC4dFo3i7K4yiGcqKP79SLH4L+MfcpfHCAHiGkZRpcwvJBjJMjEYDwf
         tTydejGk2Uf1EjgrarXSW6MSdPWCJF5tebr2PFgu2ghdrv53GkmwqOHVInOb5lt20ENH
         SFvcdTchutqbWwW7J9XF+JTvRUOKq1ixsY+lI2GCXvOgiXAlww2MHFENXG4s6P8c68Iy
         CGtw==
X-Forwarded-Encrypted: i=1; AKwUvBwY5m5fZ6fhv8NsLZA1CKsAFYVgwZq/75Y5XqrgeGl6AbKj4rEWV/UFh5Ol13BmYMapa2jHebsqc00qXG066g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/rdBbvhnFyKuzZt85f/5HV7A6ZI7UW8Jesb2xvKnjorgeSqoJo
	iodrhDofnajOleUIq7i7kGLfZ0Dn+QjyzX0Lzha9ugrsoKjBvIfn12nW/XR8OWBc+iA=
X-Gm-Gg: AYBFou220gpqQzu+Jn7C24PeRumo2ZZuJwVQ2T6eXAXDMaFQljPIREIiJJRGXb0JSQp
	qkAoxRcnsX2V2z7/pb2IcN+wal76IkjM7UBs8tmaBAAoW3pR3wAt0At+eCp+JKWcX+oh5tAYPYg
	JYnh/Y0NTNkP5D1MYutVUegXp3eLlzgg/MxGsUx3JraMim8DVEccjOGjyVNjQbxm9W/wSaMgSvo
	AWPMzmSc2O4ixezTewSsbMwUgpBVYDd4qEw0mi5UWouF0XknF5B5y1QveUTsqzReM2GiRRbpIgu
	KZIDue3mHWsKWYPVKOUycnstLf2YNioID/8NTBJjv1AOtq03jWdcdzA+yWhMgbOPrWZct5StPio
	MluJHjW2Gz6oglqZZ2nGnIh9KpSvWgAwlQO5b23NsBXdK8voVi+CPl/ggl63SO62pfnLIrgptzw
	0oyiMCJP8DPbZDohq3GCjcMBmQDUN9lqzeeJ6IZ9qEbN8fQSvFLSlR3bFUAXiJBlwbYVY8Txtts
	vmWGo2Vyz9bvn7iwn2voMzNR9pFvJTAVWSFhlRukTdOQvBjZzp8OKm4Xsdmn7scLNFbfrr6tDzb
	QbiTYSYeila0wPZCwjS+qvOPuKVyS/VeyxmMPiRTDaqU/YKuwJShsZSaVRK1MPAOQMzTrBKwoi5
	pqzcWTOh7xDJM
X-Received: by 2002:a05:7022:c88:b0:194:3a84:e67a with SMTP id a92af1059eb24-1ac5d0da7e6mr18645854c88.41.1793716265860;
        Tue, 03 Nov 2026 06:31:05 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Eugenio Perez <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
 Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
References: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Message-Id: <179371626469.3691261.7199603294029974156.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:04 -0700
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


On Tue, 03 Nov 2026 18:32:21 +0800, Cong Zhang wrote:
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
> 
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
> 
> [...]

Applied, thanks!

[1/1] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
      commit: 6c6dec7883f8eb10b326bc9d109a4990c885d949

Best regards,
-- 
Jens Axboe



