Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955A1F4C8A
	for <virtualization@lists.linux-foundation.org>; Sun, 22 Jun 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750614018; cv=none; b=j/YoiFyv7MRk5sSqyuYYQp9BvUrZoSzVyyf638/ILy0CaRB4NEhwgX/+UYPvSZKWl1vky9DOc+maobtjjy5OpF6J7K3SmLbsX1iy5xUysnd0g2MljO8ZvCoV6WFy4lE7cP4kYu8nQ9XBoTUry7/eUEXop0BBB1WWHduY93v88vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750614018; c=relaxed/simple;
	bh=JBS6katIuy9abXAwM/EgfQ0vNXuWJoKtGDCgsMvppwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mwgqy/3UuR8diMO6jcQdHB1CiKiTNtONA53g6Q5a0FxfZY1LmHzwOowyHhIOonvKo4MV22qKjbtIeTtXZC5HAbItArJSbyhl3fNqxDnSWuEgqe27clIEzRAApWMEH4h1S4jmYImqHUvKtmru7u28f5iTzescdIG9BpunFpYEVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=G7b4y+7s; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="G7b4y+7s"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEE5740676
	for <virtualization@lists.linux-foundation.org>; Sun, 22 Jun 2025 17:40:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 45Q4_J9JKV1A for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jun 2025 17:40:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=yuri.benditovich@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EF9154066B
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF9154066B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=G7b4y+7s
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF9154066B
	for <virtualization@lists.linux-foundation.org>; Sun, 22 Jun 2025 17:40:14 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4a58c2430edso38608681cf.1
        for <virtualization@lists.linux-foundation.org>; Sun, 22 Jun 2025 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750614013; x=1751218813; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JBS6katIuy9abXAwM/EgfQ0vNXuWJoKtGDCgsMvppwk=;
        b=G7b4y+7silqmBkirS2E4Gw3DeGUl7wKO8Vi42yUhPhai6mKjdejfLO6mhy9t359rRL
         sV9AKds4amv5OKVkh1OHa46f4R9yNBq7NBUyGmJSVA6H0LQQPu/nYlluw4lUQqVYlynd
         XXf2H0YZmR9t1M5JsPZIunq6SxTLg0rqJ4H0gw7C8CvqqLZUPMyvOTOSVLPlbaR4a5aO
         ungCcn05mk7QekW1L7AUGALvHxTviEXdA6DdSwhsILXn+X5Lb6YS/2337tO7+G+lk7FR
         lUDQN4FJrnZd7H0TwD5NSZY+eq3ZIJ2+jPXc6AuJtPoeTYp+oLhWNYkImkNAyc26C2OM
         qsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750614013; x=1751218813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBS6katIuy9abXAwM/EgfQ0vNXuWJoKtGDCgsMvppwk=;
        b=FSZ7xFShVxkbamR7om134JbZL25P6wlwDW0Ykkrrbywz14AwoRoknCaxr/qBo/CUif
         iiJWaQOUdrvnv2nKb1nOwsMAZNOkv37F0K+PhlooBWdQhp7kxAhqLem3DB/uCPw27PmM
         WqiHijdc1RqjMXKxvg81xW79rrdx/TV33ZYvX9GqiBOn6QTQUD+hJhftTJjxkxK3hiLw
         J2nXk4xUEvl/j4pOonRWmE80tB58AuIYbdxd+XiSqbTDS57RMVUv1EvmtMZdgMuRjl/Q
         N8tY3G0ohBc/icxGH/V/ySDV32ImI2nAX8h4mbUgwNZ7rhvON8UByszQLhsvqIFJ/VOJ
         cQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+gY9ZnlGcazYDFO4yOGgMxLIgpAbsYKYJGm1/lqkZ1mh6mPJHTj3sFIA6v8hbph9dgOKckgeREDsDPMAXcw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxRpAHPi+Ha9wkGuo2BtOPEH/JU1E37HxlPdkW4owWNO4Bo96EK
	CK++UvpoASA6ekTf0o2gQQ87G6JXXG7hztTiWiHtiN6ryCMDK6veYT7mpZKRG2MUS9hujcats14
	teGaoYEqPb6w5yZ+bx5r7k9Zaa2/0zFTjsUPmdso2zg==
X-Gm-Gg: ASbGncsdxU3AbvbAfMNhR1TLpNALqiUe5SyuLpWJ7hYn+3gXJgtzlDHum8cNubktSso
	co+S5xlVA2WVDaBrp3AQBIA45K6XP+8rtWmWcT4hWodIL8W7mfbLm0s3Xt75hpQ8ZCWkQjWnoxn
	9X8Kot30Vts5bnechHiLXmmbwcgrc+ToeJnnou4lbBtyuhcuXa7u+VyHl5YsSmPmknHs01eOFP4
	HLfvdEILjQAR7IM
X-Google-Smtp-Source: AGHT+IGAQVA4j9B6bOXEQavSPQk4pUsTIQfktiOkSDRcEtYWtj2nMKnJm6GAf6TwLLKYEA7597CW46OoVjUcTVc0rKg=
X-Received: by 2002:ac8:5707:0:b0:494:b247:4ddb with SMTP id
 d75a77b69052e-4a77c2d6173mr135279261cf.4.1750614013493; Sun, 22 Jun 2025
 10:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
In-Reply-To: <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sun, 22 Jun 2025 20:40:02 +0300
X-Gm-Features: AX0GCFu7f7UEMKygSwaRuFS-QXgCw4dhQ6kVLLsvANPI-_VjCLQSaQpxwUYjwO8
Message-ID: <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Yuri, can you help to clarify this?

I see here several questions:
1. Whether it is ok for the device not to indicate support for XXX_EX hash type?
- I think, yes (strictly speaking, it was better to test that before
submitting the patches )
2. Is it possible that the guest will enable some XXX_EX hash type if
the device does not indicate that it is supported?
- No (I think this is part of the spec)
3. What to do if we migrate between systems with different
capabilities of hash support/reporting/whatever
- IMO, at this moment such case should be excluded and only mechanism
we have for that is the compatible machine version
- in some future the change of device capabilities can be communicated
to the driver and _probably_ the driver might be able to communicate
the change of device capabilities to the OS
4. Does it make sense to have fine configuration of hash types mask
via command-line?
- IMO, no. This would require the user to have too much knowledge
about RSS internals

Please let me know if I missed something.
