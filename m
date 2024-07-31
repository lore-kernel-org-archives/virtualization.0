Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5816D4EF
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421310; cv=none; b=fZTbOwVZ2xkA1gHLUd9IImYr1EKZE/TgpSuTadOH1idKHw8MPleZ7+h3n6NRptEQOmfFUDEBGPyjbDRIyCKKoQhLyzxS1RQar9y+W5O/RnTNc2AbBi7xlFc6zORvBoiLIIuaPTKFl2SFZElD8KE10MX7Le8X/fFFPW4J/iSo3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421310; c=relaxed/simple;
	bh=QduR4BXgZwuHSsijt4j0iA5UYFKaczuVbZ782y51PC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF9X4FAgUIRGPuojAFk3wiZKDAz+zi5MnwFvdmwqH6tBnlF8J9xYBtDg7IDy4O1sAyOWBypEWMOVSEViC85T9IZDsleVptfFSveL/En/lKbQVLywSgdZXWg4rhNynP4BH+iKMLUqHT20Qw7AcsfpoTQ7HJxmEkvg5nHSqIRfQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46VAKTFt011177;
	Wed, 31 Jul 2024 19:20:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Wed, 31 Jul 2024 19:20:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46VAKT5Z011173
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 31 Jul 2024 19:20:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a7276007-7567-4f8b-a9c8-e491e571c80f@I-love.SAKURA.ne.jp>
Date: Wed, 31 Jul 2024 19:20:28 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>, Jason Wang <jasowang@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
        cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
        iamjoonsoo.kim@lge.com, lstoakes@gmail.com, mhocko@suse.com,
        penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
        torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
        vbabka@suse.cz, virtualization@lists.linux.dev,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>
References: <20240731000155.109583-1-21cnbao@gmail.com>
 <20240731000155.109583-2-21cnbao@gmail.com>
 <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
 <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com>
 <CACGkMEuzYXp51h2tPk29HKhvSfgsC5WSYtGt==SVMDU-0YSPEg@mail.gmail.com>
 <CAGsJ_4z+-XdAEt+XrxGTnoB4PnimKXhg0JciiwPST-OQYit+-g@mail.gmail.com>
 <CACGkMEvnfFVWWd9++BkZu=7iL8+yo71Fr=R00sTJ+pZUbKbiXw@mail.gmail.com>
 <CAGsJ_4w9UrgBR9gs-J74036JBXaod2OE0WOtPiMYyw+ov7VcHQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAGsJ_4w9UrgBR9gs-J74036JBXaod2OE0WOtPiMYyw+ov7VcHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/31 14:05, Barry Song wrote:
> Jason,
> Thank you very much. Also, Tetsuo reminded me that kmalloc_array() might be
> problematic if the count is too large:
>  pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL);

If "count" is guaranteed to be count <= 16, this might be tolerable.

Consider a situation where current thread was chosen as an global OOM victim.
Trying to allocate "count" pages using

	for (i = 0; i < count; i++)
		pages[i] = alloc_page(GFP_KERNEL | __GFP_NOFAIL);

is not good.

> 
> You might want to consider using vmalloc_array() or kvmalloc_array() instead
> when you send a new version.

There is a limitation at https://elixir.bootlin.com/linux/v6.11-rc1/source/mm/page_alloc.c#L3033
that you must satisfy count <= PAGE_SIZE * 2 / sizeof(*pages) if you use __GFP_NOFAIL.

But as already explained above, allocating 1024 pages (assuming PAGE_SIZE is 4096 and
pointer size is 8) when current thread was chosen as an OOM victim is not recommended.
You should implement proper error handling instead of using __GFP_NOFAIL if count can
become large.

