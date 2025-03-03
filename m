Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490E236A63
	for <virtualization@lists.linux.dev>; Mon,  3 Mar 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021215; cv=none; b=j7qdM1yNcwUpQEsVLHjtRKPVYy0ncwFWpwIM15VBjT/wUuAOkz0rgYM3/ok6qg9ZUNKDRBQxyUD9H00EFGgWHYa74n66IidvGE3ANEwE0t7ueohsNqRHt7LqzqdPJVlZzAPPXcj0fn6neYNyy4bzFQMUg1Ht3kXQmhLGRAZSMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021215; c=relaxed/simple;
	bh=PuyMo56E1J04N+xRFHQpuOme3py1aZX9AvRAkMmg0TQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwJ4JMKcBhQm5QOMQW+03x97IeXGq8vBOJqLZP+adguqsLnay3yVJ/gmCh2DKshaAzcP/WvxFftWwp/rLcg9LC1O0PtH7s8Uorouqm5s++Tbb8yC/S3qVwgspNMz5Ui2zK1EXyGyMrtpL2jFyqWugX5DUmbnULlw1p2Cqlu+blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CrgBQViW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CrgBQViW"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c07b65efeeso429818585a.2
        for <virtualization@lists.linux.dev>; Mon, 03 Mar 2025 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741021213; x=1741626013; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yL69mmP3AaHszBSiFbdb5IOP3AgAgn4Zq7i8mgBTtbc=;
        b=CrgBQViWVGqP2lbsKLWk8Mah0gU0L702Jx0bX3Eg3fNuwN940rngI2OpgJHR6Oln0a
         icxKtJ+UT7HgVD+TSW077hRnBhquDe+2XjVnswQiihGUg8VU/O5WEB0fC7kDnWl4Q4o7
         AfJsIaRxc8oYGrxQJtaKNKaKGtKrK2olYYEfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021213; x=1741626013;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yL69mmP3AaHszBSiFbdb5IOP3AgAgn4Zq7i8mgBTtbc=;
        b=uk9NadsTpC9JSDklBQd7cflhPpF1u0vUEurp0MR3gIZjLOW6acAc44uHKBC6Y6iCyA
         l4otyHQiab5EaWuINJbXF4JfUgEPDuFXxeA0Xrop8V92Pmd/ZqPjImrj0va8LcUlUuTq
         i+fXfKYthCFyguKTCnTeXKToYBeDk6c8CH4cNfkbillKLGkoEadEF7ZlEG7nwQ5thPfJ
         JJXsQ/KYJ2g2cH+b6UvkXMmmZjmktRyWYkVGbAi9yKHuNsJcEivSKQUpQlYxnhKeolzP
         z+cV7v/7Rekf0HzNxQMutHg8NwDpTux4AzZZUo6n2Jd5niUVn2pNEcEqezJk/6ONIkuf
         YIiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTAyuSdly71tnWfJT1lLWJQ+RAI2gIiLWvlNqIHDRUNoZVmfdez7IzZ5G9SK2Cp/avzSmCWggswecdalGwFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWhQHcf7nJWvbL+Y9nSmv5IRxlf1HY165hLcUYrh6owFAhKAb1
	t+5tAocrN7O0Hvowt/UvxM3Rde55oOnb7k2KE92sVS6FyrqG78YKnki8CBlom48=
X-Gm-Gg: ASbGncuS685DX9J4B0yOZvBwYRnEm177YVgptRmcUjBS+iBJJtVvqJB1Ls1iwDZ9Ytn
	ft7rHkyzyqJ3JFKvKcAB+cTVzwked8GGsfIBlV4ZsFwvRGcotKJ6gFSa7H91DKYo/v2QZEWqeRH
	B3D+KMdlSI4GFVCOFxcyVZ6lQazFAgr9ngRO3XzRl1u31pdpa4+MIb72vLsO1kRfkFXW9RvN130
	lP4sxY2pBnu4NYZgUG8NdLZuUUTV281782x5cO+2O88LBI6M+k2nWgqu6SwOp9EYYA2nFY6bRpI
	UsM+Gq016GCj67HFQgBcNxGTXmI4b5+pgeJAv0nyQqlQVYcfhMAtVv7uqhJRre3oQ7sJuqQrMzO
	SNb+Z13o=
X-Google-Smtp-Source: AGHT+IHlpeyEa5ZH06VbJgoLcEMoTEGviZJYbrPAPhw4YUCksto74AOTT5BgLi6sgiQez9Vt7bG6ig==
X-Received: by 2002:a05:620a:27c7:b0:7c3:bcb2:f44f with SMTP id af79cd13be357-7c3bcb3000emr677131585a.17.1741021212762;
        Mon, 03 Mar 2025 09:00:12 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36ff0f3c0sm621367685a.56.2025.03.03.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:00:12 -0800 (PST)
Date: Mon, 3 Mar 2025 12:00:10 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
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
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>

On Mon, Mar 03, 2025 at 11:46:10AM -0500, Joe Damato wrote:
> On Fri, Feb 28, 2025 at 06:27:59PM -0800, Jakub Kicinski wrote:
> > On Thu, 27 Feb 2025 18:50:13 +0000 Joe Damato wrote:
> > > @@ -2870,9 +2883,15 @@ static void refill_work(struct work_struct *work)
> > >  	for (i = 0; i < vi->curr_queue_pairs; i++) {
> > >  		struct receive_queue *rq = &vi->rq[i];
> > >  
> > > +		rtnl_lock();
> > >  		virtnet_napi_disable(rq);
> > > +		rtnl_unlock();
> > > +
> > >  		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > > +
> > > +		rtnl_lock();
> > >  		virtnet_napi_enable(rq);
> > > +		rtnl_unlock();
> > 
> > Looks to me like refill_work is cancelled _sync while holding rtnl_lock
> > from the close path. I think this could deadlock?
> 
> Good catch, thank you!
> 
> It looks like this is also the case in the failure path on
> virtnet_open.
> 
> Jason: do you have any suggestions?
> 
> It looks like in both open and close disable_delayed_refill is
> called first, before the cancel_delayed_work_sync.
> 
> Would something like this solve the problem?
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 76dcd65ec0f2..457115300f05 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct *work)
>         bool still_empty;
>         int i;
> 
> +       spin_lock(&vi->refill_lock);
> +       if (!vi->refill_enabled) {
> +               spin_unlock(&vi->refill_lock);
> +               return;
> +       }
> +       spin_unlock(&vi->refill_lock);
> +
>         for (i = 0; i < vi->curr_queue_pairs; i++) {
>                 struct receive_queue *rq = &vi->rq[i];
>

Err, I suppose this also doesn't work because:

CPU0                       CPU1
rtnl_lock                  (before CPU0 calls disable_delayed_refill) 
  virtnet_close            refill_work
                             rtnl_lock()
  cancel_sync <= deadlock

Need to give this a bit more thought.
