Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E23BD241
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170239; cv=none; b=ZShyiQvkoUIwne3XUZUKV4Rprir7De2SLLafKE9NZyY19/WIBVBo9FJrKfFNmkhH4WAr1JqeBHXhdv3I4NyIMzeQmAxFaK6Fp4amyVpzKwWPNxVkCM/oujCDuDTZQYgHuyvotwlmgQUnlNIasqkz3egxSMLE05JUYZ91K4SJCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170239; c=relaxed/simple;
	bh=C1S3L/LEpKSx7OkdBw3weRasepoj5Ehsa+LpRcAEm8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhA9xAUkhKjrMiuRW6MN0Ye5n6O1lLfr0u+rfK++i4F74agbHB5lwGZyOjVPm13uAJrZpeS6u3zZMiSMofte4II0rPmPpyqQsigv9ye8Zx7sYARIUK68ZgOIZExmMw+mWMhtnB8JF3lzHNPkXML2oVtSwOQQQaN3GzeuspZ3/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN1jDZtx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN1jDZtx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781170237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aMr7MQeoSiuBHAcF+jVEe51nOK2JsiXVmtxZEm7uzc=;
	b=CN1jDZtxbTTunJt9puPPsaKigx2rzEIDf3fqYCbGn6+0/wCw7h0Noe9ideR1NIJB+WKQSy
	oImYJ/W5wAC5gWKuFkDzw9cbtbh5gn7I25TgNZi6o02UKyR2aScm8RsCvyUQUI77xp20tD
	x063YywAbMml7mtPZMxqGvLlwlcjZ7Y=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-MWCvi3yyM66sXOfxkUI5Eg-1; Thu, 11 Jun 2026 05:30:35 -0400
X-MC-Unique: MWCvi3yyM66sXOfxkUI5Eg-1
X-Mimecast-MFC-AGG-ID: MWCvi3yyM66sXOfxkUI5Eg_1781170235
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6604350c37aso8465439d50.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170235; x=1781775035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8aMr7MQeoSiuBHAcF+jVEe51nOK2JsiXVmtxZEm7uzc=;
        b=IUaHgzGsoZzpJ3S1fo0uF8D3xRWv5MdTYSjJ3Wy+GOaRN1/pRpQWmISxjDzdbJ7QoU
         +QBPjB/i2PiWDW4+Av9CKSbUAjb+2+Pmb+rTIqqrW2Mu/qmPVCcBBmWIJKj3SFCTSPSY
         Gj6Wbuwl9PLUM8MWonV56pC8ivnlbNLueLeCoCYPDKoZRijFO7ckyeUhIBX3jSUp5GcW
         8ohmpp7Zob/z9njQV1rgWr9um3V5n0yHs05UOKTOHy7wbEkQktYfCPh8w97eeOIk5iSt
         Cy+fIoXgnb7jBK/nVz1D3r3tI5u4bctsBAAF+I/D5U+l2NVyQ0OJmbgrb1NQy95M/kV7
         rhJg==
X-Forwarded-Encrypted: i=1; AFNElJ8vXSoINZZ8+dAKdkSwBg0nT2nKwHbeK+S+/CvLGuKljKW11L5UADhs0I8L2qKnpktzSf9h9gDPcizNp4sqVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yybe2IsYqE1UOkEifFLBFajKPLjwko/VAY6aadzJ6uMoVlDjuW9
	OMemA7N5Cb48CbrQvsfttcyi5QXnGA52FGCr6eomj5poVNYQuUtXXhnDL4SOdsIS60/PSTMXfUl
	dhWMqvmzdtlTWQwprY09IpP47sLcUir8ydglEsURYb0AyQvPuvFaj+8DeLwT9mJzzEwZJl2vnPW
	8di4tPz/iUwJRIom55Zi3LRwPENYtCQOMUdBEBFvzGX1E=
X-Gm-Gg: Acq92OEQ4EvWSNiFhJ1mV+kH3o+0ntKcx/znsIYSnjIvEHUiOtSOVEnyfEXtC2V3/QH
	5sEgySfiyGoCzJXU+owc249Ay8tuRaYlvT+fVI9MLRxvgYrPdp3d1z0UfGSdekxe49LXcbaaT/g
	v2PqYdW509aD3MTz0IQHgF0NFk0N1elYdwZWn1eueqY3KgAM55DLU5+3XxdBESK0mHnDuCz9iYz
	HOIyJuX4ti8KCdd
