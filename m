Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D351891B0
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042712; cv=none; b=InYeI4dH8zAL7ahfCVtqhWomGMG17YFZtavMnEItAAjtQtIbbi+D0EwSISvB9WDPoNEVzV8MixAR53OC76Ido66xCv2J3ho6yNX+P5M16Cz1Ne+zDOIWAs/P0sau+qgGI4CYnX52n76Aw5lWOJ1SSDj1MWd2scFVSkTWBlhNJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042712; c=relaxed/simple;
	bh=ty+USuCasgyD0q5WV6y+xqpiIL59dUuUhJrHdOnICuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM4x19/myLF5avv/x5Hw6d4OwNJ4svedEygwIZ6K1KmNwnsUhj7rb+SJxn6edqeSK5OB2xyRzzQsG0P6mO4yXNqdURimcP4pIXYc9NVAZVzYUiR1FuRNqY6Ehv7tDGC6m0od4AZWwfU3AjKAZpVNBsku+RdiOmbiRwijL/YPD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea79e689eso5854676e87.1
        for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 04:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042709; x=1721647509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIjlZKoODIvZ5ta3ient2GVc/jl/vGg+wUu4XZXyR/w=;
        b=XEAICuy9x7rXUN9H/fOfm7nrnXYZjYKgwUBMuUDGOdam7n1BHgg2tHa5EfJutJszCi
         q2/La0oP6qMLoT49PHTI5TDcF61QaR8mvPOL+4FDZFzUIl0wCG0/6+tdPc1I+jryCWIL
         ncAa+fScoebiSQtivJuTQy/298McVMAq1RwT4a4kO6vGuvrO/Nn2+M4obTq7w1AZ1QP3
         v2SgcpDVhsG1l+DNQISDkzvxZyeY86ASKRFC32dnjanBRcNa6lP8/x7NhAWldXXjL2n8
         CY9C4DukS8chHpuuVAQ9lFa1fFkNB2jTXUCf3H/PshDIOMlBmSy6L9zP6Z0YReawSKL6
         kN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWBN+vD+2qxPzZk232+hSv6CdBKJUEcb1Z8OHrqrvcKO3CCAax/S2QS0nzVEDMae+v//alNbu3G80KdfgC2XNquuIjoa0JZEKpC/0/AfU=
X-Gm-Message-State: AOJu0YzlxXbBa+wR6Ml3t6VicLO+F9Pgwi3kC/e5GDD3E93R7W38E86p
	kvjxPQQs/+17iaVQEqSo1hU5S39RB3j7+sVwZcFVihq9ZXc+zEiI
X-Google-Smtp-Source: AGHT+IG78sUAzx9I4a7vE8/3T/SQW4az1utlpNNwNzPZzbTFoS9BD8x4sD9BV4nV2NExq/Pw+CcMGQ==
X-Received: by 2002:a05:6512:36d3:b0:52c:daa4:2f6a with SMTP id 2adb3069b0e04-52eb99d670dmr12258120e87.64.1721042709246;
        Mon, 15 Jul 2024 04:25:09 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820fb5sm204451066b.212.2024.07.15.04.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:25:08 -0700 (PDT)
Date: Mon, 15 Jul 2024 04:25:06 -0700
From: Breno Leitao <leitao@debian.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com, horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <ZpUHEszCj16rNoGy@gmail.com>
References: <20240712115325.54175-1-leitao@debian.org>
 <20240714033803-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714033803-mutt-send-email-mst@kernel.org>

Hello Michael,

On Sun, Jul 14, 2024 at 03:38:42AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 12, 2024 at 04:53:25AM -0700, Breno Leitao wrote:
> > After the commit bdacf3e34945 ("net: Use nested-BH locking for
> > napi_alloc_cache.") was merged, the following warning began to appear:
> > 
> > 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
> > 
> > 	  __warn+0x12f/0x340
> > 	  napi_skb_cache_put+0x82/0x4b0
> > 	  napi_skb_cache_put+0x82/0x4b0
> > 	  report_bug+0x165/0x370
> > 	  handle_bug+0x3d/0x80
> > 	  exc_invalid_op+0x1a/0x50
> > 	  asm_exc_invalid_op+0x1a/0x20
> > 	  __free_old_xmit+0x1c8/0x510
> > 	  napi_skb_cache_put+0x82/0x4b0
> > 	  __free_old_xmit+0x1c8/0x510
> > 	  __free_old_xmit+0x1c8/0x510
> > 	  __pfx___free_old_xmit+0x10/0x10
> > 
> > The issue arises because virtio is assuming it's running in NAPI context
> > even when it's not, such as in the netpoll case.
> > 
> > To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> > is available. Same for virtnet_poll_cleantx(), which always assumed that
> > it was in a NAPI context.
> > 
> > Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> though I'm not sure I understand the connection with bdacf3e34945.

The warning above appeared after bdacf3e34945 landed.
