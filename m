Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB781B6CFE
	for <virtualization@lists.linux.dev>; Thu, 19 Jun 2025 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301094; cv=none; b=ffzrK6fKyoSLdCwtegQYN8EmQc1iWKopCJ76x2E9vb2FyNOuhtuEpH2AmDToHHmET4N1k7rnJcOMEjpXq1TaLJ4Ntr9LADeQ77eilTF1wkyFVuO44OsHuDZJxGPnJNSLZcj/iSmgmXAhzy8Ar1FxCHfA3syYkvh8xW9LNX4ZfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301094; c=relaxed/simple;
	bh=qoyTG+y8tPin1lSTQeGsP+HTVOL7kT5xddmxzpFuYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cONuwD6phM3mnXxYJcrdHl/PrXwEXp3EqQwxJOwBg6Q8jDaWeEH4ZLdbDeBCdD7o8TgVgfRp1Fver0OpT8VsmTb45FXCGgya0/PJawsyVi40Evh9h+aI069bdDMMxMKQDY+Wk+D6BHujsLraTr5KIcXmQ/w/qwVLencasbI+HGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U2L1O6k7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U2L1O6k7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c7a52e97so194616b3a.3
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750301092; x=1750905892; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGiV4ZITlSkGta2ar3rISknYHCyA9ON09GdNG8pubLA=;
        b=U2L1O6k7LwCAzL3tM1lFFpUO6QJxc4AwwAHoGo8SDV1wdbq0aLAqJmcrsN6LifYLnd
         MMBM34tzf00VqbaAhFZR/4SyVr60E/+USeIS+4VBx/87X41FiHr+ywOtxGbyPbX2RanJ
         n8ye51zrDdcAgqXDbREtRvXoVwXkS3WLtecZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750301092; x=1750905892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGiV4ZITlSkGta2ar3rISknYHCyA9ON09GdNG8pubLA=;
        b=qmuksUnn7BO85cnHC60MTbsHuzUy3p1e/D6vVBGXE8cCifj8WE64pzMZXIaQdO/x9V
         bPI0GOU+Ga7O6mxopTQ2hTm9Ucjau/3W96keb1f4I8uhqwZpZFjKmLe0c1hfqWc+ldLL
         uVyDr0ZTAcnsyaHOBzmUnNTyDOAakvIBnu/zbFrgxZpKrQzsHIm9YaLTfetrZF0HYREI
         w1Zc2+kmnevQYzWF/4g1RRaMdA8KME6I1t4L/+x+9vQxjhIlT9GfjBuF9T0YdrJIXBfZ
         15SZdi8BQ11nFabGr4zJ5lXIVoe2Q1SqUhAkK4WQMlCsLAYnps81nnGDFJSGmfiA30z+
         bXig==
X-Forwarded-Encrypted: i=1; AJvYcCWyWylofuIK69tawcvLEFTejez8jzi30m8OJPlJFuSbUSr095IeXcTEB++rzvD0f5XyvPpDiuNLA/kttGCQtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDtgKNcWKILtZKG7GwzwR7eOI0pfqqobM0o3pRstZ7UwFdg4Gh
	FGggfKf8TUM389y0GLENDDHmHLfkeof2tc2r0SEFI5/OSkLaF/9/f+Fq5cMcRU8WDQ==
X-Gm-Gg: ASbGncsb3o6pAv/W59OV3YWq7ZRT5IHfx+10nxLA6AyNDWRWfeiP9H6xb9gXLV5ljog
	zGSIgeEWPIUnI4iqoKUDRA+H0T+EYVDTKlbO+m/jI659eR9yAcrQ9UdXQaEIrfjOwicQhaPB9jP
	Z0pV1Nwr5AJrYiAXa9m3D9Y91ZgNZiDUQD6xSmrdsOsXtRuvx7o+ATMz1zOIIedV9axxPeNhvBN
	yaKx0BBR/9AviUomhspUc1Q6byQ1VorWNCo9SOQQPM92xmBi1fy67bYk2mdMLRMSL5HDJZPFTbj
	n9DjJ0gtpPLwf+To+nJTQc7p8ImeoV7ikIMBWMeNtItuz050zUuPFldYNqzZCHVaeg==
X-Google-Smtp-Source: AGHT+IG6keXC3NsOp2Ins+/oPh724/MxHSdE1WbIS33oc9s9zagcbgJChxdFiOB1royOBlBoftNKog==
X-Received: by 2002:a05:6a00:1d15:b0:748:e4f6:ff31 with SMTP id d2e1a72fcca58-748e4f7091emr9593788b3a.8.1750301091998;
        Wed, 18 Jun 2025 19:44:51 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cb6:ce70:9b77:ed3b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748ff646231sm44607b3a.146.2025.06.18.19.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:44:51 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:44:40 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 03/29] mm/zsmalloc: drop PageIsolated() related
 VM_BUG_ONs
Message-ID: <ved33aqy5rlayhagg3x6xcry3cyadw6eponaj6dfwkt7xmbep6@dpcvwrfgrjxx>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618174014.1168640-4-david@redhat.com>

On (25/06/18 19:39), David Hildenbrand wrote:
> Let's drop these checks; these are conditions the core migration code
> must make sure will hold either way, no need to double check.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
