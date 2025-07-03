Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2EB298259
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528992; cv=none; b=NQWwaQuqLP/EMBW8j6/DF8aHKrI2JPdgibKaAv0CNk8Eku1C1TpDJB/YJxdfPlWLXoBq81KSPNNJL9bLBdKIBSan/ACEHWegiQXb1RIODPsTSthRvG4BSuM2OrCGydMDdMHusZlXzmjz7L4KW4fEkhN9pVeyP8Hrbg0kT0l7EoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528992; c=relaxed/simple;
	bh=4rdlP0nTwM1j9GZkgPlLuvN9K1I59CDnggPz0pqAh0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfupSitd7WXNYu+hkWmiBFDgygTgJjUWPz03JPKgKbZRLSh3IJ7RRapFXBzWC3tJAVlZ5g8yYDLpOHqRUBqByfD8R3V3XxXFfAzb38CRkmE9bgwRIYfBSY4DHXE0SmITJseBC1xh+il3pTiJNVHdCT4xV1YSObDjHg05nKsxxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AqyY3b0T; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AqyY3b0T"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234f17910d8so75289705ad.3
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751528990; x=1752133790; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rdlP0nTwM1j9GZkgPlLuvN9K1I59CDnggPz0pqAh0M=;
        b=AqyY3b0TW+zQZtio60N32rV5o/Un7ntPA3KtpQYUBs6VXFbmzJ2UL/Dmx9h05iRwzs
         awnEp6XyhEri2MACssjeUBb60WipOk5VT3n6Hztv5/mtTjef3xS0ndpsHjDtrV2XXV8J
         8VEXtvfS+ZESaWULI0uSNwb92ncYpoX9Vx0nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751528990; x=1752133790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rdlP0nTwM1j9GZkgPlLuvN9K1I59CDnggPz0pqAh0M=;
        b=IpY9F/2k+n4StBZOHXAG2eVmtKnlmi8QGaB7VNiAprsmORjPwGFyD/xrOoA5uBd86G
         2g5GjmtWAiQTifJB2JZ0NJVjFnb4+tzI25uAcw5TvE1feUKB2RobH0RaLfB5GcjanS1C
         ccTPV99B3lwVZBMOMcJxyV6UpUC1pvlcZlgMzAYxPoTNe5BsE2oxuEtLu9xLo6hSRLTQ
         mOHAzDSJ095HojrBF0SRaEiRFz9hWTOBhV5nIQ18E/orp0dYfqVxrTy3Z3qzRTZDkrtI
         uLHlqFeL5F+WqHjOsXBAIcHodnyUbzRl6mSGrQDhPmQu4jcct6JSAMsXVFB+ijfDiMZ3
         qgqg==
X-Forwarded-Encrypted: i=1; AJvYcCWv5bk5Vjs3i3Rs4gSsbZ/0kxauQYiOqL7wVzWsb1A/ZXMzLcFIAKm5Y5Eu8YJtXhEFiekpD2BGu9JWcig9Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJdMb0a4FuXdFNhn51J9+cpCuh19MfBRy2OykfbbPUMVKgLgpb
	sjj+7czLrYeaaAnxzVZXKmT/t5XNZmdMOUIiJQ3h1/qKS07rG1MRirA0Y8WlzY8udQ==
X-Gm-Gg: ASbGncuy3mG4lYJK3mGgECqioYI/N3/TMAZTZOxKj/Kcr3Ja2EpFpLmS+vd+DnfsX5r
	IgHdLFn0igFSsSti0TpPraKp3OZxqc34q3sRLjaaJTrbmeSL31uqp+oUj2Az53hiLlGZOfOjT5x
	iAWlQzY80471jeKoi4sFtZXGecW+7aZtTX0c7oKSp7Fnpc7NQO136i0dJ/X0ZbTa737kwQVdn/c
	b8RK00H9cgCKASNErSP/BwGw96/72PxSxYk6cITf/D/p1/olj2hk+s3FL3AV8x0d1fbW9L3UVGT
	L0Al265okly2+G0Bz2K1mqvW6k0gMV85DKK2LDkwVOWax9hSJAOFb0fYhYG1ArmoMg==
X-Google-Smtp-Source: AGHT+IEKxYsiAxh8kaPSjnmxQLTx3GgbE7KRESYB7LYtUj4r49YBA8q40hB+RM5u8/Kf7sPDiMHXFw==
X-Received: by 2002:a17:903:1b65:b0:235:f2d7:375e with SMTP id d9443c01a7336-23c79842f5cmr39376735ad.52.1751528990271;
        Thu, 03 Jul 2025 00:49:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8e3f:7c33:158f:349b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39ba83sm144377755ad.89.2025.07.03.00.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 00:49:49 -0700 (PDT)
Date: Thu, 3 Jul 2025 16:49:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Message-ID: <w2hhkx6nwgtk22bcyqm7drvozddwiumj6glixpyrrub7f4ivvf@3as22jquijyu>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
 <zmsay3nrpmjec5n7v44svfa7iwl6vklqan4dgjn4wpvsr5hqt7@cqfwdvhncgrg>
 <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>
 <ugm7j66msq2w2hd3jg3thsxd2mv7vudozal3nblnfemclvut64@yp7d6vgesath>
 <11de6ae0-d4ec-43d5-a82e-146d82f17fff@redhat.com>
 <5thkl2h5qan5gm7putqd4o6yn5ht2c5zeei5qbjoni677xr7po@kbfokuekiubj>
 <vscedd6m3cq73c5ggjjz6ndordivgeh4dmvzeok222bnderr5c@dujm4ndthtxb>
 <6a83e3e1-ab1d-409b-8395-df363321cade@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a83e3e1-ab1d-409b-8395-df363321cade@redhat.com>

On (25/07/03 09:45), David Hildenbrand wrote:
> Not sure if there is real value for that; given the review status, I assume
> this series won't take too long to be ready for upstream. Of course, if that
> is not the case we could try pulling them out.

Sounds good to me.
