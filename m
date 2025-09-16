Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176C2E54A0
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008110; cv=none; b=mBi5STttDenQKSIP0piFvrJstSJ5okJDQJ8c0wEob68ZSQfe5xqe6NVnSJoSqOTUyRyetuxcuw2NExj7ZDnhyA5I9Ao5cBUjgCjUOpxj7PSXilMkinOKtp2cJ/uiIoFx4Znhax96dujJ6O60XAAJ47Gsk2sKafVGL3+KHmILZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008110; c=relaxed/simple;
	bh=D6d9ekdBEhyb3G2A9aDEOXln00Ab2y76UPi2l9PmD4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2W1ZuI3BQ5ukobLfsJUp9p+SCLUkLsYQLCFiyCs9FcQl3tD21qBvWbEa8rkgM+IgFfI8WLd9dR+SIi+cKqLD0TtXFyBEUidfcyN4QPZsVayPYY1mJlTHQow0puGkw9w/gSxfY4I/MBSes22hMGTdgbXbLjguSj8JKMkBPwcz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRLlI49x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRLlI49x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758008107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6d9ekdBEhyb3G2A9aDEOXln00Ab2y76UPi2l9PmD4M=;
	b=MRLlI49xEbnrT8jtyJZVNi97yMYblw9+cwr5e4SR770bovfRS6vAF5li8L+24g0ESlJJ5V
	NHQPAXEUJfpm+7Y7fTxfkkBMBPghbgGeRSLE26nCqfaWSgfKF8Y3ka8TC8BiNNG1K0qcfR
	ercTCWTmm09hEbD/36ROeTTE9Uqh/Z8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-X3IQX-JPP6Crk45iUdfPKQ-1; Tue, 16 Sep 2025 03:35:05 -0400
X-MC-Unique: X3IQX-JPP6Crk45iUdfPKQ-1
X-Mimecast-MFC-AGG-ID: X3IQX-JPP6Crk45iUdfPKQ_1758008105
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso6144558a91.1
        for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 00:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008105; x=1758612905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6d9ekdBEhyb3G2A9aDEOXln00Ab2y76UPi2l9PmD4M=;
        b=oWyu+4NRzfHHHMuO5kB2lO3LXWsV2VivmPjS1+2QIJJr72MsuOSMypWbio4tzkhHHL
         uWQrkMJCIcUipkG5ba0nKPp5TRkOpXBiwHy6kcOSvFHBljwjeXr/VVQ3I2DJJikaC16f
         C00mhkdJhGaKgX0erohj/PhiAE2PPxSF4CP03oTRODSV7Le6FtFuUdqZ4wkdZZ+jkQKk
         aDTtHy/mVyNFKT5QGmDxmBJJo4Z/fQaG+RxrX+ZLuX1ceusVin/j0m9FsqHuMzG3J/fb
         i85FrJw6btnht1OFr0h8m1uAnQ3RdqUfRGv0fVCjJaX4MIiKkoU6/PH9kxON1f3ROMpd
         nmmA==
X-Forwarded-Encrypted: i=1; AJvYcCXzvzVJo1T+WK2EKu596s/deM4afQ8/vP1mDjYX0kMJ1wfGW7lNgNQ5htoZlgwMxKeBgRC4w2Axd3XDvyGstA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkIbPJImon71HDYkaKChCLO4pcLe8gnkvX5Roz1ATwMkj0BvK3
	srpHE4EzcXi6t1LhXrXJ3BXSRDMX/h7f4aPJ+w4hf4HcOSO41Su/7zBo8ElBtY6L6/dRFqfigDX
	1OjSWXB0GMHaZ6SD8xCQm0KDNoIt0b86P/vQ7JP1HwRhr4LvZ0qEaha5WrLFUriyfePDsGHjmgt
	UetdmK4UMPcE9EaiwQExPAL64kuih/VR+al1xT+ZOungc=
X-Gm-Gg: ASbGncskG6Nbqi5e+tDDK7M7MpUtL2mxF8hVbbkwMZyaqhckZMhijj43nr+QVqtbpkb
	mA8KUA72oMhY6Fi3+6SEY6WBhW3BqNAmDO6+ygi00NXOCTXyh/Ww6KGburFmN3zqtMzUdftKL7P
	ul6kqk1VAUasodE9mc8Q==
X-Received: by 2002:a17:90b:268b:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-32ea61f40eemr1655249a91.13.1758008104885;
        Tue, 16 Sep 2025 00:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE41+0nEZ7uR68Mnvkj3byTsvAEGDCXOwLITAVl6OsB+Oh86L0Un50ZLiDd2YqmZSU5tm/eVC4SN1t81Pb26VA=
X-Received: by 2002:a17:90b:268b:b0:32d:e027:9b26 with SMTP id
 98e67ed59e1d1-32ea61f40eemr1655196a91.13.1758008103710; Tue, 16 Sep 2025
 00:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com> <328b3f8f-cca7-4d8f-9335-24341b40b2d5@bytedance.com>
In-Reply-To: <328b3f8f-cca7-4d8f-9335-24341b40b2d5@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Sep 2025 15:34:52 +0800
X-Gm-Features: AS18NWCI_RI0SXTKAt8c2DrKB370dG1BgGK6HWboIC6YYEbwdDnxbL9kobwsFbc
Message-ID: <CACGkMEvXH+VpA-2sJ39QL4Rb3Gg0VCOKn5BApRpft=583Qcp2g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] vduse: Use fixed 4KB bounce pages for
 arm64 64KB page size
To: Sheng Zhao <sheng.zhao@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JqZv5XRHaf6ldEZs6zPDc1MovN8MsDmCeNM7MtQ6pr8_1758008105
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 7:07=E2=80=AFPM Sheng Zhao <sheng.zhao@bytedance.co=
m> wrote:
>
>
>
> =E5=9C=A8 2025/9/15 16:21, Jason Wang =E5=86=99=E9=81=93:
> > On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM <sheng.zhao@bytedance.com> wrot=
e:
> >>
> >> From: Sheng Zhao <sheng.zhao@bytedance.com>
> >>
> >> The allocation granularity of bounce pages is PAGE_SIZE. This may caus=
e
> >> even small IO requests to occupy an entire bounce page exclusively.
> >
> > This sounds more like an issue of the IOVA allocating that use the
> > wrong granular?
> >
>
> Sorry, the previous email has a slight formatting issue.
>
> The granularity of the IOVA allocator is customized during the
> initialization of the vduse domain, and this value is also modified in
> this commit.

Ok, let's add this to the changelog.

Btw, do you have perf numbers to demonstrate the benefit?

Thanks

>
> Thanks
>
> >> The
> >> kind of memory waste will be more significant on arm64 with 64KB pages=
.
> >>
> >> So, optimize it by using fixed 4KB bounce pages.
> >>
> >> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
> >
> > Thanks
> >
>

