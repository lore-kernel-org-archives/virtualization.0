Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552118;
	b=am3DZmiATjhNyr2fL6OnGXOIDBdvatNoA2fx/isJOKfCupvw/VnHuvErWPN3WXtf9qGM
	 XbhUdjjC79+uK3LwhorFkolzRNHCtTo8uNAQNmOemvs5dEQ29ZZdXCPzhHYXBocSM19Lq
	 +HRPkdXLuB0A61LRd28vEH3+t5rPoYJCknnjQ3jajPAvMtQtu8+FSeM7Q0xbCV55WJnIP
	 vMlK3Qf04a3Omt1itDFE3YM1e/nAqAUuPwM6XLoAEh7GAe4bQseYZv5qikZ02P8/mXEa8
	 qUpbeLinGNhoQO0SbcVzMgTpfhFvjVPZa52p0ksZtepBnOOQfbIYojtRTNNWywZWQuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552118;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QLrx30i7el36agCFsnnbg5QgixV8UKR0zsMUS/E77Ls=;
	b=3PMGgIoLhTZQoYn4Z1QycnX5KO41rekdYYmRhKRZbdciclz6gSD6Ta0URrVsll4/Bq86
	 8HTA9weJNG8y+gniFH9kFG124VbpvhPa/jtUdtE8J367A/XQnJMUKcte5KUd7797q8bXI
	 5WdHX+ZaItE9f4gBac2upJeL2iWUYQN2kRBI2yQq5z5EUyRBrSpjr3eXXtCZkf1HUYA7P
	 GnkmQEWlRzFcdSW2un+gJNg5lal5gp5NXEWe8CEqMVJpV63B8672xy3sJVrsfyjqQ48Qy
	 Lhele7+psMtwrKgEsNAOWGyZs+cdtO3ZWKl/xgzXCaYAPh8TeKskZTla230vkrTf1DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FglIm20p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09160A3808;
	Fri, 13 Nov 2026 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FglIm20p
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552117;
	b=xxG3dOCo8USrSQCh8sFEWG8QzEEPsB9efTmvKrqOPLnPXOWK03KltssojR2qj28YR04I
	 R1K2RVa+3PGZ9mufCwKKJDWFCNMFva25J419XKfJ0LDz+SvmvaKcf+DVcgAZTVzO2ISYI
	 +a95JP2XiE0/4f6jf+u5TTZ0rPQgWHSoJiUe4mZAZGV0xxah2lTCLMi3PIffdMzISbwOW
	 mngpBTIgnQOR6C8bmGO0fb14LArGUR6eUpAOMCLovrDIW2kmLL3485mCPmQG8QxTzl6uU
	 ZIgOWXMLbM+WbcHUfvAS26GIEH4I9/VPF+xaDx9lk/2zOxZ0NBDTm11pgFUj46AlD8g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552117;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QLrx30i7el36agCFsnnbg5QgixV8UKR0zsMUS/E77Ls=;
	b=EFxuoTXJpMDN9PkFsD3YbrF6EvQMngDygOpYQ/MZpxvD7DspDMDgAG6p3aFwv7ir/+yJ
	 tQQPfC9KiTvK/8+8IfKLgDE/CDSZkcHFhTWh/1mCTcDFrxVszBJvGyGvnBdfSqJZCIFWe
	 RU2ijF3MWfL4lVSQsETZqrbfc4L4VcH96b1WzNsv9xP78PlXltbeuj5uL4JktcuMA+BuZ
	 J+PeVhfObjoRzk1GBRHaBXO91vs/iXvBlm8koFOX/6Ax/FaI5aVtQTpOsHEIcsP/4Ev9A
	 h41JmEsM9mSDPKH/4sZ/p6BFCXoxregljHFySvRLVlS9Fa9UWp4itms5I5PCMShuiTg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 751131F000C5;
	Fri, 13 Nov 2026 06:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552117;
	bh=QLrx30i7el36agCFsnnbg5QgixV8UKR0zsMUS/E77Ls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FglIm20pYlFUi+tgJ2fK6oAo245NzDo98Tn2kVA2CjelLF+1sj9XAi9KRilLg7txK
	 MwiA/h7cLIfQ5FOyyJ9D9Qz8N6/jrF7eI3m/RXrkx2HXry0EBOXJI9lVwsxURavkqf
	 Mw0j+WMpV/lqc9asNFm0ETkiiRVGuk1umcbQ8dedWi0jhXXvOQy1KpF6bobSG0GhPH
	 8+Ltksji8A83bcIpyYQkRmIt1Q/qDzDpl8iQQuQ9o0s+Mg++GntXV+r4TYj2MNywJB
	 PLWLUr/i8HzfoLM3JCUKr8q0U1tKxhrB05JDoWhSrsOL2Nl+OLdRsaeqrS1Z/HZQoD
	 GAhffdyT62reQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0424F4766E;
	Fri, 13 Nov 2026 06:41:53 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:41:58 +0900
