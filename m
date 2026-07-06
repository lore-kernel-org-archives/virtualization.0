Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC593AE1BB
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329880; cv=none; b=dj20G2R6UMjtTeDq/AydsEOHHmxEiPxKBw0wjzNU/GRO7VYWEgEkQU9+yAKud1Emxu4mrEEbgcWyzGQK5YNB/QDqjHY7yknH8zUNPxu3qoVQRRtR3oRX0iCUC33HIxG1IByM6MlTLfmuadTTV6RBD7J59+VGxdmVJNWgpWd83QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329880; c=relaxed/simple;
	bh=bjF0BZXpIAjW/Uu1wH2j5e53ZR+HCAlpR+B3xXBi2vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUdSv0o9izHyaPeh32ji/ofIiXYXgFU+MTX+V1uD5IIqqH/bQbg8AVDfG9FwZrg9iVi4O14OcsICHram1wc3f0//HBry9sg+LKgRGGPeSIVWK3KQfh7WYBPn/BdHmy54Zn561HPxl31makcSWNQokPJ5j/HXh79iLcrfaUhSbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qu0sfzs3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qu0sfzs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
	b=Qu0sfzs35LqlFGeInch5gaxB4uuOKILwNlKyHKosOPx1l0sRCaR6H+dN/JLKxcayuYyRLz
	vxIa3Rq6ka/m3bHSfMzSfew/tBN5Ob4YwyBM+CEEVxOIdLzWkKbiMG4RmG5ZtUe1nR7J4i
	dNd5IiOzI4vhZqCYV3CbLF6pwqE5pYQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-nOlrd3WsNTqngq9RxlGxkQ-1; Mon, 06 Jul 2026 05:24:29 -0400
X-MC-Unique: nOlrd3WsNTqngq9RxlGxkQ-1
X-Mimecast-MFC-AGG-ID: nOlrd3WsNTqngq9RxlGxkQ_1783329868
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc77a6943eso55801045ad.0
        for <virtualization@lists.linux.dev>; Mon, 06 Jul 2026 02:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783329868; x=1783934668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
        b=PkAHCb4FmxLlyf0RBsMcM2FmxJMK7kk8H0GW+vewhURYxA5BQtr7i0bMcyvOtmGfPZ
         G5QSzAHr+dh1oTeP7q5bB5K2rSQJhWbQUvfUqbnb8AjqgajnVi3dn2fLSqQE7ppU+5is
         6wmaH9cjNKTCSpz/phhyQLn2J6YUbbfj4HcOzFgmWSr5lDzpwernzTbUcMVZLTmjc+pM
         7pnEOferldssYMK5LxlCOJAHCcrWYoAO5D5NTzSxY4q2299iNMdjESD6M4OVGL8+wQrN
         PIky6Xd/gbMjvk+FaSTzkzd19FPpEMym42wuLLDt9gs2VpJHTzprFlhTMgo+NFmF6j7n
         irag==
X-Forwarded-Encrypted: i=1; AHgh+RpeqKoK28ghuBffiYwOYbQ/olg+SYgnIu2l89KhIVxoZzr1NktU2RxFF45m0homiFy5KDvhWWKsqHHpICyvFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze/GR5Py3DlycQe0tz0WvZxZkGuNYlcmU6JK4WbbrIIOd88S5z
	F5fvOziQyDiS4A5OtN3o3NrAruX3GKLfkrVaGlUwdm2UECAMETupq9/R/JmVJWCeWnf1NvEIov6
	1G6154tDtsbUyGYnBBw73ifM2eyWW+UyCAEEIBc9qmJJDjHGxyh5AYQKML+Q9nj5u1q7pHioBd6
	fw2f8GlZ7Pl/meg3ac928IXoCmm00zGmVFjIUUPck5izM=
X-Gm-Gg: AfdE7cnywD5ms6jrWeDw/mxQjjkQSFnD4FA178PGLdk6FfJptg5iEYoIOrN/mgqsUAV
	bYGKHZhUWcKD3KklBPeDEYSS9g3bMNsOfEMzsW/hiapO5qwdUlDB3TAR7L9X7+jkw35ypOMHBd5
	beKllaPwAX23ySl8kFdAiFsqh+/Fn5gaSLbcRmGzT4R7PmpCeuYbuxZoa/tT9a0SMX
X-Received: by 2002:a17:902:d4c8:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2cbb7511a14mr91874295ad.18.1783329865776;
        Mon, 06 Jul 2026 02:24:25 -0700 (PDT)
X-Received: by 2002:a17:902:d4c8:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2cbb7511a14mr91874005ad.18.1783329865282; Mon, 06 Jul 2026
 02:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com> <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
In-Reply-To: <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 6 Jul 2026 11:24:14 +0200
X-Gm-Features: AVVi8CdUM8gLEd1esj3vEBaF7KM2cPEVYji_lbVGfB2Yvj6K1tMDr3_xJ0gDydo
Message-ID: <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com>
Subject: Re: [syzbot] Monthly virt report (Jun 2026)
To: mawupeng <mawupeng1@huawei.com>
Cc: syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, stefanha@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HdzOB69OGj1zRgnsJikPQvoP98_I4fkp2bXUpdK7ELk_1783329868
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Jul 2026 at 04:55, mawupeng <mawupeng1@huawei.com> wrote:
> On =E5=91=A8=E5=9B=9B 2026-6-25 04:32, syzbot wrote:
> > Hello virt maintainers/developers,
> >
> > This is a 31-day syzbot report for the virt subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/virt
> >
> > During the period, 0 new issues were detected and 0 were fixed.
> > In total, 5 issues are still open and 61 have already been fixed.
> > There are also 2 low-priority issues.
> >
> > Some of the still happening issues:
> >
> > Ref Crashes Repro Title
> > <1> 24      No    WARNING: refcount bug in call_timer_fn (4)
> >                   https://syzkaller.appspot.com/bug?extid=3D07dcf509f4c=
013e25dc5
> > <2> 3       Yes   memory leak in __vsock_create (2)
> >                   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8=
708082678
>
> Hi,
>
> This is regarding the still-open "memory leak in __vsock_create (2)"
> bug (#2 in the monthly virt report, extid 1b2c9c4a0f8708082678):
>   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678
>
> I spent some time analyzing the root cause and the previous fix
> attempt; below is a summary and a direction that tested out.

[...]

>
> I'm not subscribed to follow the list at full volume; happy to send a
> formal patch (with the af_vsock.h / pending_work changes folded in)
> if the direction looks right to the maintainers.

Yes, please, a formal patch with a great commit message is much better
than a long text to read IMO.

Thanks,
Stefano

