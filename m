Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192014;
	b=uKM2oKDg3oWrT68saBRRzRPgWwhnp7w3l/6bCuIM7n5g3AfMntQN74eEQdlGcDVIXtg8
	 cekD2lbZ24hHoRqqaOKSwbAguscchV7R3/PjnZCKul9uA2ysqCoKNLvkxIMcBklcNRNuN
	 QJEprMuV1OF7ooIky81rlYk2HyOMRIFnD5yld91Anb9Yy90C2F0XzxPxZBHdKhigrTPub
	 MB4i00bvizHIQbMSwEyl5Lr0SqnqIXjsOcvJvdRYOhOgMCxI2a+fZMToKThYwQMVr2Fuz
	 zMIjfk8uyYoS/lb+OXRw/wZHmOdFkGcFoqtx/E/7Jln4iFjhysqYr5y3Ft8D9SVA7yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=peXMP+Uqox2irv+KGdOujRvJkcrEJhKJFHot5k4NW5g=;
	b=1wLiv7t5ScUYaYjnjC+Ldg8ZElRFDOzMMTOLhQJG78rJzciTH12dmYXGeXRL2cSHAQ8D
	 69mRZuQu15XuXi0NiFL3jki+3QNM6+FsinllG71GysjonlEYCWsoTrQgZZAIGrnaQIXqV
	 AU4eThVb9YXPyW1rurvrF8JRK2JRq7LZpvJqVagfmHn0uBjE/DQxixOdFTsBtK37UtwiN
	 2uLcVTTOvNLOyezwvUzOSYHQ/IMcckCHiL8gu7IjmSlRUbMsVIsKnydUKqMG6d2XNIgBN
	 bmrzs+U/Qx2OVPtvL5HbfzcYacaHW6raR/fK2RxPH28t9LuK/dQ9QQFkTX8Z8pp5AKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DcjJkpVg;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC634606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 02:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC634606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DcjJkpVg
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb2fcaafb7so42530a12.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 18:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794192013; x=1794796813; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=peXMP+Uqox2irv+KGdOujRvJkcrEJhKJFHot5k4NW5g=;
        b=DcjJkpVgwcJYPiY+C3AKWqDrVdifaQNpKojil3s+7g7s2VkaPaIei3FRKMfiDRQjSP
         HGDSVy4zi1/rA5kkQIqdVfdcw2a0blSvTLDulOQ9GN4GXLgQnq08w0mwyr63Q+Jnwg3l
         cQCWe9rgBzuKvPtjpSfFzbxKbUfJkmRAmabQLnSXn0mzgsGbBp/YGXgXRQRg8xkcd5gS
         Cb2a8SVI7WfYm1THYu0an/rvUgUsQOm3DkZKpPK4w8julFsorG+ApzoyD5nWLmqfeIhl
         n+SFIdmCc9P0+SXEZ0vCsucBA97bAQ13xs4SwbS0HpSRHmjRHPRH/f6aKk5hGUaRBK+k
         iFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192013; x=1794796813;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=peXMP+Uqox2irv+KGdOujRvJkcrEJhKJFHot5k4NW5g=;
        b=GLmZwfFoeXCQ8gKvYipY64EO0m8ZL9xHZV5ID3DbHmgKXSwKL5DrReSCo6jEPvhlke
         jHe1B6Iu3GshwUWx8MkHiIzFhW3QiALpA52aQyJ/R0cw+xclwYs/T/RMZT7apVXkPyaI
         ocbk1NEuC750LOogeJAU9ZrpM6rmYe7OsHCbJmeqz4jo5CgHCXKj3bfSV/8voVG6N42t
         3EA1/0EHpszDyo19fJVibZws47crjQmNCFK2u/DnRWZu9/ZPPssHTXlMFZF7zNHPMqcf
         swlYdS35bpvgSbGuRqZVL0sSei4dFDQd9OfvixpSXREuF7rCre4n8UAAP42RfGEDEooQ
         tLOw==
X-Gm-Message-State: APuU4Z8ShVhRDGGTmsnQXX6IZVPNLmpppSvwwER8S8R3dRU58+f9UgnY
	MtHspcVhatkJFqRPJW/kUoT343MvGFMpMylw6IFs+zC1naJJtD7jCTa3l9NXPeRzRV0=
