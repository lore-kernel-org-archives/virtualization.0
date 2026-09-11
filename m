Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BDD496D38
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145067; cv=none; b=hjA3Fq6nSI2fVxgpz6cU9KIzYRh0Sn7xQxOos4RgNiTdrih3n9TJOrTJPocCqkuO9HcPDEwx47dQ/JD/WK/OIQ+0JJpzwPLnEVAcQN9TxKi0FO6nuEA5wv+JNC6NntwGCaudr2ui8fJnAsrwuxY6cTt0WIR/Lhp4dHgoVoXq7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145067; c=relaxed/simple;
	bh=KRsMfl0dl8Qf6tQlsyjrXTK7LiHsTdlrKuIcd3ee2pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lH2tECd2QL5f/3zzsp6nMkm0tsqvDKn1vJ3e7CKwOP350bWZjysSvyOltlMgK6qwyhb9y67wwlOnq7f3YM1x4VVdtpVUOqfDpNOECvcDI9jQsP5yfNVIpc70HtYzrgGMiqM5WxcJN1vCK94cadLJ1BNLyAdOgFZQvkBBgTN46SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD4AIzbN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD4AIzbN"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-86927f9ba4dso1161111b3a.1
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789145065; x=1789749865; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KRsMfl0dl8Qf6tQlsyjrXTK7LiHsTdlrKuIcd3ee2pg=;
        b=XD4AIzbN2MnnbGQNKhTryMfxjgyVDZpiyyyJs7P/RdWc/w1evQpfKJt1yxzhaeuJq9
         GVRHn5KG6AA/3D2dJnnO+XriY8Dv6EThFL4QgQWm6CRvvSMFN6mv5UQtYu+gE6ESA05b
         ImNH8cgTK/fnmCoX+qx/KgABZ6LT25ifwWsRbXliyD2L6+x2igpbZ7K6OvRaAHT8edWm
         A+uWAgN+/PPKDG3S+YUKCwyGp9NQn0OsOBMXJgOsptY/7n8ruKltML32IYIHy6zt7NY1
         5ohNPBmPsZojF4ubMdMOARTn2QOZCvRbASxvh/usIuCb+/CVoG1FaiPkMhtPGAZHknVe
         sVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145065; x=1789749865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KRsMfl0dl8Qf6tQlsyjrXTK7LiHsTdlrKuIcd3ee2pg=;
        b=Mgix3v1umDAZNGujJAGCkpuI1ScjvUZ/xVzv8AfHeQtVMxrvFtlNNyknAOCqkW7nuR
         Ci+BADdo+PigtQognsFFjkh1hH2eadYYcPsSCC6jGk/11dyAs2lA3aQydw3875WQIFqX
         wOcnZD5QEsUBu7ytDDDVnjDhUVrHW9Wumi3cb6t3dHal/eQVbDTbxwNqxIk96j2Hsi9y
         /2bh52GIHr24RP7bCezrAiC9l4aAEKk9xN+TvnojcTfrbAaqCHoc/vnVSiE7JRPShW4U
         Dz1qLUxEDLTsE+vwiX+oHuYdB9jMRtD1KLeC1JLAEN2L+ZD4PtURINZPnFlyXXyQutLL
         QzLw==
X-Forwarded-Encrypted: i=1; AKwUvBwmgvsmmk3sI64SKrvNpGGQEkpKHgGafjUAxzsQO4GbjIzoQHJRl0olTMKcYdhzovWM7nXobEwnLOWjC4wwbg==@lists.linux.dev
X-Gm-Message-State: AFuF++mCro5PysMEq2vHPfxClEBu49LFVwSM3RG4z3Crmlp3Ndhq37X2
	m9NdZjEsiNc48/16dIealmebAB3cAAfmq0mEZGBdG6rERK7ha/Msg+9/
X-Gm-Gg: AYBFou2KdxogvwAW4CPQqmegVKbFdrl9mgAyiLDcJ/A8xAbl5P5dRHpsgJWfKXYKBKA
	233y+flhH5I8Q/6kMcqMAE5QENoJL14ALUe3/xjIW6w8kSaKca263sjc2Y2OVIGrF36TFP0XpWH
	8bWu9iHJLkVV7pacKMyw90JkxhMl5bPJeVakDuB0pBmHuyFSFqHqotcd9G+NI4i1i+lV+2xQVUc
	/faQAZZkgrdC6+uV61iP0xohYiMLx7PVCtYbXqrcZBBWKw631UOB8ujTlIc3WvuEtAiLu8BOE2W
	WbvQwCaWSeWFhtsYW9m4YK3iCj4CX+MIpe5189LuSZwTFO++ksAyvwVNT9qUp9ya4E1x/ubseNZ
	3u5KRmKOBRGr2ShiOA2JWp7GvEZHiOs6WXZpJUCqBmlS26hDZ2y10TG+gIs67A6GkuzznlQkBK0
	OlEJaqA//f3LtNGPVCGy/MItTAIIeGnVa8qQPkwxiBBZoNvKpJCt10ULQ+Q2zgJ20F/ub2bo+x6
	aKnTr/mCuQcl3psSwI=
