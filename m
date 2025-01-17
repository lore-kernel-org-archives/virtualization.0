Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953681F8920
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108222; cv=none; b=Ya/8z2619Dct9Bi66j4fci65YGTGVcz7EavNxqiI4jlSheUb9oqaqj/Qt+gmHAUTSI34mCDSsN6aE7PhiNclx9LoMNRmQW3meMWtAcBJaakFo3PxLKKXIBSLKA5v4imV56c/V6AlvyZ4KCyt6BIAs+fjLD/Gv4iwOXnBRzSaeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108222; c=relaxed/simple;
	bh=stvLBj8vrIlRxoIQO91LmZtoYhREa7PDIqDHI76BvJ0=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WWt0D2YLQ+ibag2nTVX81kChsdS3521xEIpLvcxbGxlROYavQGfBWAhkDdyAirioSq4iNDfWr+5wQ1VyFVWeaHC9lodV/4Fx9PnjnMTsJOPA2xm7GpuSK2vix3M8Zyaue/KWHJB/tyXP+d76cYr3mbYxF0y7Jgs1i8qYz7npvmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ctb9MuEf; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctb9MuEf"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28DB760B63
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2rW-uIqvmPO6 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 10:03:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 682846085B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 682846085B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ctb9MuEf
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 682846085B
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:03:40 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7b6f19a6c04so169716285a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 02:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737108219; x=1737713019; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9GtSAfegOKtXuU9h3FM+siOFpI1M1ddzEo5C7T72m4=;
        b=Ctb9MuEfGY3CsWgREL1UILlfI2prZV0zKPgjwcwJURTx2ViySj3SgFvcg9CMjQtWhX
         cTN3JPUKl9qdsUY/xYOCFttL0GfENhNo6nuMBbNPW4tphAPZOBgCxIDNPkIAlQpd8BKw
         FlTjELk6/SPCHGug2qfZ900k5jbZae/Df6aNKs5OYj0C9/sKpwCYSp84n/hLlOxLT0ql
         hbAlOfOwIfAKTlwrBod6Ayqe8vlZFtkiUX68tq+llYW/RGHgxo95AeBfXwxYrBWRxbpD
         TI+zhX49Bj8KCkK4JTKxySqDEwFeqAHkKCpxVz9/HJMgzkYbW4Ugb8WyzLQGuvCZhsN8
         0b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737108219; x=1737713019;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9GtSAfegOKtXuU9h3FM+siOFpI1M1ddzEo5C7T72m4=;
        b=Njh+HDtYbpScRxpoZB9W7jOvsHOByaNLtOmp/XEuKO7ry7E3c7n1V6NqDr5n1Muemn
         diWN9AuJODzNEXaIQ3oFkI4p4TYq2LR1BokjBFvnCkdKayN2mar9ZCNON4VXk5AOw7ZO
         xSVp7BuD0iI9kiYVHFULCEUM+1GEBzfaW8YJcys0czciCQW4iXtQJOq5MAW3wHfTTTpW
         FhIFhRUtttpzNiisrnru91TMDge+F7k/hfZ3dsOArB2wOEkqPv1q3inr+QEjJergwIIW
         EhO5JocTVroNizsG2QH2jbkYcU6dgmumpmg3EZz7qQONOYknFXjOplDUI1IkuZmiojfs
         F4Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWso4hfGFRi0Uvxl6shcfHfV5J9zepR1hS0Br4PU77XClXAReOxpvkv6xehYeB6SoTxhyhfhtPw9/qsr1IhCg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwApe3NAWU2iq2DjjGAyXhtdkRrNZEENiJdEsWQnbupC5D4zs6Q
	o5A2Rlil8nf1ADDySiIhUyk/2RVTNnQ9NMFl3MMoiPtcLzkpAtJl
X-Gm-Gg: ASbGnctixG/mitBz0wWk8tq61KN9WMN+HL9x3CDf5JNcg7mKAsPZyR2WAv913+unDYB
	rYqMu9x1DaaGdzE3rKguh2rnljGVuQNPR5HA9bU9qrD+ZR4E1rvETBvi5Vug/XjZxaBIdFtOqpw
	aVpMFRLOWgxveclHhJziUnNfZ+FOQq5Ba7wixO/WOqQ8rlm1gZ+L3GHV9qjwRQwmEqgviYLBqwm
	3r3J+7us2INwotPp8/Eien6MJUgc+uQjmfMGMA1kZclDSY833TaSzD/nHesKFRSzgRvxk4yldMa
	ytXUf37mtjUL5UWZw+XD3vydU5Xb
X-Google-Smtp-Source: AGHT+IHAw9VdvUbvSwjtsR3613T025f+o8n8ZrH+eW7tHQF97iIfZacZIlS99j4vfw/rHbRvSMKG4w==
X-Received: by 2002:ad4:5aa4:0:b0:6d8:8f14:2f5c with SMTP id 6a1803df08f44-6e1b2180802mr40099486d6.23.1737108218910;
        Fri, 17 Jan 2025 02:03:38 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd37f6sm9789456d6.91.2025.01.17.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:03:38 -0800 (PST)
Date: Fri, 17 Jan 2025 05:03:37 -0500
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
Message-ID: <678a2af9e73fc_3e985b294ee@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-2-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-2-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 2/9] tun: Avoid double-tracking iov_iter length
 changes
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
> tun_get_user() used to track the length of iov_iter with another
> variable. We can use iov_iter_count() to determine the current length
> to avoid such chores.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
