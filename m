Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB663BADA3
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168376; cv=none; b=cmgx2TJs7oD6DGUftbmSIVkI7S2eqSsglXsmIcIZFx3mIXiaNtYRIho3AokNGBGCFFuaYW3WskuktqthuHclCoeOg2nHIgb1yWYXjDwdSqY72XVD9FBBzu6UcQymF/kUhx5GnsgL50ULH2j3VewetOtKCxt6R4Oj1XubD4GfmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168376; c=relaxed/simple;
	bh=RaJv571HKEcRvX9MGjkYaW+4oKH2q5iRRdHFPdhTId0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BtKZ5PkIf5xSXkbZ6ErJSKcZe1dYDnxHzFuv+YkxTRjxM6cpG7rfB5eYaZLJgmuvDcOngBwVqBE55GSPCXExitpYbEPkAJcfMgkOFhEM2SxqLH1yKHC0bS0f8UiOxhV6alRbRZKpR71yN10DjOqY339pNl2SCBm5v8HtsjpOOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkV7WzK0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkV7WzK0"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9158643e538so687583785a.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168374; x=1781773174; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4uXW7MRbQJd427EHnO48VbQxxD2p5RQ9HepN918NJz8=;
        b=MkV7WzK0f7B5+mF78gzjPzi/LJ4XsZVFfnl0SpDIWx/DuGKJUWoHWA7jQxdNL1+ATx
         3QiTt/QYhwGhmSazu6TzGgRF++k9VnBPfVlnP7aUqXa/JZcVhlOuDW3WeL5ZIWbZ772v
         FwqcYf842+F8nyfKyAdeUnNuP2vt8H3jgel6rh0SABtluWrWEXRFKaQueJFsW/AzfQ7A
         edBX/PUwYMZWA1K32l5VaGI6rxaPiEXaEtoEKimRK5m7U4pHLjTsxSlT0YP9vC6EVwD4
         RQzFXy8scG2yVvUEYm2MKqF0qzuS57RoYnHfpsRHuHQbbghNGN6DSvOkAlABl3sqIzzD
         GEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168374; x=1781773174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uXW7MRbQJd427EHnO48VbQxxD2p5RQ9HepN918NJz8=;
        b=RD0Cd44VCpk6H36AiiLvmLgJ9VBW6Nc6ol4vtB9tjqkAb8BCjqciV3E/H/Nri+jWCZ
         AJo3VI4M+bMo7M5LGjv2S92YbXQjZzoAjGzY3nk3qrWlwdPFcHkhICegJR1VW4beuqL4
         UN3cQsBUIP1yGXD9wcx3QQR/5KD3jz7S9nfQlyMv2x7BvX+5WdRCEGz3y9wiwjxYW1o4
         YIZlDeRE8sd5VD1NB+Eg00jBxa3lS+yaRcOta4XeC6XnrPzadFEgcnbKoaRXrMXrkEh5
         rdzh0KRnw8Esb0KkjWoiDAa8yeysyPbTJPSqyi/YeXYT6f5K/J/+pJ7la4gvfzM07LOb
         0qTw==
X-Forwarded-Encrypted: i=1; AFNElJ/LOa1jPQPpk94qratEokQ1juSkP5y5aMI5UnPUVtDuspD+EnvK+u7H7MhrmQZyH8Zibk+wyg9fY6grN0l85A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz097q7xtq21OAUzF8G+htNthlG2Y8lBD4U70vNG19oLdU65THx
	jm8BFaJHlqzIuIY5Ov7GqddabSiSfQmMsoagZhZfXG7IgxsUx2Dyiz4E
