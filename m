Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56758259C9F
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455041; cv=none; b=WiTPr7VzXMMhKJ5bBGC1BaDgvkxX0rdZ1CMb8X28rxp530RrPbSVeG1qU7xq9AFkppCxgNOATA3y+M8hZZ8XMXBcgoPOJGFcGcHTaFHDIMipmFUPEH+4rndbe9CTouM6o1v5cAnnHwfVeyKqgK4TJKR7WMKov5tWhYnlP6H+YpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455041; c=relaxed/simple;
	bh=8N56+TGylsQY7gFnKtTRVknM2MRo5gOpmc2AwA02aio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p/pHsUdQFVSav9qCtv2qc5iz4N89M01NCFWG/GmWTK+S5AFndSdnpxmQfVDMXkohaPrM2+sqU0jPreryVjsAQeXWj7YeulRau6mGY8LuBFdD7KMFwgKMhmbRkzdmrXDEGpA9+VCrqllLP7Ae75Lc6lKskTuuasz3hp95dRJbaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-mHYJOq7eMvCE0FPWJEg-LA-1; Wed, 02 Jul 2025 07:17:17 -0400
X-MC-Unique: mHYJOq7eMvCE0FPWJEg-LA-1
X-Mimecast-MFC-AGG-ID: mHYJOq7eMvCE0FPWJEg-LA_1751455037
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a6f6d07bb0so98289791cf.1
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 04:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455037; x=1752059837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wldKfbxnDfMUjnGQMZxO+EJVdKQ4uPilVamWozU75kA=;
        b=cqrlePYhQFRKV957ep0uh4qULTY3DCxImU+0wbCBfTywhlZ6Ofsdtbh5pp0AKacman
         /a89i1VjvTMKomwte47pYlUMLNyS9NAX/oPt9M0piLwKTAlp8h8XtfNmyNtYw52xuxuI
         u8x2G7H6har2YAUiYuvtUFJ2N2dXNvWHRDpRPjZXXuvnvWZaN3D8oLTJOYV+BjclgvLj
         itvkLt76yNjklu0pCpbiQbfS+98lEm2ATV1U18nh9ixhxwKUsCzG1JCAXkh67Z63lGlH
         JaMeOeTQ6WLyJiLmAdfLKA04F97OIs7h/fJqXCCH21YoeuQPIpR+n+qyIh6+VqGpTEXD
         tNxg==
X-Forwarded-Encrypted: i=1; AJvYcCUAoray6tZiTrJ2Tei9xbiOGgqoZzZde7Qdau2Lh2JQ4vmrH2Y+cfYTWQ1e5jtcSxqmnguasTYyKj3rbyucUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIymUeYqFd4hdN5JClpP+voC2dFB+tIMCwQcX6k5vhsnZEl3kz
	U8WsjXcCNh4IuSkT4ccdzomAO40rjdyjaazrX5cMJCtv4ApA0S+E+ewWTFpIAi1v8aSkPgbC165
	KcTijAJsrx7VQv7K7T3WoFDLUbVARsPr1IWx/XsG+745ZXZEswKF9b1aLVDoDr8AzuVI9
X-Gm-Gg: ASbGncuzdUNaBK/bcEulvwKFvojDNoH2pBZhXnDCk8PuF20W5x8CEyuXPSTZLlBK5Ym
	2vtu117Dt87utNo7l58TZiSEZFOLxDjDz8vxImwBvTZqMatfN5mmnY/M07YRFSN/MiC4GztwQ5Y
	P7efzrMnsLcZtJFwxHyM1dc0bZUgOpH7YkRY0GljEJhkm1CFm1Bv+2c7TmM6SFIdTiO9HkK7+QN
	fewBO0w7EYx/61u2ZrI4DZVKN6BWWhVvg+xha0IxQ8a2+RjqWI2eSuQnlMZVOfJ/dtSi+Ls+xXr
	o5ZVidTISQb2fIXn73Y78HYH2kYu
X-Received: by 2002:a05:622a:4892:b0:4a4:39a6:93c4 with SMTP id d75a77b69052e-4a9769152aamr42028561cf.21.1751455036585;
        Wed, 02 Jul 2025 04:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyX529Bjf/JHbkZ9z4pNDGbh4lbiaMrqb6Gqb4GFhbQWEzxXEP/dakYHu4BYJfkNuEVi7vkQ==
X-Received: by 2002:a05:622a:4892:b0:4a4:39a6:93c4 with SMTP id d75a77b69052e-4a9769152aamr42027891cf.21.1751455036019;
        Wed, 02 Jul 2025 04:17:16 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d8acsm89956541cf.63.2025.07.02.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:17:15 -0700 (PDT)
Date: Wed, 2 Jul 2025 13:17:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] vsock/test: Add macros to identify
 transports
Message-ID: <hv4ufpmyuyzreh4n4tofco4mlbge3cqvuvfnpadek4scov3jyi@f72cscihqcsw>
References: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
 <20250630-test_vsock-v5-1-2492e141e80b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250630-test_vsock-v5-1-2492e141e80b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6xsdLcCX3u-6T-7GcqqTuGEDPdBu_6b2bEUMqc_WgfQ_1751455037
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 30, 2025 at 06:33:03PM +0200, Luigi Leonardi wrote:
>Add three new macros: TRANSPORTS_G2H, TRANSPORTS_H2G and
>TRANSPORTS_LOCAL.
>They can be used to identify the type of the transport(s) loaded when
>using the `get_transports()` function.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.h | 4 ++++
> 1 file changed, 4 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 71895192cc02313bf52784e2f77aa3b0c28a0c94..fdd4649fe2d49f57c93c4aa5dfbb37b710c65918 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -33,6 +33,10 @@ static const char * const transport_ksyms[] = {
> static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
> static_assert(BITS_PER_TYPE(int) >= TRANSPORT_NUM);
>
>+#define TRANSPORTS_G2H   (TRANSPORT_VIRTIO | TRANSPORT_VMCI | TRANSPORT_HYPERV)
>+#define TRANSPORTS_H2G   (TRANSPORT_VHOST | TRANSPORT_VMCI)
>+#define TRANSPORTS_LOCAL (TRANSPORT_LOOPBACK)
>+
> /* Tests can either run as the client or the server */
> enum test_mode {
> 	TEST_MODE_UNSET,
>
>-- 
>2.50.0
>

