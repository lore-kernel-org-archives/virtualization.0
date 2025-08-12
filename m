Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC12DA779
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971122; cv=none; b=O3+4SK8eEE4/7VWv26RBm9bttS1M+emJoYjGZ+crgb5JIozdkd8JJSqFfZ4HaBRdt+zOJAnHutij3PMQrVgpczsfkW4KOxeiUbi+4M77Fw6/8BLlqFaTEBNAX6EE26F6v4pmtLoLd622wCXV3zJMSZkgj/aHaSQXnfNY+dZykQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971122; c=relaxed/simple;
	bh=QDW6PgcfQGmvnuZamnjvlDuDj/nN6/r+CzeVaCn9PhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQY9vzykcSYtKT2dS21j0zz/x1ThmUEnoEfUbvXwZclT+8Yywpd5y0g3wRh/HXeADcwqebKm0xhh0etid8r8k7evT26C73gMBaj59KbLqY+KXLbqi7E9ElxplIFo6VxQ8CS6x0iKavU3/yd1/+ZD/iXGTe+6pgjt991PsVYgjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TTzDc4E5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TTzDc4E5"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32106b0930eso5270098a91.0
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754971121; x=1755575921; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsF4i7owr2w64jophO+zO+eW0GN81ddWs4iypkKqJ00=;
        b=TTzDc4E5We6TfVPUS/7KF14tyRc0dYMk9rKRuFhEeQM5AebnMtH4hZXpPAl6V6EPHe
         Co2dDHrzjX3VJWv0TOYmfcovnnweVxWqbmOXKN1prybyZ1huIEPsSetRBmAtTfOTZKQD
         tgNEFvaSMRYBuLuMCadRspaJyLUf75SQDPZfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754971121; x=1755575921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsF4i7owr2w64jophO+zO+eW0GN81ddWs4iypkKqJ00=;
        b=JQ8u5XU2lakwyHo9fCVnWr3T834enxcBjH+DmtMICSCbEN85QGD4w5/rnYr42JepmQ
         VUUKv1gGrQCyMfy5lFK26sP0oWH9np35ZTGaMucIFwdqEdOvM0FZyrJC30Xz6ZtCzwQ3
         qRS9JCLFvVVw7f2J7I8yvEwAJyl/39iVoAoXtfnciVduNyWBM+vJN0aX5zgkivg4nmIN
         eWnyjHjkvzR1BFX649ovbIGo8thyIUGD1P/G5/ujVjOME9CWveweQW+QaAIB4Bar55Zb
         XJStTsIvkWjpiRQoJYN+al+9Hf66twjwpPICMft5bcQm7pFXw0V3DOACpQc1ET0TklQx
         ZXYA==
X-Forwarded-Encrypted: i=1; AJvYcCUTgriidxebVM/jQo1F35IW0B4jNMpNRLKDUyWGEXrL58Tr/Cc9bDdzH2uLZbzUBzZJKBALtGdbnqV7KrjSNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxN9LpVqsKKFsDNyqYHRxejl79JYZJexmSDQitnP4GB0knJXRnM
	JNOSAaiHidVLTPvM0CxixkC0oBu5EWxlIfgW9L7hgBf5z/avEyWDoswz+z3aFL3+jg==
X-Gm-Gg: ASbGncuph8W4jXsXp43xUjuKI+rQdwLpYWg0w2UW7dGZKlYfqP6nMAC8o8H/yqqmam/
	WPIuXlP8M5JJU/t4sAF6RPEWC/C8WtMZQQUtrG00AqzsMGw+zGiffTq73O0s8E0XYBeib1KoKq2
	STqcseEFOsrK59rrzBE0GKLxnYGwNOL2GfmEFDOjPRNJv/800obwveYOnqMfNkAh4uMt90LvDHk
	gGP9Kgk/c2DFmu2IRSEIQk/WSZ7xoeYolrQEdtgyGPBR517hfNAjT1qQmjbnlEzXZdxcHUQaQGn
	ieLEca1KR4erss8o2tvx+E0VW7AJFIMvwNdcDS8b9qjysnRavNZOtaVvEfm9nc893UlIFk4LjA+
	jVjmic1Fj0MIm3MIsPq2G8w6p/kWjKJwFsrOa
X-Google-Smtp-Source: AGHT+IE0YyrVY5Vt8OKrl33IrgQwBQBekiXEdcW95C5mTt17WuM8Sondsrrkn0NdMV5pujBh12Fm4w==
X-Received: by 2002:a17:90b:2251:b0:31f:1a3e:fe31 with SMTP id 98e67ed59e1d1-321c0a11aa9mr3103600a91.11.1754971120678;
        Mon, 11 Aug 2025 20:58:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e529:c59e:30f9:11d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611d846esm16436888a91.8.2025.08.11.20.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:58:40 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:58:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Dave Kleikamp <shaggy@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 2/2] treewide: remove MIGRATEPAGE_SUCCESS
Message-ID: <lky6lmpq5hsflc4rcs2hev5i3gctvbrppysttnzo22r6oiryw4@edfre7sprwk5>
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811143949.1117439-3-david@redhat.com>

On (25/08/11 16:39), David Hildenbrand wrote:
> At this point MIGRATEPAGE_SUCCESS is misnamed for all folio users,
> and now that we remove MIGRATEPAGE_UNMAP, it's really the only "success"
> return value that the code uses and expects.
> 
> Let's just get rid of MIGRATEPAGE_SUCCESS completely and just use "0"
> for success.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

FWIW,
Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org> [zsmalloc]
