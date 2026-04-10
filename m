Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB43A16B1
	for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816012; cv=none; b=MELeaNg8S8y0an7LsbmUcCPEJRdX/Qc9k88Bfk8zq3FNVm7rJtuPjGAy5H3Y2A9nnUewFfVewudTBqkiMfMotU2AZ/YfI/UCiUFh1twPRHRgqeLeW/EWpyvn6Y9Xa8kD5f67FYq5dn5IXP07ML4XAKcmXGn3Ywm4EDDyC4KjFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816012; c=relaxed/simple;
	bh=CkkTcVRvO2d7MMdIVZLYeQllhjaF97ikmEow5w5WxQY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CzkzCCZHPODXQgbbfCUUjqJMalIVJaeiInI8EgsAK4kF7//DD+7LpqC5BV/EcOO5vTUXSrDgyg0/I80HspslHJ4348LWjf2sFj9+gUNFyPJu+TMD2dghxXpr1GxhKgNj4xAqphqWgbZdia+TP8W0M2dr+KoQmQ0QkCDITtvwfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6rYDdTI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6rYDdTI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so28532375e9.2
        for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 03:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816009; x=1776420809; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n65v5lHWYrbJBAxts2dg++sYtCJXZprIZe4TiVjxC2U=;
        b=P6rYDdTIpDkiYysX/Iw0eWTNj0Qw1mki8lYk4eTJ3PX1HigjUIqx8NHCS2pOj8GMAW
         Cei4//48Qy5O7seK+3plzryVktjrUVgYDRR7ZxKZmHNDWlFjRPAe82XYTTtiu6OeO4A7
         57QgFW2jZ0OV0L/DYzl1CtDsgk7pSWqv9/RIzX4OFzNKBwCtWWCiF0CnNsvnChTwuMIM
         YbqqnN2vnLRT8LnFy7KV7iAdPF78FWSoA0KPazd8XZY9P1hK7kKR4Epm3bY9DD7tTxF9
         x41907AloffQUZzhbmaG/YVEcwV0XkL72bvQUptskLJGOr8kj39r5Vw7KE2Qc3aiW4ne
         0G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816009; x=1776420809;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n65v5lHWYrbJBAxts2dg++sYtCJXZprIZe4TiVjxC2U=;
        b=kWoE7n5r5AO8VIrspace/esghucKaH0+/vJnTy4TzBeZkytDHW4vnfOW5kq8PVeNvk
         Yq7xSKXSTMet/epm4Psw5cRhOuKCsG5z3Eb6PQy6AkfrOF6ghuaeLiY3Rih35VW2f3Fb
         +W7b2TwedrrwNiPT3tq85VboNK+HodYp/ipBWuGPNgebz1cHEcOEm++uVOQLxwIrukFD
         /x+WWVN6zthBXiP1K/Lp7V/tWYfJYVnUZsDwboEewcrgxIKeKWlNf9LBBUMnUpNbtaGv
         ad31C2LLRLy+4mnYm+4ZFggAS5QibN55hIx5UL5qqgwQUIu34yz+QLwEzHNbTsEmRAX/
         Zqxw==
X-Gm-Message-State: AOJu0Yymck3i2hek4hrtNtvksNfBYjTgBNkNrQDRZYTyaHEzl2TCS9vM
	WUn/vUjhNgpjQm87TgK9aP4kPicnvQXe6NhTpjx9AmjpkJr5Hrbc2z37UDoe+pOK
X-Gm-Gg: AeBDietENrP3nKblkUaNvd+X6LVQNBTa+v+eYlinq250OohvPKlkEa8f+tev2jZ6vvX
	OQe2ae1gqRX1qErTXI8z4Pmh6geJNxtv4uFvN+26mODpmMr/fRTv4sokT29NdET6Enkn/2uCpeA
	vDMFwqfj9UmwhHR4JKTEqHCOP+Lf5n8AZ9zpoqhlU8cBq+IK5PpiZ0m2rPohZg7FQSpPnVCGG5M
	KMowi0q8zGut4lqLjKPk8EaAzr/1Jmooj2C7bp3mX+hbt75ln3ccb2B3tg8szMBhcrI0ZNsmopp
	18wkIA5SoxERjLia+XeMiVJMlSrRP3aArUVCCJRF1pZV5fRO+06s6Kec/XMRqx8LPN3Mg88a2Ze
	MgA6vM/IisU1IEadtGoELbr+7esSXESwScsQUUBgwckCye9y6svKLkE1IqjfQcjhFoIZWAHulVd
	ngjPMSHbaZ9TNEG49QtyE=
X-Received: by 2002:a05:600c:4504:b0:488:9db9:5235 with SMTP id 5b1f17b1804b1-488d6867c23mr29381225e9.22.1775816009016;
        Fri, 10 Apr 2026 03:13:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58bf10fsm60132125e9.8.2026.04.10.03.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:13:27 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:13:24 +0300
From: Dan Carpenter <error27@gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev
Subject: [bug report] virtio_net: xsk: bind/unbind xsk for rx
Message-ID: <adjNRD31OBaVl4He@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Xuan Zhuo,

Commit 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx") from
Jul 8, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/virtio_net.c:5893 virtnet_xsk_pool_enable()
	warn: potential bounds check after use 'qid'

drivers/net/virtio_net.c
    5873 static int virtnet_xsk_pool_enable(struct net_device *dev,
    5874                                    struct xsk_buff_pool *pool,
    5875                                    u16 qid)
    5876 {
    5877         struct virtnet_info *vi = netdev_priv(dev);
    5878         struct receive_queue *rq;
    5879         struct device *dma_dev;
    5880         struct send_queue *sq;
    5881         dma_addr_t hdr_dma;
    5882         int err, size;
    5883 
    5884         if (vi->hdr_len > xsk_pool_get_headroom(pool))
    5885                 return -EINVAL;
    5886 
    5887         /* In big_packets mode, xdp cannot work, so there is no need to
    5888          * initialize xsk of rq.
    5889          */
    5890         if (!vi->rq[qid].page_pool)
                             ^^^
flip these two checks around

    5891                 return -ENOENT;
    5892 
--> 5893         if (qid >= vi->curr_queue_pairs)
                     ^^^
So that we check that qid is valid before using it as an index into the
->rq[] array?

    5894                 return -EINVAL;
    5895 
    5896         sq = &vi->sq[qid];
    5897         rq = &vi->rq[qid];
    5898 
    5899         /* xsk assumes that tx and rx must have the same dma device. The af-xdp

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
