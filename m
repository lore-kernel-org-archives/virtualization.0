Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2821390212
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998863; cv=none; b=YraWIUF4FFKnJCWaC5Ts+WRLTDji6UssuO271shUSh0pJ1MqkWHd5VZcPQp+UbkMVFqY08e2EiiNFmP8hcIcnHwxCSJaSQWvz5lNBQvD2JF1NUldvCfZjMFh++dkBdDY9NQ7XBSEfeXjcOQ9rePpdG8IQJhL3a+or68QID3Ttms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998863; c=relaxed/simple;
	bh=2HeW6yQPBT2PrIoTxjqfHMyOQDJQngsMJVK//XX7fOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dB+9Z3tx6sQQG3ixRhIcXrvGqfozlRguwvReg6zuoFImC5JN5R34aX8f/BbV29yLt4CMj2Cf4vttY9JBEg1og3xXtruG1Ks1d2e2Wl9Vh2WBp4+CbI+92GxnWOhtjiDl+ztqh32BzvS3M+udo/CVuX/PQ5GseYvCgCMDc/d90VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ej6ibhkk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ej6ibhkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780998861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5AGHJKl709rDF75fggz2CPtkzpWxiGnDcPVzzKSTGA=;
	b=ej6ibhkk24p4B81ovWD5se+ihyWGwXMzq69SC7/bXqSqaJKgpVELYW1CmhJoYu/w2cMxAd
	yZ5jqRdTkgXvAnEDByCe/qgtLeojWM+92uQAtnth7KyPdK9e64HF8OQhEAPbmg4QwVXt/3
	ikH6SuiAOPag6AWLtgL9vBvxO0E0VLs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-s9D-MhaVOqON9tRgsgz_OA-1; Tue, 09 Jun 2026 05:54:20 -0400
X-MC-Unique: s9D-MhaVOqON9tRgsgz_OA-1
X-Mimecast-MFC-AGG-ID: s9D-MhaVOqON9tRgsgz_OA_1780998859
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bf4ba05fd18so415355166b.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 02:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998859; x=1781603659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5AGHJKl709rDF75fggz2CPtkzpWxiGnDcPVzzKSTGA=;
        b=oPHbZm38qEhGp14UHKRYlotG2nFyTC3jsfS70dmo9HcUmHKTI5MynArgFqeNDh7XH6
         91lpo/OMcLlo2UFeI1qrzEzeA1ijqySE4v5kCE7KGGqR1qOq4ucb7R/y7sR6HHXdu3og
         2LIXcHw0oEzTEb4n5jA9ZD+XuOX/6yb0GtgPQGuXyUPDZ7nHhwLQywwoEueOAqNmkBCa
         j6cBETf1CNi1OR0GzMnTh6hkuCYEDfNQ11Ngl2wsKLGuW7yiMvIdlhYunYreNVf67jq8
         IlJpL/nE14iqqYhXJZozkOv8wME50asXjh8U5s8e1lBZExssB9NdhgAFdaYj514zOOkx
         uKlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7AaeIUKjUh2GNj0jglAEdT1QZVt03XjGpnm/WnLJMclKaRhxct9HDrCviKyyrVGRn9sAPOgf16TVru329aA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+g+kgUmdImqu7YUKnShNr0f0tCgiE9kzLKqjVR3yTYCNquz0w
	NuvY04a7jPJ6AIaENa8M8s0skLH8b/DfAFKMZO3h0a4ArfFc6PNLrFROuzWJAPPVVLTnqzfrN/H
	TjPUJFn3FBNVFMt9aQki/fbm3Go0TXtxde5RpsQRUIswx28FPfc1E8c0qWy3THAQWpA3m
