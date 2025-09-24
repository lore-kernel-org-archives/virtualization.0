Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53276257820
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698327; cv=none; b=WihzEHJRJHZRJy7BVDLKeGpF9Bz7xoyuj8+yxA/BMuJIM/eYCEC7dI4WwV8Xlq9hyrM+pAH2EG5MyrVsmtjdX38QqvuSJ239RZlJvv0qSTCYyOipJItrG1RLEJQo1p0oFGj1Zg7Bu7dgDNI8P8XwxVS/l/qIADZ0dTui5sGnHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698327; c=relaxed/simple;
	bh=vFGV/5SdrXTqAjDg1Z+qtUf7lXuT4QgHCPVLjdBhXkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S51LFbJa7/BvCakVuyUZoGY5rTN38gI10YsYMD17nKy81uGjM+pxl0a65vYnUXKBBXMW0RDVMFtBchXpIAjMYJBVnRGRFxL4odtwM+BO52mBFfGxf6ptcrr/FTJvpEqeXHJk6WHfe2jub2lBOQGxpoi8zSTykBRwG0lnaS7K0Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpvRQHn7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpvRQHn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758698325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4iJVB6lD2fruztfkG80c2BDXVSi3uw6WFakzazt5Zo=;
	b=BpvRQHn7cNZq5pWuP49RkKnIJZSwSvxbcsKmuYQldlXbAvde6XqEptmVyzmZH/r09K5D6H
	+7sgFaxferELr0RINM2gvyMLzHBOnWvWwHhcEwdmK8ResiqFRH9VTfBpPHIKlCUJ1AdI+E
	UZBC0o+0lzXyX8gB/7//m/MCdrOGCes=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-xtXIc4FIPm2-BBmUuQmttg-1; Wed, 24 Sep 2025 03:18:43 -0400
X-MC-Unique: xtXIc4FIPm2-BBmUuQmttg-1
X-Mimecast-MFC-AGG-ID: xtXIc4FIPm2-BBmUuQmttg_1758698323
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e19ee1094so23831565e9.0
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 00:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698322; x=1759303122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4iJVB6lD2fruztfkG80c2BDXVSi3uw6WFakzazt5Zo=;
        b=ZMt1MHTS4eHqaw7UUuYk7iJYulx17JeshL0Z0qqwZ9sfE808Hlw6rsjGYjJfDxhRh+
         b3WOd5IyBoGtRDHBKx11GThoXpWGE4+wtm6gnHs7GOaWmTiJByClLRV4g3z3VU9qzJDL
         +sYbQMKFvesYp1L3vGd8ikVB3xdojQZ5YXa5w4BYi2yKUcBB4KeLOKf4inebd6rL+BLD
         Q57+f2a53J+0Eyy7z83P2k0UFXWQIrwLS5M7CJiMpu4reT62KPBwsRRwISa52ArcKKhO
         UF1FFuO1FDg64l8axythFoJbV6CBNgERxpkpqjrMJBwoTviVXu5tcsS5nrJ1JJpuR1/4
         owlw==
X-Forwarded-Encrypted: i=1; AJvYcCWETT3JglWbJI9g0+8XsXIzcZbjvzfwLAYroYI2JZnxYmwIv4FTrhuJcL4naenxP1Py+0pjodSEHOGytgV+Zg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyue2C9KMaUCi6wA/z+y+I/frJCmo+T4W4GP6g0Ge7Nch5IcTFh
	P6vv0HZJE/pLZeAyz/BjINuhjZh1Wo4NiwGnVhVnwTTaLcLUIGq+9CJcY80+ZLar7Qwg1mr5/Pr
	/EXuSZ+eAnUxMdrVY6F2ZUOkqmv2R6uVegqjYura1O9n48uafUwcM5kxP4P5a0pqx89+9
X-Gm-Gg: ASbGncvlVbQI1lQ4P9bRMMUaL6XAYjFx4Ugk8ycEaK60VBxD7ePtX1LnmDvXL9k1Eco
	s89HAv2Kt92w8XqukTO5JBUjZB2rngK3jiC5O7oGAn4vvwo8H8sYrwz/8r+Bwdcy91kHMBUEi7m
	8w3iXCxR3juoAxYeaJUWFDn8azXLov15qhEWOnm8/NWwi1EENE0GbnqqtT8D7Ac7Rj6eBVQBE7J
	pNDWxCgPzci3w3FIs3C5PjHJKUFzbwpTYvszneBp6Q4yyzvZb9KYuCMDqZ8KmB6ngUUjfQ10B3r
	jzZfQOXEqknJoFwQS6f191+sVp2ATVU3hTo=
X-Received: by 2002:a05:600c:4f16:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46e1d9789cdmr54641415e9.3.1758698322521;
        Wed, 24 Sep 2025 00:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbSI2vy3Xtfu4Q9BvlHbV7J5LuaePh9VoqJOvv5JsIaLhsTV8uduTMFmV9uZ4PhlaEw7WBrw==
X-Received: by 2002:a05:600c:4f16:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46e1d9789cdmr54641135e9.3.1758698321969;
        Wed, 24 Sep 2025 00:18:41 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9b1dd4sm18905645e9.8.2025.09.24.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:18:41 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:18:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924031105-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QAMs5UBPFZCSfKv8ssLv7y7Snwv-o7toOtLLpxWTV5E_1758698323
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> This patch series deals with TUN, TAP and vhost_net which drop incoming 
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> patch series, the associated netdev queue is stopped before this happens. 
> This allows the connected qdisc to function correctly as reported by [1] 
> and improves application-layer performance, see our paper [2]. Meanwhile 
> the theoretical performance differs only slightly:


About this whole approach.
What if userspace is not consuming packets?
Won't the watchdog warnings appear?
Is it safe to allow userspace to block a tx queue
indefinitely?

-- 
MST

