Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E011DF263
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371328; cv=none; b=Ee2sAhlEcBuayoZs7Neo3ZzqYNOAteB1M1kZrTYDSgFHFBAzhKU92QEqx0ZMTk9C0m9eEdSgku93ci3o0w1MNi3DYrLXMVK3eTtOu/3a3tniisbIshMmN7W5HAVNVtp3/Q/zH0Q2tSg4mjzsoCcGyE6pdDFuyYEYpdlYVxigmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371328; c=relaxed/simple;
	bh=ULAlyrVB0EFv5QHnlkeU1h1uFDt8QM0/aVvEPlRZ7/g=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pAH1wWZA0HKVSFSWetaJz+S5XVPOzfE2cDetW9shfHeAl/9zOrR+Lk9+hV7Sb4vle7/HpekW8UgEtfcDeE8/TaZPqHS+nsv2k6DGwPRd45/HxFfY2UFn6PtN/qEqbvCJsuB/Eyc/MZ+xyO+M0TYRy+RjgMxT7689FKVSw3CowC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXFTV2jZ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXFTV2jZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9729383B4E
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:08:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbL_H2YL1N_I for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 11:08:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::732; helo=mail-qk1-x732.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D34D983B1F
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D34D983B1F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FXFTV2jZ
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D34D983B1F
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:08:44 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7b6e9db19c8so399012885a.3
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737371323; x=1737976123; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG6TkAlGOMMNyymPZxnF0C646p7JeQya5BAnNmWiF0g=;
        b=FXFTV2jZr9rc0dRM7d397Y4K/9SsypK7pkAmhRpGjPDbXhQBOLtrwx8/GA/vn1qkkZ
         mK0qydS9+CAkeFrAXdxFt3Gsa2SbMCFlDm2xpOljIsAFRq2a+oOu2wDN6EBirgZFCCVn
         2vxBlnSDR0eRiPcEP9WS3qxT3NsXUJbpTUDxyUG+5YY2ppxBL/+CrJyG64DxNlWrXkY3
         s6g1degHsvRwfdIsEqrG8McLpXzLAMYYLkywDaMDCC+mPXj4u1ch3N5YKliS6sydF2sZ
         jN8fevsvUqX+Pr6xvf6NJsFV6JaKI3ksdmCELlwcA22i03PkGyySvtJVv7SGGBLcrUy0
         IIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737371323; x=1737976123;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aG6TkAlGOMMNyymPZxnF0C646p7JeQya5BAnNmWiF0g=;
        b=vOI0qwZn9SklM4Zilnuaj15UWJhKthYS8FWizYJfSiKq+s2x+nvvQKwNpRdx58p1/D
         cL5xNQo/2fKUItwsf1RXOjjRdIagMMLreopWCpOkZpOdPEHZ0tJY+QjfgiSNibKaeWuN
         PLTF/npBiTBhoJxknJ5eHRHV+vuGHVpH5geFWCQWJphPieR3iGeikhhYQJbiy2S2kjZC
         XRL2FzeBQuaabHHRjTrKQK9J/2Qcid+FUlh32SgPKf0jiuOQOOrIvP0ZWwkr3y7ffqfU
         GDH0sCYjUlbdwyeno2Iu8YzRoodjblLUhQHXXSifCcW4epy/v4sP1c/HypQdRKMSuNTG
         WHlA==
X-Forwarded-Encrypted: i=1; AJvYcCU19ATXJnTZ5hGPSKzf9Cpa6mO/8egYb/QnqflKhSX1UbruKyFUz77ut2lrB2vm1VkMWWopog4FW/KjhWYpvw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy7uSWnlNmg5JRe6KlajQIBRuQYRva4HsIe1VoHD5SDt9vcCr5x
	YGirWKW+SCveJIpwwuqLMJ23U7QncwDYzzSKdZFQoyEI6GDgOVxV
X-Gm-Gg: ASbGncvyqGi06I+baM+6pTArV3NYmtXOl3scIPztySQoZUanSShqMEnRy60zF76LVtw
	a5ItyfbOqeXqS0A6EYr/7UnDilQ6VY0gMSIkTDEztOI9OqhCjXjFT/2EkgIcx0t5a0EOzg5mxG+
	ieYD9ZTBS0FTHWHGXBStthF9Ie51R4pZJeILHLuL2VZ63HiWZ02+U2Rxgw8KTXuxkK5cko7eNLx
	/R7WDYvaz4R3Yn18debTga6SqzisbUtO8cxyHDLI1NV7K1qLDA7eDhJex/psPVq1Ug+rHvKbc1L
	K/DCWKREuEOFolKfTFtyZLrIidw5knRLzGycNNaLog==
X-Google-Smtp-Source: AGHT+IHjrEflT7QkveiACsrNZZlggSGNB2s6/3h0lASWTfvZOXb0je20GxWRUnjZ5D+Xc5ekfo7iMg==
X-Received: by 2002:a05:620a:24c8:b0:7b1:56f0:e09f with SMTP id af79cd13be357-7be632898c9mr2729938885a.54.1737371323433;
        Mon, 20 Jan 2025 03:08:43 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147591bsm433649385a.4.2025.01.20.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:08:42 -0800 (PST)
Date: Mon, 20 Jan 2025 06:08:42 -0500
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
Message-ID: <678e2eba905a0_19c7372943e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-4-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-4-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 4/9] tun: Decouple vnet from tun_struct
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
> Decouple vnet-related functions from tun_struct so that we can reuse
> them for tap in the future.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
