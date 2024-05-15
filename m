Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3A155747
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785676; cv=none; b=Indrlprd+AFLdhfQAD3WGU9VmIFFOFnhIzklKxCuZ9BeUWW+gzrYdMe9kkVr7YlA97NZZ7alm9Z7tS1gz2h436W/ofM3BHfsptzKPsyGEqSfADdIeqTqQH9AYumIs0v5CbI5eaRvGVW62Ow5mcYuwXSPNgX3eL7prBeerJ1zN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785676; c=relaxed/simple;
	bh=nB/Wx+bzRLvAZM9HJrayest7/Jl5WbZCbrJZngd9CQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Eyggs/TFhl6T7b6S/Ttzf9Dsx5J4Ji2YIptSSLyWhVzfdG9LQcY3dzWetqgNZiHs9FzLMDEh4Us6RW0jHolEc8IwblHCIEbLNS1VRrjlX8hRIgRmV0UtoJpAKhe79Y6YkmnrmCBovQEn/yY/zKS2ypvo44bMc1q3xUl7g2coicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Icb5UgFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Icb5UgFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715785673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbrWi8lbFLyv72mKMlVkkmYPCKHUduDQsR6vbInAIJA=;
	b=Icb5UgFd1NcQ6lNwAkB3zHPm4s2S8XA3+TBQ9uYP3b8UpkcoVfVmrMpzZo3Cknp17JR5oD
	i4NefmiCzPAoymi09Im1Kkm1MaGXwSO9PrFWj423X0VlemR18AFZJwmfnu1l5FLpJUXNpy
	DhDcXT3aocFNXiL3fQRqZoJ5Od4wZFg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-CGgfd7HjNP6uJ2w3LPWJjg-1; Wed, 15 May 2024 11:07:36 -0400
X-MC-Unique: CGgfd7HjNP6uJ2w3LPWJjg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e345cdb52bso68481601fa.3
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 08:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785635; x=1716390435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbrWi8lbFLyv72mKMlVkkmYPCKHUduDQsR6vbInAIJA=;
        b=f0+QUMMqVA/vl6SulsmrUgRDnhXy2holIo2ay2h/f65WEVy68ncmyE/YWt4Znym6R5
         1AfBt+R5ohgFTsvMAgzwOMi7pa7kA9kze99xEWcgzxv7fgS8ESlDGEerYanSwAWTbaYj
         /p77NY1N1+c756eizjY8B8VTsDVfksp5sgV4sMMSAEpdw4cTjleKzjlreVn6BzZiiE7p
         /uk9XqxbFXCH7zpjjyOUC0zKG56BuruOIQ0UJxNRiMXnEbsgY7lZGC69ciEqIJfBH1UA
         HuWhLGJcozSuR5UkspNpTI5PHo/yMOglJcQ3Xktc5YeXC1y38nGCKCDuxVvbsugAKst/
         P1kw==
X-Forwarded-Encrypted: i=1; AJvYcCWmYfHedOHL1zQCEXyPfGMBw5bEp1lDCwkegzjYrX9gQ6rDfj8vPvu/c1qdnIqvfaIN5Gw5UhzRebqG8ppoAs8qQjHhFvVkq8yg79H1dYM=
X-Gm-Message-State: AOJu0YzRxKgmdJoRZ3xhLZnYiz5XTPOXCDI3JthWvNMaq+mZ4QFQMjCh
	daYosl0OL9cw92S4ScRkys2Mna7TZrMlP5HAlzIiySThHK5wZyIiLsLCL4v/BPf/UDuDRWEnmgc
	hieNKeSQXtuj4ZlMBBJ3NB64ih6qodrALJyipcSBdX/zopiezwN/6XdPSw+kFV9Py
X-Received: by 2002:a2e:7c0d:0:b0:2e3:7121:aba6 with SMTP id 38308e7fff4ca-2e5205c61a3mr133092431fa.46.1715785635228;
        Wed, 15 May 2024 08:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA2MjU83PmPbl4SP+crO3lzmgqKP48+f4i5kvUwU7C8/1az1QdYe3lnvRKkMDiMLe7dIqRJw==
X-Received: by 2002:a2e:7c0d:0:b0:2e3:7121:aba6 with SMTP id 38308e7fff4ca-2e5205c61a3mr133092081fa.46.1715785634668;
        Wed, 15 May 2024 08:07:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bccesm16825319f8f.5.2024.05.15.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:07:13 -0700 (PDT)
Date: Wed, 15 May 2024 11:07:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: Fix error code in
 __virtnet_get_hw_stats()
Message-ID: <20240515110626-mutt-send-email-mst@kernel.org>
References: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
 <20240512115645-mutt-send-email-mst@kernel.org>
 <1682873e-eb14-48e4-9ac6-c0a69ea62959@suswa.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1682873e-eb14-48e4-9ac6-c0a69ea62959@suswa.mountain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 04:50:48PM +0200, Dan Carpenter wrote:
> On Sun, May 12, 2024 at 12:01:55PM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 10, 2024 at 03:50:45PM +0300, Dan Carpenter wrote:
> > > The virtnet_send_command_reply() function returns true on success or
> > > false on failure.  The "ok" variable is true/false depending on whether
> > > it succeeds or not.  It's up to the caller to translate the true/false
> > > into -EINVAL on failure or zero for success.
> > > 
> > > The bug is that __virtnet_get_hw_stats() returns false for both
> > > errors and success.  It's not a bug, but it is confusing that the caller
> > > virtnet_get_hw_stats() uses an "ok" variable to store negative error
> > > codes.
> > 
> > The bug is ... It's not a bug ....
> > 
> > I think what you are trying to say is that the error isn't
> > really handled anyway, except for printing a warning,
> > so it's not a big deal.
> > 
> > Right?
> > 
> 
> No, I'm sorry, that was confusing.  The change to __virtnet_get_hw_stats()
> is a bugfix but the change to virtnet_get_hw_stats() was not a bugfix.
> I viewed this all as really one thing, because it's cleaning up the
> error codes which happens to fix a bug.  It seems very related.  At the
> same time, I can also see how people would disagree.
> 
> I'm traveling until May 23.  I can resend this.  Probably as two patches
> for simpler review.
> 
> regards,
> dan carpenter
>  

Yea, no rush - bugfixes are fine after 23. And it's ok to combine into
one - we don't want inconsistent code - just please write a clear
commit log message.


-- 
MST

