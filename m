Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC938C2B5
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638543; cv=none; b=RgfWBVu5PvOQmLq6rAqbAs8qhjCOaBqd7QeDqBHaw6vrMRI5TTqdtt5wKRrbUwuhaDs4Em4R9WHhNkpuDVlYxvxBLJoUw3w3NENFpdKFjnisCZ50w1U+C1ZUgs0TP4Il8wVWc7lkorcKpPVRJW9k3wp/tjGt9IzBYSHFcsDSfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638543; c=relaxed/simple;
	bh=tIMu771eti/7wiXo4Au6giCwBRYWMVsndvF+yY6uasc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3s57TtwsXffzlKFv0r3A/DH45gB1y6Epp8Gd/cdsLyDQbs9iXtjOy3waygTJyRs8AgDYFLswnOfbKtVxPTY+2cFK/UlK+mEzOorEzpZKTA7VUDuHckRyxms6BdeC7kPLwZDgBTR2Wx7is5EP1JtIXNdO8BdT8F0v41ABingFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBlbHn46; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBlbHn46"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9a9be502so46828445ad.0
        for <virtualization@lists.linux.dev>; Wed, 04 Mar 2026 07:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772638541; x=1773243341; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsY5todpbk3rMcwCwi+T3uOMFloUvB58xV7DNnWbYXQ=;
        b=PBlbHn46OxmMdzW828SKhREhSO9rQFTnp1dXBgxGy/gUICHbS1o//TpQHqvVcWYUPj
         hAVE8ThyWYg5l3tWbNOF9uYUhfJUJ8LFVZ0X5VWnTAL1lz0pDhtVpxXIQDSeedQcOk2X
         Lf74z1aIb3sjIlOmtwdlJyYrwDMOKDP9XS04w1M4Kqtn+bFgbE9z6L4gVhCgfv2L60x/
         XipI+nEVUsjPnu8jlueVq8m9AT/d4sx8xUe3cGeMBWTmc2lxrtZRwQMZha0GvT8YMdAD
         A4miPkhTESQsDNPGZtm8KqcHXnqWNUQOGK1tuFkPBVTOVT7Hj1hCl5KMRYsFAqagIYxN
         nzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638541; x=1773243341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsY5todpbk3rMcwCwi+T3uOMFloUvB58xV7DNnWbYXQ=;
        b=WLifspaF4cxGC5d27GlN6rl5TNNvxSSEnMmja2sOFizScaVsB/I/jZKlE6XqxUqV4q
         jj0dGUXrXks1weDVGOmwcA0K+C0lcH7fqS8cqKU7MATy5TUHkaTHDRioxI+Cr2JpFdPR
         Ch3N3vjd4TNJyNrj2j09p0lZ4cPqChnT/6aw6U7a9sBC9FfqsPKJZvK5U6MEn893VqLv
         8VQo8onmbBUkn8sutrCKhZcwq+6UoovbG1dYF2nyphnoKB4NepzVLcnWTKHAwwCPDDWH
         YrFp71iQJGM91FAyLqYpGGaTOt+YO/OmVTdvkZgICsZCWJOloEekC3RoO1UvpZg3zNTp
         6xuA==
X-Forwarded-Encrypted: i=1; AJvYcCWzHV4YzsS7Y8uVRbnvAaH3uNH6oEoxKKkDhnfsIosROM/MyUZo/0voqtZy5TcUa6BO5FlIN1gEiIhyKVYucQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRokrZH6ce7qVxRGX/yZz0X9z5eiOe7qzfpmQiI4Se2W+QLp6c
	TSsYVrF+TBhrtNZd/CVEOHBjX0v4t4ATT0LWYxWfvr51WVILRXmve7uX
X-Gm-Gg: ATEYQzxif8Kit0tRjfyKnIpisjRIhc7Vu0UARQustK5driIke9oAlDbEdKWiD2Y40BW
	shF6Ulg1yf1l5sWOuf7lgJSYHS6+HpPpKyWSlcyPKhR38wwSC8s4bB0yVlXbTqPdzKY/Yo1k+GB
	UM6WCmkGPJPv2jySKoqnOy4tpBfbRRmZoO+tHk6szOzQMTep8JVD8yNsv3D7OG/Zfjko30yPYqQ
	KXHek17tK6wJxWbWrfJu+6w00ADo1TMUa001djICQndUzcSCkghTpInYvd991gmIMN4axGlZ3Vi
	iYAqFRneuhWuiqWpxhleozLJBvbgJ9dXWGPzeNBHedu/vtWX0nhw0OXlYUh/tmeLmDmpXWv9UHh
	0Z5u4bKZQxHBmBSp/01lVZ+rbgL/Zq05jhcRyPpNe8hKVv+5v3FXc2zwP+av77qrNQR8vsttfnM
	G1bSEJnBwpw4/4mEFQ6h6LWtK1fV8vGygEOrKvtfCDNHD9piCvW5iCEMwWjAzd2rYjz7yYM+ENr
	7XaqA==
X-Received: by 2002:a17:902:f541:b0:2ae:3a1e:3490 with SMTP id d9443c01a7336-2ae6ab10e95mr27956305ad.38.1772638540911;
        Wed, 04 Mar 2026 07:35:40 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f0f:b1d0:50db:9305:a4f4:d29d? ([2001:ee0:4f0f:b1d0:50db:9305:a4f4:d29d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f0ff9sm214379215ad.84.2026.03.04.07.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:35:40 -0800 (PST)
Message-ID: <e3382903-3854-4479-bcb0-bd9793148b2f@gmail.com>
Date: Wed, 4 Mar 2026 22:35:34 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260302164158.4394-1-minhquangbui99@gmail.com>
 <CAL+tcoAm8wBEes9unXrssHHsnPP28b0XcOdqQN-TVtet5O2sAA@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CAL+tcoAm8wBEes9unXrssHHsnPP28b0XcOdqQN-TVtet5O2sAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/26 14:41, Jason Xing wrote:
> On Tue, Mar 3, 2026 at 1:03 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
>> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
>> wasting CPU cycles on polling. Users will be notified and they need to
>> make a wakeup call after refilling the ring.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> Thanks for handling that problem. Please carry my tag in the next version:
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> You seem to have forgotten to add Xuan Zhuo's tag...

This version contains a bug fix which is a non-trivial change so I think 
it might not be the same as the version that he approved of.

Thanks,
Quang Minh.
