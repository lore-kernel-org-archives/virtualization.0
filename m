Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C622288C08
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791342; cv=none; b=jqsMXzaPL9tilRLYLhJ9qWudJhQEUsoUPHb0lerLFKAr3Cm0VSY2Nc0jR22S0Lel3uR38tKo7VlmYZpV95ZoyJDSCmBFpkHiSlqTdYBT/DjC99qfqOGJmwkMcFKRHNjkRWjK+SoubsU+mLGN/iD+4OUB7QunpZQZMPtbyNZmLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791342; c=relaxed/simple;
	bh=m44O0dwBKI30dD/BNVYtje8eoZK0yrU4cbkCCOY9GCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kipy3Qj/3/4Qj0rDcwRzJZHw2w+/GeaKp+r+GRiPvHCbY29EBhaGjrm3n4cf7R4d7oVxy313DPPROcFCMkEBtLJaWykjnKKHYrngqkg7SY5Ph17tgNHPjLimF+u8dfJvw3bfOrymXRXAQ7n8I8oZ+Mcji2uQ+7muWHm/05CK+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1HedPvX; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1HedPvX"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5c5033f6so22508351cf.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791339; x=1777396139; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFUP7oxtLw+TaklzOUYMTAsDjSFshdzQqWmKfd2xajk=;
        b=Q1HedPvXtchSCjXXMyZasT535juvWw6TdrYAoNsHyT7AFEwayNj0Lpanh6V/o+l31r
         dyNTg5smw7otEZoEJWyUhbbJGEXSgLARRDFnKvrHk2SALaZEReYTq/lr5sqsbGk6H7Oh
         CfxeEDe+pGtu1xxOQ4ZSMzZh839vIcy6zVnnZ4SL27u4COivUOXt/pVAFACdfIARTzsa
         ehYP8+DBFbOKs4Ws79dJpoYzWm3r8a84MkDOtNGyZJdHF+4ywM0a+o12mtN5gDW7Ql2g
         FF9rv7HeWN/+u0RyzLCvI4ZJTohkzAeitlDa+d5L0Bcb7CthtlP7AuLbuVBYuA96OK54
         9+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791339; x=1777396139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFUP7oxtLw+TaklzOUYMTAsDjSFshdzQqWmKfd2xajk=;
        b=dB+zATr0sFe2EU0MtsKrASYxCrTpLnmi9h4iwxF7tIx1dzwssZFjFuNgXGpIdHkweR
         BS/9/UH1vyn4jqggVlEniPCQi6MVdPHtXyLLX99XAq4ta9l/0km+N5pAuE49T2QmAD7g
         918AOfgE30RBvci9c1eYQuFVgaTPvNwUYvH0C06M7v0dXtp91MTAnGsQdapdmxFBUbmO
         VYODYN7kxR+UMYButbook05nCeequD26bQT0V3x23pVXesslaBrqoK8+GPbkG99ko+yd
         QQrRkHATcuonaU/L1HbmgrP6tqjq+w8xa28OoyRzlyX1KLLWNhxQxG3eld8Hwp96sFSi
         CjwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8trTCuBPfdq/BqJ5DoAzXeZ/4OwyAijdtxbzYNooL4fM95pjEZf7kYyY9xzz9fv15mqiBXMyN3cgVJ+m/wXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywboy1ATBVGuO1NJD+xyvBcX822oqpji2FwunK2D/gO+B9soEqO
	rRAObw2pft3FzaU7x+pXp/MoTgB4fdxgBzrK68VsshJdyRBMap+vzVLk
X-Gm-Gg: AeBDievOf627ztkFXUnR4Alqq6zeIFvLCufCzBy4eWkTBHP+qtnTJ1Tu5vIRiXvDlM3
	Xh3EQUXDC+5bZeCERGA8/C+AZS6dCVkJA+B2crNp1zkJwFmjd/IPLGOd395qqEYZ15c2VZP6R5v
	767OrrS66/DmWZSWZH7AkZKve3RV9S2gppV/OYZYX2lfqjPR0DMI4oREPN/e4jq/5kSn2qanpGy
	P0y9M4KzF8x8ZN2Lv1uIPv70+fSwFGE+MZN7EfJ/eWHCNQ0k2dv/xq5wYzeUHlKlgYsW4gVylvR
	1l9sNgf0zBoayBj6DrixGn9Sy4zFm+Pl0dNqY73CCz3N8nuvFZ02KRCyPrQj78py8KfkIENp5yg
	LAjkUeQaVKrxcgPozfXl1PLh6HSMz/j95AIgtxS3R75Lcj3wMHY+eFuhNTxl7sKc48DNF6bszHi
	HtnsGBbzF5D2xDrPForgYwTaBwzbY8O4lVLqqtdPlBOxCB0VbUbvK9aCTvKp/s//LGN2raUudqi
	SlVA2NTvfVgPgGsr/Gg3qQ5PIieZVk=
