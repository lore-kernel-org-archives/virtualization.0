Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E7219EAD
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431663; cv=none; b=T8tAnFiyycFRV0Cj2l8usEu4o0ZMjlicOMVd7DdjWoiy/bcm8dNsQCSzCQOaG1Hu1rnTjkuTzNi4D/Sz+jFCkXL3sRptAypk6s0ymBxX7iZGjV8wXibWEylPfL7HhQIXXmVLuBKGJzi0CRO8mXQ9cNdIXni2QvY/SgYU9m6apfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431663; c=relaxed/simple;
	bh=tscVKlLQWx7s/13Gw4/C7+1Jj4CP4pCVW9+Lu+UEVyk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AsbC4SdXU7A8JLDMbvZqcsspIihPfQ2G362KHRNsDjtfHlam4Kf/1bZCEfSgri9+W+ycA5IFL/kjb+VYPqNqr/1X4XjYwl+c6lAKS4aMn1oZle2JckJ1rPO6tcYWR8S3Jyg9IJgx9SXkqW+bSArRhWPE+XGWXnFdNayOkukC+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDSCd6CW; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDSCd6CW"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 571564085A
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:07:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4dSFqTmpuwCE for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 14:07:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3E27B40848
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E27B40848
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GDSCd6CW
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E27B40848
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:07:41 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7b6f1be1daeso79935885a.0
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 06:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736431660; x=1737036460; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tscVKlLQWx7s/13Gw4/C7+1Jj4CP4pCVW9+Lu+UEVyk=;
        b=GDSCd6CWX+YY3SAcqIw6FMukgLxKQF4W725ndRtOBmpAF/E7RAzSofvFc8A6A654NQ
         lSriArEQYYxZu5vtqmWeLqlHSO/oTyLgVekNq6LmYVjHBuZUq7aRP+yIXQ50VfqYD5hj
         6BhPnKeBKXeQaQZeOBUx6TYRjSYTuQyfwhOD/bMsnDvnjWcVcMCDoPmRVrLO5Y0HBoTS
         zyOBiKdcwHkHbXg3U9Xzxy0AuCH9/EwIkh1HZ/p+E094r6M9IeZ/hDzqKrkg/buOQXQI
         /vJzHbWHCuARx51yMMM4wXSEg0Mjf+58BBg8ZNGK90U2TpCsOB/v40Kk1zb1Niz42tvI
         kddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431660; x=1737036460;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tscVKlLQWx7s/13Gw4/C7+1Jj4CP4pCVW9+Lu+UEVyk=;
        b=HMte2VneO99e2jsI00x4pM3r3kJzov/nAGUO3CO5qWFRXwI9GbqslDWgZhaBUpMxrR
         Ml+EtinovVrPSSFAHv03DNkTgjTLiojbgrV5Eiu5kc4eYDZubWoZnDmsGo0bmvCQaSZh
         sOcwyne3dMe8MdSK1TbMcQAdDu6irj912aGPN/edeQiAm5lBVZuI3SP4J06EJNwIhCgN
         98xf1VEiGHXLdaFFYWi7evXkvUm6YQJZHjxphAJJeRosoR9t1BaY78xZtIl7Qak1HNp6
         YTXCfyA8lTSG7UoTUAUVPMitpWzmdRNeT/78lLWMrmzKKfhx3MKLB8AmlyXzc9NX2+nV
         cjPg==
X-Forwarded-Encrypted: i=1; AJvYcCXPjyxAnyAN9u1snntzOlIQnld4OU5eu5obBxWxyAJFQQRvTB7wlPJPVBuv8FaszZoKULXtD8ethgwQwy8aqA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxLqbtMVVcap2vxoPp7gMV+3DSPXL6s2rS2gvIG3T2vQ9zmPbIS
	g6lFYOM3nSJDEu5m3b249d4MyYU5v7OnBIH4yOLI7jTKZu50z+op
X-Gm-Gg: ASbGncv7LIHaybbCqtNYNVLKhx8Jbz0RePIK7ghrd5ieuE/t4mqaj/7ftVF3YATOeZt
	VZQYDjp13SXmUwgR7nqjB0W0iPIfIsuNly9uQsQ4fqstiezy9MiLYN7w8v06GrrXFzZHWXCffLW
	akXQetpN9KWP3qJKnxTX7n5jUO7+YV0oQhdYE9gzj6DDVna8YVWRgmDSKrI1bsui1LwIMTpXm9Z
	hqgUbBPd5LsK4cmLZxxKrEW88DRBRZcPErorOxdiLlOKwuSwRuObaytfwZ4YOawNV3Ae/7kgINh
	PMLHBGULJbxmTMNz/X8LOiv39+6U
X-Google-Smtp-Source: AGHT+IHCTMe567nASwbLxdPVheY8R7YeDB31hZF/68JU5B1pjAC7Gu9U0PmgqA1JJJu294K0BFuIkQ==
X-Received: by 2002:a05:620a:472c:b0:7b6:d736:55c1 with SMTP id af79cd13be357-7bcd9759dffmr1178409285a.48.1736431659927;
        Thu, 09 Jan 2025 06:07:39 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248304sm69773385a.31.2025.01.09.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:07:38 -0800 (PST)
Date: Thu, 09 Jan 2025 09:07:37 -0500
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <677fd829b7a84_362bc129431@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
Subject: Re: [PATCH v6 0/6] tun: Introduce virtio-net hashing feature
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
> This series depends on: "[PATCH v2 0/3] tun: Unify vnet implementation
> and fill full vnet header"
> https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com

As mentioned elsewhere: let's first handle that patch series and
return to this series only when that is complete.
