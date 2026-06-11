Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0FF3D0919
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174296; cv=none; b=pTZZ6zm5zyMW7H7AEtRgJ5uqXAKc+gz6BVtdU+6TvRvlzkQRMXqb1SL4yRSCLA9esZDnOBivCSwD7hguJWA3vS88/8o/u8XGDUrhnQAt2jBLGQJexhgCxgwQsi/Gv3whWCwPanpAilK5JORQPBFdsvAnh3iktYdoeF52Zu4sJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174296; c=relaxed/simple;
	bh=XoTYR/TeqMK2ycCgG5+xbyxi/eud39OEFhZfHmqkKeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ktqz2XuTlgBQs8yzcdKWlGcj8LCxigs8PHeKgW+jziVyeIQltpYM2Ah66TO0M1ko5iAkIC9myAcAQXs+f2ejCEe6Eg/m8HuGut8wPS0xpUY2JdmguVsOUNwLf3PyqPZZj8c5OzkI9l0BYFG3wJtS5HVobAnW3CUvve4ZgJgGX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIuNIX3N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIuNIX3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781174294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/vtY/v3M5U6llxqJZ4Yn6/DNDaMuf4s018w2I93KIY=;
	b=GIuNIX3N+NNIneXNOYpuOFCVscLKSnHCy7an4xjWFqvVGlMXB7II5Proy27LLhNgKIIRHb
	n+w627ab3lpvumI/Rce2PQR1PYnbht9gNCHAmx0GOHwRwLRvGaWn80DRXAFBq+MMYk70Iv
	6MCTWPw1tN+1Ks3oLriEFhTf91t073s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-EYpUfi8QMESIevmRRN14ng-1; Thu, 11 Jun 2026 06:38:12 -0400
X-MC-Unique: EYpUfi8QMESIevmRRN14ng-1
X-Mimecast-MFC-AGG-ID: EYpUfi8QMESIevmRRN14ng_1781174291
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eecec7667so5446153f8f.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 03:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781174291; x=1781779091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/vtY/v3M5U6llxqJZ4Yn6/DNDaMuf4s018w2I93KIY=;
        b=rLU5tF8sHuGeRfclp56XoJZ66/nk4HV4ie8Y4oAo6Umn3yvrayhkphiIWAnrIbdOe2
         r2P6AlVil5VPkzB8myhfB2A2ZnPwfcotzZMZ1i4/0ArmN88nT5UMXsmvry2+XwgyWrna
         Oje9HWm+I+w5aJPt7fowFPHbcI31p1iMoWhb8tXwru2idEzEWB3cnNPeWH+7eT+Zv9Ra
         nbADEHRYxGMpx/IlUjwWYGul/pL/MzaEdrk/iw44loZisLBZA797TP+nTXj0mQg9GbBm
         qxjpQw3fRaGFzwtnHkCprsgpYMsjyYCiPStxmEgZHZpWSe8Qg2J9v35d8VqlTNy4svwE
         3nVw==
X-Forwarded-Encrypted: i=1; AFNElJ+iERdtD4k2UVVaypF71ZCjLYUa+ZwYSadpXPJltVvZ7xxsF1JjWTtt9MoqjXuuhwt83PhaAWJq9c9kNdKV5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo8hPDoPfPZLau+xfL/g61oiG/jiRQjmb6yjJtMY20X28+BKTI
	zsSdZw/ugOV/F+gVyqKBp+5P6uxq79KWldj+oz7sH2NUntoi8CCAzFlMqXVfQJVrQYPTS1vMSP1
	tFCsiOY4hJZv85TgH/XZtJwFIFKev2NEgBZZLrJExiIqCyFSbDij3rLe/3rEg6ApV3cyJ
X-Gm-Gg: Acq92OH6WNaic0HMsMDBeJ6FiskusboQ3DKhoWTbR0UxCkvStRcrzh+kzHjXe2VzWOt
	wp6PQEULPXYEv49VwjlgA9TPsFcDFm3cbvKtxwOew94PEG2/qNun1G6lLUBL46i9d9r91ItgYNw
	DX2Inrs1XjjURwIaUjd5ObvakXxPe2tqS83FFXbwpG2D9lQDHbwhrTZbEm2YocQ6GsehoIoOJY+
	Gj2wHIinF5m3Alrop8L/G1mCdxI4WJMxqYnNPSxr8yGqwcDr+5Rn840aaJW8a6nKnryBdjp52fO
	vFl8CFuoE4xZMlG0YmXgR10VgGqf+eObGBTWeMzch7sH+PF2jisM8bs5NBeEK+4S3Wz4Pv7cfFz
	NsjBNNHKLH7emcYPqq5k6NDr+dGqBGTWGX1vUS7w5SWI5q68Nx/3CmQ==
X-Received: by 2002:a05:6000:41e3:b0:460:3234:293f with SMTP id ffacd0b85a97d-460677e92a0mr3648445f8f.42.1781174290519;
        Thu, 11 Jun 2026 03:38:10 -0700 (PDT)
