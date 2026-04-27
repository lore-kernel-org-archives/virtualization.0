Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08853537F5
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306749; cv=none; b=RCH25vMs5u0QotX5Xv2MNR6v/1CCz4dF0o0EB8dEBZxOSpEzLME9vPSLVORlBNLBiHVeaNdh8vafsmvpzmkCbnhaMe0bU3ugUwVa1o/Qf3Uemnwt6k/N1WblwmZrheFrQ5Xl/DjyU56JklipGTj4YgKDbdYrrKkhug3+2uK+1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306749; c=relaxed/simple;
	bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iCDC460FtlMOGH5xZYavJTkGM7LDdCbfpP7Bz4VEy9pMqlXtIiy3BcWZ3rOvd9y3IzeG96MboaGwlDcSGkfKww9vak+FCIpqWoP0VS8bU0YKbNg1+HBlUOHVoRzTrF1bEp43y+TMkkSxBvRLnek8nWIxP36h9TS4dFKVxXVk1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g455nApm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g455nApm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777306744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
	b=g455nApmV58k2fFYs8Gp9yXb7g/3t30heZTras3FEUX0vfNEjZdut8kuIEWjdAq7/JVjU9
	5abpCdCI5SIPImSfY3j2Ty4AcXmS+B0jETC4uhFUkitv94QmzApID+X9Aa1IE/Sql0rjv4
	MsBqPGZjwXtsKl/FmHs4rONZhx1CkC0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-4kC_lo4ANdmrAUl-_zayiA-1; Mon, 27 Apr 2026 12:19:02 -0400
X-MC-Unique: 4kC_lo4ANdmrAUl-_zayiA-1
X-Mimecast-MFC-AGG-ID: 4kC_lo4ANdmrAUl-_zayiA_1777306741
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d721a4858so7129505f8f.1
        for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 09:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777306741; x=1777911541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
        b=W8dHMkxAMc0nmhdHsO5kBVpvyAKbl0wHtv+Djd2pWDIKri1lOyQvGyrxQCQh/cR+Um
         F2ocCCzMp82wmLYtluvLXx2TzeGWjBey/uVxgk2PyFGEmwCw0DWaTZUYibQcouJEjQRU
         WJgH2DPrChD1fkxBpQGnIkA8LU72uDHdSMmCjg1MF7c0Gsu0vEJP3wzJ1YTpRx3lSdie
         TwVmf2rlHa0aQCjSMJFzT+AEAawClJXuKRc8LbN0pZZg0T0UCj0+RPUYKYeQGUQAbfXp
         H/SIC/4SauOhRxemYFGw5Jr44yoTAiFFVH9GwKDxsfdSta+93qL9doGScKmdLQwa6UtQ
         6c4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8op0snHaZITZkfiLOFWlnTYSDZ4H0yPfOYnrbyn7fgePovM0Q5WQfCLUegp7FyoI7nFpwjD1t2HlhfNoBSkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJBUMF0NF12BSse+aP+OXfq41zp1rmmbz3yvvtW3ZK43iCcjmv
	lEDQU1WeuJ+q2/HQjyUMXQkOd3RKnQcAjrfcuatbgIS8VPo+TDaKcTX0mHRugVYluoDbGfpkQAV
	kOYIz+jguDB7cco1/T903YP++1qU8FnJrfs8sK9d6G0Q1Tbh4loqyGet96GeWH8P6YSJ4
X-Gm-Gg: AeBDiesU5GZyjEv4tAJ8Gp/vHS9GElSJ1LwToJmAsDBWNwTMAyzHc/VDHhOadlBSJWH
	AfZHQVXEoJeX/G++wRZpeDtQs3uO/N4+Cxyo/TLpI65gLo8k796v80L52oleXV4udeRjXktjaMR
	uGyEaIkJ7twuPPQGZf015w3I6USr1Q9eTeDlxRAamiMTF8fl5fjJWh7tgp7Lmug3/+p4MqY3aPb
	JXvtAr6/bH9ZZNbm09zVC7jujkvZWJfKC+4vUF4GC7npFRr7+9kuD9mWVwhR5GmWRZvDA8N0RrE
	DWy3zfl0M3PuH6hIpsEX7JqcUGuc3enJ7R1hdTiXQFRcgDq5bT8cxDqfElnXTuGc79erjdf2w0b
	hEBFauswWBH9aYz2lnSEUEqjs/WMrRLiUp8vDkZuaR7hAJeG5WZKSRifiicT9asre9UbVqkSK6+
	USwFM6jA==
X-Received: by 2002:a05:600c:4714:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-48a76f91ac6mr136595e9.28.1777306740889;
        Mon, 27 Apr 2026 09:19:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4714:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-48a76f91ac6mr136125e9.28.1777306740387;
        Mon, 27 Apr 2026 09:19:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm969836865e9.6.2026.04.27.09.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:18:59 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:18:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] memory leak in __vsock_create (2)
Message-ID: <ae-MTiL0vf-y7Ygz@sgarzare-redhat>
References: <69eacf39.a00a0220.17a17.004d.GAE@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <69eacf39.a00a0220.17a17.004d.GAE@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ulIRbPQ5JfZ3w9OoFjVY5Fxn13H2Bj1NPo-2pFNJvcs_1777306741
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

#syz test: https://github.com/stefano-garzarella/linux.git fix-syzbot-memleak-vsock-create

