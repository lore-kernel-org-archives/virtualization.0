Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496B296D36
	for <virtualization@lists.linux-foundation.org>; Thu, 15 May 2025 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289680; cv=none; b=bSUocSFDQP9SowHXvHb53Ef4o9p7BCsSfWTleRtSfOUCZzFZLKoz6JNKUV5CqAR0kNYEdAJf2pj/weDBejvDS5BskUmuUuoqviIWQDv6/cTwDbv4DlprBmfIt4aEH4bROdyn3qurOAs/T4oRYb65iY92IsN1RG8Dj02Ih1p01Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289680; c=relaxed/simple;
	bh=GHX8SKnuRhPHg4JVM24oLTd/BzpBHMkfXNZOoDsAupc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=K+NafpuVHP7ADTvMs2wBLUccrirzrF2ro/BHc9zeHCvfpL5PRtsfXiy1Hp3iweDcrhaCplVO9+AbMG9N9vXtfjQDhE9DQPKBe6jDgJuizN4kfOXm1NLS5bK/UVhLp3By92+vkBylxo9vouLh7L40qAgk0XlndaCX/GtMJBTlD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjiT3WgD; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjiT3WgD"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF882810BB
	for <virtualization@lists.linux-foundation.org>; Thu, 15 May 2025 06:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mq2EVdf4RQlT for <virtualization@lists.linux-foundation.org>;
 Thu, 15 May 2025 06:14:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EE59C834DB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE59C834DB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JjiT3WgD
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EE59C834DB
	for <virtualization@lists.linux-foundation.org>; Thu, 15 May 2025 06:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747289676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0+9WuDoVK7seiIekMPOn5cFsp2sTkD5ZfvmbgrYAn0=;
	b=JjiT3WgDVFVylFVRhxTCCWIFpZTWFnNZfOiVQH5cF9SF12jYaCAhgoUO1dE0o6RopSZr1B
	ZzuJTJz5lQrsvYMmfmeI+Canam9WLNPZMeyo7cVH1ArD/wzMstywH/BLIhSVzbnvn0m93M
	IlOjnWZGLp9x1zVDhP0NMezoMRNKCb4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-oNYdtjNuNRmPnn-rgYU9vw-1; Thu, 15 May 2025 02:14:34 -0400
X-MC-Unique: oNYdtjNuNRmPnn-rgYU9vw-1
X-Mimecast-MFC-AGG-ID: oNYdtjNuNRmPnn-rgYU9vw_1747289673
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so2985015e9.1
        for <virtualization@lists.linux-foundation.org>; Wed, 14 May 2025 23:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289673; x=1747894473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0+9WuDoVK7seiIekMPOn5cFsp2sTkD5ZfvmbgrYAn0=;
        b=KqbqGJ3rn/W8oEEpawovH+HD+0lIIj6a3xIokZn3SE66O8ClVouMFO4Wg2E7yVNcQO
         UMnGhwJKhSj3t5/Nu2LwxkYbQaophHsPV9gC8Xpuy/irl35osoORkXhoIFlcj29+cLpc
         Im3iAW2w1qFLi0CoyQeyhERMiI8uHww5HvqA36fH5uB0IvqyIyv4fyE/dYbv3nAA4UGT
         36OAIeJQ2nzTMuv4Yyfsvy13R6Gu7a7QFLInX2GnPwGZtuK5h6dyUfOGnZLfLgx9bqTQ
         nJPW+as/6ymm9LsJkg2VvlOZyk/7Gjo6L5YUl5rdfWcXeuxjHracWquLhuAfX1qa14Qj
         ecww==
X-Forwarded-Encrypted: i=1; AJvYcCUNr5P0YiUODd5ddUtVVtREVXEN2sczG270CZFQKRo6g63U+eGo+8CMnsbW5u7YZ04BxyloLMbcTqiX0xEbsA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwOuIWKMmsPrVLkaHDGsnIJpVM2X6heNrE/wfQFisMRt2H1w7km
	bJ6g934aGdvPcBCYnXzR59Z5wLsuAw8JtDqnZ6ByzuyIYNvv+C3oUfw+YT+oHoaEhnE3+fEbE9k
	jw60ockwaXlBzTd4t4LIFZHlCZ5i4ug7kTwbTDxidrJbrV0GRfLEXty0NZ3GsfjjvWcMRY6uT7g
	7coys=
X-Gm-Gg: ASbGncv/uJK48rMrgRU5pZ6t1mIa1PteDOLHOIo6d8FRDzBTPYICoyYAnRknUdNoO8j
	95plqUHzhLcx9WO7GPIAdtaYR4Vwcf6mII1rWBV1ZaWi+vKX6mIwM/h6ie9pzguHeuXH4OSxmIV
	72d+5Q6Y0zLspwlMBLDilo9nrOf2BECmLYfDSfpF8oOQhn/CNY9AnQ9m9AgyVZVuduZyzUVEudm
	VXJIvo6ED4azRDcnmv0lKlJYC9uTACof8tZJ84Fu94yhQmVw6apNRxR0o2dX2CS8l9ZdK/pmalE
	oaUJgA==
X-Received: by 2002:a05:600c:8289:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-442f96ebbdcmr9334975e9.14.1747289673390;
        Wed, 14 May 2025 23:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3PEe9C8rgBo0TvQnY3+NCOLyFxB24dQVnG16aVk1y3CI+MSZSiHnCWnpwcLn7wNlLIVXpyg==
X-Received: by 2002:a05:600c:8289:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-442f96ebbdcmr9334755e9.14.1747289673051;
        Wed, 14 May 2025 23:14:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e8578sm57255445e9.29.2025.05.14.23.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:14:32 -0700 (PDT)
Date: Thu, 15 May 2025 02:14:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250515021319-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org>
 <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org>
 <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org>
 <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: elSVgxLL4jX5hUt92b04p5JKiOAiI63wHwjV8JeclGs_1747289673
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 14, 2025 at 10:52:58AM +0800, Jason Wang wrote:
> On Tue, May 13, 2025 at 3:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > On Wed, Apr 30, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > On Tue, Apr 29, 2025 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > > On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > > > > > > is disabled, and any attempt to use it will result in failure.
> > > > > > > > >
> > > > > > > > > I think we need to describe why the default value was chosen to be false.
> > > > > > > > >
> > > > > > > > > What's more, should we document the implications here?
> > > > > > > > >
> > > > > > > > > inherit_owner was set to false: this means "legacy" userspace may
> > > > > > > >
> > > > > > > > I meant "true" actually.
> > > > > > >
> > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > > > > applications need to be modified in order to get the behaviour
> > > > > > > recovered which is an impossible taks.
> > > > > > >
> > > > > > > Any idea on this?
> > > > > > >
> > > > > > > Thanks
> > > >
> > > > So, let's say we had a modparam? Enough for this customer?
> > > > WDYT?
> > >
> > > Just to make sure I understand the proposal.
> > >
> > > Did you mean a module parameter like "inherit_owner_by_default"? I
> > > think it would be fine if we make it false by default.
> > >
> > > Thanks
> >
> > I think we should keep it true by default, changing the default
> > risks regressing what we already fixes.
> 
> I think it's not a regression since it comes since the day vhost is
> introduced. To my understanding the real regression is the user space
> noticeable behaviour changes introduced by vhost thread.
> 
> > The specific customer can
> > flip the modparam and be happy.
> 
> If you stick to the false as default, I'm fine.
> 
> Thanks

That would be yet another behaviour change.
I think one was enough, don't you think?


> >
> > > >
> > > > --
> > > > MST
> > > >
> >