X-Received: by 2002:a05:6000:41e3:b0:460:3234:293f with SMTP id ffacd0b85a97d-460677e92a0mr3648382f8f.42.1781174289911;
        Thu, 11 Jun 2026 03:38:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm76938127f8f.16.2026.06.11.03.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:38:09 -0700 (PDT)
Date: Thu, 11 Jun 2026 06:38:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Cindy Lu <lulu@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: Re: [PATCH v3] vduse: Add suspend
Message-ID: <20260611063730-mutt-send-email-mst@kernel.org>
References: <20260610083452.477759-1-eperezma@redhat.com>
 <202606111115.tKKe1qCE-lkp@intel.com>
 <20260611050140-mutt-send-email-mst@kernel.org>
 <aip9tNOx6WHIq22p@stanley.mountain>
 <CAJaqyWdQ7_1zYcfNVF_vQrrLHf_TRAbqS0X1kMQm7QMZ4UY+kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdQ7_1zYcfNVF_vQrrLHf_TRAbqS0X1kMQm7QMZ4UY+kA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hSUYvz0QXeJ2rB7h1DFziesQ7LCEIcTcSK2PH0Mq590_1781174291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 11:30:23AM +0200, Eugenio Perez Martin wrote:
> On Thu, Jun 11, 2026 at 11:20 AM Dan Carpenter <error27@gmail.com> wrote:
> >
> > On Thu, Jun 11, 2026 at 05:03:24AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jun 11, 2026 at 10:18:51AM +0300, Dan Carpenter wrote:
> > > > Hi Eugenio,
> > > >
> > > > kernel test robot noticed the following build warnings:
> > > >
> > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > >
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Eugenio-P-rez/vduse-Add-suspend/20260610-164534
> > > > base:   next-20260609
> > > > patch link:    https://lore.kernel.org/r/20260610083452.477759-1-eperezma%40redhat.com
> > > > patch subject: [PATCH v3] vduse: Add suspend
> > > > config: arm64-randconfig-r072-20260610 (https://download.01.org/0day-ci/archive/20260611/202606111115.tKKe1qCE-lkp@intel.com/config)
> > > > compiler: aarch64-linux-gcc (GCC) 8.5.0
> > > > smatch: v0.5.0-9185-gbcc58b9c
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > > | Closes: https://lore.kernel.org/r/202606111115.tKKe1qCE-lkp@intel.com/
> > > >
> > > > smatch warnings:
> > > > drivers/vdpa/vdpa_user/vduse_dev.c:577 vduse_vq_kick() warn: inconsistent returns '&vq->kick_lock'.
> > > > drivers/vdpa/vdpa_user/vduse_dev.c:1302 vduse_dev_queue_irq_work() warn: inconsistent returns '&dev->rwsem'.
> > > >
> > > > vim +577 drivers/vdpa/vdpa_user/vduse_dev.c
> > > >
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  562  static void vduse_vq_kick(struct vduse_virtqueue *vq)
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  563  {
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  564    spin_lock(&vq->kick_lock);
> > > >                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  565    if (!vq->ready)
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  566            goto unlock;
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  567
> > > > 9c4307e82fa1dc Eugenio Pérez     2026-06-10  568    guard(rwsem_read)(&vq->dev->rwsem);
> > > > 9c4307e82fa1dc Eugenio Pérez     2026-06-10  569    if (vq->dev->suspended)
> > > > 9c4307e82fa1dc Eugenio Pérez     2026-06-10  570            return;
> > > >
> > > > unlock before returning?
> > > >
> > > > 9c4307e82fa1dc Eugenio Pérez     2026-06-10  571
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  572    if (vq->kickfd)
> > > > 3652117f854819 Christian Brauner 2023-11-22  573            eventfd_signal(vq->kickfd);
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  574    else
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  575            vq->kicked = true;
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  576  unlock:
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31 @577    spin_unlock(&vq->kick_lock);
> > > > c8a6153b6c59d9 Xie Yongji        2021-08-31  578  }
> > >
> > >
> > > I think this is fixed by:
> > >
> > > commit e4a249d15eb2d4b28213bebb1eefaf2e6d99de0b (HEAD -> vhost, linux-next-vhost/linux-next, kernel.org/vhost, kernel.org/test)
> > > Author: Nathan Chancellor <nathan@kernel.org>
> > > Date:   Wed Jun 10 12:16:49 2026 -0700
> > >
> > >     vduse: Fix error around jumping over a __cleanup() variable
> > >
> > > right?
> >
> > These things haven't hit linux-next yet.  I found the email.
> > https://lore.kernel.org/all/20260610-vduse_vq_kick-fix-guard-usage-v1-1-0ce02c08006e@kernel.org/
> >
> > That only fixes the bug in vduse_vq_kick(), not the bug in
> > vduse_dev_queue_irq_work().  I don't see a fix for that
> > yet on lore but I may have missed it.
> >
> 
> No, I can test & send a fast patch for that.
> 
> Thanks!

Alright.

-- 
MST

