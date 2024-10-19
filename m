Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9177BAEC
	for <virtualization@lists.linux.dev>; Sat, 19 Oct 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355539; cv=none; b=ZdLJdg1BH7gZSetmVQ1wZhgvz7Aov76gN/ir0j0AwXKo2cmCKH8kuow37ghrGRfc5J4iD+4KTmqdvofbuZn8u049SrxEm3DF/1f/fssRTx8gcKOSxa6RS3p+hTBZ5/bLrB7ODBbGRf5hZLsshmeaORZavFyRuER1Fj5s6VrnbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355539; c=relaxed/simple;
	bh=hiK14odWgJ+69p68S7Ex9WYiJtchHRMGDUwfV7v7LL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CuuJZCMrk/Bchqxbf5mTuiiN6w1blIkT1bDkqDAlHXPy5mg1FRliqbAh50e0KRoUgX8pZCmZcbzq0ffB02Aa5ksRUnDbrQgBuBPpH1oTNN2nUsF94I6mSOStO2bNN7vSnv0TJtz0ZxFVH3wjkjGZLA05Y0tvRZxENLYG27q40ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCUw/ZUz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCUw/ZUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729355536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jri3A5/LqIxor8N+KDtnG79y3WkHLfs7EcB+rulVroE=;
	b=HCUw/ZUz2LaB2SDxn1FTznyywg6UHsbipbviUAYGSB23/wDQ7PeyM4jrEqZapYTmNVpj/j
	yjdDMu3k5xEspZAwJSBhAL0Gg2BBWIkOKhSP+mEF5cOMGbCKtnseavfJjgdKgkXFA/8Q1N
	0b23FFy9d7VTDkO9nvI28KrT8pdXSsI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-OvtnihcaPze9QWtlwZjMDQ-1; Sat, 19 Oct 2024 12:32:15 -0400
X-MC-Unique: OvtnihcaPze9QWtlwZjMDQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4a211177so1563773f8f.0
        for <virtualization@lists.linux.dev>; Sat, 19 Oct 2024 09:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355534; x=1729960334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jri3A5/LqIxor8N+KDtnG79y3WkHLfs7EcB+rulVroE=;
        b=X/ID7wW6NHIXJq1wzo9VbT/E/BLRPCIh09r9yyyqGADFNhVLkhq7G1gqMSQrYmw4+G
         zUraNQs7+SvBCkEsdEcd/qYHpOhJKp6DHQe2ydXDabxmQxZmxj35GIuDytE/k33Gp9ue
         FmHkAXck4R7chHFoNV6j+EFmwCgsok7JKCcNyN59SJf1mBOAognUe3A5zdF1W2JvK36V
         j3DZFgAXABog6uvQ7UvMH6wl71CuRHGXq4h+kHqkt0clt8m/e8ejfTI7ER1yIHyoXXH9
         jp8pz9wFa1uvfDSubVxMcIc7ltmXYzBU3rEBBKRJFCtxRwwWfFH5jxUQtZxRmS3DeyLc
         +rAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmbNnmZRnT7zgy7huVc7Hg9I8J2NLG+gn/TRRwJxvfDcsF4UszvoHMVuHz5hwljNp/SzfhaaLNaxLjkGQ5hw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXANQfxDOHlRg+A0mtOtG/Xt9wg/gFydCzw683h02BfVpWnOtd
	Fps4fJowNarOBgHOkHoD1RNqIz5bq84MzhSZhHm07OB/y2vlMiCw5vciHsA9oK5h/CeUU112EFh
	CQ+3uoW9DJ5O1sjKVoanwecplVFKg0zc8kklLBG22JiXhvx16Mhm1vOGojpikL33w
X-Received: by 2002:adf:f883:0:b0:37d:529f:ac1e with SMTP id ffacd0b85a97d-37ebd3a6035mr4053785f8f.53.1729355534331;
        Sat, 19 Oct 2024 09:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT/wgWyBLryARTXkB+NHtmMEQqhlYTSaiwN1r9L1u+/9jvus81e06CIrU5Ii8VeRCMc6p79Q==
X-Received: by 2002:adf:f883:0:b0:37d:529f:ac1e with SMTP id ffacd0b85a97d-37ebd3a6035mr4053764f8f.53.1729355533918;
        Sat, 19 Oct 2024 09:32:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf1193f1sm4820164f8f.103.2024.10.19.09.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:32:13 -0700 (PDT)
Date: Sat, 19 Oct 2024 12:32:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Darren Kenny <darren.kenny@oracle.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/5] virtio_net: enable premapped mode by default
Message-ID: <20241019123159-mutt-send-email-mst@kernel.org>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014005529-mutt-send-email-mst@kernel.org>
 <m2bjzkeb2u.fsf@oracle.com>
 <m2zfn1a24d.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <m2zfn1a24d.fsf@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2024 at 03:59:14PM +0100, Darren Kenny wrote:
> Hi Michael / Xuan Zhuo,
> 
> On Wednesday, 2024-10-16 at 08:55:21 +01, Darren Kenny wrote:
> > Hi Michael,
> >
> > On Monday, 2024-10-14 at 00:57:41 -04, Michael S. Tsirkin wrote:
> >> On Mon, Oct 14, 2024 at 11:12:29AM +0800, Xuan Zhuo wrote:
> >>> In the last linux version, we disabled this feature to fix the
> >>> regress[1].
> >>> 
> >>> The patch set is try to fix the problem and re-enable it.
> >>> 
> >>> More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >>> 
> >>> Thanks.
> >>> 
> >>> [1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >>
> >> Darren, you previously reported crashes with a patch very similar to 1/5.
> >> Can you please test this patchset and report whether they
> >> are still observed?
> >> If yes, any data on how to reproduce would be very benefitial for Xuan
> >> Zhuo.
> >>
> >
> > I aim to get to this in the next week, but I don't currently have
> > access to a system to test it, it will take a few days at least before I
> > can get one.
> 
> I finally a managed to get access to a system to test this on, and it
> looks like things are working with this patch-set. So...
> 
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.

Thanks a lot Darren!

-- 
MST

