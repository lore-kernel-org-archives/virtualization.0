Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C15F24C692
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431422; cv=none; b=XSe08JkO8xjY9Zx9oZJDgxvA3ElA0ceO++kVEvrMn39NnPDDM+L297JEA4VYYUvHxel1F5kPnEsKTKBruO9CedzYYu1XwMkv/j7nbsrFeoCRY+53WgAmr+IoAh31EJkjiGYDQoPQFVg5vPEVWBptv47lpTveIF/ZxR7CeXq0UeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431422; c=relaxed/simple;
	bh=3J4zAqb63bH3VX5N3JqAiFgpLhLxiKG6g2wX0yan0bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rywhk6tXkARAc9lJvGoAi4JLC+aR1lwEDSPQyyNkpoA0ClMc4/ogwkJoILJvvMfCbW8jZnD/BFszinFbJLK9q3y9ZLtm01quTUkDIB4DEzsjzx3mi4aQgvIY+d9uSRnqlmGrKl3o45wr/18V6qtIGVeACVbl+yZ+w9LzkECsxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m67rV7jv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m67rV7jv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24099fade34so49556235ad.0
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754431420; x=1755036220; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKL9Qs4he/u4QmnFJ98xlj5EFrnUf0t+cD9K1mfke1w=;
        b=m67rV7jvZwq2P49uR/sU/Yx7w2to3EU2h9kBXmZOGQzt2YFSXBr6/yw0OIxp1jIKTJ
         3oszzvywLpml/zkaoVZPwXx3WPiXl5d54rETR4KNNAb7R131VDkimXsVZ3+IykVY0wVT
         i7IsKsUCsgwztqb1LcTWseCIxqquFQAV2IoEvd3YZRoFaN/14IuKqpEN8E0qnMscnjFW
         yXMMcTDeK+eNc4pmPrlSBaflmBUKBEp37UZGdZN29kKIax+wLYN0NeulmMUVGx6iU2uW
         v9AATeqvj9d3a2BdXuBq/6qBV+lTcPagB/lhSmYJjFxrEanZnm+Y0DFkRjFcirRAmDbB
         Uv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754431420; x=1755036220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKL9Qs4he/u4QmnFJ98xlj5EFrnUf0t+cD9K1mfke1w=;
        b=GX4e7Sx7dmDsdo3x5EQPEi0eJ5YWfxi2mPknLKsgd8XRQg21vduArBAv7aP91vJIaC
         nLc1DJztBxTgo2yxip7qLWOzQTpfLEMo6xIMxalLko+P0IgQMHY9MmwtmB7veogccNnk
         ZyoQFHXQf5l6Njz1eWgTLBmQXQwYkjfqmWQHzQsF+uLdzL1GpE1U6OKs9E/d9fjATQ0r
         /j3ZXqNrbuu5xlkSZyeWjwkZKVkO8yScGxvS2lDKp5Pr7qhzCpRHcg0fazuqALQDTDR9
         LfMwe+QQX+4LV4SMjb5RJSzkYIb5/N3e+JvfeDVdUmvjm3z7ph9o1Quer6Xo3yVpPBXY
         7ubg==
X-Gm-Message-State: AOJu0YyeJzyDoKY3yoSDEOUenbahe6PlnHfhLMN3/q3HCnq54LS5KYgp
	p6YL/pH7fVFo3r7xHDYkcByw6oxAFNi1cMSd9U3JUqXINniPv5hRaigy
X-Gm-Gg: ASbGncvFvrJn11v3vW2lhVSjclhL14UJtTkoHxEP3mx7waQZaVUSs3mx1rq4OYcw8NA
	3jh1KnaBMijC//4nlXLh46GHnAe98LK7cED8L/6jhwUSawe5p2rbnVYdesiZ+LDcKQEUS1jxCC9
	4ZApM442clLPe9UFCiHf/VAuRQfRyG8MIAthwoIaxKWw2TCQ/ZoDm+nuK3PQnbME8CgK/tbziK3
	ESx4N5yvUcaC0H89iWPKRCXyKccYspyjIPjN9HzMNJo3BZHG6JHt6xsZdWE9sfdNqTqVXyOa2vN
	tCHSNFsJKmfqfxQlG7Pt8k2rWxQYRB1xkREzbEO05uUaIPLi61yvHXa+O7mYhMvypNOtaIf8KZ2
	V5cHVrZNkcaqxfFnmIHcUfhIzHuixc6Ae+5npwiJaTMs=
X-Google-Smtp-Source: AGHT+IFfzRZXbjYMaKuhhzfUCiya/wrLqxSvHXQBVysGY1NlsmWhfMPYkWw2Vxzm69yDdFqszb4ZOg==
X-Received: by 2002:a17:902:cccc:b0:240:640a:c576 with SMTP id d9443c01a7336-2429eeb9837mr8222175ad.15.1754431420427;
        Tue, 05 Aug 2025 15:03:40 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa77sm141295305ad.174.2025.08.05.15.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 15:03:39 -0700 (PDT)
Date: Tue, 5 Aug 2025 15:03:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v4 00/12] vsock: add namespace support to
 vhost-vsock
Message-ID: <aJJ/uWhqEu1TG1Kz@devvm6216.cco0.facebook.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>

On Tue, Aug 05, 2025 at 02:49:08PM -0700, Bobby Eshleman wrote:

...

> 
> Thanks again for everyone's help and reviews!
> 
> 
> Changes in v4:
> - removed RFC tag

My bad, I didn't notice I still had the rfc tag before sending out with
b4.

This is ready for review and not really an RFC. All test cases passing,
etc...

-Bobby