X-Received: by 2002:ac8:5ace:0:b0:50f:ad91:8902 with SMTP id d75a77b69052e-50fad918c7amr93780241cf.37.1776791338948;
        Tue, 21 Apr 2026 10:08:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb92db861sm13134471cf.5.2026.04.21.10.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:08:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Soenke Huster <soenke.huster@eknoes.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 0/2] Bluetooth: virtio_bt: harden rx against untrusted backend
Date: Tue, 21 Apr 2026 13:08:43 -0400
Message-ID: <20260421170845.3469513-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZKqx4ureNbRGEghGjGWcmMQSoiY4oUCECme_Vgn8RvYYw@mail.gmail.com>
References: <CABBYNZKqx4ureNbRGEghGjGWcmMQSoiY4oUCECme_Vgn8RvYYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Respin of the virtio_bt rx hardening patch, split per Luiz's
request on the v2 thread:

  https://lore.kernel.org/linux-bluetooth/20260421151659.3326690-1-michael.bommarito@gmail.com/

v2 bundled two independent hazards in one commit and the commit
message got convoluted trying to explain them together. This v3
keeps each hazard in its own patch so the rationale for each is
self-contained.

Patch 1/2 keeps the original v1/v2 concern: virtbt_rx_work() calls
skb_put() with a used.len the device controls, with no validation
against the 1000-byte buffer we actually exposed to virtio via
sg_init_one(). Checking against skb_tailroom() is not enough
because alloc_skb() can leave more tailroom than 1000 bytes due to
slab padding. len == 0 is also accepted, which lets an empty skb
reach virtbt_rx_handle() where the pkt_type byte is then read from
uninitialized memory. 1/2 defines VIRTBT_RX_BUF_SIZE, reuses it in
alloc_skb() and sg_init_one(), and gates virtbt_rx_work() on
[1, VIRTBT_RX_BUF_SIZE] with bt_dev_err_ratelimited() on the drop
path.

Patch 2/2 closes a residual short-payload hazard found during v2
pre-send review. After 1/2 restricts used.len to [1, 1000], a
one-byte completion still reaches hci_recv_frame() with skb->len
pulled to 0. If that byte was HCI_ACLDATA_PKT, the ACL-vs-ISO
classification fast-path in hci_dev_classify_pkt_type()
dereferences hci_acl_hdr(skb)->handle whenever the HCI device has
an active CIS_LINK, BIS_LINK, or PA_LINK connection, reading two
bytes of uninitialized RX-buffer data. The same hazard shape
exists for every packet type because none of the switch cases in
virtbt_rx_handle() checked skb->len against the per-type minimum
HCI header. 2/2 requires skb->len to cover the fixed header size
for the selected type (event 2, ACL 4, SCO 3, ISO 4) before
calling hci_recv_frame(); drop ratelimited otherwise. Unknown
pkt_type values still take the original kfree_skb() default path.

Both patches carry the same Fixes: 160fbcf3bfb9 and Cc: stable@
as the v2 commit, because both hazards have existed since the
driver switched to skb_put() for used.len handling.

Fresh runtime repro of the original skb_over_panic on an unpatched
tree and a clean reject log with 1/2 applied are attached in the
evidence bundle referenced from the v2 thread; no runtime change
between v2 and v3 beyond the split (the final tree after 1/2+2/2
is byte-identical to the v2 commit).

Prior public versions of this patch on linux-bluetooth:

  v1: <20260418000138.1848813-1-michael.bommarito@gmail.com>
  v2: <20260421151659.3326690-1-michael.bommarito@gmail.com>

Michael Bommarito (2):
  Bluetooth: virtio_bt: clamp rx length before skb_put
  Bluetooth: virtio_bt: validate rx pkt_type header length

 drivers/bluetooth/virtio_bt.c | 39 ++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

-- 
2.53.0

