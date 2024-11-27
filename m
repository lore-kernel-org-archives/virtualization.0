Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545102EB00
	for <virtualization@lists.linux.dev>; Wed, 27 Nov 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729661; cv=none; b=STvHSw33WpVh3N2+EtV/BUsZl1TCSjHQ9td0EPkK4inVkfFbwWKeXIiRBqPfmNJx3yxiM39+SEL5bUWBBslpNzxt7NBSy8RalCt339MwdYdv9DbNaHvQ5VW7o/B3s0z1Ed4h+if3bpgr6yixKyPGYb9RoO0u/EUONyLMQ1m21CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729661; c=relaxed/simple;
	bh=3cPCxD7H2a8Lh6owvh2XlsPsMo9YKelKbnsLwpIFa20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0a46s2rZhE8p9vhzqt+yDIHoCt1FYDAqaKDGl5G7UqmTsQXjmqKl6T+GbY0ZFc+OxjyscR+IP+n9MZ8ASuGyrXOu58XxZwcZc2IqMEM1NLgSoUNJgBJP37qmBnvKpInBi3RHPO4JHpp92R+0rt4e0gudQF4G44l8WImo75xlIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOngm8/1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOngm8/1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-211f1a46f7fso157865ad.0
        for <virtualization@lists.linux.dev>; Wed, 27 Nov 2024 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732729659; x=1733334459; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C10ZEuRraCO6elndBS5q/kKi7+M/Tzch8Tv1uSjbGZM=;
        b=UOngm8/1694EwYobYyaFiZ2199Ae1NJxoY7vz6xCVeRhum+HWJG/fvsC/ySFySFdjG
         VEaz/Pcf9KxkjiRigZi/haQI/nTp/zULbTpiQXF8NTPTPVZgZvZxHbpRoNV8K9bXTuNA
         Bcw2fr1FX6OGLMWqsq/0Mll7Elkp3F+3t1rHjI7VbBK9lAt6VzsFLTCNw87jSPwOgyxI
         yQMihKF60gPFsaeiLli+BcQms5c+03ao+mpQRD7t/LKtHaTXm6fjayoSouGjdISKQd0N
         vg6PRirAkLQHXGbjlLIWZF0UWisBBDth242aI7+hYqLueNNk+VPN45D833jOTk7q2WUq
         qShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729660; x=1733334460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C10ZEuRraCO6elndBS5q/kKi7+M/Tzch8Tv1uSjbGZM=;
        b=jZ8whhqpWLIG1xibYa7x331bKvgQ5sXlvwN7ppB7akNBLc6y3NZUyuM22+uQSkQGDb
         yRX2VdV2q8h6fDSZTFMsudsnbXxScHVhAyJo1NOVonp677E9MfPzpcS5cwKS7bVp4q2R
         w/m1akEvRI6Ml2uCdk6VdU85sQAhpRfMYnrXO25eg+sDCwbBYcWYfBZG9a+BwoqKsO2w
         jTJbtxG7chzuheyUeu/c0ovHwkFl6OFc5t74RBSqJJ5dun4qKEJTFHILJ4D1aaHNB017
         mtRInZHb0tM0KipamFw6cY7Nnr0jUeIrrpcecU1P9N5TpfHXmmnIbzFo4TUZhCT+D7SF
         qVPg==
X-Forwarded-Encrypted: i=1; AJvYcCWLZaGox4yo96PlFWpQHs/XSq5ful06b/YfkQKRoCAvOOBUTML74ndk+L+MmQEDgqlw5WEbUWp/kGfPJoGzDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9ckADv4rLaHCTABLa8P5guS7b//PX9Pbnh39J73IhhQd5Ryd7
	UqIpgGhb6urv2okkjrXS5INMF9xCOeVo2abletqjwVmMOa8OlgnFpo9hhKFCx1uYGu05mFactfI
	nRrpQtdrMCGHexNO12NSqbKjJyo1wrOXVZnWZ
X-Gm-Gg: ASbGnctVnccqQh7xSgF7REu3lgqHLH8f12geeZUwLtxQlMkT51ybnJXa6TnUmQq2Kd6
	pfOQihLfL65Fn2CrGQoKSAiLJCvAjsSbLGNt5DdYLrrmNsCZreSWuo4IfS5HV9Rt+qA==
X-Google-Smtp-Source: AGHT+IEWj4m7+heIVmeyDopSriS2JGtzJfSKycg033XDM9P61gMKjT+xPWPfu26TGwPqoI2Oh8nkmAXZluulyXqzu48=
X-Received: by 2002:a17:903:440d:b0:20c:8a97:1fd with SMTP id
 d9443c01a7336-2150640abb9mr2258805ad.19.1732729659360; Wed, 27 Nov 2024
 09:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-2-yuanchu@google.com>
 <Z0aeXrpY-deSfO8v@casper.infradead.org>
In-Reply-To: <Z0aeXrpY-deSfO8v@casper.infradead.org>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 27 Nov 2024 09:47:22 -0800
Message-ID: <CAJj2-QEq5xj7JHNS_QaxWXq0e2KDMX2OSw5rGfYeGC4+X9gx8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mm: aggregate workingset information into histograms
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:22=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Nov 26, 2024 at 06:57:20PM -0800, Yuanchu Xie wrote:
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 64c2eb0b160e..bbd3c1501bac 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -470,9 +470,14 @@ extern unsigned long highest_memmap_pfn;
> >  /*
> >   * in mm/vmscan.c:
> >   */
> > +struct scan_control;
> > +bool isolate_lru_page(struct page *page);
>
> Is this a mismerge?  It doesn't exist any more.
Yes this is a mismerge. I'll fix it in the next version.
