Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552119;
	b=Hnzg+Dy/X1qeT7zSqgCk+UFVPb/8Ymu5Q5p0scgLGfkkvi2nlAqUW+/3vjSwDzgJ4PAa
	 s51mSV0jY18yHcv41WqhesFVLNslDWCkV5tXsAMPy6k2sA7+VTRCJA1QTQUzFVflnOsSq
	 luaO7U92U/VdrxebHc0iiy3xENrkNhChEBCxmjIvtjRPHrmpm0Hs8RKNm9uRpYLzwtYeS
	 NSEQtQ5RFCRnS8AYbRGCYSPIW52uG+6Bx81qHzlPnTNaPkhC4CGjasVh+Gcqe5wkt94Y3
	 u3vKQGKBNwvibcRQk7iOhDYBpGN4TMYyq7Z5VTPytBya7XeFu9twO7RPagYX21NTOZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552119;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Mjq1IqPuv0wqkFvIHE8r0zTpP4CafAeFS/MRkBbdYxk=;
	b=DcxOrYcMf9yhFL6Luh2vasvwMhyYsNSc9Gvk9f1PrqCi4crdcEVU4YH5kKeOs7ebQ4kL
	 lhZ/386eu7PWnnsCCno0Uf0nJaRUF9wTpxHCQywPmU9Jb42WI6vEFQqjUMKYVjU0sepLG
	 Q4PqjROP/wTwhPuHmGmm+/zbgb2BxyjX6rHd+5InVUpZBqcC9TigCagL5qmMKWniqkCMv
	 0yBb7QBtFs6XCxN0xLAEFHfCoH5DL1FJw49GWpb9ibYSH1/Gua+NOHLVZifihi5tTToQS
	 DlF/J7nHD79kuFrQ/Mi1gfJfmaRa9da8p/vYXNazy5+m8iNXLDiwSKOlGxNUSEyoZgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIMRiH2u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5F606A33D;
	Fri, 13 Nov 2026 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIMRiH2u
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552119;
	b=Io1ZXW2LUw17oy3s4ZmI0kHUr7v7o0BKOga2DMx9xcnEA8QYPmYCFn9uZCBOW0dFhkEO
	 ZbExhVQuBipqFfmltpEoHZTsQ2DOC518rXJawX5KkNLDymt8+VvKOTzVjem/ZN3/29d9U
	 G+O82N8JPmtRB5c3PNGsUC6DvHW6WbzasgmA4erni2Do3E3MRg3NCULve5/KO5ipwhoZy
	 tMqz8xZLq+xbHMyMMa4ug69wj1SWNQh9d/TgSoJBt5/ljeu+s6NgseMwsPhZriwT8IwuE
	 le+LWeC7PeeNPoj8buS9N4tisB/iL91H++tfggaBBlxim1VOKuITflveXox0dKMTJ9w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552119;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Mjq1IqPuv0wqkFvIHE8r0zTpP4CafAeFS/MRkBbdYxk=;
	b=vmt4BnjHaWNQyHVL1E+w4Dz5umcpwrzM0F1WR7QYVofo7z2Qro74DtHKQYiNSEfZbzIg
	 R48pwjncW1c9IBSnzmgsHSVJ4f3PLn+Cw9HOyLBlOp448fBa8W5+8RMphLnZkLXa8nxCA
	 khMU59SD2tXKQUDxK+ClYelWCiiuXXRB2DG5Nv2hGeWWLvWW+sba10qKTp6ihyHxWSea0
	 yDTi3Mg4mV9yhKKsRXl3CXtCSQS47y1VMSn1kaBl8YHWkJycIjesw73Cj6VaLI2iEHYx5
	 7dz+aYVziXRKLwRqe5y/vAbQdSb7FX8jsYQJ0W8a+H75HilJfoHIlhQzfUQ1oB++/bQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 11BD41F0092A;
	Fri, 13 Nov 2026 06:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552119;
	bh=Mjq1IqPuv0wqkFvIHE8r0zTpP4CafAeFS/MRkBbdYxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CIMRiH2uYVx1LdhF1625nGBHu6m9WTKmR8//v0r3JVznlUd7LaaMWgPFk+DFy4827
	 iZP6bRRB9nH9TJVR4lmsAgXl1kaTVMx6KLbRICYZre98/co0f/5xgjar4AUtqHjgIa
	 XN9r4/QhhANyobQOUdFv1mxBUo1qvjha2bi1rEnFfWqxsUdyxkK/umqgK4AJNTsG4Y
	 /bN6z52evNpZr8/CnfLusY3H9rAWOGFE497ZMPlkDUUyhFBeBIAcTXoco5VJYvaPnJ
	 FMRJuwIHEULe0BCHfSMrCRWSuPaLCXXacf5U90N1gJLb4+4P6YFmvZEVMkZYVn1VFe
	 4TQu0Zj24WTCw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6CC4147681;
	Fri, 13 Nov 2026 06:41:53 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:42:03 +0900
Subject: [PATCH v32 19/20] ALSA: pcm: allow stream suspension without power
 management
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-19-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=2166;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=3exDiH1TdiDmPhJt/w3j/w6DMwZbWLwqVdLqWOiTBTU=;
 b=bfJByh7/8yxMt79AqWrFUhmZADY2F3J6v8pSvc/UXtlzHhtE0z0kJvBK0Y78zWsUs8qROpC6T
 DtNP3WzIx8yBfwg2HXmb104xQZOy/3WKpR/Urb/DCMKBTEhziCyY/wQ
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

Device recovery needs to suspend PCM streams even when CONFIG_PM is disabled. The no-op snd_pcm_suspend_all() stub leaves active streams running while virtio-snd resets their queues, so an application sees an I/O failure instead of the suspended state needed for prepare and recovery.

Build the logical stream suspension operation independently of power management. Keep system resume support conditional on CONFIG_PM.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 include/sound/pcm.h     | 7 -------
 sound/core/pcm_native.c | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 7150f8356dc8..cdbde0524dd4 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -628,14 +628,7 @@ int snd_pcm_start(struct snd_pcm_substream *substream);
 int snd_pcm_stop(struct snd_pcm_substream *substream, snd_pcm_state_t status);
 int snd_pcm_drain_done(struct snd_pcm_substream *substream);
 int snd_pcm_stop_xrun(struct snd_pcm_substream *substream);
-#ifdef CONFIG_PM
 int snd_pcm_suspend_all(struct snd_pcm *pcm);
-#else
-static inline int snd_pcm_suspend_all(struct snd_pcm *pcm)
-{
-	return 0;
-}
-#endif
 int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg);
 int snd_pcm_open_substream(struct snd_pcm *pcm, int stream, struct file *file,
 			   struct snd_pcm_substream **rsubstream);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 8131a7be5dfd..a1c13647a14c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1828,7 +1828,6 @@ static int snd_pcm_pause_lock_irq(struct snd_pcm_substream *substream,
 				       (snd_pcm_state_t)push);
 }
 
-#ifdef CONFIG_PM
 /* suspend callback: state argument ignored */
 
 static int snd_pcm_pre_suspend(struct snd_pcm_substream *substream,
@@ -1939,6 +1938,7 @@ int snd_pcm_suspend_all(struct snd_pcm *pcm)
 }
 EXPORT_SYMBOL(snd_pcm_suspend_all);
 
+#ifdef CONFIG_PM
 /* resume callbacks: state argument ignored */
 
 static int snd_pcm_pre_resume(struct snd_pcm_substream *substream,

-- 
Git-157)


