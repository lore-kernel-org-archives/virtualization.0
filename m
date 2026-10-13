Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F6388E6F
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881952; cv=none; b=Id1D0+3oHCRNygKhB7WoaK+69FON8450gIQsrOkJDWLgs0tlLaioHz9crcS4Y8CzeF9BLB+6PtaNebowQy4o3if2BeN5xe/WuINQVIsEpLblsbpr0XOF6/VUvJFAii2Di39ANTZxRLqkfIlPfun+qM5IfX5dIVSFlcFTTRmD27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881952; c=relaxed/simple;
	bh=xoLslMg1TgzRFtaItrr8Q3+veiCkTwzMeUa6OX+fqgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARpvuxX1X7XfFHybHqIPQkysrKt2W6oUjREBs2QpJEZW+op5JYNnjupUAbuUk3OX1wF3MzROG8Mx0ulEabVrV/eqgPwkKQjlENi1/STZu3pwOcD5xnWgM7JmpAn6KRw1bps4IbWUykwzdL1aLze1gQalcwXwmq/0E89Tav0XhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFaLPXqj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFaLPXqj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e82462a3f1so14746185ad.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791881951; x=1792486751; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xoLslMg1TgzRFtaItrr8Q3+veiCkTwzMeUa6OX+fqgM=;
        b=KFaLPXqj3ZjIQpUwvvysfRu/JymGipq/YZ7oyjcVZYjXmUXUxaQrVqsBoq33uBiwKG
         S8oyGBiuGOc/bApg+qcv9vtouJUDmTgQzQb517m+K1o9T8GiasCxsAnlxpRk1XksxvQ1
         jFrkSajfdgUkg2r3XAp0WE2CLHLdLiN1LNMNWDfBcnee+FQjWXupKmwN1IhZFRdrVS5Y
         dX2o8YrT+aNFJb0tLBPFJtfGzva+VWcs673ePGpD7VRbsB6EY5AENiR/ooEfdQBpmO+S
         GRmNcObR7gaXCo/lFkS2En5dU6yseokjqJPkkzrpc1dXy+DS4CfID6JW6GqEqgvGh5Xa
         yb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881951; x=1792486751;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xoLslMg1TgzRFtaItrr8Q3+veiCkTwzMeUa6OX+fqgM=;
        b=KAY+y0yrzlga4PseyPBDKDj96OkuCG2xaxvHywR4l+GIC8KZZ9oxtW2c+5PNnOGQxS
         WWZs5QnUr0SHBlNmJ5szOUsjXZSmvMFXxw5w7ihfyVTD6ORYx3CyCE+V9MsnMOBuSFdj
         Dhk4X0CBYPqoj1fqLkS6lTlTxvN200/LWSElHOYph9UFtqPbxNI4/bT3YXQLOLRiTosI
         npI6z2ky5Wfn406cmAcJQuh3AdFsHCUgBCVsv3XNVxaTPnMD1j+3LyeYRAFH5WGtG3nk
         DwIy91H6soAChaw3e4mLtyYIGtGoPExxyBghrL2beO16y5sK+TigGT/tKbJ4FmRBUvhJ
         vDGg==
X-Gm-Message-State: AFq9FYLBFgKD+oTNCnP+bqyIOqvL9JzVffclqUZX0PZKCie4Ks0azMBr
	Bs7ysXqcpDoco6ZcDWgOhmeKWJVYniGpgaUfsPsRHLeOGWXDwbc8IS3l
X-Gm-Gg: AYBFou1eb7aeOwcQFp7iXwDkNcKqVMmCfhHoP+aeuGnNJ5vnsBw4r5oSMLAT7Xpa4cp
	HX6eFgBrhLGDTC7HXH4+O9F/DANO1bZJmnIIn1I1RaR36Ew8NinxRssS8T7VKn8FVIGtHV2N7Qf
	xt2QjL8bsa0eGeHynXxEWIQYJzBcWdgoYc5w5XFIE+lzuUXsiorOh83HSNX0SmhzzxjFTEJ9KLN
	yioNAZDS5gAWDajL6jq73dhtiof/9uazerw2vA1I9dT8wHB2gqlrCWWWd34jZT0PZW3vcb6pd3H
	TTOuTz43TVTrQd1259UWRDxneW/YrI8C+OjOuHGg2mD995Nq/CcHIhwGlbdT3u1bLwGIXYILJqQ
	Gpj+WkMcgurTTky4oNKinSmwQEUBVks7chvfUguIHfGLyZIUsIl68p43nTGQ9Bp1MvOCrCo0psI
	hgSqJg3aHgB2KArVSVNTmkspWMbD6DVURhu1fgATZthW1DYjuH3XgsO58bUp6GLXgC1kjy5bDgd
	5ioIIeIIownhtF6N5EHp6XZXp/gs5xD0+/wqMdcVxfiltl28ATe2FtowoAs5NQtHPe9XRrSQdCS
	bovB2TBdJWMbulwy
X-Received: by 2002:a17:903:903:b0:2df:8b09:93bb with SMTP id d9443c01a7336-2e842aaca0emr94933515ad.10.1791881950940;
        Tue, 13 Oct 2026 01:59:10 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e842300d56sm53510185ad.84.2026.10.13.01.59.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 01:59:09 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: sashiko-bot@kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ALSA: virtio: Keep control payloads alive through DMA completion
Date: Tue, 13 Oct 2026 17:59:03 +0900
Message-ID: <179188181241.52451.7572855613839007151@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <sashiko-outbox-169212@kernel.org>
References: <cover.1791877396.git.mynameisjune111@gmail.com> <sashiko-outbox-169212@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks, this is a real alignment bug. I reproduced UBSan failures for both
the control header and the integer64 response payload with the v2 code.

In v3, the alignment is at least __alignof__(struct virtio_snd_ctl_value),
in addition to dma_get_cache_alignment(), and the initial +1 offset is
removed. Each subsequent region is aligned as well, including when a
preceding region has an odd length.

The ASan/UBSan regression now checks typed header and 64-bit payload
accesses with DMA alignments 1, 2, 4, 8, 32, 64 and 128; v3 passes.

The updated series is in the new [PATCH v3 0/5] thread.

v3 cover Message-ID: <cover.1791881787.git.mynameisjune111@gmail.com>