X-Gm-Gg: Acq92OH9yf8WqSemD1ZaalX9LIOfShvPFWnzAFQr6JxurbzU3mwFKQ6EB1//ohh7sI6
	pKOL+9MYDhspDXr/WOSRBl54yFrWNVVZmUcPWDp8gbjlzJXX4g52nfzp9ENefIvNeQ9gs2GKXi5
	UAmnajIV1T9H9EJ0HDWgzklnxz41VmkwWnmhb5LKPWhpS/N8IJj+MiqT39wnXYGdErkCjSclLzr
	KL9Myi1xfv20i98yjAqLWU4pLrmOh4YVC6w5QZEnCpkx7t7/7KSluj+vSA9B//9h1s4m9ixAKrF
	uQA+UlIyE4oItc7uRI19f1fbI6VhLcPQ/Qvkucbgyc9xUk0YCuR3/elRQo+4F/Xss+cc4+Xdmmq
	+pAkTimufYah72tlGbssuKJ0juzOS+vS6H2uNNhL1RdKOzPMiM0XVUA==
X-Received: by 2002:a17:907:ca84:b0:bee:f72a:28d6 with SMTP id a640c23a62f3a-bf37096c195mr956581966b.14.1780998858695;
        Tue, 09 Jun 2026 02:54:18 -0700 (PDT)
X-Received: by 2002:a17:907:ca84:b0:bee:f72a:28d6 with SMTP id a640c23a62f3a-bf37096c195mr956576466b.14.1780998858161;
        Tue, 09 Jun 2026 02:54:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm1010527766b.24.2026.06.09.02.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:54:17 -0700 (PDT)
Date: Tue, 9 Jun 2026 05:54:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 07/37] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <20260609055317-mutt-send-email-mst@kernel.org>
References: <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <aiagMc9Ng_AE_adh@lucifer>
 <aia93IzhTgi1vGi6@casper.infradead.org>
 <aia-q026facbptoT@lucifer>
 <d0ff6269-8b8a-4983-8569-d9a8495829f3@kernel.org>
 <aibSPsc33YQiYSMI@casper.infradead.org>
 <ef14cfdf-5f1f-4e3b-846d-fe1462042883@kernel.org>
 <aibVTe5HTk-fF_kj@casper.infradead.org>
 <68ac0163-865a-452e-b643-351e094cb2ba@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <68ac0163-865a-452e-b643-351e094cb2ba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5yyREcYAcwzyLDwm_1jWoLEit2Qqfrlpmvg_l3X9vQU_1780998859
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 04:55:19PM +0200, David Hildenbrand (Arm) wrote:
> On 6/8/26 16:44, Matthew Wilcox wrote:
> > On Mon, Jun 08, 2026 at 04:37:03PM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/8/26 16:31, Matthew Wilcox wrote:
> >>>
> >>> What I don't understand is how the kernel page allocator needs to know
> >>> the user address in order to effectively zero it, but the hypervisor is
> >>> able to zero the page without knowing the user address.  It feels like
> >>> somebody has x86-centric thinking where cache colouring doesn't matter.
> >>
> >> (not commenting on the icache dache mess we have to drag along)
> > 
> > Well, that was kind of the point of this email ... I did ask the
> > question you're answering in a different email so let me respond
> > to that too.
> 
> Now I'm confused :)
> 
> > 
> >> The thing is that with free-page-reporting the memory is already zeroed by the
> >> hypervisor as part of discarding that memory previously (e.g., MADV_DONTNEED)
> >> and allocating fresh pages on re-access.
> >>
> >> So it's not a question of "why is the hypervisor zeroing less efficiently", as
> >> zeroing is just a side-product of reclaiming that memory in the first place.
> > 
> > We definitely have users who don't want the guest to trust the
> > hypervisor.  So how do they disable this optimisation?
> 
> Right, I don't think we currently have a toggle to disable free page reporting.
> So IIUC, this optimization would similarly automatically get enabled if the
> hypervisor advertises it.
> 
> -- 
> Cheers,
> 
> David

Not as the patchset stands:

[PATCH v10 35/37] virtio_balloon: disable reporting zeroed optimization for confidential guests

disables it.

-- 
MST

