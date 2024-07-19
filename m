Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD221EBE
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jul 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350911; cv=none; b=XZKB/CdR9PNZd0/+UI7VWPR7nul7uj2XjZXH6XCpAvXd4AANYEntb7v7+BgkVpUd9b3BDURaLmDXQxBh/CTvucrh+/JZlMAskVKHkFFF63W3V5Xs/7VlbdHtvnPg4Hw2tcKgp9Ga1dhz7cYmKjCYro5gT+RnN8Cw/xhwQ31Sqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350911; c=relaxed/simple;
	bh=8KnAlU9cYLXcno95Q36TTWbBLhvPugdWp/i7BifU7nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnJo26kZFskVOVdGMPK5VfZAomCpTjQ/iCu5/0S+i04BBIFIVz4vpHlnoRqsSVKKGJfkvYcvslmB8GP8COyUCCA5OPYFgy4GM+np/1u1sjt2s1zY9JU2U5vKk0TmAOqHqEUiw6lIKrRU6tw45FVfMt55ZdJvbgYb6hpZM8//dsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxyA/uNn; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxyA/uNn"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4660B40929
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jul 2024 01:01:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUSKCbjjsjPy for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Jul 2024 01:01:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 90B0C40353
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90B0C40353
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BxyA/uNn
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90B0C40353
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jul 2024 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721350905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPg8UfS1mNa8nZOIH+oSnc/vQVgPs0AeEqj7g3NW3eA=;
	b=BxyA/uNncngj0NuFI+Jc4x8E6dvWzraXCFOxhVjbcwqAjNAJ5ZJNaw8/d//GPkGUjZVsvg
	1abw68ezVHXPqfChs4zgBicRMl4UflMHVTsLc09Kv/ANqoR102bKO0Rtbk3mPh8rYTzlBJ
	xiL8sWRZ4TfiTkw8XyhA05i1w9meCfU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-_RNSjqnOOIObZkyMt0RKlg-1; Thu, 18 Jul 2024 21:01:43 -0400
X-MC-Unique: _RNSjqnOOIObZkyMt0RKlg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb4bcd9671so1004281a91.1
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 18:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350902; x=1721955702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPg8UfS1mNa8nZOIH+oSnc/vQVgPs0AeEqj7g3NW3eA=;
        b=e9d2DLQzR0Qq1tIzNI5GH8g1vrL0IQVBdmI/hoe/6Aha+Yiqwv0DSGrIH/gtG9MzcS
         d6JZG6yidXFjzTop76ilc+vT1rzJN8XUQ1W89FVSDGwgjY/53MVRz+sY7c9oNeKr/6Ne
         saPjZZObi44/3eiJu9RYAWZTkNOB+Hq0tR0CKR6pGRXcyGS2iNNCPJETmEWofrSiWUhQ
         dZIBaew83iGnxEDtU78gK42x+ZAJbY+dk5rZuRV5Em1o4/eBJPYisZfedliyWcoH0vWL
         LKPm7ucsz0e9LuVTbuk8fZOfxDN3VpezyW/xdFtWL2VJM0Nu3gdqNY44Pd+KtTh1fDc0
         L/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXG7dZAJ6XhuvVsmRFHoHRMsepW8tqLGqiIPiBZKTMUTOVDi78TvpAADjKbEMhb7YDgBpFBCSgbDNMxxOp/CHxESAqaqYpArJHxn4aUe/zDp5CMW7WrYTJiyA==
X-Gm-Message-State: AOJu0YxCwmVL1N0uj1PeUoS6TqEmqxPesFADielTVkfK/+a7+dO+qzNg
	BL6IVzzYHW+5jpd8ki+kva4h4kIPn3CwQwSoQBBLSBC+Q7/6YkN0uqn3z1SF/2/QFu2OiJcNWbk
	SrkBGSru5GrT7rUYFwtZMHwPtruq9WXLI2OSwCIaaM+GanR0XVgKMFPQnn2I/w7v6TQsWrRavIU
	4M8GeYfLFC6fmGrFx8b8xkOiyx+UVJOBoVdDpOp9QJXLWbZpzzKT3xYw==
