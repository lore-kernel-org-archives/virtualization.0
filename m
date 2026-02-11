Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987D3570BA
	for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802628; cv=none; b=qz/rrrBLq9QRzP0g/T8PgoBNoZQqzs3wHvWRITWeZStlnsw8vptyjrrJYU3gGyqPFYQWM2axh3sP80XvagbaD34exScJa58PrHkntHVxZdEgxjjTJIMFCAzWao3XhGZpjyM54wHN6dpkHO13OwkbM/YuI4LwtO7LPmfoEHBF2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802628; c=relaxed/simple;
	bh=bspBO2FdrrAqZFdWd9MvqX8zHS/3AYlNK2RPVUvzVDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=paCkfqE5l14/wWS48hqrnl0lcVdwkSdOX7+c+M715Qreyk1uSb5SxZl2I3D74pPG/MaYNqRN/718yboSkraYUlIzS+DTR7p2Lz+fgR4KNSIEc9SZY4BsoS9jEbdoDFhwOkvIcTl/LFDEw5WKicw2EwXUxURvEWrcKd0zgtuHUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbgneDXQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbgneDXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770802625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gBmAJXaSxyay4y/Pt9nQaFQQMgJqtE9oD0z31uD46SE=;
	b=bbgneDXQhpbSTk+dOBoTuk7b1Dr2k56bh6hbTkj7ghVTQPX/2dgtZqCF26cFz/riweDQ/v
	uWadEnbPzvExiJ4umnY2tXiLrZVxDsseNhBA+VzdMt2o0Umk9YEQvOREVeDLtKv/0SX931
	T5aDEUo2GcdQ4tUI+1+9OEOKsNGKwOA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-fiTVYjjONzmjqb21R82M8A-1; Wed, 11 Feb 2026 04:37:04 -0500
X-MC-Unique: fiTVYjjONzmjqb21R82M8A-1
X-Mimecast-MFC-AGG-ID: fiTVYjjONzmjqb21R82M8A_1770802623
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435991d4a3aso3934015f8f.1
        for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 01:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802623; x=1771407423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBmAJXaSxyay4y/Pt9nQaFQQMgJqtE9oD0z31uD46SE=;
        b=lvd0Ta3rS2uNL75DTQP0Xnv9PqBS8TNsgeP15FeKswNaZgMzaxAfuR7oVxCl3aHsz0
         s8UBYX47dJJMnYAqKPGaTjmjwn4wI8wzAa+4wZeeq24G00LkKECV3eJjt+5poYkHOkxa
         H+74T435aLR505hh5VNH8wzySqmzJqGts4yTlGH8az3bgDgRbdb+D9ojsNFyexvKKrGC
         fhXO9EcwDdptG1Su/6sy4zkpgiyOeaAg2KegaJ9lwbQwI7pLdjnTmn4IGehVj+x7Yo94
         ju2Se6uXwfAYrcmQ3AJ0nEwQD7P7N/20D6EFjCAURTwCUZKypXn7Bvnym5tW+r4bDbnw
         rz1A==
X-Forwarded-Encrypted: i=1; AJvYcCX7jmt4MfcynU52nM00WnVDhj9qSdniivtV9B3LSBgqKtw9EqAP0djn7mGIBVQgDpEGHmbBSkulqH77Xkxe+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwagiQhyUppumDyye5/qcFb+Ncy2Hhy5p3dtY4JjaTwwRVrUZah
	DNIQiQgeWAKLeae/Tt6LuMcutiydAglnQJOsCrKXno0g+tm1SosxEFrT9VbLNk5OfqzXpDOcjfs
	FwHZgbFqa1dVXm+WIjyYEO5mKuIZzeNKzJdA72xog+We3GNibj9/7I2Wvr3VQ+3wwcy7S
