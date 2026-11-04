Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758715;
	b=JrxcGPAziXyAw2uGaSU0F/6f+Ju+DPsar4ScTO5jzH0LWr/2DYOTD50Nv6JkT3RFmqii
	 nmNCoQNqDZ1Uy1XrBUoOmpIOslP124mAGNBxnBkFdyzauF4sCOGgbHbQuoQrjRuqth/9B
	 75uYfmVZkV2KHROs7AdFIeBoEouIZUGl04ZaYkWZoMeFXFWti7TPQJ3pyb53MDyH6fQVe
	 Nf4wAVTKh8XXgXRRc2FBgkv2lpB30DPNyU0YVpW36Glna3/MJVx/iC9BaVZEPjIyF0a/9
	 PWda3nk0BObppfNWSjnZCfC9YHWGGb0HWloa0CMzVjDWnpwAo4LCOIrUBOSrDcNzAzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I+E1FT7j2TPwT2i0hneBh3LNGnIyRwhqUFoGV1aFaFs=;
	b=URyTLI4oqJTaE4GbpoyBapzlHT+/WKTzKxsDzEpkQLxr62PJugFhFIjQXlMCwFcjSGr8
	 o0v4reH7+oZ/EsTV1hjZeo/5CffXeh0ISvqX7/ECOcszOqt/vL/XJU7TtUfDFBBcNt4MB
	 oMFgbmZS9xyrwtK6CN3/doaFg4+rtMhpp52pFTpH5f1hB3GwxYBEra4VposTmpRCHKRPa
	 Pnl8372glPeamEwJUsDO3IBI2TEiQifl7zpPH0mpKt2jm7yFQ3szOznTkXw+Tyy1F3JKn
	 xHiQE5xlv1UEGvRMSm/pJ6AbN9OsE4I0KfYxrmc3eSS/HV9D4dwLg99l/rC9eZ9UZGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pvuaWqk;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD78606D801
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD78606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pvuaWqk
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so233829a91.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758715; x=1794363515; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+E1FT7j2TPwT2i0hneBh3LNGnIyRwhqUFoGV1aFaFs=;
        b=0pvuaWqkyrCrPx8KXobEWRVTlrJ62z+VwyCD2PBjbJpamGfV6lTHNQV2+lMgzUvXqZ
         gqC87O5a5xpnWjMnC3XbVsjnbf4HjrwD/SgkWIbRMme0u1Qwro308O3gPavWOMYVNyrd
         975Kdi/VMN13fTJtEMgTWcti8rk9cpmDOoKG5S1H7jjE0bVYeicv9gxok7CUsc04o+5v
         lGSP8wgTr3kzZ+xDK6t1UnT7PHwEJoQG7Kj33uh9yqSfEPtLGaBUEQhgh41BUC6EScbs
         sPj+g4RaC93dEh8PF5RUNX3CfXHlEzINBRqcItXqy7a/RCangllOxvphDOdsxP0sdyt1
         369Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758715; x=1794363515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+E1FT7j2TPwT2i0hneBh3LNGnIyRwhqUFoGV1aFaFs=;
        b=P2eOad5J9khysPcJYNgSo8j0wft+rvrFenSdntibOuP7SgQtlpO4+DOrMaouav1OAU
         z6R6jA8CMCioZ8XmwtxbFDtIUEnwqkNHa4af4E390EzT2MzneCOSEnjg7NcK8D794OA3
         lPc1klFIFTHeaSKPPTWJrG9zIPMqOz8xgL4uQxDzKPKCzSkZEFSKjVowO7WCXARredX7
         IV7WqLxSOxc167o56FqGQtdIGCekUoiPeeQ3FNFhx5L0B+8pzYc9Krn7Fr5pURuhrTK2
         JmtWLmscPGivLjhWSQIXx3CjyHnjdUbfwWEX1clg28AiCPriUbz6nB0Q0g11vqtcNcGk
         dObg==
X-Forwarded-Encrypted: i=1; AKwUvBxANXlipHhUeJ+3XvyS/r/BRW8VK6ALiBVmz1wa6sN7akO9ME5ol746sjj1+xACi9KMX0qHA+ghJ8vVlDGt2Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+EQ/SUa2ERcGdJn/WwYc7PTFW7e7wEve3U0La59/5VFnYck1MM
	H1T5Jrp/3VvZkvwNj+ErZYUcPYlzfGUGucvDpUnFlUvUSuWgN5Q+wL7H
X-Gm-Gg: AYBFou191KFF8g69vvjatZWICOCQBe+2iJQK3n9/H7dBVYckd+iyIqTXDX8mxGiGKk8
	YFxwOGMhuCkeDjen9v/udrUC/q8a+CJIdHtMkPwUyzrrDhDgjZgs/A3h4n1aGbOKJcIT0sZQlWC
	2XhCMhs/r5tIurfA1EkUqH+Bdb/LBudlOq88tOlDZd8u08EeOX1iHGZf6kAjE+h11zX6po/sWD3
	C4XHvpx8V5/zA1V2HC079yVHqq+DKjDK6aVxgoZcB7pw/7nuycn13GXSlJLXYwVV6SX2MwHQcxB
	7plbmb4viUEgbKxLCHZbhLxpX6UQpmpKPIGL2PIMEOyIh5ItgUKIvls0ploMf38OgFPUioyu3j1
	GyZBPizSfADd8SpSqS4PbMjZYJVhMnkDd+jIfnB2rhYFX9jG2Py90aNdwA2Y7Em7ScV7cZwfVnx
	k0eOED+QZXQkkFlHDf+pvTQ6rI2veyJclWBuva8Qp/HP2jh9OzRpyb4Q5OGcWJWqnfbtrhoWqsW
	RC0zg9L5enHHBZL0OyY3ubUXmflh4i+cMzAGQM1wMsGQc6G4taxyRdgX7LqYJh1uMz7UI5nSzLn
	rA5ZmpJqzOVd11YcIyws/MLzvkxADueshZz9Yh3aVN63qsG3JdVipzB6IBrdBdrp2C99CBPlaUM
	iQ3eIAS34Wh2ajKtCUIv6bgzXtBT1J5J4FrNlCPKvB+eV/atAXw6w9dFfSaNmmlDX03kq
X-Received: by 2002:a17:90b:4b8c:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3ae897c853cmr12970769a91.10.1793758714583;
        Tue, 03 Nov 2026 18:18:34 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46326f8bsm346131a12.0.2026.11.03.18.18.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 18:18:34 -0800 (PST)
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
Subject: [PATCH v14 12/12] docs: describe virtio-sound capture options
Date: Wed,  4 Nov 2026 11:17:45 +0900
Message-ID: <20261104021745.57733-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104021745.57733-1-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
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

Document the five opt-in virtio_snd capture module parameters. State that
capture_allow_empty, capture_allow_short, capture_packed_status and
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
