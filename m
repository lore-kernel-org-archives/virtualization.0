Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABDD214A73
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789982; cv=none; b=IjIN+r2bfXV5MF5/gR28Bustbgz5olYfBStWOc54YOFa7sUReQUpnGIb7N5cGqPIu6rpQQyibYbNoixTuqgw7Dq9F2mpfPC19zoXnRa+CYZOSu4uGNBAypdiNv0D20rRWh9vhkmwWB2oEawjDCO8FeJtmB1xQRsj/35011r3j7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789982; c=relaxed/simple;
	bh=JFEi2wLeGZOf8BHQEKqWbZM9NCkw6C1VmawHgv9xFhs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tvOGG0/lqebXGwgaPDeIlJJJ6U0wcEM2SAC2yBgkUOT7d8CdMEL7T/K9YO/2XK0/W2GcecSGqKSUdJd+D4iUGLSjPVjHkH3IkwM3wsSvTfVCwUN85Vh9KyOI9JtMfz0oldQzGKLk4B9FZJezPgSi/GFy4C0WykV/W+RFPbh6md4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCI/F77H; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCI/F77H"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B508413C4
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJLuJoB6vNXL for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Feb 2025 21:13:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e2b; helo=mail-vs1-xe2b.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C13FD413DE
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C13FD413DE
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nCI/F77H
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C13FD413DE
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:12:59 +0000 (UTC)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4afe4f1ce18so65472137.3
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Feb 2025 13:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738789978; x=1739394778; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=nCI/F77HRdG1mzI4Ts+gYsmCWD1wdjGKsjbOBbVeDzP5y3i8NqjpvIQQT9oOrAl814
         jO9WIF6fYSRww1od2qtZFxZjd0xqsEsc0rKoEFmZp+bsAsYly01wNpPG2bK0dkHQ5LnI
         of7V37ZbAXBvp3tlGWwOkPfefsRHKdVZMuNnDzPLkH4hoidxvx6DGx2hiWO0IHCvF23X
         dP2Wrnym8Oyo8/PFhJzqJaJEbvhOKhoom+dErvsL+1wJQcd66Dms+vwuNyUwtNqwg65K
         GZzXrlfYv00BGfVGPqZy93BfIntzT3p15gWymyIwdhuRypX7OR8qU8Kgmm0Ylf4OKwM0
         Q3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738789978; x=1739394778;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=ozzZOZTidpM+yrQhdSu+oKFRWlzRn9KoO/0eBQhzB46DiOwIUYJkrajLr6BkODQQzY
         5UyWX1M4/KI18U68Z8LEh4xM8P0Wpkw4tQr8lt5wjO6eeNJxxvg3+6GL2nAGWiqxgKRb
         lq94FWPtrS2/ioVqD5h7xR/GQJr6IlNpcFop+g3Iir5JuaVv/pMEo+sGNMTvsB3+Oh3V
         n2W+Z0A3AXM7WQO63vw0xDaWYOGkAbB1m3fXI6ce4pG/mCGh0kmaXW0Vv+tyas2K4SiC
         7MfkMh8XfVb//MaOJyXWBICexsSOFGcstfh4y6+fKY3E3Obc1KAG5WNxWAVGG7w8zMpG
         7zLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzKuwQ6httvq416E6oBYKzKc+LRbxQqrgUAQEpO8Bx1UYBazaGngqxtFbi0g3omVOzmQkXR4KW2Lfq/9EiWg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyMVR18ZiRVLpCM5p69eQqfosq+ykekezHWj2pNwrlszw4PhXpv
	1gYCv29TyBLXvlpVG0VW9PspvZqUu/2rO67o8Vq/PvOEEt287h3v
X-Gm-Gg: ASbGnctWO85pTKkwf1lr/KjbvX4lbjF7EjOGGUo8JF18DaLR2WWAVpnmmGQzSf/nGQd
	nKVRkRvcgwy6Ov8BafXLr2/zbqyLwkROO8MAJ2Wn3pQKXJXpLA7XeC/w2emRQDEJF6stiMW8OvP
	rWkUaRWYuutVEE6nh/oluaGKnko0XKAQliSbG9njWCAeuyQpgNEp44AHfakKl33POfHVn2Kn7S0
	JqPwvb8l5o8m3PuBtGvqka9p1RhYbQuV89K6AeOym9xjUBOVUpJJ9LauE066BHDdv+Yvlw/pSHm
	ijE10xA0pqmlvd0nNoHRW58FtZSrQSvcBMQBX+Ol2PNgNnm3nqk8YvtGlINGxj0=
X-Google-Smtp-Source: AGHT+IE/LhqpvYWyeg5YI138zii1Tf41J5g6QM100haEEOrAXQ0Rs3YYuJinwr+QJROJhcSFnZ0nWg==
X-Received: by 2002:a05:6102:d94:b0:4b1:8b53:2987 with SMTP id ada2fe7eead31-4ba46fb5a4emr3251472137.1.1738789978520;
        Wed, 05 Feb 2025 13:12:58 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1d947d7sm1928864e0c.48.2025.02.05.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:12:57 -0800 (PST)
Date: Wed, 05 Feb 2025 16:12:57 -0500
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
Message-ID: <67a3d4595ad82_170d39294c0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
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