X-Received: by 2002:a05:690e:169c:b0:651:bd70:1622 with SMTP id 956f58d0204a3-6626960e086mr1532253d50.10.1781170234928;
        Thu, 11 Jun 2026 02:30:34 -0700 (PDT)
X-Received: by 2002:a05:690e:169c:b0:651:bd70:1622 with SMTP id
 956f58d0204a3-6626960e086mr1532162d50.10.1781170232819; Thu, 11 Jun 2026
 02:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610083452.477759-1-eperezma@redhat.com> <202606111115.tKKe1qCE-lkp@intel.com>
 <20260611050140-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260611050140-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 11 Jun 2026 11:29:56 +0200
X-Gm-Features: AVVi8CdmsRFKQZIyZ17UopqWAhMPANwF34pMq76ydWAvEXpRbOQ4uag66Ggnruk
Message-ID: <CAJaqyWfCLBV7wc9usmX20A+NWwBvNiDfyFWhRkNc8Uyr632WnA@mail.gmail.com>
Subject: Re: [PATCH v3] vduse: Add suspend
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, virtualization@lists.linux.dev, 
	Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V1eMjkymMW90HCFs5PgcOd616QLxSQuu07WDPlqkg1c_1781170235
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 11:03=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Jun 11, 2026 at 10:18:51AM +0300, Dan Carpenter wrote:
> > Hi Eugenio,
> >
> > kernel test robot noticed the following build warnings:
> >
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Eugenio-P-rez/vd=
use-Add-suspend/20260610-164534
> > base:   next-20260609
> > patch link:    https://lore.kernel.org/r/20260610083452.477759-1-eperez=
ma%40redhat.com
> > patch subject: [PATCH v3] vduse: Add suspend
> > config: arm64-randconfig-r072-20260610 (https://download.01.org/0day-ci=
/archive/20260611/202606111115.tKKe1qCE-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 8.5.0
> > smatch: v0.5.0-9185-gbcc58b9c
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Closes: https://lore.kernel.org/r/202606111115.tKKe1qCE-lkp@intel.com=
/
> >
> > smatch warnings:
> > drivers/vdpa/vdpa_user/vduse_dev.c:577 vduse_vq_kick() warn: inconsiste=
nt returns '&vq->kick_lock'.
> > drivers/vdpa/vdpa_user/vduse_dev.c:1302 vduse_dev_queue_irq_work() warn=
: inconsistent returns '&dev->rwsem'.
> >
> > vim +577 drivers/vdpa/vdpa_user/vduse_dev.c
> >
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  562  static void vduse_vq_=
kick(struct vduse_virtqueue *vq)
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  563  {
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  564      spin_lock(&vq->ki=
ck_lock);
> >                                                         ^^^^^^^^^^^^^^^=
^^^^^^^^^^^
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  565      if (!vq->ready)
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  566              goto unlo=
ck;
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  567
> > 9c4307e82fa1dc Eugenio P=C3=A9rez     2026-06-10  568      guard(rwsem_=
read)(&vq->dev->rwsem);
> > 9c4307e82fa1dc Eugenio P=C3=A9rez     2026-06-10  569      if (vq->dev-=
>suspended)
> > 9c4307e82fa1dc Eugenio P=C3=A9rez     2026-06-10  570              retu=
rn;
> >
> > unlock before returning?
> >
> > 9c4307e82fa1dc Eugenio P=C3=A9rez     2026-06-10  571
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  572      if (vq->kickfd)
> > 3652117f854819 Christian Brauner 2023-11-22  573              eventfd_s=
ignal(vq->kickfd);
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  574      else
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  575              vq->kicke=
d =3D true;
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  576  unlock:
> > c8a6153b6c59d9 Xie Yongji        2021-08-31 @577      spin_unlock(&vq->=
kick_lock);
> > c8a6153b6c59d9 Xie Yongji        2021-08-31  578  }
>
>
> I think this is fixed by:
>
> commit e4a249d15eb2d4b28213bebb1eefaf2e6d99de0b (HEAD -> vhost, linux-nex=
t-vhost/linux-next, kernel.org/vhost, kernel.org/test)
> Author: Nathan Chancellor <nathan@kernel.org>
> Date:   Wed Jun 10 12:16:49 2026 -0700
>
>     vduse: Fix error around jumping over a __cleanup() variable
>
> right?
>

Right, that was fast indeed.

