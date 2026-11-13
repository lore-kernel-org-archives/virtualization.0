Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552116;
	b=xqLAQ94QpldhXzI9sxUfrxwb3Eh/3hMmlC7p97icz4kHsrxjVkqz8nZFBY8li7R1y+aM
	 UYTcQsCmNA+8A8zc474GiMH3l+WVMTBt6D5jDciq0/nXPFvyI9yV88S1BHHOo2GjTpFuk
	 bDEBFLZlPRa/K5OzZZPv2K76IvWVIly7jsCqi5CzE568olMoq38WJxQeYVA8vGH9guK76
	 RQShBHxwe03I+KfGuXXZfwUutIMJUDfj9wTpbFgerQM2F3Fz+rT0rc+HlJ6zAViROzLnz
	 WNi4tHMWuQCNj80pf0MDw596JPfGA6qAyejUboPdXoNyjN9OUnmrzM0iDWRHZhlZR6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552116;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xt4nVbr+QJWsmhkuk9NO2h+mQ+GI20Tp8xXx6ZTHMq4=;
	b=Sic1nGu2sUDDknEWaCpSS+XA+fiyzFRC/1qbtdgOhp7Xw6g+f8N5Baap0GB+A2J7oIF6
	 nKgYx6QslHrynYbw8FODxZyt9CCFnMSs/Ht9NhiAXoL/nFWqKF3xcKACY0A2qyu3QbPSw
	 5+Eob7iuej/0WUGZ3aFh9cBg3gvp0AwPPjwI/Ee7hZbtMq9KgufDnQkYcwnPPTOTkePQZ
	 brKe5MAUtNyxydHIu/Qi4B4TesTeUm9pzEufb4T9ycIH3bSgemP1SlOAGkCJos2U9egyU
	 zzL56ZTTHVmJjDtAi/D7wU6CgVJOKMA6b46KEqh/Nxi18hlCEMj4m/LNjszISWsyIqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiubbEwu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3060A2605;
	Fri, 13 Nov 2026 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiubbEwu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552115;
	b=MVHcbKTQ9IVsvUEJSDTa1GR0Po6ZpQTFpo4+uarHNN5QpbFIJXtBxrcGicZhQwQUfM6L
	 deZOiXkmhr9YyxH3pQOrmL1hdMOLG9JX/khG9eQEu/Jk1+8kEjqaTLo5QIN15Tub5bhCP
	 rWPpbo7iiy9I2aDnCIwQjkfADyJgnwijZiymQkUCiE5im+ko6sLMyaX98VJHZdoCKCneq
	 bfDMWa1iYwJfrYozKIIlMnu1LcdBk7Xm7tZOBraJrq/09m/3AxBVAjGR4nZOfAJKWZHv1
	 HZhYPCl6dCliOWAuEXBg/khCz5UyP8p3RrWpc5+29RTFmZ2SU5mBLvp9esP+EG7vthA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552115;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xt4nVbr+QJWsmhkuk9NO2h+mQ+GI20Tp8xXx6ZTHMq4=;
	b=WMPCbwWihXDOLJ9adtF8Mh7RUI7KVr9cM1jFOQ0/gOt31md9mRpJKDG7MJEec47AfGJ8
	 gsirbHBwDcw9gRrF9J5L6jS5MH7llfbG18wXxd44SnCS/dK+StzwsVR9jzQ9ERd4Se/gj
	 qCaHUcMbgyMPmV5s46qRAd6zD0uCRF6QHLHqEkA3us2Wy+k0XprYC1tWX2U9BuBYz7/Ft
	 M8xZEtXcnvjnL0bLGd/veEPlYgBx/DKhn77RiK++0Z7T0lWhzgJF4dEwYlVwlsFWKiyQn
	 DiZS9AXFQuu7tHbHPEz+ui5EEzmlvDXgHH046cVHpBDqKrb1jZdSYW4bfGBWM5vQZAQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 71B8C1F000C9;
	Fri, 13 Nov 2026 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552115;
	bh=Xt4nVbr+QJWsmhkuk9NO2h+mQ+GI20Tp8xXx6ZTHMq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YiubbEwuyPvUZnopFimvsI0SxaZj4izp4Gjn4l9ItzCgXQTv0K/TXXqJF8r0C3wkn
	 68cpAp3C36FoDYDnssrMBnWvJbTjhmyEYIzxkt3+qbdLesOGnep8m1JnPUwxJD8HIZ
	 rd2gUb+VGRuFi0ml2QIn0mDZJ5BlmEzAWdImV6XDPBNwFDi0AkYDD0+Q3s/CteLTQc
	 fsUMPVSFBI4Im4ayo4nIPzc/kuwZ0uv4cEspfVaWsv+ZugAJ6D7YlfgGX36hoLsfQg
	 IMY7tfy7FzKZS29Pb2mwf+emkbAX8uNaJuONJxi3MFJj4IYKWop6f8Dghz3Na+M8QU
	 s0Q486q39OgzA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E29A14763C;
	Fri, 13 Nov 2026 06:41:51 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:41:45 +0900
