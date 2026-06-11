Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF99358D3D
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170266; cv=none; b=G72OItpfHpcn8f97RiTbrCrVaG7xUrgJGoHVPLoJOena/JzjPSDVJx12UYOKKtidefv5wwMcn10Jw9dszTUOvWSD5flVtwZC70lND72QCgdYB1KRR0pAkBIO8N4xVnvXuZOdI2GqD4ykmfyetYw15M2IJb3BNZpqEuQ5S4bN4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170266; c=relaxed/simple;
	bh=w89Gt/JtXX8ZT4RIyRt8rc6bOLcjvGb33ot1aJe6Ls8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8/a0mmMramzY5LmjTflML7ZcthGoHVfest/Z+8UtoN50Jfm3axVv1ZTK4HQnItby2/Og8e8LlD/UL+OWAKlzLcJuBt0EdVw4IHWYXdc3jNSiM+hOQ/jGCM+phEBrKwHjpLd/P8SH38e1T/pMJIMLtlS51tyu1qOna8yHDLma1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOyqrwKM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOyqrwKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781170264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2hNPvYgf0iD8PvTepkvC82FmAqCAzcD0YMkTYIhG0I=;
	b=eOyqrwKMNZJW1BDvdleYTuWuwT04GeitcAihhomeeXe8O1Ik8mt08gBGQtb1j3b7vhQMjo
	ykesa1WMcorFQl8lTAV5v+ako4sDFHiIk1mYOa2hofi/MFEapV3tts8on0D3KKaaC+dHmr
	27Qix4pS+v9IwrC70Bm/Ji/BHi2QTtw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-DbBREPpIMwymMmGRIcy0WA-1; Thu, 11 Jun 2026 05:31:01 -0400
X-MC-Unique: DbBREPpIMwymMmGRIcy0WA-1
X-Mimecast-MFC-AGG-ID: DbBREPpIMwymMmGRIcy0WA_1781170261
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7e86a896175so133247507b3.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170261; x=1781775061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2hNPvYgf0iD8PvTepkvC82FmAqCAzcD0YMkTYIhG0I=;
        b=P+WNxPhdkX8xarkv4yR0Q2GwMPaeGWK7MBsdC5SYK46bwNTBGabbJM3msKSLnLhJix
         xWIzEmckaCuOSvz/ibBhxTPmveqeoXuEbKVrbYA+ImxfR2bRwWJLVYTqT4YXo3kYPbWk
         QQp0xLxGB87Z39ERP287VhxgYZDRv71Fb7LLvRofJKgLt5V5P9pLzh1mRL5cMS2LPhPX
         ijJqvzEdwS7HJeZ7U/h2POjiz8zLFDAM6afurFm+yXAxYT2BlRmCg4y3itpL9nw1KCLx
         ZJ93yNrSEkmM+lbotGhd8nC5a87Kf9I80PKU/USBVKlhQNoiN22YtraJHkgZCo4x5Jlq
         9/dA==
X-Forwarded-Encrypted: i=1; AFNElJ/9l3oy00HPsomS5EHoPyHsN1vPbRK6ZOa0TU3+Ydbd4YH5hNPdCGTENwnUusuqMzRn3Mn8RBSMnNwpV1oQAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxrl3Nk53xUWF8BHBHQmUxwa29TJoFHMbA88jchQL5+I2UrkOG0
	/w9gcFsQtCXUCpew4lTcD4OJuqxzpecbuN9QET1W726ZSl6XVeKRRB1+nMSrkLcJ4YApxsAuGAn
	VS5UgbUuJVfu6grRCYlCbhwD63Dh3iDhO5cvtH5dMQkGz1rDXl/dJ4sGdbgRdD+CCgIWKGrSrUE
	CyV29dhEMBqnwMMSUx1Pfd8q71GJ6XwDJkSiRtCe9QjqI=
X-Gm-Gg: Acq92OE1COY+cvd/gPW7O25cjdM3t9hRADZASXUM0UuWz9+OT31xcgT+kBUK4+1BTfM
	iVP/xV0CqFevSCpYfyCetLq7ycOBdLPr9DO0B07ExhuBLwdOjZiHW1dOtbo/YbZ+PTpwan6Vp5l
	ehTkzbT+GBRY4VS00IfDwE5GGSjE/g8jGPluNB3tfHWeRTHYj1YmKpXnVyqE++IoSE5PWMdHT0c
	w8bWZ68zfHATY3p
X-Received: by 2002:a05:690e:d58:b0:660:a41d:d166 with SMTP id 956f58d0204a3-662699f02e8mr1204730d50.58.1781170260574;
        Thu, 11 Jun 2026 02:31:00 -0700 (PDT)
