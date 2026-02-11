Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900F26F288
	for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797350; cv=none; b=gnuEUM7WgWzzrI3ZsZEcNpiMlaCJBG6M9+IjEIL7MYdnQBqFWBP7ylLJtTqHf4cj1prcGDbCnD/SK+TSQQN635cDloQsRs3JpIl9GJQwlPi/cuTizJWTX8LNbXxeq8XnYT7Spu2a5XVPLlcCCba68/UHxqodZh2cseePlBO1/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797350; c=relaxed/simple;
	bh=6eXXMh8LWgw5UCCLiS87LTS3qgU3t6TL/DHgHSYap+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jhkP2eUhbSUOuN+IFwHJx7iyl4xFTQo3uBWJNtLVAmU1clOWi+FDuNG+dzXfVoWJBg65xcHPXOsc96NWHTjFdFrGNlqklg20aKUTGPkDkT9fhsrU7dsmYjLQqWBl29nmjH38yhDd3pYs6yLfIhqySZ2huBgL9RYg6m+CepWz1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeTfH09D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeTfH09D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770797348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOfnDOTaGJCTNIhSFIFWenVIFLC4qtu2j56vdEhdYvs=;
	b=BeTfH09D4RyIGtTR8c2jvof56u+IjHvnYpjMnyNf1hjntOpwAHW2BReUrYhQRd2PMFOllt
	4Qt4kSabl5Jc53jfS0aQa1cN2jwsaNZW18yUrJwdZxEeI6MQIwVDhw8qFN63mOljarj2nS
	XkUUAXIZhsvN5oNSTCqJJiFQgVeBHhk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-Ppd-ZUYcM46Hn7FrA0cU5A-1; Wed, 11 Feb 2026 03:09:05 -0500
X-MC-Unique: Ppd-ZUYcM46Hn7FrA0cU5A-1
X-Mimecast-MFC-AGG-ID: Ppd-ZUYcM46Hn7FrA0cU5A_1770797344
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso24901295e9.2
        for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 00:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770797344; x=1771402144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOfnDOTaGJCTNIhSFIFWenVIFLC4qtu2j56vdEhdYvs=;
        b=wTeM+qNWjEzzZiD1Zr2xGSm3oufm2QNVgWBhJahv9U/9WlAbwt83kT0Pw9roQisqyP
         Wzv0aCTmjTzU2jNiKw8kSWCjZcLhPLAg9yfyjKsEvAElZkK0ImsPp8i6ixsiK0QnEq+C
         qlLFGvqW3Jq9KaDM0tsSWu9XtLqTFOepN4fGhj5tLejSmsU98jMNDY+bx2Wi2l1/HZVn
         5zI3PyixcB/asXqdRFlgZizSBVDLU7+9bx1xTaEQ7sCxi0stHV+tqM4d1RObxqZEWDGY
         wws+00zrxfHR8h1j8if2FUAmF6CvW04U3S/kSZFZXINM/EewiDDr7uD/XGKqL2+VMymO
         QjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMKMuV2qOleuQqkwY1/ARBswi+oH0csbznUvhQ3Vs2qSyVFEssRa3XieF8UObs7D84HMAFjBMTy4aIO5MwCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw996TKm2UW9+3B2qqsrCS9PHDOvxkX9iMhBRcxvO4nihvjnRrx
	0SYhuuMVLcF7t+g+02NU+ajhIwIfvGUl4Wkbv7oPGSfW/5cht4vHV5TZv1L8fvBlcaIbS/y80kl
	DzssqzTHkLdHuZ01r60tu6AnLIlqmR8Xhwe2wHG/TshBNWVgGMrC7hHxwYGBEliGVTfgV
X-Gm-Gg: AZuq6aLsejiLb/bdCcEDQYCIANYQkUaFxOKATSFnM933RfwjlMBy1sfLKwztxE6ELGy
	TvdhjVrPSVc03kXl3u2aiEJuiH7eUPml8EuisqoZ8M2689i9TcUapH7Z2sv3PZvgj3gj79HJyo+
	N9hTYUVRq85bkuYvtFeSt/DZb5/NDIq+t7IQN7oO8VYxujzTKVbc/YHlbnq/dgEot6xnz00Hbvw
	RdTNmXwtVula+0Oc+ydu8tYhZvTLM1+zB/4rRAbt/+tjsAuQy/A17L8yg65cMJNC4LqKnR4VD+f
	h5Ic7zWu9Atp9W4ZWyrC8hsUpy+25oTHDD9lSsy6eZk7eAKQY7+iwDz+dcMUVUZ0+u40mhJFOmK
	IvXKt0j+EuVIR6PQcEYIMIdi9Z3L/kH22emF8Si0HvXRh2A==
X-Received: by 2002:a05:600c:4f8a:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-483201dd051mr255133305e9.4.1770797344029;
        Wed, 11 Feb 2026 00:09:04 -0800 (PST)
X-Received: by 2002:a05:600c:4f8a:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-483201dd051mr255132955e9.4.1770797343544;
        Wed, 11 Feb 2026 00:09:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d92267bsm36448905e9.0.2026.02.11.00.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:09:02 -0800 (PST)
Date: Wed, 11 Feb 2026 03:09:00 -0500
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
Message-ID: <20260211030643-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
 <20260207045416-mutt-send-email-mst@kernel.org>
 <CH3PR18MB6379AC9DFA09E80668BC0BF8A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CH3PR18MB6379AC9DFA09E80668BC0BF8A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _aPpA6eUCUinfg6WZpxIncq8W52SAcOtxzYCEtTg0dY_1770797344
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2026 at 07:44:54AM +0000, Srujana Challa wrote:
> > On Fri, Feb 06, 2026 at 07:13:08PM -0800, Jakub Kicinski wrote:
> > > On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> > > > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> > > > align with kernel's standard RSS key length. Add validation for RSS
> > > > key size against spec minimum (40 bytes) and driver maximum. When
> > > > validation fails, gracefully disable RSS features and continue
> > > > initialization rather than failing completely.
> > >
> > > Hm, FWIW clang says:
> > >
> > > drivers/net/virtio_net.c:6841:31: warning: result of comparison of constant
> > 256 with expression of type 'u8' (aka 'unsigned char') is always false [-
> > Wtautological-constant-out-of-range-compare]
> > >  6841 |                 } else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE)
> > {
> > >       |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Which is kinda annoying because the value was increased in net-next.
> > > If Machael wants this backported then we need to keep the check and
> > > follow up in net-next? We could try to cast the u32 away but that
> > > feels dirty..
> > 
> > 
> > I'd say yes. the warning is harmless.
> > so
> > patch 1 - this code
> > patch 2 - replace with BUILD_BUG_ON
> > 
> > but i ask then whether this code was actually tested against net-next.
> Yes, tested against net-next (before NETDEV_RSS_KEY_LEN was changed to 256).
> BUILD_BUG_ON would always fail as-is on net-next since rss_key_size is u8.

BUILD_BUG_ON(type_max(vi->rss_key_size) >= VIRTIO_NET_RSS_MAX_KEY_SIZE)

why would it fail?


> Can we cast the comparison to u32 instead?
> Thanks!
> 
> > 
> > --
> > MST
> 

forcing compiler to generate code where we do not need any
really seems silly.

-- 
MST

