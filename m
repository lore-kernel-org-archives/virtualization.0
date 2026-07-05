Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5131433E71
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783242397; cv=none; b=epsIXiU/dbnKCkYe+W2CAu7vMPzYQVgjNruib6wSJaGErbz1f++M9fcYxAqLHoHRmojrBehhhQ4h2DUQOLnkIhKMJptEe7NA1EOtlaCoUk07Y02zrVyLJnlI9i2rdb+EOmwKqOc0PbHaOMUkWedfMt2iYFIsweHbFXI9ZBrORVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783242397; c=relaxed/simple;
	bh=1S9VScandDqQ7PKxFyzJGh2t7FG63XBlOht32fnohUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BsBE3apisxBcVcvUY6pOuSOTKkg8X1JlSdJMIo2oXPNL9XLVASeYmJ3I+w+sV16GJSlKIjK/wO3Nnbs7BNtpUbhGTBXSZvmUqVynNloeVLNoaQgGCYgMzsO6eBeN6wqRRbn6aiGLTx6tKxRrhDwUvI2+DtPg67JquOkQUOtEEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3EVi/ZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3EVi/ZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783242394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwl2RZIgRGshSa/qt93sniK4Og2qca+KFPXUQBK5QlE=;
	b=M3EVi/ZAVKMzxUk0mZ4lxfTHf4gP1snPcP/wClGfnCKUe2KZk1UuNn9bGj+W33B5tOu4qu
	VrwQSCDLJ8CpnUaM2+37fTlXp8oFQgTp2zeRHKUicSHnVl4Md/AEpBjVBeaVjciDicXeff
	HqM+RPF9HFL9EDo9G0fV1b5p5kcS8zE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-hgDxfPl7M3aTEguYsVuiDA-1; Sun, 05 Jul 2026 05:06:33 -0400
X-MC-Unique: hgDxfPl7M3aTEguYsVuiDA-1
X-Mimecast-MFC-AGG-ID: hgDxfPl7M3aTEguYsVuiDA_1783242392
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso111926f8f.2
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 02:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783242392; x=1783847192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lwl2RZIgRGshSa/qt93sniK4Og2qca+KFPXUQBK5QlE=;
        b=sC2Iz/h8gZoJAIlg60kolzlZagIwyfDidxSCp513ehdZSIbx0GdRp8pankYeThh/MH
         T94P5pKOggZkqKxqOY5gwkFF7WMFDEkGlb1ucdPCpAljEGGpGdBYIfrOx2dVCCxz9yDp
         vwL8eH77z8x+x8DIOH5RHPgthN+bKQDMsrzvX9JpVqt/KP7aNqd+lEowaY8ZYTMqWfKC
         nwhGtUs3FsIU78Ol6Q5iLr9wrBbJaVTthIBLYVppT2kRw+drfVrfgKE86kEdL08NRBH9
         JsH4HswRq0XJCr4VaUXsUEDEGErgGa0z6yvDhmJhfWcPH0DC+FlbE5g67X8ZQPapyiqK
         3xaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZ/e+NdWubfPj5NcAFHZZqV6qU9siN63npEIU1W9ZrG6s+/w62iiTZu1njogcW+L7nJI61N4JRNdkl7w1S+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwM8ZMH5fVqPYj+D75b0iUD8G+2p098qVDCC2BscmFgHZuQAqK9
	sL5bUf/Ws8LuYIb+hrN2WGOqkfYf4vanFNjv9wCHcg8UsJJVEkNyp0HQLOF1KIc0BuVbotp7F5M
	dX5QUBAVrbiT3RTB/pZzHNcDi9JqMSFgI7pRdnBOepIhf9mWRMCUTk87F64aYNuNwAhxAchLf+M
	+x
X-Gm-Gg: AfdE7cno2wmjDhtQjPZWZEai94Ki+XXI/SLS163JMZqnSeZXg3yVoedaZWkUIF3VCzl
	xDOaUNEIj2e6KUk/VD6Lpbhg1jhPIF0So05Czjh+HGTVNiSccVF5GGpSINjgbX95Rd88TnXc26K
	j85P/RcxflR4yEXcNS3B5vJxzHGMoRVyJfb9MWhgHfIf+BsQdtlOW8wox8YD2z3VBdNiUvCNw9Y
	s3QD2SDsb5z/SYc2VVfR/tfoSJJGAyWKSj81VPcK5vsDsiEthrxpQerVoPylFaXqckYhqLo3bT2
	Go7nQZq9olyjKxfbj4vI6Ux/2Df6BVT1ASDLblxkYc5Z0Y5rOfheQbavQmIRe7nMOtZK5t1wbpq
	Um5+hb+O+ZVmCMhjgP7+QE+q/hL0nEP53
X-Received: by 2002:adf:f390:0:b0:476:cb01:6393 with SMTP id ffacd0b85a97d-47aaba588demr5679057f8f.11.1783242391652;
        Sun, 05 Jul 2026 02:06:31 -0700 (PDT)
X-Received: by 2002:adf:f390:0:b0:476:cb01:6393 with SMTP id ffacd0b85a97d-47aaba588demr5679022f8f.11.1783242391124;
        Sun, 05 Jul 2026 02:06:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm14405764f8f.36.2026.07.05.02.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 02:06:30 -0700 (PDT)
Date: Sun, 5 Jul 2026 05:06:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: page_reporting: allow driver to set batch capacity
Message-ID: <20260705050445-mutt-send-email-mst@kernel.org>
References: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
 <20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
 <20260705042313-mutt-send-email-mst@kernel.org>
 <20260705013956.36f649b5cb13409d9088838a@linux-foundation.org>
 <20260705044139-mutt-send-email-mst@kernel.org>
 <20260705015116.bdf3335e9a955f057a6d9c5d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260705015116.bdf3335e9a955f057a6d9c5d@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i1a6MuiBu35yh9VSZAFj22-Nmj59KhE89lQUysQk9J8_1783242392
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 05, 2026 at 01:51:16AM -0700, Andrew Morton wrote:
> On Sun, 5 Jul 2026 04:42:38 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Sun, Jul 05, 2026 at 01:39:56AM -0700, Andrew Morton wrote:
> > > On Sun, 5 Jul 2026 04:25:53 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > > > > If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
> > > > > > to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
> > > > > > page_reporting_register(), before the reporting work is scheduled,
> > > > > > so we never get division by 0.
> > > > > 
> > > > > Thanks.  What's the priority here?  Should we fix 7.2?  Earlier?
> > > > 
> > > > If possible, I'd like it in 7.2, have a setup like this (small
> > > > queue is useful for perf testing).
> > > > It's very early in the cycle and the code seems straight forward...
> > > > I judge the chances of breaking anything is tiny because
> > > > it just failed probe previously.
> > > 
> > > No probs, I moved this to the the mm-hotfixes-unstable queue.  No cc:stable.
> > 
> > I suspect the Fixes tag will make their AI pick it anyway. But hey.
> 
> -stable maintainers have been asked not to do that - only backport
> patches which have an explicit cc:stable.

Out of curiousity, is this specific to -mm?

-- 
MST

