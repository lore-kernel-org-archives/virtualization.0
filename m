Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981961;
	b=cHUFyH6tu21oyuA+0LftEO3C1ace+S5apIyS20R+kg0Ven4VuN5Xq6zBcHm5+XeSqTOn
	 Fht4v/N9zhgSzDggO1htzAlkHj1/QDp6ep/042APklHEdkrXkc3V12nb4CNtH2x9jcIJA
	 W8GtqcrNYD1QOu0ZgSLO+Bm9m4XntQ252+36R0MG6u8Q/2MVuEqwnlAEbw2WQM5wFqb9W
	 iQEujgcAFhevfQj+chS2bn1QdyLVtgqlXCbu32/Ydi5x9hDUXJ1FHGrQh4xJbXTMI1tBx
	 Dg3MW2H/sjYoTDfrQB1+i2Ban+FT6d+rlsqAxaQFoe848HRhHr81qu/hXmDkKF8gmCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
	b=UnYWemkT4c5wixV2TDItA5sP2uZ492kCNTOlIocDJgkU+gQY+X3UTzlpZFIo5TGvfxge
	 wkEIWsk7urWq/1DOp8U558Q96hB208qwwbz5S/2J+2NaLPxmk2CcF2pFCppncbm/i5oBv
	 4oWPA79hMggYqdsa2y8z9Icr2XpF9tqlgiVQ7/n9JkB4JFB4S1ZUf/AXkaPkjtsbwcCie
	 mhk4hTzUJ3LUzdN7DedVosn3TbActAItDK883x2CoUPVi5onhUVCvuP3OrQjVV8cn2pm6
	 HWLB3FUyFbX2qw+Lg3no/H55GdajTnvClS2TeeW+TotRf0LDi1NnxAaryOPAyIWcyJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xOjTXFx9;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F51608361D
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F51608361D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xOjTXFx9
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15ea896ddc8so1493015c88.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 08:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981961; x=1794586761; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=xOjTXFx9Ths6SogdpwVTNF0MCU/lesy220lG36lSCDEkkn1rl8qGi0tA/NUW4VIcfw
         hiGfut1FEBVG5xiHk52hnm6huZvNuCGC7eZnQZOxe4xsed1hT0NZz3kPGiYBl3T4hUOi
         VHSbT2LM6+aB1lenNQ/9dhuxaVGe/Sbprz87lOab6niehe88xtuVaAq62Sa+JsaSZ7/a
         AX4jMSvwEYb6g4hvzsDl9QSrOBkCBJzdQsp8KvnSQIVsmIRhOUtSuYgNmmEqMKfDfpZ3
         3NfYRzIjfk3Z3RCrNSZFDsJV4mHoBgzXev/1buBeTXBUjLxGIBMzy4xAwPrkUwiAn6Zs
         HVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981961; x=1794586761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=Fv9ReNNpcjju7P0Y91aZKTY8udb/lxT1sE7seabkM8O1BDN6+y5BYUfn76QFRNqCG6
         pJ1xtmYWhPMHF2HakRA4UtG8tPF3g21R5ctfQWJtoUJlKbHwZTfawKbtTK5hR33IeLBh
         DvZC9ufBoMJGTtfeeoDPrrlsmp8QxqtBHUSQuKjlEWrEfTsPX16Vyb5d0a7vmXtoqRT6
         LykwtxLOOYCILDOsawFTtnKhohPv7xHCLj3IiUBoMblQWASHirhxj0umeS9KZptxyCKl
         ewZCjemTJQA4hm2XB3cyF3JUhOPpo3vw+PLcsK+bpgPrvglqU4VI9cmgysTZkL3oLTSC
         IxyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLwXkI8Kvkdlje0UMBBeKqbcuIF+bzrO/+tINYqDzXizEeTuoCCKGajdWTF/4e6pLcdg3zNbhbsm2ihuazmw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8xQ9mfulVKmSAYa9QU5kclZfqoAkjkTtQBtCAhONHmu9PqfvbA
	8/oW8vE2unIL1MWMoaBRSCqC8j7XZxBSL1JJXh4QQtZ/WYSLWKp2Ts0e
X-Gm-Gg: AYBFou0hIu7M467GVo5GRlZnqMUcUh67f62gewLFhqD+/4Od1UGnFyxn/gGOInJd8IL
	J/018fezPLlsSPYwaFmQgT9jBpYQpXhxnlj3H+/yhLPAT0JS12fH8b7uuRQwut/4DP5fRvNuFx7
	cTsZsF+AEdLjfv9fsf64VWSqyvhvg5WcF0t/N43Bd/EY+rbTWKpdl3Sk2qa+9qPyv0sMMC/QtIQ
	uqyk1WqX2+6Kdf5pEiP0NnpTH6Bokn7aNGra2EtA3q1XYJ1tLYp6GjlpAIqL0pTz13FtxKA/TGa
	F7Ly7Fd8VELFAmeD4ihOwJkDbl/iptTMXuMM8M5qGP6PfmU+Fq04xIivK5ci5Fd4R8dc6d5FnEf
	JMj10uGrWEj1kGjJsHsIPevcRktzyJU/ypzzh5tOf8f5cV9uUL+AOeNogxhzHJ9qLXd0PoaHC/G
	2faiRrzvsV7VgUhCR6oAM74Zan+ZxZPMBS3E0Mde92hcCXb7fuJPkSwYZ2ECojfq0iigusQFwJ1
	WJtUYhe8R6WWYTKW8+w4AOAnEwkzBEzv/wzhvvpML5somnzV6ENUcUVFmd1BUq7r6CquDWdA5TI
	aeI2Gz+fC7CFUBubzUj286cdPxeR5yAuBHuD0ueiWqyUaqbIBp0wj5XK9QvleyMyisd9xoaN3iz
	4xEuW7qrq1NbbLxhQIwjAhFNcjxN+z3l+A68gFysRLvxNVg==
X-Received: by 2002:a05:701b:2719:b0:136:b50c:c0e9 with SMTP id a92af1059eb24-1b25d309c43mr3587753c88.21.1793981960370;
        Fri, 06 Nov 2026 08:19:20 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm13139526c88.5.2026.11.06.08.19.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 08:19:19 -0800 (PST)
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
Subject: [PATCH v19 11/12] ALSA: virtio: prioritize staged capture period work
Date: Sat,  7 Nov 2026 01:18:37 +0900
Message-ID: <20261106161838.94308-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106161838.94308-1-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
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
 
