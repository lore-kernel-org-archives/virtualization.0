Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795643175;
	b=of4K1aBQMLDkombhTqTZi0BRzqJYVH4UX+G8TBGjbCaICqR99YkkCwQ+6Ggaacjmt0rV
	 +zh+mi54te4uXlZTN/McqfsRonLwLHbni4m50/XnFv7Aeno7nmpBWOlbvXaGVHhj8ymjo
	 j3nol5TZK/QPmBRy4GKQhbvIFPiX84C/9yb3fcZTgixwPSN0WoOylnOfOhwxNqr7S+P6F
	 KEeVdT5diKM037pNQCTKdBqupEeFd2O4oLmB0Ol6OerYH5sV7u5QopFpdtqyP/FNycfKH
	 bROuqlJ+t1OC5sf5kgjRyhcZ6PGgGltlW31lfGLJ6YxJVpdtn2xSNOyij+chIP1vFjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643175;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=sN/vvPChvRjnihCjXMx+GKZD5EpsDE0bEFaTBUovVHA=;
	b=jcCU2uZ1eJ9FwWKZlEqk8z0NPZDBmgYzhOyIfmDgjUBnDrL/8rGJn85nAMXGDefNDFyZ
	 8DZNbX7TftNs3AeMgNHdI31IQgcbrximqFUTDUFXeCgdreFXx8dbIRuIccjxHSKe8bB0/
	 8M3rkxZnNJPGb/9igelev71ibBMMQXEmkHVdXgFw9fr5u6j7dbl+SPbiV+dVYD8Kzy1F5
	 +lVQTjfGmyhb/uBwGAgvDZ2KPp52Bw+cpgc2qk7KZ6jwzz2cJLHX6IKmvRKRqTwqUIHAi
	 4uh26M4xYxwA22z0MgZWtWdCVwn9Rz+lpDwasOSEVcC18Xyj42l365tIP0bPOBf5r1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FROQxim7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.133
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3BC606A321
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FROQxim7
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 400FE40087
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 21:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.063
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MXL6dWaO7adC for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2026 21:46:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 719AB4004D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795643174;
	b=II6PODGkn1c5ogqeQVVWvcFD2fPKl9w6oQVUVKtLeU7jcCbrK+k0vcbrfojDvpRnr2S7
	 EMZFpjnVcNW0bCeqrcKDkjYprClzlG0fX0DED92RMnCSDwiGEniQw+lK2CSZCXt4RcOhX
	 BE+MWHZJYqOuvPz1LMvxjlTaMV89I0g39UCwzFLB6/cKZU2YPli5OMd1joWui+s4jF4V6
	 x1I+xppxXQmo60KawPqc89oLE602+KHBfedDVjG2cXS7lb5O51mVlTv1FRa0Y+DVBExGA
	 veRq3XEKLOnvD4I+CRJZfgWaYjg86pkgvSz2baVqwpKzgO8N0Ll4q+8wVO+btXcYGJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795643174;
	h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=sN/vvPChvRjnihCjXMx+GKZD5EpsDE0bEFaTBUovVHA=;
	b=tXmuCWxTnd1RMlYkV3mi/CEyQInJPLuM5ud2kTeYnxK7/ZeVL1cx3G7bm29ZnVEyAkKR
	 KZc1AG6TJs9ZyOigfO/rjuOw6yC3bMb++UGLIGW2vvLPrfPAgHWLJNrwuiSTZgPtNNSrM
	 f0e4g6b716wQRQ8iYO+BBPKzXaHWvODlU0lOrp4TiuF6PigynMlOut2QmXulrmy/HlJ1M
	 6TX9NHGIJ5VKXopu5VRusQyEyqWL4nKPnCrCM/Vh8j5DtXtoTWN9roOWXr44dIYC0/a+P
	 pXp3RekrpdyuaA2O0/hRsZ8sv/NcomWPb4h1vfIAiT8lQ0GRfrxa5RHFEQPUOG48xIw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FROQxim7;
	arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FROQxim7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 719AB4004D
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 21:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795643170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN/vvPChvRjnihCjXMx+GKZD5EpsDE0bEFaTBUovVHA=;
	b=FROQxim7NhQq+Igk9ska8V9PCoSaQWMMVnpPTDxKEvD1UQ/UztBW4kKSFiYb7uyeMGWi/Y
	DB/NrgxUw9jeLc888Wojkub6/V16GnnRTzgmKFAN9lD7oF6grwx728L/iGQT6vaM32r4pW
	ODBUz6kMVQaOjU7E2w/EmpdiqfiY3Rs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-YffTPvVfPwWEQ0DhklfjEw-1; Wed, 25 Nov 2026 21:46:08 +0000
