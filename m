Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6CC9479
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724590; cv=none; b=gih647svem8K3+6P3muCYH6Mneqh96Vu+N9ylRzN2oW5CfVh41t2gRV31BwIo9E729pfGS3BIpyXHy3xqAiuKpY74wOGLDL0nekIoOsC01IV5xx+U6J70TeKLe7nRmm6DPxlAmq5AvMz0lXisNNzntrMKKCGxUT3nfsWvehgubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724590; c=relaxed/simple;
	bh=Ox9TBLnaP9aPqB08aXBL462yt/Vovhhe8i02LnN88aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sREdq9ZMS+e77N3mRmYAXfc07Wq/vfOLhbHuPEuAiW2UYSY9y39kXSJ9cbj93y1zYDOT0qsYqvlFfb4vg4dtHX1Xs218tnpJIBlRO9gRUme5Nh1PdPMZfhn2qykucPXNHPqwApSng3pvOf29rV7ftFdeBAf9sZ0zHxstpMz/rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTvDjq0m; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTvDjq0m"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75C48403AC
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:09:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t_eVIHWbvHt2 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Aug 2024 02:09:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8638D40294
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8638D40294
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TTvDjq0m
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8638D40294
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724724585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ox9TBLnaP9aPqB08aXBL462yt/Vovhhe8i02LnN88aM=;
	b=TTvDjq0mtWV7szr8E7OrKGDqokBcVyK73FiZe9zzwRFJkRYU1Bpz84UPvintrYyO760BuB
	Jm62godsawtON608KC3VJPJ3o4LozBeKmTYz1YPH/wgYUk8Bv9us6Q7L+mZ3EX16s7AuUn
	ez1aBWb3oFtKAf5NkszjWHrpV0hi9b4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Xhhe-qstNJSYDgNTXrNTVg-1; Mon, 26 Aug 2024 22:09:44 -0400
X-MC-Unique: Xhhe-qstNJSYDgNTXrNTVg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3ce4f35c1so4337239a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724724583; x=1725329383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox9TBLnaP9aPqB08aXBL462yt/Vovhhe8i02LnN88aM=;
        b=Ax1h5+uGitKZAYOlPftwPxrAuI651Gm4x2j9TlNWm478U3DTyzv6z4LPmoDG2E+zs0
         QLCQ53zNmINk6wMf6Qt7o9VPe4kBnZzgf+ZiciGJH6ekXVTCCxfUIE4ID2bSQ/t2SPeo
         zDxKVoC7bE/kXFaMw43WcOh3nOcRhw/6aFUIlRun5BoBtzjrxpD5mW2DLiZaRT231xyO
         YZhUuZ9JpMxn11b1KlcG2t41KCD5SXRUOXCCLFWhud3YyfXcw+d82RULL6GTvvHy0pAi
         zm6+hyGWCa1jqrP8HIr4Mgt9S8XCKYWV7SoeOu0nv6J14KpgZn99Xbx5+EaUE4ylmtWj
         x6Og==
X-Forwarded-Encrypted: i=1; AJvYcCXKVFK0+A66R2exu0z5zkf/IN/5OnbR5u0vCLHBKUFWN/Ttfs1i+toRWAiYZBnB6VK7fdbzWTyZ+0+r5EsdRQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzEcltxUFjPTT2flt2Zpo6+20bFkgVzF9YYQgY1+GNDv8L1AB1r
	DhTGkMvs44vjWC4tKF4SEtkX83sJasgrOjkL30ytCd8WgiN5R+sR45aCDz36vah3jukjtZ9B6Iy
	gYy+MvLQW7Zx0JllV80vOFAUjD6p0WPRJ4O2R/ahknJSy78Q20fXs80sy+IJ2qDNCI4YynustIC
	HHGlQ2O9XVOAsBfhJdaJfwrL8wufpZMSNuxv2mSKe43WDwWS4D0nFy4g==
X-Received: by 2002:a17:90a:e604:b0:2d4:b8c:7b91 with SMTP id 98e67ed59e1d1-2d824b86862mr2306053a91.11.1724724582997;
        Mon, 26 Aug 2024 19:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRyIGDqgMb80Kz29snKJoL6F7ntR8ReI4Kah7pwXxuEBlrtNMgtfDwjDhYAnUEB6W2Fb5sLwP0TFw5Q1+kDjE=
X-Received: by 2002:a17:90a:e604:b0:2d4:b8c:7b91 with SMTP id
 98e67ed59e1d1-2d824b86862mr2306011a91.11.1724724582450; Mon, 26 Aug 2024
 19:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org> <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
 <ZswgHTRUR-wstAHf@infradead.org>
In-Reply-To: <ZswgHTRUR-wstAHf@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:09:26 +0800
Message-ID: <CACGkMEu882qAovckSf7ufak9+hfQ9jpLOmrm2TmCJTRGrm2D2A@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Christoph Hellwig <hch@infradead.org>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 2:31=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Aug 26, 2024 at 02:21:52PM +0800, Jason Wang wrote:
> > > What is the application visible behavior that the API use is the prox=
y
> > > for?
> >
> > Vhost used to be created by kthreadd but some recent patches change it
> > to behave like being froked by the owner. So the various attributes
> > that interhit from the parent has been changed (scheduling and
> > namespace etc).
>
> Well, if that breaks userspace it needs to be changed to opt into the
> new behavior rather than requiring a flag to not break the existing
> applications.

Yes, if I was not wrong, this is something this series tries to reach.

No flag means old behaviour, new flag means new behaviour.

> Assuming the change is intentional to start with.
>
>

Thanks

