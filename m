Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3192356C1
	for <virtualization@lists.linux-foundation.org>; Fri, 16 May 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391981; cv=none; b=S8xNJkzO1cYdV0z4coRUbkpWGrS1CVqlrUs/GAe+PGuu42USGWhZJBNrbSU2+vU5NPZFJU3FuCKqUXs0VYymyNSHe4T3FgLLcguxWv56gWzYvZM4GJRfGVcD8h96cpbhuFRnpVrqcTHdabLa5yWvIJ+o7/zUuZqTlJqPNmUD5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391981; c=relaxed/simple;
	bh=NCB+3lMyOx+fn/S3zX/Y6sTtiI24gcvf+J1THi9Qmbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UD6UNPtL9/jrRHRkg6GSPgtixYJbDxSMkb3daVPOwDsuypxuhf10UA6MPJY3auC43YOVW+GeneIJxev/ukDgFHmPEhclYkkijUOmK57y9zUsbzYee5tM54rSjg2lG3Z//yO493X74tE5HSrliMGNVKtrN9t64RicspZ/Ab29BMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhBcQcgn; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhBcQcgn"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E531140A94
	for <virtualization@lists.linux-foundation.org>; Fri, 16 May 2025 10:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PLt4RTJV3JPk for <virtualization@lists.linux-foundation.org>;
 Fri, 16 May 2025 10:39:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1F7F640415
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F7F640415
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OhBcQcgn
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F7F640415
	for <virtualization@lists.linux-foundation.org>; Fri, 16 May 2025 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747391977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQQMDEIIwXkuHEhIKpxJjnKfw2Oug4GMJkHufoFzpm8=;
	b=OhBcQcgnYslQCNpgw9HH9T56xBN9sBnIEpSC2CsBhRuOk2pQXQhLlGBkePD2B/aMNhatd1
	DuYHDtaxgz7zdBHa5dBqGlkV4Drj/Y43uxD12sEwVliwvkwFYCWtbSltalwv2ZvF8iom8U
	hJDNVSGFj3PBv0t9dgneV2aeZZzv7hU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679--UMnqQM6MGO4TkyKCn0-OA-1; Fri, 16 May 2025 06:39:34 -0400
X-MC-Unique: -UMnqQM6MGO4TkyKCn0-OA-1
X-Mimecast-MFC-AGG-ID: -UMnqQM6MGO4TkyKCn0-OA_1747391974
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-441c96c1977so12625025e9.0
        for <virtualization@lists.linux-foundation.org>; Fri, 16 May 2025 03:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747391973; x=1747996773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQQMDEIIwXkuHEhIKpxJjnKfw2Oug4GMJkHufoFzpm8=;
        b=Acudg93Zp9rft8XIaAaDHAF8cFSVcGlvnD6j3dGTrm6EDQc/frA7d1LAWcGQeK3bon
         5nzKOJzSNw5+MfZ6NKfOHwGn9ztyIXjtki7b+KieBMdj/Ixnlc8PsBMfejt3WuSvM1tu
         zQTyoV3OlMIf07mzbVzl/o2D0I8v3KoDjMY2bUBAWEO5PAsZSf1DpGbgGp3HdwH3zf28
         LI5Xhc5EkkpFjBdPCvpxyKU7L4NLJK57ukwv03Efx7hRLsXP6gX5Pio2A7Qoz7wju01G
         WhRxG0ULIW4wV2/eo1lFvJClbZyNRRLXecdlrS2ViHonwvVo6oOlp08eMfmkt6ygNkWs
         HYbw==
X-Forwarded-Encrypted: i=1; AJvYcCX4kIvLuBTe85Xv0hGVme/eUOic7Oj//Dg/FsoMvxpz3J5vGd72BgFH4dvABfT8TItcTNaM/2PYrv5TaFucbg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwiImzUFEr6q218CEqfsWWlvA87rSFIgWV/bs0fIuAvCUg9wYWm
	xs/jjcUrxeWSBaOX4sy/2NN1vs7QzNOqhw+9FE4HJ7cyQJeICL2AUs5nQ9hY76dVf/2N87MKJkw
	cZwbMhkikiEdOnqbauUsX1YS/WD6BwgcKVyks7Ym4dIdNRVJCui7A9D9qII5zNF2Vjo8fikJgkC
	wAWETNH7A=
