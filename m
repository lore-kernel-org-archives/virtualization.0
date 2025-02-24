Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCB263C7F
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418716; cv=none; b=mRq2xlBz08MY+Azy/i7oliqDzrn9lehtv2UOR5qH6PX23D7ayowy6Gw4FWk1CxZJmsp6cwgqGMo6zHApgg2Mlc59TfDXRqB/E++P8bKNYl+YUzM95D1fgdHQkkj7qEWdlfOQHGTGouPhFNNU9Ppf86yCpY5i9e1vKbMcFjqwZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418716; c=relaxed/simple;
	bh=6WDWAvw45opfe01BXQoV2J9T4wPwlIJFh7kOtE0s2h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSAdVv8czAxJ8PsgChdkjs3/e5w9oxNxHsTbpsMiKWaYkfIKJ9gaZPV5uD78HRk1Al+yjVcoW3QtKXcauCR1MKGqx1waA4e3Wgzf6glDrRQY4ZIhS/mig2SdrMusEaDJxHImpa84omSTkiwjevP121H9wpPbCpuUSdxfmoLl/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO8pMMFy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO8pMMFy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22114b800f7so92976945ad.2
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 09:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740418714; x=1741023514; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX4AozQfD/+Q4V/98VBsuhZOuZnT8f3wxe/fXFwxJI4=;
        b=EO8pMMFyNMib9NGREHJSnWVRoclVucRmZDnv4ZXT9duZJmrTySa2fXNkwHGeQx1DXX
         69CZ6z87tDBC3mPavzdxLHSzDbB6IdQPHY0tR4hKnDL8UK1MUhSzLa5xCC1D5K8SODIn
         YUCm0EmBVnrCIRlAOKkUa+tFlH6/Id9cppElCGeWgwDuPOApQidU2JspW0XixdYKqxse
         rj2TR2jNryi8XoXvFLEH6mwT3ennzN2rGQz7937KiQWEhGSBqiCiqntMl85z7VAqhNGD
         XPPw5imugSJImy/kwdU8NECZ/f/qwnyDAfHGY+B349l9nddXhfCwSoJ0PB/fdWuk62wU
         iq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418714; x=1741023514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX4AozQfD/+Q4V/98VBsuhZOuZnT8f3wxe/fXFwxJI4=;
        b=U7jkPlOeY0KfBM5Erq3PcpvmI8iXDIVvvnNYREDfRCn2c3/EiQDZaXGNCPOsjqedQ5
         MnFSVYWRUoXJLQStZUmLKlZDDIPVsPOjOtL9IAm3MSH8nc2Sf2gepPN/zI3JlYCcEh46
         pHSzUVA6pdZsVwiQEhLYlpKSbTUjDdnQnkJBsYy4uSr2SaKhLZDNpcwB85/aEXMj0QBr
         TXyqVQavX5Hacf/R4cUlxMdeCr8ma/7OGCTHnJRn/nhM5BrytDQ+lIfbLUUQMaaluqMD
         52HXR4rrNG3P+vOVyAAK9cc7nGlGdHSrQQhUF2mX1U3FHGaAtoF6P4hbGgiq+HZMVc4a
         DAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVX6VCfkAHsYAY54JKV0FnEo4quvndwbi/EZTg88/uhZWHbuvzb5sBEOmyPv07VSWbBwVTWD8z2XgA04m3ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+4DHvNJHltBv0t9EJRVNX5bhl9WaJcpAolNO0fHbUciSsc0bX
	oNcg+sJhGANzjeP3NukpN+RJFNgTx9XQFQp8qL62dT00eEp+olk=
X-Gm-Gg: ASbGncujb629IdUMGG6iLJdyQlsH0FT6PpsB/3d3IVSEKTE1DkBDvPdH6W6L+P0Dbuq
	c8dN3ZuqgZuT2Gx+0zDD7RkhJzZFNFiCyknC0pUC2tD7Zsg0AlWzP4rG798KdytY4gWwwqme9G9
	RDu0jB59iBuFaT7JdQssNiguSJyg2Hs3eJzwyHuiF626zm1f4rz6nC/X1qP4Rf42dxjVN+pkGFg
	N30AJxgrsvjlUOt03KmfSMvb/P0O+tX3h/ltwvJr7qlaebqiHIevWS6QReDz4zp3DHIkR0T2Iua
	kspFU4Qzic9LHKulfu6H4g4XWg==
X-Google-Smtp-Source: AGHT+IEOY3jvw3d20B761rhLccrQlmDTz3/D4N2sGGq3MNqiiZ11e3nLJ+fNVmPINvJS8+U0KTPG+Q==
X-Received: by 2002:a17:902:f550:b0:220:e63c:5b13 with SMTP id d9443c01a7336-2219fff4ef2mr211596935ad.46.1740418713456;
        Mon, 24 Feb 2025 09:38:33 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d534afadsm185575355ad.26.2025.02.24.09.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:38:32 -0800 (PST)
Date: Mon, 24 Feb 2025 09:38:32 -0800
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
	Samiullah Khawaja <skhawaja@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v5 3/9] net: devmem: Implement TX path
Message-ID: <Z7yumPB749GdF26X@mini-arch>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222191517.743530-4-almasrymina@google.com>

On 02/22, Mina Almasry wrote:
> Augment dmabuf binding to be able to handle TX. Additional to all the RX
> binding, we also create tx_vec needed for the TX path.
> 
> Provide API for sendmsg to be able to send dmabufs bound to this device:
> 
> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
> 
> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> implementation, while disabling instances where MSG_ZEROCOPY falls back
> to copying.
> 
> We additionally pipe the binding down to the new
> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
> instead of the traditional page netmems.
> 
> We also special case skb_frag_dma_map to return the dma-address of these
> dmabuf net_iovs instead of attempting to map pages.
> 
> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
> of the implementation came from devmem TCP RFC v1[1], which included the
> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> 
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(assuming Eric/Willem will also take a look at this)
