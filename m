Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286646AD
	for <virtualization@lists.linux.dev>; Tue,  6 Feb 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237733; cv=none; b=m6uhFdPy1Q38Y1BSWZuxP3grjQfKenIjRv6BhXHXbEjeG+CufkgMSsFgMf+n0CMyRqIVutjQJS8NluCMaKmMCwWu9DheQ9ZPdhfbPFDw2+aLkQE4BQBS33ttW6BY+Sk89FUVEZ//ATNN786cwrPB5t9JM8uaq+QUF9ya5x7ilJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237733; c=relaxed/simple;
	bh=z3qNh55Ci1qT92NuREESK3s6R8Zvn6g7iP9hM+eOcps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VI1xOX9cVjwCqPD16A2BXh8GofdvQMig+hVO2dbU6uh6Yx1vlXuyDIzoQe7/7E77L9GZf28Mgu6Gq9RkafgiJPhdLKiyRc5x5HUwhAsX033V0RztbwE+pu88GmFmUko12Z5p04db5zygsN2b71YNbmnbgaGsuzQ8DbG8UjR5Hn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2biQxHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2biQxHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707237730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8t+ziwiAXv1MK610pwiNfiMUsIpxu55IRk7DaOj/Q90=;
	b=X2biQxHBfzufR46n5o3DhOBtdOp476LBl9pGNmKyWAcrGuJ0crfl9Wn8amvyiXLglw6GYj
	6WqSgYslY/2G6bvrsYnwwNoIDT1w3XRHspfnpnH+2Xm3UDGtZc5+HFiHcD6swxBleSelmq
	fj1nJLfGrsbBX0EURcJRu9AyMqHxX1g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-8bs0YIJgNaWQbGlqzvQzgw-1; Tue, 06 Feb 2024 11:42:09 -0500
X-MC-Unique: 8bs0YIJgNaWQbGlqzvQzgw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-783f0e989e1so616630085a.2
        for <virtualization@lists.linux.dev>; Tue, 06 Feb 2024 08:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237728; x=1707842528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t+ziwiAXv1MK610pwiNfiMUsIpxu55IRk7DaOj/Q90=;
        b=It/+tsjFEJdX04l6k52jj9Q0L63MVFb9X069xhidHUx1OYlVJ/jSGneNvm3+JBbunH
         cRG+yDGXURNXycg0lENvtfmEH62b1OJdbz07JIEZfdr9QbZS0HIdu3zw4YSvd0bXSDu1
         gSEqAIA7GyGCS9esiYqp5B5yNhe9yauUYOVrBEc94es8lGfzJ1aBsswxPG65+0sZnNEp
         KQe6cKqsktlzFKc2ymTLjQpbfqn31DT8xy+7bwbCt67oGTOXt2921ZTHVoSRSDO39p5O
         F2qooB+IByTENcr9SB7LGwt74zdLTQ+meQjChQei7DqZw7M75yecGM9koNNn6j/SeRdv
         L8wg==
X-Gm-Message-State: AOJu0YzhXPCaUsb6d2wjkaQ/+Z607ybWJvIjWZCK7kdhmPTYUv146SNX
	afVSkDemGIUgmeRf8/1BFzqOsk0sP5L8QnYI5wQSB8F7ieooABD7uvNtNTihNRtWlTeqWEGb43E
	rWE3TbXwSekBn/XZsOw2+cRh+ZHLZuI6wuspMg/m2GVHANXq6CHEgulWB94xjHQVA
X-Received: by 2002:a05:6214:410e:b0:68c:9839:2d92 with SMTP id kc14-20020a056214410e00b0068c98392d92mr2713160qvb.45.1707237728568;
        Tue, 06 Feb 2024 08:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWzlRP34nEq93eRJ1m027Z04RkI4N87N2jEQGkLwDumhXBGqQEEa9a47NP8Nr899HDm2Ekeg==
X-Received: by 2002:a05:6214:410e:b0:68c:9839:2d92 with SMTP id kc14-20020a056214410e00b0068c98392d92mr2713145qvb.45.1707237728345;
        Tue, 06 Feb 2024 08:42:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwgLrNcLnuzwjdvfMmjzxU/e5br48ICw475bMqgHYTos1NPpTydq2InJ+RH332jfbQ5PIqxQQ8O/6raDo9U/242CKCn4SQK/uw0SW/zCqrSImkwCyxKB2P1qXaRy5Y5GMUgAbBqRiPTdpmrtfa55ZN7r+rox5t9XrsqVO9o4BatEjPVF8Xi7Ef5i1SBPI8+Y4AKqItpgDP7bK2r3bd14ZAARHglIAfW5w7jp5k6l5qzHd7AWf0TjZ26DDYvnpQsikUE0CNUbQdSYvCjXgu
Received: from sgarzare-redhat (host-87-12-25-87.business.telecomitalia.it. [87.12.25.87])
        by smtp.gmail.com with ESMTPSA id er4-20020a056214190400b0068c524a70fbsm1148431qvb.66.2024.02.06.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:42:07 -0800 (PST)
Date: Tue, 6 Feb 2024 17:42:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, 
	Shannon Nelson <shannon.nelson@amd.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] vhost-vdpa: fail enabling virtqueue in certain
 conditions
Message-ID: <rcdyxrwfvjncasnqiygeudfix2ma6hpkeyavbq3owjuj6lmp2i@ildcakftxmy2>
References: <20240206145154.118044-1-sgarzare@redhat.com>
 <20240206105558-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240206105558-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Feb 06, 2024 at 10:56:50AM -0500, Michael S. Tsirkin wrote:
>better @subj: try late vq enable only if negotiated

I rewrote it 3/4 times, and before sending it I was not happy with the 
result.

Thank you, much better! I'll change it in v2.

Stefano

