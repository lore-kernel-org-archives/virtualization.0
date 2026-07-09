Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17240E8C8
	for <virtualization@lists.linux.dev>; Thu,  9 Jul 2026 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594728; cv=pass; b=tG09jj6i0zydpVdFBh/Ta9IyTvaoOJEn/0Jdn/BrUJ1VNQ8H1bbLB+0CKnXO3YWM9TUqp+UROxCf/5zMlJSX0ZGQvBhq5cnKiFHh+m+ZoAOQJ9Whde4E6Won1HicdNiTspNxVtbeFJpxNwFNG/KP1TIOQPEPwuUjLiicDo7rWH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594728; c=relaxed/simple;
	bh=YYgxP5/kCHxFjRmS9qO2kcoV2ax4rTAnDDio/UAJdy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppPQwD/MlqW2o7WhsVw55scspIX1+1jl2gr4VdW2JERdNBeZSaEB3ujIne/70otZkvGXErDV7NoYiHkrtz2Xjx2u9e6R/aHiWmYiEta99ZV99pLRUg0hqAqnkRc3wZYSgy3zQS3ck8d+cFVcJKbBEar67PjnXqUi1rcYZ1wplos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARP7IyAo; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARP7IyAo"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7ebd88be784so863148a34.2
        for <virtualization@lists.linux.dev>; Thu, 09 Jul 2026 03:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783594709; cv=none;
        d=google.com; s=arc-20260327;
        b=a6WPOq1UGzMD0gixaKjdAe38npq6Y4bEHh++c0GhV+BcKEm9lJVwR7WNIDhBoSbDJ/
         Hx4iJsmP8p6LuhViPnP0laDNRnIvhYNa31AWS+7q7Xsw53TsQxh8B6LqveoUbUsmHR55
         F+Zf28DMGBI2kiPgZZyPkhbf1MNXwUh7MizvFOyLxpvoIASxz7eBeEelFMT8DHPFD3G1
         j5tKVBE1aYBYVDUObHs8fV0IBPt02UTYdv7SQfdMPxrjWpGDJNDMBUMV/P6l/nOA8BWk
         KOFeYMjKKVREvp9RLcM59oaJSx/sH80BOAA7LSyc9htD6ae/GJRVuRRRg5TjQgbY706K
         pfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B3IX2AtOXDdpt/3yHeSv69G4RZRiHMSHTQcrM8/wpyQ=;
        fh=ZpIs/Qe/tQtq2d09B4nSCzuaeA+IhnZvnfkURLYrtjY=;
        b=NlfYGfrnPZaTTui7RTYIRbh9FKMoV6nurzQLCdUGE+mHlY5bkuQ1tK3CykfiPBziLO
         cctVSTxhrHOeCEV9ndR8JOZR5dAe3ctSqhHpIlND9nyXems3nZE2Xb0M9Rt0Af+CDJnJ
         9z6m81TNEnfOjl6tPGP8zcVWiNsz1PXo5x+/z7A5vGxeSF5+p3PvDJR5BrJI4x/cEBw7
         WAMfAcjsmhsVHD0EGrpJQvO/JoqIgLIbfivQbO5LYYLUU4hRN9FaIcK/LGaoooh1YI14
         9L7OR8Y+nMj56aardti3//NHKJjaafRfSwziggzgvDtumaBvwDd2laoBTcyEe5SA4DD0
         rh0w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783594709; x=1784199509; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3IX2AtOXDdpt/3yHeSv69G4RZRiHMSHTQcrM8/wpyQ=;
        b=ARP7IyAol7oDvuOi+ShM7b8qDouYLhNoGfILhW1q2SESuHMJ7d50mWoBJ0tHjER0Nd
         YhukmLbb7lGINMvib8jLTCbogFEGHjnktESRXgN+M6tBCugPhWIYfmNsuxQDvTqicwWv
         OOFiTsHoehXyGX4hOvra2C9Yhi/O7lXPcRJU2ex0VNIvbcPnjCKzb60lL7WQTQfVwvi/
         2mEISQ78Uc0hJy4h6jDG+pZnPiyS/HF7sCkK1x6UZjJAh9cca1dhYgzTQa+b2asKOXK3
         2s4M6qQGCaWUUgYOaP0bTzJt/CO751T40k5N1ERShmuAfSpBp+ATSRYQb+5B2DQNlmUe
         2ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783594709; x=1784199509;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B3IX2AtOXDdpt/3yHeSv69G4RZRiHMSHTQcrM8/wpyQ=;
        b=rm7TT6Cv332Mk6Q7EYqO97UCuKfyr94T0TF3HXlyYwtMv3Cd3g2s8f3ynG92g/J9Kd
         2DgkpMrqf4mk9FP2Wx2s1NDPuow29DxVi7lmVJ3AwuwnTE4f6NaR7I+cFdcHW/6mkG9o
         FmawNudGGVLlZz5h3kQK+fbPHS3rfV4mURKKdvvWpS1anYVCMMQR5KXcdVR6VV7jciL+
         53p+cz8I9DrFe9hAsSFsHcGyhuvVYpkLRSDmWxN4LKEasTM6D3MKPVjWCS6H3v47r8dw
         DASJjnw401c1Hcf34fQCjPpx86GHJk+KO9kpzPvQTSpZU3EAYJXNHehc4qXlKfXagWYC
         uitw==
