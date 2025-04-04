Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B03165EFC
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744820; cv=none; b=hii2FC/M2hpxzg9Ix/mc94d8Hv+XSgUaZFZ7ZSGakyxPqmOaq0Xz5MPBoR13gOVNTCuMR/Hiz/h0tO/PgskaNOhWkrcwlWOxIlyqXCcy0cUdHTlpGRkUEpXhfDPPsvhHCurTB2fumVjPVdzfUYftADkh+a0ko+GrpDim75TpNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744820; c=relaxed/simple;
	bh=t5YrEvo1Qv7V/OOCE0jzPDPPWuEcHK5DHyugrkXD3oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k2ooNYSiE8oY3dyZnCPlQp9mJ/rUzTMgPUlndndxsvOGH1B2EriLJtAjJoH64CDokORzWtxtEvXkrwxUMdjYrv2qJakISX57+elD6IRmRrQq56Cxulumz1Bus/Xe9wiyysCBMJmsa4VurEgBy5r8P/nzFMmY9XvkFMS5CtO55lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8rx+1jI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8rx+1jI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743744817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8DadzuBkB0b+TswMeRC57LXNTfY/qY6jGCVQ+lHwe0=;
	b=B8rx+1jIIiHi4+s0CVyzN29uKWCQ85uQ2cRRCD7szz0P3hUBF54fIJ/S/SsfpN7TzrJQes
	zfCPoU3BLfcoE76OKDKijHDAX8PXOr5/XOqg0gOwC8wHLiOW37BQV9vQdlW5XfmNmIF1Hv
	d4YyBhjrtmw0SJs0sJwkKYwouHk52LE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-WKTTnEwUP8eH2-VOF33lMA-1; Fri, 04 Apr 2025 01:33:33 -0400
X-MC-Unique: WKTTnEwUP8eH2-VOF33lMA-1
X-Mimecast-MFC-AGG-ID: WKTTnEwUP8eH2-VOF33lMA_1743744812
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so9069465e9.2
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 22:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743744812; x=1744349612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8DadzuBkB0b+TswMeRC57LXNTfY/qY6jGCVQ+lHwe0=;
        b=fqy/ReHRN5M+2Iz8Xm9jziC5iVMXucpGt/Xx9Em9lZftsRonCMtdIRDr9Xcwho1LHK
         Wh4N1Jwua1pCJChJhQ3c+xYfQvuQc8YqqsPmgXbg0Bh/fDpIUALjrU74za1gLMvr52ZH
         EACxsDjXh2sXSub0mROALG2CMu7WR5u6FY+zwkg6/zUQJWC+QfaqqqIn5kxUouhLhuB2
         znxtuHIW6xkDofCdI0urGy1Wd0xeLJpQZact7iiEEABhAWGqhcCAYr1E3SpCtGVnuZ7Y
         Dy+X/Dj5TRLacah8YSOqw6l/BVf3ZoARJCR5ouLy7yKocXtIY48+o3QTvAlKIdVVNCjK
         6H1A==
X-Forwarded-Encrypted: i=1; AJvYcCWAONUc3DmZFPXuouBHARqdR14xkEM6/rUEqvG3tFwJho3/JJvKCE6M0KtjesfYN8SRag/qslP6NzMiTr5OkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/BJQtpvCHNH9Mc3RbuKQ8TQc7vVikL6b8F7F/zKrspQDDhUrw
	d5EMgAxZt73G4gXdNSypoVmyscSymRVlr43nkh3Q/T5D2gQCdTPxAUiiw5OogFedDWtCgo6qxpN
	rsvJH+gko2dDxTRCGHxm3TqqAOMx6U12VA1uwUJPS5PlD26pUl8pU21sg0cUnF3T7
X-Gm-Gg: ASbGncv0kFNj1DBk4Eq0SFSWabTJcxCA36nZAcXLpLbOkxTvH+GOXkukiiZGOUEtKci
	RczvoMSUewiuRjrXUG0hPEJVIRl88WYBbFu/LIFJVn2oZf0MFVxKzJmCvnbFJtzw9ed08cSQTWo
	nRjDQNVkl2swypuUX4oZHfbrSwdmUrNHDoRP52OK+HUo/N9JhVwHl3ftCABpaVcefunmkIkQInM
	tWwPF7REKaTKfIZhIpRJxI8iCLhbXDUvgajwggf9WTxMyCJlqaNi9pPqIvXuGk2/kLGLlZjmghW
	sa9YUSMhEg==
X-Received: by 2002:a05:600c:6986:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-43ecf822cf4mr12380275e9.6.1743744812320;
        Thu, 03 Apr 2025 22:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOWcVoqDuuU1EzwnYMSgwjMR/a8JCeY7bzgZQlbtecRuO04aJY8fG8iABZRmySxq9rz0/+0A==
X-Received: by 2002:a05:600c:6986:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-43ecf822cf4mr12380055e9.6.1743744811973;
        Thu, 03 Apr 2025 22:33:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm36561555e9.4.2025.04.03.22.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 22:33:31 -0700 (PDT)
Date: Fri, 4 Apr 2025 01:33:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250404013208-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <20250403103127-mutt-send-email-mst@kernel.org>
 <20250404060204.04db301d.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250404060204.04db301d.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EZHEqaqfsyixgzfmPG0B1nOMf-jzpmzEwGtpgjLMcPQ_1743744812
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2025 at 06:02:04AM +0200, Halil Pasic wrote:
> On Thu, 3 Apr 2025 10:35:33 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Apr 03, 2025 at 04:18:36PM +0200, Halil Pasic wrote:
> > > On Wed,  2 Apr 2025 22:36:21 +0200
> [..]
> > > 
> > > 5.5.2 Virtqueues
> > > 
> > > 0
> > >     inflateq 
> > > 1
> > >     deflateq 
> > > 2
> > >     statsq 
> > > 3
> > >     free_page_vq 
> > > 4
> > >     reporting_vq  
> > 
> > Indeed. Unfortunately, no one at all implemented this properly as
> > per spec :(.
> > 
> > Balloon is the worst offender here but other devices are broken
> > too in some configurations.
> > 
> > 
> > Given it has been like this for many years I'm inclined in this
> > instance to fix the spec not the implementations.
> > 
> 
> I understand! For me at least knowing if we are going to change the
> spec or the implementations is pretty important. It would probably
> make sense to spin a patch for the spec, just for the unlikely case that
> somebody did end up implementing this by the spec and wants to protest.
> 
> I think, a consequence of this design is that all queues need to be
> created and allocated at initialization time.

Why? after feature negotiation.

> I mean in the spec we have something like 
> """
> 5.1.6.5.6.1 Driver Requirements: Automatic receive steering in multiqueue mode
> The driver MUST configure the virtqueues before enabling them with the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command. 
> """
> 
> For example one could want to hotplug 2 more vCPUs and still have a
> queue-pair per cpu (and a controlq). Those 2 extra queue-pairs could
> in theory be allocated on-demand instead of having to allocate memory
> for the rings for all the queues corresponding to the maxed out setup.
> I've had a look at the Linux virtio-net and it does allocate all the
> queues up front.
> 
> Also with this design, I believe we would effectively prohibit "holes".

For existing devices at least.

> Now if holes are prohibited, IMHO it does not make a whole lot of
> sense for the virtio_find_vqs() to support holes. Because the holes
> and a fair amount of complexity. Of course that would make sense as a
> cleanup on top.
> 
> Regards,
> Halil



