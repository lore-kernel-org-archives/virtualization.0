Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FAB13AA2D
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337677; cv=pass; b=U+W6IR/kJfr61vmwb6/hsWoj8XvM62FWtsbTv5ZTIW7REvKMFcpXCMyy1VtoYLvoiT28Vsw+qaM2pVTaZeiwZvaeQWx0RLZOGGcy4yZb/HzihcUxo++n/q0HWCxJYmPjIhzWC6YnhaSDZCbLBHqCXcDRGHn41cDjsb7RmhTj628=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337677; c=relaxed/simple;
	bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOb3aVcD2jcWLEn1FSnrzKRy6qpXyf5O4J+9BmS8KJeboH+Z2pvyhcok8Tjr7GFXA/0zBMSSNHEy7QjLQTfA89YhUoKzsZThPdoMUM8qw5b062UrHrcu0Dh17vxSGf6AmDveZFV2OY5kA6z/ducJO0ieOHjXoDvCPylDiWOqmBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqlR7mHZ; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqlR7mHZ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7fd8446a1cdso15655197b3.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782337675; cv=none;
        d=google.com; s=arc-20240605;
        b=VGwTAfDLmGdax/kFlvu3pntJJY/G87ThsJcIfvjbdC4EiNaNBBdpqlXdqBkfq0AHoU
         eB9DXl3KjKQOqDObSJriC7klRGkdOZqgPm68DSi0EGpyWhYtro7u9Nm0gtvFz9A2KCfq
         Zw91Sh6gdG6kuI8H0IljNWLSBFBY66DMqe/pBs6CKjRt07ACD9R5qkXnGs6KCcoGcKrm
         CnMRw9Rj494UJ7w3X78aO22WToIJJDGuDYIw2crIxZd2fPl3ZmRcHTQBPs2SIVIiPGCe
         lE4e/dwVYtpTImp4Okx4PPQGu1sJDfuJjkZQeZWrmjcbQM9uYDDDuZazEvvIeRJv1Kdu
         Uidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
        fh=WA4ybSlnT10E3FYEDgg52XVDZAT6P9gwV40x9LrVnkU=;
        b=JMgJdKd2Mg0dyCvhhzUGohlMarGuLpsy00kysxK3/JF/1KzTQc2MlJxFS44icjJWXZ
         X6ZW94uGEtUxBXPIdGpLHCuXmkbunAW2JmdQxEp2/GGNNGbyfIYV8eVTJsjKW+SQN2jT
         QlRF8RiF6801r8kHxk+IRzCmneuWdYoYgTzP8UggQHNP3+NY7RZM/fyothY2kNtFqq+u
         WlQq9pLIigP3ypQyIa4+vIEqW1OToV08vEIG4ERIoqigHXh88vwg80RHnPhexb71Gb9X
         SUz/fs6ZpnOBoycPUil3SYmJseKXt+Gjec3EXiLfbCkLAfdvuDLOh6NbyFHOcYGZBQ6U
         FAVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782337675; x=1782942475; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
        b=KqlR7mHZftYDsjy9WaCM0QEWQff/SsBncHEpEN/+JR1nlcsLFRoQ1jRZW4QGGEH+gg
         zID2ncLUOLfS2ZjSHuE5HQGSbpmH6LSAaiVWUK/dUEDmXFE9pe4D7peLI1RlxyP0kw+r
         rbgPysmthUN7DyLhVUgFBxHYVCvT7QZ6fbLNUdvVBDc/vY9K7/6bHfC78hHjRCjl1rS5
         9HU4Xqprc0OFtAQGgj9HdrVSp27EKoEh3CJedmMrsqIWmZqhPFyilFHjXeZ+5wvs7kCd
         r9epNKXmWXp/0accRrq7NJQXxVRDncMfh6TUWcF4Kq9z6uOWZdMuJwo/4C+NJUbIlm//
         6rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782337675; x=1782942475;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
        b=K4RlowkQwzlTOVVjLqAJlJGujRs/HFVDz18EyPJWsrqA74+co2N5eAlN7N/90Bncfy
         GqKz2YT2P7QTPmOt5yjpZaZDMpSrIOpGnfb9l2nrYSUspZfSca2maA0wrePDxqUs594m
         MGFREKmR/2JuudHTq9boD04SA2MX+RAtgPZJ6ASpJRoKZwImw/6MZTwMOfJwCcYH90BV
         5fP+XhF18v3cWOj9687eaHIpAVHqz8pr1WsZmRaDDAhcbryGxZ4QZhwMiVtDoHBjKa5m
         LhoZou7XKmYUrAXjRrFkzPu/iiA1ev2Hit33CLD/iNXCZcyTGGu8x4q0QXdnW6MhseyA
         Qz1w==