X-Received: by 2002:a05:690e:d58:b0:660:a41d:d166 with SMTP id
 956f58d0204a3-662699f02e8mr1204700d50.58.1781170260036; Thu, 11 Jun 2026
 02:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610083452.477759-1-eperezma@redhat.com> <202606111115.tKKe1qCE-lkp@intel.com>
 <20260611050140-mutt-send-email-mst@kernel.org> <aip9tNOx6WHIq22p@stanley.mountain>
In-Reply-To: <aip9tNOx6WHIq22p@stanley.mountain>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 11 Jun 2026 11:30:23 +0200
X-Gm-Features: AVVi8CcR7__V5dwFrJc4_VvqCsOvRovXP1-XMWBLvqXqHGl62B4egwzD06z7cuQ
Message-ID: <CAJaqyWdQ7_1zYcfNVF_vQrrLHf_TRAbqS0X1kMQm7QMZ4UY+kA@mail.gmail.com>
Subject: Re: [PATCH v3] vduse: Add suspend
To: Dan Carpenter <error27@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, oe-kbuild@lists.linux.dev, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, virtualization@lists.linux.dev, 
	Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KE9EhjQvc29cLdSc9gIKB2I11m4th5IjCJxTKl_5qDw_1781170261
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 11:20=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:
>
> On Thu, Jun 11, 2026 at 05:03:24AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 11, 2026 at 10:18:51AM +0300, Dan Carpenter wrote:
> > > Hi Eugenio,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Eugenio-P-rez/=
vduse-Add-suspend/20260610-164534
> > > base:   next-20260609
> > > patch link:    https://lore.kernel.org/r/20260610083452.477759-1-eper=
ezma%40redhat.com
> > > patch subject: [PATCH v3] vduse: Add suspend
> > > config: arm64-randconfig-r072-20260610 (https://download.01.org/0day-=
ci/archive/20260611/202606111115.tKKe1qCE-lkp@intel.com/config)
> > > compiler: aarch64-linux-gcc (GCC) 8.5.0
> > > smatch: v0.5.0-9185-gbcc58b9c
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > | Closes: https://lore.kernel.org/r/202606111115.tKKe1qCE-lkp@intel.c=
om/
> > >
> > > smatch warnings:
> > > drivers/vdpa/vdpa_user/vduse_dev.c:577 vduse_vq_kick() warn: inconsis=
tent returns '&vq->kick_lock'.
> > > drivers/vdpa/vdpa_user/vduse_dev.c:1302 vduse_dev_queue_irq_work() wa=
rn: inconsistent returns '&dev->rwsem'.
> > >
> > > vim +577 drivers/vdpa/vdpa_user/vduse_dev.c
> > >
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  562  static void vduse_v=
q_kick(struct vduse_virtqueue *vq)
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  563  {
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  564    spin_lock(&vq->ki=
ck_lock);
> > >                                                         ^^^^^^^^^^^^^=
^^^^^^^^^^^^^
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  565    if (!vq->ready)
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  566            goto unlo=
ck;
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  567
> > > 9c4307e82fa1dc Eugenio P=C3=A9rez     2026-06-10  568    guard(rwsem_=
read)(&vq->dev->rwsem);
> > > 9c4307e82fa1dc Eugenio P=C3=A9rez     2026-06-10  569    if (vq->dev-=
>suspended)
> > > 9c4307e82fa1dc Eugenio P=C3=A9rez     2026-06-10  570            retu=
rn;
> > >
> > > unlock before returning?
> > >
> > > 9c4307e82fa1dc Eugenio P=C3=A9rez     2026-06-10  571
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  572    if (vq->kickfd)
> > > 3652117f854819 Christian Brauner 2023-11-22  573            eventfd_s=
ignal(vq->kickfd);
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  574    else
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  575            vq->kicke=
d =3D true;
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  576  unlock:
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31 @577    spin_unlock(&vq->=
kick_lock);
> > > c8a6153b6c59d9 Xie Yongji        2021-08-31  578  }
> >
> >
> > I think this is fixed by:
> >
> > commit e4a249d15eb2d4b28213bebb1eefaf2e6d99de0b (HEAD -> vhost, linux-n=
ext-vhost/linux-next, kernel.org/vhost, kernel.org/test)
> > Author: Nathan Chancellor <nathan@kernel.org>
> > Date:   Wed Jun 10 12:16:49 2026 -0700
> >
> >     vduse: Fix error around jumping over a __cleanup() variable
> >
> > right?
>
> These things haven't hit linux-next yet.  I found the email.
> https://lore.kernel.org/all/20260610-vduse_vq_kick-fix-guard-usage-v1-1-0=
ce02c08006e@kernel.org/
>
> That only fixes the bug in vduse_vq_kick(), not the bug in
> vduse_dev_queue_irq_work().  I don't see a fix for that
> yet on lore but I may have missed it.
>

No, I can test & send a fast patch for that.

Thanks!