X-MC-Unique: YffTPvVfPwWEQ0DhklfjEw-1
X-Mimecast-MFC-AGG-ID: YffTPvVfPwWEQ0DhklfjEw_1795643167
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso26821505e9.1
        for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 13:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795643167; x=1796247967;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sN/vvPChvRjnihCjXMx+GKZD5EpsDE0bEFaTBUovVHA=;
        b=bACgrKhRdDUIhVxATH/xBggX+tsJ7cXEP7kLKhlscXckLxl1khzpActK4p4KB4VRkt
         n2RbbQlynKCCqPi6sTkhopjSPlzR2KKQNOUo7PNkdD3hYTrqmB6t6qYTkSPhrlwQTKX4
         wKhdKSfMuonhNL5aNi+0dItJltlzuOKj6mC5XrS8IyXT2c/t82AKhaKX2Ls2g71/nHis
         6UWWTZiuqElUUsEkfWJ4wIsDtP03dh4xhK/KCS4BOL5mCgDIaLlqvjc0HkRAceWBNEh8
         5T29Febz+hiZv1UZEQoqKfySBEXd8STCTu4Kmdm0x9ChqEVljnh0uoomcpRHttVREHN1
         9QHA==
X-Forwarded-Encrypted: i=1; AL+hErFjA6wCDbRaPdJ/361WlUfFMQGGSLATf1lcBNKbo1ayXhaMD4Z//W0tYIntNcHontUhE7ezmXGjQ0h+ysmG0Q==@lists.linux-foundation.org
X-Gm-Message-State: APuU4Z/eYlV5IqFES1PM9ZxsYfANsEiMkMgj0wsxyUtt552rOpBb9KrD
	mYkDqa2HiXYVhI30jHRqnc5GrdJdn+ft4hcWFG2anmnF9AGWF31M2FlDHxIZVYtkbqhOXDhYP0M
	Nr7Rs5QJIVOFKchZf0yhO2aVdr8uI94I+7kVxsHM5p9vMkwZMoY8DpnBnxeXehKkYZcV6yYH/gi
	2+f1CBTeA=
X-Gm-Gg: AZFdTZfq293k8pvkZBK5VTpxZUUZwn8cNbMbyXz/omZAjX8UwDzdgfkkY1vwR2Bjun4
	4J6+QkSdufja7M7i9VVW/tRHoSM2te26RCIQ5VXOePwDJ4c3gVjbY7gHNzbNZwffHT/8+DYuyBt
	gbxNe8NQOyEZ5gSax7HtQDVdXecU5+U04BVM1u9sepySXwFhuwiDldlsFeQ+qeaFwom0j6MupXe
	tvUk2kNPQfKMJq/wj7Doq1Mah/2eclWxJxY+4dpLjFe0YiRyPFRoYhC309cvFO6h/87/vWxfegU
	7zztHPVVMuBxSTGzpIlDlKvVPz2qPVLOAM4uqfvcVqu5m39gTcqRn87cQmJU724wyfBKagN78sR
	KqpO+HzfZdFuQqubD8idxi03tt98M+UdWPpcvPMbT/yc=
X-Received: by 2002:a05:600c:3491:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4bb8880014dmr398711445e9.10.1795643166767;
        Wed, 25 Nov 2026 13:46:06 -0800 (PST)
X-Received: by 2002:a05:600c:3491:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4bb8880014dmr398710875e9.10.1795643166098;
        Wed, 25 Nov 2026 13:46:06 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm38309168f8f.29.2026.11.25.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:46:04 -0800 (PST)
