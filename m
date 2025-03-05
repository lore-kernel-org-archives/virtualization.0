Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AF2250BEC
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190977; cv=none; b=fdzjbCHePt7XozLhkmuFgmU+K61jctIK9YseJjqOiCwb6dxdhNkiLoehoMF+K/Q3XS6+SRY/Jvga8ZWhSw/1clx7y+ZUTFNL3f3j9/+smF1GFyhFRFqfuVsNwx92Jw9ZRinGpCBvxX7O9RLQK/tcjimtk8XlfyBGCRXMTXNM9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190977; c=relaxed/simple;
	bh=GKmV83MRa5t4NkQJ3esvrmWFVjgUKTVYEu/IX/vnRuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8qSUcTyN9I6wTAfqE+vfbmfcjWm8v1Dqr/l9JzO4+nRtgkKuC/cfhhLyMmXA1VqezUx8HrL8u4KFKiBbwaBLZhGN9TKAzjkygIA/vRqwwxR6NK6j8Pz8RyiX+BeN462TGWrEOLYIKi39kNxv8RbAemxEFDvhU55uXGJDsB3Hz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs0VjU+/; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs0VjU+/"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 38B5141164
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 16:09:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOht_EHsgiqZ for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 16:09:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=bobbyeshleman@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 22F9C4115C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22F9C4115C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Xs0VjU+/
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 22F9C4115C
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 16:09:34 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2239aa5da08so67972125ad.3
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190974; x=1741795774; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3ZvhVCBXJoVmMj/QDYwjnvrQ0tg00IV0Ab5gY5yAEQ=;
        b=Xs0VjU+/0eb8PBT7Vm0tqTz1OQTSrImpWYuoYLXKwiJgsFtKNPLYum7gPGE8cr+n72
         0jFXqCgjaM6hWLNAVYQ4Hy1N1UZa51BsI7wFl28TMgiTcJXM67KL7MUzozkyP9CKV2Tz
         IDLhgawRqCko/EkBL9qL80OmqhT8z0Vinl7b4lkp8pOc6T9QRtR7SwUPTLC+XjnpwGPk
         1SIpb+XkqtsO6qo/QTY8v1quwr3VEU+5S6hBVcjLTrMi0ySoHQ6HAtfrDSuYJ7sEhcm9
         ch+8H9sAIrLbYpdAizUdircyohGJu2z9ol5JSivM7keNOLKlftMyBrQIoUFynZZNNzpX
         /eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190974; x=1741795774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3ZvhVCBXJoVmMj/QDYwjnvrQ0tg00IV0Ab5gY5yAEQ=;
        b=SOtRpY2KJdTjX9RMJuXSYb3GuKBdMFh/x05z4RMHYIRRPmqysG9BiegHMUCUmMHhBe
         JuB4rDWHc3p35xlTE3kRSq/FkUEyRlj0WJfTojgCk3oXdb/3xhEFvoxutZfOwrl/7LMM
         ghaJR3Pc7DIU2Wiul46rilWOxweyNOsExgAsM8hpuGw0LpBAUnBBzEf6x5pyUy0GLMDL
         ZTsmdaW/Xp07a4czUFBM6D5glmxOnuc4VlG4FLUQ+8vgzMu7r+a7v3edOobJ58GNyCOU
         S0m3vbTgYLVcbturSt7I6GtWW58Zy/xSIhP4orMuXDorCoQNlXMbDSWUetCd/w6mQEfT
         eRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMWp3iUjcmZTgaZ4CDBbtJkQTsUYmLJlRyZQgT39jKmunFo5/BWg/HZvbRT+rEE0E1tFWaVReqQC17cOCsjQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw9KSSoTKM/FHJbW7JxGb+ott3Wl58nA9JTID8g5ivNTAhRxjf6
	h9oLhEsTgpVjzkw94Qcb1vtUbnQCHtrE+IOChJsV7OZ0TKWf5NRQ
X-Gm-Gg: ASbGncsSl1JCNreh2J6OHIfQurvfaDdVzU5hGn1WF2vgFQhK7Ik35FYdcvmnkOEAVGT
	lGgCIiRS2LIUWydp/6oguH+9sfa4cQyflLKYP5O2Nq9AAcvUdagSfuMtr/WaalesPMnolS6LnmN
	DuxwAEvmPS0FQSAfXsKoBh3unFzbmcHVDIc0HvR/0ya2k6/joR/3jT6Te1hBgLgsoF/6QEcQjA9
	ItF8ew3EQxuKmElpf0LXfDPkn1oWVNUz6xtecd0RfFGsgQW9TBj5oP3Vkbqs69GHklQ+oUpoRQl
	I1iiOM539pKiTH3U3GcoJC8vKZOMNSkva+ABLqWY1dqT+OVCAjfNjK9vADH7X4qLuQ==
X-Google-Smtp-Source: AGHT+IECEBns91C5EwHlCoDWNpwg07LFYchP/SxyUo4u1fqpcLi7anWcXaFI4dnLEJw/KAKqFZuNdw==
X-Received: by 2002:a05:6a00:3ccd:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-73682cc409dmr5359182b3a.22.1741190972845;
        Wed, 05 Mar 2025 08:09:32 -0800 (PST)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7358603f4a2sm10921810b3a.173.2025.03.05.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:09:32 -0800 (PST)
Date: Wed, 5 Mar 2025 08:09:30 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <Z8h3OsmQxL3e48ZJ@devvm6277.cco0.facebook.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
 <20250305022248-mutt-send-email-mst@kernel.org>
 <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>

On Wed, Mar 05, 2025 at 10:30:17AM +0100, Stefano Garzarella wrote:
> On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> > > I think it might be a lot of complexity to bring into the picture from
> > > netdev, and I'm not sure there is a big win since the vsock device could
> > > also have a vsock->net itself? I think the complexity will come from the
> > > address translation, which I don't think netdev buys us because there
> > > would still be all of the work work to support vsock in netfilter?
> > 
> > Ugh.
> > 
> > Guys, let's remember what vsock is.
> > 
> > It's a replacement for the serial device with an interface
> > that's easier for userspace to consume, as you get
> > the demultiplexing by the port number.
> > 
> > The whole point of vsock is that people do not want
> > any firewalling, filtering, or management on it.
> > 
> > It needs to work with no configuration even if networking is
> > misconfigured or blocked.
> 
> I agree with Michael here.
> 
> It's been 5 years and my memory is bad, but using netdev seemed like a mess,
> especially because in vsock we don't have anything related to
> IP/Ethernet/ARP, etc.
> 
> I see vsock more as AF_UNIX than netdev.
> 

+1, I also agree with this.

For reference I added netdev to vsock before [1] to use qdisc and at
least from the qdisc perspect the juice wasn't worth the squeeze (tldr:
only pfifo_fast worked because vsock can't recover when other qdiscs silently
drop packets).

[1] https://lore.kernel.org/all/5a93c5aad99d79f028d349cb7e3c128c65d5d7e2.1660362668.git.bobby.eshleman@bytedance.com/

Best,
Bobby
