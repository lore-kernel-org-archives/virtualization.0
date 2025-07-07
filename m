Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E717ADF8
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751855958; cv=none; b=X9TIeqH9MT132Y9xiAayGVZheBVVkyG1YwRUsdJkmGPJyKPnyT909SNPagritwhC3b9MW85l+jqFk9r8Jb3Vyzucpvs5ZtMbqLC4e2BwjFwZUzsEmq5j4RoC0YNMkm+Ug0pCsszkTg+8rontyKu6ahN7ZapxLDhKNcD/5E8SCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751855958; c=relaxed/simple;
	bh=atyvLyGvCJNyDgAWZ4IJQR5kCqQIHDUYFs82Oe/4Rqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiKXHeoe8OBdXOSj+cn2uqs30BZpGahe8nuTMCEfDlvnaGr/g3mTu8u7jCMo+EiVQ7KSjK0NMJQ4cu63WKE5Z3u4EGn43CLJ+3RfQB6fmAeFtgh+4DD3KFnu0pjHs/tqBK/RguK3LD3n4bq7Q5qX3vaOC3Npxe2MqcgnUb/Wvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ExbOjb5b; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ExbOjb5b"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1461748b3a.1
        for <virtualization@lists.linux.dev>; Sun, 06 Jul 2025 19:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751855957; x=1752460757; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2eqbUK4FYCJiLH0zvQx8aO0ccOeXGf/PUZ4UYY45Alo=;
        b=ExbOjb5b/zDP3o1GrLjTzXFapfzStsab0Hoq+GODQE/yfHlAqB78KVGKqBqDsGLEW0
         BYMe77qXkiD5Iv8/oX/JPznyMem0bBf2qs+W4je9X7B7/xN3zm1ybVRhfnvKVp14ge/c
         0OdRySuK+N1yikkO17zH9PSvE9T52+h5enCJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751855957; x=1752460757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eqbUK4FYCJiLH0zvQx8aO0ccOeXGf/PUZ4UYY45Alo=;
        b=eW5e5CH96I85pVE+q2ai/2/fp2D75DG8Ey5iRuqqMvfMY2ew/+4DpmwTBZK1n6ODUF
         n43Ix/vkvYBjDB5vQc6zC36cA79UtRpEE+VSrSlHxZgE94LcDLrtmSIQySLRICBIwTQA
         sJ6V7SvptF9kDk+o+zAuNQll1R0hYEl8KgIybtzPPQF7Lz5gpY0aQNnnuMxfRpKmYj2W
         adsMUv7OPIhunx4mrSlQ1HNeaLTKjMuzUsIDvEw8Sh7x//Amv8vl1DFGS6FDxgEZObLw
         stjQrT9IDYs47ac6Kce40DZwiJvAs5L9rJGiXxDHaGhK4QKEpFL/b11oNFQhI19tuZhn
         IBjA==
X-Forwarded-Encrypted: i=1; AJvYcCV+n4FJ+USBKJYeiRJoccINRyLuI1ZDKDTF4UYMlkVpX01/Tw8VAPkAEglQnisNF7aT3r294PUpJpea0mBfZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyywjUWlwWl9NQc2AW6Gs9P4bWxrj2vCKc16tIpIYYTeX7nfOHT
	Z6I6WHCxT5iLA6Km7XOWtqX1Wvx2xlDIKzbxkkyfus9xmUpJQkyfXlitqShv3Sx0UKc18FKV0Vi
	nvnU=
X-Gm-Gg: ASbGncsfENGq4TAQNgfvYEH/MRzWCm98yMn+x1NRdnMZ/IjmYWzk11Vw6re+Z72MpAX
	UjCYfD1GM86ZY0IyWPkEyKVhki96I1cj1AtnG9+DGY4lfniGilKnicuHcCwf1NEap7RO3Tk2qjW
	FchejEPFmKzvdk5aDngAgQDU8qRWwlOpbG9AGO7lQXzYytsRSMtYZyeA94/cCzfaMQ8CKtXdy9Y
	7bs8gApEezLDQr2Cs4H0xfjjrOwxuZH+6LF7RxV90td/JtvKK/ssmjMPxrxtsM6DiCvRMqZ1AOt
	Lt3BKOsGxtAh3A9vktjDIAYmt3k3lFHsaERY48SomGcpxrt8c0BcoqEk0lqbp2BMIg==
X-Google-Smtp-Source: AGHT+IEurZuttkS95VnXcSGu+b+8TgCle7ih6/mBYzXLZUJ1AXkAhgjCuqtatOUxrSPej26STHUETw==
X-Received: by 2002:a05:6a20:4328:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-226095a5143mr15866459637.10.1751855956675;
        Sun, 06 Jul 2025 19:39:16 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5470:7382:9666:68b0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee74cf48sm7419649a12.77.2025.07.06.19.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 19:39:16 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:39:04 +0900
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
Subject: Re: [PATCH v2 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Message-ID: <5bc5vidilgjb37qypdlinywm64j447wtkirbmqdbmba2bgr3ob@22so3brrpctt>
References: <20250704102524.326966-1-david@redhat.com>
 <20250704102524.326966-13-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704102524.326966-13-david@redhat.com>

On (25/07/04 12:25), David Hildenbrand wrote:
> Instead, let's check in the callbacks if the page was already destroyed,
> which can be checked by looking at zpdesc->zspage (see reset_zpdesc()).
> 
> If we detect that the page was destroyed:
> 
> (1) Fail isolation, just like the migration core would
> 
> (2) Fake migration success just like the migration core would
> 
> In the putback case there is nothing to do, as we don't do anything just
> like the migration core would do.
> 
> In the future, we should look into not letting these pages get destroyed
> while they are isolated -- and instead delaying that to the
> putback/migration call. Add a TODO for that.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
