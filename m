Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC049224B10
	for <virtualization@lists.linux.dev>; Fri, 24 Jan 2025 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749975; cv=none; b=KPFUKgJRHvuA9e5w1heqLZ6FTDbQ3CbN4bazPXiOq8dCOGMol+nAE98rdowv/5cVig8Y5nR9bmozBI7nrpFFS4I2jimZWRyU2GDCKH/uE3qx8pIn7sX99r0K2bA860IbbwbCQsJqPKr2n08xztyMPwyAuG04PKRMy9Jdhi2YRwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749975; c=relaxed/simple;
	bh=Mct/s8icCxgISw7/YyvdW0tKtb93dWIuER94Ecuz9fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD6+6+gmI1j6NdiDu1VZZ7wXln/mPhBzi8txDC4Xuowy33G7AuHkyEWrTjgoiyilyI54INuwM7Ajjh55HSJOg6jqIOgv/9mHkdJ7217PQOMsDDDL9aj6Fj9owupg8Z+Xh1rX/8wMx/qL32xOWjwpPux3cJDpx2RRV79n+hxTKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bruKWUO7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bruKWUO7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2167141dfa1so46961145ad.1
        for <virtualization@lists.linux.dev>; Fri, 24 Jan 2025 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737749973; x=1738354773; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixB98NmCHGnppTZhm0g8E8pIn7GO1Kr2T45neZxhNN4=;
        b=bruKWUO7YyfndRROMfWy3wv1fBF8ZWJY3d5p8Wp25fplI5RmriyJfr9t3twWnrP5MA
         G1oW6LTvWe+/qLNDnyA1tieuQy1sKYZqQgXgCZdHvq91dQm2pWbPhunhTTQUD3sMMJAx
         k0DcQ4jQci8JfnT1H0hGu8T0hEl7jk2hD3264=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737749973; x=1738354773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixB98NmCHGnppTZhm0g8E8pIn7GO1Kr2T45neZxhNN4=;
        b=EeYukoMnIkYTUJOn32AKItCCU+FPCwsl4qLz1wQ7QAf2L7Gap1XSqS8R2cw2dROFwj
         S+7PGZgb1AQZuZIK5n1VEgXkZwxye0ZKzuiizz8l5RpPjPXMlQ6nBfwCfUCsROT9k52m
         muBZoJPVNmpTd7harxjpYao9MaW6uUxpr503WCz7KH8RGqKBI8UCRCZkgtMlOAN2FeSq
         4lhqMfC8Hq6v+8EdLq2iR1cdz4gRevsuUzR7gt41EnA/zaKL0uyUfmFo3mRyE72OQWeM
         etyrH0Lh+t2OGrOC4WgOQLGtXSMPGYyAoTqe4kQ58V4HxHCi1Z8qz6SuXqsbtQOfOh96
         laBg==
X-Forwarded-Encrypted: i=1; AJvYcCVKEkk7Mg3Gf+kME03duwNxaRvVHVWA5C7X2dQSGL6sadJ1qJJokRlvpghH//hYTzNrTL6GuR7Qcu67c8XvlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDPWaEfdjy0TxV05+nD8DeIHxohFAFe90mO/IPNS9i9bwrZj+6
	CT1XOF6gUgBd7Lkhczc7PEiEjb7cZS/hW4gVcLxbSRnboOML5BH9ZjMKsn1E0zM=
X-Gm-Gg: ASbGncuOe9R/jyEybzXc8BiFUK3WOIR2LIDWUbQs/44aWF9Ck7oAwOFNOt1EiTmgwR5
	EQ/b/B4Y3ATUDbYNURUaohVzE6aZKw6ZrccOzdZH0Qrtj8jGlA9A0gX5kwRi695fha4QWq+xO9B
	mLIHnHAYGhsHvQq9FsZqhxrgTTacTmtpPbqogr4fwl2AMpW2UOVyer/cRfilme5Io+6eoy2ZrxC
	SYCXqpS+xycV5RcVPDW8NxYMcBC64RMdbs+P5CtJBQoO5J28qwJAwjm1PeYIgBO/aWNj2r5jA6G
	cZx+vAZo6hj34jNj5B8=
X-Google-Smtp-Source: AGHT+IEBBQUc9yHPlJE7U8Le9EEy/Ys7qdfN3dt6zEwH5EOWHAFcdEMVQEDbDI0xb6cM5LEEwx21fg==
X-Received: by 2002:a17:902:f541:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-21d993172e2mr138168385ad.1.1737749973160;
        Fri, 24 Jan 2025 12:19:33 -0800 (PST)
