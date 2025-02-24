Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63818F2DF
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417351; cv=none; b=mhYJdKfi52oQQRAY+CrCHVRlv5IJH3DcTgoIyEpduFxLh69JR4tKdUreLkSbLTZ1aOWsbm9vanXdWREYTQh6SAYeksn6BuSssYaWfe5a1x6dbuiTvHA3RkOgeRWyEfDb7eIi+vT5Y0ldqwUgheDBIu8BO0VkZ0ZpD2/7uGTGHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417351; c=relaxed/simple;
	bh=fH4RtBkSRZW2kBeXi3P/AudbFsIVNSe8yu+5vaExYfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhV6IcHg1OrhgXhQ2142BPzYKDFhlpyWdq/zDdT/SzZmziOGGrlC4XZQmA2kx9d2fgFrOKWkWlXIOMFdd9Tl+VU5ZZd/JiQN0wZ3Sn6lYx9veZ5ylvfgytvR07waez+Wwy5vRV2XUw5LEmfuu/opFYzR/Tczuk3H9d81oGOuqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0O7n8Ih; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0O7n8Ih"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220ec47991aso63795985ad.1
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740417349; x=1741022149; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxLi0WJqLjDUsJq7l6SDZpuIuRBeCk6IdkUiuE+2Dwo=;
        b=P0O7n8IhRXTIa5PLTtFf5/Wv1p0M3arozK3IdzJcmBWvHcc+Ub706Gq+epDTIh8DdH
         ZA55B5n13lbpybjXNj1vn63J+m/Eg4NJdbruRdwcrDL21LiIK1JwuQHlG1oUqYJT8OEI
         eOkvN0q5img7t32HaA95Q3QioIqSQ8dw7YOyp+JtaaSflGAh6DTBUy3jP/ZwizIXe4kr
         I+4IOWqbk7pOwrbClcNjxyHbJ8jmD8d/yIbymZSQR9b9xDBddzpp/MU44Biur2FL1aRn
         nR2wWlpkHiftFbDaBgDKYgHLh8vFL4wfAUUgLaSe+GGnrjNbaWqun1bIohHA6ROPgz28
         ofUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417349; x=1741022149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxLi0WJqLjDUsJq7l6SDZpuIuRBeCk6IdkUiuE+2Dwo=;
        b=KN7va8cW+GUMgA1FnsS0qajwK5W963cuGdSLGJyFL/430gxvxSiMwEP6tYt6zbyYX+
         lI+UCltGnVIvN1SCXsrfcO29V584cMnaDR+rTEjGVYqwCU3+wqXdWf+aU0vTWXdVWpoO
         P33A7OsKcMYPYuD5BgE7zM/V4LnLB+J5uIIB14kHE96WYJjuwmrdiLisendIgZ11NlJp
         o9YhvAhtacIsYkie0XgRVpm5XEO6QjxiHvKKCkqFz4F9M2jQcKOM/SQUegm3vEvQwBNU
         5ZwPNosA0YdGN6dmhi9ue8uAhNuEwHktel/llhO1NJWIscJWh/oXofglJykUHlz8W50c
         m+hA==
X-Forwarded-Encrypted: i=1; AJvYcCXh5XjUmTAwZKPeoAHatUnDPsT+QPezUvZE3JK9kKWF0y17mZzKby500aLfzoNxfpNQZKDZxZVR4JFOsymTvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsOTsnS8RHkkGAatzPyxdqCvn6yF/PRGBgj9/u93zZOlHaXbg3
	kSJMopXu4Uuz7hheFVvL7uoodLN2vou8ERYRH46r9xnuNGx1+Q4=
X-Gm-Gg: ASbGnctuo55kR3MHsC2iUGxbjRJxSgCADnbaBH13JIz0ofpOUiePwh7AltgEvx5KQV4
	TPtrbHbv9qFCyIXhSK81oI1lWFFrJFgG5R/a4UPFrkhnkfCUBxw05ucGxygwGuKkk47IDD3wHdP
	nszHVLTpXJSOujdoy0RUDsN/uCiFYyS0KWmBRDd8A/Yqkm7xKaz6T+y+sECTPbAs/rwg1uMsVCM
	OC+418e5iyYckWJr4+lnR55wGDq3inFjpfXN64a40bd30L0Annus+qhe0Odgt2HSlskuoRY3QPi
	JkBXNykGCz6g6x1Czr0RL998nw==
X-Google-Smtp-Source: AGHT+IHX3hMEBBORSG6Giv0hdr/rxJRv/ocP3i7v+0Nr0JPqfdQtTKmVEfvG1d9RA3UeZWNnTu/9iA==
X-Received: by 2002:a05:6a00:1947:b0:732:623e:2bdc with SMTP id d2e1a72fcca58-73426c84885mr22523269b3a.2.1740417349558;
        Mon, 24 Feb 2025 09:15:49 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7346d9b1af1sm1497263b3a.71.2025.02.24.09.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:15:49 -0800 (PST)
Date: Mon, 24 Feb 2025 09:15:48 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v5 6/9] net: enable driver support for netmem TX
Message-ID: <Z7ypRKrKN0SdBOM2@mini-arch>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222191517.743530-7-almasrymina@google.com>

On 02/22, Mina Almasry wrote:
> Drivers need to make sure not to pass netmem dma-addrs to the
> dma-mapping API in order to support netmem TX.
> 
> Add helpers and netmem_dma_*() helpers that enables special handling of
> netmem dma-addrs that drivers can use.
> 
> Document in netmem.rst what drivers need to do to support netmem TX.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
