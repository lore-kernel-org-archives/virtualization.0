Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267705;
	b=JwhQfdRCEWQDh11jAWzjqcmi58huNVZ5BYMPyM0cUlbg0RvXWKcXPDuIXccgoRvfwMCD
	 CSb5v70o2mkCLBpUGNJEoD3Nvu515+JhckESJrasmt1/leMDY8TQ346JgESaJ3aDXjits
	 O4kKIHjtd0ETYMwZpHC09mqNc69ogiaE0zzXEQ4/KxGIEV0s8BOKZ5Il/SJ31Gm9IH+ns
	 5tYJJWHtm9JWPYFksGKIZrO0t5KufsA752l12aoelKVAoh7AlHL1hV0dAfqNdBfY4zSt9
	 4MNM6qz9NoMGWOEcscLBAgqvE/XDohTlVJYHUyt24AJ/ND6LlLg8kXzj+busO0gnUIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GCeNfDJOwvZXuY8dgM3rlag3FgqE7583M6Aa4tPPS8I=;
	b=0IFpoGN7SswiE7CaQMt2y7smw2DbxZ0RbP2hH7HWcx/g4m/iKZoNCpe5uvMKsRbwj2K3
	 htPSEKAlxNxUJRUMieC9gvSJBW27lDhDsrU5oI06GE8TWTRqYW0QJObqqxy54UNCcvPR+
	 vDzsUuEDJJDB4pZ6sdfesgRKgOMbgnkQesMY/fmQS5aIet5NeWba1/VrzNLffjG4OTdaf
	 epcAa+3GoojbG/N1uxGNAfqMkraEV6t6ZNTPvUB88F57iMqIZ1DeYuIROjSfAvngsG9Q/
	 S+UP2v3zDtN3HnUxrXVQ5s/vsMYErBocmorLFIUr7ru66rEe/grLXDGMJHgJWpU4tDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbCnIeX5;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE760A5BD4
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34EE760A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbCnIeX5
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so3074647eec.1
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 15:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267704; x=1794872504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GCeNfDJOwvZXuY8dgM3rlag3FgqE7583M6Aa4tPPS8I=;
        b=XbCnIeX5lfrkwYDoV9Ov5RwjupBAoVBNUyf9DoHho/13ZuAAoXn46L2QFXKz0EF+nM
         3X4Cvcz16kE8rKg1CMb/S7AQblFbSPbWyRFuWVv2DWAvE3IT9MGJUv6y/m/sTbjJzh2E
         NYXeFtOhbOvfnp2oBYWGvO7L5V8LvfY3kiuZJcVwUiQp1edF92P4AzwrYARwi4bQ4KJi
         zEXIuTJvnU/eOvxyUNlzRGNMA7cw2ey/1eiZgorBkaPS9N3NbwQdvM8Iw0qS/EQ7vqFV
         /wvvsu8tsbpb+PxNDDx4ZpqPbzhv3LDWovrMLwpzygbtc0nTDC91vf3Gd+UqO+fOYqP3
         A0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267704; x=1794872504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GCeNfDJOwvZXuY8dgM3rlag3FgqE7583M6Aa4tPPS8I=;
        b=aqc0xnMSmYJ0rto6JJgpe4xfhTwX5T2oNildckK9ux7heNC7s5SsC/daMnEfTLcWZ0
         vJ51B5jnR7MQfd2vpw2BNug08HqQbNZmyAYE8m7hfDjKvqkTnf3XJ7/8djA69IvqLJdH
         Rr12BH3zgSLSxHFgDAAXi+P+KhWzMfBrP0+b2+EREIxDa40BWsQ3XbxJKWNc38HlaHtO
         mqFWvRXOSXInZsLYcMB6NGtLRVvzRnz862GYGfT/KeYgx+zlJN/eFQQ+b7TMA6mK02eh
         4Y97UyDDTutTU9Pzd2zgPku0A/pUGLt4YdTAFeGDBuuGu2xde3YrlR2KhJ/OnhuG3VhL
         JilA==
X-Forwarded-Encrypted: i=1; AL+hErH5v8FtMTN1CBt6toOzSrVoKlgDuuW6rOLwDQxwyFwUEPkp2MEQ4UHAvAzKnv6JEZXKmAsba6MZikTUo71dNA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+VANMSENu4r1G9Bt7ufLoU4zKjdc+2EBbPMJGt3elGEu75JDFB
	X3b0yJB1g68vQ6lz6BabIyE0oZahwauCPWzuRqcczQHU4KJqz4S3u+sY
X-Gm-Gg: AYBFou1Kq8Xwr2O1uBKFkYT9EMBicBepZUVu/KOZxy3CvsQnNHocbtf+J4eopfP/IXl
	WwUMdfDw+S4qY2Sz20YQ5lu2DtOIW46I7fRLBcRfLd8OvCxI3hgOL95eAfrxWUieHWsWkb59uzE
	j7k8fQOYnhkp/PaCPNFLg1z5ZPuydlFZIt1tsvsKzL1WKnUn7ORANYpPw2KB3ErUGTNNEJyjykg
	lAgL49/7II7iirR+WbPYNcjCruJ9YoVmC5/YEIHjnHXYQSwK9SNcgFvN4DThvAvqwp6BsJFXvME
	dbyv54Nb9l+4ZbFAZen3KEWzz//dBrq4GpLYbSFXGFMpzSzhaJq8aAEgLYw3TMYxlsdNjs3l65g
	9Wl/Dt7g0ca65P5KG9XhYMIFz5mzXqVNinOhX/j7Zg2HpyX7i6S6xx5KSMG9Quv/FAnMHIR3lmZ
	6W0P05JNRwTcMKaBA17qq2xOE+9M1WqzYstyCzxaM1RFx4WTukEEaWupAkCFkmTzSSSzVPMR+UA
	i+wErm/rJDniwDQ/N1QXfQ8KSjcrIu6lcK7gSk3U0kujd4GfaO27vVzZ60db3mvjc52zhU29nZN
	Tvru/Umfayx0iujjrxeN6veGG3373t8zn4g2Za7MPO1YicUyZ5aAeRU4RQ/ZcgW5ulbetobIRYc
	/3Y4MA2P7h+i2ePeQW0yteD4Oys/LQSWQhyM/rb+QGf284rE=
X-Received: by 2002:a05:7300:d204:b0:370:1652:5ff4 with SMTP id 5a478bee46e88-3751e99347fmr1011593eec.6.1794267704227;
        Mon, 09 Nov 2026 15:41:44 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm1739049eec.5.2026.11.09.15.41.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 15:41:39 -0800 (PST)
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
Subject: [PATCH v23 14/14] docs: describe virtio-sound capture options
Date: Tue, 10 Nov 2026 08:40:49 +0900
Message-ID: <20261109234049.79534-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109234049.79534-1-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
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

Assisted-by: LLM
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
