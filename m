Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C8101C5
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302940; cv=none; b=HdqjJYnu1DsRaBuCG/UJsuIqYXxyYy8u7sj3s+OzRareH56E71KvI8is3slWSQy/XCYb6oceFZt7YMSxPqdSC3RUWIK9DkciIdP+VOIQrg4j8d5jHGaQQQlaTKof1nHVwcQBOmIzCLr+2ttlxd3a5PBKwOuHQiPQ+B/q8Sovw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302940; c=relaxed/simple;
	bh=1h6fzE7CDmV1O0t5HtGQutaiZcu3XDixPdfniPx64Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfLWR0RuJJIQLKtz2WT7bATABpsfErSIQhF/T33pk3Han6Biq0ZdgWYf+kbmI0b55EQl+WPJipou1nxnsgn1SHc3Ay55avzWfB2JX8ufxI5Y/BHSAr/jLALAwImgw1km42+GKBprkQ46QWC6ZPbiDHqMMYoTL9f/7tF1HmIfvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dy2EhO1z; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dy2EhO1z"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5AE580FD8
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:28:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lH9H7bWMCU0S for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jul 2024 01:28:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0D2D280FA8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D2D280FA8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dy2EhO1z
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D2D280FA8
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722302935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rmIJ5vFT5Yjjbs7pVvMcPXGKtaSi+0yKhvgi7LK01Y=;
	b=Dy2EhO1zBH7cBLHgw2k4i96xhx45Mn67PI4hwq5clANP2zepLD4tonomkQKqv0u6FSgXll
	NIw+QFId1YGqKAcvmjrEa67fOPWPHZWYl2P/M+mNBy6lv1iPQwrK10t4f4JwUgQ5Yz/Z4v
	DyaWELvetk3rE9CWClCRcRL++cTh7Mg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-ZxugUeriOQOPLxPffoDb1Q-1; Mon, 29 Jul 2024 21:28:49 -0400
X-MC-Unique: ZxugUeriOQOPLxPffoDb1Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef3133ca88so39077551fa.3
        for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 18:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302927; x=1722907727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rmIJ5vFT5Yjjbs7pVvMcPXGKtaSi+0yKhvgi7LK01Y=;
        b=rT3mtW9ZtUJOPJJoOlWA8sGrZW6juruUmNlNK42kTu6Xw2aySzElIBO2LYFf59gCsB
         PgMKNW46dW49EzZp1qqU+sq3npOzMuivWM3AilJCIHqbhuDcrn+xSFXqtav2LiCUL42s
         zkijAyJfuMS1fLk80IkOXSuEvB5nBO/fW/n55BTanEJefJ4EdgqHdBGWS3gbRbkP7f3r
         tAeXivCnencK2Yh4ZppUIeWxwZOZ60BJiWQKDhR1VZdhmJGICuIyasIm+24tG7h78ghn
         sTx9+mwMPeJmAtdH35wGHzemZ2GGzpg1UX6yGkyH+d/iGpdGzI2wJ6y7zCtj7ZlTk7J3
         nLRg==
X-Forwarded-Encrypted: i=1; AJvYcCVpugPCKfH7jlAiVRv8KOJ0kTKs7jE8uxr4PhzGZ9ZQ0x4NJfnBoePOZc4v9UlF0AoJ7atM3B7OXJ45qfWc4l2dM2IwS7B11O2fGhSBKufAUdRf7gkVERcyTA==
X-Gm-Message-State: AOJu0YyMkiV7uPVeBZqfH6PpPp3IvQNRoCgcKT7oOn8af1aVoxBCw2nC
	IOn+So1RZrGagqE/SDQ7v+6li/mI6alnivpGquOD2uma2n9HSr2/7V72aZi5l10N+Mhuh+Cf7VL
	tvfXQGc6odju9cHpysK877OkTT9mJcEN3b5u0u8j0akhjHicGD9EF37xzMrfHGlhlcXwlJ7rH+l
	8NVZPLykq49N5I7GSazl1vGReEMRX1DBD7Cq4vZBkLq+eSKSATaTdoEA==
X-Received: by 2002:a2e:8ed6:0:b0:2ef:208f:9ec0 with SMTP id 38308e7fff4ca-2f12ee05f83mr63094041fa.14.1722302927733;
        Mon, 29 Jul 2024 18:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtzdiCpJ9XgLdCKEY4EksF7k+lVK2MjMN+/4Tci3YtSJYsZZW4stODQlF5ADRUckTfa0JhEthcKDqHdk90vQk=
X-Received: by 2002:a2e:8ed6:0:b0:2ef:208f:9ec0 with SMTP id
 38308e7fff4ca-2f12ee05f83mr63093981fa.14.1722302927388; Mon, 29 Jul 2024
 18:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729052146.621924-1-lulu@redhat.com> <20240729052146.621924-3-lulu@redhat.com>
 <a5898ab7-a2ad-412a-85e6-9c7ad590704c@lunn.ch>
In-Reply-To: <a5898ab7-a2ad-412a-85e6-9c7ad590704c@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jul 2024 09:28:10 +0800
Message-ID: <CACLfguUkEtB2cTBrsC_GaxxMdVk_kXjO-gokDUNdECSuCrsLoQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vdpa_sim_net: Add the support of set mac address
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 03:15, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
> > +                             const struct vdpa_dev_set_config *config)
> > +{
> > +     struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
> > +     struct virtio_net_config *vio_config = vdpasim->config;
> > +
> > +     mutex_lock(&vdpasim->mutex);
> > +
> > +     if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             ether_addr_copy(vio_config->mac, config->net.mac);
> > +             mutex_unlock(&vdpasim->mutex);
> > +             return 0;
> > +     }
> > +
> > +     mutex_unlock(&vdpasim->mutex);
> > +     return -EINVAL;
>
> EOPNOTSUPP would be more appropriate.
>
>         Andrew
>
will change this
Thanks
cindy

