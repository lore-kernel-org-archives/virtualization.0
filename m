Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300C29408
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157296; cv=none; b=a4f/viPoxKY8Sk4grp3tvy4+mdQj0g9hKwj2KOA+1raZI2bt2TubYCR/psEiFDbQloORdvXw/JsAlvw8CNG8CyK5QyMhsfp1Ww4RTuA7dn+Ez1EzkS61KO84opUf7nTpBWYiL/0acZA+WBbEtSJi3UwggltqfgjH6burAJRT+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157296; c=relaxed/simple;
	bh=RO8BBqJnXoP3LOp/aiEWTIMapxx/ZjyQNyG4/wIlN5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gJ+hpk10Ac1dr76h0QTZL6M5yQlHSg6OnYhacHyMC5BDb2/dD+H/xRjvqJj4mIIVUAdVo23B31Lh2FM+ChIxNAoqkOgz+EwEJ2hbFD2IICGZX4qh5Vs61ya9uGJ7oMDFR8kY0BILqMgJeQumN/qHowp365bVaNFBsKYjq2xbBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxFAen8Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxFAen8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788157293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VzgjundSHcr7LPjtj27GYXaMSFGktJ4pDKFyBrOg/JA=;
	b=AxFAen8YDOGCfrIj3p/iAHvi1CQQBXRFz7CysI23bs/K8YkPB29JMY1XcmAz/LMRDEHes/
	qwBpQubqbEs+M/vkk1VNKgsK0rHIiVqXZTpPdmAAcvoMKIRJk+B7mvWlsRL9z7yVBZr9sM
	5VHS1MGLhXiI/ksUKkUH7o7i5fnPXvs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-vAjb7rpUOPKkwN18fi0t1g-1; Mon, 31 Aug 2026 02:21:32 -0400
X-MC-Unique: vAjb7rpUOPKkwN18fi0t1g-1
X-Mimecast-MFC-AGG-ID: vAjb7rpUOPKkwN18fi0t1g_1788157291
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4843313047eso731183f8f.1
        for <virtualization@lists.linux.dev>; Sun, 30 Aug 2026 23:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788157291; x=1788762091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VzgjundSHcr7LPjtj27GYXaMSFGktJ4pDKFyBrOg/JA=;
        b=XfVoCAV9kSPKvLaxl1ujSxf/9qPLrVt6Qk0O5H+1O4eDQ6NZOHu9fJT6CSkS5DLuJt
         kU8py5k5HP2yB6LlZnn/UTsHpXSpiYFIGlYSK/FvqaUuQvVR3NmZWP9pAvFMVb/gbkKu
         ZLOUQkHl7j3BPkXFolJN3JLCxWoxLBeHYCmQd43J8MvcTdVTMLZlV613N9ZfPLPqQ7VC
         4OdVDQIF7470Q/rAzzAR0SVtaSBsQ5USKlHRFrs3y/6NHN/nJGZLjW3qzsFF24whWl7f
         NjQ8ZCWo7ja+1Z+bkvy7++GECcH5O/TiCy8QiKeVLR0HGUnph073SGZRcdQ10b61iewd
         Pvgg==
X-Forwarded-Encrypted: i=1; AKwUvBwxuXR+hMiFSFo8o6Hf4Gd8a55iuo4vh1vR3WIUgFbIgUQXAIWZWOUKJrcPr0vY+QgtdJpdAlaS6yfyCgXCCg==@lists.linux.dev
X-Gm-Message-State: AFuF++lA+wJ5oXzSCu0ySyMy4cZt6MOZPhccE8t1XnjNvMo0GgxqrDqr
	suiBzQN2XjD2kV3yGHxCvTiqDUYEEOqCzDJiZPndKWnPGdbl3n0blVj3Wti1g/SfAcTMx69PHDC
	0Nx9nCDGHxQ0XV6TIwDt+6wEIH9nUVj/7YP2kEoULrse5PrT/Gk2vi5F72MGveio7cUu9
