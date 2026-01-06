Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98133A9FD
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695312; cv=none; b=dFOyIDNclw1+Woy+w9ipzs4GzZ5i9ont6zExO8HaYmt0tqBMsF9lHXpBMAwfD9g/X/p2aeENIbe1FrpYGRRstKHLuvqgoHvVg6ZE0WkyO6YuJHvhJBmbJTlLbe+2SSre9110ZEeUATSal2QInVbBo5lrloiObxgOnm0VJhVrQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695312; c=relaxed/simple;
	bh=nEu4WOz+vtpJU2TGs6EPbQkaMhnf0O8StNk988KhUnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCpO64bq8Datbf1Owy1CZ4IHfw5X6moOTskO235W3dQVS/qHdKZZDrrsB3FHLq2M01P6B56YUscgBhoFd77iFtt1Xhgojro2MMMcPjIuVtpeyDwCFybodrbsSFeIYWarcjyMUyzyzK/0V226TnGq5YY5UNhlNF1fUIVqdhHDoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWttEKLg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWttEKLg"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso286445a12.1
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767695309; x=1768300109; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAJkKuJpYWdtj8kvDzq7kj79D0dSrUm44Ey46PsxwVE=;
        b=lWttEKLgsTdtmr2Pkk91kRhPY3uA709i0d1P1sDvTwwk+T8a/Dj+IyCt9Py50QiyBh
         8UxXVm0NADIY0WkjHBInk/TPIy5i6NFognLvlMmCaIlEZNIIWNqicKeKxXMTW3JRogPa
         NF0q5SZ5+zoz49Ixpy1pUipgINHTH1uM5uYUFoJTVCgBeEzT9ktCo3p82zGmdRKFofvc
         4kUXGbIASaWOr4WO3lo/rbVOoScPtgYs/05iaP65NtnwWJAP8ANVWgUK2Q6oY7lPtcX1
         yvGgBBokN1+nv6+agkWfuX7YkoEZiqJw6Lv0wjxstVuFva0zvYOeCuX/9YD/Lqt17ZXy
         Z+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767695309; x=1768300109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAJkKuJpYWdtj8kvDzq7kj79D0dSrUm44Ey46PsxwVE=;
        b=Cr1USl7oll5DDYz/g3fjaaXriSk69b8m6Zke55Odw+nX3njaap8g4mQhYSWI25NJiT
         hjiU5Hq3Pw7gXtM9pl6+1tK058x9benHNMUd5ZT1tgF5ulKlMEk7d8ub0OrxHuvDRcP3
         XCESM/XM/0DXONfUmbLfDk+wo16hY4ybbNKMRR7tJKylHLt74EEtfd7ALrS09Gp+G7Bo
         0wfgy8ypd0gIz3bdgIgRy0+wT/TZG3ms5qvI1m8GqT27c3tx46nl5TMmb1Wb9vZ2lhWS
         pKc9WtJWESfqDGLFJW6PWviZdaMzOk/RDyse4OcbXx9P50qQzW+cUzMmAFeQ67osQaIA
         0m8g==
X-Forwarded-Encrypted: i=1; AJvYcCVkwQYq8TOIkcStUmFcCsIoMjLllnKCpcbbW70QQTjVFWRB758lxDkKMDVA2HTmlPruA83qalPPUDJrzxDDQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzClN45d6cw1ziE235iahMYSqtTYMO52el7nry6QOqBj/GtdS/n
	9cSlXvDig3XvRbJZ9KLbvS6uPeZA42HBa5Vvq7NB9fMsPBKnXz661PbqCfbd/HzMr0SyCY198tD
	50F4wJm+S1hgwh7oV7rgf55o499JIevA=
X-Gm-Gg: AY/fxX5kW8eW8LeHnfmnaRofhRaIAEUf7HGFKiu3wUhBdhG6myXW4yqmu0iv/2nu8Bo
	0y/Q+5l8QCQ2cE9IlXKOupiUpsBtCC+ArFFPAjd2oOjGMSmC407yKdNdX53Z5tHmi96Q6uFiKDm
	PzwFUqGIigwIex9R0QC/HX33nDvPXfsvvZNxpizPTNcH6AkWsJVfgudJDpZlFMk4fm/hw2WUehY
	9HYnim3eONpg2T3jP2K/MYGvGXAqIYn6nFsPsakdlCgh67YSTP2UBuNLtjkoR07GNPKbpRZEms/
	ZFCXC9QVJuXAxghwHvQ/UIo8E6Y=
X-Google-Smtp-Source: AGHT+IE596N+CStEx+ymFl4KP/IAg7DPwvIzsQgEPdelrrDg73nHTs58Enhoj6GXrimF8vBvgCjK+cC8m257+3fVL7o=
X-Received: by 2002:aa7:c343:0:b0:64b:a52b:fa1b with SMTP id
 4fb4d7f45d1cf-6507bc60919mr1656343a12.6.1767695308725; Tue, 06 Jan 2026
 02:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260102180530.1559514-1-viswanathiyyappan@gmail.com> <20260102180530.1559514-2-viswanathiyyappan@gmail.com>
In-Reply-To: <20260102180530.1559514-2-viswanathiyyappan@gmail.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Tue, 6 Jan 2026 15:58:16 +0530
X-Gm-Features: AQt7F2qFv-ofQsHt7p0xfCLNT_q5NACm8CoTMw_f6VL8XWeKj3K9Y8M7vOIoYlU
Message-ID: <CAPrAcgNR+=GS0RxH_UP1Hz3U-HJL3_ZdGoy=hqkdS=iXL8zF8w@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/2] net: refactor set_rx_mode into snapshot
 and deferred I/O
To: edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, eperezma@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +static void netif_free_cleanup_work(struct net_device *dev)
> +{
> +       if (!dev->cleanup_work)
> +               return;
> +
> +       cancel_work_sync(&dev->cleanup_work->work);
> +       kfree(dev->cleanup_work);
> +       dev->cleanup_work = NULL;
> +}
> +
> @@ -1682,6 +1882,16 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
>         if (!ret && ops->ndo_open)
>                 ret = ops->ndo_open(dev);
>
> +       if (!ret && dev->needs_cleanup_work) {
> +               if (!dev->cleanup_work)
> +                       ret = netif_alloc_cleanup_work(dev);
> +               else
> +                       cancel_work_sync(&dev->cleanup_work->work);
> +       }
> +
> +       if (!ret && ops->ndo_write_rx_mode)
> +               ret = netif_alloc_rx_mode_ctx(dev);
> +
>         netpoll_poll_enable(dev);

This is the response to the AI review. Honestly impressed by how good
the AI review is

My bad, It should be flush_work() not cancel_work_sync() in
__dev_open() and also in
netif_free_cleanup_work(). These are the only places where execution
needs to wait
for completion of the cleanup work

It's ok to just cancel rx_mode work so this issue is only with the cleanup work
