Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862572;
	b=Buairhf4TzKSaC5YXRlF+yfO7OP6r/pB9DsuVKmWHf/4vunWOzkIRViSrsK1Hj526H6X
	 h4Gu9uL9Qn59Sc3Vgmfi4ojRqoEFryS2eg6ZCAddo73P9rUB52mXAqLeyaQwlJVaWGXIf
	 fOrxwe6gIgGJnC3XyqS1Kttl0Gzes/gNHQkJloDLj9Ca6EKwBsMHpYfHsqEagnAGnINJk
	 kjr4IUzfDx/6+gIBM5tRZOPR0UGDr7cd1fMO5VzDw9ANsU3syVKL1/Z4aQesKs39oV1Zy
	 XNBzvretnLA6FSpI0DXUMYjkWeY9H3e8fsS3YDicm5PXOCiQbcGQHFf8yBpqKFWZmEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
	b=SQckEXk8RQTS1xcDPcHV+6bIFlgYIVTNdklJJhtR9+5SQBhPy0u2XUFqUm9gyNwPqFEw
	 PmwivoW3kQnjofwChtszpyZchYUU2vCeZQXIu+AM+HzBa4vesRO+ozfZg+hjkfgFzG4RW
	 F7yBUmjugs6xwMm/nAXy7EtuJmDUNPFfB99+rExilnbM3Xf0x5u/L5qjdl7NBhJa02UZ/
	 EEFtHv7BEW6hHlsPNbzNkBeiaCFnIOq+gjlevgCtCwSHNnNY5/fEZMuppaKeTrjnl6ziB
	 pF5dRlVGe1R7GBQv2tWmPM8/LYCaNNrXMQVUdzv/uZPy1w62Z41kdVeDLyG8SiqHmhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMCQT8d6;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A54606EE80
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A54606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMCQT8d6
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36dbde64409so1102445eec.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 23:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793862572; x=1794467372; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=eMCQT8d6oEs79LOc56sadWh7P/cnpFi5lUT12yujxo5Y9B74UiGCwA5UHqBGwdFxli
         7Fe63IqtALTQe8enQdjgmchRpa6fESq9Smxb1EQAE/G6N8Cu+QN22HNVH8nNEjm+P912
         KmwR7nzb2yBw9bhdtr2j/V5x+V5PquqPShJ66kMJItPU/QhF9hiUN2+BlUNKNQAlrGpd
         UsXFdFyXWC+6+n3GDf7z2JHlTddRKHNH7jGrl5eZCSdcvTurO4TS2pEslgnjarwa0ytE
         9XWN/KUACRUjUcAyzANn8a8XiQQa/7aO4DqYcV0d4NcR2CLZJmBzzwdkSrBS2ONQ85nh
         ErQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862572; x=1794467372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=knY9cxJxUxiBNiCa6HAYOzyYYi6a30IE+xnyNXBFqmlKjdxF25tH77J/CTtmUovuwp
         t2SZ/c2+lKFxSeIrnd0SngBdLG4wazdnDwOFzMt3ZWX1fCje0Lcv+eynF8jJJXuD4P8h
         eXfTceL+CQpFs7HId2D7I/ux/Xe65n7U90SluTh0e6GPv/MetSFu+MwQM2FfEfob/lLb
         H9qGcghBuT0fsuY/8sFw0dss4fmsVvl175txTVYMa2/FdLuCWox3BjEHcgdZVwGDwFE2
         VhmOYuZjDpvm5rGvIP3iJoIVlvUEWKOL/rzWlHvHfQl10xplJR1UwfVFVu31wfFIlOcj
         EmeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgVZiO4XU7nbuoGma9sGJDNwWNM3SOjCHMu8QCjiQgm3DU5XSLFeNTaIqSmEU4ik1U8jZ3z7YNoC8x0+JO8A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8a3xLpGVtKXDy3dKQq4x1T2yQohFIpWjKKNgwPXxHxYJ2m4cu3
	Np6cd+APNEGJBe1qA35xCW529jUonZ2Nh9BNhqAwJUUpI6ycOlBb0MYL
X-Gm-Gg: AYBFou28zxZQ5HYVOijM6029bZgVaIT7UAo/k+zu9HtEj96YGNHL8dFeTGbsrBxzS1g
	6xdxp36nc5VTzu9yaSJmYdPIZQl362jOFMPwVcL5oxaz81X3rAaTUk7nJtvhkpBEe2oZyY0yYbI
	fkIlZy6N2GEOBez4ndt91v7dS00O0pu1mYUIYfDwa/Mu+BAUsCgsy9famqLrhdZtkHkaeuPr3NU
	8lYHZw3Q4nTgukLjcR1UV5NtmpFuYgrzm3WrR2KuwaNlASDJ2jjiAn5kuG8mQqiFu1FwtNawE5F
	8aihuw9XZekFbIAnY0/w/ghjT8I5iMK57Iw8pySDNfQZjUNWg+ur8bIofdne5M5p6Awghz2mc5d
	KCmnd672DNNoj90ibiz2h5K5piOD5LLrmVkwVFuIqR9fYuCgspZ2dkjsV3CZEo/QJZx28dCeA9J
	ZPY+CycKmhPz9AXdpTdzCWdE6fmONzQ6mVWkXxB6rqkk4JEbnqsbb+oq4h8Y5qqEcW/oCr40B1Z
	/X5SzV4xyr6gVied0X0hMtRd5bx6KLJXw9JWiIvGdKjPl5wRPdm2eeomjx84Zg+eixytx0Vd2lM
	SWK3cLlJC+GwYnciwhZbquPrIgIJvcRNCIy8Hh7nYoiWCkpvV26y2iqwoblZba348Isir+eACk7
	Jgh7QNWRcCzhCxlAStK4frnkqQPfhsO7kRSDJ8lyq/xyAwsY=
X-Received: by 2002:a05:7301:618b:20b0:35f:2858:aa4b with SMTP id 5a478bee46e88-36a4241b070mr25031192eec.30.1793862571510;
        Wed, 04 Nov 2026 23:09:31 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm16812286eec.24.2026.11.04.23.09.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:09:31 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
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
Subject: [PATCH v17 11/12] ALSA: virtio: prioritize staged capture period work
Date: Thu,  5 Nov 2026 16:08:44 +0900
Message-ID: <20261105070845.6449-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105070845.6449-1-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
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

Queue staged capture period notifications on system_highpri_wq through
the common scheduling helper. This allows capture notifications to make
progress when ordinary workqueue workers are delayed by CPU contention.
Playback and ordinary capture keep schedule_work().

This preserves the existing priority proposal without mixing RESET or
lifecycle changes into it. It provides no hard real-time deadline and
cannot prevent a userspace reader from overrunning its buffer.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -168,6 +168,10 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
