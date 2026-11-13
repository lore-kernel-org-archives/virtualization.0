Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552117;
	b=y8ROm6ePhoIwzAO3N6Ngv/Dg9lguSG+zrIS2Mtcb9WnLJtd6g2CyHhCAJ4+rbE1qPsXu
	 4HXm8Invvx13XgWQskHWqCH/V3CzJgW3dxFPb3rOUnFs3c7ZFVgmFOHCHoa6c1cb7tXu2
	 PzLw2wxkZdpUHZSgwxvOeRgn1QsqQ13DjrrFnllhO/5XqD8by9qo6ytp8UWzDku3u65Hq
	 gjAJeJD5OT4mTpD8by5UDjA9FeGc7PthrLaYWQpFPfkPpsy+Ya/mUY17NP6ZtPsu+84/z
	 k+VpoKTBwpI34JELXQu4PUDLEvZ90Q3F8/dc2+hMd4N+WagL/CkyPEeOypxcfT7ch3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552117;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=81m74lbv85pW2cQN+rz6KutFlg5imIQh5ZhE4mUfwHY=;
	b=EbA0Eh0CJ5h5DPLtaVM/rbItoByTWnM/cVVZ86NGv4ZYan5BoUsp9yfGaoaszF357+DQ
	 GuzPpNXnhvrg7oC0biI3Z11jpMseKjcqBRdh6KJyAxvkqRGEia3i9EPQCQN3F8YogYgkb
	 8xdK4HkmLAc0d6bJyC59s4Thd8g9JFIFxaMEjY05DHxDN+Y8DL7cRh8d7B1d9yttdWRgX
	 hmkcicQhkA1rHzIwT+ATUCd9Xs5d6LhB1dsFySEuHCnfqwxeV9yAkOxvtlfIGDrHCmWmd
	 Om3bz7YPX0cMsr7rNufOOza8lVOgs9hcy47KqJi/kaBnQMmaAmFRZAqc0l3cI62y1IQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRocOYEu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7160A2636;
	Fri, 13 Nov 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRocOYEu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552117;
	b=Dq6wvYPeQMpLIfh2HU7/dkrg74jYLFwV7tQWhOpyGJ9ARRgcgPfT4uSd4ObxXayW8Pkf
	 vhrUWk5laUnYdnbKgSin4Q+/E4tMNcNb3dzTTGt7xAGbay+iVpvGHmiXYRApZVYK4b2XJ
	 SHneGKTwOM9HZF6sayutIZpMHl8vSYVN9v+5kBETRG9lWNWwcpkEEjEmKpmWFtdgXX6Mw
	 nxynZmyOE0zrzo3kUydS6csOkUJ9iQtkZxBVa23H+hL7I//AhFyNncesdJNXeDw1dpAzh
	 bEzBYUdfjo2m+KA1xuU/AglbCXFyKLeGJDMD0r/U8OfKGn1Ar0Nks01SVMNwmAHT9Bg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552117;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=81m74lbv85pW2cQN+rz6KutFlg5imIQh5ZhE4mUfwHY=;
	b=zurnG9d660wqm7t5uJgxDUzNtKib2NIpo5h/MClaVMvlnXN61YQZhPXhN0RCKSNTGxz4
	 sxGlPmUKylX2toSWfR9oPcWvE/LHHh6sHM0Yx4FCtAP8tgnBpKaRsKVQj1nhJl+BOEFn1
	 nRyW1ZcWHv6IthkX7Zhjw8IFZ9uUNWmrHr9UeOKhhVfowp2q4do34J1gUWDQ7SSJY8C9g
	 /+7+WPaDYziaik918n1bAXvqQZoTlQbq8gEk5wU+ABNCcZDWJpJsfwKnTGu8kI8szxiYc
	 mxF8eOUiyk/2wE3QSb4ogx7Kgbc5zCXe/RBvoeg1F+Z9AK75MkpU9mB7bFhspIUOsOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6DC1C1F000CE;
	Fri, 13 Nov 2026 06:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552117;
	bh=81m74lbv85pW2cQN+rz6KutFlg5imIQh5ZhE4mUfwHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PRocOYEuLuiRAve3jxLMxNMj5r23IEXlZ0jr/B7lkYDHMp04KEa3T/13OWlTn+Vv4
	 gvb7hM+2/X1aOKGMDpMTzALLKHKFV0XFclBpVXBazPsxLOhp7uubqkyhhl9NxSnL4I
	 vwfsooBUsudeX+XdwICetCuKFEsv+po+ihICIQ6+Vd6eT8y1zFH35yr5CB2tcRp3v+
	 kJtUoKcXTgqVJYY/Y5K7YSSqo1Eep1Z6kv9uMa9vsHpiWEXwjcyPO2+qua6FCOxEF5
	 twzS0myV4/eGh0qj/tuXshPW8w696012uqw/fYF4BGpE38Z6Mcgzf0eTEZOFksVI2h
	 lMXF6At6816BA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E4DC44766A;
	Fri, 13 Nov 2026 06:41:52 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:41:57 +0900
Subject: [PATCH v32 13/20] ALSA: virtio: prioritize capture period work
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-13-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=1001;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=K0F5pXJldL6rCj0lz2VzTTvcGn52OcRIreW1oqqy4Ws=;
 b=aXEZpOCWKnqcPRaYTXvvgjyK3UUMGTCIASub17IIPjI+L9hrq6HJ/pslMjqcW0QvzaOz/JZ0h
 1RAi54rqLxvCza9TMAkLa6SZXjoBqqYRjBRcIIPIhAQwZrIuHwSXXR8
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


