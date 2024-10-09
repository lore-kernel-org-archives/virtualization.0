Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF918B465
	for <virtualization@lists.linux.dev>; Wed,  9 Oct 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468294; cv=none; b=htfgGe/Rf7s2+Jt7uJ11I5qwzkMOwbOVk78sMcC4dFzagK9Qjfm/2Vbye1nTW6lJfNABogCWeDpIjkN066aamDRe4jP1QhqoxmBmFPDtXbSQymWQ0OLNzUZemfsazQB3xArXWC23IWLiT4N7F7mbcHbm+Q9S42/WHxSoweNjtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468294; c=relaxed/simple;
	bh=wJhVJ+3VA3g67o3DlF2lZIB2H/vMM4MBu8Rqq6UDh1k=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jLAAmoY8KWyP9W5Fh5PLee1XVYZmcmxrWeaxEskgdE8RN/oiXMe9dIIuBEL7y6AywBUVE+bSu70ixA+CPq2cbaB+yTCPQvIKaa1X0lGGCyo4W119EEwJjXlfCzFtNP7SAYoO9H0g90xJHkgfzVAt90XAVnt0mdKSne/deFQMH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fn0Lm68q; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fn0Lm68q"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728468289; h=Message-ID:Subject:Date:From:To;
	bh=EoPgooXBHHqcZaGog7p/CimjuVHlXZKaNgI2CkSSOvE=;
	b=Fn0Lm68qalUcoPYYRn4qUOMpWM6GWcx62JEcBTy0S3uLAj7GT+Tyi0rCEKCKSehNHOWDz4exBbIK6CCXF47h3ArXwIjJ3l3kNH2RZV1yLOWhyXJgsgXjhMDdAwcWodFVdqGyEAKRzug1sVvbfjvoemzVzTyaYJkDZT0BwvRquAc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WGiMLlU_1728468286)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 18:04:47 +0800
Message-ID: <1728468047.566891-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by default"
Date: Wed, 9 Oct 2024 18:00:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Darren Kenny <darren.kenny@oracle.com>,
 "Si-Wei Liu" <si-wei.liu@oracle.com>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
 <20241009052843-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241009052843-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 9 Oct 2024 05:29:35 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> > Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >
> > I still think that the patch can fix the problem, I hope Darren can re-test it
> > or give me more info.
> >
> >     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >
> > If that can not work or Darren can not reply in time, Michael you can try this
> > patch set.
> >
> > Thanks.
>
> It's been a month - were you going to post patches fixing bugs in premap
> and then re-enabling this?

[1] was tried to fix the bug in premapped mode.

We all wait the re-test from Darren.

But Jason and Takero have tested it.

If you do not want to wait Darren, we can discuss [1] or add it to your next
branch for more test.

Thanks.

[1]: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com


>
> Thanks!
>
>
> > Xuan Zhuo (3):
> >   Revert "virtio_net: rx remove premapped failover code"
> >   Revert "virtio_net: big mode skip the unmap check"
> >   virtio_net: disable premapped mode by default
> >
> >  drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
> >  1 file changed, 46 insertions(+), 49 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>
