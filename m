Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF11684BE
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495858; cv=none; b=LHtNSJUUAas6hnrzwBAOAR1VUKsz+2bJygllnW2zR6c+U5WjoyQ0skGFFVicddOgd3QxL5oxuzcqKIktSm+EW9rFZ8QSAjjyMN8wdCxTqleuW4KHarPnehXYcQ0ABBC7HlEv0aF4Or/0C5SQA+HQvFL+RXQh5RpVcvqoAO8yoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495858; c=relaxed/simple;
	bh=0bAHEY7ff2Q8E5C6vXUVAPLo5jv8Vnp2PPLiRrb00mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ltuLy6CCFubglnlCzCyjqnpGiNE8YlrmOy/RF6IkGtX8jJDIPYOJ62gMfBSNBMorahls/qgjfMe22op91PQct6YgAxRPuW92r2VlqniFjEZsau+tbqPKm58xJ1uKdBfcD/WtWBN5B2FUQHOYuw4M77kO/JUYCPEqpwl5RS2LNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbIoOOAX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbIoOOAX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768495855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SljNJ9ya7guEeZDCesmPS6qTlCZIDBdh9EBAuJaiH00=;
	b=EbIoOOAXqZCoNaTl1R3mE/eL/2NoYooj15JxVZ08ls3ycbqMyx1yr4NuhFcv5Y+BC9ybk7
	Xa35qzXorhcyognZdNj86kH13ecNXXDqGvVjkuE74ZjMlvSREJnbRjoS/DWpLdhwZaM+3P
	w2n/nSePQItE3SLfhTb4C4WGZuO+pZE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Tcx6GXmhP5G-VB8RnHAdVA-1; Thu, 15 Jan 2026 11:50:54 -0500
X-MC-Unique: Tcx6GXmhP5G-VB8RnHAdVA-1
X-Mimecast-MFC-AGG-ID: Tcx6GXmhP5G-VB8RnHAdVA_1768495853
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so12594215e9.0
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768495853; x=1769100653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SljNJ9ya7guEeZDCesmPS6qTlCZIDBdh9EBAuJaiH00=;
        b=Ruia5Vw3DO4ZLq7hzLN70DbKT7t1bhif8mKOHAu8rwSI5Tig34LHhDlT/a7X5ODWsO
         fG/hZJdLKlAv7lv6a6kdlAL/RQ3twaUOf4XkcFkjaxY0Qgr+j5ACyHTctNUt0BwS3FkZ
         OTaiMA4khKAey5WihCHqR2YcHP1uZPIYQqo/vL2KJE9WuSNIz6nBFef60mge2K8wH1kI
         VyA8ZxtKmgQ/z0JwKQB/LNQNzxpnjWZzUjjejDHCulew6qBSGrJumze0Qo068kUXf5VG
         jkQMn1OCjCIgsYEkIiMF1q39DQh+lGmjUTAZyAQaM1leberxC7aQzBjQbXB77SvepEnH
         sCfw==
X-Forwarded-Encrypted: i=1; AJvYcCUDQW2DuX11QgWdHQG2isLxRGp8CuQhSYoP1OOaaoOBKhDxHlQo7Sx7Nd6GJjFd38J5FuRJUjI2s5Ae7l3jnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBVosjgMw3rO+dVp1KQy87RhZpzFtq9DNdUk2RKuO6j4bQZI2/
	nJUVTUgM05UrC46Of7MpSzcrPPygyqQ9VMsooSCMP3espCWAzVjHkJWHB12xo8w7wm5Yf49fXcx
	jhEGl4Nr94oJ6Nr4nXNI91IAPgRW+v9yeShsxX1kGf0PIzxvf7J81e27gglEsuPFdxPmH
X-Gm-Gg: AY/fxX54u02NtXZrbpruWl24MEoKanaFS77S3wy9RYKnLLvH2Nh7YxSMtjoUCFyZsF/
	acN3bkOf9fO9nEA6mHLYMGTDgYNkU4fUYw+NR3XoV0k0rbhe0UMWOT8WmQE8u2rTb9gIztue+Z6
	6LJnAe6LPfeVgib4Wl5yuF+KKQDDq/yBMgW90n5CZ5RMuhEyftofzkMdDXOG9Fae/dcXzYTA4Ez
	haMyaekO9/xs5CZnVA4f9tFe6QMigSB52rs2mjQawdS92/uJvWD9clpAOzInkQOFN+Y8v2HF6tB
	wXKDseCqgOuzlvNpu1uy/Jv7eMx9iPxEuCDrlW6wXj1ljhCHcc3eFODpa+BITWCz54R1SjyKfsi
	8j15WbhgtVSoZ/W7PhQJT1C27eJXUdw==
X-Received: by 2002:a05:600c:45d5:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-4801e30aecbmr4637405e9.13.1768495853201;
        Thu, 15 Jan 2026 08:50:53 -0800 (PST)
X-Received: by 2002:a05:600c:45d5:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-4801e30aecbmr4636905e9.13.1768495852632;
        Thu, 15 Jan 2026 08:50:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b7aasm57337815e9.2.2026.01.15.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 08:50:51 -0800 (PST)
Date: Thu, 15 Jan 2026 11:50:47 -0500
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
Message-ID: <20260115114849-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: ft70s2pLkHfA-IRnXjh-AdQi_ZAno-SHnr8Pbkfg_D0_1768495853
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2026 at 05:33:56PM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/15/26 14:55, Lorenzo Stoakes wrote:
> > On Thu, Jan 15, 2026 at 10:20:12AM +0100, David Hildenbrand (Red Hat) wrote:
> > > Let's make it consistent with the naming of the files but also with the
> > > naming of CONFIG_BALLOON_MIGRATION.
> > > 
> > > While at it, add a "/* CONFIG_BALLOON */".
> > 
> > Probably not relevant but cheap for me to share :) so grepped for
> > 'memory_balloon' and saw:
> > 
> > include/uapi/linux/virtio_ids.h
> > 44:#define VIRTIO_ID_MEMORY_BALLOON	13 /* virtio memory balloon */
> > 
> > This maybe relevant (I guess this isn't actually used anywhere?) though
> > interesting there is also VIRTIO_ID_BALLOON... hmm :)
> 
> Yeah, we want to leave the virtio stuff alone.
> 
> Now you'll learn something you probably wish you wouldn't know:
> 
> As you spotted, there is
> 
> 	#define VIRTIO_ID_BALLOON               5 /* virtio balloon */
> 
> And
> 
> 	#define VIRTIO_ID_MEMORY_BALLOON        13 /* virtio memory balloon */
> 
> 
> The virtio-spec [1] defines ID 5 to be the "Traditional Memory Balloon Device".
> 
> And in there, we document that
> 
> "This is the traditional balloon device. The device number 13 is reserved for
> a new memory balloon interface, with different semantics, which is expected
> in a future version of the standard. "
> 
> That's in the spec already like, forever. Likely, at some point someone wanted to implement a
> new version (for whatever reason) and defined ID 13. But that never happened.

yea Rusty wanted to do that. balloon has lots of weird bugs like it does
not really works with large guests. We really need to get around to
fixing this, and maybe it's cleaner to do that with a new ID
than trying and failing to use the old one, was the thinking.

> So now we have these beautiful two device IDs.
> 
> I'll note that the spec also defines a "DEVICE ID of Virtio Cpu balloon device as 47". But
> no changes really happened in the spec with that for the last two years (only the
> id is reserved).
> 
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-4260001
> 
> -- 
> Cheers
> 
> David

