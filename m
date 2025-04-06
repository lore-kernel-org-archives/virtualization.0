Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2D18027
	for <virtualization@lists.linux.dev>; Sun,  6 Apr 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964975; cv=none; b=Yev9N1NQM0/cXj2CSLCz2bufm9Sdld+J7uSk/lmzaOA7soTPhdk7eMD0Z5A6zSFimAwLaSQv7mxOeMtVre+ABnTmHFFx2DfNp81yZuqWZDBEt4+clI9WcdTh7SvsxuH7UG6xqMEpexTJwIhYIlwHv9nRFnkxB0LchOQ5mOyUrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964975; c=relaxed/simple;
	bh=jkthnwIu4x2ab3rryn7gQmfrXQCW9AmPrBXkvq286QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QWb2Bg9AiI9Fj6TdhdVBE8UARzhxpf/8JZKoLbLIgTxXFwj3TqG4DMeJ7fY1tiLPBn1QUdKSbhY45Aiqgj6/A9VaNGWGXUb56ZFjMzUvLNRXseo0lcheb0bIJM2ssyohqxNKL/05JB22RqQUwVrEbg2HLN110qZrh7FHwHtBUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPbiR3Vz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPbiR3Vz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743964971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4c8B490RwiITrJ+PXzql/YyOvDN55S409ylH6Wlhgw=;
	b=jPbiR3VzmzK3U5KM0ypg2bdnc/f5urhMk2YtasnzBBMEdXv/tNfx9gUb4veFj3Vezn4exT
	LYZRyZuoW4vUExMLdn0VIVJcrDPTLb0QWp+0irSM8mfLUDEsSoC/V/1X20fVWs6YlbG2N9
	VT/9/X1Sc8Im3K3TzqrE3ay6D1v83bM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-2mWnoTo5P6qE75UfxhGK4Q-1; Sun, 06 Apr 2025 14:42:49 -0400
X-MC-Unique: 2mWnoTo5P6qE75UfxhGK4Q-1
X-Mimecast-MFC-AGG-ID: 2mWnoTo5P6qE75UfxhGK4Q_1743964969
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d51bd9b45so25047555e9.1
        for <virtualization@lists.linux.dev>; Sun, 06 Apr 2025 11:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743964969; x=1744569769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4c8B490RwiITrJ+PXzql/YyOvDN55S409ylH6Wlhgw=;
        b=X2DfV0j5YDBxhyVUdlLybNJgqmBQzvdJ0Ces7CMh+Z0CEpMVSbDDf0rWqW3f1UEvt9
         H2TIB70LGVU5W+09Gjw4Ru/yr+UTLCmJbDW1lNV9IRshjM60AbOvQoHtwyfd8N2sa7QX
         p1jl+Vk2DntREcmZ6QWLyhYhnc7Z/vORSthKaXdgCH+tSfVTRUjbdz1PraI5MQ+NRwZw
         8a2sRqUMxUuAWPRoU7l1KhF3sIKv5LDONkf/JwI2chNn/MFVYndUH1XwwMCUDFlWDFbe
         hxR30H3ckAfZc0yZ4snA0VABsmfZ+EcPrGLiIxiuppn2zd+QLZrKe0PJN/3haxigsIu5
         +MXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTTmQzB6wsXQ5itMB6BoKXH023aI0bogFx+0MXWqJVpSjI8g4C8f6VEdwsU3Ot4PG7sEmuAUsyMDr+uarnmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNSYihSHnSuD1ZchWDT7BDubnxMHKhcVkZsgLwzqgKZgwpaTqC
	PH1dNqEeMi4h0IRxyV3YMSQvMxq3Oh/CrCoiGBG1rQzurh1bY9q3fFv5Ys3ZYewSwrP/JT/rn9j
	FsPSdVSw6IRLV6gm7U2o1NGuc43mAqKMEHqiVVF8eq9qHiBGCIfYVGwKRSbv0J3xa
X-Gm-Gg: ASbGncuriAjOL2TCClUWhspGqeFQtlzIk+quiXe6b3Rc7K4ZI9gKixyo91pB+KUIYBt
	mT4XvAsn0AJmrQ0M8VDDzM92oDYK+cdQ8mj2zPe0IeFq1C7Ru67ILMNnZ1V6D5iY0fUd3BHfras
	QsNsnToNc7VFPurPOC7/RinHNwsWoi/QFidVv+jXlLcnGhNMn1JphcPYDu5YuSSvWqRrLkAav13
	k1T76R1cTNkJjw7yL/LSwy2sgWvAgbNUex3vKXfer2X5uqKNllxdaodcN2Yozad3Uw63OPRHxjS
	XT7auEnIBw==
