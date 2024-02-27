Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C6136663
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039809; cv=none; b=S/HXY4chAldb6YvES95l0fP+utFuS0vqX34gXfrqyrmMDG2omhVToFygVsBoNUDh/FwWnFJn0YrIe1AnY3hvSA9vhRyzQm3Ff1UIyw1B80e4AODueiC2DBAqD+pbjm+1zoVpZA+qLAY7GgTvTU9EAmrEx4lLna9qC8mBT6d65gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039809; c=relaxed/simple;
	bh=sLSnm5sDDAgj4iXUanzlaO3dk9veURq4FvyOwrFUb90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WygrIx8lqTaVD59saJAxPuaYtj+HTQfouEzfTHIzO6D0iV9PdCG/P1f6g1DLdUKe4Dx85ybCGNXT1Sd7mlA6dzJMwQo6sUXG10AWihqg+/D2s2iPG81ZljWcmHwkYf5OHXgpr79tLbVBwYffPbTeRoI94FSoC51YH+Y593IS0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Y1tzEwVq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Y1tzEwVq"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33dcad9e3a2so1325480f8f.3
        for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 05:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709039806; x=1709644606; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLSnm5sDDAgj4iXUanzlaO3dk9veURq4FvyOwrFUb90=;
        b=Y1tzEwVq4UkkQAgaqz5Zgxj8yf+h5pZq9AP03p6yYotKDsyiJO0tdMR5rBtv+wNsv0
         5vWAQnTQ4VexjtkNlVJ04HrZomz9+68EUtC3NeRo7mKGSotLmvSaUQhogE4Jhzwbrpfs
         J3GLafmJW09LiqPmtYgvrUOtOIknW20tvECqjkLudVRnAO5c/OynZ25/46+3CYSoeLCD
         UOQW3N9Xri6TEHu6B0MseyveNn9BHCuNKI7sdvTxL82pL8n8RBUAdq48J8btH96t0ZGB
         EtNvV0XLOYICB2QTa4TxD3gEpGJ+FNI1TIS1zaWmyZY5DTvDUWPya5dfPQ7f8BCnDO49
         /7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039806; x=1709644606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLSnm5sDDAgj4iXUanzlaO3dk9veURq4FvyOwrFUb90=;
        b=XYxHaX8psO+xQfdIOn+bUq6YuN9rIQ0jxKJs9CiwmUS14TK5nygu2avxVSr5z3cL3J
         40buenjOPb3GJ5J0RWPJYfeA9FxIHt9bIkMdiydlQ0ewRXl7v2ksWSvM5sPK4CazWBjB
         9dqjFGq9BfhDBBZOiC6cG4IX1ZlLpWXFMCpvJZwvYxcpWDmRpUVkyfYzkslPPSalil5G
         1BWYkfeUu/0XN1jf+M4BUFPuuO/zVZEFZ04t2RSzIq5gOnvHvNIJTdmFh5s2kxMIBv5i
         3qa0x10KY6lHnBxhWiblp322E8NBYqhCvzyDXfnAs2Ql5rUAGp+N62fIp29ofkUCAkyn
         by8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSQ+7u+JuUJmmCQZ1ZsN+Ljn6nweuOzACagwLPLjKgMd8TfPaiVxJkCFCaFK3Fbu8c4DMvDVNIu/BSmMG7hiB9d36wGv0YBP+M0nKlQ9c=
X-Gm-Message-State: AOJu0YzzPFAMPLSNucfsBlQTnyZ2Ps3FW37xPpiFjDNQ8UbIkJIa64o/
	Yo3+pUXBXSn5L7sjYyxveZHptY5pPA2GbwzmuKJFGdgNgdr80QZS/1JmYvvdLqI=
X-Google-Smtp-Source: AGHT+IHVwzejnC0mU8vDYAfBnv4dzKsSVW/MjvgOtEqga8tB19xw0rosYNSCyp9knEStmh94Em0BaA==
X-Received: by 2002:a05:6000:52:b0:33d:815a:47c with SMTP id k18-20020a056000005200b0033d815a047cmr6493085wrx.24.1709039805964;
        Tue, 27 Feb 2024 05:16:45 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g16-20020adffc90000000b0033d3b8820f8sm11308242wrr.109.2024.02.27.05.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:16:45 -0800 (PST)
Date: Tue, 27 Feb 2024 14:16:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/6] virtio_net: introduce device stats
 feature and structures
Message-ID: <Zd3gutgi_22F79jR@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-2-xuanzhuo@linux.alibaba.com>

Tue, Feb 27, 2024 at 09:02:58AM CET, xuanzhuo@linux.alibaba.com wrote:
>The virtio-net device stats spec:
>
>https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>This commit introduces the relative feature and structures.

Don't talk about "this commit" in the patch description. Tell the
codebase what to do:
https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes

