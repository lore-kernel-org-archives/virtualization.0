Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546620C477
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486673; cv=none; b=cWfBhyfKd1hFZCFO7d+1WkAJ4su4hN05dXua9hhVM8d5OxPv1ursyQkZyRJX8NVP/HtGpSOYZ8ALg725s/+jLE3EPd8zCCUyfS1jvvwWSj1YAUkqR1EFwZhVbkkGhXgEMHYoCV76o0Swcyd6fXmWXXowGU9O+JJJ7H7CWIdqJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486673; c=relaxed/simple;
	bh=epBzChFWqyXGC78otuPSiM2PC+xIZf6jGDfUxUyxyFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Dr1bVgymvhEQKkn8jR0T3ZY9IOD2UkLezzydVjhHCDWQcWD/6CkZnKOMijmtYXFGR5XDrFlM3ZvO0MU28a1gG798NWbF3gH4Kfk+33zY1schNtyAEAxl3myxl5GqTwibn/odKcN3I+Qq5QF+5AlG8Lfczwetu3p+lXN0EplzvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl4uzAFT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl4uzAFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740486670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKyNSexWiDKwCqu9HObEPednC2sw0nkOY/VAAlgGvIY=;
	b=cl4uzAFT9aHEUpDHYm+Jn/C0/KRc32crCqV2B/LXHks1wBEObBbv3tFoXumDF0XlGa+Of5
	r5WsQFv9/urffQy+uFXVg0p0TuFhCIeuyVAlOWGeyxTDi3N8n1CcLY2OhpJxubN23rQDzZ
	OTZFSM7L0fZAamLnp4IsAdbFrjWlvpw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-EsZoszR5P0WPw-q16l2QIw-1; Tue, 25 Feb 2025 07:31:09 -0500
X-MC-Unique: EsZoszR5P0WPw-q16l2QIw-1
X-Mimecast-MFC-AGG-ID: EsZoszR5P0WPw-q16l2QIw_1740486668
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43995bff469so44722855e9.2
        for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 04:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740486668; x=1741091468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKyNSexWiDKwCqu9HObEPednC2sw0nkOY/VAAlgGvIY=;
        b=IdnL/DVk+JXEzxPfV3p+hVawbiU3EGAFOV9FJX0+6kL3rVzcdfklioHuDn/lpRPxwz
         sf8Y5UaSOcCNJgqXOFdDMaWq8Em45c0vp+DimmF9VMvrcg4yuh/yqjN+ESsezpxZ9rdg
         dCxTXPGbKpv+9YurfMjAcsTV9DY7LlsOtExyPDx6S1VxuechPx2RK08TTmuLfsorevPp
         IIyBYBLvkS2GLUSXPuBhjnDwbCA6Mvg4xStbQCOPEBTGgABuSS5MM2eUz4KTrnsZ+hgU
         xcCsQJ1K57bcXbev8V3PSpYEafqlCyVJ4wNIbjomSKKWCGx+IvreP0Q3NI+ePS5ZTsuF
         OSxg==
X-Gm-Message-State: AOJu0YzApucRX9tfZAeQvquqe++tanvFfn3gFggyAZr9R2uyo3tnUSGk
	LIQWo25RaFO8oZJoinREh5W5t3sa+EXRDHMft0GhyfqEAFAniuoip0HAKGG/nEl82tPgHqemHY4
	vSuR+tSbVs5HaeshbBnA0GJ3slD2CRQrH5eBph7lClOKXAXwteuz9NLM+6gj2fX1E
X-Gm-Gg: ASbGncswU47F7RlMv/oLBPjJiwkHTKR/r14M6A1sw0sJPnRPSIkBs74/cEYQcfBR9+6
	Nn5uX2EnZiJXf6blYvpfPG+G5tiHLviKT4VUP2m4pLCFBWzHXm8cShfRB+H47FGZZRyItRK9Bo9
	nIZmJssxNVBCJCmH+t776nNMh9dqVX24FeJR8pL/DjDvwkX0X4AmvRQ0kOBzxs4K7uYwXctBYnT
	16oQ9andQqxrPEX9mNUPqR7eJkcS0klWj3d8TKzT5LIJ/I5S4WcoaO0deGGD5CK2MjCdu8dCn+E
X-Received: by 2002:a05:600c:1c16:b0:439:8346:506b with SMTP id 5b1f17b1804b1-439aebb2e0fmr135928445e9.19.1740486667907;
        Tue, 25 Feb 2025 04:31:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8IQnXGA03kjD9l5gPzLgfWvd950pwDLmUbGGnKrhkB4ZzLB2aleYySGlP1eeJx4R7L/lfNw==
X-Received: by 2002:a05:600c:1c16:b0:439:8346:506b with SMTP id 5b1f17b1804b1-439aebb2e0fmr135928265e9.19.1740486667515;
        Tue, 25 Feb 2025 04:31:07 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882644sm2100289f8f.42.2025.02.25.04.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:31:06 -0800 (PST)
Date: Tue, 25 Feb 2025 07:31:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hanna Reitz <hreitz@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	German Maglione <gmaglione@redhat.com>, stefanha@redhat.com
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
Message-ID: <20250225072222-mutt-send-email-mst@kernel.org>
References: <20250121103346.1030165-1-eperezma@redhat.com>
 <20250224164956-mutt-send-email-mst@kernel.org>
 <CAJaqyWfir7+oVtC3Z+eC+jbDxkACs0J9a4-wnx_dgU5VeFhr8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfir7+oVtC3Z+eC+jbDxkACs0J9a4-wnx_dgU5VeFhr8A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4-CYJFLv68DvqCruLxgT__6LL0InTY-Pa7KZajdAbCE_1740486668
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Feb 25, 2025 at 01:17:02PM +0100, Eugenio Perez Martin wrote:
> On Mon, Feb 24, 2025 at 10:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio Pérez wrote:
> > > A VDUSE device that implements virtiofs device works fine just by
> > > adding the device id to the whitelist.
> > >
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> >
> >
> > OK, but the commit log really should say why
> > you are doing this.
> 
> Sure I can expand on the motivation.
> 
> Something like "Allowing VDUSE FS type allows to build filesystems
> that run in userspace and can be presented transparently to the host
> and the guest. After modifying userland's libfuse, this allows to
> expose a good amount to already available userland FS through vDPA."
> 
> I'd add using the high performance virtio protocol but I still need to
> do more tests for this TBH.
> 
> > And also why is it safe.
> >
> 
> Can you expand on the scenarios you think this is insecure? While I
> understand it's security sensitive, you already need root to perform
> vdpa device operations. Is FS different from net or block?
> 
> Thanks!

I did not say it was insecure, just that you need to explain the
security considerations in the commit log.
The issue is that when one gave access to vdpa user device previously
it would only allow mounting blk now a filesystem.

Net is different, it is gated by CAP_NET_ADMIN.

When net was introduced, selinux was there initially then it
was deferred and never surfaced.
Maybe we should revive it so it is possible to control which
devices can be created in a granular way.

> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 7ae99691efdf..6a9a37351310 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
> > >  static u32 allowed_device_id[] = {
> > >       VIRTIO_ID_BLOCK,
> > >       VIRTIO_ID_NET,
> > > +     VIRTIO_ID_FS,
> > >  };
> > >
> > >  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> > > --
> > > 2.48.1
> >

