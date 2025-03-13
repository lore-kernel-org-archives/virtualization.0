Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A21FC7E8
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850450; cv=none; b=ecgbjuh2Xsu3l/V+2wQlIUTH9g4Rs1Q018cxrVG31xYbq9WK/fMSqrc1W5yRVZw7QAar7y58yfVTXzI4rVAqogpKRfVEe9mbaq/xXqZNY17uBV8QCCq9BguPhdPixPUxjg3MyncPbxpaPDzIcAzztOT2plB5zE3hV7dYPPng+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850450; c=relaxed/simple;
	bh=KtmKrH0Gsv0sBFL6B7nZq6RHI/4HDfiECApPAP1vOr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lG6LL+pP3UddnzIVCnfZUE323jdPj+zEb/0l74Cw1h7UStw/vv37Vz6I4tMSQW+H4fmyaLDYIDHIVEcIvnB1GFnnBaXaDi7ewwpD8DA/PKDlVqbJWbM3X/D/H1PMpboRj1hoyKVHKJ5GQLccBCo/VCITIwHXtB7EXcwL/Wbp/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqJo5nOP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqJo5nOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741850447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4bfYEIbp/kS2X2cwGn1CJqsR/J4F2IpC4H45RKU2a4=;
	b=FqJo5nOPWDZvXMnUaMq8yz7DAur3XgvRRlldH1KzVjncJ0fRNlVzjqNZFuXxvAjubh5CLt
	5jKxjXawWTfdH8AWnvBzqXRPxrEq0ySpYNjo+t4cSIWfVKj7VHmk6qIelpyJAHuOg2rHkT
	6r9zYLj7QvIxHGSArTietsOR7zVC46A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-xTpmmoLJNLuy0dNips_wlg-1; Thu, 13 Mar 2025 03:20:46 -0400
X-MC-Unique: xTpmmoLJNLuy0dNips_wlg-1
X-Mimecast-MFC-AGG-ID: xTpmmoLJNLuy0dNips_wlg_1741850445
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so2673235e9.3
        for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 00:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850444; x=1742455244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4bfYEIbp/kS2X2cwGn1CJqsR/J4F2IpC4H45RKU2a4=;
        b=jP6N/8W4j87xV3fee8ZeplKsegK5EB4x3sXoLLIC9Hz7i3nFmwA+pVRkexKl/QJIlR
         u3jDI7redYdTBskbgnbxR/L7N9JCpkmY/WSxh4wLejuKmf/IhPGnFcLmGUy0xJaIgrjW
         VNiz3ieUOr0npIZf5GvfoTaNzOzRNutzGdGQTFNqHD6rE6Gr2EPBdq+1OdqNFPLJF7AB
         vwTtnbb5V7B95iFoesAo4iRdhkWzuBt7jUQ4bhO7ttAtexrrHUjKR36d7WvQUGornOja
         Q5lzM13h9svgBtok3Rcn35vdoFYL5Al7KTdPMC7ulK+DtXMbuCKcBtmzLiKlqVOiXSSL
         NSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFBapznrTJJrdO/C5TYX9bk2Fk26xkXpdARC8CQhjs6hzpG++xnWFJdGAP+d/by1rui3X45vbLCJLWx2gwPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcKtLscAJPqMOgB5hN9S2LANAEeTDateYUhhk8Xh49adD0B5rG
	9iHH6rVfJVLerA4EiOI9oX2MXNaMd+OeOWKPXXkK4vsOVVMjT6EKowlLmc5DnTrWt/Qf8c9t1VD
	SWr6I/Xfmm8Kkh3Zw1mnM8GAJuag48EjSBxPyvGlL76yndJnA/5EUi/u3mB+RvO6PlemUJAD+
X-Gm-Gg: ASbGncuJ1TV6Mv9x9l8N41I5DRPqOtPWqSUOErvnYghuADLSdT+gIn2vAMz2H9GZpfn
	quw6d7koMW/be+lIm7nOMSIyeQI468uTDj/582Pe/6caaRYN67MYC8+9ZVM+VWMa5MNaIOdBrgb
	o7KlrbHu35gayrl+IeUPkj7GZ1MKmdNM2YWmiHrgvHHNVo86Uy5fNEU4sQI1DdSE1wPVA7KFyUb
	EbeFdwVdtTbRGaXzTNyHICWEVML7j7Est+rT0ONW3CSQiADf3nG2wIKczKxdy1U+FDpVzmxtM69
	Q1b6iuQITQ==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39132dab192mr19228453f8f.54.1741850444462;
        Thu, 13 Mar 2025 00:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdSno6hSKVsk5d06B4EsgagrhEFS5vVdfXL2wu7cQUeZCwJ3oOQpqMw11c+iVNeKk+NLYSpA==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39132dab192mr19228411f8f.54.1741850444109;
        Thu, 13 Mar 2025 00:20:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d18a2af42sm10316185e9.32.2025.03.13.00.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:20:43 -0700 (PDT)
Date: Thu, 13 Mar 2025 03:20:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
Message-ID: <20250313032001-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gZs_18pzDLQtjPXuh22pSEQXro3EQcXCusgs-WCjTCs_1741850445
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2025 at 11:19:06PM +0100, David Hildenbrand wrote:
> On 12.03.25 01:06, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
> > expose it through /proc/meminfo and other memory reporting interfaces.
> 
> In balloon_page_enqueue_one(), we perform a
> 
> __count_vm_event(BALLOON_INFLATE)
> 
> and in balloon_page_list_dequeue
> 
> __count_vm_event(BALLOON_DEFLATE);
> 
> 
> Should we maybe simply do the per-node accounting similarly there?


BTW should virtio mem be tied into this too, in some way? or is it too
different?

> -- 
> Cheers,
> 
> David / dhildenb

