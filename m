Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4AE1FE0F8
	for <virtualization@lists.linux.dev>; Mon, 21 Oct 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543738; cv=none; b=Ha4j+veEra7Gu+JydHX+RakSzujntN7dWsMJtfxKpf2VyA6FEyPzNBv8vV6eDpCpvLhhrF9P5StnXf4w8m+9MPAUP/ZLYfMwqe+blwSnWgEYU5I8JZ2Fb+IhQmoVzCxddxSzgDLbgzwO8JTmo6e5Oi18X9vUjH0ttI1pFIcDRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543738; c=relaxed/simple;
	bh=h/OVx8fY1Np52b6ZnjtJ7sQ3UhDWKWmuvHiNf1EmvbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EKHRjM0n7CbknHC8t/CfP1FcOLFHMOi+XF+fbbAcPVFBetR2gyVWoDCCmVbJqlSZmQDp/v6X207Q4vbD6C5WqdgoQpmnI7kUmW+bw1fcj75RJNJoB5u30LXm7LKsG43DrWQ0Kqvbg2oBPxsxwQhLS9jhT1r5PAoOcdltQb6Qlhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3tbZ/j0n; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3tbZ/j0n"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3529d80e5so86125217b3.0
        for <virtualization@lists.linux.dev>; Mon, 21 Oct 2024 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729543736; x=1730148536; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlBeTjB30t5sVtg+4c19Ovx17PsydaPYj9vbcqxgxA8=;
        b=3tbZ/j0nSqyGwvlbIs4sDojZub+Va2xGWHdn4UskZe9Uxsd0Q+ushRV/YqPrdpZWHe
         DWhrSCqqbzr8MLQ6BZStCKFXVx6cGC/xRlb49tFnKQirPEzv9EaN5imxwehH8W0FQoTL
         Dm99d/C69/hYuIsk9B8aFxzX2L2idTGQ97WlrvDeXUoDeOgYcQtEG9yUp8YsqGqrOxqd
         A8QOdepyHfa65tuWYzrRFYLhYxor11a6ZdnTuZxkxgDTdDr11p0mBqsGuJpnDnisopHL
         XeO0+WjJVb9fGqlgXtNnoIx9chSghilFFRbB0YUSA06knGF5LlNh2Pk+4QYgs/idhT7c
         dbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543736; x=1730148536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlBeTjB30t5sVtg+4c19Ovx17PsydaPYj9vbcqxgxA8=;
        b=rgLxUo6s0ZcnN8mHEf/o5M8/zyLK55Vq9MCDc++FMLRCddYxvmFxn1KWqlGmVGjVvl
         I1cZx2YmCzaejO1h1fNQ774QXeVmva9oEJ6TQVJOER2W1zYF1txbKMYt4zrHvB+PYQNV
         1L1ayEv+/qeoYpLT/ji1JxsZadt8/w8wPHKxtvhPkisKqiR4Z8La5iBKjZM6v2/gS6zj
         jdZKL5H+pTuDql6UKhESR7/mcHl5i6Zqk1cghTNgD3qF8Jzh7MrdYC7Hq2uz3lM9j0RB
         GuPIXJUuGLb1Og1MYmjZHBMVkfo2+ebO8gh6QQLKJvhJzWn7l8JS+gvvYV264GExAln0
         JAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3qPl86IP+SDs2uFI4hjE8TX2bdzjn+R2Lzpg+DgcG5MJTAkkrOS9F3eQa9YLTCTJRv/XKoazGLIrYyLBtDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTdhsiZzHXYecFMTl0cwrgq7JSvu2AtwtfsuZIL/re2aga2MyO
	bgbOgLUC/b1N/df8pgVrtl4eAlF2gwGDPXK32nU/hkIhIk0LuvZtwbTc7V75PCSUQKOWt0vipNa
	fBUmSwA==
X-Google-Smtp-Source: AGHT+IFaD6sHUUx1iDTWVXuvYhwh3MjPeso168+Vopjk3XjtpPDKt7LWCqxSWBJfBAZl5rNsNo4cmve1/N3T
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2c5:11:202a:34de:6d58:91d2])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:9b06:b0:6e2:ad08:4924 with SMTP
 id 00721157ae682-6e5bfd21d18mr3568567b3.4.1729543735690; Mon, 21 Oct 2024
 13:48:55 -0700 (PDT)
Date: Mon, 21 Oct 2024 13:48:49 -0700
In-Reply-To: <20241021204849.1580384-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241021204849.1580384-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0
Message-ID: <20241021204849.1580384-2-yuanchu@google.com>
Subject: [PATCH v4 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324..c0afabab8b71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18716,6 +18716,13 @@ L:	linux-wireless@vger.kernel.org
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
2.46.0

