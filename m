Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7F3A1D0F
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023956; cv=none; b=KleGpxMmcouR391OkInxHzVq7QXqPJWzxdgHiUFj9UNXNRiU+sxgMMlZbCchWkbwR+FrHKmd5y3TUioJ7IoEA/0iNEKlsverfkmaLIyn2GVzxx79S9cLlfv1AhJ/d8xZS7WdzeS3sit/iZxnM/J0SJZp05LSSzTF2pbqqxKyzyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023956; c=relaxed/simple;
	bh=sbLghi1wvhV55htoTSopKocdqh5GgtgNJsPIzD/S08U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m0dSDWYMrDE5kj9pBE/TrKt0tl2eGhXEl4hcDrfERlnlg9ROf4xEX9c/WjFwQ0uCeV49cM6oAfbDpe/dw4COUeKiFFj6Y4bX6GERXUZarjHMZ8GbDF98WupX/kn8VQn7vUP5b7eHwCRZpXGPn4MOCTjzvFaxY/RRaMwiAv7MHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/jnmIp9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/jnmIp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772023954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sbLghi1wvhV55htoTSopKocdqh5GgtgNJsPIzD/S08U=;
	b=H/jnmIp9KWXJF1hoRqr/6qY9Yi35DdkLCtUnOb9ML0NBRX2rh6i/cIHVxEpH+EhFN3jzUn
	XvnxufnaVkrvg/bIL3L02PdmeTYhSrwRincTHLDHzGx64nhNawCkT52DxBfVmo1LHmviql
	brQzqNMujfA4SiQNKjDRzgpu51+MCcc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-y8uOpYVMN6qp_Qaontiruw-1; Wed, 25 Feb 2026 07:52:32 -0500
X-MC-Unique: y8uOpYVMN6qp_Qaontiruw-1
X-Mimecast-MFC-AGG-ID: y8uOpYVMN6qp_Qaontiruw_1772023952
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43990373d35so457038f8f.2
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 04:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772023951; x=1772628751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbLghi1wvhV55htoTSopKocdqh5GgtgNJsPIzD/S08U=;
        b=k1acN1iluAqxGsYZyqGb5kfCLAtrvIS+QsorDjxv5QdCUFJOTIO3m1g3ak6Vl7ka8w
         M/3U/4HqvGBXrsRmZPD8ESk4GZRDPSQJxk6Upfi2Qh2xMjrGL/a6Z/KoNCUj1IGIPxuH
         vGLEFUp0aX/JMWnPE+ifK9kjkJ/wiFuRouPNjop3btaay+DIcr1c5YT/Ub/VOvJnm+3D
         4sDDgiaKe2qNAHnE4QOSe9O/b2xBIWknGGCZW2ra47bmtms5U9B2ecUCiK3YxbIj906q
         3FTH1W/T552v9872vQjcE10DiaAHz6RrF9eLxkmtGjWr+6pwq623VkkAnc/a0Y1MDeqH
         7G2g==
X-Forwarded-Encrypted: i=1; AJvYcCV6lCQVddrSlbBOvXjCQ96s8SqUzGIUCf6DoA8kzHhEXB5dpQYztObu9homcG/HaW/72C0y8QwPA/QQA8e3tA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyU3LkCHoNwLRQiTXN9G9YtaPmK5y6dT3kuMrbKVOWLqr20nEBT
	ONEo4OS5BMS1XXPKBl+OBTaFNc6+R4zAMMiTN+8gLsYmDPzWKWelAEmVwJv3EKsF9tD78Jkp/qI
	LDlrWGSMjsBpr4GcpItOlJO7mXH0iYlwPVFiOqcVrIJ/QgDZrWT7t+kD68nJRgWztKjqIwcgLIl
	Vs
X-Gm-Gg: ATEYQzw8Se3+dtv74BOpSaMqygg08SoFNpHx4/iEOj4UbHcYq2X1qoFh8FV3jEUIpfl
	BAKyXkGccgakjuewiZLr5lJJtmAFiM5fN5aAjCY0veSIT6jKCBJmPsUGog+s3dYBqApkbjcrWzA
	Om8O/2BQvdTj5K/VFQc7H4xMW0FKAH6fXT+/4XqbcSuRkTYe3KneJJCRPivaEwzLQQpjUzbfqnv
	n9YjKd3nuXlEBvfz17xdfzVUsXXVxnvw9LYyiQuZ82D1GnpUl9UDp/a0XzhOa41v7lkFdYRpyGq
	ye2kReGjSKTdOYsypDPsTiOZjtFUxMRTt6b5BlRwMFBjdR0vXK2/zB21A3zkdSVotNvgGBeGXYH
	dh5ATpHFrRHUA3hufU4cgYRakHgH2d4jTpFb0Cs9d/G99mw==
X-Received: by 2002:a05:6000:2489:b0:437:6d3f:a04c with SMTP id ffacd0b85a97d-439942f9b28mr660652f8f.39.1772023951402;
        Wed, 25 Feb 2026 04:52:31 -0800 (PST)
X-Received: by 2002:a05:6000:2489:b0:437:6d3f:a04c with SMTP id ffacd0b85a97d-439942f9b28mr660608f8f.39.1772023950927;
        Wed, 25 Feb 2026 04:52:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439899da8dbsm10508920f8f.18.2026.02.25.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:52:30 -0800 (PST)
Date: Wed, 25 Feb 2026 07:52:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260225075144-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l0v9r8ecTMuIt3FUQ61Wu_c0Wdpd8jsv0jZaJ9yEwMU_1772023952
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2026 at 12:47:02PM +0000, Srujana Challa wrote:
> > I don't know what to tell you. rss_max_key_size is just the max device
> > supports. driver should be free to use a smaller size.
> My understanding is that this patch prevents the probe from failing by disabling the feature instead.
> Given the current implementation, the driver becomes unusable when this condition is hit.

current implementation even more broken. but the real fix is to
intepret max key size as max.