X-Forwarded-Encrypted: i=1; AFNElJ+46C4P1OGsrA7CVQti3xT8CHIq/VC1R6+k4yEeUr0D0jwUAnb8zWTj4XKbPgBfBYosjpipHqBYYC3GmrkqCw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3rYZRS/897zBD/ado7CAUNBeVEYQs/QDRgbcK23ChMWkM/fvR
	p51T0ty/h2dsgQZ/DuMHAV2YddySZsbDbxxA9Swy79uc65EnsRr38q/pWHrcSre/7VNXPF6IPO8
	iT86U2kszTN7mINsXgWQoiHS+dOkzQwCgdLPRZtk=
X-Gm-Gg: AfdE7cmaiOotPglgzVlk5ccZ618R7eWq28smq2g7hUc9D0uIaHti+n68cMoi8mMVa4k
	WHkFjv/GCLN7xPIM63J0WD9/fqL4S2F0Jr+tuKSP0Aekd0xjIaXhn4oH5i7e48kLEwx1UbwqfV4
	atlJiTvhGihUOyHrxBK6r446pbft0J6B02q9CiCCLMyXMCxBy22s4Ool/FQZh4n82EZcN+TSnWm
	FYjljMzTwN2VNN76CoT5xBI0rRGlBvQMrpDQx3Zz96YvKM7SPWoTS71uowusVZjtvJn67Nz1oQ=
X-Received: by 2002:a05:6830:314a:b0:7e9:c76c:abe3 with SMTP id
 46e09a7af769-7ebcfe6bad8mr5029939a34.6.1783594708966; Thu, 09 Jul 2026
 03:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260708124238.2817165-1-joseph.qi@linux.alibaba.com>
 <20260708162435.GB2502@lst.de> <55f7befb-5ef3-4ede-a3ed-4968864c45b7@linux.alibaba.com>
In-Reply-To: <55f7befb-5ef3-4ede-a3ed-4968864c45b7@linux.alibaba.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 9 Jul 2026 12:58:17 +0200
X-Gm-Features: AUfX_mzyA5O4pbS9o3vLdAlkX5J6jOIeUhGiEn85sXwKBN-NRQD-7oeWK920Pik
Message-ID: <CAM9Jb+hPmV4KF5xAy0=CPy6yh4=9=aACmLbZ3G5daz7QuAH3hQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-pmem: use GFP_NOIO for flush bio allocation
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Baokun Li <libaokun@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

> On 7/9/26 12:24 AM, Christoph Hellwig wrote:
> > On Wed, Jul 08, 2026 at 08:42:38PM +0800, Joseph Qi wrote:
> >> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> >> index 4176046627beb..081370aac6317 100644
> >> --- a/drivers/nvdimm/nd_virtio.c
> >> +++ b/drivers/nvdimm/nd_virtio.c
> >> @@ -117,7 +117,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> >>      if (bio && bio->bi_iter.bi_sector != -1) {
> >>              struct bio *child = bio_alloc(bio->bi_bdev, 0,
> >>                                            REQ_OP_WRITE | REQ_PREFLUSH,
> >> -                                          GFP_ATOMIC);
> >> +                                          GFP_NOIO);
> >>
> >>              if (!child)
> >>                      return -ENOMEM;
> >
> > This NULL  check can go away now, and probaby should to avoid confusion.
> >
> > Also bio_alloc allocates from fs_bio_set, so if the incoming bio
> > is from that, we can still deadlock.  We'll need a separate bio_set
> > for this to be deadlock free.  disk->bio_split isn't otherwise
> > used for the drivers/nvdimm/ driverss, so you might be able to
> > repurpose that if you want to be creative.
>
> Thanks for pointing this out.
>
> Seems it is more proper to use a driver-private bio_set instead of
> repurposing bd_disk->bio_split, like raid5-ppl flush_bs.
>
> Pankaj, what's your opinion?

Hi Joseph,

Thank you for the patch!

I am not very familiar with the internals of fs_bio_set, so I do not
have a strong opinion on the implementation details. However, a
driver-private bio_set sounds reasonable to me, and I would go with
Christoph's suggestion.

Best regards,
Pankaj
>
> Thanks,
> Joseph
