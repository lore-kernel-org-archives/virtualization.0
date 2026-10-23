Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774128;
	b=lSpziDhY81S3A9Z5Pi0Cx4uiz4MjWdzl/N9+6bNq38nQTDcBrhq9MP6y/avhqmf47yMB
	 PX7WhBcCbXIDZagmURXeEKf9GNtnnwRNgK5s0Q8C4Q0nlht+VV1rDDTui3fEepdrMwDfJ
	 qXRQd3vpI6H15vm5EPqEv3Xf1QPGDsRxCXe0wGiWKlWHh0V1i5AZycYf1XkpuNqkTSK7N
	 p1rjre4EMM5WVi9npW5joYot+2rZtuZMRhkOpIdFsKTdDPSZXm+xcpedNiEyVS/GUcfv8
	 8NFW+7JWIGleRUUIDTcKqDm/pN/MTZ6zhOpwUkhs+XiaB4AI/DZOZadi7jznRRQF2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774128;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
	b=vf0aB+TbmN0+Ktzld2pmgaA41y7UGfQXMQc/hYyW9lOKz522Nyx0dBj8h5t2WNDumjMg
	 ntjSsTWKQu/RWbfXPD6l9YEbcW0h4V6QyJMT4NmxmM7IeL/wk2xMDjJvb+2W4sTX138Kg
	 oviVJ1fjKNSqYcjrNvXnyAmAwwwGGAUGHJZxpHhniw8dwG7BbolL/AdP8GXtY6GOMwIfg
	 W/Gywj2Ib+QMqQN7HhY77OcAen5tj4SEPU3QewSSeLOX0fMuRoAExoOy9QDCEFbYA2EjK
	 LAw/scFSk1AmDZPBgqICnXh7eqPKPDTYiA5XXnAQ4hRHxUQUpRs0r5kpZKbWInkaNCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gU82Iq7X;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB31606A32A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 16:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB31606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gU82Iq7X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792774126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
	b=gU82Iq7Xsy1bpWiIWtNPit9g5SQIShMVBOyJwx+nwb+BjP3l+EB4PoCljAmCX4l/1T7dUD
	+6tTkweWJ8evAupHVvRN6kSm2boS84zitk73UcCxFYaXggpoiJzkpIUtJC6FUrJtrqd0rN
	IVMs4Kh2OrhM3PI9LV69RzWvXdes1A0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-aL59tnrEP4ak9CGFYIYbHA-1; Fri, 23 Oct 2026 12:48:45 -0400
X-MC-Unique: aL59tnrEP4ak9CGFYIYbHA-1
X-Mimecast-MFC-AGG-ID: aL59tnrEP4ak9CGFYIYbHA_1792774124
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c4445512dso978846f8f.2
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 09:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792774124; x=1793378924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
        b=F6v3hcaoyhBAPK9/jjSU7npcpqD7NoenFU5HKr5CLhrXIxxUjvce7Sypgh2LdQ65xj
         2gNjj3XAMjPNx/z1VUSXW3103gm1s0AAKl486mjqmDNdv6GK+qJgjRGk3fWmfn0eupZY
         m9VFyFqHokI1B0ezi66hdJrwd2IgjUMlwoWbz3vJy7LXWbVDSiT9QsHXiJ3BY19PfVdP
         BeZpOBtwkgdCocF8MKcriZaU0rmXa2y2qtwibu5VPsYwR25gRqqepHjKv7XAHC3o+mb2
         0MoMPHDYDvIzmRQfPaUTA2k2KVNFgY6rK9gwhsEnSlM4zSnJg8nq4CIF7cCNl7LKQhVr
         WsxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhQ1LDAyqAs0F/aNSRx/Q2oJyRqQKrsTNHYoYtOr4qe+XBbbS1f86XoyjkizRCAyA5A1ySfnWTroZ+SY+99A==@lists.linux.dev
X-Gm-Message-State: AFq9FYIBh7zmWCz8dc0W+uRGAfQT6CuOymcXZ9wbH8i/EIL4nXkyuOo9
	MbnkXtobhNrAN11Q8/qcFhA840BEsHe6nx5mLPwRV6S6nhp6fn7t2GxnOu5juoIEECMXmGs10b8
	04jHWDjkzWHOxMDcBGAKw+lONFNlDFjdobvAHXBbbMqhBtrYuPNbHt+dKizxVb+hEOGiN
X-Gm-Gg: AYBFou3D2bEgyPsOrm0sgx5N/R7H8pKFGPBa+Ra9VQpHY+6SiQ6Yc2xidtvXzKWBfiG
	IvAnuUqwaeCAE6ornLo5PasImNA8rTwLLvzJXrZAS44NkWiCUCm1SUmcMnu6qjl9nzttulEwbVO
	Q5XdwqQHdFQJlRKi+j5u6CnUXZi3Rzeans4RofknBBMyAcYUtvTiLVKfxn4++jIWV8rkKHMbtol
	Kpt+UaU/OtK5OeOKTogcP9GRgK2TTUyxRaxSf9n0XwsPay40tDToaYT4DxetuAd98B4WHxtkNLK
	lErEP2xVlKESZYei7Yw8J2Y0bpvh2BkY80VH0JQEboMSqNQXEi8ZiJVWZEXFXJi7UG2YIlM=
X-Received: by 2002:a05:6000:4026:b0:48d:eb6b:9d0f with SMTP id ffacd0b85a97d-48e385ac430mr4702396f8f.11.1792774124039;
        Fri, 23 Oct 2026 09:48:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4026:b0:48d:eb6b:9d0f with SMTP id ffacd0b85a97d-48e385ac430mr4702351f8f.11.1792774123549;
        Fri, 23 Oct 2026 09:48:43 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37c4b7sm1157431f8f.2.2026.10.23.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:48:42 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:48:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev
Subject: Re: [PATCH net v6 6/6] net: add ip4_parse()
Message-ID: <20261023124740-mutt-send-email-mst@kernel.org>
References: <cover.v6.git.mst@redhat.com>
 <970e2341834eadcf265fa7dd61a05ee305fdc1e4.1792687500.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <970e2341834eadcf265fa7dd61a05ee305fdc1e4.1792687500.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t5Turm1Ey23Wi8XHNKl4ds8oyjSs7OOUGhvz0SikCSw_1792774124
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This one was sent by mistake. Pls ignore.

