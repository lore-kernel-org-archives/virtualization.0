Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374852;
	b=OuuqwleQjnNtPImHE8MBqWsslVO+cY7Q5N73BYNmdBzEZnLGCLJGKjdkbhFX5/wwCmsH
	 isNxQxuc5K6LPeX3Z66SdWDt6we1+qPA1wq8uQ+druEYSjPInlTApnmTgtxTUSMdutsuz
	 s3rn6/mbGWA8DZhJqg4D5R60N+co0Wm5mMGgXzxYCs9eI5hf27S7PR5M52bVlwNc9jMD6
	 K/d33VxMp625TzBqgAGqpxc9nl7+Y1ssXmSofnbU75y+Ji6wzPbhoqgX4WYkp+/1IBpZP
	 w+UoR5zgsE3ysxmoKqhuA15LimfSQ4m2f+HHyTDP/hH83wjdbFVnmi9fYY+YRVjxCNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374852;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
	b=zxcJXBNIrQrjdnF6vdchT/IvZfWQExg2WeeEuVm9KM01k4wUbCOqbm9nqAz9PI0F+Ire
	 5EFPjXdI1aCIt0Ik8S6AaNAGQDrcNoiG6bCfXCOq6F94IphdqEe9OcDfvg80dMCsJBUhr
	 4lJ17bXkMO85PMYwqXoxhkFPtIyOGOYE0inmcrOGTRaviVoG7XENw5fALD3jzrnMZ1QYU
	 JKPimjTiJQqSth5jEb2U505dwJa3QP7w+4Y+uvUnER5Qt2E4jt3uJPknH+SFgw99NigmO
	 vFES114wNPS2oIMJCfYQ17YsQt/V77HyKjR5x4QAay5CxzmvTc69X/feAmXVr8F+8tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZpAwrYuL;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59D606A330
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 19:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C59D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZpAwrYuL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795374850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
	b=ZpAwrYuLf5EdLloLxtncynvxdkf3IrcU3uWbIR/1vn8nDClXS68XwwZqoZEaHb4EEWypM7
	if1l767wKwZ72NATFFD+S78SrI6tfnWhXMGf6KGmtG31XeFcBx1KlJPtHHT/yLha4LI1b3
	bO8IaXfLRF2/9MoTLpg/x08hhJSGBzw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-pKZ6WHAoOUqmr48oQKiqgg-1; Sun, 22 Nov 2026 19:14:08 +0000
X-MC-Unique: pKZ6WHAoOUqmr48oQKiqgg-1
X-Mimecast-MFC-AGG-ID: pKZ6WHAoOUqmr48oQKiqgg_1795374848
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so1504175f8f.3
        for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 11:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374847; x=1795979647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
        b=EkzMmAMfzRcyhHFi5uq5kehyw3taJfLXfxtzOXZC92OVRYFLLZ2a3/s4JaX+QS4xc3
         x95wqEE8g0ia8zSRS2J95Nw/7UKtgPjYgnazEKVJwknA8vOEhTbGZOPMQmDG4yEeXGAB
         wWbt07KbPx5R2FFWTnJPYyYOAW+IyIJ/7mSUabCkmvS79mRHgj1r1M2lLF6ADD2NRpNw
         caB+U/o7f4r8ye2OPM+IAw7l9tsweTCeWRIMtjxjAksYxki3yG1U1sVcIH+l8KnsnvUF
         fx15WJhnYY4c/Q4SogkTRJckw7qhLLFZ8sp/WCZb+PIS4nc9IX1Idl8t4sehyb1OZGIH
         rTkQ==
X-Forwarded-Encrypted: i=1; AL+hErHuAk8tzCRKg47pJzkDmq03YMLnBxtF6FmpbmLoLEmmVYaNiR1hs0A09BkRKJbtA3TuWMk6YB34l3rbxJ5D1g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8dPuo0SY3cKQPXzWMuoSeDOiXbemCEXOk1SJY+UW+p4fzFa2N6
	Dj0clewcvb0MoKET751xsUDTKGe1tCvThEQBFu2E/ammnM0Gxc7WVlLCOH69hNpyhbrIWmVyoZx
	ROlgB6ReGYtcc++MKj+RhxPy9p+GKbdxF6Zs16X+amJ9oce1qP5TytVs9CEw9zepOlxPP
