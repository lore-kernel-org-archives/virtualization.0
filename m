Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703803A9018
	for <virtualization@lists.linux.dev>; Wed,  1 Apr 2026 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031704; cv=none; b=Tmk2SM05meza8akEcax83IpTg7FVtZEutm6ylFWjCRNOtKwOCnOvnLKmN004u6Oh1LfT/xrmPndUPzvQH+myG49KaI6ES3hWABu/pSHemLiPv3bv2DzYg1fkfTGrfWk9wyyWe8ney1YFnnTlMwzHOu7zpk+ifHtzjNtbNY0m4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031704; c=relaxed/simple;
	bh=mE58UPyJl/FiMLUP216GucoGkRmpDm4sFWboaotFA54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P75FGWBtM0mR38ddDnEBNtVTTnR7NF6IZb8Ez659OpPvadkUZ9G++vZdPiKj+FpDluduk6wPVNCWk5iP0mfFpH+6eMq3Awxk7MeD4utK5RHcswEkUtjmm+cjQQaOfsUzxANPWl4OL4DraIt4erFYyHjudikv2qkip0FptIaFawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L85HWBCT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L85HWBCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775031702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFlf2MdDkifmThFJKZCcvKogFCBxiEgmNxrJgdVh+Lg=;
	b=L85HWBCTk6f5/pxyVCl7a9p+Lke1Cl2jSn7fzq8WJfBOUrCA//k5PNXOxz/O/ugm2mUFkB
	k9wYWP2R9Xr6I0EeFM+rLLbUFwfRh/qcvTHKFKaxp/GrpnUe/QEiXOB4UAiPP2KYD8pgsv
	tWu8BqzAdRQk8Nf8pg7YflDgmvLoBgY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-tRPo2fdxMpuk1QbffvA4tA-1; Wed, 01 Apr 2026 04:21:41 -0400
X-MC-Unique: tRPo2fdxMpuk1QbffvA4tA-1
X-Mimecast-MFC-AGG-ID: tRPo2fdxMpuk1QbffvA4tA_1775031701
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48887ff8b73so761535e9.2
        for <virtualization@lists.linux.dev>; Wed, 01 Apr 2026 01:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775031700; x=1775636500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFlf2MdDkifmThFJKZCcvKogFCBxiEgmNxrJgdVh+Lg=;
        b=pu5cqZu35ZviaGyGZz81r/jrRtnhwV0fwdY8wjbf8pK9VxMWfzmMm41YjkKubLdXb8
         lEavPpJnd7v5bgIRnqJ/WYVfpfyMqY9YR55KSyf8d9bMtfV+Kr3MrjRv+uZzhn8nRV6T
         GVomoMh0bizQhrKmbAIV5X15ZleE68mMgmiibNO8VcZVGgH4lrnmQqKhPF4OsZQxsdMo
         4tIGdgmx1WDJXoxJKWCcH3EAJZv3BGu6g00YZZmaUBGjSPHk6mExVEMLjcB2SDuolEJA
         C3K7Ku2RT97WcnrVQapEFf+IPA/MThfNwIDfv2mfrUuXqBka6Ge7/+vYtmgWjP+N/M+Z
         WedQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG6HunB7NgDknf0KKI4UUSv3sSGCsurLkeb3nkkyGdT6gF+tGtnFwNEUGkcEGdUaQkZKL0WDItY2Qi8+Zsaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxQeb4+eCskT2MzFPlrg341gdfzHZwb8xQCppoYx9N50B6B8Z2
	QvKSwC9UjXcqWih6gGRh2TiJ5bf1y5YB9SyJJjlhncPdn2IH833oVy/GSId96CITHVLyZXlZF4i
	8qbAB7zHLEb+LcoRTbT/YZXefWmKPvgA+8e/bSgDfH52uB6i1Fz/1B1pSLifJ+Dk8uLR97IYIey
	eT
X-Gm-Gg: ATEYQzyNya3TN5Fy2b8gJamN0lqrooE0+cytmF5+jzA/5jnp5D97AcCSbI6pzQrgiXf
	BeoL+wp3hLyccbG13Dx7pwwJrU+zHy0+VOPMkIlNqxsqRV68lRd7sPhDsWl3Dgh4qdthoPQ+Tlr
	YVQODKylBkTGLoLEXcwp14U74smbMNbz5mtWBHMySJpWSQUrHkZ0wU0JfdMZcHMh9iyRvcNd0ws
	vk1BVhLck+4pY8qn+rQz4Yk/Esn2LcJJ8idXPfHRaRJ8WVfyAZMGpJ1TKoj2OSBedGSDDqN+nqu
	hXBMbxWxe/VmJGX1tk9Pyp+vBXQBSwwO9b/PrU73Jeok+xmfl08s/ZSO4bJvBJKEdUBfNKOgeqq
	fOK2Tiae7LtaSRE38
X-Received: by 2002:a05:600c:8718:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-488835c0534mr45597815e9.31.1775031700291;
        Wed, 01 Apr 2026 01:21:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8718:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-488835c0534mr45597015e9.31.1775031699827;
        Wed, 01 Apr 2026 01:21:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e29b1sm32050464f8f.8.2026.04.01.01.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:21:39 -0700 (PDT)
Date: Wed, 1 Apr 2026 04:21:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Srujana Challa <schalla@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size
 to NETDEV_RSS_KEY_LEN
Message-ID: <20260401042119-mutt-send-email-mst@kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
 <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
 <CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
 <68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
 <20260331104737-mutt-send-email-mst@kernel.org>
 <20260331180522.64ef9886@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260331180522.64ef9886@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SStuW6t4-Rj_a8T3A9zcLqSG5jPaYG65T-7wvJ4A7tg_1775031701
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2026 at 06:05:22PM -0700, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 10:48:41 -0400 Michael S. Tsirkin wrote:
> > > > Thank you for the feedback. In net-next, NETDEV_RSS_KEY_LEN is 256. This fix is
> > > > also intended for stable kernels, where NETDEV_RSS_KEY_LEN is 52, and
> > > > I added the message to make clamping visible in that case.
> > > > I will remove the check and send the next version.    
> > > 
> > > I'm sorry, I haven't looked at the historical context when I wrote my
> > > previous reply.
> > > 
> > > IMHO the additional check does not make sense in the current net tree.
> > > On the flip side stable trees will need it. I suggest:
> > > 
> > > - dropping the check for the 'net' patch
> > > - also dropping CC: stable tag
> > > - explicitly sending to stable the fix variant including the size check.
> > > 
> > > @Michael: WDYT?
> >
> > I was the one who suggested it, the extra check is harmless, I'm
> > inclined to always have it.  Less work than maintaining two patches.
> 
> Give us an RB tag please and lets close this one? :)

Oh I thought I did. Thanks.

