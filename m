Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5E1D61B9
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884576; cv=none; b=cNlnTySIbHa0b2zoSbP/gMiX+zMghseYnEgs5AV/jKohbwSujkOxKiMbx+/1F1aq+bxnz/R6wDBBzvPFEtnRerimRLlJroTf4kdP97Wj55+0/lq1f7R5qhwNNPkTHwB2YJ6T/6jgu24NcCqnvekSJyN8YAFB0KIqbfRGUpsd/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884576; c=relaxed/simple;
	bh=LiWfgtP3ccuFSeeihkum3Zsw2j+Q/tBTiOLrwo9T6sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nghjh2KgpqAt3f+UHonMywjjb/23nQDZ+yOy1mjBM+OiYcOkxfJFT8BAas3836W7PQcpGL2rafTLbKCX6B8mDXSmvrONQLegaOc9yn8EO5f3UNTkD+5lVtp3gBWUaidvhNyE5+sMyd9PbbYGtI+2oU5utUr9jGcaxZiRNZl7RSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJKFqEyf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJKFqEyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730884573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpGds3rrLDrDyMfb6nHlArwXd7ub7kAc2WQ+kRP5Q+E=;
	b=cJKFqEyfKJa8485dkmJ6lCKDzM8Gc4kJ+5xAPO2FkhKcWCxWsRdDlRugMgVzYbHOhGOjxr
	OPAzmjXdd9DYEJ6zdwGL5Y/pfhssjUhj0hNn7vuEA1keNMpdfVMhr6kx7wJjJIk+O3Q1n3
	rkT5UlRzXDFixELxPvcidB1ujDOpHJ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-OVGd-mmjPSeExXjXzFTzmQ-1; Wed, 06 Nov 2024 04:16:12 -0500
X-MC-Unique: OVGd-mmjPSeExXjXzFTzmQ-1
X-Mimecast-MFC-AGG-ID: OVGd-mmjPSeExXjXzFTzmQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so3482785f8f.3
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 01:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884571; x=1731489371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpGds3rrLDrDyMfb6nHlArwXd7ub7kAc2WQ+kRP5Q+E=;
        b=s60P/mEhgxFSDkPPQECJMcb4wDzvFTRTybjfC/Q/tE4uLaVQQxxi0/jW/FVR+1Y81H
         yHFkx/0ycRYyryKL22fvtjHMLMa6K10l5XN7t/0ZTYPp7jAZ3NA3982Kvb2/FU7ZwGC8
         KsxruhR5P4ECV8354oDnJvDIRIo/nEXCk0brMwCwUDMUDBsG5E303Gjr+4UxiEwZ3qXf
         /HFl2bCs+M/3QIa48J6+TvLwLco+4wQR8dkP/7kb0x7zvU//5rpu2wEJDL5RYHft7BKT
         1u0lg9w91QY2hDGCbvNbNMUT6ha/DB/Y0gcFl0HLt5bSc41BkfMdpwTV9Wgh8FnlWGns
         Jbvw==
X-Forwarded-Encrypted: i=1; AJvYcCW9KCJ8Ut0LFNAKRKUj6lfvRFFGih3j9jAhQdt9XeGs/NpSeG8PgU9EZjyd0wp1ggCfT3ZTxE/pvDSJgsl4/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJbnBEptFeIN1EFaWpCBlpJSr3yuKWf7Dlz9mq8gv9qB9w/wZC
	0yPALgXmApGXlyAK4Yx1wTdn2rEtdjWZZPf3FTICudn3A4VLXfPQBDECHOfODl9HqnFNt0rEOh7
	bCaMS5LejmItIjYxuD+taQdjllNfRZ0lYSF5Z91ty11lMEXvHsotlXCIQx/x0zuCz
X-Received: by 2002:a05:6000:178a:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-381be7654bbmr19918775f8f.10.1730884571473;
        Wed, 06 Nov 2024 01:16:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzRwU2TOM2eQPF5E6Rf2mNxBpWaMzmZbkkznCCrfo7GyAOnLbimkewh0GmBs2JIyl8mHd0hQ==
X-Received: by 2002:a05:6000:178a:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-381be7654bbmr19918753f8f.10.1730884571022;
        Wed, 06 Nov 2024 01:16:11 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e56sm15522815e9.2.2024.11.06.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:16:10 -0800 (PST)
Date: Wed, 6 Nov 2024 04:16:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by
 default
Message-ID: <20241106041545-mutt-send-email-mst@kernel.org>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
 <20241104184641.525f8cdf@kernel.org>
 <20241106023803-mutt-send-email-mst@kernel.org>
 <1730882783.399233-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1730882783.399233-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tHs3kpgVhObRofeK7JKBt8gv-hFS3wN4MoFYrY7gA6A_1730884571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 04:46:23PM +0800, Xuan Zhuo wrote:
> On Wed, 6 Nov 2024 02:38:40 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Nov 04, 2024 at 06:46:41PM -0800, Jakub Kicinski wrote:
> > > On Tue, 29 Oct 2024 16:46:11 +0800 Xuan Zhuo wrote:
> > > > In the last linux version, we disabled this feature to fix the
> > > > regress[1].
> > > >
> > > > The patch set is try to fix the problem and re-enable it.
> > > >
> > > > More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> > >
> > > Sorry to ping, Michael, Jason we're waiting to hear from you on
> > > this one.
> >
> > Can patch 1 be applied on net as well? Or I can take it through
> > my tree. It's a bugfix, just for an uncommon configuration.
> 
> 
> Why? That can not be triggered in net branch.
> 
> Thanks

I thought it can but can't remember why now. OK, nm then, thanks!

