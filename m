Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA53F1ABB
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850741; cv=none; b=t4fPnKaZfGvcSun0xzQh75qsvXe/QL8o+CXn6Fx7Gz9FJ/uHS3Dj+uY0lpKDwRqZUJYXQj1p9TFm7UlMIs4nvgP7A34D97jRwW5V+42Cl2jAjcrLPYiSgB0oRbxbg2qRHF0Lfs2y01BPxa/GcaOlyMF1v7qNuVslupDLvosgFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850741; c=relaxed/simple;
	bh=bnWc1AJ7KQnTh10M6Zbo3fjs0IUWo/svdvKE+VBNbns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HIG33gjaw9XwUnBUbcwdlKHAV5LOG9jd8avoKIueR/SOII80hPrMRdA0f/x65VPXKM+8kd5AMDotmhMjFZPMrlqgQ3WoXfJzNnkwgNV0Te7bDTHdlwonLWd5J9siK9/ez2E4dt5ekEQDlIWgqVk1xjt29SeSFpocHEApzviiBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2AsMWUX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2AsMWUX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784850739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkkpGDa9n3hK7V9pFmqhXKgHVG3K+tE/JydDi9lJVEc=;
	b=h2AsMWUXJxEZDkPnEUyZHLvMC70ZulkLSMMc57MAmz/BQ3CPybg1csJ9mp6WC7yyagt01m
	9S6PF0KVs2FB9n67XvvqsboWV5ktU1oR552qiDYgim13iFuu7bG+v3fwSjgUKHTHUU/OoR
	h+W0pt6DDDexKglRPUm7qJWHih0watg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-SSNpnCIRMcySq-AClWQeEA-1; Thu, 23 Jul 2026 19:52:17 -0400
X-MC-Unique: SSNpnCIRMcySq-AClWQeEA-1
X-Mimecast-MFC-AGG-ID: SSNpnCIRMcySq-AClWQeEA_1784850736
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so5796425e9.1
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 16:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784850736; x=1785455536;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DkkpGDa9n3hK7V9pFmqhXKgHVG3K+tE/JydDi9lJVEc=;
        b=EkfpiuvGdfrouQjAHOCGOXcAyeDCzDhU8Q1507o5kB6d6JiEVlSrTIdL2aEUJ1cl4n
         j9y8Jj5wi0Avjc7Gjmty4BKs2c8cP0yBVZvzXJ9Eba8k3v61nMQGpkF2fAkE2cfZZDnx
         aV1vxlsIIGBtkCdiJR7miw4HUEdzKyNCe80hC0bkRpz/IvvIf7Fkz6vszLarSeFGvqLW
         EL/qgCfpLgHeohJwVRU2ibLShJNEk0sEq1A/Bbe6WEt3mmGh2e9U5dT8l9fR8MhJ3PWE
         kL4MW0tc2ehlnIEjlYNU8nZNJj+jEVHi91hT9kw12nYInw2ogjX43MiMgE1WQ1Ra6H5v
         u2zg==
X-Forwarded-Encrypted: i=1; AHgh+RqTTnBvGb/D6KPvv/WSjQIi3bn4IrKEsrjh19zMlc3UAeeW+rTWFePdBohBGqwGTj4pEydupt4/FDJ3XbKPKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3uatrM/48knJTR5+54nvYlJNcon1CZ48jnlqIQRk5ZwK2Z+bM
	w04cK7gy1iVH4lVaI4d7AR0/W+JvzicSfKhuSIT00RPfIg1YfH3+I+g5gcjSKJFQ0V/ruNUbotS
	BXiNP/0NC9dHVpfTSGdIxgH4CRc1JBITF1EjgmD4WSYzyGuXmWtnsxa/f8xohhBzlQ0Qy
X-Gm-Gg: AR+sD10yVni5F6DKnWtdKnQclqVEHJ6egQ41TqCYQ41+5I4P+qNg+zek+aJscl9NOjv
	1/OWisnIkr9EjftLMmigcQ1bIxupcX4hqAFpKGdTiUEcMYgX2lc2qUSY1Cg0nXtlZHM4VmjH9wp
	32vXX3iljKwYEQuKmWxwv0y81zBbD6+WRAjwtsr+83pxYkevGuxVu9CUt3mYXjfSiPyMLC/y5KP
	XeGXWDr5OVjwieIhp7Cn1c63pZt7ti7+U8XOvVKc3AzpD0il/iPmLQiVF2epA4ZrsVy7TreRafU
	BG2/1OntisaiR+bAH+1IcNj3kGi6wjyKedgxdFYemjza5zJ7vJu0p1245YhwaaM/ciyuIBGZBow
	NRsjPCKN78e0QQInhWFmVRw==
X-Received: by 2002:a05:600c:4684:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-495745ac56cmr54152405e9.16.1784850736265;
        Thu, 23 Jul 2026 16:52:16 -0700 (PDT)
X-Received: by 2002:a05:600c:4684:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-495745ac56cmr54152155e9.16.1784850735844;
        Thu, 23 Jul 2026 16:52:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b816ef8sm15548295e9.1.2026.07.23.16.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:52:14 -0700 (PDT)
Date: Thu, 23 Jul 2026 19:52:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, huster@cs.uni-goettingen.de,
	mhollick@seemoo.de, jiska.classen@hpi.de
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260723194822-mutt-send-email-mst@kernel.org>
References: <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
 <2026071803-passage-dares-8240@gregkh>
 <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
 <9569e577-aa82-4642-b9d9-fd496fc12849@kernel.org>
 <2026072036-outburst-rebel-c71b@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026072036-outburst-rebel-c71b@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rjy8rxL3v0WGGXpW3d20d9t-HU4f5hadUqIUUFx6q4U_1784850736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2026 at 10:28:03AM +0200, Greg Kroah-Hartman wrote:
> Seriously, I'm trying to figure out what you all care about here and
> what exactly the threat model you want this driver to work in, and I'm
> getting conflicting answers.

And yet it's documented in the kernel tree.


The threat model for confidential includes everything that can lead
to information disclosure but excludes DoS attacks.

It's probably confusing because it's different from USB, where you
really do not want a usb device to crash kernel.
-- 
MST

