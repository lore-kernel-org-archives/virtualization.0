Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2CD1F1301
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820687; cv=none; b=dfULFXcGl5hjDexm7vcVhex1w+VUPJ+caWix2ItPidsUOp0i4Vs59+eHWl4wezSQK3xdAG3iIqfAMr3fTHEHKJlHdEonjJnBCraYbMsvYprQCOIz+2c3YygXIZwVO6WGfk8DUjlq4aZSPAl83nV+hJkNJf6bMHbYX/eeGog43nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820687; c=relaxed/simple;
	bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9Ut0RvpfRFfz5Fq7xWGKRQe0jYWjeC99utUZiMInQRdC5HqgXjQ3ADZS/WAJBBB74KGDGxcF5D5acc8x50yDXLVrbImKopbNUTp7oxcc9DuuqrNKON9cLKesZNAI1j7ptdRsEfC2iBi/keib1/R+xnd48J3jRFX4aYCASSE5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ew94nFNE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew94nFNE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741820684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
	b=ew94nFNEm/63ziiwzXMo2kK9h4sBwb3yeKH4xZHZz4nhFRuvbsZqJVEQruqO3jK18ddHYU
	QqmdBuLSm+iigVu8abFttIOhZpQO6Ri7LTdIPFREM1N4EiThH8kOIjnOmoUlPZx/ziuf6O
	10vlgc4iPFpooDwjhKMGJxqwSkyrXbs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-S2peLcGDNVm2g895p0QiAA-1; Wed, 12 Mar 2025 19:04:41 -0400
X-MC-Unique: S2peLcGDNVm2g895p0QiAA-1
X-Mimecast-MFC-AGG-ID: S2peLcGDNVm2g895p0QiAA_1741820681
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f6d40a61e7so5355437b3.1
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 16:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741820681; x=1742425481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
        b=C68PZh96sLBy2YYEn34nMJArt7q/3/t/lOKMqbGYsLW0+ntHgaZlh5w0aHDRkpN+/W
         ST2RUPmRAspgDjzoteGnR2IgyC4hX0iN4kYic2w2k/8oZt2aC2JZ0dET4Jg2AyzlL5w+
         NBiuM9wYVvDyadeVV+ea84Lni8/5w1RLMtstSwYT3MYcn/tY9mRJmOjeIKuOaESWDPpg
         dNCxLuVN+xcgUY2nAn9G03yjh/91XUP7X+Wl3nbFtm4/a98kQDwrBnxYCmN8bjZE9wuX
         oJGLvB3jZyt6RTR0nw17DPwLS+vURrQdxoM4gEAXlPTqtnQfsTatbf4oXrqnr+GKEvyw
         nMlw==
X-Forwarded-Encrypted: i=1; AJvYcCUY6gqsM2VF7bhbCW3Voe9XA9lyWvL6S8258AQyR1VBI0vnm78e/Kroueo541sfTIADKoE1y/v/bmuAkthDvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ/MRtCTvzJ4ZrUbDAOsFMeFJYEF9EQFDd7frqPZEw3NvHOpev
	ed9TubSJSllxVkvdIsiKTKitJw8O7wgrXd61L4pBnyvCDFGyc/y/1Fmg4xV/8FdURDyrdhIP5Aw
	OEnm6lIQzvjLkg2KcheccuxzbvwWvKqGgccEa+FU/SWY2mgAPNQ+MVhynLkEPMWPK7j4jpnpAB6
	e55WotbHG+bRpJD2j2jUVLPfgtGKNSCzuIgGa9fdg=
X-Gm-Gg: ASbGncvGzssdC+QqWCwp0ss4tItzmDDHJvzijqVCiauZy0BC2YEC8xdsCiSMfXkcrEL
	hR5BWNlXW1+ieTicXUSw80TWG0pdYyQcvCNHzl6TSpeBQa7ramXKwG1jTTSLu8JfbwKk0g9OiV9
	rFfFDbt7E+Nm0=
X-Received: by 2002:a05:6902:2ec3:b0:e63:65bc:a173 with SMTP id 3f1490d57ef6-e6365bca293mr20489043276.41.1741820680975;
        Wed, 12 Mar 2025 16:04:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE29IOsL3if064ONRlZf/bCswPuk7JbIN/+ScTtHA6PhUNFhrt31PPwWl6SfPGyM46nmrjRUH8DQbWz44H/+M=
X-Received: by 2002:a05:6902:2ec3:b0:e63:65bc:a173 with SMTP id
 3f1490d57ef6-e6365bca293mr20489001276.41.1741820680678; Wed, 12 Mar 2025
 16:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
In-Reply-To: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 17:04:14 -0600
X-Gm-Features: AQ5f1JrCck7ZrLXTjsNL6uP-21nbhhEyl_MT0WXZGBOwpNadq0-oKKZGcnVqKd4
Message-ID: <CAA1CXcCv20TW+Xgn18E0Jn1rbT003+3gR-KAxxE9GLzh=EHNmQ@mail.gmail.com>
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: David Hildenbrand <david@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OtvwH0qJc1h0Wrv9-NXHf7oKZlaKjlFZ749fw_SbTN8_1741820681
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.03.25 01:06, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers an=
d
> > expose it through /proc/meminfo and other memory reporting interfaces.
>
> In balloon_page_enqueue_one(), we perform a
>
> __count_vm_event(BALLOON_INFLATE)
>
> and in balloon_page_list_dequeue
>
> __count_vm_event(BALLOON_DEFLATE);
>
>
> Should we maybe simply do the per-node accounting similarly there?

I think the issue is that some balloon drivers use the
balloon_compaction interface while others use their own.

This would require unifying all the drivers under a single api which
may be tricky if they all have different behavior
>
> --
> Cheers,
>
> David / dhildenb
>

