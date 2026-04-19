Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544B2DF68
	for <virtualization@lists.linux.dev>; Sun, 19 Apr 2026 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776559794; cv=none; b=NSMd/GFsWTTzxa7O56gQUUORwfbNj3CUXa8Ln+qdhWmjoXMI6FBZYps2Qq0hUVqA584NCDLLeWdhVaoD3kWbsUiQWR5WmspLlI4zbgahiQkz8oZlj4IHcwNBu3GHEauBnO1kZ1tRmEf0WToG/6pJ5g447u3XoCBLbePqMfp7GNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776559794; c=relaxed/simple;
	bh=wHENpZvxkf/YOAHfOHWTCdGCZOIhVV7fuX6csf/dFw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o/sXz7Z8Nqti+WW+cp4KrSLOkxF9fQedaU4Gqis0BfPqNUFpqDI25WXtp6PdvOkGGBEQfWgIZ2xyI1HhgHd2CKxMNemJw19dRdj5uV98zNU3owRRjxVMzOs0laBqn4QYl56PIZOqblPdJ/xC8jvHj2D6z3fJU5VHqcBnEPQPmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=kVX4DnHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rWAo/OBJ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="kVX4DnHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rWAo/OBJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C4C17A0095;
	Sat, 18 Apr 2026 20:49:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 18 Apr 2026 20:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	ethancedwards.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1776559791; x=1776646191; bh=4j5ind4Y8rMWCPH5voCCoEAQ0uDhrj2m
	zHs3k1PsP+c=; b=kVX4DnHHLUhU8idIjLG2Gf+1NANpFmk4//AAf6APWOVlaoUA
	RfLRpCEplF4plliuHrCDMvnP6/eZ+DTR7nlC5sdb6Gu3Gj7zpXtGbrmL2XSiO2b2
	ooSUIsmXWyzymtMaenZGLU6ox3MBLdNJ7fDPx71MDovlpqlo7Gb1bFjWz0uRj5EN
	As6prVlAnMC7T/gtGS94mG+95QXjW8CXMzl4H2EeTbWlmbNGQS4QdPK/PVtIWK9X
	8LU9U46dC6Bbaq1/5LKxHUftZxKvEQ1lNbxVatoQtKkUAr2j0i7Ofo/03hbJ70DG
	clPhheEJPyQfP0KlIfd9Nc7xCkTBKYyDWTeu8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776559791; x=1776646191; bh=4j5ind4Y8rMWCPH5voCCoEAQ0uDh
	rj2mzHs3k1PsP+c=; b=rWAo/OBJmuj7ecPLDS8q86Q4WDAe0XueVjIReVs8znfR
	erAi/TSEMHfrSlHFFId774HIXLacvAD5Rl+nlpWfH1MyTAVr0OC7zUczzJRh8hEv
	oKtWjNQbzrNxR4eneam1FyvojGROxsElA3RJkITpsTIbbyyMisC/r0RxyJIeXtcq
	kq5SG9Y1UEEyOTDjN3qzIKxswsJOd56eacrPf8rnJxwgDDuN3zSiZ2a9KKXqtB+7
	sOcOpcNfPlChDo/M21iyAeM4qo7+0nj323VqDvv+2sWEqUoaKNDz3yaCtr1uNzsf
	jwmNeEfEe60VzCDo6ZaLeph08UF/O+qGYkL/g5xJ8w==
X-ME-Sender: <xms:ribkaSgzsWP39NBgL7oF7EHtojzi_xYyb1RyWHekjOSI45WvaBUtlA>
    <xme:ribkafmeFPeD-BhT6FfMFEmX0Dm489Duy24dEnvWSK5H1GMOrg5vwuLQC_g9ZzLbW
    z7FElX68hfWQutpUSUnURCbm5rtNZ7OKfMxBbwsaGgymqlUmiHt0uc>
X-ME-Received: <xmr:ribkaeiezalhJzdFGYzsuJgcR7rdrX__6My3kFmPVjBDVioPztHWsRT7NT3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepgfhthhgrnhcuvegr
    rhhtvghrucfgugifrghrughsuceovghthhgrnhesvghthhgrnhgtvggufigrrhgushdrtg
    homheqnecuggftrfgrthhtvghrnhepieeuhfeuhffguefhffekfffgtefgjeeghfdukeel
    vdduiedutdffffeghedtiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepvghthhgrnhesvghthhgrnhgtvggufigrrhgushdrtghomhdpnhgs
    pghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhtuh
    grlhhiiigrthhiohhnsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgi
    hurghniihhuhhosehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepvghp
    vghrvgiimhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrmhhitheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    khgvrhhnvghlqdhjrghnihhtohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvghthhgr
    nhesvghthhgrnhgtvggufigrrhgushdrtghomh
X-ME-Proxy: <xmx:ribkaSEapucUVwDr5cIS74ISRU0vNDCujht7AIolyHEPg2qKwRRm0Q>
    <xmx:ribkaQuevO1GPuEJlAR2-b_SBZw4y7NgTwSio3kbhxFmG4Pxrian7Q>
    <xmx:ribkaTekc8SHDCz44rkhYX64QrVKGFmpIiXKQdOrTEjUuMNdl5Tzyg>
    <xmx:ribkaWm-OjPdKjOjK4Hk2bocasY9b6sS0ipQrJHbQP1OSz4gTwXLAQ>
    <xmx:rybkaYSEEh7TbxYJ5udTHMaU9KuL-DKvYHc13bAa5xV29vyUjdGvkItn>
Feedback-ID: ibf9e487c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Apr 2026 20:49:50 -0400 (EDT)
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 18 Apr 2026 20:49:48 -0400
Subject: [PATCH] virtio_console: Fix spelling mistake "colums" -> "columns"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-virtio-typo-v1-1-0df6f943a79d@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAKsm5GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ML3bLMopLMfN2SyoJ8XUPL5KSkxBRTCyODFCWgjoKi1LTMCrBp0bG
 1tQBPuL1GXQAAAA==
X-Change-ID: 20260418-virtio-typo-19cbbad5820d
To: Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=852;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=wHENpZvxkf/YOAHfOHWTCdGCZOIhVV7fuX6csf/dFw4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpENVJXeHYxTWpqdlYrWEN5TE5od1pvdnR4bDhrakV5ClU3N29KWlZ1ZXJ2bUl6UGJo
 K2NkcFN3TVlsd01zbUtLTFA5emxOTWVhczVRMlBuWHBRbG1EaXNUeUJBR0xrNEIKbU1oYk9ZYS9
 ZczZyaFhzNzl4ZzdYNVJzdGdrT2I1NnZzU1p2OWNiOGx5NkZnVDVMamh1dFkvakR2YWM2eGJWdw
 o2YjUwaDZDVjJ4a3RUanpPTzdFby9jN3A5dGE2THZWZUsxbHVBRTMzVEY0PQo9aUZnUwotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

There is a spelling mistake in a struct description. Fix it.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 include/uapi/linux/virtio_console.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_console.h b/include/uapi/linux/virtio_console.h
index 7e6ec2ff0560..0506539e6553 100644
--- a/include/uapi/linux/virtio_console.h
+++ b/include/uapi/linux/virtio_console.h
@@ -44,7 +44,7 @@
 #define VIRTIO_CONSOLE_BAD_ID		(~(__u32)0)
 
 struct virtio_console_config {
-	/* colums of the screens */
+	/* columns of the screens */
 	__virtio16 cols;
 	/* rows of the screens */
 	__virtio16 rows;

---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20260418-virtio-typo-19cbbad5820d

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

