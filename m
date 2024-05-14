Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE9469D
	for <virtualization@lists.linux.dev>; Tue, 14 May 2024 02:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715652194; cv=none; b=Gc+sHcTZJC0LzS16GeVlSQHS/ilWO7TSHpw7RoUWDnoDdR0JA62TLKbvbxhhA/2PlgcijqtrraHcvZXtUfZ79UvAyTCEdJGoF8ToUiiVuIusazzkBzUUVF43vfsS1Wk06LMl5flrs7TcYRzAS6g06/keV4Qw2ui1e8RdgvHgHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715652194; c=relaxed/simple;
	bh=6KOrme8o9PGJN5Tbk8Ru6CkgrB3HbHtOupbevpkmW6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JFg1mK5+thVsrsD6ik9QEQRzbEMMlJavdEMrwpHAyZbdkGU7r7dAsR2PlFh4CleJ2B9kAeHUgsICV+5eTB/PuQJNo6UDxu5Qen5FhQNqWRkzzGYAAFANPMh9tviZPMoxaFOtu8J/5XFcl7Tvs4Iv0uY4zrEx8lVh4cObBhVjgvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Wbq4X+r; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Wbq4X+r"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso7639027276.1
        for <virtualization@lists.linux.dev>; Mon, 13 May 2024 19:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715652191; x=1716256991; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6LZX8B3NAwKdOpyzwg2nERNshi+/Z+TgchSBTbrUTg=;
        b=0Wbq4X+r72bWrQhHlo4jNJEQUx438oTFaatYLSeFlDfnr5v0oV4ET+wRL/m4n3nuDg
         JFHhDTq7SpVgkZa+16Y+gDGtZW1HMvHBdzzJMSIzykelhfTb4GwWFLCXoxnW0tpztzcW
         JJ2NteKl2MvAcrZKR3BLEmb4PFWFbT1831PoLD5d12xdTAEh3rKQU9bJpSuCtv/hB6J0
         x+8TFDjzdQSs8mRbWnTd1oT9fXJdg12Y18zz9vrKAS88ryhB+x/spx1Mrg1caL9X2Wy4
         MyLqNF5Es5ZWTXTIQQG+1CT271PKges9pwt9O+GEskowPUZ8xvegLW2A/hWjkI8J//sJ
         vgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715652191; x=1716256991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6LZX8B3NAwKdOpyzwg2nERNshi+/Z+TgchSBTbrUTg=;
        b=qoHJE7Dc4nU7imkC1Giho+p/eovIzcW+giJt2krBYR/6bbFXfPcs2mAyRHDe5bsH28
         oR6GPn9Pyto6ciJjD+7WnbUSIoA8L2XMtwJE/uJPtr29PAxUGWzwLmGozdVv937IX/7q
         pJn10TklMoIkzOgmj9VbtVWPMxkEO4Iv9Ttu0NQDbwZCsTk66gXdSTZvDwo+VxSoDy/Y
         voMcgYgAykS1TM8FxJx5wx8hiwXBwQlYBXHROr4wlBb56kdWNjOV2JxYUHgPEwonjI4A
         5Pfipxq2adh+n8n27zIzlbdwLGGZ2MXW9tq11x62+N8kwn4dr3vhOsLD/KjVBYG7ejYC
         nuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjPgnFnNJsXUenBblqIqGLVfGgYfIuM00O162HpY2GMAs8kZHgGVxmiujg4dVp2puUVbc9l8mCyP+dpQZqryv9Upbr0qRsehai4smMvOw=
X-Gm-Message-State: AOJu0Yxp+2c3dQ3o6BdhY8mAXrIQLWHc0KkRwtAIw1EZ2iEm8bQQxkHI
	qCqUEdWwyt7lxr7rdsuSmcpbLLo8ez+6EsCSpRL/LnOmmoIXkgLKPOvTVIPT0KxlA25N6nmxzYp
	C4MeK9g==
X-Google-Smtp-Source: AGHT+IFnKyUwV1sRfhj14Ul5g8vZ0XrMokIFRTN8GZG8T8GmdeJC1X9cXXIfOTYT+lTmG0FuwmA11eBeJunc
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:c98c:5a45:8674:49c2])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:c09:b0:de5:5304:3206 with SMTP id
 3f1490d57ef6-dee4f52d715mr1019538276.11.1715652191073; Mon, 13 May 2024
 19:03:11 -0700 (PDT)
Date: Mon, 13 May 2024 19:03:01 -0700
In-Reply-To: <20240514020301.1835794-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240514020301.1835794-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514020301.1835794-2-yuanchu@google.com>
Subject: [RFC PATCH v1 2/2] virt: memctl: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dan Williams <dan.j.williams@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The memctl driver lives under drivers/virt/memctl. We specify
maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61117c3afa80..5793df2b2f5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14057,6 +14057,13 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMCTL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/memctl/
+
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

