Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AC1FF1C8
	for <virtualization@lists.linux-foundation.org>; Thu,  5 Jun 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108977; cv=none; b=ESh1Clcrlo/QYSaoReEZBELKNkPodhDLGaajg9H1b+fHqtYAQITVEwViSEhslgHsQmMVv+lpNytxTNN+crK8qYE1jJhbKEX4BL6k9Smj9svob/98tJzqUIA9mSdeY3eTQuDQnwR25g9XjO33PVDprNrMbXxrQSAc6kOp2Gs29o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108977; c=relaxed/simple;
	bh=sbqnBmXp4Y55lx0p4/uF+T2QN9aG6Xvg1aq1aLpduzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/S8umnsXxfp6Bfr17vH3X2KsfyNwvDClQb9Ll9x6rnnivtx8GExEoTMEC3/LmQBUacFuDtC24jpxBp+5a6K0tQotB6DEhBTjtNNaDo7jujL1vdWH8w/2MGZjHBDn+kT+S199++Dy2/tJAFG9aOJpMzcWaYO8RFKpQibNbHtp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hk0ptOS9; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk0ptOS9"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF17E4081E
	for <virtualization@lists.linux-foundation.org>; Thu,  5 Jun 2025 07:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GdnhXUqBJDAa for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Jun 2025 07:36:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F328040947
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F328040947
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hk0ptOS9
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F328040947
	for <virtualization@lists.linux-foundation.org>; Thu,  5 Jun 2025 07:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749108974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UEFyEH5OwZcCtsgCpmVtI26aMMlVVtISZXT0NgO0q8=;
	b=Hk0ptOS9mdcCjvb/qcTiS6M75nE9TUO1HyhNkzfgqw3O/LiRh6ec9ZQHgCXGrZTTFPknsR
	/if8cqGovZ8URN/RJAwJv8fNBsyBXDvC0Bk70x9mPG4mfcxXS5DZiNauQ3Ce7MdZ/jx5mZ
	EAEjBgyxAKwGjDVrJwdDocjBKBjk1Fk=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-m8w2OZtvORSWmlM10d4z1Q-1; Thu, 05 Jun 2025 03:36:12 -0400
X-MC-Unique: m8w2OZtvORSWmlM10d4z1Q-1
X-Mimecast-MFC-AGG-ID: m8w2OZtvORSWmlM10d4z1Q_1749108971
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4e589a6f9b4so113155137.1
        for <virtualization@lists.linux-foundation.org>; Thu, 05 Jun 2025 00:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749108971; x=1749713771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UEFyEH5OwZcCtsgCpmVtI26aMMlVVtISZXT0NgO0q8=;
        b=bm85Z2Jqe+xKeLdq9jKzWtwSQR/fum/HD/4iR/muNNMQYzhezOs1rwSCNyB950ut0a
         XPvNHVks6XUWT4uZ9mptyG+P5B1mHGBi5GByOF/o5GV/IFi6zuYd2Ay6pcGDUtXmV0py
         ZQvvqST6gnbBly8fQbHP5L7sqt4FZaU4/+H8JeVJ9l/D1RctnStzVaVt+PYIhT9a/yXt
         BPcbaziwu21Ao+fKa2vV9j0rbVEY7fOGXSvhQJuq8sXd6LDpq4YbmL2NEtuIxkbkRnPO
         QpA7TBLoyFWAbug1i7c2Dp777jRZ7G0zMyM5efzdmU9hAXSQkcZFCDjzYDUGH0w6rduS
         W+7g==
X-Forwarded-Encrypted: i=1; AJvYcCW0Hs0dH30NlzsdE09t7EbgCOVTjU9Gozecxy0MUSY85NVDWVevpm+4u2oljR642pS0NLgX7dXCUDXymtt4dQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxS9zEUlh8ZIYrY5Szide7juNlAvXLloZrLSLuWx3S4YADxmq2i
	R+R0VqKYUI19XUYaf3SEagTdFD40iaEwk9A+XJjR5SE3RUGK4ydrQqfJT6Xt20wPpz4tZvc5PJv
	aWXxOd4YTG8nU0NDEkYZ8mAXMJwKrW7zYepup37JvvF+hPZMawscsaokNuKqsOS9yldQ43GOk8K
	Nh6eg1/S9FNgcJYW9gTqDFhx4Lx1boJ+szdRi/OKqeVcW4Z9IRVUe4JVXcxg==
X-Gm-Gg: ASbGncshFw73hNDibEa4JNM2kPiK8jh8YaxhCusulbJlUzNpTzo8H591FqTEWpPXkP1
	wp55TOMfvSvvcWoaTlKBONdEH1onRqS2loNGSqSp6c+wxyqiXUGwIs7Qm4vGQAz5Oc8eAVA==
X-Received: by 2002:a05:6102:4192:b0:4c3:64bd:93ba with SMTP id ada2fe7eead31-4e746d2f409mr5002980137.11.1749108971348;
        Thu, 05 Jun 2025 00:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhmZvNcFSJRPa1f5R1qRbR6ezlxjfGxuvM5sbmFEDudxzciE5vcVcY/k1vcxfX+gPEARM47nbeOoiyidVDKrY=
X-Received: by 2002:a05:6102:4192:b0:4c3:64bd:93ba with SMTP id
 ada2fe7eead31-4e746d2f409mr5002971137.11.1749108971045; Thu, 05 Jun 2025
 00:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250531095800.160043-1-lulu@redhat.com> <20250531095800.160043-2-lulu@redhat.com>
 <20250603073423.GX1484967@horms.kernel.org>
In-Reply-To: <20250603073423.GX1484967@horms.kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 5 Jun 2025 15:35:34 +0800
X-Gm-Features: AX0GCFvt-W8mHusNUhum5I6p4CStc_YDVayaIlpCDLj8gPpi1rBVSY1KA3nbyKQ
Message-ID: <CACLfguV_2Mhy-kxha5nK-GRRge1UZKYJ+21DWOhUFQ5cigeVSw@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 1/3] vhost: Add a new modparam to allow
 userspace select kthread
To: Simon Horman <horms@kernel.org>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _BJR9f7_EwocBJUl0--a1co_Csosgyv_8A1-0HTRR0U_1749108971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:34=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sat, May 31, 2025 at 05:57:26PM +0800, Cindy Lu wrote:
> > The vhost now uses vhost_task and workers as a child of the owner threa=
d.
> > While this aligns with containerization principles, it confuses some
> > legacy userspace applications, therefore, we are reintroducing kthread
> > API support.
> >
> > Add a new module parameter to allow userspace to select behavior
> > between using kthread and task.
> >
> > By default, this parameter is set to true (task mode). This means the
> > default behavior remains unchanged by this patch.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c |  5 +++++
> >  drivers/vhost/vhost.h | 10 ++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 3a5ebb973dba..240ba78b1e3f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -41,6 +41,10 @@ static int max_iotlb_entries =3D 2048;
> >  module_param(max_iotlb_entries, int, 0444);
> >  MODULE_PARM_DESC(max_iotlb_entries,
> >       "Maximum number of iotlb entries. (default: 2048)");
> > +bool inherit_owner_default =3D true;
>
> Hi Cindy,
>
> I don't mean to block progress of this patchset.
> But it looks like inherit_owner_default can be static.
>
> Flagged by Sparse.
>
sure, will fix this
Thanks
cindy
> > +module_param(inherit_owner_default, bool, 0444);
> > +MODULE_PARM_DESC(inherit_owner_default,
> > +              "Set task mode as the default(default: Y)");
>
> ...
>

