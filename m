Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963091F3FDA
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470408; cv=none; b=kQsm355ucYn8EnOWMdT6AGhHAuqcheUKelEMp/SpMvvMu1Z7oK2wQi+ONJ9g8yaw4uZyfMJVRn+Ye7/xvpV3u4ieAjOCv4NISg66fkyE+AkleYNb7KJsCeBEE8ATTlbqsizpOnMKIYLTtFCdRnNm1IdIaJe8SqTV9/gelZWiwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470408; c=relaxed/simple;
	bh=RoOPEw1pnjf93BWu1H+vv+vMseKv0LAkB8QIKntc2D8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sp+PewxfYWO7oLqUiRdExoE9THJmkrHGLcv1dsF0IVTaTVRycBOh+7LCjx4iKC+c1A0O/eGgu3ZizhPXApO1BszRwjUaxGkDPPT5twececZh45ctiG3eT2lb/fFToSEQ7QsHKld2pMwNtHwacjSwBsHIQnNGCsPbB+z1XdMaTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0WIWTRL; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0WIWTRL"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 280A2606E7
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 14:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nTfKlEdvzDXQ for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jan 2025 14:40:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::732; helo=mail-qk1-x732.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 42B33606C0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42B33606C0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E0WIWTRL
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42B33606C0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 14:40:06 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7b6c3629816so302250885a.1
        for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 06:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737470405; x=1738075205; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGQfSzGMb0K2xpDR8R+dRZzW8GV9BBlFM9+N4B0KulE=;
        b=E0WIWTRLtRXc44/oZRpLIa7p2Owp2P+Soextm2OeW081XEy8vE4N672kf27+aWzCpf
         loMQJ70yAlKaB2wVlLzef7Bg/EjUA2VOtKdA3j0Hq67ZSm5rtPhsfHUT+A+EUBRXxWCt
         nljiKCPqK5NHrKR6fRHu8sxMN4B5c0SfpNNmKPvWkFZJmd8O+DY8+T3oW2svT6BD6Pyq
         HTL2neAzECWlg9gDqf7iCSiH6C+eqfSi2g3kIh3RDu46p4vEpf+i0EK3plgWOsS0AwpA
         2lhWSBRajg6RdwvLMNRDwenr4e9HISlBu4l0ovaa5FH54i18LIHxQhM19KrKij9lCqTK
         3M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470405; x=1738075205;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGQfSzGMb0K2xpDR8R+dRZzW8GV9BBlFM9+N4B0KulE=;
        b=vWCrPBHv+0ygPGLksjI6v1tckO2rnsQ/xvdn98j9goTlohJOu3xXyBvLGo0qoqnpae
         PlUge8EpaHQHglooBme7eOr0jsidTy18O4VoBZSteZ7vU9/XcRbrCiqWKJLg/NEgN9va
         sh+fi216sYpDXI1LQygyBU51RuWrVpCvcRy6F7u6ieZMEHxRRz8M3BVu3xi+qqZehL+C
         P631Giyvc6EsOvuQ7sdC9ke5iVwm8qqyneKZE4ysS0y4kCtm6xUzJr39UDbUb6L5D2eA
         rrgbdijDOjrcboGO8h3D8AtwaVKUvWeWW6zZ9Jue0CT6gphE2H4i2X+yp6BrOluMNrn/
         KcOg==
X-Forwarded-Encrypted: i=1; AJvYcCXpSfC3uar4s0jNUBZPfbLidcY075HLgBmgh6oF8s5mBHYnKpzg2rJF9rz6c8jdksRPSPSiKYwqk7pWjUL/9A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YysFMYmnmz+g2oesAoc7ezJXeKqCmPT2fiIJB5fDKDwPX98Tjr7
	MvhTX77AaL8T6uZ90UlnHKHqfc/O0YmspPjlut5hYN1zEjfx/9n1
