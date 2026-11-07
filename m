Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062111;
	b=0B/9riev6PXfzgxIvnsV3yLYKhCjXOeqDEBURbTr4+HV0149w2Vpx3YBJv86F1xyjiIp
	 we2mrfXdshwGCIxNwgMbWzeYFZD0ugcebK2z5hwpX3OjYY3UYhwfVTz45G849lP8lGbOL
	 t1iDb9ge5JYA/znix9zkv2zZMKvjMULTYpCn894jH/mvJECe4dgOo36ikGgzsTVIthXee
	 OgBrVfSSMTC5p9G5XR00SMDokuelwvk9R1MF5yPzGjcvQbTofYJfIMS5OBBfIU8hwvVK5
	 5cxXcGyx9m3mItJZ07gsFd1iAjibFSnr/uhhxtJDwt3jYJk/hpp76MN/vcWlKgMNZvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
	b=ePPRHSV+QcmEJ2SDIF28ZoR3X7kLqZVWiud4pegQyc94Hdf4W33h2jK/i60W7SttM4qv
	 bpInIKCEjnL43uKsKOyTljtYZTKQXVKOQRru6iCloPLB3UQxJJwsrbAWLyvkqbRkJZZgX
	 3KdCOhAkt7sDJ9RcU5yuTo075Y+o2vxw3KctWeFBjtSyMWbJfxIrTkI/21akFzqCuhabi
	 Lr/1J13TbA4+tj1ELU+R4D6WrzjV9DtrovsKWebahYOqEByqnCegXTFnVnFhjlGZhhaL5
	 HM/9e/cxV2AcrAqBj8MVRIqSaoFftvoWCLqqDoQZ5uyyP0WNZj5ojdTeYAd5CxXXInw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwM6prAu;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2D60A382B
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72F2D60A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwM6prAu
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2578596eec.0
        for <virtualization@lists.linux.dev>; Sat, 07 Nov 2026 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062110; x=1794666910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=BwM6prAuSs9nNSwZy5CcxsapSZ2KVSuVfWvC7+19IafyZDjRIQFsNBZOD0n6x2GbJZ
         LC0sxXls1JNtHZPsOaurWLfAkCr6LL1/eODzPbq6qgMn0uiQenn8XYboffTq9daWth4Y
         En40CFUa6uRXtqYMMWAj5HNcW/muaBXyAuDL2x2nBVCDI97JqHpDpXnREkh2k8L5djlB
         OMv++YVuq9qi4nsUV2j5klM1+R1PuAgX5Hi2dKXq6tu2hFtil/uqB7gCLQgoQtZq1FXk
         14W64gV1Ag+ggLgDX+H8dkLwX8EqpgujY4nZKPEfjS4Erw5oxFn6HF8Role6wIC6n257
         Gl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062110; x=1794666910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yx9qdA7I7keZZm8UafgJgTm1z4N4QlAmh4J6h6T4bZg=;
        b=e2/54Ieoflm8a37220hb+4Zt7o2fnbJhjpWJm8+bApmk6VbakMkLUX87F1ANy6tCpP
         0vVdmWF7IH4BPzBA8n5oBFfZHBsNMgoW3e6KnRLF3x4iw2p/lWvGKhltGSwYPTKEfi7l
         PNaFqtTzOXIOxCvkRN+PoamLgpYtyHscPgUDE8HX7DxGUoYkqV8s/543YKLxVdsNACTt
         tgoAqMRS7r7EsNlZ5TgDJ1KsgCOGEHIuYf3rdet0P1I/Pyk2MVs0HDxy4ipE9qjpyaqT
         NBKS9inq6UJ1ZafB/7O3wfkSulKPoVILkV0ToeW14dmUoyxrb8bAWFvuEtK3Pm4apj0d
         YOGw==
X-Forwarded-Encrypted: i=1; AL+hErF6CSi7YsNtmi3xpyzyz9eFI4Khd1gQ6sbuAVK/707YXTY7ueWnw7pOS3KSW+WA1mPtXGoqNHKZf7BVTx6cVg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+p3VdlHvTUg2CHAGYBd+5vGWICOvAPJpMlS8jwY3DS8VrTtxH+
	KcmLyLdrmawgaU5ZKlkvUZWziLXCkPrz2KappkuZtyXBkmUi+w5Amreo
X-Gm-Gg: AYBFou0G5093NTG/pC4+jtsw4JXesksTPMynfJz0c/xUmVS0Q8np0sv1DGEE/Xh8rgx
	9+chpbo55n4jTnmOlg6wdZUBGKnFFD3cY64gX+LuGhWL9S5dtOExgMMMl2Hng4XjLepUCwjwWMb
	aZ4VohtgzISu+YVzpqNuhwueNkGeAHV2PAd+HjD8KD39KJcXGeXwMEzsbaBhnfueQPrVhtEGUPB
	Ca4iy2N8l37jEG/8vXC+u7Rg9AAR2PdQN1dKr9IwA8iFBebc6vwLgHn4n9Vxx5rPuWSSqQM5cIb
	mOaapjcZOrHBbJzI3WrIqjT/+b7iEg4gnbD1WygMfZBhSyddKi7pCK8OQQZ73M6C5jhvWG5s34c
	wYpEZjzvJuCVrp7ha11X0K9DzWewBv80pH7i/NsF1Dc5hHDkZymUf/CIIqz5FMPZIUr7AT1h4s9
	dxSWb3IqsEtYpWri9aXRvRMHRoubRWGKVJ9ReeR4U2XgCYcfm5QjNsq5M3IdjA17c5H0SyXBjCg
	AT44EKC4zpyB5UKPwyJTHxisZvjWisOot3lB3VA0LxuBfo5sL8ySYrftWjPUoJBCD+aOZisknyU
	SWkoPSIxZq7bJjjD3hSsoBvaRDCZbZdg1lipQYgyppQIeIJoOZ0/IBQPmRZXz1W5W3hZ5FVXKIU
	NKoWExTfLHFdrPQrKdxWeQ8gR/OWrR9jxOB2exv41mcpg9Q==
X-Received: by 2002:a05:693c:6213:b0:36e:2b8b:a098 with SMTP id 5a478bee46e88-36f77ce5f6dmr8295810eec.31.1794062109556;
        Sat, 07 Nov 2026 06:35:09 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm27881873eec.15.2026.11.07.06.35.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:35:09 -0800 (PST)
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
Subject: [PATCH v20 12/12] docs: describe virtio-sound capture options
Date: Sat,  7 Nov 2026 23:34:22 +0900
Message-ID: <20261107143422.29319-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107143422.29319-1-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
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

Document the five opt-in virtio_snd capture module parameters. State
that capture_allow_empty, capture_allow_short, capture_packed_status and
capture_pause_restart require capture_staging, and use the ALSA kernel
parameter restriction tag for each entry.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
Documentation/admin-guide/kernel-parameters.txt |   29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,35 @@
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_allow_empty= [HW,ALSA]
+			Retry a bounded number of empty startup capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_allow_short= [HW,ALSA]
+			Accept non-empty, frame-aligned short capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_packed_status= [HW,ALSA]
+			Read status immediately after the returned capture data
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_pause_restart= [HW,ALSA]
+			Release and reprepare capture streams across pause when
+			virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_staging= [HW,ALSA]
+			Enable staged capture using request-owned buffers.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
