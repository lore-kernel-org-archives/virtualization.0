Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365868;
	b=sMNXSxsV+a3KAkmU00aZObCjpwtc/D56g66Nw8bSpl5W7SV82GsLzUUpNV8scztqpkYW
	 wFR640DS4DU8bz6foaMF9WVcvwD9gz/nzDLveekn1mmM2quJ/d94fhIm4+o0fC4Of7IIU
	 Nq0VLivQITH8tbktULrSuZJNZmtEv4kkKc6ilKhHwTkVy4MZWQuqR9SqQCQQJ3rNV0ruc
	 MMsKv912OiIzBb0SP6c8DOMhlx+yjbYZNkaenWS+NIsJvZ9vHgWmFymn81XA7k7BzRQId
	 ZJS5m6pXU8IqvcJNxv7tnZPwBkME4HOIrCh6svm2ggrUzRAtz0fN8ir4p8J0hFiCSTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
	b=0dYJGut7DXD68VbZfNlSsoRIhDeGTpUb11tjXLUHTb68u71S1rbbbJJWUdEAA/q6tsWL
	 9x9RMA7+tkOCelldrl81gfngOJYKTkfBSQ//N5zzh2K+n5sF4UiTrUaa/Tc3dgjNwv8oj
	 ytO/S1F2gmgRFZc9KazXrNLdszZE89QyCR7f8RRfAnRAuSY/u4zUePoSrKgYdDup7Vk12
	 CHix/tGCbxpEDbPx48j8P7dWDK0G0fti5VM56v7XRbFmXYLPBNFRAQMpSiO77qmVikuYn
	 B1o6XO7X7iOKjvXdfLZlH/Jp9kjg9qS7NdN/L1oOheuGxkQPCFJt8YYDbsED3eKs7XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gkRdpjx1;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700C60A3812
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6700C60A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gkRdpjx1
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so5399201eec.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365867; x=1794970667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=gkRdpjx1bBGtsF4RkDcg9NotZyKCT3WsAFqgT+WcRbb7gI5xNkisPxy+vroOiEu6vS
         fWuseU068FGnMu/ojV7VeJN3vTIjcoDN7Qy+bNDk3nPZksJ9PhMA6IgY0H4fa83h5+e9
         KAymCcZShdo7HOnkAqzqiJq2sCNPFjeSlsFe0HNabUMFC4e6QD5vNAa7yVM8WNKIOun3
         l1dP5kee8hRsJJ08H8x6P7DRkJ8zSw8oCCZxy177KTi6L/8yYwYUENNYToDh1cH0AKzn
         Mm6RAMjb53qYWGXhcUFNYWmEoJ+ce1iZEf22YaZp3tnwC3LurJSdgv6HbImvKSrt+IiJ
         /sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365867; x=1794970667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hT/gC85F3aW3pcczI8WvAe9AkJI8Qa3b05R3EsTbPk=;
        b=D4vWyLkp1UDPBV7b7J+Lq5fKfs8dYnQAordg38hi1tAtN8dmBUszLa+3WLivNlS0aq
         pd0is5ZpoFebB0RnqQNWS87lWlxEcp0MNZneuSsWIh9oe0xvcXcAq72ZyT5zLHC3qqEc
         O8eo0KMmIcUCKy/xw/SjuA7Vt+7EQJcIDH2Vo+Av/Crd4VlDqjKyEtpv3qP050dEhEMK
         f2eqVbQtqSEVXzN2/v4lpNEiUgs9GXBm2Qll7UM/JrXA6FRBQhn4i4Q7BERNcavtnKLN
         a4YWVAlOYy/qMk4QXn/bXUU+iXTPQv5UYqR/db7XgKkywikO+9U+e/i8yRqwMt4LM86i
         JQPA==
X-Forwarded-Encrypted: i=1; AL+hErEmW+FwXWXrLCk15UaQubAKLPXYofXTKHaIw265303SCUYyCzS2D49sZkMkZ4EQ8eiDmzG1E/GxAxw14DKp5A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8cvazSCC9xxHlAUgK7hypqerDOzn50yeBjOLavO7eGg03VyKO+
	JQjT9wql9yLDZiqITEXDZa8NxOvH8MF81tRMdXKDDbx2tapiJF3UcijD
X-Gm-Gg: AYBFou3l/CR/qJ5KY4Z++BuO0V37rYZoL+vY7UBoBo9KG631LACxxM93i1DFzB0nRHH
	DFnI7gmydJv2iPOJoy7LacYLTc/dcIdqhdElta1WoQRWEWx3y57gfLKU5ZIFZpLhHu5COigmTid
	6PYC00XqcKYQkMhvoG/uQfhdgffI5h3Wq/nbcwMgxNaIADA0sL+lrKMtJpUdPpfitF72767wKkm
	HnQlX5Ae8nbRmpVxftHzG/CiIUP4ARXILpmo7CJK/DZM00tNxA8V59uG+ZKPjP2jFwhbpu3lw75
	YSuwNzpSw1+rPaJFFKC3JlerZFShMr3HC/fRaElmsjEbDBME3BSn9qw9bvz1JkzQHAIV5c65ocK
	XrzO+3JYFhqmm07pm2FIH6nxcQzX3cOaiz7VnK8Ohwag8eZJ7bAky6pZx/9hy1FRtBNG8jNajCD
	KZGGVmE5ltTObIosTUTcKhaSZh/YGC7QzfJ2QgX7zkmB7ybFj0Px3uwUSvd+cykpjc7vaK6AqKY
	KlLWmqUrlPyqKxA9z2Urc3TK7S7OhCqDpMmPQE8V8QJLi223nS/SddDKAAC71cR6YnbGoC3ykp2
	xy8VFjOaAFBPg0MzhLOHqtyab06ExfcJy1a9RldvGc4iK+UkT5NBIXOTiBX+r//2Z9kJ6UXlZYZ
	mqzRN3Q7fdNCvpFPAFJhVcAmiNYjJlJgVJyvX6F/AKorqk1c=
X-Received: by 2002:a05:7300:8284:b0:372:390e:1499 with SMTP id 5a478bee46e88-3768675d207mr1771712eec.21.1794365867258;
        Tue, 10 Nov 2026 18:57:47 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.57.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:46 -0800 (PST)
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
Subject: [PATCH v25 13/16] ALSA: virtio: prioritize capture period work
Date: Wed, 11 Nov 2026 11:56:52 +0900
Message-ID: <20261111025655.63951-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111025655.63951-1-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
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

Use system_highpri_wq for capture progress notifications. Capture now
always uses request-owned storage. Playback keeps the ordinary
workqueue. This preserves the priority proposal separately from recovery
and accounting. It provides no hard real-time guarantee and cannot
prevent reader overruns.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -173,6 +173,9 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
