Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180555;
	b=uaq/TwPhWpAAPhNhQOZgaiJp8oZI+sQkj30Cec53FzPlCGVfhlrruXmaDyBFcjlBkaSo
	 I1FJl2m3W8dlqD/+Ap9vCttYkd0soDzV5nLKHR44V9K5Oyhoc+9Q6KRsBywYfE8QV/or+
	 jHV9kda/9ED44YQVHtRYuxmIhIYNWwyjPpwfJRbSiDk8T+87r0NiZf/2SzDnKvNlH+5jl
	 mUIiAiC+sI7irtkVCMB2zheiN0RTV3UAZql6uJKlawKRlo4c1nWOMkOSMuufUigRTclJp
	 ogGgznZRN00AjBI21a54auF4a827Db+d/H5ANp67v9JDTlyGB+kG28fsdHB/OyK4y8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ymp9DZsSdxidMhq6vpo6Pmh7FGUL13x09jBMfsRnJjE=;
	b=CT2rV0Wvfpu2IUKEkG1xLnjJZC+28Ec50vq1hRckkR0zgJ38K6IYgXuYguxawRsSES0L
	 BSxV6QAAt+RoK3vW7DtxEzX4QsPA/li+9IrpXOaKkIeNXeBOwJQhTNFMpgkNtBO4EAASg
	 ynm9Yhx2vUFTL5ebOl7JVQm0P744jguqQ7l7HykS3XcTuG4YqzWfwkCmth+efFEbbyvjJ
	 BrnE2IqNLYp0FYbAmUwqNWx5Re6kukWg8yq6KBm3fWrJybnsCDUDDoC7QxJlM2I5vmSqE
	 nSFVUdiS/MnBbNc/aObmNEN2G2b8N2ilFbijPVkqmykNm8b4vj1u5pF92LJ3pzwBk+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xu7iDqeV;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38260A5BC1
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A38260A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xu7iDqeV
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ace9e6e1a5so1136024a91.0
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180555; x=1793785355; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ymp9DZsSdxidMhq6vpo6Pmh7FGUL13x09jBMfsRnJjE=;
        b=Xu7iDqeVgm/dmGS9enPJE8SYRvoboA+aN7OrtE5Mm/FJ9kzk03WnpW4r5IWb4KmD6N
         FZaThy91cwi0ByzX9/SyGDzJBhX3JvjeZiibqoq+6Be7Jn3Hbnjib/p3BSXEVaLfRbWT
         LT1yVYqdl3EmlwDyR6FzUXkP9uHwZosUVR8mYClJXYzRDbaDf9fBla5CycZH/uQo5zJy
         Zu6lPhLPXlduyE5I6ctWrXKi5EyM0bh1PE7nVhVaOzkBeFb3KatpS6VKwGZQ0Ez7viNc
         gogzxm6xW6n4WZrO+rIfn2iygAcITMlMRp7aZy79TNrTW7zRo9/xZPFZPjr9hoNSLAp2
         Q6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180555; x=1793785355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ymp9DZsSdxidMhq6vpo6Pmh7FGUL13x09jBMfsRnJjE=;
        b=iw+srzboi2/bVvbJkR0aji43L/KrGFQWGCJaMDDbyD2ENt69P0fY9cC/0DwVmkiJjE
         qnEP4SeF51RFHEjZrWL0OwrcVUlI2MM2iHTeb0aXLuA8TKRPzO6xAuuKqex8EfJPI79G
         Mg6YTDjK3DygMrWOSRA6CjSa4j+SMKMybrWIfeczJ93qqn4J5qsvs48eUMhu4z4rUc+U
         tCYC7nKX2SuHIZGwKm4QzDd0xBqz4hBbt2f1HNGhc44eKtkBLK6rnTsENpF4rz4YwgQB
         JHg3WTbjI9rouHD0qMnRXFSoLDOlNjkKvGNqIR/HEg9NVVHaUnvLyaky2eyq3Ck2SyOe
         SyWA==