X-Gm-Gg: ASbGncuJPmQcaVTgF4qEhAFILRz4FDY439YfhmlyO+8lENilIiv/rTHnEoxW6AWh3Bs
	2+S48OgEu3IwHzbPTVgsISvJ4a2EXAdvheQk9/FVLvggRqW9nnNw90D1hcRQ46YDi/HQhnbxLYm
	H9O3UR33B3HmCr3d36Kh/R6+nSTqRdQXdaUydRwLCPZ7WP64iKGBxrJx8dQfbxsFfm8rwO/WYaO
	pjKgN1BBnQT7oS7QXeFiHy2ociAFjSMDpgKMNsg5CkK5fMyGw54AbtipEKNsjLNf3aLXFoMGYDH
	IVzKSA==
X-Received: by 2002:a05:600c:1c12:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-442ff0316bamr14689555e9.20.1747391973548;
        Fri, 16 May 2025 03:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDKW6n87RVrzA4EIoIWUAPNw+ypMh5iiPl+xjV6leqnmea0yfCg/OCjfh+iHgxZSJtpf0sYw==
X-Received: by 2002:a05:600c:1c12:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-442ff0316bamr14689315e9.20.1747391973129;
        Fri, 16 May 2025 03:39:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f338070csm100008995e9.15.2025.05.16.03.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 03:39:32 -0700 (PDT)
Date: Fri, 16 May 2025 06:39:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250516063659-mutt-send-email-mst@kernel.org>
References: <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org>
 <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org>
 <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org>
 <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
 <20250515021319-mutt-send-email-mst@kernel.org>
 <CACGkMEvQaUtpsaWYkU6SC=i1tXVbupNrAVPBsXm3eMfAJHzC=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvQaUtpsaWYkU6SC=i1tXVbupNrAVPBsXm3eMfAJHzC=Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1H_hcVJRKigVViYPuSR8CU1HRLAF0dNoBeID-gPi_xs_1747391974
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 16, 2025 at 09:31:42AM +0800, Jason Wang wrote:
> On Thu, May 15, 2025 at 2:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, May 14, 2025 at 10:52:58AM +0800, Jason Wang wrote:
> > > On Tue, May 13, 2025 at 3:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > > > On Wed, Apr 30, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > > > On Tue, Apr 29, 2025 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > > > > On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > > > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > > > > > > > > is disabled, and any attempt to use it will result in failure.
> > > > > > > > > > >
> > > > > > > > > > > I think we need to describe why the default value was chosen to be false.
> > > > > > > > > > >
> > > > > > > > > > > What's more, should we document the implications here?
> > > > > > > > > > >
> > > > > > > > > > > inherit_owner was set to false: this means "legacy" userspace may
> > > > > > > > > >
> > > > > > > > > > I meant "true" actually.
> > > > > > > > >
> > > > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > > > > > > applications need to be modified in order to get the behaviour
> > > > > > > > > recovered which is an impossible taks.
> > > > > > > > >
> > > > > > > > > Any idea on this?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > >
> > > > > > So, let's say we had a modparam? Enough for this customer?
> > > > > > WDYT?
> > > > >
> > > > > Just to make sure I understand the proposal.
> > > > >
> > > > > Did you mean a module parameter like "inherit_owner_by_default"? I
> > > > > think it would be fine if we make it false by default.
> > > > >
> > > > > Thanks
> > > >
> > > > I think we should keep it true by default, changing the default
> > > > risks regressing what we already fixes.
> > >
> > > I think it's not a regression since it comes since the day vhost is
> > > introduced. To my understanding the real regression is the user space
> > > noticeable behaviour changes introduced by vhost thread.
> > >
> > > > The specific customer can
> > > > flip the modparam and be happy.
> > >
> > > If you stick to the false as default, I'm fine.
> > >
> > > Thanks
> >
> > That would be yet another behaviour change.
> 
> Back to the original behaviour.

yes but the original was also a bugfix.

> > I think one was enough, don't you think?
> 
> I think such kind of change is unavoidable if we want to fix the
> usersapce behaviour change.
> 
> Thanks

I feel it is too late to "fix". the new behaviour is generally ok, and I
feel the right thing so to give management control knobs do pick the
desired behaviour.
And really modparam is wrong here because different userspace
can have different requirements, and in ~10 years I want to see us
disable the legacy behaviour altogether.
But given your time constraints, a modparam knob as a quick workaround
for the specific customer is kind of not very terrible.

> >
> >
> > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> >

