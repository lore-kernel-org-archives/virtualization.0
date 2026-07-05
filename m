Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164523BD06
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783242201; cv=none; b=bhwDNxf4svzzUPwVS88UGAof6lMsIHpwbR7ewNxTM40EUklmkzlbk4f6I7Q6h/Cef94OxUQbVFrCmCbeqbvtxayLyt26fUyoZOyNrnAhj7fkO2cg9hLYYTEXkxhGxVn7OuDUOwyT/KcLZB/BB7K1owpj9T/p90A7ySlp68xbmFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783242201; c=relaxed/simple;
	bh=brbV8/1DPwfsgqRed2mZmbC3fwIJoy2L9mJnekMiAyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J+AJKT9Icnondoc+IBXAYUkI5ZKgvCYPY2xuKnXGTtaa0bMbWR17Kbu0WjvRPn9qJiYRmvhPk6aSSQ4DkSFNXfm+NiWssflYA04aJL79+3dLDx/7eG6Yhv1PAhTOq69sZZVNpMngHphbzN3EjeQerjsqkzGYcHH6jmx6dmQIA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZUcgZyJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZUcgZyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783242199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yx1i8H1guo8skt2UVrwpIqA49iMJYRdNcjVq3Vf0DQU=;
	b=aZUcgZyJxIogRvxzR/TfbhqXPD5WYsScmQoF+ufnqM+ZUW6JKtycrwYgSCu30hKxhoi5xF
	/DiPFgnqr9w94QWYg/KpiU3g1Y3JAp3b6hZVBP6vxEHU9QudNYmKnzflgIB10g1d2chZa7
	5v/pimNk22ik5RO4Lqn9STAs/2vzQVE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-qQjLm3NIMe6x-bbd7VNdBw-1; Sun, 05 Jul 2026 05:03:18 -0400
X-MC-Unique: qQjLm3NIMe6x-bbd7VNdBw-1
X-Mimecast-MFC-AGG-ID: qQjLm3NIMe6x-bbd7VNdBw_1783242197
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47127ee7e07so1305849f8f.2
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 02:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783242197; x=1783846997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx1i8H1guo8skt2UVrwpIqA49iMJYRdNcjVq3Vf0DQU=;
        b=izhhwqPA7jWkEHH45sqziFM4gmjkd1re7Y8A7DR4qJhr3R2aYkFkC/u0LRVXLViW/N
         /4TgGVaKQGiw7Gx0lQPktH8uT3bFsxyglo3Y4lT6H2/mW9dMaYkj1XqEGsZh/9jVqB9y
         osCK+25OWy/tQ4OEZSIVVF22nnrEDyFIK3ehEM7BEcmjhzQTOoCnPhzTQyGBft0y24aO
         PqatHbbqjsuys7rBaDkDY/zKPOQKXx5SF9rmi5zc/zneWcQbimNDkf33/9Oun3gGsOAG
         vn6EUc/RzPhQ7KGDoLUi4zyZSLy/wUHggdsXklw0PAF05GOtD+EvrBLIExDgF5tRmT6R
         I1Gw==
X-Forwarded-Encrypted: i=1; AHgh+RoMIVATx3aWAn6LA8DZCJeI6h6aEcHo4t2C3AB4/NIVx3iN9z+dt8ZBM4jvNa/ZXd8DvUZAJ5QNUo3OY3DR+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgIwVqGull40DktB3y92Gr3+oYKvsMzD570Pv5FLW52VhUZbgb
	IGXQ+2f9R09FIYbGIYa3vg/qNa9s5dF9zZ9pK769E5How3Vc3A/QMX4z7+8rpMADWRKK/Sfx3wG
	dGPz5miwq/fQRLPxdX3GcNNsTHJg+xlzDed+ifrFNhVyZS4p0fkVQQBFZ3ApQHnKp71Fe
X-Gm-Gg: AfdE7clbHlAwlfxlA6fqfANrYDNRZawEZH40BUcz0YsfVTkAu+rSLNtXuSwk0o/N9sj
	i11lIE5AsTQHZ5ZeY0au2g7KxdGUzhD9EfbQlia7lEjLx00kTg3Smnht6ZfWu4Zv/0GwdARhR3e
	c1p8vb2q6Ut+hC+/qwBurs40FahbfV/sZsVxdDqoLlKNfqUE72RlLa1PUniOiqL/ItuKq93Npf5
	zyJMKvLYhEAmmjqIaPCXkJMJ/S9x0GKJOHcQQoRCxB2Zk8bIRQnO2p9copgwZbNxQwGcKURCoxd
	ehfk5WUEYf9cBttDet0JznE72UY014L9f4mQaXMJYLxLBi6nPy3OTXcsbjN4W+2c07xs0RopcUA
	1vOcR7Z60awOuOy1d/wPmeBxlnr/W9jBk
X-Received: by 2002:adf:f9c5:0:b0:475:f100:3605 with SMTP id ffacd0b85a97d-47aabe31110mr5574716f8f.52.1783242196740;
        Sun, 05 Jul 2026 02:03:16 -0700 (PDT)
X-Received: by 2002:adf:f9c5:0:b0:475:f100:3605 with SMTP id ffacd0b85a97d-47aabe31110mr5574682f8f.52.1783242196164;
        Sun, 05 Jul 2026 02:03:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6da9sm14391797f8f.12.2026.07.05.02.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 02:03:15 -0700 (PDT)
Date: Sun, 5 Jul 2026 05:03:11 -0400
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
Message-ID: <20260705045807-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: HwxcPvFY__UcA63mLJKLlT7Uxru5GxaTlvH5tZMvEak_1783242197
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
> 
> So should I add one?

The "scratch my own itch, I want my hardware to work ASAP" part of me wants
to say yes. But the "decades of experience taught me I'm fallible" part
says let's have this out in the field for a while first. I had time
for coffee, and I'm dr Jekyll now. So no, thanks!

-- 
MST

