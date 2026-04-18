Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A01F09A5
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776514302; cv=none; b=njCjqegv775bsUnHsEBIHEYEmOax1av2J/XrakVR3QTAbiKsO59ZjeBoiM7QfTuMoaQ8jG6WW2pYKS9Wdm39Qc3sifBUc/PVef4RBX+3OndbnO7Ape8eswwTjylrnmt+Jy9XQaOgX9ZyEhBN0lT+dhrbbnAlsT9gpvDT7rCaSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776514302; c=relaxed/simple;
	bh=3IMpqVTehU5fBs/5C0IiMz73ggjcJQ9kIjIUzNHZoL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q3F+7aCqClcP8XIw7ucT+lhnxS8b36+QuGU/kDuydnh3HDQGUiXhVVKZAa2x9wCO72XZSZs6D+Wzn3X7Gg2BHGcCIJHfK/f9ESRH7kneGTsSKIAUb86Bm1ohX3Cyli4O/SLOhVbGLA7YrtqKbXC1vgtjFsC9fsnJHUHPeWJL0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOiM6esW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOiM6esW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776514300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2nMnTR8v0UWC8QSBtF5XWm7KZoT5rFuVXyMC3JV+oM=;
	b=cOiM6esWhZWy23j3dLNU/lQhhUW5+2DFxPsr3CPAuF2zrJMOLKj4cMv3tFYoUVlqFknpSD
	PS+Pyr8Z1H33/xnv2V9rVokgLxstKs1u//V7xie8SAoDHK3iSub8WiTccckV3mxf+sUVPI
	f1nLRx1c5iQ3uBjJ5X5NmIaaxyGjbVU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Uia__LhEMieCfuOMFAdbeg-1; Sat, 18 Apr 2026 08:11:38 -0400
X-MC-Unique: Uia__LhEMieCfuOMFAdbeg-1
X-Mimecast-MFC-AGG-ID: Uia__LhEMieCfuOMFAdbeg_1776514297
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d177fb157so1309762f8f.0
        for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 05:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776514297; x=1777119097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2nMnTR8v0UWC8QSBtF5XWm7KZoT5rFuVXyMC3JV+oM=;
        b=SUQEsR2I6RKakYxprHLgWMWSv9WSJ/YT+YhKZ29TS9OiPqSbOXvPHeWrUUpicDSd1h
         o9rsJyesX5gz2gmUwZ759RFcxRmF2exwZl6c59nTbOzvNXWWx8g6h04qBXnafsJ77fSo
         7Xpx3ND1EvxqgX7FFXVjfpl+tp6wjheTesOjEbA1igtW3OBt0Su7eosEUlciuXMPA4fY
         LN7H/ou5Yh0udVIFqvVyU3hHBftRZwrvM7opRxPyx5XNhyntcIckAqqi/gHE2Ym6l+ZE
         3iDj9uGDlkynXLQGJCkraQoapJ6EO7gjc1BKSeZyO8NGj6ja2L4VfBo91hMd9uF3Fosc
         Lg+g==
X-Forwarded-Encrypted: i=1; AFNElJ9DmuXB2aAOZUG9KEvOtXhnCjP+pwm/DQRSyGYuG5PkizUazlUAcXeOUlO9kj+1Jk6kS3pWEkQ8Og+gVgMOEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNpWYsTdPCRM344z1B0Qr541HDp+8HL3oQUpBVFradatM86a5y
	/dLSQ5soWnOLYs4F3qbX3yb2B/cdqNSVOUBUEODTOnlX+sCLpvSvvPbSVXBa9a7T5HaOCdSnhpf
	d9r6pBjOWvISglT7ry6s3oLJSxcImqkbow1WWv+hB/k+/GudYVmsLY9IhsgYK+U7sOOfi
