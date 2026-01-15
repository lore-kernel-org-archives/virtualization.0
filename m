Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11914358D0D
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469559; cv=none; b=lKOy7US2Z6R2EowlWwwldi5zKG4BdOBf0a/9BisSX9XAe6hYrDJSAHX0EJs26/tCbw5VabJfCRfdP678n3PHDH1Ja0ny5ApGdzNrzORVtie6TgFR6jmkqpaM92AOKkKt7jVm9x8N1atTMLfD4sI9qRAcf09Je+HVUj/fHdKxXqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469559; c=relaxed/simple;
	bh=Ozn0e+aZcK60IGQOTAmLmLlDwBXMY/IeGnN4Og7JQKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TDOAbEwr7vtCylzIZYFG2D555LDe5xSHVfj1Yr/PbnIgsYePfsrS5y8BfXbFS1PcgAfL3nZiZka0gMV2oHKSZmybPcjPniRV3yOHZS52TFjm4nIuMIdM+r/jxGcjtDoMKhtU/XJgBt+clrztlDYwVrR2iYATwLbXJIiZFyFFeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClCBBlDS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClCBBlDS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768469557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C4Jd2k3tJmH6usMx/hzIeIrNAyuq9j42Ypf29Ccd2co=;
	b=ClCBBlDSvffe3eQp/aTzuxnebq9nwYzLTTyjCuwf8LfM9XWUMDYUaTjKcpmQUsP4F5FTAZ
	t/oe4tdNiZxtMcMTswwMedkTnFQkgnK6tSwzO+PPaTJV9Ue2lpeE/p+DUbiBIgvL1o+3BS
	FZXaTgaSSem86N9fNi8Zfo6xhlPQet8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-IQ4AtNs0O2yGft11dKtbhw-1; Thu, 15 Jan 2026 04:32:35 -0500
X-MC-Unique: IQ4AtNs0O2yGft11dKtbhw-1
X-Mimecast-MFC-AGG-ID: IQ4AtNs0O2yGft11dKtbhw_1768469554
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430ffc4dc83so591193f8f.3
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 01:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469554; x=1769074354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4Jd2k3tJmH6usMx/hzIeIrNAyuq9j42Ypf29Ccd2co=;
        b=YneGJG3BG/VZMLUsyHRTEmQzxI18a6Rno0MQkaFARO1FfR/t3QouaX2iiYk5ZTXGq7
         iJYLb5S6oPv/y2FgDOY9rktSekFEN00/U+ac2EgOTNVl3okEXVwIgY0TaBpGhaQDyq7P
         GbksakqSmjG8z4KJBjLrEp3+rUbfP8yF9T/OzhiRQDTfVYXSLuvzrI7Ii3hMAh6pXJVV
         uhXATxd+A5datqjmi/e32sBTsLqXFntbjdj02UmC2knMv0s7miF5qBpPI0TNCWmKCJMa
         sAKqJK+z1/zEf8tgKxyYjjn0aNOFPzHhBw74SRGNIMUMUIhkUnh+o6AU10yxeYqhtB19
         a2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqh5mdUCqlK/Sbg6iMWylA5K7Mtk4lzX9QgGW86sSsSyqgLIqOhyUOFkWr2YAu3nVE6/s/2Awp1CPj26MNoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3NcCKGwcRv3ZEi4BkcDpW9YrhbZHuzgSiQv9AZiVQEanjK4zg
	H+8zE91WpHmvB29tLpYIhNOl6a7c2VE/pgXSpa1GVXGo4BkghTZtWxrIVWuKIYClO2OUt9nd0Ht
	Y/Tsl3z90LyxjPJ8Asj2/V3V2tJAG37zflpehbrFOBpvnQFB7JQbNaHitA5nAsjY2AJCW
X-Gm-Gg: AY/fxX5bHwpzbEGiyawO1e8o4wIhYNBPRmLN7Ai4WCKXWzpu/bXBXBlqPO0xsozmi4X
	1Duow0Oyvrea3TY5701O1EfOtPPAIdXaxbSDyuBANiY04lR1IV263dIS6ycfc8QJ5kRavfDPDWq
	xOw4orYVM8WP0uB9W3zJyfFZAFAsZMfMVsgNsz+Ccsg0lanxbswyJzODaOkHtRciPHwP7O01GKz
	Z4dZRJqVhEo4V8g9gOQ9dxAg4zKz4YYwY/K4+rp+mo25NRBXHWwxLVpufKfyXGi7t0uF5imS2C0
	G+xruvHib3uUMnBh34Us7FGhozQYxPbYckHLFHZu7cg8xJfrQx7nc4XZSQzgUPrIrvIjVldRQCl
	J98YNg7AYbNrqB9seLzjedlUVl2OKIg==
X-Received: by 2002:a05:6000:402b:b0:430:f41f:bd5a with SMTP id ffacd0b85a97d-4342c5727bamr6648829f8f.57.1768469553960;
        Thu, 15 Jan 2026 01:32:33 -0800 (PST)
X-Received: by 2002:a05:6000:402b:b0:430:f41f:bd5a with SMTP id ffacd0b85a97d-4342c5727bamr6648783f8f.57.1768469553541;
        Thu, 15 Jan 2026 01:32:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af65f649sm4794185f8f.19.2026.01.15.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 01:32:32 -0800 (PST)
Date: Thu, 15 Jan 2026 04:32:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v2 23/23] MAINTAINERS: move memory balloon infrastructure
 to "MEMORY MANAGEMENT - BALLOON"
Message-ID: <20260115043136-mutt-send-email-mst@kernel.org>
References: <20260115092015.3928975-1-david@kernel.org>
 <20260115092015.3928975-24-david@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260115092015.3928975-24-david@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pUf8IxdNvpmBWiI4XSI3LZ2TkcojIYKjWrIjFI-lZPc_1768469554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2026 at 10:20:13AM +0100, David Hildenbrand (Red Hat) wrote:
> Nowadays, there is nothing virtio-balloon specific anymore about these
> files, the basic infrastructure is used by multiple memory balloon
> drivers.
> 
> For now we'll route it through Andrew's tree, maybe in some future it
> makes sense to route this through a separate tree.
> 
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---
>  MAINTAINERS | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index de8f89ca1149f..b974f8c1c2225 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16454,6 +16454,16 @@ T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
>  F:	mm/
>  F:	tools/mm/
>  
> +MEMORY MANAGEMENT - BALLOON
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +M:	David Hildenbrand <david@redhat.com>
> +L:	linux-mm@kvack.org

I'd still like virtualization@lists.linux.dev included, too.

> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	include/linux/balloon.h
> +F:	mm/balloon.c
> +
>  MEMORY MANAGEMENT - CORE
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	David Hildenbrand <david@kernel.org>
> @@ -27536,9 +27546,7 @@ M:	David Hildenbrand <david@kernel.org>
>  L:	virtualization@lists.linux.dev
>  S:	Maintained
>  F:	drivers/virtio/virtio_balloon.c
> -F:	include/linux/balloon.h
>  F:	include/uapi/linux/virtio_balloon.h
> -F:	mm/balloon.c
>  
>  VIRTIO BLOCK AND SCSI DRIVERS
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
> -- 
> 2.52.0