X-Received: by 2002:a05:6a00:a244:b0:851:b03a:fcb with SMTP id d2e1a72fcca58-86b3011a828mr7287479b3a.14.1789145065008;
        Fri, 11 Sep 2026 09:44:25 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:b928:dcab:35a4:adf0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a5c052csm1404407b3a.58.2026.09.11.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:44:24 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] scsi: virtio_scsi: bound EH timer resets to avoid unkillable hang
Date: Fri, 11 Sep 2026 23:44:17 +0700
Message-ID: <20260911164417.33860-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911163509.684191F000FF@smtp.kernel.org>
References: <20260911163509.684191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review -- the eh_host_reset_handler finding is correct,
and the underlying mechanism is worse than a stale read.

Once virtscsi_eh_timed_out() lets SCSI EH run to completion on an
unresponsive host, scsi_eh_bus_device_reset() leaves the command in
work_q (device reset fails the same way abort does, via the same bounded
virtscsi_tmf()), and since virtio_scsi implements neither
eh_target_reset_handler, eh_bus_reset_handler nor eh_host_reset_handler,
scsi_eh_target_reset()/scsi_eh_bus_reset()/scsi_eh_host_reset() all fail
immediately (scsi_try_*_reset() return FAILED when the handler pointer is
NULL) and the command falls through to scsi_eh_offline_sdevs(), which
calls scsi_eh_finish_cmd() and frees the tag back to the block layer.

The struct virtio_scsi_cmd for that command lives in scsi_cmd_priv(),
i.e. inside the now-freed request. If a new command is queued on the
same tag, it gets the same address. If the host was only very slow --
not actually dead -- and eventually completes the *original* descriptor,
virtscsi_complete_cmd() will read cmd->sc from that shared address and
call scsi_done() on whatever command currently occupies it, which by
then is the live, unrelated command still in flight on that tag. That's
a double completion on a request the driver itself has not finished,
not merely a read of stale memory.

The original virtscsi_eh_timed_out() comment ("The host guarantees to
respond to each command... Reset the timer unconditionally") reads, in
this light, less like an optimistic assumption and more like the
invariant that kept this reachable at all: as long as EH could never
progress past abort/device-reset into offline+free, the tag-reuse race
had no opening. My patch removes that invariant to fix the wbt hang, but
doesn't supply a replacement, which is the hole you're pointing at.

What I looked at as a replacement and why I'm not sending it as a v2 yet:

Adding eh_host_reset_handler that mirrors virtscsi_freeze()/
virtscsi_restore() (virtscsi_remove_vqs() + virtscsi_init()) was my first
instinct. virtio_reset_device() does call virtio_break_device() +
virtio_synchronize_cbs() before dev->config->reset(), which is meant to
guarantee no vq callback is still in flight when del_vqs() runs -- but
that pairing is compiled in only under CONFIG_VIRTIO_HARDEN_NOTIFICATION
(drivers/virtio/virtio.c:255-264), so the safety property isn't universal.
Separately, a host reset triggered by one wedged command on one LUN would
tear down and reinitialize every virtqueue on the host, silently
abandoning any genuinely in-flight, unrelated I/O on other LUNs/targets
that scsi_error_handler() never queued for recovery in the first place --
freeze/restore can rely on PM having fully quiesced the block queues
first; EH's SHOST_RECOVERY only blocks new submissions, it doesn't drain
what's already dispatched. I don't want to trade the tag-reuse race for
a config-dependent fix plus silent collateral I/O loss without your
input on whether that tradeoff is acceptable or whether there's a
narrower primitive intended for this.

Is virtio_break_device() (independent of host reset, and independent of
CONFIG_VIRTIO_HARDEN_NOTIFICATION) the intended way to make a single
wedged command's descriptor permanently safe to let go of, without
resetting the whole device? It looks close -- virtqueue_get_buf() checks
vq->broken before touching the used ring at all -- but it's one-way (no
unbreak short of recreating the vq), so I'm not certain it's meant to be
used outside device teardown. Has this class of problem (bound a SCSI EH
timeout on a transport that can't cheaply prove a command is gone) come
up for virtio_scsi or virtio_blk before, and is there a pattern I should
be following instead of inventing one?

Happy to do the legwork on whichever direction you point at -- I have a
QEMU virtio-scsi repro harness already wired up for the original hang
(clearing PCI_COMMAND_MASTER mid-write) that I can extend to exercise
the recovery path too.
