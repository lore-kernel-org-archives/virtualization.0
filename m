Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EE23185E
	for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763274743; cv=none; b=u9zs988xI/vAx0ouWO6ept58BWZCHVZictFx9xJLUStNe+ho1Z4eRVJixZaI3Gj8O6amPzbym3P6htILtNiJQhmnN7WtWrJgBpLhvGtzefLf+leIBQIpfKcImWCbTszy7P+WKe2XKtzVi5h3DRYOp6/Er2Es0pASp4SpxiSUAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763274743; c=relaxed/simple;
	bh=9J5ZanlTR5MbI7H/PM8zBqnWF1m30dsYYnGd+HHXpsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hNbdNjl0xovkUPYOVrEaaeVeyCadebXUQyvoDAaNVPGiUgZjxvTSDlth1iWgxy+fe/kUjObKgxqGRMQXkzugMKnB0/FL+lNQQbJ80L7MMa1/330cQtZVyGgbK+lr7hIyM6KCK/zCeq4kWNXTgjL7YV9X5Q08I9nWuBfD0vpAsK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgHvFnpK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgHvFnpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763274740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdbfWw8hd11o6VVpJ9FO1hpF1iyjC0aAQGdHwbR22w=;
	b=AgHvFnpKc9rsH1qRlT31M742zF90yt97OM4gqgZXJC+kpcELz+ITktCIO472MGPsTCB907
	ZFYNjDD5nkGFXBwdCT0HSVYXLF5bxumO2jXG/btyR63zDr4zkD8ERRm4o3Y61OihYoWjGN
	QlocHT4e2/p2Qz+k/Oe8Hpfp03VRFO4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-DNcGXDihPZupOBi-ESua7A-1; Sun, 16 Nov 2025 01:32:18 -0500
X-MC-Unique: DNcGXDihPZupOBi-ESua7A-1
X-Mimecast-MFC-AGG-ID: DNcGXDihPZupOBi-ESua7A_1763274737
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779c35a66bso5256725e9.2
        for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 22:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763274737; x=1763879537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONdbfWw8hd11o6VVpJ9FO1hpF1iyjC0aAQGdHwbR22w=;
        b=l57zpd5ODyz2WZ0+2ICqc+vllo2959IMA9vqUwt1Z2Q6QUb/mqussKCDhhjr4z7EEk
         v2t7pAsqCSHJgtRZ24Egp+gMqASCuPAx0npgCcPT/UzuFQ0cJi4N4nv4GlMiX5IzS7Ju
         SbG7MJI2dbjYZ4Ns4yDL2KH25VLhQSn1cqiTsueXmfrowb+9/ah1B75OWYf3A4SUbGNW
         oMbA3zkmezT6iypczgvM6D3PQlZw3u+UiO5IGt07mt1FjsCZ4/mF2etWnfeuyPrtDW0+
         YaQUtTggG5eUII8QSLNoARCgJF8O2YvUpCtSWg26Cz2/wd7mFZOMd+j8EjFNwn2u5qkE
         0/pA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Ws22Y1mKA3eUMJ2oBrxo4sxjw1QMfiSXjlP6H1yNavNTYtomE+HkRW+ofzRHN2L0qQ79Qdb4cjkxmriLLg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxx+NOvLPYuUU3PdKGc+UrDdjSWd7ghdsIabHrMaIq8R5uMBZjh
	LKiZXaiOWVgS7TDidgEdI2JUaMWQ+/zgnVt5jYnBlG6tAMUnphSYFETsQ6Gx8YbBxEmJkM+QWZC
	oaaWpQyuPq+gvow/Qtu6Q7vAjmn/kJYEZ4HDGZ2xjoSY5baWICEpvc0aqwXb4MXwZjeVq
