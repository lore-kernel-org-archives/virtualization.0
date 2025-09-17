Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617F34BA5D
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126829; cv=none; b=G8XuQ7VQdRqLc9kP1IazA83BYm+lFMZS5MN3LbTCjgR8rmS/93u0yIo8cZfUmJAeC4V4YEtPahJT13ZgN4o0KAc0UosJrelahEU8omSLQtom/oEHsD+QfgFzDUr9RPbydRBuh8hm/QYr5Dwir4SKUc4a7CfjhUpT3rJrErlI0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126829; c=relaxed/simple;
	bh=T5rlTmWWL8B+5YTFOLQue/O9Et9XFS1RiNWss6/XQ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EelDuPHB5SuEeN6sX7xLBQojcsSpe+/dWX3e2xGSMA02wqUhMtHu9csVJhqZvH5nZ2OR5F02qeUcoFeiCT6H0nFmLR4L0df1HL5lCPH72QePxtnrnZy82SLww4xbJ5qMEqm9xhbti7X7hiS4lYixFB2B9ESHCMbkjANOKFTJlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYnXawzb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYnXawzb"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-72e565bf2feso336997b3.3
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758126827; x=1758731627; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G8RlqH67o65j5zlsChBs5Q8TtBN1OWluyR+3o2WLBvY=;
        b=nYnXawzbZWjQIUg84QjDZ62J4jjdWpgSqtb8YjKXJXvATYqEiJXVexoQKPcMt/CU5S
         dUsJdY1QsK8w4kTSCqP+PaFc+FhB32ngoRz7Hp0bDBm/KFTKujrgvNAT4zv2KTRll9DI
         ZMavQ61UjmiDj8b0BUrb9xjwN9LjD3Cc8I7qqslJtLxtImtjwQp/KY67fdwQCNlo1VN8
         5U3Ei3ITFA3doQa+KzHqfaXonC8rk75BHnZwzUA4H1NhACl7s7FYzKwmDBOubjshpluE
         dJUCxIFKhh8BInqakwDW49Y2NJSKTkcQF1cUvSbY2tsWrj8dW6bIh8niQ8D2hgUiH/v4
         DABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126827; x=1758731627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8RlqH67o65j5zlsChBs5Q8TtBN1OWluyR+3o2WLBvY=;
        b=fqXUMePW/WKrxZ7Hyn1tpQlNrHrnfR047P1dQ+iHehv1+dK6kWiB2k5DE6p8gbaa8t
         QFcgq8yWjE1lUIecZVy/1a9O0+P3mTgFtkB8DnlB8IGdbCWsNgR6lEdSQ8FNY6wOwBje
         uU70KofLovIqVjjJjFeMonIwnoG/T5t75bK4sfdQio4UyzVr4UQtZesMVjX4IClyiLIu
         AGeQTV3WVc7mwzscWjLKzKIYqmz/IERVkilN7PYJgrBZQ1kD59/kNGnD1qeURGYlbcie
         7tufm4aRAlAythRkXtlMCZAdymi6UqbdfvH53fHd8cfCYDY7x6cKoK8Qa/YgF/08YWNL
         K1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvvuVQyewgxDOsbDdDn0MXRK6yuWPPX2sDUOmKenmjx5hWvx1GktofgXwVvbR8/IEVmSWim22vxcIM2IYm5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyloHA4Xupi6IU3c5sKUxUoCib3NszOLf5C25K/s6hzGe6Nd4xm
	HVRLVYJ1cHfPZIqtH5s10S+m8CZBhLbhdDj4pY3TvUoXsUDbmd6rSiLu
X-Gm-Gg: ASbGncuy4j3/PTG18D5pV6oIJWD1NDBlGAZR9XlixZgGISl+6awy4xdd/xPYnZb42bM
	2XqjpU52qOT1cyWwHj1OhWOhUvXZ5ln0n+t//qVBpqRD2HiA4WhrI5rhMC7BpYQe9Xg8MdQMcIc
	30fttu0vR1CAsEe4tvhV45EeF2LrYAg9U7PI/C5bhF8Ak2TKGHu4ki1vD0fZBhwG7l7uJZrqcpW
	DHccxn+fG9pbl/Hq5vX+dMZ/oAMFULSx/rehfT5lfp0JtsNsipVv7q1VmwXwMLBPrUjI7v+dozu
	ZUJ8QDDhcmS8c9QLFI940JwlxuRAFv8nEcV6uY4/eQ/QuTyE32wG0f9DMrgcYzt3R/A6dpjKz2t
	cjfRqLR0rXmrp3vL1vDSKdUuYRBJo175JBCz+tIEBUokqAYI=
X-Google-Smtp-Source: AGHT+IFLdAPsCemxYmXa54CmGTZ+ICmGT/J4SrrjoNdABQMevWtNWlVjH/3dQNMTr0HHKjs9ZEs8Vw==
X-Received: by 2002:a05:690c:64ca:b0:734:ee:200b with SMTP id 00721157ae682-7389304b317mr22927617b3.51.1758126826608;
        Wed, 17 Sep 2025 09:33:46 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7389d32a27dsm5115687b3.10.2025.09.17.09.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 09:33:46 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:33:41 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 0/9] vsock: add namespace support to
 vhost-vsock
Message-ID: <aMri5apAxBpHtZbJ@devvm11784.nha0.facebook.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250917161928.GR394836@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917161928.GR394836@horms.kernel.org>

On Wed, Sep 17, 2025 at 05:19:28PM +0100, Simon Horman wrote:
> On Tue, Sep 16, 2025 at 04:43:44PM -0700, Bobby Eshleman wrote:
> 
> ...
> 
> > base-commit: 949ddfb774fe527cebfa3f769804344940f7ed2e
> 
> Hi Bobby,
> 
> This series does not seem to compile when applied to the commit above.
> Likewise when applied to current net-next (which is now slightly newer).
> 
> hyperv_transport.c: In function ‘hvs_open_connection’:
> hyperv_transport.c:316:14: error: too few arguments to function ‘vsock_find_bound_socket’
>   316 |         sk = vsock_find_bound_socket(&addr, vsock_global_dummy_net());
>       |              ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from hyperv_transport.c:15:
> /home/horms/projects/linux/linux/include/net/af_vsock.h:218:14: note: declared here
>   218 | struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net,
>       |              ^~~~~~~~~~~~~~~~~~~~~~~
> 
> -- 
> pw-bot: changes-requested

Ah dang it, looks like I had hvc disabled when I build tested it.

Thanks for the catch, I'll fix this in the next rev.

Best,
Bobby
