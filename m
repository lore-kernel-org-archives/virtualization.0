Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E23D45DE
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174585; cv=none; b=qGvBhw5QtRd5dwnamM8c8ld2WJucOdknY/EaXw49legRofBcBSmYpzr7gkO1tZvYskdruhl/KB2HehArcqiAR0cyadGGMOahtvNjLt/vs9xKrRiShZYJMrWHU28bLnsDCAe5cTm/NpsGJdXGq8VxlxXM7C1i+7xeSPTDnGRNQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174585; c=relaxed/simple;
	bh=inQjxgWwPEtT4CnPw+fCJAJFNMKy78lOn5LXLW2oVNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VFgfdjKYnxzt88YstDvDLEO/J5C5TahVSeyi9TfJjdTRsMg4ZE7hdqL8Obx0Ld/ziiqKScymeOUn965oO6D81vHYQleE9IW1BOYyW+iUpqirtMQEKpZ5bv9zIDpixzbwdNjFabOwyVf1GdBqPUHNaAnrKPNilroYagQ4hzYpowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJtZ0Fcs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJtZ0Fcs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781174583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eTU8IEl2ECfz/odKayZYUlnGxNgbfPhvdxEP2MTzPP0=;
	b=dJtZ0Fcs5ZpJu6G+qm075Zl4ux/UpF8Xv5bvrrZ9uoE3J7h+aXl0E+q7GbDn+HHRSiFxsc
	yo0rZHyKkH8epkUaX5iw+PYYD43IsnKoohp16w5mYda4w5k0n7LJcqtcfqV18YZyGKpVgd
	Hun9q8dO2xgMWeIO/+HKHASbD0/sNrg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-9C3vli77PuSNtYl-tm6_hA-1; Thu, 11 Jun 2026 06:43:02 -0400
X-MC-Unique: 9C3vli77PuSNtYl-tm6_hA-1
X-Mimecast-MFC-AGG-ID: 9C3vli77PuSNtYl-tm6_hA_1781174581
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ae3bcf4cso37021065e9.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 03:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781174581; x=1781779381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTU8IEl2ECfz/odKayZYUlnGxNgbfPhvdxEP2MTzPP0=;
        b=FV3Mza/bynMBXRqweChU+XO4rxfZhDO/EN4IClcQFMyD3fVpgX5d8d9qfAvvINIpNB
         Ju26fV3NgMQbPTGg2HOoYr6bXyJxZKXR64rDXNyCCui/exlmrwvHrq1k1yuU0eeKjVTp
         oCsnGMVUD984L3kgkywOgY7ZUptOnDCwvfokV15HcuqTItb4qFTw7gj6IxzAnis9PKIh
         vd+qXPbWWneNSq+6TlBhFYCH4MzSVKi5XhbZxNzQROeTaPHyG5+ocuXawdoqnJ+4DkJR
         oNykIHBf0Ys3hDCDFtiNm0zJYKYD2Q2k2LJeUVyj14egXeQFoj/CSPEtNK21Jnv6tOhi
         LidA==
X-Forwarded-Encrypted: i=1; AFNElJ/UiB3xlHc9fbBKr95/CpaaDt1s0Lt/4Zf0Dc5ARcnB5kp5NMkFZWwjP5en6QbmMSI3FDRCzOiXCezGcR1kNg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0sWO42VZhlaG3MACG0CD/5nckcEXQkWj5rcVS4bhDPneXESfN
	ceS2PPlIBZCRJPJQ39daj/h6ftfnGw4Rq7iX1lxLz+H94lKuzNfeKk9E7SKQOqyZFJT7iTRJc4F
	Oj5hW+wm/IZT8nbL7lkrwR8nud45qOdhPf24foB237yka2OEFhLGRyclJlzIZMc69gfyTNEz/nj
	kr
X-Gm-Gg: Acq92OGwpzxS7V34UlPcRtuAaeFF8SGATtc3aGBCnirt5AaD+BkKEzTZubRbgCG8LyH
	SlyTVHchgYyrPCiz8yp3qF1cZ8TsRYjuWd5dwed8fm3SdKG9mDUBPtRTUQa2HdTqL/gy0L//Uom
	Z9og43zhE2k2LkiR/7dUxgSVV8e2wPQzBPqUt5T4XKzt6aMAEIm66YuBzzrRaUKSUeLWAl7OuK3
	tv/cl7cwFE2AlzPntO6hVkLPWkrhXsiQ5RU0EmJedNbJX/bo0eyPufFfl4iSvtTtNPESCwCUa6N
	uz2mKa5Jmosx6DyaQ0+4xj+0m6T7iGoItaB916/9ikH6Qhqm1djlub+3g/LoUWoEgU3SgBUAk2O
	LWYrytadxecIyUwJ8+Oy4ct8aiDS7bLf+s9/715Fq5B67+/9mLq3R8w==
X-Received: by 2002:a05:600c:b96:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-490e55baa3cmr26317075e9.6.1781174580808;
        Thu, 11 Jun 2026 03:43:00 -0700 (PDT)
X-Received: by 2002:a05:600c:b96:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-490e55baa3cmr26316475e9.6.1781174580281;
        Thu, 11 Jun 2026 03:43:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm84495116f8f.23.2026.06.11.03.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:42:59 -0700 (PDT)
Date: Thu, 11 Jun 2026 06:42:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, Kees Cook <kees@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, torvalds@linux-foundation.org,
	alan@linux.intel.com, tglx@linutronix.de
Subject: Re: [PATCH v3] hwrng: virtio: clamp device-reported used.len at
 copy_data()
Message-ID: <20260611064040-mutt-send-email-mst@kernel.org>
References: <20260531142251.2792061-1-michael.bommarito@gmail.com>
 <aio83ZWadVTiuNpR@gondor.apana.org.au>
 <20260611025916-mutt-send-email-mst@kernel.org>
 <aipn8sIAQ6Ai2sax@gondor.apana.org.au>
 <20260611035035-mutt-send-email-mst@kernel.org>
 <aipvZhfvdtRxOQm0@gondor.apana.org.au>
 <20260611050731-mutt-send-email-mst@kernel.org>
 <aip9nja-Oz2RxkWi@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aip9nja-Oz2RxkWi@gondor.apana.org.au>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 81RujCALRRovdeSxALJp9Y5zc7rsNQR9w28B70PJcGQ_1781174581
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2026 at 05:19:26PM +0800, Herbert Xu wrote:
> On Thu, Jun 11, 2026 at 05:10:32AM -0400, Michael S. Tsirkin wrote:
> >
> > data_avail is under hypervisor control
> > 
> >         avail = min_t(unsigned int, vi->data_avail, sizeof(vi->data));
> >         if (vi->data_idx >= avail) {
> >         	vi->data_idx = 0;
> > 
> > and maybe this can speculate past the if?
> > 
> > I agree, this is all speculation )
> 
> Either it is vulnerable to Spectre, or it isn't.  Adding nospec
> markers when you're not sure is cargo cult programming.

AKA defence is depth programming)
Alright we can drop this. No biggie.

-- 
MST