X-Gm-Gg: ASbGncvSldxdDituj4ADL6sSjfCuFq7q+rPPOmDXC5VtE3l3M4C6prcbm4S5hkzQGzB
	YSunWA2c9Jag4ZSQEgBtn3ExU7yh577m+Ywuj8SNQMxLkcUHBrVksR0DJCWQIU9t0LtVU1lUtCI
	5bgjarT9U4kFO4JJUJCT40kY8NRWpfxAntduCJts9Xptvj9IOFf5GNsMmIgL4N6sJhtSqlB1ZIW
	9xW8XYZoIEa60A0pQ0+DCVZakGVtjMosPloXJAC8p/4uCnJK6sL4f8DES3FUbQXwA34Ai25kvvb
	bGBQsfOj88VoAaW3q36iK5o65PyG4NPBTInYQzCrD1HtOrkhgD0RbkjFPk3XISoLrZfBX6SC1jA
	tFFjiiWPAjltfDPvKh3o=
X-Received: by 2002:a05:600c:450f:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4778fe4a05emr84091605e9.16.1763274737042;
        Sat, 15 Nov 2025 22:32:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeRI/yezHZxOP1x7mKLvN6v76+5MYb3nziZ0TDSQOyL2+hNz6X/UXawre7ClVnkphXS6dc2Q==
X-Received: by 2002:a05:600c:450f:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4778fe4a05emr84091395e9.16.1763274736503;
        Sat, 15 Nov 2025 22:32:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e84a4fsm19190559f8f.11.2025.11.15.22.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 22:32:16 -0800 (PST)
Date: Sun, 16 Nov 2025 01:32:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and
 put_user()
Message-ID: <20251116013201-mutt-send-email-mst@kernel.org>
References: <20251113005529.2494066-1-jon@nutanix.com>
 <20251114185424.354133ae@pumpkin>
 <2CD22CA1-FAFA-493A-8F41-A5798C33D103@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2CD22CA1-FAFA-493A-8F41-A5798C33D103@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ODpAGlzo-4CGXy_PA5r_s_7wwID7y6FgHrqr6cdpUc8_1763274737
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Nov 14, 2025 at 07:30:32PM +0000, Jon Kohler wrote:
> 
> 
> > On Nov 14, 2025, at 1:54 PM, David Laight <david.laight.linux@gmail.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Wed, 12 Nov 2025 17:55:28 -0700
> > Jon Kohler <jon@nutanix.com> wrote:
> > 
> >> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> >> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> >> ("vhost: new device IOTLB API"). In a heavy UDP transmit workload on a
> >> vhost-net backed tap device, these functions showed up as ~11.6% of
> >> samples in a flamegraph of the underlying vhost worker thread.
> >> 
> >> Quoting Linus from [1]:
> >>    Anyway, every single __get_user() call I looked at looked like
> >>    historical garbage. [...] End result: I get the feeling that we
> >>    should just do a global search-and-replace of the __get_user/
> >>    __put_user users, replace them with plain get_user/put_user instead,
> >>    and then fix up any fallout (eg the coco code).
> >> 
> >> Switch to plain get_user/put_user in vhost, which results in a slight
> >> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
> >> 
> >> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> >> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> >> RX: taskset -c 2 iperf3 -s -p 5200 -D
> >> Before: 6.08 Gbits/sec
> >> After:  6.32 Gbits/sec
> >> 
> >> As to what drives the speedup, Sean's patch [2] explains:
> >> Use the normal, checked versions for get_user() and put_user() instead of
> >> the double-underscore versions that omit range checks, as the checked
> >> versions are actually measurably faster on modern CPUs (12%+ on Intel,
> >> 25%+ on AMD).
> > 
> > Is there an associated access_ok() that can also be removed?
> > 
> > David
> 
> Hey David - IIUC, the access_ok() for non-iotlb setups is done at
> initial setup time, not per event, see vhost_vring_set_addr and
> for the vhost net side see vhost_net_set_backend -> 
> vhost_vq_access_ok.
> 
> Will lean on MST/Jason to help sanity check my understanding.

Right.

> In the iotlb case, that’s handled differently (Jason can speak to
> that side), but I dont think there is something we’d remove there?