X-Gm-Gg: AYBFou3zE/vu43aNY8I8hoIF4gIqcrz7p3Iu8MvcOZlZAfEH+QraTdbAiSucHQugSZL
	CvlbWFTD9yucOPyz4SakuHum7sN9ssJEVQ7fYxHjIG9OIo7hvqzzs/Lrw976gOzlYYpegVEsOgl
	bIyhCG9r5BgOPYd4GXFF301gtwFGodPJ1ej9XGu59xGRje5/7hIArhMpfJzPJhiJXl8c/pJwmqK
	gGRYXn/xjVeKWXFdEKtR0V65zNY+8CS0L10unJ05Dp6pJTF7s4k2FZFXmjob/Yv/aIew3I/kLld
	KOmXXNJTJnspHN9v8A/j7R/vB8XhBqfv2H6wD6Kf/Amh9dRjt0A0rHAga7iqQmcVpR7d1Zhi50S
	XP3ieWqRKtuE620iyQGn/3p91AgDjW+otYlZBjiUFNcS5CyLL0Q2YiNRWIV+yCVBSMPJ/BrermY
	nrXDHLKcejc87iCFrCTNvTgyhXaVwpLAW2/MG3lnR1kRiI0Vh2DtGtMNgeRCAfGyTSNSe2/3C28
	mcVs5mT9ZCCkOewpgMC6eZBJtQ5fe/BGQJ7yuhCPOJVguxvJwFFU2DS3qvEwfL3oHg8Ka5DzbAu
	3PKbo93iFuMT3BHTcY+RcPe11lMGUoKb6FlCC2bAo5YXbMo2QYwUonbVCbQvRKjGGNaG6ykPMRQ
	7hG5IzdeE9IvtWcfIS0/HO6qQeKQp/lJZFLu7WYk=
X-Received: by 2002:a05:6a20:4b1a:b0:3eb:65fc:1a5d with SMTP id adf61e73a8af0-3eed10650cfmr3137646637.1.1794192013021;
        Sun, 08 Nov 2026 18:40:13 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([139.159.170.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b646bd34c4sm808997b3a.4.2026.11.08.18.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 18:40:12 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 "Eugenio Perez" <eperezma@redhat.com>
Subject:
 Re: [PATCH v2] fuse: virtio-fs: stop new requests before draining queues
In-Reply-To: <sashiko-outbox-203803@kernel.org>
References: <20261108135830.29924-1-q.h.hack.winter@gmail.com>
 <sashiko-outbox-203803@kernel.org>
Date: Mon, 09 Nov 2026 10:40:09 +0800
Message-ID: <179419200903.34516.7461247025134970821@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi Sashiko,

Thanks for the review.  Both Medium findings are valid; v3 fixes them
and adds the missing Fixes tag.  The v3 patch is a separate thread.

#1 (-ENOSPC can bypass aborting)

Agreed.  virtio_fs_enqueue_req() drops fsvq->lock before returning
-ENOSPC, and virtio_fs_send_req() queues the request in a second
critical section.  Teardown can complete in between and leave the
request stranded on queued_reqs, which fuse_chan_abort() does not walk.

v3 re-checks connected/aborting in that second critical section, and in
the dispatch worker's -ENOSPC requeue path.  A request now either joins
queued_reqs before aborting is set (and is counted in in_flight), or is
rejected with -ENOTCONN and ended through end_reqs.  After aborting is
set, no request can newly enter queued_reqs or the virtqueue, except
FUSE_DESTROY.

I instrumented the window: enqueue returns -ENOSPC for a FUSE_STATFS,
send_req() waits before re-checking, and conn_destroy() sets aborting
and drains in that window.  Three runs:

  VF_INV: q=requests.0 in_flight=0 queued=0 connected=1 aborting=1
  VF_ENOSPC: rejected
  VF_ENOSPC: STATFS returned -107
  VF_INV: q=requests.0 in_flight=0 queued=0 connected=0 aborting=1
  umount rc=0

No stranded request, no warning.

#2 (dispatch worker may_block self-deadlock)

Agreed as well.  Rejecting requests earlier means a DAX release can be
ended by virtio_fs_request_dispatch_work(); its end callback issues a
synchronous removemapping request, which is rejected and needs the same
worker.

v3 offloads endings with req->args->may_block to a separate work item
that only calls fuse_request_end().  virtio_fs_request_complete()
cannot be reused: it also consumes argbuf and drops in_flight, while a
rejected request has neither.

I verified the path with a synthetic callback: a background STATFS with
may_block=true and an end callback that issues a synchronous STATFS.

  VF_DEADLOCK: queue outer
  VF_DEADLOCK: offload may_block end
  VF_DEADLOCK: outer end error=-107
  VF_DEADLOCK: inner returned -107
  VF_DEADLOCK: outer end done
  umount rc=0

The old inline fuse_request_end() would stop at "outer end error" and
wait for itself.

#3 (missing Fixes)

Added:

  Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
  Cc: stable@vger.kernel.org

Thanks,
Qihang