Subject: [PATCH v32 01/20] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-1-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=3315;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=sCatKzTRQ727dcoeYM6czFLlHu2crS/Fj1mgMxGQJm8=;
 b=vCKzc2k3pom+yGZ8MWz+RDqrIivSNkLZhzoLkFrkguDqR/O9C7S1uwvw9gw5vXcbWR1NZ9OQQ
 ad2Y1yP88gIC7NSxzLEuZlNH0xfOoRCHX+vWxsta7yMNwCG6lGuuLm2
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

The staged virtio-snd capture path needs to sample stop_threshold from
completion context to distinguish free-running capture from bounded
capture. Software parameters can update this field while capture runs.

Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
status read with READ_ONCE. This pairs the assignments with the driver's
staged-capture policy sampling.

These annotations do not provide a transaction for the entire sw_params
update. The driver serializes its cached policy and accounting with its
own substream lock.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/core/oss/pcm_oss.c | 2 +-
 sound/core/pcm.c         | 3 ++-
 sound/core/pcm_native.c  | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index e8df27d09b97..897c8dddcfd2 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2958,7 +2958,7 @@ static int snd_pcm_oss_mmap(struct file *file, struct vm_area_struct *area)
 	       runtime->oss.mmap_bytes);
 #endif
 	/* In mmap mode we never stop */
-	runtime->stop_threshold = runtime->boundary;
+	WRITE_ONCE(runtime->stop_threshold, runtime->boundary);
 
 	return 0;
 }
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 064df4cd3b50..356ddaf33f63 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -422,7 +422,8 @@ static void snd_pcm_substream_proc_sw_params_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "period_step: %u\n", runtime->period_step);
 	snd_iprintf(buffer, "avail_min: %lu\n", runtime->control->avail_min);
 	snd_iprintf(buffer, "start_threshold: %lu\n", runtime->start_threshold);
-	snd_iprintf(buffer, "stop_threshold: %lu\n", runtime->stop_threshold);
+	snd_iprintf(buffer, "stop_threshold: %lu\n",
+		    READ_ONCE(runtime->stop_threshold));
 	snd_iprintf(buffer, "silence_threshold: %lu\n", runtime->silence_threshold);
 	snd_iprintf(buffer, "silence_size: %lu\n", runtime->silence_size);
 	snd_iprintf(buffer, "boundary: %lu\n", runtime->boundary);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 35152fae74ca..a2ea44c3c1d2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -871,7 +871,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	runtime->period_step = 1;
 	runtime->control->avail_min = runtime->period_size;
 	runtime->start_threshold = 1;
-	runtime->stop_threshold = runtime->buffer_size;
+	WRITE_ONCE(runtime->stop_threshold, runtime->buffer_size);
 	runtime->silence_threshold = 0;
 	runtime->silence_size = 0;
 	runtime->boundary = runtime->buffer_size;
@@ -1062,7 +1062,8 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 		runtime->period_step = params->period_step;
 		runtime->control->avail_min = params->avail_min;
 		runtime->start_threshold = params->start_threshold;
-		runtime->stop_threshold = params->stop_threshold;
+		/* Drivers may sample the stop policy from completion context. */
+		WRITE_ONCE(runtime->stop_threshold, params->stop_threshold);
 		runtime->silence_threshold = params->silence_threshold;
 		runtime->silence_size = params->silence_size;
 		params->boundary = runtime->boundary;

-- 
Git-157)


