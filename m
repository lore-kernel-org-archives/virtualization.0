Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B79214809
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790057; cv=none; b=lQ1NLoIWtaCLqxsTVc2YuwoiBALq/vtzGSY9AIl1BQqXo0SY9F3+VdkktdEu9cgYgGh/r6ryIkRGSsSu2f2lsrN/wk82cd3TZtRHmghQgZnwf3c8Frd/vzWSbekiSi32bl7+3ZnD0TQ/BzJ1pohymgvArDBtCZO+GDyRo6MqqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790057; c=relaxed/simple;
	bh=KugHMl11lphY7X+eKVMkQ7YSdoECqG16VgpjtDZyfhw=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TV+FsXHr80JEEqHeI+Q21Xx5O4LQypjWUWPkLLlrMJqMqa2c3ot1BKGgaOMtOt3HrIK+jPcGs4IdZnHwpW7nboISYQVWTOdIdWkGZUX3cP1jFkBa/LDC/jLHzhFuNP615/n+5TVxd3w7dXpecnndEhwu24RAQ4CCHXHi0fEk2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/ruoY8K; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/ruoY8K"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8F0142693
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3C_eBtiC7H0N for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Feb 2025 21:14:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1EACC42591
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EACC42591
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z/ruoY8K
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1EACC42591
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:14:14 +0000 (UTC)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5174db4e34eso876844e0c.0
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Feb 2025 13:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790054; x=1739394854; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Atkob+jpFe5XAV3H/mgAKiaXJzCzAm2xhYQkiL8EHq0=;
        b=Z/ruoY8KMFPOi2qPzp0ygM/DdyCh6EsPJ3wyRoaKYnIYFdJWT7a/ZsfkqIrpT7SDZV
         x1xGSlYPnMw8dWJ9K/tSaZ/DoyTGwSMTvJakBN41oVZEX78K4QB4950kRxMlevWhKOxy
         undnbSJmpCkjLdc7XOy38yh6o20ryUSy2E3fEEPPmwbdCiIoFd9xOsAOAwC7RNSHeTGX
         HU1FKV8yUy2vcjvxQEpdUXUBUWan7kzOl70/7YjumW2ADjECHEIxXFlJIjCuBDU7yR9n
         a3zI8VcBcLM8nJVsN3LLdHNnwBLu9ayy2f6nmB9cLp+rwrRRWRnJ7F0zpOKYr8uC5IqW
         00ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790054; x=1739394854;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Atkob+jpFe5XAV3H/mgAKiaXJzCzAm2xhYQkiL8EHq0=;
        b=aBpSWaNoM4kUhm9qQFRuoCfY6jeA7DR5Mk1MHFM8CcfbPae6/OlPMCk+HcB2krAjXT
         4KSJuphkBGw5hG3D45DJOwZ069okBGQETDStQVHVp51XVwQEjWvC4S/adwu5BFhHrnQb
         2Kw6jLBg6MEgxTm41InLnzzBMRZnl9cpsJ45gukukC/IWoQjno6tK7RMETvyAE2rop31
         1dUztHvI3aefIXnuFpPOnLEjdXTo8NmWoxa4pspQaXTvuDOm4S0tToj03MBl3Udxeg48
         RFbqp0/I8BMfgIv2R04uW7SSBzqxZyFzKT7OuWntF5KiNgPe8ehBftEV1mVBQFp8peme
         ZHEg==
X-Forwarded-Encrypted: i=1; AJvYcCV1tC+p7Q5G3ty1Mvm4x1K7OIrXOgh8nMK29SPJtGtz1GxEVlmlUgx8V5icI1qXo4rZ7GZy811FVICxgxtE+A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwF3y0fU3ZBq2B6u42w+3onxblZI7cegh1cA1FZG1zu7OCmFQJY
	+3mi6sBR3Qvbonp3j2QpdDOC/5jV5tocjqwvaxoLBnH4vsb9Z/lr
X-Gm-Gg: ASbGncuSOd/vQN61jy8KkyoQEti+nvHHHJTC5IAAswCXsgy49djloPLSKooOapuxqEA
	49bJCNBvSNELgAZueaJ4Jx0m3kks7qhvbFjUvBCsAo2A8Q7/2L/qnCtjV9hzHljvzRRcTzb0Skh
	6oCAgkjSRbRKD/K41YmjIhPNN1YWwaJjXLd+9vp+F11lo7op845APRkY7eOev6decmqtOcuEHym
	4cMK5H+5PO7jisf/x4RSEtJ+9quqtUGWbsnuPuQvS8xWFryxZAe5+WNfgtpEjiH3afJUDBao//o
	x5qPJS3AFQQzRJThphc3Gj5sPMQD9EmbJ0QlXrwLvxgVGZ593q/j+Jv581JOA8Q=
X-Google-Smtp-Source: AGHT+IEfZi+/l4M87UPw5/vyc7KRKZkS3vvwSExWhswz2jpE396W7WJFjzoCPLOYlEnFqXotGyeJHQ==
X-Received: by 2002:a05:6122:1b0e:b0:50d:39aa:7881 with SMTP id 71dfb90a1353d-51f1b96557emr632876e0c.0.1738790053731;
        Wed, 05 Feb 2025 13:14:13 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1be86fasm1914516e0c.3.2025.02.05.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:14:13 -0800 (PST)
Date: Wed, 05 Feb 2025 16:14:12 -0500
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
Message-ID: <67a3d4a47801f_170d392943c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-7-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-7-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 7/7] tap: Use tun's vnet-related code
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
> tun and tap implements the same vnet-related features so reuse the code.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
