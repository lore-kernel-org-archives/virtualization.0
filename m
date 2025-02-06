Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8851C1624C8
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Feb 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858195; cv=none; b=OTBkjVxlGfOl1eoRAnzb//OCh4d96N05tK+WGoz4o2OgMdOJppA+3noB9TPsmmM3Ly3Ptyc2hpWJHaRXkjo3o6ZdP4pYD6q0ZdQ3atrQ7MUOO23t0XATetM5qbWdRh1I6HB2ifwjFY/tliSqsi5SXiVh2cgVftWWHOWc9dyEWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858195; c=relaxed/simple;
	bh=Sz0yAKu52Q/DkcVZvMUnojW6qo+VO61Tj6LBMXUj0n8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hzk7Ao46CL/G7jyYQmAAUjB3cdxdHxKeh51fi3bWHjiuAdIeyND9IXholV2RL4504RYp1y07oFfke48YPn4uK1wEdcB4A9DxLHpiNP8OPkLSYu9IZjBfxZgwPFpOk6PxIeWlW20aUF+kqAgvs/YloTuMZQfGkpBI1F+KjlGlpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2jqu4Ho; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2jqu4Ho"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2574984708
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Feb 2025 16:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vf1mqT8ZS_Pq for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Feb 2025 16:09:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 59A1983FAF
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59A1983FAF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L2jqu4Ho
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 59A1983FAF
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Feb 2025 16:09:53 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7b6ea711805so155878485a.1
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Feb 2025 08:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738858192; x=1739462992; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkXONlGU8F89bT8v/54D+GqervLT59Ca/28JVFZb6vM=;
        b=L2jqu4HoN4hioJwwSLY6k20UKy5bV2Wz9WfJyqZvGsCyBzhzcsw8lq0E3PbIW3IQQ3
         m0Rz0zXya4DApiucZlsHWerbve08dM+ACajErK5YarrbtXGRRdmwinDYCM5vAGy34g70
         pIxZWyiaUsrFqroX1okJPMQpZ8SY28E95/6vC4jhKdYU5lTn86YHdpsxN9FqQdrOz1BP
         CdNCUWeNcnuEsg/JU0NrvcixavFbs5LJcoi7T9dkcQh8D2jZvvhV73Dh3XqXcJQDZYCC
         ZR6M74DvLmiwjA/vsUuj0R3zd+tdEVpYTqpNVMWBQ3wKHK8r5ObNos+6Bp/IWKa1d8ve
         XPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858192; x=1739462992;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkXONlGU8F89bT8v/54D+GqervLT59Ca/28JVFZb6vM=;
        b=VWTvXhNaUK8rJOjA1sOJArIEPS7vDWb6ArLKFWYMRgOBy6GNIM3hynkBIf1bqjMkgQ
         pE5REFdVVarYDJ7irWEnwhfXZaPngnuAGSJ3qFC4Jn2MpSG8u9DWYVnIFaLe/9Z+AmdJ
         mRtloM8HBfHzkBD6+f6snoCJBx4izH43F/2UHqOgY/LCIfj36NcK1e1HL8RmBewfxQRv
         qC0JspZrDEUUCC4tYw3nW31Ast/si2nxVYs347I18URpFZJrJS52c8zudAc4pVEQDn5Y
         QitdReme1ligCWv7xzQ1uzcrsybEfu8k8zWVCuwvQHuAwolB9DBNM9WPrYPUyJSaelo8
         M3KA==
X-Forwarded-Encrypted: i=1; AJvYcCV7V+a7hoMYB4hmpG4/NgvyRWXF3UEfx443VI/k1dhKBG153TyD0+buHuuQR90h9gBoinoVL9rZN8fUg7vszg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwBISAAKiDOd/biNgdb3d2SuZEHcRmpNJ5rBIz1qUZjzsFWkJvc
	i+PIHESlP6TPDL4NXuHKRRmfsgPBt73aYCc26tySvnIfbmxu8Xmd
X-Gm-Gg: ASbGnctDuGurzaR0br6ChjUDD0BmrNMhWGyQakIxj0iDimVT91aZdLtTw9fV9Mh/2Ri
	i0fEpTmglfKaS0UOLbKtO4J/65+/1ObBfESMZKizk2da2kxzG1XzpD7UxUMT5UyknQvuC+hdOY8
	6NA+Log2H6T5Vx5PwTHrckB8WjZijr+LWK46rspShrBS8k/0JaiYSn3ep7aVHNaTe9IgflPy5kS
	fxa2hV0tRUj2EHQC15JuXfiT8ixw8XXxM2UQDRnm3UyqETFL1CKqlG/txz9GXo+xNcTrR/zZ1SD
	7lnzgVaSbSNOuytJvhCMIJjV0QjuLsFb6gqhC6mhU3bE3epJc+qS3xALtXrOlJY=
X-Google-Smtp-Source: AGHT+IGt+/KI7G+Ky43LZCW+7h9o5kkC2zN8+03mInm/HQvkfRNm9I7BK0cYoEJQCJyLgDBBFNdRpg==
X-Received: by 2002:a05:620a:4312:b0:7b6:d4a2:f11f with SMTP id af79cd13be357-7c039e92d5amr889066885a.0.1738858191933;
        Thu, 06 Feb 2025 08:09:51 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9fa5esm75699285a.76.2025.02.06.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:09:51 -0800 (PST)
Date: Thu, 06 Feb 2025 11:09:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
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
 devel@daynix.com
Message-ID: <67a4dece7b7e4_20644429480@willemb.c.googlers.com.notmuch>
In-Reply-To: <8b389981-c04a-4d4f-8a5a-043b4cd6e8db@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
 <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
 <8b389981-c04a-4d4f-8a5a-043b4cd6e8db@daynix.com>
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
> On 2025/02/06 6:21, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> hdr_len is repeatedly used so keep it in a local variable.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> >> @@ -682,11 +683,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >>   	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
> >>   		struct iov_iter i;
> >>   
> >> -		copylen = vnet_hdr.hdr_len ?
> >> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
> >> -		if (copylen > good_linear)
> >> -			copylen = good_linear;
> >> -		else if (copylen < ETH_HLEN)
> >> +		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
> >> +		if (copylen < ETH_HLEN)
> >>   			copylen = ETH_HLEN;
> > 
> > I forgot earlier: this can also use single line statement
> > 
> >      copylen = max(copylen, ETH_HLEN);
> > 
> > And perhaps easiest to follow is
> > 
> >      copylen = hdr_len ?: GOODCOPY_LEN;
> >      copylen = min(copylen, good_linear);
> >      copylen = max(copylen, ETH_HLEN);
> 
> I introduced the min() usage as it now neatly fits in a line, but I 
> found even clamp() fits so I'll use it in the next version:
> copylen = clamp(hdr_len ?: GOODCOPY_LEN, ETH_HLEN, good_linear);
> 
> Please tell me if you prefer hdr_len ?: GOODCOPY_LEN in a separate line:
> copylen = hdr_len ?: GOODCOPY_LEN;
> copylen = clamp(copylen, ETH_HLEN, good_linear);

Oh nice. I had forgotten about clamp. Even better.
 


