Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386E1BBBCA
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152427; cv=none; b=sYMpGYhzEEsEs8xEX7p3pjWG2ZXDSb6U7pEi7vTy6/9P/FdItWYjx0JcqBYjV6uDzRE6oVQKtf0DmrJXQJQR4oFOMQnNJWIV3+0XEH5r30E8HT5830VfkDZSMVC/P6jRp2DzFGEKfc7ml+nL+Hm1Ts2YWJi/x8wrS2S5uIj7tTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152427; c=relaxed/simple;
	bh=yysFE99Y5Emir5Z8MTpaSYvkaElUuc2VX9lhXX5Tz2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdXqHzjVcwjEUWhVHvJh1u1TlC8+AhckioGOmCNcmsEpsxgx60p8D7B1bk4GYJ8vzfhyerX8Nd7K+MsJFbo2vbp1Cy4IW7W9TP0X65O4eXHIrpRY1bYteSDPY7hPUb39BXNlnrDwte1Paj6w9OSjPAbJEN1y+q6MUiaQc18cov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sn7Bxl5a; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sn7Bxl5a"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d5119d6fedso1531780a12.0
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726152425; x=1726757225; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O5RqqAQCKLZ7/+gmavvgQDF/zChWWD9gq5CWrMwyiC0=;
        b=Sn7Bxl5ahw+QZL9id63ILBWHSrQFBSTMDwCEfKwUwN7BTQV34pC3FwjubDujMhNOLu
         8bS51dgcp5AzhpM7Z7WIDyCowLqYuxB1QTkVyHlT9pAuLqQ+5ddGVAg3l3YxgdBT9Au9
         r2iWEk/FPrqUVZACsevgBIJZHghswNiJRUTn2yFoBK4zUjlEKHICqx8LE6rILouZm5ZM
         dy9SfeZyFJWLN2vRUvetkdq4hT9yDooxeLlWhBOCvqnDbliqnbtxKIJ5+qV1MBg9OIkT
         ykr/onYrge41agS91SXWIbrIVDObk85PvqWsuqwH5w3HOuu2QwkSZGZkw+xxaXwNvJil
         swLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152425; x=1726757225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5RqqAQCKLZ7/+gmavvgQDF/zChWWD9gq5CWrMwyiC0=;
        b=FyvQa4q/hrBHfInblgz0hMTERxD0sOBppTOZlcEMFA7l/aVCz7Ht9THtC4e5H8yx2M
         Cq5YlqswALjFKA+UUVkuWb3gA/JwpmOWLmxuiyz3G9tqw3r8JdHMc52serXQ48KK9zdw
         C4cBbrh7BAUcSnMaRA3ysHpi9C9kMRWEZRy0T7eYNW421lIAIQNUrAlJvOJZf62os09S
         pEq1ZqE2pYrNNOBUeKsOWes6Jgc9Nfr2lLs81DmtWKwihZU+MvjcLUMkTP91NGD7gFSf
         l2L1NPzF5Nd20jTbd6YLpXlwUC6erCQBQ7iqDoXAmXP7z78eZPJRhgjiT9SSJalU9gkU
         xkvA==
X-Forwarded-Encrypted: i=1; AJvYcCUCVW5ITArG3H7eoBO3bIjxJFMeeDOIZCM2OueU8WyKBK2QcgQ4OoVYnheMR0ToWjhiDkenX3V0ppnx6mSOBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDaCxVwzHZIMhv6OFRLsivXzIUlTlRN6eRsRbraRtTl5yfdaYi
	hBVZ1APHTa9rCw12p6yE3ZaPIFpQfPwJ/Ty1/DCjuJ5lbmV/kKtfvENGpfBMOZFzOhKmoDdgNI4
	BKwK8nTEvOohPjmnWbQq0eCJsev5FXdsbvpe1M6frLvBkC4aD1Q==
X-Google-Smtp-Source: AGHT+IFust92Fikdsqho6imV+PsPdvyXW21u1a9qb23cqJI7Y7HiY2EO8+6cZUItE74mHAq0kFTKlPW6DkWtVMyTj7Y=
X-Received: by 2002:a17:902:e952:b0:205:7007:84fa with SMTP id
 d9443c01a7336-2076e61e31amr46398585ad.28.1726152424882; Thu, 12 Sep 2024
 07:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <000000000000e2058e0621e7a637@google.com> <20240912070121-mutt-send-email-mst@kernel.org>
 <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com> <20240912103017-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240912103017-mutt-send-email-mst@kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 12 Sep 2024 16:46:28 +0200
Message-ID: <CANpmjNOGpVXXdi61vFJDPB4CHsd3ksotjdQHO6WiVXV2m-aABg@mail.gmail.com>
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>, 
	eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 16:34, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 12, 2024 at 03:48:32PM +0200, Marco Elver wrote:
> > On Thu, 12 Sept 2024 at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Sep 12, 2024 at 01:11:21AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> > > >
> > > > ==================================================================
> > > > BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt
> > > >
> > > > write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
> > > >  vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591
> > >
> > >
> > > Yes, it's racy!
> > >
> > > 2589:        /* Just a hint for performance: so it's ok that this can be racy! */
> > > 2590:        if (vq->event)
> > > 2591:            vq->event_triggered = true;
> > >
> > >
> > > Question: is there a way to annotate code to tell syzbot it's ok?
> >
> > In this case, "if (data_race(vq->event))" might be the right choice.
>
> No, vq->event is not racy.

Oops - yes.

> The race is between a write and a read of event_triggered.
> I think data_race tags a read, it can not tag a write, correct?

data_race() takes an expression, so either read or write can be
enclosed - e.g. "data_race(vq->event_triggered = true);" works as
well.
