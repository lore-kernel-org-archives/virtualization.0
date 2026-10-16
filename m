Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536A37D12E
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144438; cv=none; b=RoL3gKnEzjJzrapbPaZfHj/5EpFI25pbXb0B1EHNoA3tZfAsOiLdQ8Tie0d0DbLiUaUMHad9jmBLGPzbUjOfx8m5vTj2dNyIMy6ga41SSpxDDuJnbyL0V/f0J7shtIqD4HOsx8Dc8qbCU7Ka0mtXccq8Ucz2ND0V2nKheVf1xmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144438; c=relaxed/simple;
	bh=GZNsXghh6SZMQS0etCLAbkbM/Gi10aQpjd8kmsWf+hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LdHT8vz7YWm/hIoBlzdq0+XVwCgTD+/LVEkiu/j2Reh87yv/ZQsRcscwouRJTvJKg6HPv5Nzh+YlY8DiS4We3+C0cfwxJNBCPENmkIl8sExGWmFkzEMaxNSdyVSAEIprr4SHRMVXQ0DeClb36sfN6B8I/jCnPZEgUJf8RB1SMGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e37xVH6F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e37xVH6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792144435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr7WSuKask2p1j98eCEcwTF9HIf7GILCC9to1Tz+WQ4=;
	b=e37xVH6F1LHHZQIMO6wnThnuHgHCWiB9JdN8v6O+Vz57Ne48ip06K6iIAVO2r4vdvte1c2
	dEly1eClthdoiTRlYXk1jlfAq1biMYK1HCs2T+n3UePNNeTXPx6EwnSc3aF6qPml96WWhT
	yWot0EpLG4bylWwdkOiHQaAbffsFlyw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-yE5bbkkeOqm2oPVk9NYK_g-1; Fri, 16 Oct 2026 09:53:54 +0000
X-MC-Unique: yE5bbkkeOqm2oPVk9NYK_g-1
X-Mimecast-MFC-AGG-ID: yE5bbkkeOqm2oPVk9NYK_g_1792144433
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df02b91f9so499422f8f.1
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 02:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144433; x=1792749233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rr7WSuKask2p1j98eCEcwTF9HIf7GILCC9to1Tz+WQ4=;
        b=Ghmm2qCRXIEXCNVB0ISNTJUJYBFxZJbzTaerYwVsoBSVKMaHv7gCdWSt7rscf2tzYn
         awel6GtSvecPcPcMB18fasNzsFueNaitzKaS1BuZ9UN4zDbkUPZ6P9BXMtcWmfHwSqxH
         RzeuNKIJl4uU3eHRJzbjKrJA23iTvr7Q6M4bQNRSH89E6OWb50X1AIjaPPt78Kp6xA1C
         gBbjxZaor9xI2ILoGlsxun27bGXxPYYOKpENW6vryh1vGlVNHFFtupdkMALmq13iq6gh
         WPWQitDXOgjgoSXkm5ucHA1qMEOyktYv80FK4wutSVAOOKn9ZmRVjFQBnuNfClwVDp8z
         jAPg==
X-Forwarded-Encrypted: i=1; AKwUvBz0i281JEC6DQsTQXk5iXS755L6N1G/K36GR0T46WAUgBM/Lwj+QmtB9qKPyVcJltHIeWnY8p1+dkOLr/dkdw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJBl/UGyA4FimVJ+lpKpgz862cH+pKs+56rHUBuugJdO9c5Y3O8
	jqzl98YoyWLpULvKtXWf9Se2DOSPkQt0ErrsZSH9EAvBclNpSsBGaRA/1dqVaww8b6Pgvg2RRm5
	asTk0h6eG2OQbw3nFMtzwEi5rQ8DZPbuWHP19AnqCrZjvZr0quvC9MK/AxIg0a7Gc6wSuAumC2q
	Ap
X-Gm-Gg: AYBFou3FQrpsdCEbELykLzt7xcrAeyoZS9Jhiv/oqcO2ePUpsTTtQrJiMy4e4mcqIR0
	36M4RIR3wolGqSvN+xPaEKDFYk3Xzsl18liMw2/0EGAgRzZto7vXhSDKgPoC69dfkW3MC7SQCS/
	ZZFl4ye0J6Y31vo1oSQHYr0lqUp0sAibwKuLbkR16KS6vD8dw5sJ/AVrmK1K5AY5Ha29gUfyGrm
	nKxhwRaprV6XdHIf0IGo3mpkjD5wjQ9yndTiiDb7QSDJrndIbgr5wrR30kwohBWoHzto3P6Md4Y
	U6XjBuOFXsE4mzEAHgXrH3vNAVX/wI0Xjv0sVAVSnEfbH55dpfUw/2/+k8XLUfZdU19lbw==
X-Received: by 2002:a05:6000:26d3:b0:48d:f4ef:62e7 with SMTP id ffacd0b85a97d-48dfaca5f59mr6434742f8f.0.1792144432653;
        Fri, 16 Oct 2026 02:53:52 -0700 (PDT)
X-Received: by 2002:a05:6000:26d3:b0:48d:f4ef:62e7 with SMTP id ffacd0b85a97d-48dfaca5f59mr6434697f8f.0.1792144432170;
        Fri, 16 Oct 2026 02:53:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a72sm4456837f8f.4.2026.10.16.02.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:53:51 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:53:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261016055312-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
 <20261016054142-mutt-send-email-mst@kernel.org>
 <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
 <20261016054558-mutt-send-email-mst@kernel.org>
 <77e9eb61d0e81ead5d5840abb95ffbd695a4e513.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <77e9eb61d0e81ead5d5840abb95ffbd695a4e513.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lwkj-MkvqNiS94VvOKikC9o7JJQ9m2o8J1zEyEBFHs0_1792144433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2026 at 11:49:14AM +0200, Johannes Berg wrote:
> On Fri, 2026-10-16 at 05:47 -0400, Michael S. Tsirkin wrote:
> > > > 
> > > Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
> > > and -ERROR on failure?
> > 
> > After this patchset, it can, to signal slow path software checksum.
> > I'm changing callers first so that changing the function itself
> > does not break bisect. I should mention this in the commit log.
> 
> Oh, OK, that I clearly missed, but also was only CC'ed on patches 2 and
> 3 :)
> 
> johannes

Right, I am trying not to spam too widely.
Indeed, this is why commit log should explain.

-- 
MST

