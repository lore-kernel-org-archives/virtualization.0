Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47EE1E7C34
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267846; cv=none; b=dkdMvSoGXCUJ1OTaNCoSQCBc1wsw/3YcBGCwbAVtNEQtiNKLQ+mRJWr/1Q26xTTHPHRroR2KT0rHciZlwMJVfrB95XvWG01d+wJr65nj1/IA6TBabS/5uzhnKGJ7/LLn0T8jNoLGifj82jPrHmeS7UQ2ktV3OmvbOJmCHeGQaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267846; c=relaxed/simple;
	bh=Tn6aoQKc3aa7Te5ssMfmlg1TIGUDpo7hBrg6GnUEEI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OsMZi7mD55m08yn9teAIsqY19lPQ7ZWc+BSSSodF1ThD9wd+t+5ju6oLIGReNxqjNluRKlu81YYRTKddEdmDLqINxM5wf6jZMK2xlCbVF6xzIMNtcS9xfcA+tQy7e6z8u9WCDCI28N2oMKGLw0rxrltPzkXLrPm+qa9FvKngFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ep2m8QXk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ep2m8QXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751267843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OXgKDsO9IF1jvtOwtc1YPzsL5+C5UReXJZt+iIzw2Mo=;
	b=Ep2m8QXkYuEtbGYQuVKlcmcL13uteGtXpug5ftNTyf0/D8+AbYde+Zo2hv/i6M7mwC2Los
	UooW3fnzNUyqj/yUTc/A+9n++s7bb0uhIsNR6vDv9fes6UaWdOS9wYWKw0PakOkqD5iuGI
	h4Axqvgo3CDi2dE8hazLVEFvkBGmJms=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-9lqmoz_bNuqeTg4aFmpJOA-1; Mon, 30 Jun 2025 03:17:22 -0400
X-MC-Unique: 9lqmoz_bNuqeTg4aFmpJOA-1
X-Mimecast-MFC-AGG-ID: 9lqmoz_bNuqeTg4aFmpJOA_1751267841
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-606b62ce2d4so3929359a12.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751267841; x=1751872641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXgKDsO9IF1jvtOwtc1YPzsL5+C5UReXJZt+iIzw2Mo=;
        b=FIGKozPvtyHyndMJDLhZsJG9EtWRwQHTJ0/3L06RTBm4Ehr/hlk9NV4Kh2BFrsE/sT
         y/ueC9H/li9uRtoRV+VLuavet/50YSLVANSc8Cdy8GPQJWgeP/QZe/xvALYiP0HM/WOJ
         GRrw7MgYurO8kbl6y321JILMLFT4ddqwaqgJ16fEDfQSOtEDgro45hucMs0y0/rGfZME
         Un0rsuqld/3QewuBF4pvyT74qt/QpjujKj+ZF3wGEvRWVo1zZ2dFKuktItwfa2+zkk/x
         FoujygimXj6D949JTO0D0nGd5I+8zMiC41yj829IKll4JSdraJ1a41W/9qcZOnIF9TSO
         sGbg==
X-Forwarded-Encrypted: i=1; AJvYcCVWnXKQWfkXlI7MNrhcd28FR+vqqEPvZLy/UZn00tbFE/haTkShgCyfJ7XHub4o+fQu11ubPOFboJTxIbl9sA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygk/M4mDV8TTAGi/Iagwur/a+W95uDBpjiuKGu2EOTjE0wJFgE
	oabaQwA74nBGB2Amq8Rt0qQpvn1mbJ72F29AZFLQZZzMUXzzWpfkZtntICVlaF2pYt/LW4Qq76C
	+Yghx4kDT2DmaczYikhX2NVAqQZ3iaz3xU9dcY0xvWwzqjbyPeJqtjuYIUns2vOCfGhE1
X-Gm-Gg: ASbGnctLm3BMQJfNdeSJ70el2lod1vV8f7V/4ruBaTdfIVtTyQVaENG/UX01S/12Isc
	GknxOYInopSMMjUldTQkHB2Rn1pmZSOIALCJHvLLc7i7xPbX1sesxqkiuZwYexgYysTt0oxCq2n
	VamQeznl3mHAA759EQFVj8iWuIuNpKNQxsv3g/K8IPUf6KQaz56A75wmf+2VfOzb9merlBBTX29
	XbZwi8PZ166iD5YEKvNTuoys1tiV9vimVBIOmNW65BxTG6HNJsf6eLNUKJnjW1QKG83N/kn/DCb
	Lgbplz/dw0A=
X-Received: by 2002:a17:907:7b89:b0:ae0:e88c:581b with SMTP id a640c23a62f3a-ae3501a1ae4mr1165185866b.53.1751267841027;
        Mon, 30 Jun 2025 00:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKxfKBywT4IQk61EMh763CcXX3O2d6CwAncqtW/koAuBxomT/ER0VDAIzBM2QUWavfZMolHw==
X-Received: by 2002:a17:907:7b89:b0:ae0:e88c:581b with SMTP id a640c23a62f3a-ae3501a1ae4mr1165183566b.53.1751267840551;
        Mon, 30 Jun 2025 00:17:20 -0700 (PDT)
Received: from redhat.com ([31.187.78.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae360e6ce54sm567534666b.37.2025.06.30.00.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:17:20 -0700 (PDT)
Date: Mon, 30 Jun 2025 03:17:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com
Subject: Re: [PATCH RFC] pci: report surprise removal events
Message-ID: <20250630031347-mutt-send-email-mst@kernel.org>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de>
 <20250629132113-mutt-send-email-mst@kernel.org>
 <aGHOzj3_MQ3x7hAD@kbusch-mbp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aGHOzj3_MQ3x7hAD@kbusch-mbp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hAjBSM7k6snvXiijwTlq6JQjih4OecUMuR6SItRTqQI_1751267841
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 29, 2025 at 05:39:58PM -0600, Keith Busch wrote:
> On Sun, Jun 29, 2025 at 01:28:08PM -0400, Michael S. Tsirkin wrote:
> > On Sun, Jun 29, 2025 at 03:36:27PM +0200, Lukas Wunner wrote:
> > > On Sat, Jun 28, 2025 at 02:58:49PM -0400, Michael S. Tsirkin wrote:
> > > 
> > > 1/ The device_lock() will reintroduce the issues solved by 74ff8864cc84.
> > 
> > I see. What other way is there to prevent dev->driver from going away,
> > though? I guess I can add a new spinlock and take it both here and when
> > dev->driver changes? Acceptable?
> 
> You're already holding the pci_bus_sem here, so the final device 'put'
> can't have been called yet, so the device is valid and thread safe in
> this context. I think maintaining the desired lifetime of the
> instantiated driver is just a matter of reference counting within your
> driver.
> 
> Just a thought on your patch, instead of introducing a new callback, you
> could call the existing '->error_detected()' callback with the
> previously set 'pci_channel_io_perm_failure' status. That would totally
> work for nvme to kick its cleanup much quicker than the blk_mq timeout
> handling we currently rely on for this scenario.

That's even easier, sure. However, Lukas raised the issue that
pci_dev_set_disconnected must be fast, and drivers might do silly things
in their callbacks. So, I was working on adding ability to schedule work
on such an event, so prevent such misuse.

At the same time, it's somewhat hard to abstract it all away in
a driver independent manner, a callback is certainly easier.

WDYT?

-- 
MST

