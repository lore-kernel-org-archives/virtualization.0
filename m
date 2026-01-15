Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8A42049
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496029; cv=none; b=Frxxt601tXWGdD20wzuEyTaat1AJwAigXGaCznXj2Rnxrn2ErXzvDrtU+2V00l/1jBrtNj08z9wPoE6ND0LLhMpU+MF08Bem3UgHkEh3/DHP5rdcpYpx8Sb/wzZvCw8/Xp9KzdoCtRToEXPMfld54BMrHBIhHz+PDL6lPzG+Ncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496029; c=relaxed/simple;
	bh=V54PrZBvUZY0PjY3cU1uOI/0T7/YH8EFTu5s2qL0YK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dpz38pHpSRuylBRE3jgWuOvdudv4ABL9/9QV8y0B6MnLSqtKKgSmheP3qcFTtzwwdlHNw4hlS/tx0UPOPizWo8pbEV0k79L+SUd4PCqFSOLNc03XOg2kWk50Vyyc/A7WvtLMn8D9Zt6wJaucBEUP0dfD22s3qISiaz/sB/loQRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jh+3YafA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jh+3YafA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768496026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5su/nAHmwHcmkA811BDe3v/5JJsozj0l7oyd1uJGuPg=;
	b=Jh+3YafArW+CCsVuXIOQ9BsYxgScd3P5Cf9sqpUa/reaECAbjn6Cuazr+bP+7xib6DlVs1
	zgtHrtjOQFFk/VWZi8htiWABCBOxv5lXnGc0k61QV9VLugFT5MgTuIOUSZk+/8ui+1eetp
	nh+DusbFQQ+OoJ24l0Ff4+6a+yGSUIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-s2qw33h_Niq9qogtIPPkJQ-1; Thu, 15 Jan 2026 11:53:45 -0500
X-MC-Unique: s2qw33h_Niq9qogtIPPkJQ-1
X-Mimecast-MFC-AGG-ID: s2qw33h_Niq9qogtIPPkJQ_1768496024
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4801c1056c7so5546395e9.2
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768496024; x=1769100824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5su/nAHmwHcmkA811BDe3v/5JJsozj0l7oyd1uJGuPg=;
        b=Dmy+/jM2LK/MoWXe+NaeRrhhBbPRdQ0lUdbn4suWigDROM2s99VwUy1lgbrnvdNYcN
         PvIIoZdJ+HchT4bIMTFhtxWDKUgOs6dDFp95u3EKMtN6kSJZzMzKYJDmPMmlZPr7Tcjr
         kz3dFSHFlfTmxLD6SK/POc6rE9MzcJEu3XZVXpMzVvsq9loyz84Q+amp5CdEUmLSuCII
         MSPs0WJ02IqVUBFh5gMn3ASfF85qDELILA1knFeJybWVjM7GZdU7uNU89PwNF8ulYp0r
         s+XxjGuZcfiWl7NLZaLyDsBu/10QVkqe+smUCW+IFfLgGrGHQ+nY2RekJUbhOIrWyPYa
         fL7A==
X-Forwarded-Encrypted: i=1; AJvYcCWbb4pP5VluLPJvm6QXdbIJhrNR8AeYHPhH/PMEz/AWtJ8ut10Sy18bzCKdewwwxbJTBjdHx06UlUJ3beyvbg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxx9GTquW5ur19aopjuCw+vCJXqFCfymbdkNqpjH3jXnOTqsw+s
	/zqJEQu6q2jw+5xSeA2oo3wDkG9CCquypdtntLzbVTTsqRSiMvhmxfBlrHkYjJVwmx+xuA9OJ7D
	CocFSY6aqkuUWncty6mgl4TQiFE4ww4CyjJRVjb+HDSkXo+D+BoousE+BP8GsOFTf3zLe
X-Gm-Gg: AY/fxX4SEHi++UKkn85wRhtcT/h5TWP8dQUkviL3LX27EPXuD/mAo3ht+oCUH4Njml0
	nClKqnBTKNqWUUVUFXErf7fcaRK4+rTxrYDbgyy34uNA9WzXNUUBkCRAQyo0zAaVTIUelkhYuZf
	Kl8fMcuvIvPaT/wRJWhNRtdg1XjrYCXwcfb6/u34iqHwXVck57/RyRC5hQiNYaxPlWrpOTYO8Rc
	+YsQA7jozfEEwk8ZkXINyjv/t/W3UtlT2Ex9bPfJYLRAvWa0zLxBugkOHhQevmSfFlAjyDuXwEW
	DGRKKZVbvRbnanZupzLM2SWCgF6AyAfJ9FDoRG6GHcbU569890MjFvCvUtRCDRRlUDVd2fPqrUd
	x0ERK/CFXNNo7XGExldezHpWWCFWdDw==
X-Received: by 2002:a05:600c:5487:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-4801e30d482mr5165645e9.13.1768496024093;
        Thu, 15 Jan 2026 08:53:44 -0800 (PST)
X-Received: by 2002:a05:600c:5487:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-4801e30d482mr5165105e9.13.1768496023585;
        Thu, 15 Jan 2026 08:53:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992681esm58497f8f.11.2026.01.15.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 08:53:42 -0800 (PST)
Date: Thu, 15 Jan 2026 11:53:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
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
Subject: Re: [PATCH v2 22/23] mm: rename CONFIG_MEMORY_BALLOON ->
 CONFIG_BALLOON
Message-ID: <20260115115228-mutt-send-email-mst@kernel.org>
References: <20260115092015.3928975-1-david@kernel.org>
 <20260115092015.3928975-23-david@kernel.org>
 <219f7be4-8355-4376-bf97-3410c6e23867@lucifer.local>
 <37fdb994-59d1-4196-b377-f3f749148b19@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <37fdb994-59d1-4196-b377-f3f749148b19@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TodwXxfKALBv-5UUE_ctLz5pvAdLqyCth2xxDw_rLXI_1768496024
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2026 at 05:33:56PM +0100, David Hildenbrand (Red Hat) wrote:
> I'll note that the spec also defines a "DEVICE ID of Virtio Cpu balloon device as 47". But
> no changes really happened in the spec with that for the last two years (only the
> id is reserved).
> 
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-4260001


Maybe that's a good reason to keep calling it "memory balloon".

And hey, there's also the floating, pops easily kind and maybe someone
will use those with linux in some way :)


> -- 
> Cheers
> 
> David

