Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A0381B1A
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074698; cv=none; b=BZueBXGMltaa9h2TiFMziOFQlPsAA5jDrlp1mUygfgWTw/FxW/mkZSNubG2dOt00SCSwz3DbIuGxsH/c3k7YTRHx8E3PqL2hkOpAKIT3FLciDQt1/yJeBsFlQYKBNDz6kkjWCBV+eMA7yUAvs8WxnqynDgzj99QZwFqp06fO8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074698; c=relaxed/simple;
	bh=sIOsSzK+02Njeg/G3mjumYcc+3JE2Q7ShVEnlK253tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D2YbfVfdLdTb3S9n0DPoIQbtk4bWvdgRnTKPQ5bOubHxjd7jd7TzPuZGxCXU9mRmkFqyCtE4XPqecBHBGNrhJaAE72UIzeVyg8J5fHD5CLuKwDWDysXY+BE9WcqVcuU0/nFJZocuyGTbFHmklwwGDh1Qu0b33NyOj9S3lNDY7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAv0GfTc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAv0GfTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781074696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M3o+dJNDhBpE5vvIlT8AjaOqRkYI2j1GcVWBSU/Kk9g=;
	b=KAv0GfTcCS049413ikrXy14JWHsK+NRZUMwGvh8oazyDaYGI4ccevx/4WfOl5vEzOhvGXx
	RuZBNoQvoRU6RCgxmPkhW936ApeyQCGRIfTSP+oS75OAqmzRk4ybvwgvR25LDysjS4imSm
	T6rU1weeZz5A2Wv7VyCvXtDnC8TVubA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-thm_3a-dOSqNzAf8Tf5AbA-1; Wed, 10 Jun 2026 02:58:12 -0400
X-MC-Unique: thm_3a-dOSqNzAf8Tf5AbA-1
X-Mimecast-MFC-AGG-ID: thm_3a-dOSqNzAf8Tf5AbA_1781074691
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490c56e2576so44177825e9.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 23:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781074691; x=1781679491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3o+dJNDhBpE5vvIlT8AjaOqRkYI2j1GcVWBSU/Kk9g=;
        b=lPMfJMDjjDAu929nqbV6rWa9m/o//qwVokkOCCSTeGb+iosvjPs7dNkYAVVOWbNtXQ
         8+ZjRyNV56P9FzrvLVNCq9gkyb1XLeIdHsF5poXrjVXVgEwxNdxCz34f15l3B5Gw6B9c
         Qnkj+jVSqBH1uAO5QybzBjqZo+CsuBq5He1StGAVvzQqMR4Br6w292HPGLQYlBi0f6J4
         4j/P+YurV2+ecUZT6Rs5wrd+6GicnZDnK8pfV1IsLRPWspBwT4dQNQqGLuwLVtLAMswY
         Kni/rXxeuFwDp3E3tWveNE7vKnpaZyXylnBSSj+OpGj6jO5jFb3sks5Fyw+N8OPrPvkY
         ljBg==
X-Forwarded-Encrypted: i=1; AFNElJ/Qwoq+OrApYiLp6AvbCJVldvrqqFSREBBokVia9BzhHw6HU6OxAr/ejNn7owkiY52IQJlJ2vU5W3ARPJG1aA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpGTprJUWGABs06A56aAQ9pbQtRDCAxbpt1vlEUvqIAutPhbqz
	cojThQrrfD3FMIXxIgkzyPa0AnN1222adtMwvE13qZWmvLAT3j6oAYQlP+lZFeBMVz5gYWqE0vM
	3hqCiARaPwv5e78YwQa3IzzWNSrjWEuTjwZBeQfOhwVRjVjj4DYh3DdW0/oUU59v3hsTz
X-Gm-Gg: Acq92OG6YncsVy8v1CrXp/Zwu5r2z0RmXcDLsUzhK/Oh+ab+j0dFz3sk7KX0bK7WyGF
	MbiitTCO0s3ZnNgDC/LbQ84AUr96YDcxpiDFbpsk88wtYE3/Bivq/QBDPSWLq0R/6dgStgfYvkh
	rc6D/HEtzBIxIgSwIcS12h6GTbSocGYWEd3uigtKHu50VijalZGTmqSrtU64hyGYjcoJvWkOgMP
	SA8JzuusaxmuqTnRRbuVkwYS80eCcwWxZ5uGqkLTjgvBvNrJi/Q/pXUNULDAuHjNicfec48wjfv
	umxZcbWjYgCFnnq8Sd3rG5YF9+3E9ni+9TjJajww5vX8Xh6cAG9tnFofkpcfcEKKmd6LMeCpgly
	DkBt0XhDzKimPnQgunu/nToBu8pTaODnAi+5ZXJQqgojyHUI8eQpFMQ==
X-Received: by 2002:a05:600c:314e:b0:490:9d1b:2022 with SMTP id 5b1f17b1804b1-490c257bb25mr377753335e9.13.1781074691338;
        Tue, 09 Jun 2026 23:58:11 -0700 (PDT)
X-Received: by 2002:a05:600c:314e:b0:490:9d1b:2022 with SMTP id 5b1f17b1804b1-490c257bb25mr377752995e9.13.1781074690891;
        Tue, 09 Jun 2026 23:58:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46059346676sm8291609f8f.26.2026.06.09.23.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:58:09 -0700 (PDT)
Date: Wed, 10 Jun 2026 02:58:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Message-ID: <20260610025755-mutt-send-email-mst@kernel.org>
References: <20260213154051.4172275-1-arnd@kernel.org>
 <20260610012421-mutt-send-email-mst@kernel.org>
 <0134edd1-de51-46b3-9ea8-bdbcf48b878f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0134edd1-de51-46b3-9ea8-bdbcf48b878f@app.fastmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WjYNMqfj7DaXOPkKPtt9novPOLTiXAKA-N8psATkaQA_1781074691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 08:54:59AM +0200, Arnd Bergmann wrote:
> On Wed, Jun 10, 2026, at 07:26, Michael S. Tsirkin wrote:
> > On Fri, Feb 13, 2026 at 04:40:46PM +0100, Arnd Bergmann wrote:
> >> +	};
> >> +	__u8 ready;
> >> +	__u8 padding[3];
> >> +} __uapi_arch_align;
> >
> > what is this __uapi_arch_align supposed to be doing?
> >
> > It compiles by luck because gcc thinks it's a global variable.
> 
> Sorry, that should not have been part of this patch, it is
> part of the series of changes I was testing when I noticed
> the problem here, but that other series is unfortunately
> still not ready for merging.
> 
> The background here is that I'm adding -Werror=padded to
> the UAPI checks in usr/include/Makefile, in order to find
> any instances of data structures with implied padding,
> and then instead add explicit padding using architecture
> specific macros. In vduse_vq_info, this includes a final
> 32 bit of padding on architectures with naturally
> aligned __u64 but no padding when __u64 has a smaller
> alignment.
> 
> The __uapi_arch_align macro in turn is what I add to
> structures with optional padding, in order to be able
> to reduce the alignment of a structure when building the
> kernel with a higher default alignment than userspace
> (e.g. on m68k with -malign-int).
> 
> Removing the __uapi_arch_align is the correct fix for the
> moment. Let me know if you would like me to send a
> replacement patch without it, a fixup patch on top, or if
> you will fix it up yourself.
> 
>      Arnd

I fixed it, thanks.

