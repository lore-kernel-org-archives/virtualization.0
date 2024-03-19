Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809339FE5
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876284; cv=none; b=Bw6RvuOfVMyD+CIXCftfP5M5RwYfLkQWHpn421KNrufPB/JeRRMxlWvNAEOWR85UpZXmaEem++ePt83pbVBQWLtIZZnCig9+OYbUDFa05fruHT4HZLZDT8mFUvVOuomp8kNh97OpI+QUP6gBTkR/HaLs9EPi/YI7IwLU2IrRsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876284; c=relaxed/simple;
	bh=SPOcqFOa4IEJC4nSqQwjCzcE1cmOqlod9iEJDt4l1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qXkK+yso7nKvG7z6AEymeWkSotojwJqh9s7BAWTnpaKFAvFTie6vDmcGmt4OfX3ptrFyNp24Zd7uXofysmjEQvQExbQUuJ9yFcHqlqh8Y8lQJdUG3YwF1f9pnCgWSf8gCd1wtPKmF6l5Wk0WT8okTHyG4IgHj90mqDS+kx3Adew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZe70Yz7; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZe70Yz7"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56EE340C88
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 19:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nDZZrLs0oeYH
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Mar 2024 19:24:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 92BB140327
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92BB140327
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PZe70Yz7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 92BB140327
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 19:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710876279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=054PSwUxcEoyTTyT0YXDp5Ih5pKTqj1jctjnvFZE9RA=;
	b=PZe70Yz7POOFOTaicoaaPjvQmXajtstRibO8+6qqDwpGZ/qoF3BH9xNv4FyhzIN/kKKj/i
	ROrF83qYX5wOUboYDxgd6LNQYLT8zjKC1cB6ykXH1ytPmoFgjc9ZRAfHOmxBP+SYk9+sSn
	4WVoRoHj1nXqRrSn91pvaTwrxy1C7ck=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-ZXZjXo3eMZqJm_pZRjmkrg-1; Tue, 19 Mar 2024 15:24:38 -0400
X-MC-Unique: ZXZjXo3eMZqJm_pZRjmkrg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed483c2ecso2027723f8f.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 12:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710876277; x=1711481077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=054PSwUxcEoyTTyT0YXDp5Ih5pKTqj1jctjnvFZE9RA=;
        b=eEZpyyKNcjEALpMYja91PmW+k35tjbUJX1ZP3pxht3YXgT1kXsl2WXR2DIzrQupeDe
         Iozf2G/wc1XX5JtHuhMzCRxQj7Z3csXSy5D6+yDaybkjkmH58TJ8wE6Q+8zQ1qr4cpny
         AgFlm6dzJL5CIts8Sl4lMEJsWiVJQmGSbWUgSEqcuJ+84MVaoen8XJbDmNy6zAJ1Lo04
         DY45v0EbnVEFxPhxLQF+FJJwPc+ED+z7YoFLrEKbMTerutQWz7bSNx9vU8qQBdBZAYnX
         R9DV1mfTHYEeOxUsZM2NzO/sc0OCqW9dVW6AYRBvZOUOC1bBOzIT4lQvstRDLLcg45yv
         f6uw==
X-Forwarded-Encrypted: i=1; AJvYcCVL3AgACSpPrkWV6WCWH4HDI3xtWxUhfGvqg6vgRbwsdGLQ9jUmsUj1/Bj1JLzdnNJPco+BwRPeXmLTZGImiZCgfydavaHkIV9lCbtfFsBCnM9PTqXhB19HCQ==
X-Gm-Message-State: AOJu0YzOw9q9ZO5+h7SpU/xsEJVmeFpOdBFCA7/N+S3CDTb68cR8pC6t
	3y99zObuddnSVeHJyU+fd6xplHJmyvjjRo/3ByblR71WJOFYRfcVaPjcIGO1DsKoKoO3g3ku6jJ
	VY8LiDopT/MPMAPGs0yyVK4KDObqGhorbiPsTTiAEgFdgzSpB94NLPcBEJrm5lnvJRp8d+Zmv9Z
	hvACY=
X-Received: by 2002:a05:6000:104e:b0:33e:d1fa:6627 with SMTP id c14-20020a056000104e00b0033ed1fa6627mr7835989wrx.50.1710876277025;
        Tue, 19 Mar 2024 12:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQZid9lWxUAfX9KUhv4EBBJ2gUziSxS4M3VUS2nzuzhpo41M0C+zkRsiu9Q7+Z7XgReUIshA==
X-Received: by 2002:a05:6000:104e:b0:33e:d1fa:6627 with SMTP id c14-20020a056000104e00b0033ed1fa6627mr7835957wrx.50.1710876276421;
        Tue, 19 Mar 2024 12:24:36 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id v3-20020adfe4c3000000b0033e052be14fsm12994886wrm.98.2024.03.19.12.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 12:24:35 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:24:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com, andrew@daynix.com, david@redhat.com,
	dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com,
	gregkh@linuxfoundation.org, jasowang@redhat.com,
	jean-philippe@linaro.org, jonah.palmer@oracle.com,
	leiyang@redhat.com, lingshan.zhu@intel.com,
	maxime.coquelin@redhat.com, ricardo@marliere.net,
	shannon.nelson@amd.com, stable@kernel.org,
	steven.sistare@oracle.com, suzuki.poulose@arm.com,
	xuanzhuo@linux.alibaba.com, yishaih@nvidia.com
Subject: Re: [GIT PULL] virtio: features, fixes
Message-ID: <20240319152109-mutt-send-email-mst@kernel.org>
References: <20240319034143-mutt-send-email-mst@kernel.org>
 <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 11:03:44AM -0700, Linus Torvalds wrote:
> On Tue, 19 Mar 2024 at 00:41, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > virtio: features, fixes
> >
> > Per vq sizes in vdpa.
> > Info query for block devices support in vdpa.
> > DMA sync callbacks in vduse.
> >
> > Fixes, cleanups.
> 
> Grr. I thought the merge message was a bit too terse, but I let it slide.
> 
> But only after pushing it out do I notice that not only was the pull
> request message overly terse, you had also rebased this all just
> moments before sending the pull request and didn't even give a hit of
> a reason for that.
> 
> So I missed that, and the merge is out now, but this was NOT OK.
> 
> Yes, rebasing happens. But last-minute rebasing needs to be explained,
> not some kind of nasty surprise after-the-fact.
> 
> And that pull request explanation was really borderline even *without*
> that issue.
> 
>                 Linus

OK thanks Linus and sorry. I did that rebase for testing then I thought
hey history looks much nicer now why don't I switch to that.  Just goes
to show not to do this thing past midnight, I write better merge
messages at sane hours, too.

-- 
MST