X-Gm-Gg: ASbGncsFuLPucourRLhAS4Fwv3r0tQ4KaRn6librsEMpnxa0bBSFGDs7gS7Ymp7EILm
	RUDR8AmbAV6M0gUL5PiKiaQgCMNf5pRPYPfTi+D3pQi/fxz/zmjLvnc3oFkO1R/DIX7wnI0hrRR
	/Pnfq2Ix9gyPZH5ZLiodKh/Rg3P3zitgngSpCQCEi8BTh2m0aUKIP4m8mNECCENL56QwfTbeotd
	KP8F8qhGVbxOXRCkFJfr4aLm6FHhjGXqYw9UDf+Ci29tGMpbyIjsq8sTEU1RwGFEGxJ1EuZG6NQ
	cKQi8I3XL/hhbxMFAwEzPoFrK+6lMtniikVMP5BLkg==
X-Google-Smtp-Source: AGHT+IEm9uh2oi8GwqrdV15LlWS/Rqn7wndmxNzv/1SRiy16/A1ivtq3hKiACLTKq3h6bJm+AeDuYg==
X-Received: by 2002:a05:6214:c25:b0:6d8:899e:c3bf with SMTP id 6a1803df08f44-6e1b21c47f9mr251116416d6.34.1737470404863;
        Tue, 21 Jan 2025 06:40:04 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce3215sm51677466d6.100.2025.01.21.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:40:04 -0800 (PST)
Date: Tue, 21 Jan 2025 09:40:03 -0500
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
Message-ID: <678fb1c3d123b_23e15a2946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <806def7d-16f3-4d53-abc8-7d18e8c22dcb@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-8-ee81dda03d7f@daynix.com>
 <678e327e34602_19c737294b4@willemb.c.googlers.com.notmuch>
 <806def7d-16f3-4d53-abc8-7d18e8c22dcb@daynix.com>
Subject: Re: [PATCH net-next v4 8/9] tap: Keep hdr_len in tap_get_user()
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
> On 2025/01/20 20:24, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> hdr_len is repeatedly used so keep it in a local variable.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   drivers/net/tap.c | 17 +++++++----------
> >>   1 file changed, 7 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index 061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8..7ee2e9ee2a89fd539b087496b92d2f6198266f44 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >>   	int err;
> >>   	struct virtio_net_hdr vnet_hdr = { 0 };
> >>   	int vnet_hdr_len = 0;
> >> +	int hdr_len = 0;
> >>   	int copylen = 0;
> >>   	int depth;
> >>   	bool zerocopy = false;
> >> @@ -672,6 +673,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >>   		err = -EINVAL;
> >>   		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
> >>   			goto err;
> >> +		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
> >>   	}
> >>   
> >>   	len = iov_iter_count(from);
> >> @@ -683,11 +685,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
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
> >>   		linear = copylen;
> >>   		i = *from;
> >> @@ -698,11 +697,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >>   
> >>   	if (!zerocopy) {
> >>   		copylen = len;
> >> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
> >> -		if (linear > good_linear)
> >> -			linear = good_linear;
> >> -		else if (linear < ETH_HLEN)
> >> -			linear = ETH_HLEN;
> >> +		linear = min(hdr_len, good_linear);
> >> +		if (copylen < ETH_HLEN)
> >> +			copylen = ETH_HLEN;
> > 
> > Similar to previous patch, I don't think this patch is significant
> > enough to warrant the code churn.
> 
> The following patch will require replacing
> tap16_to_cpu(q, vnet_hdr.hdr_len)
> with
> tap16_to_cpu(q->flags, vnet_hdr.hdr_len)
>
> It will make some lines a bit too long. Calling tap16_to_cpu() at 
> multiple places is also not good to keep the vnet implementation unified 
> as the function inspects vnet_hdr.
> 
> This patch is independently too trivial, but I think it is a worthwhile 
> cleanup combined with the following patch.

Ok. I see what you mean.
