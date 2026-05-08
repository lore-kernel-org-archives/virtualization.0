Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B51371CE2
	for <virtualization@lists.linux-foundation.org>; Fri,  8 May 2026 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221023; cv=none; b=dbpK+l0AzzRbh48xeSaDca9OTBl8asKGG1ByhEGVuKQAj4zq8ekGeqLQZXOXW+88IKXPU/yaRflpPlfsjrh70K95v9r0M4pZ5N0p+9SR2uIwCOz8HGyD7PAMR16XadoSt/eAeLw7ylYmQT5EPc0wlfb0yW7aI5+aoEtLC3R5Mx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221023; c=relaxed/simple;
	bh=maMKpG5JtsahwCoCistRB9wzcOXtXjO7nbLwk2IXAhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eU6zb/56cVLQsxgdzdoL3QNVOQGHnbwrBzYq+bc8W95IxDS8iYEyIjy1fJoTP3JqVxMyRgfV9p7afaXanSGw/wlpvZLnqKZGXRgq/QDrE7rJ+bTRbF8mage7wpq+XQh1azxBmcXFzVhSNjWK1FggKEuZ8MhyiSw2PZmuPbNX2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KM4KFiy3; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KM4KFiy3"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52830416C5
	for <virtualization@lists.linux-foundation.org>; Fri,  8 May 2026 06:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qi9LSr5zK8lu for <virtualization@lists.linux-foundation.org>;
 Fri,  8 May 2026 06:16:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4AF69416C2
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AF69416C2
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KM4KFiy3
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4AF69416C2
	for <virtualization@lists.linux-foundation.org>; Fri,  8 May 2026 06:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778221011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2unXq22HY2FnCjKT6qtydtFufJI+AwXDzC5gFdjej0M=;
	b=KM4KFiy3W6T+yPa/+5TBYd1nyixpSjiBEJeevhfbKczLBojqwwkjOZLUt2rw0Ippl6mMJO
	yfKH2GOb9iIeVrJVZMfkS6Wc5kPOkuifcWfQXjSCfMObaClabjHAnD5TLiFT9O6ezCZ8ia
	sCxxM31/M5PT44GCBVKwju3q0slF5KA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-kltfxTRKOUK6a-1KLN0RrQ-1; Fri, 08 May 2026 02:16:49 -0400
X-MC-Unique: kltfxTRKOUK6a-1KLN0RrQ-1
X-Mimecast-MFC-AGG-ID: kltfxTRKOUK6a-1KLN0RrQ_1778221009
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44dad1b938fso1020768f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 07 May 2026 23:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221009; x=1778825809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2unXq22HY2FnCjKT6qtydtFufJI+AwXDzC5gFdjej0M=;
        b=T/HutPg3KBsC8owozmC8WvUJHmiO9nXyPs9Fb4YHEQSeR3793GBcds4wGfg55C4cPP
         CvjEfLMdN/U6pWUZeM67WQkVIhksZZfCX0dGwdfsV8aWj0T8eVsanP/2KG8FxNkyNdGU
         r1Er//x6fwn5c1tcoys2P6CxesFwsmvh2yM20n4TgYRZ78bzBm/DT7207c6Vjni6b18q
         BSuPO542LSl8HjHM0Bw7ziBl+PG9hDgFyR7yKMh42ss0hHOGWw+BhKZUpUnckQZJ+AIn
         JvejRvh3x6J5iviqUhXykjcPjSDrhQvoxDkcsMoCJHQxdPMRp/enq7pbLH23m3JgBwxm
         bZAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dDI0UM9iEfS7pHm2LJ5WgH3Ce8PSnXeHNwijbABRqxVVuQv3+NKzDZ7vAmzkfT9fBXjWL/4UlaYAQiwSu2Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxD+va93Ih/KtsDZiUP8iP7M6zmkBAWQ2iMvZixX7s0QUD0EB3Z
	fU0jpEAJrY3RvSsz0qCFTqVsi11LG22D2Loiqvrq6t6CjuIBraFJUkLLW7FK1rCMjuOIRLQXt5o
	mo9xi5vIpkOa46yb3Q3Z5A2vtr9NjyXaWSIkTxZtXr/AtfAuelvCjdgz3y+rz8rIQV3wcWvEZay
	70x+hVimE=
X-Gm-Gg: AeBDiev7J7rTnjvhmt0DqLcC/M/p+2IsFkoCWfE2MpVL+8rIy0GheePmzd3c/a/tQ48
	2JmuW3PycAzfkYsluoPP61wY6MCa3jSyvGiBX7bi8HPiuWOGHLyr0/KAMAr70yxJSA7GFuY2M62
	zkVeH2hnHaOrULOi4NzZYqiquhwbkOLgln87D3RA/48DvZ6C4kUaa9I1mr3mVDtdwTJ7HaHxLiO
	98lJoCbggg0V+79N7O3Xg1gLmvjt14BY4SE3ZHo07xF3tDbrrhHGVVUgzb26/bsiEG7XL4ONYTP
	U2qocy3eN5BNLEMhFXQra2MDloajPQE9w+Sw37tyto7nYTZiUOGgyaGGngvaXBZ7WYeQaadmsGw
	ckRy9tPD8XapxKDK4qfQ2ubAQGGiqTa58wi+l18ul
X-Received: by 2002:a05:600c:a47:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48e6767e04fmr19385195e9.11.1778221008544;
        Thu, 07 May 2026 23:16:48 -0700 (PDT)
X-Received: by 2002:a05:600c:a47:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48e6767e04fmr19384575e9.11.1778221007973;
        Thu, 07 May 2026 23:16:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68eef558sm15122585e9.7.2026.05.07.23.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:16:47 -0700 (PDT)
Date: Fri, 8 May 2026 02:16:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [mst-vhost:balloon 4/30] Warning: mm/mempolicy.c:2527 expecting
 prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages()
 instead
Message-ID: <20260508021630-mutt-send-email-mst@kernel.org>
References: <202605080331.y1eIdVUC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <202605080331.y1eIdVUC-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GAMia4F7c8jxx6GOa7kkdQd9pNPidlhO2fO97k583Is_1778221009
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2026 at 03:56:56AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
> head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
> commit: 95744e0e9c4df79c6bc8ec96306b29c7a8e8984e [4/30] mm: move vma_alloc_folio to page_alloc.c
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605080331.y1eIdVUC-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> Warning: mm/mempolicy.c:2527 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


kerneldoc messed up by a rebase. will fix up.

