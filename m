Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F0360745
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418832; cv=none; b=AvGj6ZeINkAuDCop/slDVDORlnGCLEEydw+SR15mWm2uXK5NE+R809obo2hhguWQbJaSKiShvje39SR0c45KmwMLryD/8Dy3S0ZVMhUcH9VlTE8gIQqyVTX+nymoZqoLptHMShzJrVSh29jF6Nc3O07cViklScvTgr6sa4Favqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418832; c=relaxed/simple;
	bh=wyXlAw9NBuCcYrZ2aWPeMRBPQO6GBVmiQWBTWbYFFCo=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=N3YYC/2U8+V8ec7HElJ5u09d+HM6/snrvDVf6+Gu5vZgnzzCzYYMEQ2OXr38CtPfpHQoXTupPDWgmFxdWD8zLwrldLlMaW0Iv5oxjkxVl6RGMkYYMUUDhh1aYmsctVrnjVadgR3ANex5T0D0cZOcIpvLK0S9EjMIHAlhTGoxVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNQQ69s3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNQQ69s3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-809466d7991so6380717b3.2
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782418831; x=1783023631; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1SDcvwC+2cfNzc62XgNhssE3KTuau50UXxV1AfZ1AU=;
        b=dNQQ69s32IvrRSyBz8O7AuYXLjLmOnwRpuHmUNI/VQBvsX7NN1CjUvi9wlwqwysspz
         /xSe+JDMeCLEkH4qwNfLhwrvAcZ4A/I1buKq2oSoh3PI8dDmbe59r3df/f6Y7tuZGgUJ
         lSRTvKMRG3Tv4OInu86mWqmAyTJt9ORkCGilt8Ee/RFbJ8jbCuWzZ6CfjYXdzQ7jujxJ
         ln2klv33blFJhGWV0OvvtcPSVrtfoLkYTVguO9hv3u9nYL81D0GEKjmczzpFMqynsoBo
         IT/ByuPfInxY360s3j06nEOBGT5ZdsecF+FAod7SA/AL0KSxx3jHXZDZ6gSQL2jt3cmF
         y/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782418831; x=1783023631;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1SDcvwC+2cfNzc62XgNhssE3KTuau50UXxV1AfZ1AU=;
        b=fFu2ObMozg0C3uV4zM6cE44jIQEhbJqpoftE4CvnrQGqGH6D4qF9hjP1/iOsth6nDu
         Z7+3y94LF7wrl2i2OKyHtwnJSD/bCBUpBzI6YMjYZhYaCTt7YrFQaxaIfwnJ11+E023y
         ad8ik6wl788PSxMYocKKrku0udB2pZiGzdxPnr4A+Jd/0ND8P/fo8l3ATFgnt3xpOyCV
         jeVpsqzBwUFGWP//lYY0lNeXlkMFcbCtDBll4O5K8Hj1JEK2NE3IdsAB4n9J4kN0Fz2g
         ZMY6bq3xQ4hnzLhI+a9x3xYgMCU6x9zYA+yAOonx4jYS/16HYEUcbOP3oZQR/8Z70WX9
         p+cg==
X-Forwarded-Encrypted: i=1; AHgh+RqqfejpqlWjtpO99xuASrrkGYFzdNbko5AZmfXBFb5izDJowQSoorjPkfeYEDzFVh9jVey2H88cDqepFJnNzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPRahHLsm94SaX+9Of03nLYafKLybf893sAF44Ekylw4QutY6z
	pmxJciMWoNZQ8j3d47S57bI7Q8sA4fFg/HKcpqfy+VZr2fSY6U6lavhl4lIBD+rPY+L2nCrdmt/
	Z9Mo1EPnKy/m+H5Xhsh0P+gBWaS59
X-Received: from ywae25.prod.google.com ([2002:a05:690c:a799:b0:7db:a916:9126])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:b82:b0:80b:9f4e:a8a with SMTP id 00721157ae682-80b9f4e0e00mr1449587b3.9.1782418830351;
 Thu, 25 Jun 2026 13:20:30 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:20:17 -0400
In-Reply-To: <20260622172208-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625202019.2982436-1-briandaniels@google.com>
Subject: Re: [PATCH v4 8/8] media: virtio: Add MAINTAINERS entry
From: Brian Daniels <briandaniels@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Brian Daniels <briandaniels@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, 
	adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

> > From: Alexandre Courbot <gnurou@gmail.com>
> > 
> > Add an entry for the new virtio-media driver.
> > 
> > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index efbf80806..af370b787 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -28327,6 +28327,12 @@ S:	Maintained
> >  F:	drivers/iommu/virtio-iommu.c
> >  F:	include/uapi/linux/virtio_iommu.h
> >  
> > +VIRTIO MEDIA DRIVER
> > +M:	Brian Daniels <briandaniels@google.com>
> > +L:	linux-media@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/media/virtio/
> > +
> 
> add to virtio core too pls.

Fix staged in v5

> 
> >  VIRTIO MEM DRIVER
> >  M:	David Hildenbrand <david@kernel.org>
> >  L:	virtualization@lists.linux.dev
