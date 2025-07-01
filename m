Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87416277C81
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386801; cv=none; b=mqiemKm9Ym8q8iWkIJu6N8QfxcFIf1FcqraYDrpi8LCb7LOCzxsZ+tDglzMyfKZD9p/kja76EKuBnwkV9S55iV1aRW2K2udNKLdWYGhOggP+0TtpS85+UiGuNQWC98cSLtKcZ7YqFzaEoaBXIwsyx6XgLTAaZKS3C/twDyHFpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386801; c=relaxed/simple;
	bh=zERKkaBVA01QeEEJAAMKNa1asJWSr/jVIILAqrrIZ60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OerSBVopfBWk4d5fn6sCRJKTlVHAre90qWZhocZo0iKFGl7UQijd2js2JqoXRIqbY8NocEqYSCel0jgMsmc4bd5oY9RKT9kpC/wkzlUF/9Jub4glrPj6nj6mYFxEAx2t/3+BiipgIgBoyJBuRQvnL4X4BGz/civkKsKP2csyruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dd1ebYip; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dd1ebYip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751386798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=prvx9QgvrkS6/HrNRjUGuyIwIbKu9TUrg+VFzDZXD4A=;
	b=Dd1ebYipm7MxI0ZmIl0Rt6OV+fUPOudy171geNiT7cqNAGvvob3hT/zjSWfy3BCdvE3rpR
	JUlMupFQHKG9nobAk0sAszW9CIbArYje2Pbke8rmBbmVB3MZs6Q9qQQRKBfc5raUgIH3VQ
	nF5/EjBgV2O7ZACIn1fxZBCUKv92zmE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-9KCkFC3sNk6ngd5t2BUAMA-1; Tue, 01 Jul 2025 12:19:43 -0400
X-MC-Unique: 9KCkFC3sNk6ngd5t2BUAMA-1
X-Mimecast-MFC-AGG-ID: 9KCkFC3sNk6ngd5t2BUAMA_1751386783
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451deff247cso32666115e9.1
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 09:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386782; x=1751991582;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=prvx9QgvrkS6/HrNRjUGuyIwIbKu9TUrg+VFzDZXD4A=;
        b=cxQtQz4g7RlJgK11P7k/idqzEz766bnSanUcVrk2sY3WKkNVqJMQDmHy/YCQYw5nUO
         pZd4T980S1FCG8IBZ5bf4WQqgOSf0UaYIbmxIfUhTrkI9ZsLujoCyybq/wVRU2dWm6RQ
         pFks0cFUTDeRhtp9QWpusugRdtSBbOFrPdW6j8YE7H19l80c065I15o/2+MttbuyGse3
         jy/zsWPgEUbtBAm96wNb2fGbKQcMSNdW9i5qyqtT8mpOlmbQ75ICM32MffNVztcx1aKb
         gMS3BCkzJEQtefcu8r14fAhbrftSrEPjkiYJKTb9x45wfbA3Bgav0I5p/uxbpmZpn9LV
         NOww==
X-Forwarded-Encrypted: i=1; AJvYcCUVN8piZIUlxzMR19Djv4ohkF4PHZCgJg6CQcTETbT5f7ZRFSiozJzNOgrIdLaOdxxls/49nFLOTpbaSx+k7g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1f4VIdNnYh74Ayk/gGqY1CHVDB+G4Z9uQ9Vtsuj7p4yjotRbA
	VNd2B8vDcVyHk58gi4cI4NJOe35QL8mnLCE/2IKONw7w8b4qqRWqO3nxDiCblyN9Qqsw9sRpMGG
	0yZBrxlk6iolz4M22vcXnVDBb0QhdqJWiKpZqFuxTszNh0jv6uS/Mc0Pl7dOMhQnCY8o4
X-Gm-Gg: ASbGncvAYNLU0oA/uAs2ldFNhdLD4jYzr67SWNVAUwpjTqcWo9mO0mvofacGtAXT21U
	c+fnuTk29YvNZhk75DvJnut4WSEZrHYpODEJrF5Gcq9JMTb4YJS3SeK8s+1O2ACz369+8KL+Rwb
	3AHn8zaEYqksNdip4Yh2DiucjLfOfukNM/gZtp7kP5JnbXkZRYnxFYq+vnaZVRtd0N5H9ew5Cvp
	sDItG67PWQig7bI33nSpUIIgtxcYJOUdTF6CvVJmK3oWcD1n34TyCd1lyvC9VEsbC5Rs36ShQM0
	LJAa46l9m+9XencA33lkT398ErfEEBiWLLUgtFJabAH8RTwbAYa3sTqzYxhTYXO2FMrIn44EWaa
	9spC9MmEXETYL4IGtpobAESawWc2WNP0ye/qIl0dkNMPHhAPq9w==
X-Received: by 2002:a05:6000:643:b0:3a6:d95e:f37c with SMTP id ffacd0b85a97d-3afa162e3eamr2592086f8f.2.1751386782477;
        Tue, 01 Jul 2025 09:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLsheDAzVmPxelDGtXmBLJTIToWVZUdt5kz1Su7UknmC/bZ3D/wqAcBB9bZnWbrfYyDqyy5w==
X-Received: by 2002:a05:6000:643:b0:3a6:d95e:f37c with SMTP id ffacd0b85a97d-3afa162e3eamr2592019f8f.2.1751386781923;
        Tue, 01 Jul 2025 09:19:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52c8esm13813942f8f.55.2025.07.01.09.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:19:41 -0700 (PDT)
Message-ID: <b2e65056-bb64-4a50-91b8-3db2d94dcc78@redhat.com>
Date: Tue, 1 Jul 2025 18:19:38 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 21/29] mm: rename PG_isolated to
 PG_movable_ops_isolated
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-22-david@redhat.com>
 <443de491-4ade-45f3-9c9b-b4428b0f0aaa@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <443de491-4ade-45f3-9c9b-b4428b0f0aaa@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C6Toe-WFNYL2mbgK2xJX__-iGeTBQQn1nYMtaRwX67c_1751386783
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>   PAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
>> +/*
>> + * A movable_ops page has this flag set while it is isolated for migration.
>> + * This flag primarily protects against concurrent migration attempts.
>> + *
>> + * Once migration ended (success or failure), the flag is cleared. The
>> + * flag is managed by the migration core.
>> + */
>> +PAGEFLAG(MovableOpsIsolated, movable_ops_isolated, PF_NO_TAIL);
>>   #else
>>   PAGEFLAG_FALSE(MovableOps, movable_ops);
>> +PAGEFLAG_FALSE(MovableOpsIsolated, movable_ops_isolated);
>>   #endif
> 
> Nit, but maybe worth sticking /* CONFIG_MIGRATION */ on else and endif? Not a
> huge block so maybe not massively important but just a thought!

Sure, why not (goes into the introducing patch) :)


-- 
Cheers,

David / dhildenb

