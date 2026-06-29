Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3173379971
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782697191; cv=none; b=FPNryyGd3r5GR1yrODl5JrPYIKwc49UeBM4eNe+NHSn/lfvMKoGBssgZ3d2ur/tW0YT/anaLfRDUe0j3v9B92vMtPFokhOQKEqbyUbuA46gzZaviGuaCCzi08GBHJ0oONPnnOk4hwLajByuC4XFPM3fq9ZDNyyrwNt7yzTjtvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782697191; c=relaxed/simple;
	bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHjCLhcdToRvC6n3EAchGNTDnpzPapi+7kwHBirIMIbiP5b2tvwau6TfMxHsswD8AzFZdz3cl5zgnBSSOQWesp13nRiHp6a87iKbETykY9JIb9w8Oqpiav0UdQjz6rhYFvp/rUNnPy6KSo9dz+d7lJ3eBewAH2Rzi1wLqsdAtAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guS9qKyK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guS9qKyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782697189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
	b=guS9qKyKHCLfnROCdmiJut6dro2qAm2B3AZOul6Y4u+97/IUaNMe27THtK/ajJ+P5BPUpD
	CHpEI++2ukqhd6dxbg2NNyBXhs+rzS1bC0gzU6tQx0lyOiy+pp5r5chf71UDaJln3CKK1p
	OaN4l1AL6ziS0yI9Xh2bI2pNFs2LWg4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-kSdADC6JOryMkvdGDmYk3A-1; Sun, 28 Jun 2026 21:39:48 -0400
X-MC-Unique: kSdADC6JOryMkvdGDmYk3A-1
X-Mimecast-MFC-AGG-ID: kSdADC6JOryMkvdGDmYk3A_1782697187
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso1437699a12.3
        for <virtualization@lists.linux.dev>; Sun, 28 Jun 2026 18:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782697187; x=1783301987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
        b=B2L5KUpuHRiAiEv+ypA/vLfq0TaLoFVmXWTJYqQJKcMrznI3qU8yydBI/6iJJXb4CL
         VgoWCosGYvwaT8gO9oMT2N+P3bXMZZFCSZ0ME/Ren0aL9DfT+xgnY7N9aqq5STj3wuRI
         CDwLa8+p3ucm6TZHMW7XXmWJY6F/wxuU0iu9qGssAJhTgPTAWpfEMa8MOSp3pUiXczvQ
         d/Fopaqz+fiPhpd0MJm1haSlBOwhBDIcwNIW6/xE+jOiON4dw20/FVHbklm7JzuZrNZt
         y+X4TZ0RFOUiS/bpbICMKXn3ZvVXtUet82mnUgQphJ8+2Y0IRNN3sb6aGF6EsAYVcL68
         AUIw==
X-Forwarded-Encrypted: i=1; AFNElJ/fygnB2K2TJadbuevXkgXfjGnPIEp2kfeaGXjD0VYeHNUDbnBJRWoNxPnhKxffawjB/pImhdJRJI0YhsEahg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkLvYas34DRAlCHQafPLcRnLfa1SjjncpdSbAm1YjA8Jfm4xRN
	DSF4CUQwGkWt3mZqwmxZe6RTKyLiYVz9UdSAl9oirOeXH6e3kOnWYPhWCCPjtMn3DAf5jFV+5Rj
	jpKBoArpM2oUBc2lzlcxuTsTxSetDyVkfQIlxXrcXNx7G6QZIQKBu+HCNM4KnArNeG25fJwJh9F
	yZQlaz5roVYO66e7MTxI8Dm171GhCsGDKYgedstaHo/OCXemfxD58=
X-Gm-Gg: AfdE7ckqtyOgCanldsb6bCy/YBRlQdCqdOIEsAj3cP6zlryBLm27gafYZTZRhBY6mI5
	xv1xEYDNqV5cbFvsRlC/wBTYC9LbpCvj6lrx2YRo9V3gAjuF7wc1PSbWGMQFXlSSqkYHg0U9fws
	lBA3/WsMvsppt6/hh+47tjSPODZUb2mk3Hn3g6/HMHmx8a+ABHi6xpFaPy8G+AHrJ8afMiAA==
X-Received: by 2002:a05:6a20:a106:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3bf735d848amr6431524637.27.1782697186991;
        Sun, 28 Jun 2026 18:39:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:a106:b0:3bf:735d:7fb8 with SMTP id
 adf61e73a8af0-3bf735d848amr6431502637.27.1782697186452; Sun, 28 Jun 2026
 18:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260626022039.96139-1-jasowang@redhat.com> <20260626180433.3e302324@kernel.org>
In-Reply-To: <20260626180433.3e302324@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jun 2026 09:39:33 +0800
X-Gm-Features: AVVi8CfiIaaNu4XD5f16KUtQbZkJ7QsuoHzBIziOF2mgWVcE5Rb-guxFM4B6N3U
Message-ID: <CACGkMEveL7Kp8PJfbOX06LhboaFZt_1tqu7z2rvCnO6yj9kSkw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Jason Wang's email address
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	eperezma@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HV8lga1sodfW6zM47Xa-pJnGXIANk4VziBuxUcmvbX0_1782697187
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 9:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 26 Jun 2026 10:20:38 +0800 Jason Wang wrote:
> > I will use jasowangio@gmail.com for future review and discussion
>
> Do you want to add a mailmap entry, too?

Exactly.

> Otherwise I think you'll get CCed twice (once for MAINTAINERS and once
> because you given tags to previous changes)
>

Yes, V2 will be sent soon.

Thanks

