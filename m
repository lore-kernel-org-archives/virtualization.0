Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E52E7168
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189469; cv=none; b=ATtMscoEUYo/LDLYnp19ZZsmFvUIH96cLXzpWxCKEzk3l2aFoZItjFBy1BxA2kLBQfDaBcLNQaSHzZZJC3y5FQJyoeXlyqpYZZAdpA+1H6Quk9NBz5j8gszNRTgkZeEN2Dj72isIEay5bcLWAw/4YqY3F5vt69tiMbli12FIPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189469; c=relaxed/simple;
	bh=d7Qa9uTwQP9IlFVLep+Lf4kR5fWHlvWelL/qOpCe/Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fX7jdwxniZzT23EsOiNr6EyXl/Nyfo1cRVQ86N9jNmDy0dOSjV8yZaPXTPzCd6Kw1QJuRYlVUWbck2BEsPC9fMnK+C5M2v1QTi1DDE5BJWxEikUnrAaM5vrwfu/5YSmvOqCtU4I335adOE3f+xeoA4p/qdcKAlIAutfe3UXb2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKG6LGoL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKG6LGoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750189466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xz8wxuAlhJWtQEwDScEI86WHmU+E7vfWayu2m96ONxo=;
	b=bKG6LGoLNXCfL5oBx7iG+72InMHC242OBpDsXUGuZ9g+h7MeUxbV7gghfqwMrg3OtC7egU
	sllsZWqUbxw7CzPz2gUfmUO32wwMWdnMtdhpSLN5U8nJpOPjW+OguNPPn38KaO2hXV5ENj
	tnxzJMjqk19BfngCtJaNRuLDgVKi3y4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-UTUlqNZAN8K4SK4v04soDA-1; Tue, 17 Jun 2025 15:44:25 -0400
X-MC-Unique: UTUlqNZAN8K4SK4v04soDA-1
X-Mimecast-MFC-AGG-ID: UTUlqNZAN8K4SK4v04soDA_1750189464
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a56b3dee17so9067f8f.0
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 12:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189464; x=1750794264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz8wxuAlhJWtQEwDScEI86WHmU+E7vfWayu2m96ONxo=;
        b=dlGCVULc52sfeif/HGzfrW7SH95gCT5CnnyEQ6XSc8vRx71/crgyj86JpQ/bErbr2x
         6dTg8bCtVCAaMpVVVZ6GMavAjnJNXN6Zq0a07/8Cr2tJ53w2m6MWG+ag28C9V82HY0FN
         xTfhoY6OpbvvsmFleiiqXKPT+nEbxmjUWMkJCDhoSJmzQd49IvvcaObnwPVQHxWE7mSZ
         wOSLqp+yxMgw15O/SucJwpXkXa7ScLnyb04zjPVcrYRWQMC6yfE3olAeJwy4C7F2Kl9U
         FEx+Dehio8pRk/37ZYwcTeCbhH8OfRJWZdt+qWY7eupmoAc+FkAkhmHJu2ZXui5qN+k5
         2s/w==
X-Forwarded-Encrypted: i=1; AJvYcCWChR4BUDdfaeVuDmiimhHYyQIEq9N78zZT8CgAp/uYfx6u3PtxT8Rg47Au3x+Y6JvFMPtujYjA32AuJNdeEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwILTzpqX8ikcOKV9qzSW+ikXxKvR2gy9ygYM9RcQEvLc2TeQvv
	zrKxiqcr7pphWsKw0vF+2mY5KXpbCtcq2Eich2kRSP8lFXBxITTQWqxfFKPD1ePZQUFlJYs5wO3
	yZ4RkWMe8AXrlAkQkBgp+lgiph4M8JAzG3jibn4wqdNjqTsQQ+bCxyr2GeNJOALLwxsux
X-Gm-Gg: ASbGncut/MubOtdHmJDiIYgZshJS8v7/Dj/Ab9sNMY6e7yZaQ1ieO79PelZw5VvZgvx
	iMA/az1ZlFp6NuYyPFrGmvBX6jm5tWBoGYxNcLkN4zTInNd/TCL9X/7kxN1Y2GhQBlWKrUYGClo
	gzSrlpYgue0p4mvvF3yBoJLVGlm97FphQ8A5a1ysGtwQFVyLvhkZpgq4wBHGwglpjafXOlslwrx
	ktAk9EXTPB0P9HC75lrF0oh00Xctw5r+ZFKj/48o2beDgUd2OdhgexgQyzh/HuGTiJEXjmK49Aa
	oe18AlKOewTYFt7H
X-Received: by 2002:a05:6000:1884:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a56d821e4dmr13616040f8f.16.1750189464050;
        Tue, 17 Jun 2025 12:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT4nXs8VZp00DXkDGFfmjcwryY7G0O/06cxd3nB1XVq44C9m+cjUSonQ6A1euh9PZFFnKMsw==
X-Received: by 2002:a05:6000:1884:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a56d821e4dmr13616025f8f.16.1750189463650;
        Tue, 17 Jun 2025 12:44:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b09148sm15304977f8f.58.2025.06.17.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:44:23 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:44:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alyssa Ross <hi@alyssa.is>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, x86@kernel.org,
	Spectrum OS Development <devel@spectrum-os.org>
Subject: Re: Virtio-IOMMU interrupt remapping design
Message-ID: <20250617154331-mutt-send-email-mst@kernel.org>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250616132031.GB1354058@ziepe.ca>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8VJcbYLJiU5g4Thi2coih7i5nQlWNyRlnAisrXNrZpY_1750189464
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2025 at 10:20:31AM -0300, Jason Gunthorpe wrote:
> On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:
> 
> > Is a paravirtualized IOMMU with interrupt remapping something that makes
> > sense?
> 
> IMHO linking interrupt remapping to the iommu is a poor design,
> interrupt routing belongs in the irq subsystem, not in the iommu.
> 
> The fact AMD and Intel both coupled their interrupt routing to their
> iommu hardware is just a weird design decision. ARM didn't do this,
> for instance.


why does it matter in which device it resides?
Way I see it, there is little reason to remap interrupts
without also using an iommu, so why not a single device.
what did I miss?


> So I would not try to do this at all, you should have a
> para-virtualized IRQ interface, not an extension to virtio-iommu
> adding interrupt handling. :\
> 
> AFAIK hyperv shows how to build something like this.
> 
> Jason

