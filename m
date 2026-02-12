Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62C2BE62B
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879996; cv=none; b=QbZc73AjPFHJeiLHDs05PqB/lPZhgfE26mzOnAa+w9F2ZMV+cMbyR8kbxMbp17ncTm00dvsFyj/GdPMgG0MBtuGaM6ynXJ1UWBVbx0C6iT8FcmnH9u5zlPomKVO39G0ijxCXLBjGQR7AGxIEzAM2qmi0WByyT4pLe+KRvUQNy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879996; c=relaxed/simple;
	bh=g9HYPhHqcbaoctrpbQtbxiphE+OHyOHOP6Q7Eyep2RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ot8R9iRFxZ+7plnN0+hp6AyblN4brjnNwdKHn7mJId8Q1ROOgsvp3JQ9lEKBY8YQvxa5KdPQpIYMA3Mt33kozgFymrF4wTWKNS8gW+6cn4E5aR40nigM1NPM1BoP5/6mCm5t12FNxtvCS4s0KTAdLNiONY9JsEUfgBo5CZo6Ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/Lgt3mE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/Lgt3mE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770879994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSQGsAVLVUl/sL3M3UFHxDkkSBw9IH75zh0vjPlYmyg=;
	b=R/Lgt3mEBpVwxqDsr89KfZAZec0ers7sYejTuoIqOMddB7wwzyoECKoExGHkmvnCjkJZw8
	z/TKUyyrRjIcgEAeMVPH/C3HMoi+O35/4s7G/0iWfsVORNIlD+usmkA6KImrJuzxphWa2o
	uLOFDU+hkagl+/2q4dk1PHCzFk+JXew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-BDw_ifxIOQO2ZLe8rUJ9Uw-1; Thu, 12 Feb 2026 02:06:30 -0500
X-MC-Unique: BDw_ifxIOQO2ZLe8rUJ9Uw-1
X-Mimecast-MFC-AGG-ID: BDw_ifxIOQO2ZLe8rUJ9Uw_1770879990
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee33324e8so25202405e9.1
        for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 23:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770879989; x=1771484789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSQGsAVLVUl/sL3M3UFHxDkkSBw9IH75zh0vjPlYmyg=;
        b=j5rwiWvpoGbzN7tdFLOnT2onhG7NcYncEv76VXbtj3aGZonj2LEwgY0hkbyOZfk9D1
         v6jzy9x6zQjSOZDYmTe+TJQ3prhsIVSXNWehLK86hn83uYURy5mEmb92EunvCd7MKntg
         yHO3/sYpZegN2+MFUGcGKv6m6FWNakNDAq2ZZcOZ8PG7fnmGB9NL4OiTMeOqcOeQPXXU
         pU5e0OEh5+m7tRakVCjbhIYncq52hEDIn6mvVbDuB9mx+2zzbc5UOjtQxCZcoWGIjFXt
         LY46HFBL/xHb6n8267N4Uwa1h2FJz/6JL6ke9UuNfmQocwpiwgY2mxkyu4MvXvKUcALf
         wszA==
X-Forwarded-Encrypted: i=1; AJvYcCVRM4ozOSCRSzK5Ng/nmU9SR1j3JgOyW7dFgsE2kydORWdxJa0SwdL1Cak5MaSoIqPOCnYWz6wiU1E1m4KwSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/j9wjkUbGKSVmqBBOBLdOwOI+fluEZ7P2c/v/fID315Kv2edU
	b5YpWHpA0mNF5Q+lrvAKG1vEuiYxsH8BHuyQGXjQUpTJUXyV+hKVwn1ZpUctGArRj8N8KLZOLMg
	EVulKfCM/9Pf9mOZQSX5bxQhT63BpWS1lQUfcnzjokQ3jwmGolgB6ZPPtU8AuzcZcKQkU
X-Gm-Gg: AZuq6aKH+sNb1wxhwZtb/hd56z/cbFwOtWI7XSseRkqEzq3b3bJHOZXJWYt9DIsd0xN
	5ZpqzZOXLMNHFMPFxhjvj+KRgx0vexyiITD8PYI+0Ruub0zDKSQfmD0iVqjfyz5x+k4o4LE+jVc
	QsCVy1cMlyGyM+ddJ+zlnFDrPbsmp/Ixd9iyXidRgCe5RXYhxOBHETbcADzB7kH0MRgm0rvERr4
	k8Q2FX0qXln77SOJoPJ8uvq+dbVnilGMQqcUESRVI+iNx+VqGwpjJsVWSC+ZZYlrxADj7EJCLP3
	wYYMErCgVCsLTTeg6KQciYKr8d6hrR3U2et3REL1lo6x0pV0z9UzZJD2M4oXXDUrgHjDHN6BWzZ
	axG6XXWp2i9sGPep1oxinp5ov8zI8zNn9Fj+PtpcCbefIRw==
X-Received: by 2002:a05:600c:4e02:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-4836710d797mr16270725e9.10.1770879989523;
        Wed, 11 Feb 2026 23:06:29 -0800 (PST)
X-Received: by 2002:a05:600c:4e02:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-4836710d797mr16270405e9.10.1770879989104;
        Wed, 11 Feb 2026 23:06:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d78cfsm251666615e9.1.2026.02.11.23.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 23:06:28 -0800 (PST)
Date: Thu, 12 Feb 2026 02:06:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260212020317-mutt-send-email-mst@kernel.org>
References: <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de>
 <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
 <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de>
 <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
 <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de>
 <CACGkMEveEXky_rTrvRrfi7qix12GG91GfyqnwB6Tu-dnjqAm9A@mail.gmail.com>
 <0c776172-2f02-47fc-babf-2871adca42cb@tu-dortmund.de>
 <CACGkMEte=LwvkxPh-tesJHLVYQV1YZF4is1Yamokhkzaf5GOWw@mail.gmail.com>
 <205aa139-975d-4092-aa04-a2c570ae43a6@tu-dortmund.de>
 <60157111-219d-4fb3-a01a-6df9a83eae7e@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <60157111-219d-4fb3-a01a-6df9a83eae7e@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _-hy3OXUytqr8EBrYIgQB4QkdbXzUxl5-LEKVc4kcOA_1770879990
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Simon is there a reason you drop "Re: " subject prefix when
replying? Each time I am thinking it's a new version
only to find out it's this endless thread where people quote
>1000 lines of context to add 2 lines at the end.

-- 
MST

