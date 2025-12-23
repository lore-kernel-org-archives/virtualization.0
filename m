Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB50E30FC15
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526710; cv=none; b=ZoDlXoIFM4MWqbnw9bsUJ7f14+fNx1NAPQ8MfqIMctvJ4Wifd8Kq2OPA5EnE9RMARPIg4BhzdMc3ZKjf1ET2V31NWBjtfTGguOCHWJUyCMAlD9DdeQ2gxlaGq4qfa0YV34x1Euqyta6E+sBwYQ5xpmjgG/uno7H3dsNNl9j9hMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526710; c=relaxed/simple;
	bh=cXthFECf7M+LNc4TyNVDwgQ997q3cl0n2gZfYwSKG+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JV42N3710W3z/hVW1ZJOeN7vb5qURz0SOBP+PabjEYpiSan0zDMn1tT70zCZ7L0I6BxaN2r3cm0kDitxOA1P1UCwXKsN62qe3B+DqeLSFKFmNnKxWbw1QZPpshUAj7FoArINkgJpDuCxnO4ed6NQgd/JCEv56fHgYfGoebeEVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWhN2vwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWhN2vwx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766526707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4yXAksJt5VhERsnm3173KkbdLg28LUkgCq4MTlnS5fI=;
	b=WWhN2vwxWweIvPX2SriQdF58AjqOD8fGdEqHZDPPYa0+KKnkMv4ImD2iRTZBzBSC1YHXCa
	7UgMQVeYKEbWYUObyBalITUuVr1OuV59+a2wPdHoI6TSgvXiFKY18Yz9z86PmXpUzg7NV3
	n0JIRwFTAMKgHrSxF6uC47yQ5VdSmhk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-6m2bvBSQOzig3QK9T2e3Kw-1; Tue, 23 Dec 2025 16:51:46 -0500
X-MC-Unique: 6m2bvBSQOzig3QK9T2e3Kw-1
X-Mimecast-MFC-AGG-ID: 6m2bvBSQOzig3QK9T2e3Kw_1766526705
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47918084ac1so45602035e9.2
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 13:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766526705; x=1767131505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yXAksJt5VhERsnm3173KkbdLg28LUkgCq4MTlnS5fI=;
        b=YH7xOMoZSyc/mQ/PCKbCuAqem8w5DyrH3yehs0lVL3haIGvCID/bG56gIpcfTCUmvD
         25EUY9jBIF2UdvQmIP/C4/c4uk1Pbt2wDRLIXc8zNA+OHqdyFUaL/UXyessCLRt3OEZM
         C+vjE7fr6yFX7MXjpjBDKYRROJwZZomXvzJpCAv0xxiEqIyXA1Nl7C2Pu0l3a3le2Ujj
         toxTMTtiUWk4wEjKKxdKB+vO8San/KwEOAg/CXrubWZnoV3sxo+PkWnKugOD7KvZU2e/
         5uVYl8YBeW8gVJAF44k9eCE9wce+Ctf2ogxhCpkUJiaNNwuFNxsutc3QupCMzQC1acZy
         BZbw==
X-Forwarded-Encrypted: i=1; AJvYcCUUkyvt3CTbyaO1pXjANy15ESegjXhQPY0iHPiXmIgENjppxbjePFP8f+Jf84OP5mw0mdoJAFS/23imhRSkdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXBf4z52xd3xalsWSfvPAZe4ppfLJKqYLEYDmPHOFvXK8p0Tsz
	kJjIkLaArPiy7qq+v7iD34VcC4M7G+wHa16WhplTxqI6Wmp5ny+4wdXAZNwINn/XEK7ORz91PqC
	r5ZYcnMYH9L+52OMNZTDVoHaKP1G4DTVOFrpCkdWvN/kCh9ZW30tLm0hKNjU2+LgJw6XS
X-Gm-Gg: AY/fxX6AjY+Is+WbRjs7X6B0oUB/OUWsI4Pku5SVCjmBl/iAI5kmuyrCAG3olNPggFD
	fF8tmLTGUYDLmNSxBsqeR1QMUBtNUNf2rt8b8KFZ1pY2BrBlLSac5NHojvv8kGnPbbIkm4aAce5
	45n/DKXOIG2xSGM00iQY5VsAsL1UGu9Ay8FiySA1g/Yx4dXDP1C9uq1MAq+5/zUoy8IU9SyCvDr
	8GCfenKIpIuvH6FXjxxgiRAa4UaTHqfvkw6WaqrZJVqUl2cGCoc7ln2qqRwb5QliHYGUFgybqlK
	rqxA+G7sCkv/wJUhYjbceHBdtGUTjeAnveLxZwUz9qTQXaVEeXAsv3+DNdMoHS9nwiPzEFJEtmS
	zQE9KONw6zQJjawhB2R/eRsCbfBw9nRriDA==
X-Received: by 2002:a05:600c:46d1:b0:47a:8088:439c with SMTP id 5b1f17b1804b1-47d1959d6a0mr155122295e9.35.1766526704892;
        Tue, 23 Dec 2025 13:51:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/v6UvGcz7cXLMbidc+dzXXEfdNJhnFZc3RSCYTM4ESPNS3/tqnOw9OV8rDCMJJSPHCNYfvQ==
X-Received: by 2002:a05:600c:46d1:b0:47a:8088:439c with SMTP id 5b1f17b1804b1-47d1959d6a0mr155122155e9.35.1766526704446;
        Tue, 23 Dec 2025 13:51:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c637sm298058315e9.11.2025.12.23.13.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:51:43 -0800 (PST)
Date: Tue, 23 Dec 2025 16:51:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Daniel Verkamp <dverkamp@chromium.org>, Amit Shah <amit@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
Message-ID: <20251223165135-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
 <b905018d5ac8a852759e8483ccf8d396eac4380b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b905018d5ac8a852759e8483ccf8d396eac4380b.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -yHDIndevX6glzLvs6KmeuHq31ERXrorIwiYVyUlbTk_1766526705
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2025 at 10:36:48PM +0100, Filip Hejsek wrote:
> Hi,
> 
> I would like to once again request backporting 5326ab737a47
> ("virtio_console: fix order of fields cols and rows") to LTS kernels
> (6.12.x, 6.6.x, 6.1.x, 5.15.x and 5.10.x). The patch fixes a
> discrepancy between the Virtio spec and the Linux implementation.
> 
> Previously, we were considering changing the spec instead, however, a
> decision has been made [1] to keep the spec and backport the kernel
> fix.
> 
> [1]: https://lore.kernel.org/virtio-comment/20251013035826-mutt-send-email-mst@kernel.org/
> 
> Thanks,
> Filip Hejsek


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> On Thu, 2025-09-18 at 01:13 +0200, Filip Hejsek wrote:
> > Hi,
> > 
> > I would like to request backporting 5326ab737a47 ("virtio_console: fix
> > order of fields cols and rows") to all LTS kernels.
> > 
> > I'm working on QEMU patches that add virtio console size support.
> > Without the fix, rows and columns will be swapped.
> > 
> > As far as I know, there are no device implementations that use the
> > wrong order and would by broken by the fix.
> > 
> > Note: A previous version [1] of the patch contained "Cc: stable" and
> > "Fixes:" tags, but they seem to have been accidentally left out from
> > the final version.
> > 
> > [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.com/
> > 
> > Thanks,
> > Filip Hejsek

