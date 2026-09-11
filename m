Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB063E51FE
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096291; cv=none; b=hk7OQJLoLZaOKjfo6v+BRsAVfkl1poWBV+dNfwUv5PBWAhFcxwdBCrGwHfJEobgiNizKPse8BSHgWSSFxzaixDPGRfZhk80+5rqDPWKeRsEsEIUWaBUZ9DQqWi/0Kf/Tt5XvMyYp33L4GAYLaQEPgQQXH/aSauyXU4CgJ1+VzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096291; c=relaxed/simple;
	bh=IsH/uiXS6PCMYKUcTa6HJLyo15+CD5yZpyixAyCfD84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/d9uf/gXdepHacezuHjD2SWiGx7Fs2LPusYlmK3gmEDETtDdCfRiD7+nui7WrEjmaxUQT8C/9gYoJ3Dq/buNgXtlWeVzU6osUBYrKMwCZLDJc00Lz/E06gJ+1OKLBB3qwoLQxdmFhiTo2LeqHUMtbKdcG0p2Wh2tP3kIoYQzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoOvSl6+; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoOvSl6+"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-939ee3e830dso17794285a.0
        for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789096289; x=1789701089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+7mpvDw1F56ZPu1ONqje79/4zvVptkv9Mg6Nl0mTjo=;
        b=BoOvSl6+xk4xKPYKGPZapLur/28r+o5xr8Z5FMxVulPZueeg+dn28y1cusZKxCDXFD
         QDOm+TUdAn8Q6nE1rvEg38fnF8FVFJJNxsB67LAzUM4gFCUucetqSMDCjkBgZcmNSqXs
         ms9GRMiOdNWPwetUUVkMS8wRXz9a2TVHHGDf3y0iR7kGQHzEw/31SbaYWOXbXDoSqQoo
         6bsHLaRnIxOPO775Jp9FwXbkHgdYsWbQn5UX331a+lCLMcQ3E2mxcoWPHhKY7XD23iFN
         mdJmibT+v7oHjhPUjfKT18k9eGaAiaVKBzc/2jVM/r9SCa/S1isPOLXJxaih3VSimU1+
         9HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789096289; x=1789701089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+7mpvDw1F56ZPu1ONqje79/4zvVptkv9Mg6Nl0mTjo=;
        b=XKlGs9J2dUte+T9WY8WPmT/MrBAvuFeqkPEithn2dFD1zVCY1Vi/KhJ78H28giqTm6
         xtGQKVGKnisDspCdegwEEAwn8JSRQvERN8LHU72zUrdh3N61+sn9uHeWyN1uceAy/k0l
         lsqQq2Hi3LtJQW2lskk2pixGTXPB8EEIDH46IcMkMpqD2Fb3PT6tRfwm8t9lpClelLjG
         qeQsOSsTnlUE2RVsYMhVv9GIu5eTpZd65PejTW5zqkhqpX8bwnJNHRBDMFe/d86Zy6uM
         vcfZ6MZeINArOgmYHcm0gYXHt2q61Ir3EhFklBiDAXPy0lgv2DttiPAFoesF/QHm8zVZ
         MbzA==
X-Gm-Message-State: AFuF++k1BHRCvhKF6nSJNOqUSR33VwVJgJOecXh1ChmRTq+YCvqWEPun
	9sBlxJZ8dQfFEHdzYajQj/iHLe1wwGBtc1rrcvndDz/yLLn8V9eKuUGF
X-Gm-Gg: AYBFou1W4YVwBNSiZ1S9PwiNothmwkFIYAs2u2RwKju7wfXjBaDCUTOL1KNVKgiliwA
	rPy5+aygaaDa4QQxOo0+rHGHdgiLV+U19SJiZMyhPhRpoQGephHax5e7+d0KhJow5EsItPKg/Lm
	j+ESlc5QIULc5FbQtIBw+qLczQK3hRyUoDXMQ01uyFw9NhUlWadvENBCog91Mhs6PIEZKfGbkgO
	rncC6SVlZ8lxmXaRw6IiZbZBdygRBhC8zKMbPEd2/PwRVjPfdFDqivI44DJOR37wYb/igdsNeV8
	QqVpVJHe1TBv8YrQKFIxuSAc5IlPhMX+ppcMM6vW50E/d82kpbS/u4jafg3hRC/lsdfxtAYWBeA
	UsDkHkg8buksnTslbnyaGCX0M8LRtQjQP5Asa8rC35ctYxBntY3hCToyqQOWpt7E4G+aI/NPqSC
	5ylDR0Ha6XO6eUytVQqwHmIo2tYlE+kLbwT7JJC0SMMCX95MlV3xMa063G+Tz6QjnPr/YI06mTk
	JvCVJx7P8TTHPjnuA==
X-Received: by 2002:a05:620a:1a08:b0:934:970a:beb2 with SMTP id af79cd13be357-939ea22a13cmr252005985a.26.1789096288727;
        Thu, 10 Sep 2026 20:11:28 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bfc90sm136878085a.37.2026.09.10.20.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:11:28 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] ALSA: virtio: reset device before deleting virtqueues
Date: Thu, 10 Sep 2026 23:11:21 -0400
Message-ID: <20260911031121.1542502-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtsnd_remove() and virtsnd_freeze() delete the virtqueues before
resetting the device. del_vqs() frees the vring backing, but does not
provide a generic device quiesce operation. In particular, modern
virtio-pci keeps enabled queues active until the device is reset.

Reset the device before deleting the virtqueues so it can no longer
access the vring memory when that memory is released. This also covers
probe failures after DRIVER_OK, which unwind through virtsnd_remove().

Fixes: de3a9980d8c3 ("ALSA: virtio: add virtio sound driver")
Fixes: 575483e90a32 ("ALSA: virtio: introduce device suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 sound/virtio/virtio_card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 647190f4d5afc..6f35276416fed 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -354,8 +354,8 @@ static void virtsnd_remove(struct virtio_device *vdev)
 	if (snd->card)
 		snd_card_free(snd->card);
 
-	vdev->config->del_vqs(vdev);
 	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
@@ -383,8 +383,8 @@ static int virtsnd_freeze(struct virtio_device *vdev)
 	virtsnd_disable_event_vq(snd);
 	virtsnd_ctl_msg_cancel_all(snd);
 
-	vdev->config->del_vqs(vdev);
 	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; i < snd->nsubstreams; ++i)
 		cancel_work_sync(&snd->substreams[i].elapsed_period);
-- 
2.43.0

