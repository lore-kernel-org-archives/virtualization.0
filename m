Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166AB199E9A
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372075; cv=none; b=kntSyaAo8FpL6+e3A+3+NBKKpCxllr504fscRQa5rGbNf203nV5gedDaXPHVCjh4/V4oJtYWgqYV5urx0X5tOif3x0yB1TnLQZznr+gqiB20BZGnPtnpujBmppcUZhx17wZviE7TuIVcV9qYEUa2Sp/izHm1cKQPUR/L+mku9/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372075; c=relaxed/simple;
	bh=FFlF49Ndcu7bSY/WqS5XDeOlTqds0cZQy8nZ7PQMmBE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=huM6W68Ie8W0h/YT/maTM4OMKKmvMYAalJNgeGtsBQ8+f/JqzQKOEKiF3j3zrZECVqb3Bc4k7ooCIcmOYnnLcxN8ZriGKpk3FiF6aaj1D6hBGpyeGs4N88zZnR3GOYOBKcFMQK861D9dQx9AeItt7ONsIS6qtCRyl4xatqAhLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At2lHlZ5; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At2lHlZ5"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6E50403C1
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:21:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5HpO9pgdmnlv for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 11:21:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D5486405CA
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5486405CA
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=At2lHlZ5
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D5486405CA
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:21:12 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7b6f8524f23so549199885a.2
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 03:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737372071; x=1737976871; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMQYJiNSDjtYISDtLQzbnRXfj/hyY9kWIt5FzEKX0e8=;
        b=At2lHlZ5H07lvHgDQBFWhLMeF7GSBsgOj2TeXS1onI5OEgv1nqe5Q9ilTVvrCJcrJO
         iaTERHhIqtc4keqrTrfzQXzIdffDT2SHfquB3owiINi+Ia+RtSLwYHZLpMRZ9HXeu46Y
         n/KU/R4cZ5/H/q//cZH6LupJOvqaIQReb411RKX2+2VdHQQvjZsy5piF0kL2UHOrSjWb
         +iVx++bdWopdeLIwKTwuHFNRqAlwcgFN4RTwgeOP+hv+3VgpIbiBPbp4eIP1EOyRtALQ
         sRD8vjVoiy5SLSSYvjgiQIlmIiKS9LZhqyDXxW4Iq3rVSLvANkkrBgmi/gBUzvvJglER
         i/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372071; x=1737976871;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMQYJiNSDjtYISDtLQzbnRXfj/hyY9kWIt5FzEKX0e8=;
        b=asJyWfnpIzzq21S8p2MGnveSXy6bSRBOdxKj7ygsQp3FnAu4U64NT/05DwV0h8jGEe
         rsA3i0tyEnT+c7CNhBXjVsDIiS6BCXlomhbVszX9qI27lNz/6699q7OLCeyQojjoCMNa
         Qrlc20MakA4M0Ltqp+x+B9WHcYn/zS4Vx5ONTu1Zbpgv3yCpN7Ec93DJBuNoVd1ICzLd
         iUMNquSBW1sWcXi0Qo4nuReQzEh4ZOLhi7bNjQZ6R2OzWEDxPMC25YDzJx4dFitgbed9
         0COUI3fo/nKqFWFDA1KI5Y354tXbujyM5gZRE3JQCiz+2aJ509hkuAuyItxaS26pUgFW
         2Upg==
X-Forwarded-Encrypted: i=1; AJvYcCXjd9QSsZNxdcC6sOUwdGPxJQ0EnKMFFGFyX5bgLCTtAqgkUV1zahfP4gNPw1lExr/o0rzCHXisNTYLFPK4ew==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyevvEC5M9ovGaLgfCSv4h3seLJ/Xh0u9C6xwiaALvj4GWhxT9Y
	8ZXySU1lW63wGuh9C32B9JoCAXHXychRLeCRDJYCu/blafSH9596
X-Gm-Gg: ASbGncs8DNlCYH2mxu7cAp6rjgJPd3xK/WUxXjByMpjArnMiniNsP8TIt3gnKzIOmJ+
	4akiEW5xc8svK/al/lmruW3pE4wgvyN3v/OVIddgJZimZ6cT3kjdB9DgOINoeR2l8kY/jNDmCI/
	AkX727WgoS9FukH6oq7G3g64+ik268VhBUemDXiShZr3rigwn0X+6HqsXmCX3HAF68EdBbDFEnU
	gO6gxuIkQaizSEEiEjwO6nDGDo3rSKqQMYTPX77vRw0XPEuQQHHJ2WBR8oLo80cUwPtJ2C2gAW6
	8VAAdvCMdPKEqG1GhX7U0THY1Of8yFlvhHuDHxf8eQ==
X-Google-Smtp-Source: AGHT+IGvsCFrFHwRRgYBN5w8OcJpAZzq676HslkeBClKtRNI69dAi2O4pLRADREXBOwAOfvNQkHoFQ==
X-Received: by 2002:a05:620a:43a6:b0:7b7:142d:53d2 with SMTP id af79cd13be357-7be63248004mr1940175185a.41.1737372070030;
        Mon, 20 Jan 2025 03:21:10 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d98ffsm430581585a.85.2025.01.20.03.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:21:09 -0800 (PST)
Date: Mon, 20 Jan 2025 06:21:08 -0500
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
Message-ID: <678e31a4aa4b4_19c73729488@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-5-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-5-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 5/9] tun: Decouple vnet handling
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
> Decouple the vnet handling code so that we can reuse it for tap.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
