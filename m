Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54146C144
	for <virtualization@lists.linux.dev>; Tue,  1 Oct 2024 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745219; cv=none; b=ml5GAM+Pen8SRJVVeFz0Evtee5iYb85ntZRkVlrxfIoG6niLvcFd+2wl8l5vI4OGnF03yXIZYnpBVp3kQW1Y6Y06FS6CbjPXEvrGQejuta2la/heB+ik8ElEu/J5K+k2RUiSzWhKZC/Sg30hJxjOf5tgNS4tGswZIa9Jn8S2Zy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745219; c=relaxed/simple;
	bh=foTvS2kZQWqUIQ5whLAVtR2Zn8mUtJtiuvWR2WBRGhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A0X5aqPDdIigyDMZpCAuf9zyxPdoMrSHM6IRSpjasnYS/zKmIUs9BUnbeuhb+28LWcHxZGc51loLRC8biOevVM3I1+m7HHmwp7wKEO+7HJekbOX0JaCIaAeCY0eunI4Lt86jlzLGOjnoOo2Wv94I4IoBGcaLo4oxVt+EV6lE7N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/5NwsOk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/5NwsOk"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e25a6fddb0so34220997b3.0
        for <virtualization@lists.linux.dev>; Mon, 30 Sep 2024 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727745217; x=1728350017; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qchQsg/qNbRX/pVJ9McbPj0llmdwBRtNmtuFlN5g4dw=;
        b=A/5NwsOkeUr701KnYLGygccomHI4ISpXNOGLQACZff1tK1pt2Xqx/egjU7Y7YOkTwC
         ZM4FCNpu/Q8QJSVdD35A3oMlsdr+9EB7Fjp9vhHTCaZONW1RFIkW8egyPeYDPUn91lEu
         O9dD2sn6R5ptj6nTpy5UDszLV61M0Yh4e5hr4GMdyQE/Wml4+ZO9NNv3urR7JFsNpq8k
         dE91ruEHb0+ELPQBw9VRtaEjtkx0qX8zKJCZPT9N77seCO5AKkLjbMa6IlWUg1otjYrI
         qFBgBs2smoWEsTNpnzw9CQl7o14brgADB7n2NTkVpdpjD9OMJOEHcKUG78pb27e7Sk1s
         n1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727745217; x=1728350017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qchQsg/qNbRX/pVJ9McbPj0llmdwBRtNmtuFlN5g4dw=;
        b=i567soiSkZYcR1CjgwuMddpIPhMhbr7rPcpad+geJHzfhf3toOd9vvvXv8j2ck0Aj2
         TECsZSbRCQqvZ96TJy30al2IPgQbNdOPSDC3FqgYcVC34x1EcvyAVYXOynoMFUWSBsS2
         aYHZY6OGKx53J5jr6eoPDJ5BVRIEs0W1L2uhW7ikPykE/fzgvlPGrFJzi73u69v0kS2F
         Whm5s7z6NHHnxZ33f5WE1Ls0ewcBe70Ezf+QKzV1dcMuhTCkV3jYrDeAKIoIH57rnh25
         lGVrISuaDqF4XUD7L3Ojwg6VLhghOrpAUAWY+PZl/qK4OMdCaZ17OAepYvGM0rttyknO
         TI9w==
X-Forwarded-Encrypted: i=1; AJvYcCVzc/wqcrlMYN+APlHsIU0I0gA/BaVVbrR3keWDGSRTtnNvhduT805uylrxPYgh8gIjpuiu0go8InQHA+TALQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvwGxa5qGIga6lPoCzCyHkuZVhVP8IjFL+23zHe2QAZPRyNqpw
	+GKxJET65aoi9Ycrk9GBObwjQ3w7hcmTGW1y0zHFg16h+x1clUPgRVPKVu2BFEQir/RrsRLBAu2
	+vGWrHw==
X-Google-Smtp-Source: AGHT+IGCiqik6XxbJ03Gc/eBgy5fKINyy2lsI7yUCqtsEdsmAZb+g1iMvsLXq/1U77op54NfuJ/jv4id2rPY
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4ba])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:6187:b0:68e:8de6:618b with SMTP
 id 00721157ae682-6e2474bcbb1mr4697667b3.2.1727745217364; Mon, 30 Sep 2024
 18:13:37 -0700 (PDT)
Date: Tue,  1 Oct 2024 01:13:27 +0000
In-Reply-To: <20241001011328.2806686-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241001011328.2806686-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001011328.2806686-2-yuanchu@google.com>
Subject: [PATCH v2 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Change-Id: I3ba78d0fefe594cd5ed6805775e6497572bb7187
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..5e661f39e07d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18125,6 +18125,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/purelifi/plfxlc/
 
+PVMEMCONTROL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/pvmemcontrol/
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.46.1.824.gd892dcdcdd-goog

