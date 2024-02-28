Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5D15A4A6
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142250; cv=none; b=TAWIPgdmXXxQoFph0nqNMpPkzge8VbbLfjIkJYteS2zzlbD+4JcLaXc4livo9DEAjlOwi7VTkpLj/0h2kNRsFdWGJxUefVIDu2887W/GrKAdOVhmBhY4LpRrPYWL0EYcZmBRf5C3IDWy7MFYCkCTJ3GuEboYBzG2tJJx5Q056ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142250; c=relaxed/simple;
	bh=W6V/WUDrcU6ltqu9bzNaahvrM7LME69p9CtE6KRKCd0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=it1u5ausZ3foyPunfgul/eF+wi5kBn2C3nHXyYepHDlmGddSSJjw9k4hyDEfmztZJshPFemfBHSZi19R+CDEVqd1aSaX8bq3+QGvIUFbHVLHKEmGFo3/Rilfv9Y/LI7WLk+4ebNlzbYMhgpi6D8JwWvqeW2uWgK4XzR1gCh1rk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RkzJMAHu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkzJMAHu"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412b41a1294so6941005e9.3
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 09:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709142247; x=1709747047; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQYfGRlMuAzV9NGrkcAH7hkAKHgrR0yYSvegD/d+xL8=;
        b=RkzJMAHu9vMgJQZua0yaYZzo8OLocZzb445nQV4hZGi4B+sV1vPllRmTP6EUZTtHSo
         2COrP+1ojQ6KMziTJukQEUjeszH1pAHan9BWxpPiAsRLQtIYGyExxT7i6g/TKxjmSEJY
         yZjelQ0DHZYHVfN9HgKNWpWcxhcEIKO2BKCZGD7sofqnQwXdkqW7wsSlLTgJ1qwAFljW
         NfORUOZancb8VW0qSoJLnv4UfOepRjwo1Qz7kA/O6lm/h35l8+03NdC6ymu5A751MmsU
         dJucGZ6EP3RW13JVeXB/lz259bGe/I/6Do6Opbxcvzy9Ku5NgINT+MQsZi90E/58c3vM
         HePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142247; x=1709747047;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQYfGRlMuAzV9NGrkcAH7hkAKHgrR0yYSvegD/d+xL8=;
        b=fnJgTsqScHy/7sAw6mSAIkj3Lh73jTUzAdA2aNoWdb2aYg82mRjVOgMGdDnbSvm062
         42+FXsJG8A2x5qO6EQT3YgucKA5lwnO1MDEzFynYKvQjkaEMz63RFwo0d/uFvw/t/nAk
         zw6eFhmJHHg1UVuZ0H7ju1Dcan11Ksh9VT1/7icu2TF/veP8Y0/91jh0kyYSehDCU/tH
         1pL7zhOApdpv4jIoV5jEAd7wkJQGlc3CcfOEdmJ5sqf146BkFzjeyirVGd6v5Bi/s193
         jbsxLq0fFy9cSHVWbI5X577/uQ+pzLG0zzJxClUeOENwClKyp5kgqdtA9RJ1KCrchTKb
         8bsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVQchtXuGElzxKklcNi3Cu8rO/ZdqqU+GBfPef5bXs7cb5wfqWsVQ/vzB2jqY3M/CP662q5lYi6oXBO7g+VVzlSj1DTJnyOCqK31VfFOs=
X-Gm-Message-State: AOJu0YzyVvwWuZiVSq8OmUkip9QwYoTGs6ps5CRXk3Hw1lXMAa+fQC2z
	G7A5k8GxI3eSgiqco06eR9m7fnqql0xH7uj+w9CbL5fhJ2MmnvURkFPRWKqoEP8=
X-Google-Smtp-Source: AGHT+IHOwDyfmepDmBoQvFrRKQ7FFwyrzLDzVXnTAg0OSmmsmnEyu00VFewWnjH4ylk3CMxRj1xMVg==
X-Received: by 2002:a05:600c:468f:b0:412:64a5:a21 with SMTP id p15-20020a05600c468f00b0041264a50a21mr127317wmo.40.1709142247357;
        Wed, 28 Feb 2024 09:44:07 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d564a000000b0033e0523b829sm1008975wrw.13.2024.02.28.09.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:44:07 -0800 (PST)
Date: Wed, 28 Feb 2024 20:44:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <e2361611-e8e3-4c6a-9f71-30e81a65f793@moroto.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
reading one element beyond the end of the array.

Add an array_index_nospec() as well to prevent speculation issues.

Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: add array_index_nospec().

 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b7a1fb88c506..eb914084c650 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
 	if ((vma->vm_flags & VM_SHARED) == 0)
 		return -EINVAL;
 
-	if (index > dev->vq_num)
+	if (index >= dev->vq_num)
 		return -EINVAL;

 	vq = dev->vqs[index];
 	vaddr = vq->vdpa_reconnect_vaddr;
 	if (vaddr == 0)
-- 
2.43.0

