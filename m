Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F5202F7B
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673407; cv=none; b=DjVZg1SaxW2b99/PZn60+Q8/3lZAC7PK/IMgghPi3HBMtoAgrodqP59P6sRraVher6ApikuItNgd+7+fvyMFHv8QvNaLReUL5ed78j2lfvwob/tsMv1VI6GEshfHOB3yY3hcGoAoLGYaVHUN00uEO8NsQfk2onOrN5uFBHxh2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673407; c=relaxed/simple;
	bh=7DYuxYq5iQMVGICDY2QMi9y65NM/F8ac6MLxH71EyBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kc1M/HqzyXDFBOcQ+I+iCENc7w777U2lv/sHkCMzzmrWmcD5jwjrsVcdlKJe0FpSEQR1HlDsM/ZGfZl5OkoO508GC+0xnwrSwHABa2YX9JyymJn92Jg1sVaJIy+61YmTH65tAjwGhgcHeNZqa4DhqlyN07StG9nayIq6hf7ivGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzM4DO7Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzM4DO7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753673402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C83Mxg+jc4W7tLsg6CC1/bE+dKhpk6vxsSd0/8fHDfw=;
	b=OzM4DO7ZvOaHAqmluEdx4l6+QV0+rZZe3owFFiHGX8v3tsMdJ5QNq21VLQ0Z1a2EnYoKNG
	mIbjEMGggXIMOLd6UPx8lhwC9dbyqoHyFig4d8l6S7aGzMQ/yELvRLFSNwvoLzdvHessv3
	WcLqODHtt5gh4ulaAd6Mbe6erdYIFXg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-uDbfXV2DM26Oni0tYggAOQ-1; Sun, 27 Jul 2025 23:30:00 -0400
X-MC-Unique: uDbfXV2DM26Oni0tYggAOQ-1
X-Mimecast-MFC-AGG-ID: uDbfXV2DM26Oni0tYggAOQ_1753673399
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400b28296fso10479945ad.1
        for <virtualization@lists.linux.dev>; Sun, 27 Jul 2025 20:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753673399; x=1754278199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C83Mxg+jc4W7tLsg6CC1/bE+dKhpk6vxsSd0/8fHDfw=;
        b=EdVIx7Jusz7cl+uOtxB50iR+0bZOO9QcqsO1Cn3fSB2duP99VdvQ4UHaI4vgzCN7ef
         rYLU2e/ga2kk+GiD4XGc/l0xiGaLBjNXGfMngksANaOCl12Zw12DV7+NHn9662wvcqDh
         zGOR5bZRTbD43zz0wC8wvvb1tJVm+cAn/MpBr4CYHxLz8lUi9PX28bu/ZxgYFfkBiPBa
         qEe9u/7te5PgSRCCnqXv39iNDtD/H/ehXXv0QfDWjwGopgdsg4tS+P9NO9suLrCQ4TMt
         CQNZpYv4zQOIJNyHhpXUGSSEH8tfj/LzDFAXdlVH+0T7e1BLcOSvKa1VhwO744HwD0kw
         CdKA==
X-Forwarded-Encrypted: i=1; AJvYcCXAC9Px0S+2ReuOpprnN25h6Ad1X5ioE932O29ehRLKseE02JNdYhQiuQyCU2m54TQ2wMxlxY1MRXCLgTMlSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeSE7PPSH+UoF8Isbd6jZES8KwGtznhlh4nVJ/ANJanNafeQMb
	SoE6yWNX+HUJufRquMCXhJm8mBWp1O8V5vxOeIN0TUTcOPsM86EDQWbVkx5lXniDvOjlbFlVkC5
	IInJvCf3PHOxLBOneuTvip3rD6T6TNMlQQZYW/I5nilqxeR9qa7K9MyDCtwQwAC4vFq0WX4iKr5
	mPPE87JWs4cHQmZ8W5aIrMH93pFiviv+UV9hYX1k5HMks=
X-Gm-Gg: ASbGnctaeJrFQW9SkMhZnvASJYFsTPRPU0CIYL4aGt6S1sCUUDIxZNLz3kGlUcNygCb
	P0851YET3TTvhF3rVJE6gfWBRIyNMWXnytfuCicMh3BPdSQCGwrMgX13Ef5zsHdJSYjoQgROQQI
	8TS//KQdCWIv71xljGqYw=
X-Received: by 2002:a17:902:ebcd:b0:240:1f25:d443 with SMTP id d9443c01a7336-2401f25d6e2mr30560125ad.30.1753673399597;
        Sun, 27 Jul 2025 20:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDm/Gzir3BF/7ZYp0sKNtVBOwnJLz6VbOmMMiqGZKAeWWWfopLvjf9zqkYWO77SQsKbsCM/eGVmPDAVdqAVuE=
X-Received: by 2002:a17:902:ebcd:b0:240:1f25:d443 with SMTP id
 d9443c01a7336-2401f25d6e2mr30559885ad.30.1753673399191; Sun, 27 Jul 2025
 20:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250725083635.73355-1-jasowang@redhat.com> <20250725091129-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250725091129-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jul 2025 11:29:47 +0800
X-Gm-Features: Ac12FXzBKfRjj1zeWsbUaDLspQ0PjkB3AfDBNjrF97VpxVGJeQKTp10kHWMIYgw
Message-ID: <CACGkMEu2Dq6MWM9D4AgUMXWe-evhmN5pMGjWeW84Yzj5MBXK4g@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix uninitialized used value
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"kernelci . org bot" <bot@kernelci.org>, Linux Kernel Functional Testing <lkft@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 26PyJ2iF0NAEu3mJ0venGcriQUX6a-tI97CVdQvg7zs_1753673399
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 9:12=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 25, 2025 at 04:36:35PM +0800, Jason Wang wrote:
> > Buildbot reports uninitialized used:
> >
> > drivers/virtio/virtio_ring.c:2113:40: error: variable 'id' is
> > uninitialized when used here [-Werror,-Wuninitialized]
> >  2113 |                 BAD_RING(vq, "id %u out of range\n", id);
> >       |                                                      ^~
> > drivers/virtio/virtio_ring.c:2077:19: note: initialize the variable
> > 'id' to silence this warning
> >  2077 |         u16 last_used, id, last_used_idx;
> >       |                          ^
> >       |                           =3D 0
> > 1 error generated.
> >
> > Fixing this by use last_used instead and drop the complete unused
> > variable id.
> >
> > Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: kernelci.org bot <bot@kernelci.org>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> I squashed but I think you should respin.
> also noticed a couple of minor issues.
>

I think a reppin of this patch should be sufficient.

I can post a new version.

Thanks

