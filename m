Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5313AA3F
	for <virtualization@lists.linux.dev>; Fri, 18 Oct 2024 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729227305; cv=none; b=IXfEOmHZQwUoWRbnEH9U6w57DCrWYXEmxRHzqJ5oljDzLRyQEsgMLoD9f2fKhcTra8q8s7psaheabPOfx2oZOXk8mY/VWAo0zkHe+BgX3rsG1lmx207G3e2fBA+mbjWJFb8Scjp6M//O9+SPtVTqsKC/pVcsC5+wiSljlYHx4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729227305; c=relaxed/simple;
	bh=JIqvG2jCtfUzqKikp6Uyzo7Po4a2fnUn52lM0O7ye2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqimCzuqOpIjRVJPadhnE9E01Xl9ezIP/mUccr6kamhu1HKW/E9TZAVFbu81vUEJHnupG968X0+m8jmVYJ5hyFymLipoOWUGihFHhvoR63vRIRdZ+wxqBGDCJspc5pN+X/TJSio9uaUkopB+gyByPvaipRr1Ltb8OET+XbJHbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC6swlRM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC6swlRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729227302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szoLsmL231n26j+M8ujJ4xDFFgCiCGUDcshF849Y4SY=;
	b=DC6swlRM1c3FaT/B5LCaYT/wF05/zJx3YHXM1s1JFCr/tInoJ8dYBe/opM/5yhkxHMBMDo
	AR7F07QjTy+z7CqMCETZGHGbcM1DPWdeze56VgHEWUtRXOEc7gazKLdcogII/BZCklnwgQ
	PhcSawk/7k2RCZC2+e8HUrwIhrl+tPw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-SWTSHk7WOEu0vGIOVkKdlQ-1; Fri, 18 Oct 2024 00:55:00 -0400
X-MC-Unique: SWTSHk7WOEu0vGIOVkKdlQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-205425b7e27so15097775ad.0
        for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 21:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729227299; x=1729832099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szoLsmL231n26j+M8ujJ4xDFFgCiCGUDcshF849Y4SY=;
        b=FA0uO/+yNDAcYD202/bad3/v+f9fFdL/snOiuQhxAoXkiAwinTGKCpghRrt/x4rvNP
         YrdwN8d++WuglUohDGyPIXdzi/u5zCcV6AvJdAOAWKLAiClSSkos2+xHamTUak2RQRqX
         So9WIs46Rm8uGobZWfJ59ABR8NN14C6XRr/FMN9ApEme4aXZqcOfYscSW5pSTmQJSm7N
         SXnrholQslznUE16Np+61zacF5KTHJPyYr+DtgyNAIB2isBdNAuNh7aPo19P7pd3b4qd
         Q+wTdFB7F8kMHlFVp9+b3/nLuHEgzSOrpMIhryOc2Rbf005Wy1l2Ge9DsQ2xw3c8bU7B
         8tnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXHvSIuH30cRIRUXRVQjpb3l54/MY3koJZ/U5n6qxhE9My7Ictefm9D/0H44XfBexzHCVNGRqwoRvp63wNXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJSqRKl1mEcqFwNOw4WBsxfdiBA1bYO4KZBAEIQT2JEW2uJr1C
	koSPVNSTYaOMRE/P+Xk5k4HdnjStMrL3iDeXU7Y0vgfjzc/qyz8YuU/3MclddO+A/hn4C5HRob0
	Fs4FgDkns4H9LpRftaifDNb7VC+AOP/dGEgg7LABkU5vS/H87L0a6Zegh8l6FBUBbVvAm+emuP9
	sbeOsCnQofn2RivhQgqYst5bF11+EdUhVC9LwwuGY=
X-Received: by 2002:a17:902:ea08:b0:20c:aae9:7bf8 with SMTP id d9443c01a7336-20e5a79f484mr18664565ad.5.1729227299441;
        Thu, 17 Oct 2024 21:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa2qtY5gLDoKqA6Yco3p4816y2zQXXPzBeUVcOWJS6Zu2NpeNQ0xtaSVTScNoct/TB2ZVWLO0OINwXOzis3OI=
X-Received: by 2002:a17:902:ea08:b0:20c:aae9:7bf8 with SMTP id
 d9443c01a7336-20e5a79f484mr18664325ad.5.1729227299043; Thu, 17 Oct 2024
 21:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240920140530.775307-1-schalla@marvell.com> <Zvu3HktM4imgHpUw@infradead.org>
 <DS0PR18MB5368BC2C0778D769C4CAC835A0442@DS0PR18MB5368.namprd18.prod.outlook.com>
 <Zw3mC3Ej7m0KyZVv@infradead.org> <DS0PR18MB5368CB509A66A6617E519672A0462@DS0PR18MB5368.namprd18.prod.outlook.com>
 <ZxCsaMSBpoozpEQH@infradead.org> <DS0PR18MB53686815E2F86EFC5DFE1E45A0472@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB53686815E2F86EFC5DFE1E45A0472@DS0PR18MB5368.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 12:54:48 +0800
Message-ID: <CACGkMEs81qAn4sOzNBiUUd=VgFuP5QvUtsfSjKVx3Uv2aHnK0Q@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/2] vhost-vdpa: Add support for
 NO-IOMMU mode
To: Srujana Challa <schalla@marvell.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
	Jerin Jacob <jerinj@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 4:53=E2=80=AFPM Srujana Challa <schalla@marvell.com=
> wrote:
>
> > Subject: Re: [EXTERNAL] Re: [PATCH v2 0/2] vhost-vdpa: Add support for =
NO-
> > IOMMU mode
> >
> > On Wed, Oct 16, 2024 at 05:28:27PM +0000, Srujana Challa wrote:
> > > When using the DPDK virtio user PMD, we=E2=80=99ve noticed a signific=
ant 70%
> > > performance improvement when IOMMU is disabled on specific low-end
> > > x86 machines. This performance improvement can be particularly
> > > advantageous for embedded platforms where applications operate in
> > > controlled environments. Therefore, we believe supporting the
> > > intel_iommu=3Doff mode is beneficial.
> >
> > While making the system completely unsafe to use.  Maybe you should fix
> > your stack to use the iommu more itelligently instead?
>
> We observed better performance with "intel_iommu=3Don" in high-end x86 ma=
chines,
> indicating that the performance limitations are specific to low-end x86 h=
ardware.

Do you have any analysis on why Intel IOMMU is slow on "low-end" x86
hardware? Anyhow, we can ask Intel IOMMU experts to help here.

Thanks

> This presents a trade-off between performance and security. Since intel_i=
ommu
> is enabled by default, users who prioritize security over performance do =
not need to
> disable this option.

