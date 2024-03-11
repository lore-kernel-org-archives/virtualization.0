Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C724DA12
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173865; cv=none; b=NJUohQsIhtKbvLqpg3xr0L0bJhoVb8zNth+kegYbEexGd2cIZ6yh8JSfay4snblVWbGm6gGmWnoWvO+WNcxQozfI/qxBBEpvMMuQ0lD0jP+vSwxtKUsmbuxUHRZYdYp2PwJ+Ciy1J+RyGqKr7Erb4r0PK8y1EL0+8uiPQQAu7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173865; c=relaxed/simple;
	bh=jc/74af7NZP+cpnNw9Qk/swCgD9N+vE+d+7fUoVN8BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+YRXXm9pYkXJaN2b2h/ZRPrBIoCqCtikHGYgZse4tqjBTEkyuWZscltY/IWFJIg2HTh6TalyAWEBzWL08/sCvRgDnFK2fCR5P/gVG3AQixjJtBWO4Y6eBvt4spPjgR0foQyi+WSNRiHyuEHhW8eQAdnXEr97CW7vVfDXZE0AY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1KL+dl4; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1KL+dl4"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A117405C0
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EMvsp_MLWaY1
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Mar 2024 16:17:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5E4BB405B3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E4BB405B3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K1KL+dl4
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5E4BB405B3
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:38 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4132e548343so4130115e9.1
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173857; x=1710778657; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lx7gS4QP7mPyluL8Zu2ZDhyswvsRIpNUouI6tZofm4=;
        b=K1KL+dl4CGFKraMdwST2mFW62zTOiyJotC/zrvLEATZOtI0SYZ9KoMqIELKdQf12hf
         lPFF9mhB6Wi5pyGex5BG+ojYd97Tkzxtw3MGrIhQt+igdfQQRyya9NL56pnB4qpt+z2B
         Ylu906jQwX5AjVzBsHrzvkNLuIOO2+izk7osysrz/mhhvBvRkGHYPNT9oXIO8H8uCt9M
         LXMc8037jIWV/fyPZ8TKs3i/uxUA/YfUlNogIfCc8hMtgqbiKJ4qgVmacJ35lDEGjdwV
         P0x1haCf0Y2u784HicG5ZCCekrGa8RXlAdirwhUnIkXPJ6YxvFSufh9IMnszNwF3ot3y
         SCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173857; x=1710778657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lx7gS4QP7mPyluL8Zu2ZDhyswvsRIpNUouI6tZofm4=;
        b=LG2hqVa+uTtSZLk1cz2vFYVbFVIuNnkJIH46UdVUGlyxLl+JejDVCSc6fHrzdbshkX
         t+D7XS0TjBzOqChReZTWxjDeA87BIHgxdnPf+mzHeIflwxEs23Zt6xQ+qWbkPmQWrNwB
         a6zn573r8sZr+bXUqhU/bc7FuNP8X4F7v5a8ZO+1AhcXDL/Sg2LmJrREz8SFOPBvYBA+
         ickXm9c7MYkji/AAccwED7mvv0rUOgH0ucnlp1TuD62lJN90hdgBekY1h7aPUgKfHWCX
         yGvl+EGEH6MooDjDresBKLx72BFRWK03KzlHlTY80mhZp3Ieat1uDL/KnbllpJVAotss
         3zTg==
X-Forwarded-Encrypted: i=1; AJvYcCX20xEIrOJiQ8UTangx/hVe8Pb9meV7L/JA5/jwnf9RvOlpUYRPD/6UN9+4565vR7dxtWEJ6+XC82EDQcHOYVE2j0l03Ve82KaplQTUQj7PHevPgXVhVkfNyA==
X-Gm-Message-State: AOJu0Yw9/Sr5pd1gdYbfh9OBVLv32Y/RuBwn6m0hMji9bGGarC/TQFqq
	AqCsAJQoZ/H2r+QzGpdO9FH4m4yW9QxwZurAxxxkQVbQOypPA5sH
X-Google-Smtp-Source: AGHT+IGnYShk1v+ZpEc4xRU9N5TjXvx2xTfMB9p+pJwWcXHMA9n5F9S6x1ihlL1DyRVWu7ib73UDKg==
X-Received: by 2002:a05:600c:358c:b0:413:18e7:2388 with SMTP id p12-20020a05600c358c00b0041318e72388mr4922789wmq.27.1710173856688;
        Mon, 11 Mar 2024 09:17:36 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:36 -0700 (PDT)
From: Vasant Karasulli <vsntk18@gmail.com>
To: x86@kernel.org
Cc: joro@8bytes.org,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	Joerg Roedel <jroedel@suse.de>,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v4 3/9] x86/sev: Set GHCB data structure version
Date: Mon, 11 Mar 2024 17:17:21 +0100
Message-Id: <20240311161727.14916-4-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311161727.14916-1-vsntk18@gmail.com>
References: <20240311161727.14916-1-vsntk18@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

It turned out that the GHCB->protocol field does not declare the
version of the guest-hypervisor communication protocol, but rather the
version of the GHCB data structure. Reflect that in the define used to
set the protocol field.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/sev.h   | 3 +++
 arch/x86/kernel/sev-shared.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..c48db0bfb707 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -20,6 +20,9 @@
 #define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL

+/* Version of the GHCB data structure */
+#define GHCB_VERSION		1
+
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }

 enum es_result {
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index c02a087c7945..6adae48c501f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -257,7 +257,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = ghcb_version;
+	ghcb->protocol_version = GHCB_VERSION;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;

 	ghcb_set_sw_exit_code(ghcb, exit_code);
--
2.34.1