X-Received: by 2002:a05:600c:1c02:b0:43c:e6d1:efe7 with SMTP id 5b1f17b1804b1-43ecf9c3318mr77649405e9.26.1743964968810;
        Sun, 06 Apr 2025 11:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ7Ob0gGk+5s+Q1YLlqY/Rv4sutBh4ToTvYFi5jKg1vPDkOglX+EoRqjaRhaLmLLp6Pxa/Tg==
X-Received: by 2002:a05:600c:1c02:b0:43c:e6d1:efe7 with SMTP id 5b1f17b1804b1-43ecf9c3318mr77649235e9.26.1743964968402;
        Sun, 06 Apr 2025 11:42:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c300968cfsm10197854f8f.16.2025.04.06.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 11:42:47 -0700 (PDT)
Date: Sun, 6 Apr 2025 14:42:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250406144025-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HP3wOYX2MvpEwskLxb4xKYJOZFP6M0WXCT7scO3b8JY_1743964969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2025 at 03:48:49PM +0200, David Hildenbrand wrote:
> On 04.04.25 15:36, Halil Pasic wrote:
> > On Fri, 4 Apr 2025 12:55:09 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> > 
> > > For virito-balloon, we should probably do the following:
> > > 
> > >   From 38e340c2bb53c2a7cc7c675f5dfdd44ecf7701d9 Mon Sep 17 00:00:00 2001
> > > From: David Hildenbrand <david@redhat.com>
> > > Date: Fri, 4 Apr 2025 12:53:16 +0200
> > > Subject: [PATCH] virtio-balloon: Fix queue index assignment for
> > >    non-existing queues
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >    device-types/balloon/description.tex | 22 ++++++++++++++++------
> > >    1 file changed, 16 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/device-types/balloon/description.tex b/device-types/balloon/description.tex
> > > index a1d9603..a7396ff 100644
> > > --- a/device-types/balloon/description.tex
> > > +++ b/device-types/balloon/description.tex
> > > @@ -16,6 +16,21 @@ \subsection{Device ID}\label{sec:Device Types / Memory Balloon Device / Device I
> > >      5
> > >    \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtqueues}
> > > +
> > > +\begin{description}
> > > +\item[inflateq] Exists unconditionally.
> > > +\item[deflateq] Exists unconditionally.
> > > +\item[statsq] Only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> > > +\item[free_page_vq] Only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> > > +\item[reporting_vq] Only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> > 
> > s/is set/is negotiated/?
> > 
> > I think we should stick to "feature is offered" and "feature is
> > negotiated".
> > 
> > > +\end{description}
> > > +
> > > +\begin{note}
> > > +Virtqueue indexes are assigned sequentially for existing queues, starting
> > > +with index 0; consequently, if a virtqueue does not exist, it does not get
> > > +an index assigned. Assuming all virtqueues exist for a device, the indexes
> > > +are:
> > > +
> > >    \begin{description}
> > >    \item[0] inflateq
> > >    \item[1] deflateq
> > > @@ -23,12 +38,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
> > >    \item[3] free_page_vq
> > >    \item[4] reporting_vq
> > >    \end{description}
> > > -
> > > -  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> > > -
> > > -  free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> > > -
> > > -  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> > > +\end{note}
> > >    \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
> > >    \begin{description}
> > 
> > Sounds good to me! But I'm still a little confused by the "holes". What
> > confuses me is that i can think of at least 2 distinct types of "holes":
> > 1) Holes that can be filled later. The queue conceptually exists, but
> >     there is no need to back it with any resources for now because it is
> >     dormant (it can be seen a hole in comparison to queues that need to
> >    materialize -- vring, notifiers, ...)
> > 2) Holes that can not be filled without resetting the device: i.e. if
> >     certain features are not negotiated, then a queue X does not exist,
> >     but subsequent queues retain their index.
> 
> I think it is not about "negotiated", that might be the wrong terminology.
> 
> E.g., in QEMU virtio_balloon_device_realize() we define the virtqueues
> (virtio_add_queue()) if virtio_has_feature(s->host_features).
> 
> That is, it's independent of a feature negotiation (IIUC), it's static for
> the device --  "host_features"


No no that is a bad idea. Breaks forward compatibility.

Oh my. I did not realize. It is really broken hopelessly.

Because, note, the guest looks at the guest features :)


Now I am beginning to think we should leave the spec alone
and fix the drivers ... Ugh ....




> 
> Is that really "negotiated" or is it "the device offers the feature X" ?
> 
> -- 
> Cheers,
> 
> David / dhildenb

