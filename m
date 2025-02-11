Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291661EE7D2
	for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261627; cv=none; b=mSrHUtE4YNk/Id04utPbvqSvUHP1cO29jma2eGHpaM9PEOhbXBMwawfvGD9/tRofwIj/Q65OwEsVq0868lBQkcHE8VEXGoFXWhoJiBZ1S6CZeqtfcfuHcljqXzZ6gSueKXP+PQPGDkRx6832IpXnKIC16GjFXrJRTC2NBZ3VjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261627; c=relaxed/simple;
	bh=0dvMrOU+jpUj7tdCPK1OdWeuBFlDOcoyCJs0wbTUm44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ojWoUs6+yhTL4c07jDrh43qgF+h55zXFcsP9K4PiqcZikHaFvpZhdDR7miMpkH9StuawYbh1LD5M/FWEbYQtXNNZ6HGtjfs5L/1q42QEoa/0IBnT9/RASVx+XyKApHDl51ylubVllcKy8Icz9x0fY6F6SQM2kHFZRzPaRyE4/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyIbEjcz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyIbEjcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739261625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1n8vkK3pIQpfbo4j0Rb3+1FkQLwn21MZFeg/srwCbfE=;
	b=UyIbEjczQaYlON4QF79Rk+Ud9u0DjJc+QrmOOhsxUvO54+pl3+Iz2APWRknKOtEmdDYnBX
	PFImTj/BA+Gu4IFro5LVWcHALIma60Amxx6gVTaDZy86BgnpTeyW19XisMSUSuY0zqN63H
	nBFkEucDx3ENpaVyrRzHwBsO23BPRrw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-1e1mtKO5Phy9H8A9wZP68A-1; Tue, 11 Feb 2025 03:13:43 -0500
X-MC-Unique: 1e1mtKO5Phy9H8A9wZP68A-1
X-Mimecast-MFC-AGG-ID: 1e1mtKO5Phy9H8A9wZP68A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38ddba9814bso923697f8f.3
        for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 00:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261621; x=1739866421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n8vkK3pIQpfbo4j0Rb3+1FkQLwn21MZFeg/srwCbfE=;
        b=ssNDp2eFRWhWHvFwdJbevONS/31BkmCB5QtsnwT4vKJl3nzkUQTt5qG32jYITsWNJH
         rZ6NGN8ndlq+hsfXGJPWnskcm+avhPhK9wVwKSLdPEekH+FCEkD50jdWq1kAXn62Fh7v
         ws/9ksKIRzUDsVLUemEevtFeGiLEUbLW4x+rfjpaY29OVnzCdEbt9hbkAOS234NLRIl3
         dguLd2eVz0Rwpx//IZmVQWdc6YRmunrQYxvbGuDPQ/sefG86I5K5utgg8zJYlOYsp/cw
         9p9Ya8RJEX3o5t1QGKuZf1sNDbdL87TAz51vfBFQ7JafMC25SYBmdIAZ7BUSvXwy/jbk
         m/ig==
X-Forwarded-Encrypted: i=1; AJvYcCXrl9v94JhkXhR0sFhZmPjcDtJrzSY9t5kXds7K2EAbzK4W+Fr4taBed4ZPW5tO5A7DBbUZJgIbNhhVIuZG7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm77diztwRO9qGpQnSocbDbx19A5A9Zh30Ae524j/lQtfyHIHZ
	59uoNj8Wku+wMKcFuT31knKpWbaBOwBQRLCoioSuQClOuymOT7UlL2qWC5zHEGmP+dnRfc7pqCF
	MdzPpVqhqQwjgZFSzBfAsIAZ6ihf2IfDNhzfZayfLfc9QtW1JmAXkSkA2PyvOPsmf
X-Gm-Gg: ASbGncvdCuIavH7NGniNBBUWIipdhP/H4UwtM+Yt5/dp43MXpO8Z1fmHqplCh5Ae+TK
	jV5fA6Orit33684RhVMGNjUu1bK1sSJEhWt9B7slqgTC03ibvjd4SN/umSeQqBfPPViinTQe5m9
	SPi7gJmZjsEN/DIHMAMcDbgzErQ26zdTsWrpXacvrmniWobtV0a4jvcmP8XX3+liA4tBzJfRXMy
	vo4hA1Ppd2M6rk9ygvZVigmBu6EnVo8jFw1N1GuW74zprKwdJa54otQZwJ91d8QizZLWARtcn9L
	cWhl6dIsU/FuyFcJo4X0S+N9vOcsAbFK8se//z4aHHijZIFUIYfzwg==
X-Received: by 2002:a5d:64a6:0:b0:38d:dcf1:d191 with SMTP id ffacd0b85a97d-38ddcf1d528mr8272409f8f.21.1739261620706;
        Tue, 11 Feb 2025 00:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESlByLWTFDUB78pjxA1Dd6V3iLKw47Bgjaj5JruimINPkrnWdgcGJctJ+ryQRtChMGWsKZHA==
X-Received: by 2002:a5d:64a6:0:b0:38d:dcf1:d191 with SMTP id ffacd0b85a97d-38ddcf1d528mr8272350f8f.21.1739261620000;
        Tue, 11 Feb 2025 00:13:40 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd6080926sm8087046f8f.83.2025.02.11.00.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:13:39 -0800 (PST)
Date: Tue, 11 Feb 2025 09:13:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com>
Cc: bobby.eshleman@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, leonardi@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, v4bel@theori.io, virtualization@lists.linux-foundation.org, 
	virtualization@lists.linux.dev
Subject: Re: [syzbot] [net?] [virt?] general protection fault in
 vsock_stream_has_data
Message-ID: <xx2igtwgro5ffbmdaahbwz6irolnfh4ktmdfatfrl72kppne7m@rp2ajscxfpp2>
References: <67867937.050a0220.216c54.007c.GAE@google.com>
 <67aaa81c.050a0220.3d72c.0059.GAE@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <67aaa81c.050a0220.3d72c.0059.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: JFJ7898LKn15kmBaXDFsxjE7ttlZoHVAqrI4zLLVmdM_1739261623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

#syz fix: vsock/virtio: cancel close work in the destructor

On Mon, Feb 10, 2025 at 05:30:04PM -0800, syzbot wrote:
>syzbot suspects this issue was fixed by commit:
>
>commit df137da9d6d166e87e40980e36eb8e0bc90483ef
>Author: Stefano Garzarella <sgarzare@redhat.com>
>Date:   Fri Jan 10 08:35:09 2025 +0000
>
>    vsock/virtio: cancel close work in the destructor
>
>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bb31b0580000
>start commit:   25cc469d6d34 net: phy: micrel: use helper phy_disable_eee
>git tree:       net-next
>kernel config:  https://syzkaller.appspot.com/x/.config?x=d50f1d63eac02308
>dashboard link: https://syzkaller.appspot.com/bug?extid=71613b464c8ef17ab718
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125a3218580000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147f11df980000
>
>If the result looks correct, please mark the issue as fixed by replying with:
>
>#syz fix: vsock/virtio: cancel close work in the destructor
>
>For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>