X-Gm-Gg: AeBDietv/m2JJYl/veBRUewBbPxEwF00TReHG5iRw8PvOA95f1pJC+36pNc8ldBJf+m
	gvHYu9tAuk2Y67Z4dZJgnAAU0TnZGq54CKHp5uuAhR5AyTJfVnbGv9JtoTgHsxEdpk5+TPwYMqb
	Be2zSUIcXLGYwT+YDu4qdUG96G9v30qpXn9qNFOSfM+BoFu29gxReC6Hg/JsG9t1epnENE3teEd
	MVvSXFoZ5+JVqpxpysbrlVJVXwbHxJioyx0qgxS4zerpUZ4fjI1zjZZ0tHU3lv+zN7zBaLVejgD
	KbG77o4zanuFvTBbfXjpQDz+Pd+z8pl6yec4UcoQD6YPKBHkkxVp29ZKoS+wAwuKeYE4liKOE+W
	+pT3gb5HFNU5zlWmuQ23XJeLof8gcy7mEew0qPUkfed6crE4XXbQWWg==
X-Received: by 2002:a05:6000:230b:b0:43d:7cb5:43b2 with SMTP id ffacd0b85a97d-43fe3db3150mr9934355f8f.15.1776514297241;
        Sat, 18 Apr 2026 05:11:37 -0700 (PDT)
X-Received: by 2002:a05:6000:230b:b0:43d:7cb5:43b2 with SMTP id ffacd0b85a97d-43fe3db3150mr9934293f8f.15.1776514296726;
        Sat, 18 Apr 2026 05:11:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm14049130f8f.6.2026.04.18.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 05:11:36 -0700 (PDT)
Date: Sat, 18 Apr 2026 08:11:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH] hwrng: virtio: reject invalid used.len from the device
Message-ID: <20260418080446-mutt-send-email-mst@kernel.org>
References: <20260418000020.1847122-1-michael.bommarito@gmail.com>
 <20260417201129-mutt-send-email-mst@kernel.org>
 <CAJJ9bXzhKTBx4m3-SCM+ccGd6ZhTXTAbRxKekCzidnXY6yXbWg@mail.gmail.com>
 <20260417202330-mutt-send-email-mst@kernel.org>
 <CAJJ9bXweZ2k+F5A7rOWSodzTN6UYOP3rf2oBbrVirOuof0tqNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJJ9bXweZ2k+F5A7rOWSodzTN6UYOP3rf2oBbrVirOuof0tqNg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xMKnv3hczNw56ARrNRFy4xoB56RWGe-VauqfF-ngB3E_1776514297
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Apr 17, 2026 at 08:47:09PM -0400, Michael Bommarito wrote:
> On Fri, Apr 17, 2026 at 8:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > Actionable meaning what?
> 
> Well, between the BLAKE2 pass and the fact that 99% of guests already
> shouldn't trust what's above, I agree that actionable doesn't mean
> much to most people, not even for breaking KASLR.
> 
> But after doing some research, I realized that SEV-SNP/TDX guests that
> expect lockdown=confidentiality might actually expect otherwise under
> that security model.  Still not a lot to work with, but more than just
> correctness in those cases, and those might be the environments that
> care the most.

Sorry this went over my head. We are talking about a device where guest
trusts host to feed it randomness, enabling it is already a questionable
enterprise for SEV-SNP/TDX. So what does it matter whether guest gets by
data from host directly or by tricking it into feeding its own data to
it?  It's all supposed to be securely mixed with the cpu rng, right?

I am not arguing we should not fix it, I am trying to figure out
the actual security impact.


> > Maybe clamp at sizeof(vi->data) then? 0 might break buggy devices that
> > were working earlier.
> > Or just clamp where it's used, for clarity.
> > And maybe we need the array_index dance, given
> > you are worried about malicious.
> 
> Happy to send a v2 with those changes but I can only test on a 1-2 TDX
> variants at home and don't have access to an EPYC bare metal box, so
> not very confident about your buggy device point


I am not sure why this matters.

-- 
MST

