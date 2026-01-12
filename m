Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593702BD5AD
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262016; cv=none; b=VWJdbirLrUL5aZkDB9JRTlUQmcrkvfrrov9/dl8fXTdGNSgJWYfRIGArhfK3sD9CkNew/xp1shE4/c+qmkbUeiB7MVSDKXCwe1ayqRYpSEaVPc0CPc4T5x4yYo0YgqkxFERUYA0apYtqBVvDBwQTg5r8ZADBqFLeNQ3p8KjHk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262016; c=relaxed/simple;
	bh=D/QOV+PvgeGDhnZ/ix6Fp2phNTxa9gFGlVxWZXZmAqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHwMum5s6wqb7DPs0RanG9RH4NfwBnC3ThlfFcZPHsnaBK5PeqgAJMxz/O/qlwCHwJkv2NakASUzgqM+pVsWJoQY77WSIQ7DnyF/wOGjV2h3hJLcMcMNtUHcGGt8SWKUTdE/abe8o5WD5H0mQyuX6MdwL+gFGhGDpRLoA19mvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijPmzolz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijPmzolz"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8908f5ed4aeso55865636d6.3
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 15:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768262014; x=1768866814; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrgEBLHMQ7w7z7OSk0+LmFxB5np8c3y6da/CYllo/d4=;
        b=ijPmzolzDGzFTKB10N+aq41oCmRiY3hoeWw/gcCwTDTFwW9IsCGJh93GB7/IcaHb4z
         b2w6i/2EAZDgC/1Dbkf5HGuSB6ZeWdvsXM2hoMHUIQo/XOYkaVq1Nv+weVfrsCkaay2Z
         K0RPuGVHhrYUdFITe6S1F1ASxLm0IkK1AwOe3u0OHzxgLeqm2BzqDvnEYy80qhKihtgF
         YQ1QV5XMXcj4+rxynsruqjvnbeRjoTlsReF1n9t9a/DO8XjfgXd+H03fktO4HpvID8jc
         hEJu1g8fJOaYAoY3QnxvfX9WGFzr9zntppw0e7he0WsBNG20ngDy2mVb1thFgps+REKO
         ObtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768262014; x=1768866814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrgEBLHMQ7w7z7OSk0+LmFxB5np8c3y6da/CYllo/d4=;
        b=ByrsOEl1+vJb0iSoyUll0kqkHI1PI1g2C4X7LTbsFD9t3Y1xz9t7AGlDQm+cW+D+B9
         hvx5M9rPsZxclNBGOIJtEqwJMZYApsxKFstovs/CV7VittidPmGLR4kqycKInx4zHUSd
         lRKJCLUiL4V6Aa00AQSiVZniWELZE0N0kLB0B7ABHBSVBDrw5JM892sJg1oPT1CxN2ow
         QIXQKI697ST4q2Nn36jMoPDBFai3mSBygjxs7WjduOmgzUU7i5m1ctA4K70BFQ4aQ2iZ
         cMSHjOWt1BBUSEIC8ctDuZVsJ+LzdZVIZNh+Vi34PUJSlq+vM++1xI+Fm6sfqr65n9Xd
         YD1w==
X-Forwarded-Encrypted: i=1; AJvYcCVxtraqPAWyEfnkxjoWKVzVuAezfzTpmyhDjxN5GFhan7+iBYBnetRzvCAvFGIdjSODJmKPXeHhQVAUb1K0QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXHaUEKeIYhMzkZFSJDbl6mHO866M5Bqqq9dwagXyZEGgsQjsO
	C0VuBjvfvX/yR3ifZRutWJqBQGi2NoKyv+fb4W16X1TCgs4BBzoz6jgN+ikaQQ==
