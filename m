Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470745C18
	for <virtualization@lists.linux.dev>; Wed,  5 Mar 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192487; cv=none; b=CWcXWGRoSbIwmU2kZiL2EU2SOPTASBXbdd8/t23hbR7AesfQeQ3LUCnlQOFN3jA9liouC4c2BXQFRbp6xNehdZ8Kg4luYVF8OmVQFK3EBuYMd860aoGGLipxAeBhEk6MwLy1xDgCHeQXoiQr7WhPnB91nH79CagCTxTJAehCXuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192487; c=relaxed/simple;
	bh=F16pw37MzKbIYdgjWhyi5x7YhfEMC6EULpZEwLqrfZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC8t6TBSM/jRKadL7REQZHT0vOAZBhp0qFq74rM0AE6pRT0WMUnzAuIbWIghTFs+j76Fwt3eN4teZ52U2XZa9TsqQSVFwLTICaNJem/cTqjjAvtzZjmYK6pe+wLaN26oVN7MGDnwbtZEJmPQnnwn95oXDHfVdxFo+UCMar/Ud6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kXZWqeIW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kXZWqeIW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fd89d036so13565055ad.1
        for <virtualization@lists.linux.dev>; Wed, 05 Mar 2025 08:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741192484; x=1741797284; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oj8IVT+RqMLY39cee6JwSmbfQ9wBQwtZAQ90NgyAiPk=;
        b=kXZWqeIW5o9zoTJfdWQWL4OWv9446ot07JybE0UOCGqDve0ycSswvc5LMVU0aQ8vgh
         xar0oX5LZWgzm0RPYHdyRfBJSOKzV1tw07ir58vNlrmfMfODy252w1o36XGidxfem2He
         IcBmcfV/pwJaKMiPTeNWyJxHnEqmE7bVSc7lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192484; x=1741797284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oj8IVT+RqMLY39cee6JwSmbfQ9wBQwtZAQ90NgyAiPk=;
        b=cxebcf1OV9Ui+qJcKkacJd1USBNBceATJqOsSQp/pZWt4jstXevpG+TSrTjYVJJ14O
         tBZlxCLOWafTcWtX6IaVO6onLcUjq1xekmhCVH1JaxGDKF6mqOmSy/E+wpAPvx3zZzFo
         /bZnG9Z1+t/wf+jNvjBnrtqAcxZZp8O7LG1gq2X83hu4KurFScIQJIa1Ie9fpQa+GFEE
         g39pq5j4dR/h0ADYKKUApybcGrxxjTfOQ4wc+fw6mj9n4/Om65ggp1o/PniqYsBdqDjp
         u4gxpTe+X2OeYoUtLrHUIRq+8jaIb36xoPRIVOUuvxRUbXBRfoJevBn3xIPqB2ruagwP
         fo3A==
X-Forwarded-Encrypted: i=1; AJvYcCXSry1/adoLap3lSUqY0Zk8dgBNdZK3SdaSDxLV6Z875gpzMRzd4Sh1zT+r5VSdAuqQTwwMRacN7MpT4qIRbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzYLSJSuV299KRjYh6yi8DeZhU5XTFY2FefpCeCmWwS8T9BdsG
	kgnVNKTTKLZhgvPrG3xCM81B4UMeTb266LA/YYIpHD9CsWcchDj3G8oE8U0v7oI=
X-Gm-Gg: ASbGncuOwlJ5lbHhezAuFZsQeYKh3ubTVSSitJFe76DMs1yYQBAc0qUa+R2ikYzP3DG
	0WJenpalBBZUPIJXA7Ng/9EdlA8F8Apf0DPeOyaQ9Pvo2t6ikzx3D9vF3iSFGZA2MvE7eaLet60
	89795czzpZf9Io4Cl6mMA2nPC2vfZG67naTJxAfwFYOPQwqk/yS0AuNjrnKRz5TNt1nQj2AhyQD
	4HMCgzNBJoq8yg12ea7C+c8Iepr4TWJWmQ1b2XKU7cWPOK4GPtyIbJiWRY7knivDmGqABT3OT+n
	E/ES5IzdGNv2j9ltEXNO4ZzSGt35Jjj/72GhQW5XFCMegRjYOlVCkig4S8djqJsoq7t6v3xcvPQ
	z3cts6mRl4SQ=
X-Google-Smtp-Source: AGHT+IEftC9eWQqraTxiAa+hjmeMT1GN59eEFcCvKCUxzOWXFqKmPKYERLKg+VujKszgU0HOvaMZMw==
X-Received: by 2002:a05:6a00:2e9f:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-73682c8c058mr6003956b3a.16.1741192484001;
        Wed, 05 Mar 2025 08:34:44 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734ec1da824sm11266744b3a.170.2025.03.05.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:34:43 -0800 (PST)
Date: Wed, 5 Mar 2025 08:34:40 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8h9IKvGh4z8h35Y@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
 <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org>
 <Z8cXh43GJq2lolxE@LQ3V64L9R2>
 <CACGkMEug5+zjTjEiaUtvU6XtTe+tc7MEBaQSFbXG5YP_7tcPiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEug5+zjTjEiaUtvU6XtTe+tc7MEBaQSFbXG5YP_7tcPiQ@mail.gmail.com>

On Wed, Mar 05, 2025 at 01:11:55PM +0800, Jason Wang wrote:
> On Tue, Mar 4, 2025 at 11:09 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> > > On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:

[...]

> > > Middle ground would be to do what you suggested above and just leave
> > > a well worded comment somewhere that will show up in diffs adding queue
> > > API support?
> >
> > Jason, Michael, et. al.:  what do you think ? I don't want to spin
> > up a v6 if you are opposed to proceeding this way. Please let me
> > know.
> >
> 
> Maybe, but need to make sure there's no use-after-free (etc.
> virtnet_close() has several callers).

Sorry, I think I am missing something. Can you say more?

I was asking: if I add the following diff below to patch 3, will
that be acceptable for you as a middle ground until a more idiomatic
implementation can be done ?

Since this diff leaves refill_work as it functioned before, it
avoids the problem Jakub pointed out and shouldn't introduce any
bugs since refill_work isn't changing from the original
implementation ?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 76dcd65ec0f2..d6c8fe670005 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2883,15 +2883,9 @@ static void refill_work(struct work_struct *work)
        for (i = 0; i < vi->curr_queue_pairs; i++) {
                struct receive_queue *rq = &vi->rq[i];

-               rtnl_lock();
-               virtnet_napi_disable(rq);
-               rtnl_unlock();
-
+               napi_disable(&rq->napi);
                still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-
-               rtnl_lock();
-               virtnet_napi_enable(rq);
-               rtnl_unlock();
+               virtnet_napi_do_enable(rq->vq, &rq->napi);

                /* In theory, this can happen: if we don't get any buffers in
                 * we will *never* try to fill again.
