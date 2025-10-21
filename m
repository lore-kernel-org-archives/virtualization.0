Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237B1F463E
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079413; cv=none; b=Gumf2KZbVYf6cW+ryM480P99EJw4oKyxk+94f3bFniP95YbcKTxgvOXB8xOgjlLIJjrHs/fzNLZjujetSuwsK/h+Q3dMU9iefo/4JlaHki2pu2WXL93eiQeyDfe+BHbU8QkcA6tMawW/LNmjra9364yCv4VlLN7zgLbci1vPUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079413; c=relaxed/simple;
	bh=eF1fACVfV6HLT5roiTx6wO7WHbA4YryGuaxzvCrw3KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nputClzFguGJP5nUN9wz075y7DRkVEpBSeyhFUQ6alcLFXfFVs2AypBocfgO3ZYOPHwX6Yw8wO6ymy5gaTuezQreJ93w//V48epSNnFjPuVOLHnTVbIi8FOhgvqbQheN7mO5fIwwZvkVdKr6Ciqm1n6O5NGQ5QXjWuQcXGwZyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrHfJ5Gi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrHfJ5Gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761079411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jca+iAluyvXYfcIcNG0HUymCKJQKka+3ZoKebkZZYlk=;
	b=MrHfJ5GiBUFm7KqFFr2U/9vMbz2qElSDeLF+RaXNERDjErmUR2olNmw2RDARgVli9n1AZB
	mh/Q74ssMqGfKUX8HL73OgTJhA7XLYaGsfzZtlsfqBB3eCFWeyq7L/phWaSNf7ombSaV5M
	3W4kKJjQHUMd30Eb2HGa4BuPWa/gL/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-ROFJioNqOJm90QGQDaMJ2Q-1; Tue, 21 Oct 2025 16:43:28 -0400
X-MC-Unique: ROFJioNqOJm90QGQDaMJ2Q-1
X-Mimecast-MFC-AGG-ID: ROFJioNqOJm90QGQDaMJ2Q_1761079407
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47114d373d5so56889015e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 13:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079407; x=1761684207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jca+iAluyvXYfcIcNG0HUymCKJQKka+3ZoKebkZZYlk=;
        b=t4SAle7vkjqnP7GwJCniTlIFu0Ow2qKoFTSRtstVMCa3I3Fq3i1+v4ktvIfBmoe/o6
         wAnDwvWQnbZhIPfon0pjuiumXa+Q3WppGvTyaZ6wE4N9vhS8wHcZZGoOF8RdXnH9Nup4
         BqriqEbzX/RSEAsx1E3xBQlcw1lGOMQlYzNSA77AiOuMoB4DhGBgiRKP6Ad6wlghvFiG
         Ionw9J71NeiTTGRtkfKz/G622yiuZ3PVfdSj9srh2gkOiXOMFEaBC71IkIp7NvCS8P3n
         VFGmZ/8Hpb51Mxb8D/xrnY/VzWuuT8c8N3dLdYjzQ1xojTU/csNDkqO5aA0UrQNBMpS4
         camA==
X-Forwarded-Encrypted: i=1; AJvYcCVRcruFNroY3bwWi0KbH3iGUgBUy3E1en5zbhOexzBlPU9Wkv4ptSnICSGgjoJPVmA87vSq0LvpxQr42zB4Wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMzKwasooAHt9jwh4MxSbCzezZDIx8uaNbw2X+f2zGNgmhmS74
	hNlOJnKz4OZR83wMsTHG1dvqvuirXeC6hnCiAPN45dnKXfOHRdoVctXimXPs/WorFCeQ/ccjRhy
	dNXiicWUAu7gvKOtYvvtlWe/97+vN81PdGKvw8DgxPm16iZH3C4WdhiTvGEF0jncFIcJL
X-Gm-Gg: ASbGnctJ5AToCVrUALQ9B6rgrifqVbVaLJiRills2TtN/aNNthYNm1irhoRZag6m0HT
	v1o9s7F0UF4L2VowY6y6IE43Z/vbLKfU4vGjqZDeEPP/fDYihk2Ed/gnrv0Dde1YjCq03bpI0O2
	5Z+HGLCwzTMWcM1gQoh2rMcv5pyZIb0rNMpuwYwfwUjCQtnOLnhYA1ixOwQPmo2fFfoCEWaCqrm
	IzkGJ3bI3BLMr1tJZpNBm11+TpKvXqD90rkflxOde/ANnSPJUhrE6pVlNRYY8k38oieckKhfpL2
	YXuHB1qmsAZAGd3Vk5VL1LBwkPAJd4a+Qj3rhj9KBOMhPs5z7JB+jehyIRkibrGz6ZUJ
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4711791c5dfmr155489205e9.30.1761079407242;
        Tue, 21 Oct 2025 13:43:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3tqHiyIT27d9/w9pV3Cihx1kc1ZDJQnIJKiIuWuTpURVwED00bfMi5FBVB40yx0uQLffj0A==
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4711791c5dfmr155488865e9.30.1761079406669;
        Tue, 21 Oct 2025 13:43:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c429e82dsm9612815e9.11.2025.10.21.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:43:26 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:43:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 03/23] powerpc/pseries/cmm: remove
 cmm_balloon_compaction_init()
Message-ID: <20251021164220-mutt-send-email-mst@kernel.org>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251021125929.377194-4-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MAjX21LJWQGvHkFDzcmItMj4rpsnG2g8CYxyXZERJS4_1761079407
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 02:59:08PM +0200, David Hildenbrand wrote:
> Now that there is not a lot of logic left, let's just inline setting up
> the migration function.
> 
> To avoid #ifdef in the caller we can instead use IS_ENABLED() and make
> the compiler happy by only providing the function declaration.
> 
> Now that the function is gone, drop the "out_balloon_compaction" label.
> Note that before commit 68f2736a8583 ("mm: Convert all PageMovable users
> to movable_operations"), now not anymore.

What does this sentence mean?

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/cmm.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 310dab4bc8679..67c7309c36147 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -548,15 +548,9 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>  
>  	return 0;
>  }
> -
> -static void cmm_balloon_compaction_init(void)
> -{
> -	b_dev_info.migratepage = cmm_migratepage;
> -}
>  #else /* CONFIG_BALLOON_COMPACTION */
> -static void cmm_balloon_compaction_init(void)
> -{
> -}
> +int cmm_migratepage(struct balloon_dev_info *b_dev_info, struct page *newpage,
> +		    struct page *page, enum migrate_mode mode);
>  #endif /* CONFIG_BALLOON_COMPACTION */
>  
>  /**
> @@ -573,11 +567,12 @@ static int cmm_init(void)
>  		return -EOPNOTSUPP;
>  
>  	balloon_devinfo_init(&b_dev_info);
> -	cmm_balloon_compaction_init();
> +	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
> +		b_dev_info.migratepage = cmm_migratepage;
>  
>  	rc = register_oom_notifier(&cmm_oom_nb);
>  	if (rc < 0)
> -		goto out_balloon_compaction;
> +		return rc;
>  
>  	if ((rc = register_reboot_notifier(&cmm_reboot_nb)))
>  		goto out_oom_notifier;
> @@ -606,7 +601,6 @@ static int cmm_init(void)
>  	unregister_reboot_notifier(&cmm_reboot_nb);
>  out_oom_notifier:
>  	unregister_oom_notifier(&cmm_oom_nb);
> -out_balloon_compaction:
>  	return rc;
>  }
>  
> -- 
> 2.51.0

