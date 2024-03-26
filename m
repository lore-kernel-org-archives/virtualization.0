Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23084D2A
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476305; cv=none; b=oU8cQDmVv7h9Ukfiv5Z1qrT4ma/v10WdKzGVF1vGqdLoZlWhHFy4KIJp6lCVRSkpync8ofanrN77XS69bqmUpxUo7KT/b4MO2BZrEJbNgvdzZXcgmwDz09kRqy7asTXfYMJ0gbe608Ex2fbk2uT2Yn1ei1vs+9ts9Q7aIMEbq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476305; c=relaxed/simple;
	bh=1HtAEn3GUDU1rNP6LZWmBuVwhufr+rjFcdlx8t9YYvw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RpKaelVFOXlJPvwBULwSBzr4/l90GV33dHRsMqzdFd33ew8jC4T4aUho5L64ch73YAstUFjs05vKDxIB+8T0F7KOkkQmwwByd2jPBBImX9MHh3XZR7ipL4//jSsapVU//k3HxXUPlpSjEvhJGr8O/+CgZL5mesuNJa51Jr+cjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StuMDGZs; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StuMDGZs"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so2852973a12.0
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711476303; x=1712081103; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=InAZ9/C9EDyJhkW+bEV5eavwbh4jrGbQhGajHqMOaXs=;
        b=StuMDGZsrTtK6gLuI3TEzQknGOzKxEZfms1jWcIyQXq+Hj+8EQA4xPqAlKQx88FHqf
         G+Kscnxw37EkJHjHs4tly7ITGJZJo8GrDSpFLSPnOl0OOhvfPiRcZWd4XXQcVe3a5OCf
         J9VBc7CclMHM2vIerR8bj0r/FJFBbs06vw65o4r+Saqo+Zw/SDwTgelArDd+1Q/y2Ktt
         4ahMKTyTE7SU6B7V1jFwg3FwAfhmtCTRvd805ghl0BkXQn4siYj7p0e2jbvv/8GCoqMY
         0Tk8rlGwrbi4LuWdchkjgl27zd9JHWLEf8oZTSoNaKcfn+z++ldrGFXL8CmaWXtYVszH
         bH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476303; x=1712081103;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InAZ9/C9EDyJhkW+bEV5eavwbh4jrGbQhGajHqMOaXs=;
        b=xDdMeXeVxRrb6H8zdckoRrQmi7hTt+qbFc2BGLeZBr5CyW5eRJE/WiYHX0w+xTdTM+
         58UMSfiA9sYXGD+qxGQV0tCQ0sqBzyXEvUZwrHU6bDMW8ZwWneQ2KrIWTm+lSZXXtqiQ
         L4FG9TVjcgSrtIE6zOZttOXnAT6XAQJfqBR0jd9GUnINIAo7m2gBDPR/qiT2pKBdG86C
         DebbF9rQXWbYO2ei6E8aInq6nzMDINkeSlRfcE507dcZF6oCCgkEzQmC0eznLLIAxgBU
         YQSqvJfZ04qSDboP7Oj9vhaN84UqWl9B8AZHSF3FkfPaRAGpWRYn+Z6W0WMuzn2LygrU
         0wPg==
X-Forwarded-Encrypted: i=1; AJvYcCUSpz1SJAyvVc2IQMC54QEqgh/CKYf+a9zOPO9ePFZw6lyU95eDz06dY6KCPMuoXTgZhMcu+i4BAvIN4QQg/n7eSmIRf5r76epusJegv54=
X-Gm-Message-State: AOJu0YxdixPuaPgxiBkY5fYeRWVYwiQeMVU1K0zHgcSTt0xiVZtf1zvj
	/K9CZRdmMowmPkudGWqim2dOPdM9+mAGf2fI2W9heACt/CJIm/qVHD4b4DR5F/sTrGVhknUTENV
	V0CvJmtn4ge0REe12gkwYk+1FUXw=
X-Google-Smtp-Source: AGHT+IEBhA+WnnRTf8AR2UyUOmIouX8FcColXZqyCdRGDNFO76HxCoWYBYVkcsPJZ6LizCzy9BOlPUU/AKNzLxSVaQ8=
X-Received: by 2002:a17:90b:380c:b0:29f:e443:204f with SMTP id
 mq12-20020a17090b380c00b0029fe443204fmr8861033pjb.18.1711476303337; Tue, 26
 Mar 2024 11:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Mar 2024 19:04:34 +0100
Message-ID: <CANiq72mbsAYmR_dRPpQQ=9-NWhTtp0TWiOz0v=V-0AvwYbWw4A@mail.gmail.com>
Subject: drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set but
 not used
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

In today's next, I got:

    drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set
but not used [-Werror,-Wunused-but-set-variable]

`count` seems to be there since commit f64122c1f6ad ("drm: add new QXL
driver. (v1.4)").

Untested diff below -- if you want a formal patch, please let me know.

Cheers,
Miguel

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 281edab518cd..d6ea01f3797b 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -421,7 +421,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 {
        uint32_t handle;
        int idr_ret;
-       int count = 0;
 again:
        idr_preload(GFP_ATOMIC);
        spin_lock(&qdev->surf_id_idr_lock);
@@ -433,7 +432,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
        handle = idr_ret;

        if (handle >= qdev->rom->n_surfaces) {
-               count++;
                spin_lock(&qdev->surf_id_idr_lock);
                idr_remove(&qdev->surf_id_idr, handle);
                spin_unlock(&qdev->surf_id_idr_lock);
