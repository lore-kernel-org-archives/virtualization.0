Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17F1CDFC1
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434968; cv=none; b=n2RwdXYi0VGPKp9bUA6flFrgp5NQ3hvQtTdkIDvCn1JqIWvZMMXnc0TNc42pwFQ/8H3kaha7CrcvkOPvEOJfWUt+7ES2b7LG9ah4Rh6qtWqRLEuF9SlRYsipHF1XWVDZm1GQugxlY3JbkParMOnxb7UWz+wO2cTwFTRn9PE2w6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434968; c=relaxed/simple;
	bh=SGrH1u360HKGfwUkB5OQl0M0A4QLRKrf61IPTLVqChc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTGV7Zw8MCSINtCl5KyrEjxdT3Ri8rkfqiNnQx1c6Ibyvx2IiDqm41SHVwT3z/VhqmSWfmsByNanFZTRZ+1q6SR4bnN480zEWrlZpUVAPIh30qnbBrgqX5yqSoNzkbEl35F8u0PCK+zlqp43OI/55e36Prhh55kbORMPhE5xPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgR1o+6m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgR1o+6m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742434966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGrH1u360HKGfwUkB5OQl0M0A4QLRKrf61IPTLVqChc=;
	b=KgR1o+6mGrJKIDfou0zw8lH3q8y0iiKZupv8oRkQ1XtD/mvdAj3/0FlCI04wtpR+tWhJ7h
	8RUXJaM+SXXhd1huD9Lp2MVmYYkNUDtXGb3+u+7cgilL/RjWIeDZGK+YjCcn5nsKPdPQKb
	M1ctpF/h3v5ApJSuU6bOvk3GlTNwD9A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-DziMIg8ZPuWKy4XoxuV1rQ-1; Wed, 19 Mar 2025 21:42:42 -0400
X-MC-Unique: DziMIg8ZPuWKy4XoxuV1rQ-1
X-Mimecast-MFC-AGG-ID: DziMIg8ZPuWKy4XoxuV1rQ_1742434961
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3010db05acfso362677a91.3
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 18:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742434961; x=1743039761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGrH1u360HKGfwUkB5OQl0M0A4QLRKrf61IPTLVqChc=;
        b=tE9/ESsE9KTNg36XyeY9egLKJBxK7ufK/wCjKfT1dVZni5Vyk8DYEYsX0ERJNSeT5O
         A9S6Jp/kNbumb4at61J2tCexhLb7rJM1K/PekCnIQnixPY9LxNLP42+z8by0i0tWEzAY
         2Q1kIUA5Ah3zTVBhLglFnr3LwgOvc9o5utJdILsF5Zh1YqaceafQSND3eUt3VB98c5Fg
         wScR+l+Ll3uur1NpXlc8ziYdziS2kCYP09lJ26of1xgC5v3lpuklW4+q1CY0f8g7pX9N
         g2lb8pKOccDbW0WY86FffwrsHjmyfsnrK7UWPiZtIkbiy6dewanSEOLab4FG6a+EW1LJ
         H9Eg==
X-Gm-Message-State: AOJu0YxtR8sLUz2dtVDsPQioQdQRtDBjvIHZ5l5IKuizcc6QV9p0yobK
	hgqp/sgyfBJGEb1NOPofgRnG8a+Xffu36rdfHSrCLX4f5Be3G1JlgvzQwIJVrgpE27X97j7ZV/X
	JTzkD/Y5yWwEd243a2cusa6NxdArOPM9aI11iF6fMBQneMECIMr3nO90/TbtyhkNnZ86Nymd7Bt
	z9eTIW1RFI1ThlkDv/MRnU8bOrEM9uQsR8Nd/1j+o=
X-Gm-Gg: ASbGncvRTT7MdQI/spauIcNcdP0/M/izFe2ZddKcZajDbrkPdsiWtdE8jm//NjbMEkK
	e49otHXuok2+zkg5b8VNWxnDAshHwHUF4SSO+Jy2QtbWaIj3dYP+BksIA2OCOkj4z9B6wEdfv5w
	==
X-Received: by 2002:a17:90b:3b8d:b0:2ff:702f:7172 with SMTP id 98e67ed59e1d1-301be22004bmr8335520a91.33.1742434961586;
        Wed, 19 Mar 2025 18:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHL8OOunCev/pL9yVKVD54yPvvXy/UMUfGTvOvKDcF+K+NIjug+q9W+WWL+a2DVKRNK9ypCK2PuGfDdKa5c2c=
X-Received: by 2002:a17:90b:3b8d:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-301be22004bmr8335480a91.33.1742434961230; Wed, 19 Mar 2025
 18:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com>
 <20250317235546.4546-4-dongli.zhang@oracle.com> <CACGkMEsG4eR3dErdSKsLxQgDqBV55NUyf=Lo-UUVj1tqQ-T8QA@mail.gmail.com>
 <f3939e10-3953-4be4-bd92-2ae891f6d67e@oracle.com>
In-Reply-To: <f3939e10-3953-4be4-bd92-2ae891f6d67e@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Mar 2025 09:42:29 +0800
X-Gm-Features: AQ5f1Jog19Stpw5ZwXnl2LZ0a3rRd5bIs46de4Ks1-qbsvRNWnVK_fE3aiW_X5c
Message-ID: <CACGkMEs3O2B0fAifAki9GdDiP-SX4pMviEOjqCsAkkzCyx90gg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] vhost-scsi: Fix vhost_scsi_send_status()
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aywIYwQgCnRCt5yat2LLsqBjBObXkVNGkBpVGOIuom8_1742434961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 1:54=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> Hi Jason,
>
> On 3/17/25 5:48 PM, Jason Wang wrote:
> > On Tue, Mar 18, 2025 at 7:52=E2=80=AFAM Dongli Zhang <dongli.zhang@orac=
le.com> wrote:
> >>
> >> Although the support of VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 was
> >> signaled by the commit 664ed90e621c ("vhost/scsi: Set
> >> VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 feature bits"),
> >> vhost_scsi_send_bad_target() still assumes the response in a single
> >> descriptor.
> >>
> >> Similar issue in vhost_scsi_send_bad_target() has been fixed in previo=
us
> >> commit.
> >>
> >> Fixes: 3ca51662f818 ("vhost-scsi: Add better resource allocation failu=
re handling")
> >
> > And
> >
> > 6dd88fd59da84631b5fe5c8176931c38cfa3b265 ("vhost-scsi: unbreak any
> > layout for response")
> >
>
> Would suggest add the commit to Fixes?
>
> vhost_scsi_send_status() has been introduced by the most recent patch.
>
> It isn't related to that commit. That commit is to fix
> vhost_scsi_complete_cmd_work()
>
> Or would you suggest mention it as part of "Similar issue has been fixed =
in
> previous commit."?

I'm fine with either, they are all fixes for any header layout anyhow.

Thanks

>
> Thank you very much!
>
> Dongli Zhang
>

