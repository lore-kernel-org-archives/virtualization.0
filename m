Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148DC2AF11
	for <virtualization@lists.linux.dev>; Thu, 19 Jun 2025 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301143; cv=none; b=nQAfKJeulUiBNEt6gL3j+lKwCrEM/HH9fKJa2fSvqWWeuMkTttRcXijYAZkxoWSV+Sch1giT/HAESiULsrurkE6NggTu3z8U/ZgjfPN4vJVrjE3m8tk4jIeWccV30+0xObyXBBs2vCb9l5TNAzdjZYqm6wpM75at7xLkHLnarz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301143; c=relaxed/simple;
	bh=yN5IRTf2bp0DFPhQIni3wnaPsQ3d+S++8/d0mRCJUJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAHtDrT/BAxLxuethEf6FZ+Vw/kEQFm+fEQ6oKV2XR7TWVFb7nL5wBqwf9xnbQRTwgpnEPg4GnsklAZvaXZ0c8pFyQ4PIvOgzyskefEMZM0GmTYZN9FlozQNtQkL/xBl/5HZT8YqNGy7nNMexQHD5rmI/o+HNBfu8NPFm9LTyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YgPhGSzS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YgPhGSzS"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31cd61b2a9so235510a12.3
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750301141; x=1750905941; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVwsh/DCfF7Xz7iwx0RMWfoA+1QEfSvNmteXgwq8Uto=;
        b=YgPhGSzSRDuFxMCoQr9vvXd6vEnO0dBl67DtAp8qTsJ0lVcraCjQhmeesD9FEK6vXB
         hIVG6B9wiMefRsBVSRCEfXRbe+0isUZqKR8le3juMAoygnzTxuHrCaoC9abshjBg7XZV
         NyuBewt+qvpuYaYMIjOo2bX4L1uDmmWguOH6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750301141; x=1750905941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVwsh/DCfF7Xz7iwx0RMWfoA+1QEfSvNmteXgwq8Uto=;
        b=C+oQ3nsDRGytmR+sutkQ5BTK+v+d3BJoQxVnIrpHoi7oV9R2zKiqQKYh1GoUPTnC6U
         iskhxeZOij9F3S8eFHHM9GrJOKErw0inbTH29LF8bNiSYV23wO8Fvz5Mo6/Vep9R+D6j
         PtIYFglGotqX4lfuCVY2vqwETDEIIg/7QJS+wUb/fE53sPIeB9OacXtK0oBYa3RekwQn
         WoXMsjuJ2eP9wY/aHgddOW+FiWEqSrvv0o5FCYNXeqcxEAcEAY5MQ/O8pBYShHOFz84a
         y7IItJ9wdnVdwdN/0ZkCFnRuxvJuX/TV9a9viLn035wC8ICiq9S3xU1pu+Zv+X6fFOy/
         KXOg==
X-Forwarded-Encrypted: i=1; AJvYcCV2KD8+rHXZ8dhrNWOLNCyyCnvbq9qtjF3zsP/3+Qz7shirszNbVifbNNOUNEq0ewJxKYzof2iOof97/KKf/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFLsPVrsd1v7nFNz1TY66MJbMt9OdqgzWreOuubDKYj2QaqkmQ
	f3icFbLWrmCFkRJlYkCF8cvcHVQCun9kQIlyxlsSJ1J1AVcEXAoy6xeVoyssMVfm1g==
X-Gm-Gg: ASbGncshz6hYadd297QIDjxNQ9PnZbhFY2lS0ELqTzvzL2oQHXdR95DvT+J3GNI7G09
	D4ErQNwrtalN56dRXN6uVsUFscoojTUr6ueiSic3nWBa1kYPAtbwB1bgdbawuULISMpdFcuA5aX
	iTJJ4WhaHc8/KflDgfpm/XKf41fMVkatwfVir8qxy4Lm3V6aYmrVc21Md0F+gAC1YXhlfULwVLd
	6S+By5j2UasMKVigOAeZV99alATHMtpLIxFN1kquwdFf6CSvMyde/px2Raw9klkGxfIsvv9aWEf
	gq564xFLoeYrrMRPRASUfCJeABJMmT6NkcvtsdalnDuOrvdin5bARTiLtApJlb/yKQ==
X-Google-Smtp-Source: AGHT+IEIhSKyAh/a5UXDnIfIZx40q+8DWj3yxUrqA8zj6603W5pJSAuRQjAc6FIffxONFpmzBXMSlQ==
X-Received: by 2002:a17:902:e747:b0:234:d292:be8f with SMTP id d9443c01a7336-2366b32e55bmr310856115ad.1.1750301141373;
        Wed, 18 Jun 2025 19:45:41 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cb6:ce70:9b77:ed3b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a226ddcsm876010a91.1.2025.06.18.19.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:45:41 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:45:29 +0900
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
Subject: Re: [PATCH RFC 06/29] mm/zsmalloc: make PageZsmalloc() sticky
Message-ID: <5qkfuuar3csonfv3a6nj5ikl3ghebqassnnfw24xj7rjwx77fg@cglr2plhwvfs>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618174014.1168640-7-david@redhat.com>

On (25/06/18 19:39), David Hildenbrand wrote:
> Let the buddy handle clearing the type.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
