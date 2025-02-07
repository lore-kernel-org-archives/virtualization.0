Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A633EC
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948867; cv=none; b=D3K4LKFIrcyDxjGlh2/MrLqE5+vZJlGqtFyU67QRPBBjpxHh87efiqNjR7LuGUXgqCnRq6OD/mnWmNGD5YhlQdEge37hKUME5HMlUQLFEwMNR49Bpw1pScv54+q7KhWJ4NG4i4JNUnlqIIYN5Zmvaer136VKs08gKDZ0Z6r5Qew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948867; c=relaxed/simple;
	bh=JFEi2wLeGZOf8BHQEKqWbZM9NCkw6C1VmawHgv9xFhs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=drIH/yuNCwzSCbBrUcGbTDsiioSIeaHM7l5B+nMkl+yF2lsRFlTbf5ppnHk/o1cJVd7Jg/F2+W1/19kYQujFDzSWB0F5EeyPLBjDif1ziXVlmIQSG/wjcje8+OcJOqkZQknKWQYh2kLwuwYzj/oVn3S+O38vnihJgYcvTF+5HZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbTd2FHo; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbTd2FHo"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C02C5846FB
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 17:21:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B44uSaFfChGE for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Feb 2025 17:21:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0E84A846B7
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E84A846B7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WbTd2FHo
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E84A846B7
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 17:21:04 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7b6ed0de64aso198749285a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 07 Feb 2025 09:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738948863; x=1739553663; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=WbTd2FHofTDb682MeIuCa4p0siBCAjbZaLRg+p8KVKUWI0Gl4Blwfzaz5LgqRdlPlh
         MDKcebGkYSb2l7emfF5J0N8r3VTtgTZh5T5O65Buo5b8QPjKDrQD1PiXCLOKjIy9HQhc
         NsZh14fx7brEAeogvNV8CUSbv9WfZyVO0c0KLT2UnCCosNoterzB7QMuaaJQEjdMftQv
         07HpMmYTdsFp8D5ptCNAP3zRWNf2Dft7NrODy+okcLzkOdz6jPGtjBmj7K3cFThG5r+9
         AGtmLtB4LrwjFoGX+rNYXHbhHXFdxmnmbRABVnl4A7PBP8lB+A4HGG/6gHmTUqbzYwIx
         dmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948863; x=1739553663;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=UhBcOM+BS+fjnuvDIAtp+TNBklVOdU5viAMvxCANPEWfAwkxef1U/z3NcOPKlT4Mlx
         9SpaRh0c9NBJn1dnfW+8xfcP+QMh7GN9rv65GB8JWg1Ey/OFS+BLCd/fGqxH1xuu4ovm
         EPcdI7ZUCWEzanZDPrGcc19dXdLQkJuHpoipwCRVcwryZ7ZNck/ZrVL15aSh+Utsm4ea
         10JH5yc7IcqB3/p2vm9aN9tZfY7u5jTIibLsv+d7wTBah8CibnibwWpwhTOemjDHMQi4
         zCLWoQSr0qefUG34csRitSVRAbxQBwS3JbaPNqSz2fSfIJgsqDEW7KCR4j7acqmI9aTW
         Sg2w==
X-Forwarded-Encrypted: i=1; AJvYcCXlghdeF9kX8WumLPjZoW5bcaATJ1EdRvkrHSAfscVB0576vGs1uMBdiEpWvckE9wKU9Rr7wNRXSp//7vkJdg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyVp0THThKVYAG6sjFSq6bK26VlEDtScnoezhhoz1GoXv07wrgd
	4Lf4s7Bh0l5ZJCZGWTXhQtSMgKXWiHnX9qQgxyPD5xX4wNlzRuSa
X-Gm-Gg: ASbGnctmAjpl3sJO/AHw4JwLareBmkdHI4wW81wuKxEi3Jdgl5hxZuK0CWe4Z1KYxDV
	EXlCJ5/U+Qv7z/VP5RdIEYfsCf2trKCD+wG6QjpI/MyFwKJlvc0aQKmJZt5I/bt+wqvB/Gz0zoF
	MY+Bhtjp6Wv1fvHhisYEMU6dF9TXqCIsqUoy0x3/Q4VCqKUeEpWhb+NR4kxWY7HtNz8xyD9o/FA
	kk/qNozVLY2g9BJt2Q/nFHT9Pv2Zgd4wX0dFuN9szrYOAizfFg1IkxjF7gHUt1tNMW/9hqkZONI
	R3ftGBtAb7aC1S4XbRtGPer4/ghBmc/mWFgHWiVYX+mLYDWqEPLniwhKRsgZFdA=
X-Google-Smtp-Source: AGHT+IHgZz+O/0cXEsGoAckImVPwPZ7eUzYlDFm7WldQdP2qrllz9Oq9gpborPR1otvsihBd6dfnxQ==
X-Received: by 2002:a05:620a:3909:b0:7b6:67e1:b4ff with SMTP id af79cd13be357-7c047f25a93mr564417385a.28.1738948863537;
        Fri, 07 Feb 2025 09:21:03 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e12947sm213396785a.57.2025.02.07.09.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:21:03 -0800 (PST)
Date: Fri, 07 Feb 2025 12:21:02 -0500
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
Message-ID: <67a640fea839a_2b3e7e294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250207-tun-v6-6-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
 <20250207-tun-v6-6-fb49cf8b103e@daynix.com>
Subject: Re: [PATCH net-next v6 6/7] tap: Keep hdr_len in tap_get_user()
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