X-Gm-Gg: AY/fxX6qNqd1ebgPdJTpTPGg39S1KjpB5u2b9K7+P/ARI3T1oRdez4daD5/FWFGhy8i
	XO2+CnfWsMrMXH6M5MHopZijno8FkvR2H4E4oVO33ZiqgBzDvyOvTfYxGBn4IUfEakPx+FY+MOi
	b1/I8qyQYyrqam9TUwSvZhImAiDjAAPkilVF8VX2SBjhLvuotulfqZy/GsIRCmDnu7R3BxVe19g
	LzBOSHr4SeeSXY0qCTIZ5X2PgSwQ1s3rAWryfvMzPZSWnc/cABfBjEkwKHICuGt8fsGEBMDA0DG
	nhv6d+Tv0Isd5THisnr/HUQcvmZsT1Vdu1nT3DsSXoEUcdAVfB/1NuGTgBxwN/33qBAcPcoc6KP
	B/MolHoVcPl20ttdRA2Dwok6LV0dBsbmWtAuC5zC4/8X4V6CaOeTkoqSDNOsRADNAHMXatZUbaO
	SWUvzkxLLJ7XaB5HSo5f6Yzm/WvBcFsDFJMg==
X-Google-Smtp-Source: AGHT+IEEIChW46EWJZZzmGq0dv1aKbX23y4OJcSbpVgI4A7CpdyG+MDzyxvMqujhAfbDeFoADMp1dQ==
X-Received: by 2002:a53:e303:0:b0:63f:a727:8403 with SMTP id 956f58d0204a3-64716bd78d9mr12404043d50.38.1768254541320;
        Mon, 12 Jan 2026 13:49:01 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f7c04sm8530959d50.2.2026.01.12.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:49:00 -0800 (PST)
Date: Mon, 12 Jan 2026 13:48:58 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWVsSq7lORhM+prM@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
 <20260110191107-mutt-send-email-mst@kernel.org>
 <aWUnqbDlBmjfnC_Q@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWUnqbDlBmjfnC_Q@sgarzare-redhat>

On Mon, Jan 12, 2026 at 06:26:18PM +0100, Stefano Garzarella wrote:
> On Sat, Jan 10, 2026 at 07:12:07PM -0500, Michael S. Tsirkin wrote:
> > On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
> > > On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> > > > This series adds namespace support to vhost-vsock and loopback. It does
> > > > not add namespaces to any of the other guest transports (virtio-vsock,
> > > > hyperv, or vmci).
> > > >
> > > > The current revision supports two modes: local and global. Local
> > > > mode is complete isolation of namespaces, while global mode is complete
> > > > sharing between namespaces of CIDs (the original behavior).
> > > >
> > > > The mode is set using the parent namespace's
> > > > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > > > created. The mode of the current namespace can be queried by reading
> > > > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > > > has been created.
> > > >
> > > > Modes are per-netns. This allows a system to configure namespaces
> > > > independently (some may share CIDs, others are completely isolated).
> > > > This also supports future possible mixed use cases, where there may be
> > > > namespaces in global mode spinning up VMs while there are mixed mode
> > > > namespaces that provide services to the VMs, but are not allowed to
> > > > allocate from the global CID pool (this mode is not implemented in this
> > > > series).
> > > 
> > > Stefano, would like me to resend this without the RFC tag, or should I
> > > just leave as is for review? I don't have any planned changes at the
> > > moment.
> > > 
> > > Best,
> > > Bobby
> > 
> > i couldn't apply it on top of net-next so pls do.
> > 
> 
> Yeah, some difficulties to apply also here.
> I tried `base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59` as mentioned
> in the cover, but didn't apply. After several tries I successfully applied
> on top of commit bc69ed975203 ("Merge tag 'for_linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost")
> 
> So, I agree, better to resend and you can remove RFC.
> 
> BTW I'll do my best to start to review tomorrow!
> 
> Thanks,
> Stefano
> 

Sounds good to me. Sorry about that, I must have done something weird
with b4 to pin the base commit because it has been
962ac5ca99a5c3e7469215bf47572440402dfd59 for the last several revisions.

Looks like my local of this is actually based on:

7b8e9264f55a ("Merge tag 'net-6.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

I'll re-apply to head and resend today!

While I'm at it I will try to address Michael's feedback and bump a
version.

Best,
Bobby
