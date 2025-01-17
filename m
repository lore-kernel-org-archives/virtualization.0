Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B421FC7FA
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109036; cv=none; b=q2tUEpDeGaNRL6JFP24BD4Thxd23RTc1XmRs0p5aZedTs73Z2AKNRn0ZkyMX4EAegjk6WdE3KZ/DbLouowNLmkkrMnRRFdDhXFABg7MIxGUbY/xvddTzM3aMmUrAuWI4dCi6xqpGETIbVMoTR04lhAt7mB8M6yfgSEYMAOemB1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109036; c=relaxed/simple;
	bh=JFEi2wLeGZOf8BHQEKqWbZM9NCkw6C1VmawHgv9xFhs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EXOpT4hM3gfCAX3ehC3lm6WR+/ppblMUk7ndWV/440vuGB781q7Y6eKmlMscIi2sqNltwK7GEV2EGG+B1kc4kZounMoz/nrP9UvCw8wzhkwMPhdTrmCnvKGU907qL4a9ap4g+okeIQ3J8YDCHb5p1flhCwSrOHFd7x8QbiziYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMWUKb3f; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMWUKb3f"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E865819ED
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fqc7xipI07DQ for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 10:17:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5EB2E8122B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EB2E8122B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XMWUKb3f
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5EB2E8122B
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:17:13 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-46defafbdafso22520011cf.0
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 02:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737109032; x=1737713832; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=XMWUKb3fvcqMmdhqmqG+vqjEcG11GstJm6VxF9MPSCNNCPvoFxyIKxf46aV3zlVSia
         hftkgkWJbp6ivNDqevR6pZY9dNk40dxZiL8uTH6Tad6b/1rTEXzGxr8tXb1drOoqPDhG
         qiAhCYCx5rlkvobx/sWesPem2kFQjRVtiKdTuYCdyM9oNroWuHoIkvWNohhRr2ikJ6+z
         tfdp68Vok2GVRY+dVzlSouY5c5AU/RqhZ2lT+phK1xzjQbHqYj0s/WD0B84t/hcTX+1f
         JIObu40cNE+I9T2d5cDhWJFeoP1sxZdz9QBYs7CYCHCCog4a0H2Fbc6bAggFu2rT/QOv
         zvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737109032; x=1737713832;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=EW7CnmXc65Nvnq0Bk8uKLfli4liHDfR86KScyCyXJITTSqeDPZfPYVn4oc/LBu5daa
         ulZh0lm1UyToLneJygrJaskHxh+RjG1aqdsvmbXD3zhZwXOyhmyWI/8IAx/BkbuWSgYu
         GidlXhtqjSA68vmxpHGRMSI6Fuf2F8+qMwkevybB0OZplvsUamKsc0ef4ejvXdAtXvXE
         AJJlFpYGfNSnDxO+CNMCzcrir9tF6uN0utp1IZ/wx/Rldf+GA4Qm5V01FiaZ4dtx2mjX
         KOVol/ku3Tk130flyvRQnn5LnF4zwVwCRWgodaUlLhmiIR+C+diSZbtLnEKdCUdn8+Q5
         jj5g==
X-Forwarded-Encrypted: i=1; AJvYcCWr5khXvARn/569nRq6xTkw7Tdi3YiZi+cF6EzxZjtCCaebFQz3gsfwtmIul/qRQ1BLmWefuhiXdy1cb1wVlg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw+rbdiaz/4XZahlWQYRmB2kenJIta64FVWeh5Amoho68slO+0t
	VZvLxaoUlYVgktCgRFskp52hvEKAV+vyzYXCf2pTo5RNwcbcDWyo
X-Gm-Gg: ASbGncvyckVxUGec1Xv0hM260RvclCtDu3QUvXbiGok9l77lZDHYovNtF83K7lQaTyT
	Q7trfP2JLEKn93R1+NXXUxhY9W6tT/N47tviLJ2cQVuT78PmsXYZymCTraLTjjuEP9Tz6hJNDnT
	M7UDiBBn33L6iwAkO6P/lq2GvVZxmSyLzCIZJkr8JsBdTFNpht2iOQvJFT2y2Vz+L4Yc7h+GwlS
	GTIgjpHDDTQqnHd2eH2VVfWrLKP7WQBTgaXq50P3E46YntrQ5kZnd6ZW8hwt+v82VMpytxs3cin
	tmEXmohpCH/Vo9ajkTGKwvNNvZVS
X-Google-Smtp-Source: AGHT+IHi7GfJK6r/tRrun8aHPOSCgfPVe7JmZONv6mDjqRyn86C/st2dbOpHBXdzCk3DyzPzJ6Egfg==
X-Received: by 2002:a05:622a:201:b0:467:5ea8:83df with SMTP id d75a77b69052e-46e12a9a0a9mr29192481cf.30.1737109032691;
        Fri, 17 Jan 2025 02:17:12 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102ec299sm9805661cf.6.2025.01.17.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:17:12 -0800 (PST)
Date: Fri, 17 Jan 2025 05:17:11 -0500
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
Message-ID: <678a2e27c25eb_3e985b29494@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-3-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-3-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 3/9] tun: Keep hdr_len in tun_get_user()
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
> hdr_len is repeatedly used so keep it in a local variable.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