X-Gm-Gg: AZFdTZf6zp43pRgBJO/CNWHITvvX9wPo+D7nRLwkuZzmFpdHrsSVgtJ4FZGQlHJtiyK
	Qg9BHoYLcdCgF6GZRTYWc6g+26LswbW/n/PfWp9mAvVSVewJfP9w+J9AA0mpMB3bKAohiC05h57
	w64bHQaWEez8w1cEvfK4NZVy+il7wRffoF0sQqlLwxzu2PU7ypAnyZwb3N0I6mYHf6j8pSk10V+
	tHprvQ7iS6ILLFdkjOFA/x6cJ6Av0FKJYDO3OkNHnQEy4iEsyFSQk9sl0yc4E3zNld0vrjs2GfA
	IXxxyv2Ad5NRvAuUHMBs0RXo2JUbDWp6s2J8HXf/6k6+3ttauHaGj16KgTeRCbwpuKg9YNxXcAH
	zji/bdtndL+8XZ6nw46DOdJyHvYaTJira8m9oz0FI
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb8881d019mr195708835e9.10.1795374847337;
        Sun, 22 Nov 2026 11:14:07 -0800 (PST)
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb8881d019mr195708385e9.10.1795374846810;
        Sun, 22 Nov 2026 11:14:06 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1524:9e00:c39b:a740:e7:3fcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm198874085e9.2.2026.11.22.11.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:14:06 -0800 (PST)
Date: Sun, 22 Nov 2026 14:14:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Message-ID: <20261122134901-mutt-send-email-mst@kernel.org>
References: <20261122092235-mutt-send-email-mst@kernel.org>
 <20261122143829.2674252-1-hengyul@cs.unc.edu>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261122143829.2674252-1-hengyul@cs.unc.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BQ4cr1YfZh9AGu7ZCW5zAV2koS-EfrNnxlBALmg4EPM_1795374848
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 22, 2026 at 09:38:29AM -0500, Hengyu Liang wrote:
> On Sun, Nov 22, 2026 at 09:25:37AM -0500, Michael S. Tsirkin wrote:
> > this is followed by:
> >
> >                 virtio_features_zero(all_features);
> >                 argp += sizeof(u64);
> >                 copied = min(count, (u64)VIRTIO_FEATURES_U64S);
> >                 if (copy_from_user(all_features, argp, copied * sizeof(u64)))
> >                         return -EFAULT;
> >
> > copies at most 8 bytes.
> >
> >
> > did you test that this patch actually helps anything?
> 
> That first copy is bounded, yes. The unbounded part is the loop right
> after it, which is outside the diff context:
> 
> 		for (i = copied; i < count; ++i) {
> 			if (copy_from_user(&features, featurep + 1 + i,
> 					   sizeof(features)))
> 				return -EFAULT;
> 			if (features)
> 				return -EOPNOTSUPP;
> 		}

I see. So all it is doing is checking that these features
are > 0 and erroring out.
Let's just not do it - we don't have to.


> It reads one u64 per iteration up to the count from user space. With
> count = U64_MAX and a large zero-filled mapping, it only stops at the
> first unreadable address.
> 
> Yes, I tested it, on the vhost tree at 44293796526f (KASAN + lockdep),
> count = U64_MAX:
> 
>   1 GiB zero-filled mapping:
>     without the patch: EFAULT after 27.4 s
>     with the patch:    E2BIG at once
> 
>   2 GiB mapping, SIGKILL sent 1 s into the ioctl:
>     without the patch: the process is reaped 46.7 s after the kill
>     with the patch:    the ioctl has already returned
> 
> I have a small reproducer (a few lines of C). Since I found this with
> the help of an LLM, Documentation/process/security-bugs.rst asks me to
> treat it as public and not post the reproducer to a public list, so I
> have not included it here. I am happy to send it to you off-list if it
> would help.
> 
> Thanks,
> Hengyu