X-Gm-Gg: AZuq6aLZ/pXf21cyi0xrzhF5IpGF6Z136454kj19y/+sTtQ9GZmSnHDTJjN/UF1LSO8
	mA2KwXQ22zT5Qn/+CYXWLiPSXhbCcDkQmbTRXHyWFqS6X6R81RXadUs3iIe6byZ4tdDlvnZvGHI
	DN/G+f6+k59UD35KTOg7fBOFlBBeKbgAbzINGra1JLSp9LCuLeozc/dokWK8GxI2wQZJ2au4OSZ
	AiKSTW8fSXCVHmLLX8+t6H6hTN0rEEougETHUq6np2AOw0kK3vnKj495gg1p1FFZnmzucgo3y3z
	gaaSf8fnEHWF0fkp8kIdQ/GisEj5QxD1QPDqKCn1j2VaHqZEjOZg37fJXTbo4ogmlCfEIt/YcGK
	9IhxmAbAgs3QtFj7h/5cNh4NJZDtOy6MRNFmP95jDG1lr7w==
X-Received: by 2002:a05:600c:a43:b0:480:52fe:58f5 with SMTP id 5b1f17b1804b1-4835d54f897mr20485145e9.31.1770802623395;
        Wed, 11 Feb 2026 01:37:03 -0800 (PST)
X-Received: by 2002:a05:600c:a43:b0:480:52fe:58f5 with SMTP id 5b1f17b1804b1-4835d54f897mr20484195e9.31.1770802622456;
        Wed, 11 Feb 2026 01:37:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm102408485e9.14.2026.02.11.01.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 01:37:01 -0800 (PST)
Date: Wed, 11 Feb 2026 04:36:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260211043542-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
 <20260207045416-mutt-send-email-mst@kernel.org>
 <CH3PR18MB6379AC9DFA09E80668BC0BF8A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
 <20260211030643-mutt-send-email-mst@kernel.org>
 <CH3PR18MB637977B15CD77E0884DF56B1A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CH3PR18MB637977B15CD77E0884DF56B1A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _ssTJCXWjyVlBDYCsEU1bd_d5sPy9ayIfwnX94qH0YA_1770802623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2026 at 09:33:26AM +0000, Srujana Challa wrote:
> > On Wed, Feb 11, 2026 at 07:44:54AM +0000, Srujana Challa wrote:
> > > > On Fri, Feb 06, 2026 at 07:13:08PM -0800, Jakub Kicinski wrote:
> > > > > On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> > > > > > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN
> > > > > > to align with kernel's standard RSS key length. Add validation
> > > > > > for RSS key size against spec minimum (40 bytes) and driver
> > > > > > maximum. When validation fails, gracefully disable RSS features
> > > > > > and continue initialization rather than failing completely.
> > > > >
> > > > > Hm, FWIW clang says:
> > > > >
> > > > > drivers/net/virtio_net.c:6841:31: warning: result of comparison of
> > > > > constant
> > > > 256 with expression of type 'u8' (aka 'unsigned char') is always
> > > > false [- Wtautological-constant-out-of-range-compare]
> > > > >  6841 |                 } else if (vi->rss_key_size >
> > VIRTIO_NET_RSS_MAX_KEY_SIZE)
> > > > {
> > > > >       |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >
> > > > > Which is kinda annoying because the value was increased in net-next.
> > > > > If Machael wants this backported then we need to keep the check
> > > > > and follow up in net-next? We could try to cast the u32 away but
> > > > > that feels dirty..
> > > >
> > > >
> > > > I'd say yes. the warning is harmless.
> > > > so
> > > > patch 1 - this code
> > > > patch 2 - replace with BUILD_BUG_ON
> > > >
> > > > but i ask then whether this code was actually tested against net-next.
> > > Yes, tested against net-next (before NETDEV_RSS_KEY_LEN was changed to
> > 256).
> > > BUILD_BUG_ON would always fail as-is on net-next since rss_key_size is u8.
> > 
> > BUILD_BUG_ON(type_max(vi->rss_key_size) >=
> > VIRTIO_NET_RSS_MAX_KEY_SIZE)
> > 
> > why would it fail?
> I was assuming BUILD_BUG_ON was intended to catch the type mismatch 
> (when VIRTIO_NET_RSS_MAX_KEY_SIZE exceeds what u8 can hold). I understand 
> now - thanks for clarifying!

maybe we should just 

#define VIRTIO_NET_RSS_MAX_KEY_SIZE type_max(vi->rss_key_size) + 1


> > 
> > 
> > > Can we cast the comparison to u32 instead?
> > > Thanks!
> > >
> > > >
> > > > --
> > > > MST
> > >
> > 
> > forcing compiler to generate code where we do not need any really seems silly.
> > 
> > --
> > MST
> 

