Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB23C3126AF
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544022; cv=none; b=Fhivseiv0JtbKDWXHbKuoBGnWTDyyFdcGwFQTE6duWk+c8QqP1xnsCcIqoAkSdpv6ibSjLtM19czkD0VYWW+oVzccfxoHBnGllT4EWwD1F9wFrtNDneHf9dI83MX4liH6qeG/zcb/Z1dUruqh2CGdr+wZVhhG9HdKsiDQPlsTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544022; c=relaxed/simple;
	bh=efBNnvAjenT3ydeuHvhZ3DPeJKGBTHhPQVyKb3mVB3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CCfIyGKYW+nskamx0rnA2+GKX6LP4JW9dfXz6sDVmMHQakAZJazBeNBuWb24nQm9EnvdqFo4+DQm639AkXys+jcw5Uca07FSyt4XgQHKx0Fz3D9N7gzeUgR/6+4ecf9gNCoKXaK4T5m3ulx4VfaT1wE/MhR1MR7pVsMXZZx4ENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/ClbgOi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/ClbgOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763544019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4vo3A+zEqT6r4yHEPPmlJtSIbXl0hcYVxsto02QGrA=;
	b=M/ClbgOiQo43Y9ABGNXXGAdSqubMFMkFqxwNw9QD3uBRs52ivV7P7MlSTIsSpsgrg8dZkU
	gNt+RsyCQU2fCsQMDD2QL5INl5y8ipEwwStFP9o7/0Imzuy5ytuIzq5w2UgBkAao/tIOEa
	ncSodRx9hPZ69mYyInB7etY95d37eaI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-w1uB2mTxME-_0imdCBVrHQ-1; Wed, 19 Nov 2025 04:20:18 -0500
X-MC-Unique: w1uB2mTxME-_0imdCBVrHQ-1
X-Mimecast-MFC-AGG-ID: w1uB2mTxME-_0imdCBVrHQ_1763544017
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477a0ddd1d4so25989555e9.0
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 01:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544017; x=1764148817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4vo3A+zEqT6r4yHEPPmlJtSIbXl0hcYVxsto02QGrA=;
        b=aDfA2dc/fOv5bBlLPi+/AmS+osTdFi2Nqao5isfP5Ol1MNc88CDlDWv7y+xwQAnIKi
         dp8NV3G0m7CvJn2X1DCFEhl2bYr332U21llE/AOVp/HcZZ04F8g9Q1fPCkQpmc4DSImf
         Vl01HAwY0ZhNh9kBODPhJvNEpomDz2ZZJk4UbJFCUe+QBChXNp3ZKFow20ZxM5kmORDs
         RFXwVKczSJQNq/Nl2b+1oAfJNAxJcOvZjteiWtvsGvMEGGvkXwkJptoT0kDR//PLWJhu
         IMzV5p5J4EBsGqFAFAPqMcdMF9N18I0jEyI5HFGMzjaH5HjlR503pmcj6DtwNQ3gn9Si
         W8ug==
X-Forwarded-Encrypted: i=1; AJvYcCWPfInHMOPE6w1eXHkO+q/P1bvhwgrePBHoN7Cn6zBXi9XRlM3shAmJyincAYnEal02pq8fhAUvLYHhEZ41lQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ+25uh/JPhETK16BWafVftykVl3J4BFi/ouyWCZe4sdMYu4Wy
	Pwnm//wznq00XBIBJESpDEWha7+5j6AHu0q/neUD1i1NvxL3yy4/82qmkUd0uyRz1XYmZjdAaXw
	P/6iPoHgV+46BRsbujgGeZhLhbXcL/5SWnHw5q05ZthZDIxD1AncHkhsgCZj6WNXyIUHg
X-Gm-Gg: ASbGncs5AlKas6391qb9607A8LEXu0z04DFgCg5rDo8Wh3UfEBRsk8mLVCIWOP534ON
	KBGCYX71FL7oc2naYnEkemaOlIceRIjVaxJXmE6TDqUUtOb191nYJrnYVDZk6h7NYzhM3l7FsHJ
	zi66NDMwtC1keyguG+eU4TaDrzOZfzwe0tXRKc5DYEwzLDsmY8XPtgoiuXOFwOhvB5NGd3JHpIC
	j0nT9nXZTxsHRO0Br1qFj6czx3qBldcNKyQBDiV/2mO9CjFqkVBqNH6sGzHbl83ksd5QtCv8NQ3
	Fi+wn1UXdUM3pEVoyiob0wefrKRy8xAEUwrTe/yvgbjWIC/ll/rm7o6rHwyyS9tU7OupIOUImi4
	BeRUhcA88OjPBzilyhxLkSbFt2gEsoA==
X-Received: by 2002:a05:600c:a05:b0:475:dc5c:3a89 with SMTP id 5b1f17b1804b1-4778fea881fmr187270375e9.34.1763544016810;
        Wed, 19 Nov 2025 01:20:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYNHoQb9TvPImOLwUq6zgeQEbx+Js8WQF4KWo8jQc7HHGmjv+JhCzbPRI24y5phGaKhkTJ7A==
X-Received: by 2002:a05:600c:a05:b0:475:dc5c:3a89 with SMTP id 5b1f17b1804b1-4778fea881fmr187269845e9.34.1763544016210;
        Wed, 19 Nov 2025 01:20:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9731a75sm38335635e9.2.2025.11.19.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:20:15 -0800 (PST)
Date: Wed, 19 Nov 2025 04:20:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251119041932-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-8-danielj@nvidia.com>
 <20251118135634-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118135634-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W68EuBP35trRKgNeMCpw0S0pvasV8UBzKRcLHRY0AFc_1763544017
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 02:01:27PM -0500, Michael S. Tsirkin wrote:
> > +struct virtnet_ethtool_ff {
> > +	struct xarray rules;
> > +	int    num_rules;
> > +};

btw if you are using xarray you should include linux/xarray.h