X-Forwarded-Encrypted: i=1; AHgh+RrWU5Z9oAuruJDgc5q2gqfemEAIEuAJpj4EsmdR7G6/VtxlT960NmpahcJAnQmsbrDYJ8PwCrNjYaL8xTqy/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuTX1Rm/zMUvzWBj41JuSDlOjj7sM/Se0we9RbsjSgdSBwfe4h
	hOV9SddJbQiDQyBOR8eAGMNmFZL0z6Bf7DO0xQHwaIQ8Cz1FDWmh6nf2CTUoE1RQXF6Tmp7Q+Vj
	JAoprhHsaEIwC4zz1BADNPncrX5GglpE=
X-Gm-Gg: AfdE7ckY3wuI7JxsX9w4paJUx7L1caXZEG+G2Yi34Stwep0h3sjgNJWIoWR9RZ0diJ9
	U5V5KHX4/2Wb5fLLjdwPV7/sC+BozojLZk3gTuqUB4Vi2v3rxcplDcyOX6kplo2lZcwX7BD4fYN
	YG/hZk6FrhKrVdIKILzgxT3zWpCgnKjGyYQ9qDk5usvo3F64vCOa2kkbw/j2rK4i5FBGkM6+BGb
	3cwRD4sViZ97jjC3GhWmVrz6Cn5px9bwYUd5d7VyifvoS+tz6P03bz9Z9mITTTp8xayKCg7
X-Received: by 2002:a05:690c:628a:b0:7cf:d242:d966 with SMTP id
 00721157ae682-80a63f4560bmr669177b3.15.1782337674985; Wed, 24 Jun 2026
 14:47:54 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:47:53 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:47:53 -0700
In-Reply-To: <20260624153850-mutt-send-email-mst@kernel.org>
References: <20260624190653.2893-1-alhouseenyousef@gmail.com> <20260624153850-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:47:53 -0700
X-Gm-Features: AVVi8CeynxX2_AcSDWHorX_h258yRsucuQ_SkLNN6wE5TmhSJnB8IHSA5IRr3Og
Message-ID: <CAMuQ4bWKsMA_88Qt-0azvUckrKkcY87i0PZFmJ9Lozo-OsXtrw@mail.gmail.com>
Subject: Re: [PATCH] vhost/vdpa: reject overflowing PA map page counts
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 24, 2026 at 01:53:38PM -0400, Michael S. Tsirkin wrote:
> You should add "on 32 bit systems" - I do not see how it can
> overflow on 64 bit.

Right, the overflow I was trying to cover is the unsigned long
page-count calculation on 32-bit systems, where size can be wider than
unsigned long and the page offset is added before PFN_UP(). I should
have made that scope explicit in the changelog.

> I don't see how this can happen at all - pinned_vm is in units of pages.

Agreed, that part is not needed for this fix. I'll drop the memlock
check change and send a v2 with the changelog clarified to say this is
for 32-bit systems.

Thanks,
Yousef


On Wed, 24 Jun 2026 15:53:38 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Jun 24, 2026 at 09:06:53PM +0200, Yousef Alhouseen wrote:
> > vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> > size before computing the number of pages to pin. If that addition wraps,
> > the code can pin and map fewer pages than the requested IOTLB range.
> >
> > Reject sizes that overflow the page-count calculation.
>
> You should add "on 32 bit systems" - I do not see how it can
> overflow on 64 bit.
>
> > Also make the
> > memlock check subtraction-based so a large page count cannot wrap the
> > pinned page total.
>
> I don't see how this can happen at all - pinned_vm is in units of pages.
>
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/vhost/vdpa.c | 12 ++++++++++--
> > 1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index ac55275fa..090cb8693 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > unsigned int gup_flags = FOLL_LONGTERM;
> > unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> > unsigned long lock_limit, sz2pin, nchunks, i;
> > + unsigned long page_offset;
> > + u64 pinned_vm;
> > u64 start = iova;
> > long pinned;
> > int ret = 0;
> > @@ -1114,7 +1116,12 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > if (perm & VHOST_ACCESS_WO)
> > gup_flags |= FOLL_WRITE;
> >
> > - npages = PFN_UP(size + (iova & ~PAGE_MASK));
> > + page_offset = iova & ~PAGE_MASK;
> > + if (size > ULONG_MAX - page_offset) {
> > + ret = -EINVAL;
> > + goto free;
> > + }
> > + npages = PFN_UP(size + page_offset);
> > if (!npages) {
> > ret = -EINVAL;
> > goto free;
> > @@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > mmap_read_lock(dev->mm);
> >
> > lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> > - if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > + pinned_vm = atomic64_read(&dev->mm->pinned_vm);
> > + if (npages > lock_limit || pinned_vm > lock_limit - npages) {
> > ret = -ENOMEM;
> > goto unlock;
> > }
> > --
> > 2.54.0