X-Gm-Gg: AYBFou1v2/gWbWqGrrRMqB3YJEsnaFhNHhD4cWCfNGk2l6zSl8QnaECLgW/pRjzkBON
	xsKfTV273PLxfOdNxPLGoD1BSQtwWJ6R82X87MMJuDsBh5Mz0J0a4WfYDFsIUNlp+9WbQ64jC2F
	Ad1IBy2offzgaGWwrkyD9uu+pfvsv9oxEBox1ogXlWf+GC5cED1rIZOk3MC2hGvADJ2ZMo2Rq/A
	Jwc/AtDhbGAxCeO6PhdHLgU2IdjbAdK1Q72rUqAGd8ALB7SLkOSirpK3I3TuJHT6/B/8IR3wKfu
	SUHBHFPlwa00znNmnp5C5SnROvJTlvma2zvnK0wcUHQeXHmt0dATe0M6nn1WOaDD4BBcDZVC/sA
	RhsxpBqwstcetqSToc/6o/dY=
X-Received: by 2002:a5d:5f03:0:b0:484:3cbf:f254 with SMTP id ffacd0b85a97d-4843cbff31cmr4749479f8f.21.1788157290748;
        Sun, 30 Aug 2026 23:21:30 -0700 (PDT)
X-Received: by 2002:a5d:5f03:0:b0:484:3cbf:f254 with SMTP id ffacd0b85a97d-4843cbff31cmr4749418f8f.21.1788157290219;
        Sun, 30 Aug 2026 23:21:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20122sm20363022f8f.20.2026.08.30.23.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:21:29 -0700 (PDT)
Date: Mon, 31 Aug 2026 02:21:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Jason Wang <jasowangio@gmail.com>,
	nh-open-source@amazon.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 04/12] virtio_ring: return -ENOMEM when a packed ring
 mapping fails
Message-ID: <20260831022012-mutt-send-email-mst@kernel.org>
References: <20260818211425.91009-1-graf@amazon.com>
 <20260818211425.91009-5-graf@amazon.com>
 <CAJaqyWeGaoamHzYRd1ZVUJ+6fx_4RWDim+jLO964qKtgZ=zogQ@mail.gmail.com>
 <CAJaqyWe1fKBwBXXxHqDV676Uw03Pvr0uLizPmHKqm+sqmY_LgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWe1fKBwBXXxHqDV676Uw03Pvr0uLizPmHKqm+sqmY_LgA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zy3vh4EpDDONisXCfvGOMABB1pckgb0U70qzsuwQMb4_1788157291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 31, 2026 at 08:00:00AM +0200, Eugenio Perez Martin wrote:
> On Wed, Aug 26, 2026 at 2:47 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Tue, Aug 18, 2026 at 11:15 PM Alexander Graf <graf@amazon.com> wrote:
> > >
> > > Commit f7728002c1c7 ("virtio_ring: fix return code on DMA mapping
> > > fails") moved virtqueue_add_split() and virtqueue_add_indirect_packed()
> > > to -ENOMEM, because virtio_queue_rq() maps -EIO to BLK_STS_IOERR and
> > > the request fails. We still return -EIO from virtqueue_add_packed(),
> > > and virtqueue_add_packed_in_order() copied that when it was added later.
> > >
> > > Guests that bounce their I/O through swiotlb (SEV-SNP, TDX, s390 secure
> > > execution) run the pool out with enough I/O in flight. On a split ring
> > > virtio_queue_rq() reports BLK_STS_RESOURCE and the block layer requeues
> > > the request. On a packed ring virtio_queue_rq() reports BLK_STS_IOERR
> > > instead and the error reaches the filesystem.
> > >
> > > Return -ENOMEM from the packed unmap_release paths too. Both are reached
> > > from a single goto on a failed mapping, which is where
> > > vring_map_one_sg() already produces -ENOMEM.
> > >
> > > That way every ring layout reports the same errno, and the block layer
> > > requeues the request instead of failing it.
> > >
> > > Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping fails")
> > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> >
> > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> >
> 
> Even if I'd like to see this merged, I'm having second thoughts
> because it introduces userland visible changes in some drivers. Are
> them acceptable?

I mean, fixing the kernel for the userspace is kinda what we do, right?

-- 
MST