Date: Wed, 25 Nov 2026 16:46:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paul Moses <p@1g4.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"chenglong.ma" <longpareto@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org,
	co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com,
	fangxy@xiaopeng.com, jasowangio@gmail.com, kmehltretter@gmail.com,
	linfeng.sun.dev@gmail.com, lirongqing@baidu.com,
	oss.patchbox@gmail.com, phx0fer@gmail.com, physicalmtea@gmail.com,
	sergiiushakov@google.com, shubham@octane.security,
	stable@vger.kernel.org, stjepan.poljak@gmail.com,
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com,
	tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu,
	xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com,
	zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <20261125162710-mutt-send-email-mst@kernel.org>
References: <20261104081535-mutt-send-email-mst@kernel.org>
 <awWOpS3HR_2FTN3I@gremlin>
 <20261125060533.1296-1-longpareto@gmail.com>
 <awbTgufgR4Uge1kJ@gremlin>
 <s1xGKGqyb3Uk_gDZmeWG7nVEq4_m00HsO9pS1RL3cUnIdr4GMgH5OEBifQIl-30ZdUu7_uUoe-TxhMQd2GuW2sWKzY6UUGSWXKaqMz_XeEE=@1g4.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <s1xGKGqyb3Uk_gDZmeWG7nVEq4_m00HsO9pS1RL3cUnIdr4GMgH5OEBifQIl-30ZdUu7_uUoe-TxhMQd2GuW2sWKzY6UUGSWXKaqMz_XeEE=@1g4.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lIgRPd3aCMAg2UwphpIgUuunsXVcwyWT2t2lss3_faI_1795643167
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

First, thanks for your quality bug reports. I saw a fair share of these!
To answer your questions:

On Wed, Nov 25, 2026 at 09:21:01PM +0000, Paul Moses wrote:
> There appears to be a recurring problem with how previously reported 
> vulnerabilities are being handled in this subsystem.
> 
> Yu Zhang publicly reported the VDUSE VA/PA confusion on August 7, 
> including runtime evidence and a proposed fix:
> 
> https://lore.kernel.org/r/20260807022657.11318-1-yuz08559@gmail.com
> 
> Nearly three months later, bb2e6f166547 was merged with attribution to 
> Claude Code, but without any acknowledgment of Yu's earlier report.

Mostly what happened is that Jason left RH, and at the same time a wave
of vuln reports hit, and this one got some "critical" sashiko reviews.
Which I didn't look closely at, but at the same time, the reporter
really could have responded to, but instead ignored. The patch was not
Cc stable, even. I could have looked at the patch more closely and
noticed there's a reported security problem and tracked it.

> As 
> Lorenzo has now pointed out, the accepted patch also breaks the driver's 
> mmap path.

yea, not good.

> This is particularly concerning given my own experience with the vDPA 
> netlink double-free.
> 
> I reported the issue in March, submitted a patch at your request, provided 
> runtime evidence, and received repeated assurances that my patch would be 
> applied. Nearly eight months later, a different Claude-assisted implementation 
> was merged instead after I reported it to security list a second time.
> 
> I acknowledge that I eventually received a Reported-by tag. That does not explain 
> why a known and acknowledged memory-safety defect remained unfixed for nearly eight 
> months.

I don't at this time remember why it took a lot of time or why I chose that patch at
this point, sorry.

> I have no objection to the use of AI-assisted development. I do object to a process 
> in which previously submitted security fixes remain unresolved for months, only to 
> be replaced by AI-assisted implementations, particularly when those implementations 
> introduce regressions that basic functional testing would have caught.
> 
> Why was Yu Zhang's earlier report not acknowledged?

Because the reporter didn't follow the process.

> And what is being done to ensure that previously reported vulnerabilities are not left 
> unresolved until they are rediscovered?
> 
> Thanks,
> Paul

Following the process helps. You did good by pinging repeatedly and the
problem was fixed as opposed to rediscovered. Thanks a lot for that.


I'm not as quick as I'd like to be. Make mistakes, too (
If more people can pitch in and help review patches, that will help a lot!

-- 
MST

