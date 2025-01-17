Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0C1D5CE5
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107825; cv=none; b=Q5NbnyR2EhTongkWUIzoJCzT+XTNP8N/MOPDd992iyRUh11GR+sa/IImlHqweFSvpNUhnt1ONUgyH/ly5uTANGoCYFezhsAMLldKlNkCRNxoAj+XlT0J8ANjHc89+liJieo0D9gRd9713uFi2AShmmJXzi7V3HNI2Ylw5Wu5DzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107825; c=relaxed/simple;
	bh=RFR3/cFbGnpLYips6b5vBfbBKmTBrU1/hib1nOzR0KE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qtMcUtGgUosAT04A4YE1gdTIk+qDwgoKYAVawEum2yIYm60NXAe34KkUVHo99sar6jcuCuQ0MShCtm/nelfrxVRF5OVfa6K6lzw7Q//eyH6MwCZ/hocZLOcp7UO06+BNHfiDngSCOQYjSs1QyFM+48E3VW1+rI42oS/Xn7Ji2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKH6HFgw; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKH6HFgw"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68EBF83A58
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6Z_XSFXhfPZ for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 09:57:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A3E2A812B5
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3E2A812B5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mKH6HFgw
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A3E2A812B5
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:57:02 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-467a1ee7ff2so17664231cf.0
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 01:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737107821; x=1737712621; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovdk4k/vCUwz5uPdq8Dv4BPzFQxBElwSXmwKsXlIYSA=;
        b=mKH6HFgwHK4KSckyLQiNdav5K/XT8uwB5a6bQcfAuBxuadnLm7z3vPhzRpgk+37aQA
         d0JNngnfmafAThwrckfBD6p32sN3wMS97QYz+E51px8WYl8b1wUtAR0J0lY78b8ncqH0
         bTo6t7CZW3UmDn28u4uuYZDI0lPFj9MGnoBA57HWIYfmJNYnlQX4nZ2kj4yyAeOrBYOW
         U2URyjf/rhJm3kK5ifQQKvAfCzUAgt5s31aEh+o9BN+uMjBDlMuVuydQFdi0A6mNKC8H
         cJ9sooPcwJXEnlKboWAbfL4O8jcI+1DJJUqVJQF8oZsxVYmSp0I/R3x4YhseTYFBvL0J
         PwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107821; x=1737712621;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovdk4k/vCUwz5uPdq8Dv4BPzFQxBElwSXmwKsXlIYSA=;
        b=EQ7i/Trd03JNDKy2qbwsQdEEC+t1wVQlMo2WXbbWIWa7cN4Q+eqNi7214t8PZujPxS
         wBLxDX/+s2WEAjllFqqlChfZrPP9sF9lOyJB76V3uaG7+YGoiogLSjAFpBvB5Kunmfqu
         BabjZonwP5meO/vlUTygg+1RAucFVuMiWlpeYBA1eR+gABvgL3wCIFKcbAZEniJhvfPl
         4Yo88ckOGQXd51iDAbPMuU6fXL9H1Nx/wC9Ym0IJBYkJn3KJTxUfyopsasNAQjtMm6Tg
         BB7dSXfi72dUd2aaNSDTIfXGot1s7sFw41drY6h1yLq7uHqoYBe3n6SmCIIrgHXOo9bX
         BBww==
X-Forwarded-Encrypted: i=1; AJvYcCXPUqplCpxtYWinJ7XFwCTlrvKfYaBJutxyZF4orI9S3iFfWvJjjcTg6xwNmTC8hpR2N6qLervUDom46EvYpA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzVX4gbYVmu29zsGClzoPGnIus8uZ8gDNWNAC7YR6CXX+/8JTkJ
	BqMNxlGeJ5Qyn/GgnzS8qf6CI0zISxh8F/Lzn+dl4KjxLb+MlunP
X-Gm-Gg: ASbGncto/MzGpLCXYGafa68QLYcl4JKWVioBwUQQkAPqige/BAUOgGZg85tmYOC9cu0
	EVyCKLLzmTJnhiP0oLi+W+XO7s1LbzoAXPaR9xI5aYkW/YZ71RK9rhsd7r8pktHv1ptFMRdd/2Z
	DbkRG2r3/KJ99QB1cYOvbRr1LBv6oDahYBrd1snUrtYqb6822f4r/PoXQ2xIOAcfC9Iiqq/O3HZ
	1UKhy+kLLtWPYPqni7WlGLsq8Gn7ntu3weCh6cdQoY/r+gCu0cDuzH2C9mY1NmgU9wq/oeOK8B8
	KRW0ba0IS6ZEk5g7ZtSOBOogu5F+
X-Google-Smtp-Source: AGHT+IFschQx8vBdX+dVeL7yaPsFln2MhoSz+0jIUqp5PMdVWZN9/2ISB/pefM48R8qe/jWfCm8mvg==
X-Received: by 2002:a05:6214:4988:b0:6dd:5f90:16bd with SMTP id 6a1803df08f44-6e1b22349dbmr38642296d6.41.1737107821259;
        Fri, 17 Jan 2025 01:57:01 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc111e3sm9808596d6.43.2025.01.17.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:57:00 -0800 (PST)
Date: Fri, 17 Jan 2025 04:57:00 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <678a296c687ee_3e985b294a1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-1-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-1-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 1/9] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
> future changes easier.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
