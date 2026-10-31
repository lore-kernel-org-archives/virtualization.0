Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412576;
	b=qJgQ+YW0cv5Qsn2vSy0XUvHSZiVkb70xfMYiogC3/PUa+iwxhM/aTouexWROPa28W8ra
	 +SIQ33RzD2aotfGlGNh4swEqRgHDgM3pHXiAUTanjn9kb82TrfF7VQ90IrR2TCKmB3Bo2
	 1hUliK0ZOnAXauoc/Oo/9nvWbtx1N2jPUXKLpZefwqpS3ZOy8a9s5vvhV8JG5LQx0caBA
	 M894WNWoT8xIs4incFQ5THzt60mGooaih94OqJpF7tjdjxJlKGmGL8BkmFx1ylHtVL4hZ
	 MnuJZW5scQ0z8dIbVNRy690wNEz9XnpFiRX4iJDFXLHeRD8JLGXpiPzMZhpMOFLMyzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
	b=a0VE5NTy6yEwz41/QDxoFWxKJhVqGZ95TwuRKqCzV1CFW6Fu/ts9ISw/BLKNT8TUxRmB
	 LK1+m6h/hPngngBkCcMZmBJQ+9TtGyKvNnfnW2W+fColOsM68txA7/Tm2f2qp7AY/cNgL
	 fHeNIymkSx/+gd9j/CmN5izADOCAL/g6NqNTFUS33as30XwgnEo6ilrKauYsEFFw9ikEm
	 3YNUOMaNozpFuipTkj3VQJm95yDVvpd/2mob6AT/7SQxLPVxdsLIJYeWdf/G0w8u2rr8S
	 t4J75IEMM23xJltmwJLFVr+Ar0ssJaChhF7j0zT7cgfZaY38lutV3CMz83Ny6Pk/fdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZF748QG;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C82606A329
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C82606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZF748QG
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36661f953e4so2008015eec.1
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412575; x=1794017375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
        b=QZF748QGdFHKbsB1Zu29eSTc6czdWx+3l9QIrICk+zlQw9s14N5i07zGkrPXnag36S
         pzc5YejN5W8YGfcpKDN84ODhk265PiuLOR8tkhIj/e1IG1C+5QAghmVGFrTHWJl7kCxW
         a7/lPVMvJPK1inTWUvuu1fW3WowO5Vh/xgqd9hp/xsNAazazBKOXVj4ag1Xou9rX+qfb
         t02JjFjJC9yANMcyQcObATzOXkjf7A7ERFPj2bgFhrbpR7rvqyQd8MR3BD2w07gRhnLT
         97mDnwoy/wbC63URolD7DTuMsuUlsvg2WYo/kfI0XW+/uHOv1UDJrovcN9QkmeWRKvMT
         jB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412575; x=1794017375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BRslTI0ynJSL8rFIMfwDZ46YUeqzoiUybS2SxS5DQ24=;
        b=DYXyLkm6NjFO6x+FqOyk/fID9jBf6K8JNOImgW0Tb08bKBIjlH/cyfX3cK0yiOJvJg
         W3iC9lOoT3yG99adn+2Y5cIuklLEBFcMrmXhmhFf3gt1oa9DYfOuNZcrn1LhuRrSai8K
         /+1S9FRTH+c1JlvNgeLSW+OkOcOm2x4wCkeNnaznglGbupbBUAy4mk7snHnsn9KDELvd
         03nVSc7oGbhqYF6gK+1VUmBAXJhx7ZyLHHpAKVSZzNYSS7RcNTgIbvWkT8hrU6rBlRbL
         wmuPMu9E+ofQruDJpMfjNLMt5Yo9t4hpM7yYLQxpbfv44rN3z6SGVTsFriuPxh59zDvP
         gIkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/dKWd3JkqXoQBq7077ibWwD14nQkjsut0Q7k3PzZvg6wd874GNGxmMw229Di0vHO0cvKpXkO/JZEzoy14Mg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIy8dA1ePmIuxaOblE6/6Dr6ydV56mNAazlMFTVSamuEWCU+WRe
	yAAPOwylyCOQFlRDRzn1MCzwIZcFSQNTmJ4lq8WoTCT/Ez9gUgAFcayg
X-Gm-Gg: AYBFou3NKgepuThG9QvrRaESd/KeRJ3sxmPL7EYWf2VL8iMvpdG0ar8ppqmkekaIDGJ
	25g64VOsQ7v3I06eZy0S8t8Vvrq6JpYOgzyS0Z4FayJ2oKu3HgP0HTkgRf2NTpbRb77k6kFk0cU
	TKjstdDhJEUkvpT5ckspRqo4bkFHa2ckFSUcWijE3aFdy6c/m6nrF8d8UcBDrB9R+Fik2IEyNFi
	COBXQPmtT26Ks9+7+7DCNvgo+Vof46DPMC6Vb+8Jits6QafSi6t/V1CmJ4GhRzumlnmeKmy2fdb
	o6XUHsUgZ5GVM56Vr7Mx4XJ2NuWOU0CT2juJuJqPIQy4iVX+U7Dgyij1oJTOOMJ5ewuTSLGN+JS
	5490Qlak6g266wB7cRqKCpzXQEK2SdaleC+WKLo/eZDws0F4VNNDSgKnLOUUByJ999+i/30pab4
	7C8KWibZVtrVGog8JmNLnhvJ7AjvNtZNBPDhT5dwuH4m2WhpiUHmcy5jes3kwoaFMPTbvJPf6zy
	irTRgl8+Q/vOeZdh7cSocua7XBdw+GElzPEHVxUIiliOKL2R3w8L7X63UZQZwzd6RFHRQR8Lyjo
	tMzTNhTteJc6a6vyfRnJG6jmDW1wHG8mwjsU4dd25ti01OXB8zz1+3ougx8zzrMBOaQe1yLpRig
	eUhcuI/xXtDyGSZR9Gz/ZSPdOV66SrQYdZ6Wn7lCc/XRWsw==
X-Received: by 2002:a05:7301:b01:b0:36a:20b8:ee9f with SMTP id 5a478bee46e88-36a42203f98mr5112880eec.1.1793412574561;
        Fri, 30 Oct 2026 19:09:34 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:33 -0700 (PDT)
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
Subject: [PATCH v11 11/14] docs: describe virtio-sound capture options
Date: Sat, 31 Oct 2026 11:08:52 +0900
Message-ID: <20261031020855.2402-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261031020855.2402-1-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
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

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8328,6 +8328,36 @@
 			brightness level.
 			default: 1
 
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
 	virtio_mmio.device=
 			[VMMIO] Memory mapped virtio (platform) device.
 