X-Gm-Gg: Acq92OEFJUYT3zfsJOVJobnsUMpxYq297U0xOax0XyOoGLf47x5RhLBywswSxTmMzXU
	oWH0ld3lO3dE65sQay6gFrXOvA6iPP1t6vQSFDvQ1NQ6FlrzrifpXWHMJnKYqv9rYaLvs5QW1dw
	/keeTl9co5HagaeXqy9heROOz+aZe7JfQzRe+oamkPd9Al9WW2vUL7cdipty0PlCaS+tnWr2RQJ
	5bGpw5+cz7bdUZCqCLib9ViA9At7pDYU2km1dsv3bFGLqErV0AxU0lZEJQfkwSRtFATOFiW4Wug
	e5lzQTXoXoAmj6GAOoQwc9SXM87pEvqF1fmTR1SPj/NO3XXuNqlxnq8mjlvydyF1KRG1fFSh0aa
	nk5VYjR84JanKFUXZTc9K3PvCKF1CEM/Pfy4h+RpykbcJSRsA53Q5DY97WbMz+m5tJ4ybXhILcy
	mFWCzq/4GVJItxGDdeBG0ZCpnAOwo=
X-Received: by 2002:a05:620a:25d0:b0:915:9f28:6741 with SMTP id af79cd13be357-9160ac9657emr268532885a.11.1781168374274;
        Thu, 11 Jun 2026 01:59:34 -0700 (PDT)
Received: from localhost ([149.40.50.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160ae26238sm127924285a.33.2026.06.11.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:59:33 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:18:51 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Cindy Lu <lulu@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: Re: [PATCH v3] vduse: Add suspend
Message-ID: <202606111115.tKKe1qCE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610083452.477759-1-eperezma@redhat.com>

Hi Eugenio,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugenio-P-rez/vduse-Add-suspend/20260610-164534
base:   next-20260609
patch link:    https://lore.kernel.org/r/20260610083452.477759-1-eperezma%40redhat.com
patch subject: [PATCH v3] vduse: Add suspend
config: arm64-randconfig-r072-20260610 (https://download.01.org/0day-ci/archive/20260611/202606111115.tKKe1qCE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9185-gbcc58b9c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202606111115.tKKe1qCE-lkp@intel.com/

smatch warnings:
drivers/vdpa/vdpa_user/vduse_dev.c:577 vduse_vq_kick() warn: inconsistent returns '&vq->kick_lock'.
drivers/vdpa/vdpa_user/vduse_dev.c:1302 vduse_dev_queue_irq_work() warn: inconsistent returns '&dev->rwsem'.

vim +577 drivers/vdpa/vdpa_user/vduse_dev.c

c8a6153b6c59d9 Xie Yongji        2021-08-31  562  static void vduse_vq_kick(struct vduse_virtqueue *vq)
c8a6153b6c59d9 Xie Yongji        2021-08-31  563  {
c8a6153b6c59d9 Xie Yongji        2021-08-31  564  	spin_lock(&vq->kick_lock);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
c8a6153b6c59d9 Xie Yongji        2021-08-31  565  	if (!vq->ready)
c8a6153b6c59d9 Xie Yongji        2021-08-31  566  		goto unlock;
c8a6153b6c59d9 Xie Yongji        2021-08-31  567  
9c4307e82fa1dc Eugenio Pérez     2026-06-10  568  	guard(rwsem_read)(&vq->dev->rwsem);
9c4307e82fa1dc Eugenio Pérez     2026-06-10  569  	if (vq->dev->suspended)
9c4307e82fa1dc Eugenio Pérez     2026-06-10  570  		return;

unlock before returning?

9c4307e82fa1dc Eugenio Pérez     2026-06-10  571  
c8a6153b6c59d9 Xie Yongji        2021-08-31  572  	if (vq->kickfd)
3652117f854819 Christian Brauner 2023-11-22  573  		eventfd_signal(vq->kickfd);
c8a6153b6c59d9 Xie Yongji        2021-08-31  574  	else
c8a6153b6c59d9 Xie Yongji        2021-08-31  575  		vq->kicked = true;
c8a6153b6c59d9 Xie Yongji        2021-08-31  576  unlock:
c8a6153b6c59d9 Xie Yongji        2021-08-31 @577  	spin_unlock(&vq->kick_lock);
c8a6153b6c59d9 Xie Yongji        2021-08-31  578  }

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

