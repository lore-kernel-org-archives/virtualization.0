Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E61917CD
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878729; cv=none; b=ScFGX3nTtu9DMKqUJN+JBocUJ+nGMrM5fgr4f/2oSX2Y5ILAhBXjgq5TW/OqL6StFWl1M3Qn4jDM+wOEVnpbiHZhhKC/CTJI+kDltMQA1n3BDzemVqTVw01AyhvNe4lj+zuzf59ERbfZkkyNwmK78uaV5H4FgetLFA4TJfWcWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878729; c=relaxed/simple;
	bh=jmzYajqzGnCHIswgRvH4vFvbIZh0jM098WbwOYZyUjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qf1YN0jmeKJeAuiwywSflQILI2XKSJVOH+hBYe2klQjElAEj3ncrdmdt+QrwUT2cg16W5afv+ChWsTyRaRAtZzIaZs5gUM6szQV6aPGbOy86QQL1emMNLA2EVMuzOLNcB5fRWDwKbmMkkaPxP++Z2K+go2aCjL/+te7PIZB0isA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZImp/SN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZImp/SN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1SjNuHqdKwYbOTS0VAZLoIA4ArI3wWYlQCLHNMfK6c=;
	b=CZImp/SNO9QlWvdwWC+w+QsN1zwj3owbNLLxkLWKmrkI98nZEvGDvGukInuBiWfK2ix21k
	Snhx5mxd4NmrVeJU23i6R/85dKJg9s2XvGkc+HJhmMyvsongxdgSheCiiK+g3op/2A2Amb
	JyQX7Hcg3vN6gOMfdxD3Yj8t0+YSjJU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-O-Jylay6NIWozfLphPFp-g-1; Wed, 06 Nov 2024 02:38:45 -0500
X-MC-Unique: O-Jylay6NIWozfLphPFp-g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d47127e69so2780786f8f.1
        for <virtualization@lists.linux.dev>; Tue, 05 Nov 2024 23:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878724; x=1731483524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1SjNuHqdKwYbOTS0VAZLoIA4ArI3wWYlQCLHNMfK6c=;
        b=M8TN5LsPTcl9vcnltaRBKsHaicm3SWdsbukRiBvx4n5D8fjzRPVtkBqpbEhJy4JNjL
         sYhmnGX449V/myUSi4UfUzvijLVlXqPLiw3l67L2VMlQkam+JPO/DGnjcCOb5NSvP9Eo
         btaH8iVRJRPvCcvMKUO+ltZNUMHzMadixZ3no5MsxwTaNAhbKhNm8TTcnxzwpWK79O2j
         snuvTsLKCb3KCxeigQIe8aDrbrOlY+dTJQ2GeZexwIkooGnKhsVslCoU8HLB2OHE3jy7
         ZoVawzRDtw/94qe0t035N3hKxdYEZQIpd1/QfluWoi2Yp/i+ppsaYvX5lGICXYCFQXbC
         1AxA==
X-Forwarded-Encrypted: i=1; AJvYcCVHmW5wkKc+hoF82gG0juLqLDKDHhBmRmfO1YCGdz/kbv8m0h2NyFIujeT21nEFHLB0TiCDd/b1Tmu4iEe4CA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXtMLriCvs3YsjwF8fiTFEJXaui3sDo+IUBTGgx0uINJ8W4Vdd
	JIxv05/JULDtiMFTSPC8fks726k54BFgg0Eb81beeFViXX30NYlSxUOCbYIf6ez6hBFhbjiswAi
	3zpK3EICflohyXjNqSMGhqr6FYeYRENIj5BtJJnpnkFD5r3wX6HWvdTDlJ81Sq2s6
X-Received: by 2002:a5d:4a11:0:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-380611585f8mr27888376f8f.23.1730878724609;
        Tue, 05 Nov 2024 23:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmgzM/arur25sAUmIdHuEPwiRsmw/IhtglQbWAZMOkmhbFcCtsJAcCgXz/JPvXUfIrj4BoSQ==
X-Received: by 2002:a5d:4a11:0:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-380611585f8mr27888362f8f.23.1730878724290;
        Tue, 05 Nov 2024 23:38:44 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c08sm18317626f8f.17.2024.11.05.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:38:43 -0800 (PST)
Date: Wed, 6 Nov 2024 02:38:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by
 default
Message-ID: <20241106023803-mutt-send-email-mst@kernel.org>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
 <20241104184641.525f8cdf@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241104184641.525f8cdf@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2024 at 06:46:41PM -0800, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 16:46:11 +0800 Xuan Zhuo wrote:
> > In the last linux version, we disabled this feature to fix the
> > regress[1].
> > 
> > The patch set is try to fix the problem and re-enable it.
> > 
> > More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> 
> Sorry to ping, Michael, Jason we're waiting to hear from you on 
> this one.

Can patch 1 be applied on net as well? Or I can take it through
my tree. It's a bugfix, just for an uncommon configuration.