X-Forwarded-Encrypted: i=1; AKwUvBwRI6G7hMygJ+UoFMRa7isO3Jlzy9aAHI52Gd/kYYol7bydfXi2vXT5cLsAtH0Svp2cPzfvGsELpwil+m2Ijw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJvzQul8GPtvme4IqgP2kr+dcjZmTCcyui2660psxW1lKs5U/Ro
	E396rTEPftLe4svBBmoHG4kj/R0WI7hQIivYybqbOkYTcMcKWsCzZgvm
X-Gm-Gg: AYBFou3CPpKMG1MU3IBAQ+K8K53DRy04c2ZKjRRHMgCCCYpBiP01LTOAluTGpLKHCLi
	ZPw1Lh7YhatLqlReZ9qhSLWHdcyXGNYXtTDG4Y0Jc6LSEqEKFtOLzxD5cwc7YybQnXdHOT4aDpS
	5IJvh1V/oilf06jPDjAZKLoWq84XIwN1b4DxePVEbCBwcLqK3CNAIMSehOkfRQxHAPdXbehuqOI
	KUdAyMWYJ88Z/PySseqvrfkjtGPImKZokD/Xp5EKtmWpdw/67he3WdCoDoB/gqP8rn624Iv8jvf
	GfCH2jL6MTbHwuqZjiHcRLgcpr46vi1gB06rJp3xckCooahVZGmeD2OmyFcx+2NlGwZYkoWXAax
	VBVowol3hhHCKOOeOD4XpCngpTxzY74jE6TMNz3wAZB1zYKo2QIrVywI3z2CTKGAMMR6+H9Hybt
	EJj4UVlWkIB1O20OvPzm5gT6nadxww4DxFEz4+uuo2WSFiCZbhkPvdOLjSkFgkoecZqSDjLMhmg
	UvDmoHxuSqPWFFgHYNsRMzvjdaskLWKQXhVEf4mxiygay4w6ugpILs2nHCjpM8YmNpsjigL23vn
	b+Ach5YRzHCZS4BQx3ykvTWk2cxBXVUN4Fd4soLkiR9RUh9w8vkyuvnLs0pdW+NOofSvLNEfkp8
	OZq9RJjxEfQx9pOKgTaGd4lS21tJoqzN3gpJUTuLnRVdQmQlncss0pU24lCQIBG1fekRl
X-Received: by 2002:a17:90b:2587:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3ae5c86a185mr503200a91.23.1793180554903;
        Wed, 28 Oct 2026 02:42:34 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.42.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:42:34 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v7 15/16] ALSA: pcm: synchronize stopped paused streams
Date: Wed, 28 Oct 2026 18:41:31 +0900
Message-ID: <20261028094132.20364-16-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028094132.20364-1-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
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

A paused stream can still own DMA requests even though snd_pcm_running()
returns false. Stopping that stream without marking stop_operating lets
a subsequent prepare skip sync_stop and encounter outstanding requests.

Mark a paused stream for synchronous stop when snd_pcm_do_stop() handles
its actual stop transition. This also covers paused XRUN cleanup without
having the driver predict a stop from an intermediate ACK position.

The non-staged virtio-snd partial-read test previously failed its first
prepare with -EBADFD. With the companion driver changes it prepares and
captures 48000 frames. Playback pause/drop/prepare/write and reopen tests
also pass under ARM64 QEMU with KASAN and lockdep.

This changes the core stop path for paused PCM streams beyond virtio-snd.
Coverage does not extend to all PCM drivers.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a2ea44c..ac2e5c2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1611,6 +1611,9 @@ static int snd_pcm_do_stop(struct snd_pcm_substream *substream,
 		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
 		substream->runtime->stop_operating = true;
 	}
+	/* Paused DMA can still own requests which sync_stop must drain. */
+	if (substream->runtime->state == SNDRV_PCM_STATE_PAUSED)
+		substream->runtime->stop_operating = true;
 	return 0; /* unconditionally stop all substreams */
 }
 
