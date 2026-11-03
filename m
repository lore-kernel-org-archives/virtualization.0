Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693349;
	b=bGiwxz2/56fYNUkvNnpvUqQYolVdnC4HxmLFhwb3py2xYfLHQDgHrhuERPW5k1CLE09j
	 m8NUW9vzx5x+CScXy0dK+DxyPXv1V09zHj/pM9bNAFPMfXZLXjZ/Cj0z9d4UXMexYBM8U
	 sqbAHPzdQC3xO+OoPmjRIXs0zb7JaH/IstqK/zLWJ96y57pfuE7xW/XI9MR4l8l3W/5tj
	 gchnhzEEpl/B5WeNgUtlVeWiyyTfm5r4WluNzyChHUVH5iZZjzH0/muxBW/pHwOuenmHp
	 338tUkhbDYag4bL4xhAP9ToJQiWKDxbW79B4qIulBeMZn1BXT3zzxcjoVKncFQumWlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vOwlBcev1S8HKV7nx+URCpkHr4Kt/un4+8T7BIrH814=;
	b=sdHbj4QWyLtH8hjGRHnR/mlElkS5pZc6SGlb7Mb6uhuQToJfGSy9MeDHOPuG2iD1EW/E
	 LyOxmfHaCxL+EfujoJubZkCrPmbBS6umIS5LXasb9HvF3stcbX7oXW2xccDa38bIxMV9C
	 /RXcpD+ZLssNOxb238T8/BX+PgrsBfZC6mhe6Fy4eN1DfECYYLnxEg3DiQ4jVPa+7rJeL
	 mIbps8DEAj3jIihcVbuRsPtousE+Kk8ekePak1h8aKn7yppBVBt9h5Ps2yU4xvlpKuNwE
	 WY8aanO9ZeIfNAEuvAAgz0qnvhVaXLum48pJdMI2GjcLyjl8tmg3u9UwbcTR4//sTNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTM6lG6E;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D18606A331
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D18606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTM6lG6E
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so5499475eec.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 00:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693348; x=1794298148; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vOwlBcev1S8HKV7nx+URCpkHr4Kt/un4+8T7BIrH814=;
        b=zTM6lG6EndW7xj0g0e/OHdCCqlO/o8E60Y7bJ7Joe8jHnGrQGEMRN6Zet2gxrQcXW1
         FfCCleVF5HE/a3m9NinHZuwr72YZT8wdy2MKInnIdHAkI4dcGbmiH15iJX5ghaSwSAVs
         v7hp8RBQb8NHq5kT5Gx9esBRQwDnj81VsXg3sODOxZmO5wgho4PPo8AZAUSxnlFSx7GW
         zUUQhPx7m3JrY6VBeLErVyx77lVsj+xoA85BXf2o5wjJOuoVrdcP5YC9fs2q3fW3EqVS
         /fbUYZr8yCRv9D/h/hbBPZkAfQo4DlOsQX4aVhakRT8v8JsP21cXU+T46807xe7NBgeK
         22Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693348; x=1794298148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vOwlBcev1S8HKV7nx+URCpkHr4Kt/un4+8T7BIrH814=;
        b=w/Nru5ryWc4m19BVD5UgW8Pm0yp5hbJrUxBDdezUUFkONPUdUD4X2ihQjB0ZvglPWx
         tvZ6zravjv6Q44JAtStdR5RlWyN6SV0OM1VPfQJB+CNRC2zV87Ri/ktRGkFxnyxcjYhI
         szFQkJFbV9Pzgx+dIPERKu4606jUAjp+HcUqRln2031+cGcqjq4tJiwN3dCuJhVrKHaI
         +DYIQCscgj6vhvO0cSzw4OY4MsLiFZ5EGGrR/RYHlaENXUDj0ijvVcLJFZw4xZ+3yqpy
         871lRxR3JMoNyVYEn2eaK8Db3U9GhzJTdaUUKC8GqmdDWLsVe6uiIgIVjOZbdMWwyOS1
         La2g==
X-Forwarded-Encrypted: i=1; AKwUvBwjEzIOW1xWwtbKC5T/IBVkdwGuSkx1N6CT1QnNkcOikPuo/necij0TXOxZK9d8u4qguIZ2JtasnU+/BB/pAQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/OOSoy5DVGc371jofrz5e6k+z1l2t+vNa+Wvj3Dnnc86wRER/P
	5fjYjjvjBcqV7VCB6SxOCunFNAbTLSWnDzbNfGOAE15AZDcpHPz3Tq2C
X-Gm-Gg: AYBFou03iRaBpAFB0btlZrKBUNoRc4JWytNd8ACeDPMzczkrWET2CCX+D+0uvC55aMm
	1eE6zIXk3vFtPZEmaXrnGNKCqtudNTVjkm+qPgUwx7+rG5+09re6JcdPtOYvn+V5AHjbzbSlPN5
	pyeEMjSLjw9+OT5VTtpZyzor0ih9h0yLWmuI4hfyzp0L8RejgTFKSUfXwUEZfybe1qzmM2RrBrG
	TmyNvwDqZUocxx/EBEPiNg8Ci99DtBEH8NKBEVirJA9ZNbjnq/hwer/Xlq5alMoYYoWXE+L9mkH
	dTrJ1E3d5+364lTj4254WgyIl6Vyjx8+vfoAtptZpDLDl7lxeuOj0RwQ9H61zCImP2hoZj1p9Ur
	2kHATxtKdyw7Agca5yzMRCKqqEuLCTRikVnHK1KI17z+xRyhWx86l2MXso0vbxNXfAbIlnE58Q/
	GWz4bPBwkgckUck6izMOLpNKOjj4eEazVf9nSNCtBxPTiUe7jaFktX1KtxuNxqBnbsSbLS3wH8z
	nIpvTdIaLWqBW4pWzNLQvvfMwfLwTSdiUng19wFArQpMIc6kkPMwHLWvsjY9vrKNMp8Owd00tlY
	0hvphCBdfKhGyAfgYdZ7WKdhXRhekGtj8Q4qYdbuzDzvFeBElIVQO3/JNoM2pCvtyhjvyda9LcY
	dkaKVTu2mt19FRstQVdauhkbzviCkrswUiSXyf6f2IV65pK8=
X-Received: by 2002:a05:693c:638e:20b0:369:ef63:ea95 with SMTP id 5a478bee46e88-36a423624c8mr18389092eec.6.1793693348178;
        Tue, 03 Nov 2026 00:09:08 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm41468466eec.12.2026.11.03.00.09.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:09:07 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
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
Subject: [PATCH v13 12/12] docs: describe virtio-sound capture options
Date: Tue,  3 Nov 2026 17:08:21 +0900
Message-ID: <20261103080821.16983-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103080821.16983-1-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
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

Document the five opt-in capture module parameters introduced by this
series. All default to false. Describe the startup-empty, short-payload,
packed-status and pause-restart compatibility behavior alongside staging,
and require validation with the target device.

Keep the virtio_snd entries after virtio_mmio in alphabetical order.
Include a diffstat in every mail patch.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
 Documentation/admin-guide/kernel-parameters.txt |   30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,36 @@
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_allow_empty= [HW,SOUND]
+			Retry a bounded number of empty startup capture replies.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_allow_short= [HW,SOUND]
+			Accept non-empty, frame-aligned short capture replies.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_packed_status= [HW,SOUND]
+			Read status immediately after the returned capture data.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_pause_restart= [HW,SOUND]
+			Release and reprepare capture streams across pause.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_staging= [HW,SOUND]
+			Use request-owned buffers for capture data.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