Subject: [PATCH v32 14/20] docs: describe virtio-sound capture options
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-14-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=3396;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=/j7ES1eIZUqADxQE96uIPwum9kdULJfrWnt027v2s60=;
 b=PLKUtVcbSs8hjxt9HjB19mT5uunRcu2XYjvMwp4SLg5vDY2xaq22TaTMF2wZWScYbFlysRu+0
 vePAzwo66HIB2UZ0dnkBj1+Ph5WTik5BL++Q5gcD5TTywDdlcRwKPxb
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

Document request-owned capture in the ALSA configuration guide. Describe
`capture_packed_status` as default-off, reading a packed trailer after
returned data while the fixed status scatterlist remains the default.
Describe default-off `capture_pause_restart`: pause uses STOP and
RELEASE, then resume uses PREPARE and START; disabled mode uses STOP and
START while retaining the prepared stream.

Note that on MMU systems request buffers are vmalloc-backed and
page-rounded individually. They remain allocated from hw_params through
hw_free, and capture data is copied into the ALSA ring.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
 Documentation/sound/alsa-configuration.rst      | 25 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..ca3fd768b439 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,20 @@ Kernel parameters
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_packed_status= [HW,ALSA]
+			Read an explicitly enabled packed status trailer after
+			the returned capture data. The fixed status scatterlist is
+			used by default.
+			Format: <bool>
+			Default: false.
+
+	virtio_snd.capture_pause_restart= [HW,ALSA]
+			Stop and release the stream when pausing capture. On
+			resume, send PREPARE and START. If disabled, pause uses
+			STOP and START while retaining the prepared stream.
+			Format: <bool>
+			Default: false.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index 689eccf6a592..0531a3e3129c 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2537,6 +2537,31 @@ midi_devs
 
 This module supports multiple cards.
 
+Module virtio-snd
+-----------------
+
+Virtio-sound capture receives data into a separate request buffer for each
+PCM period. The driver validates the responses and appends frame-aligned audio
+to the ALSA ring in request order. Valid short responses are retained. Empty
+responses are accepted only during bounded startup or for requests already in
+flight at STOP or PAUSE.
+
+capture_packed_status
+    Read an explicitly enabled packed status trailer after returned capture
+    data. The fixed status scatterlist is used by default.
+    (default = false)
+
+capture_pause_restart
+    Stop and release capture on pause. Resume with PREPARE and START. When
+    disabled, pause uses STOP and START while retaining the prepared stream.
+    (default = false)
+
+On MMU systems, the request buffers are vmalloc-backed and page-rounded
+individually. Allocator rounding can make total additional memory exceed the
+ALSA ring size, especially with small periods. The request buffers remain
+allocated from hw_params until hw_free.
+Captured audio is copied from each request buffer into the ALSA ring.
+
 Module snd-virtuoso
 -------------------
 

-- 
Git-157)