Received: from LQ3V64L9R2 ([165.225.242.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141175sm20477535ad.117.2025.01.24.12.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 12:19:32 -0800 (PST)
Date: Fri, 24 Jan 2025 12:19:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5P10c-gbVmXZne2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
 <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
 <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>

On Fri, Jan 24, 2025 at 09:14:54AM +0800, Jason Wang wrote:
> On Thu, Jan 23, 2025 at 10:47 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Thu, Jan 23, 2025 at 10:40:43AM +0800, Jason Wang wrote:
> > > On Thu, Jan 23, 2025 at 1:41 AM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > > > > On Wed, Jan 22, 2025 at 3:11 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > > >
> > > > > > Slight refactor to prepare the code for NAPI to queue mapping. No
> > > > > > functional changes.
> > > > > >
> > > > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > > > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > > > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > > > > ---
> > > > > >  v2:
> > > > > >    - Previously patch 1 in the v1.
> > > > > >    - Added Reviewed-by and Tested-by tags to commit message. No
> > > > > >      functional changes.
> > > > > >
> > > > > >  drivers/net/virtio_net.c | 10 ++++++++--
> > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 7646ddd9bef7..cff18c66b54a 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
> > > > > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > > > > >  }
> > > > > >
> > > > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > > > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > > > > +                                  struct napi_struct *napi)
> > > > > >  {
> > > > > >         napi_enable(napi);
> > > > >
> > > > > Nit: it might be better to not have this helper to avoid a misuse of
> > > > > this function directly.
> > > >
> > > > Sorry, I'm probably missing something here.
> > > >
> > > > Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> > > > in virtnet_napi_do_enable.
> > > >
> > > > Are you suggesting that I remove virtnet_napi_do_enable and repeat
> > > > the block of code in there twice (in virtnet_napi_enable and
> > > > virtnet_napi_tx_enable)?
> > >
> > > I think I miss something here, it looks like virtnet_napi_tx_enable()
> > > calls virtnet_napi_do_enable() directly.
> > >
> > > I would like to know why we don't call netif_queue_set_napi() for TX NAPI here?
> >
> > Please see both the cover letter and the commit message of the next
> > commit which addresses this question.
> >
> > TX-only NAPIs do not have NAPI IDs so there is nothing to map.
> 
> Interesting, but I have more questions
> 
> 1) why need a driver to know the NAPI implementation like this?

I'm not sure I understand the question, but I'll try to give an
answer and please let me know if you have another question.

Mapping the NAPI IDs to queue IDs is useful for applications that
use epoll based busy polling (which relies on the NAPI ID, see also
SO_INCOMING_NAPI_ID and [1]), IRQ suspension [2], and generally
per-NAPI configuration [3].

Without this code added to the driver, the user application can get
the NAPI ID of an incoming connection, but has no way to know which
queue (or NIC) that NAPI ID is associated with or to set per-NAPI
configuration settings.

[1]: https://lore.kernel.org/all/20240213061652.6342-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/netdev/20241109050245.191288-5-jdamato@fastly.com/T/
[3]: https://lore.kernel.org/lkml/20241011184527.16393-1-jdamato@fastly.com/

> 2) does NAPI know (or why it needs to know) whether or not it's a TX
> or not? I only see the following code in napi_hash_add():

Note that I did not write the original implementation of NAPI IDs or
epoll-based busy poll, so I can only comment on what I know :)

I don't know why TX-only NAPIs do not have NAPI IDs. My guess is
that in the original implementation, the code was designed only for
RX busy polling, so TX-only NAPIs were not assigned NAPI IDs.

Perhaps in the future, TX-only NAPIs will be assigned NAPI IDs, but
currently they do not have NAPI IDs.

> static void napi_hash_add(struct napi_struct *napi)
> {
>         unsigned long flags;
> 
>         if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
>                 return;
> 
> ...
> 
>         __napi_hash_add_with_id(napi, napi_gen_id);
> 
>         spin_unlock_irqrestore(&napi_hash_lock, flags);
> }
> 
> It seems it only matters with NAPI_STATE_NO_BUSY_POLL.
> 
> And if NAPI knows everything, should it be better to just do the
> linking in napi_enable/disable() instead of letting each driver do it
> by itself?

It would be nice if this were possible, I agree. Perhaps in the
future some work could be done to make this possible.

I believe that this is not currently possible because the NAPI does
not know which queue ID it is associated with. That mapping of which
queue is associated with which NAPI is established in patch 3
(please see the commit message of patch 3 to see an example of the
output).

The driver knows both the queue ID and the NAPI for that queue, so
the mapping can be established only by the driver.

Let me know if that helps.

- Joe