X-Received: by 2002:a17:90a:c598:b0:2c9:e0e3:e507 with SMTP id 98e67ed59e1d1-2cb51e5efe9mr5425327a91.0.1721350901997;
        Thu, 18 Jul 2024 18:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoOtmyeavURvGXMlZW9QiwWpBgy/DTMI/26rVaTyG7HUyL1xELz/5e17Got+cyMz7yEPSyXmZm+BjeeWh1l0g=
X-Received: by 2002:a17:90a:c598:b0:2c9:e0e3:e507 with SMTP id
 98e67ed59e1d1-2cb51e5efe9mr5425292a91.0.1721350901557; Thu, 18 Jul 2024
 18:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
 <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com> <CACGkMEuj-6EcEPo9xKkmuPSaQPQnH6zG+j2cqLRiScWUB4oqXw@mail.gmail.com>
 <5a1cfaaf-64aa-426a-b1b4-da84a66b362a@oracle.com> <CACGkMEtuErg+nd96k6FkL9dfSxOv2o38L1HSsK9jU-xmmkv8oQ@mail.gmail.com>
 <20240718153724-mutt-send-email-mst@kernel.org> <53630267-d22f-45ab-8919-3103739e360c@oracle.com>
In-Reply-To: <53630267-d22f-45ab-8919-3103739e360c@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Jul 2024 09:01:30 +0800
Message-ID: <CACGkMEuUBbTADGL8dVHZ+J=-5d8Kkye2xHHNCwjzLnwAPz6dBA@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
To: Steven Sistare <steven.sistare@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 4:19=E2=80=AFAM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/18/2024 3:39 PM, Michael S. Tsirkin wrote:
> > On Thu, Jul 18, 2024 at 08:45:31AM +0800, Jason Wang wrote:
> >>>> For example:
> >>>>
> >>>> 1) old owner pass fd to new owner which is another process
> >>>> 2) the new owner do VHOST_NEW_OWNER
> >>>> 3) new owner doesn't do remap correctly
> >>>>
> >>>> There's no way for the old owner to remove/unpin the mappings as we
> >>>> have the owner check in IOTLB_UPDATE. Looks like a potential way for
> >>>> DOS.
> >>>
> >>> This is a bug in the second cooperating process, not a DOS.  The appl=
ication
> >>> must fix it.  Sometimes you cannot recover from an application bug at=
 run time.
> >>>
> >>> BTW, at one time vfio enforced the concept of an owner, but Alex dele=
ted it.
> >>> It adds no value, because possession of the fd is the key.
> >>>     ffed0518d871 ("vfio: remove useless judgement")
> >>
> >> This seems to be a great relaxation of the ownership check. I would
> >> like to hear from Michael first.
> >>
> >> Thanks
> >
> > It could be that the ownership model is too restrictive.
> > But again, this is changing a security assumption.
> > Looks like yes another reason to tie this to the switch to iommufd.
>
> iommufd, like vfio, does not impose an ownership requirement.  If vdpa ha=
s a
> stricter requirement, such as allowing the vhost-net sharing that Jason
> described, then we need to surface that now, and extend it to allow chang=
e
> of ownership for live update.
>
> Is the vhost-net scenario currently used, or aspirational?

This question is very hard. But for my understanding, what Michael meant is=
:

1) the current proposal changes the security assumption
2) iommufd require uAPI changes which may imply security assumption
changes or other user space noticeable behaviour changes

My understanding is:

If we want to go without iommufd, we may need to find a way to stick
to the assumption (not sure how hard it is). If we want to go with
iommufd, we probably won't worry about that, as you've pointed out,
there's no ownership requirement.

> Copying from Jason's email:
>    1) Two processes (A and B) share a part of the memory
>    2) A is the owner of the vhost-net who is in charge of building memory
>    mappings via IOTLB
>    3) A passes vhost-net fd to process B
>
> - Steve
>

Thanks

