Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794561697;
	b=XvaAqwsAfCSBo8dFQMXOGGRap0Leu2mHyW5VUKvUay8QtKTRh+Xk0YbBsBCUlzVz2gL7
	 fpBmkPwNfKS9VNFfau+HP9fas2UfLy3XuDu/xBNFeXPL0Xu8X4QtMtIgwOsC4VX+n63TF
	 KSMOn5MRS7ioNOxnlKUiEe2a6piIqOVdshKM/vPeLayQH9n9wvPAkbpERVaTwihyEhNHI
	 uqLqdGEMifRN7S/eNxIlUrK0sTKYiKWt5YhladX/PD93wqz2bM+Pvg6Efd2ZwAUBGcqnn
	 kq52D9/lFPH43chTJ3doTjsXR49b5rw7ElexSX2ievgjTPSD+R/uI9pdvUuROeSizmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561697;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=81m74lbv85pW2cQN+rz6KutFlg5imIQh5ZhE4mUfwHY=;
	b=IF1NnpeCD5Mqd4GqSUiNvQ+BqvuwjQFP13wWRNEGfHX3N4NU3EDxAHQBq/bQasuF8Vy5
	 yTUgqQ8cvYE1jvnPuhrazdYR2lmMfjWXumYjowdX3ZpxEdh0Uz4LHfPXl2RW2vHK4ckoS
	 4Dh2aFdw8T6YSfae3+D8KuqZTxg00HmV6/aHiQHs8ugFHtCFnvy9J41mkuXQnmaXgGzgF
	 75cRAHNKfjoiWAfUFli/aVlxvd3q+nYpu75ifeyBE8vn0xQXB05AjFGOSWto2z/lrfoA3
	 AUZLdnyCxaes8beA1YcEDkyBi/3dvDRkM2tW5IInmNVMV/GWU8f30JmF3hyFDUP3tQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3lK8pqf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3860A2637;
	Fri, 13 Nov 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3lK8pqf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794561697;
	b=cdbNSi7O4WY9zjomEEeuYmignD5lAZnk0K9AS+WHFpqlM1TkZBLRvLNmz2IEXK5UjZft
	 Rpgu/TXrN+hrqfrDYoxQ8h0Nyd8x4H9HJ/MlUYaXcxILVVajlJ7Z+PjyUyK7Je9SeHL/6
	 ON8i5CTtiaTx1Fy28FXkr3bPT+/qf9Zgaq5vdLU5VJkYvct9AAjny89l213g1v5b0IiXG
	 iydI8Y4LPakvVbBzyZHWGaeKXyhTS2fZjoSyf6SjCeBB44fbJshM8iwkxMk1SpySPtd9/
	 4XnYV7ogHO8lMIOwcFlxf12wTrhEsVXLnD8kM6fFhUNoXZd7An6rs6dtOAHqD0/0z7g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794561697;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=81m74lbv85pW2cQN+rz6KutFlg5imIQh5ZhE4mUfwHY=;
	b=LR/7rRc1jaH+1b7THFLP0jb5JRkqNyz7hPrmQ4b/PMIUJBJN0Xf2D6NCzV+0XND+PS4k
	 hEasTm6p2Mi5jXq9wNhaqaCLRb493ZZSfUvNB4RHvFfbNNOgcPMu+vFWshV8NbRfe2Der
	 vQ/wAIt6NB4uhCjLHhPsNn07i+X18eZ3shxV6VCwvWHG2CLZcjdLxvSd+VfxGF/Cxvebx
	 vjhBkIduADPLtvaIgDCGpM2F7gahfgH4NKv9lrDBM9U/d1s9JwB/Ko+p8arUbRsQd8wkF
	 /7rHK1Bkpwp1zxUA/HHtSnVzS+AxxVpuSNDoIlqrNgK3TgLC28mraQI/M+PbU7Z8CmQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9F1D21F000C5;
	Fri, 13 Nov 2026 09:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561697;
	bh=81m74lbv85pW2cQN+rz6KutFlg5imIQh5ZhE4mUfwHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=M3lK8pqf7gLdfxBCvUuQsSp6xHAq9NyTm/o262yuackD5puXd+lsnGRTGjfuwQFqU
	 phFTxf7n3v0lFEQNnm96miY9rdtLi9PS19A2voVoBwfKuHfAo4LTSC9chcmUA2TjwP
	 mWJMyDQnaYdgpkrfi5pY4WaG6eJ4pGe4iPCyOA62IRvQ22yTw3WCsB59GAOpwtHTSx
	 +4XNZPAmGP4p2AO+2NE7UEjo9c8tS9LBzPKJ8wrIMYDhmqkSkpX+WoHohOS3vaM7V5
	 wXCSp7k9Ks4BiasqOsLFoFbG4P3WIfOdW3fZyerIwa2XwSWo+ylPQ9U68CPCMLaNgn
	 u50auJ2pPX9cw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 56F5C47738;
	Fri, 13 Nov 2026 09:21:33 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 18:21:37 +0900
Subject: [PATCH v33 13/18] ALSA: virtio: prioritize capture period work
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v33-13-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
To: linux-sound@vger.kernel.org, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
 Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794561688; l=1001;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=K0F5pXJldL6rCj0lz2VzTTvcGn52OcRIreW1oqqy4Ws=;
 b=Tbvr8XYybg1Kz/dMfV9tRrMB+76HPqUk94t/Rxj/3cWNB8pe7Y+qIzJjK3OQEZjwie4neO2Er
 tNjiWhLHHO8BVi+eEeuSREQ7tdm4h3vSANt9ghPvLREMSH00e9OXIZZ
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

Use system_highpri_wq for capture progress notifications. Capture now
always uses request-owned storage. Playback keeps the ordinary
workqueue. This preserves the priority proposal separately from recovery
and accounting. It provides no hard real-time guarantee and cannot
prevent reader overruns.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/virtio/virtio_pcm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 95881a3a2c57..987105145205 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -173,6 +173,9 @@ virtsnd_pcm_defer_paused_xrun(struct virtio_pcm_substream *vss)
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 

-- 
Git-157)


