Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216B3BB48
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873982; cv=none; b=cA8A7Xfg+KbPb07vznURvcF5cNt1Zzk3oy3Kfw3mL/rGPYDKh5saPapMxxFBRqXDs/B439IzOrHYbfTsi71SYHeT2Tj8qv02Vst/sxbNlDmFT2SqD5GzpcjJk9oJpyoMvwB0AUGzHDI3nJcUbEYvizES51p2kxi+CZMOd/WYT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873982; c=relaxed/simple;
	bh=IybTRYZ1NMDJIv9ewvWjHYQYUyXJNSuLboaSvnvUaT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=soJo2cdRFUqG9joTN3OK2k318KAfsD2v81OF2BAr66KmNrksVoEWXuJn2lyr9AJp7vKWWvJiGVMSmFKCEx/Y6lUajvyH48/YRJwsk3V0Zkl9JLwNMGuycxFkQ89WWq4NC5onCJUAKyihqvnl0gw2iOJGbrjgAFGUSz/6TuPYahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqHhuvRK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqHhuvRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iLgnHgPtFcP5kfOLoezc/wCaaY+AwZW9zR9taUSpDhg=;
	b=IqHhuvRKZElkrEyU7GvTMc4VUKnr+HKRv8sc3nldtKNof/gFVV2UbByRch7Yr0XQifR6ul
	WXPpBHo/Aix2ydhgMHjg+LNLjHp0Tc5QwCo1zGRmGV5o2DFGGis7LXn3z/taIOVRg4xaKq
	HONII6Sx1WgtOwynOYqvieOhLgosmVY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-dZjjiK1hNrGLLvFKzy8NHg-1; Thu, 04 Dec 2025 13:46:17 -0500
X-MC-Unique: dZjjiK1hNrGLLvFKzy8NHg-1
X-Mimecast-MFC-AGG-ID: dZjjiK1hNrGLLvFKzy8NHg_1764873976
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42e2e50cfaeso1389106f8f.3
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873976; x=1765478776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLgnHgPtFcP5kfOLoezc/wCaaY+AwZW9zR9taUSpDhg=;
        b=S6+t0c3DX+ZC5kmJTyUi+gbq6LJbte5VSNinIGCHiE9+I1zOBaJVtZmb33xIfDoQ5L
         1B9zhRSn0k992RkZlZ0bAp2NCXXXkSvC9Ir0P4rYWKkKvWggLPtd/K35nzzspAw+TXYn
         rg/DkQzVgobYYQ3290d1OtiUKXxS/a8OOXPXReytz8edPUGtm/uvxiF9GyKAgglYwHoB
         /Z3AISdjlDKAQaCH/iTklu7HOs5qln/ADqY0SzXa9niYePBJ1XPePQ7pKmB5SwvPoOJ/
         D2HIhFKj4nnFCPmjU77bQm2iLgS6Zw8Ooe1H+U+uiivjsr5G7M59DsPop1iPQEOGH01g
         HE1A==
X-Forwarded-Encrypted: i=1; AJvYcCXtJp896dEPSF8ZwhhWBg7U4+6ulSTbil/eM6x/cyONwcPtI2Ldb6JdUMFemKrgmINh8541zhdscAYLe5TpZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh1r6iwpoDrRJsY5NPp5kPm0motqxP3mebpsXAbbR9rUOaz4g0
	SuVdssxcKbOy3dXLTAp1opjspQIysTZTazzxZ1yFvq8sKsUH2YiBqtEAa/IMMXVqgZKUI7NUlLa
	cZx+4Uc0LOBvsLftuEXfWzFZ5ljAfHVgz4CGtHHqa72MBrGZFlchHs3480rOmUmXdwhyf
X-Gm-Gg: ASbGncu7fvstl7Nkfk0dfdLTKs7c6Oa7qkiIOLoc5bDqNu82qnUwd49CFh3OTirrDoT
	Xf12AmjZ3zLzzKADKeRZHqT0lg9MRjtvO384BTUUClfmsilxqeASrA7HczSP9BlgLN57qWRVzGx
	KTq6U/CpsXk/xd57gjRhOLBntEyRp5ekE1aFB7e1BG5eMy26IgRIQbJ4pkcTnbta/7QFh47+U6E
	Ou+eOLFknMhoXGTLQPvvS7Hqq4FgSiCZ7szxYlZ8itODN+E7c1OdTVsV6t35AmXvae1rRUqYkkb
	fiqD2IGc5wBnpt+SlWp29M+HftjXpUOaiVHFEVS6b/IOW/iaQoo0ZAlRRcwn2mpKydBwesIYxJM
	=
X-Received: by 2002:a05:6000:24c6:b0:42b:32c3:3949 with SMTP id ffacd0b85a97d-42f79841449mr4525160f8f.31.1764873975847;
        Thu, 04 Dec 2025 10:46:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnLQOgiYw1VIFame5tOV56Q9mQmuEGWMGrXGwdgq0ENokkj4nc4jidVzVuvfT9S2GETs7Syw==
X-Received: by 2002:a05:6000:24c6:b0:42b:32c3:3949 with SMTP id ffacd0b85a97d-42f79841449mr4525132f8f.31.1764873975440;
        Thu, 04 Dec 2025 10:46:15 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeae9sm4707250f8f.13.2025.12.04.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:14 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 06/14] tools/virtio: add dev_WARN_ONCE and is_vmalloc_addr
 stubs
Message-ID: <749e7a03b7cd56baf50a27efc3b05e50cf8f36b6.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 63D2L9yfKPkWg-UdcB_kJQXlISVVyalrBALV-rpO4rY_1764873976
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add dev_WARN_ONCE and is_vmalloc_addr stubs needed by virtio_ring.c.
is_vmalloc_addr stub always returns false - that's fine since it's
merely a sanity check.

Created using Cursor CLI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/kernel.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 6702008f7f5c..d7fc70b68a2b 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -14,6 +14,7 @@
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/overflow.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/bug.h>
@@ -135,6 +136,14 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
+#define dev_WARN_ONCE(dev, condition, format...) \
+	WARN_ONCE(condition, format)
+
+static inline bool is_vmalloc_addr(const void *x)
+{
+	return false;
+}
+
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
 	typeof(y) _min2 = (y);			\
-- 
MST

