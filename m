Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CEC1E491B
	for <virtualization@lists.linux-foundation.org>; Tue, 13 May 2025 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120158; cv=none; b=SsSsDmlnSvfGoTpSgg5JFGUiFGHMppNL5Mc3w1ZFEhbpPreBG76IUvQtpQkRjlc8Ykry8Rc2PJUCqe9BbMBabxHk/PQMUwnUyAmYibUJFv4nbk951uYoGgREHvyiZ76PV0OZMwNC0qESeLlJvaFdv7Xrhyn+wwVrdlGIU2Apsso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120158; c=relaxed/simple;
	bh=twHcmA7LUXTu4ZuLwMdsdfHh+CfPFxHnUVLG+BwD4io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Jl/eBX1FCAaK4RmmssPJjg7Y0wBYqJRwEUEEt7+SNyutMZllUSc6W93OGMuJin2iFfoKdn1XPIe4bt3N1QAf+vVdvoHa211Dmt4USYe7Y8a1AIasfTmnd5NGpVQeexv515OTK+Ux5pHlNJrjvHos64iJ4nb3+j7hQcUOUObbd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EqceXNBM; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqceXNBM"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62EE440C96
	for <virtualization@lists.linux-foundation.org>; Tue, 13 May 2025 07:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ie5it3M144u9 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 May 2025 07:09:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8B16E40BA4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B16E40BA4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EqceXNBM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8B16E40BA4
	for <virtualization@lists.linux-foundation.org>; Tue, 13 May 2025 07:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747120151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ictuYZNb6FVZjqSx9xqiqhjaQBRlicpN74huBXSGg4Q=;
	b=EqceXNBMz/AnZLD4T5Qqskb6/p46ZOXk/FF+WQEb7a2REEyGp1ttUVmdqNPrj8mI0czaBy
	cCMF746T/pkYbdTe4CjRfwgkqp5eiqp5nEa+4L8y1kQM7x/kdBbwHOcR9ufLArqzRJbkcU
	6mMHZ6x2OiYW0c7S1tMokY4lYdq+EOY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Hp_RWmMxN56r3M-vQUA-nA-1; Tue, 13 May 2025 03:09:10 -0400
X-MC-Unique: Hp_RWmMxN56r3M-vQUA-nA-1
X-Mimecast-MFC-AGG-ID: Hp_RWmMxN56r3M-vQUA-nA_1747120150
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5d608e6f5so1365546485a.0
        for <virtualization@lists.linux-foundation.org>; Tue, 13 May 2025 00:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747120149; x=1747724949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ictuYZNb6FVZjqSx9xqiqhjaQBRlicpN74huBXSGg4Q=;
        b=X9nFO9te2scZDLIvS1RCZfNpMQYb5fMVo0CYRrGsKOdjQrZ3TGoUBfoQ0Lxw+QcaHk
         iLjmtWEMdXMXsdJtJfc8ZDECdwpJ9ci5GKtSrf32W6F9yaIPMjrWNr7tvcIchg+tVRMK
         N2C8Zytxg5Sv4hgaonngtd73JZ3K2IPFyH1BjdjXvIfNTGPKclj0zM7MYTOyynDdVp6U
         nH/5BLpdN7Dr8PBpcHI51jOXk6COQQLKywnLgmfWmr8gclN8BFm/jCzt5vW0ytyKbwV5
         OStP7s6Uz17xfA8XNzreOE5S83y6qsDl8PjmbF/i/GEzgCa4he3jyAmInEP3apRCQ+wu
         b+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyaAkLbsou+UKWz+OokhFBqcjsGhdh3KpPZrvreKsGJ4JHZ6LYr0UC79kfX3WxPPzZsvRqO1ear6tdHtg2zQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzRbLc5eXRQDlDX4UTXMA3KxH8pDF4SUwkbFJnliJacd0R0OPOE
	tWxO6wfIVK8j8InkzTznYTdBVYiaDURxCjAdbfS2RffFRuwnLbo9xw6ECMl80duE/SdaY3qADoM
	Y4fY9d4a1WDvUBTwkf3FX8faYtbKiohIsMVmQqoHSm511heSXhzalOPrHj0Hr/vbO/9Xr93f7jO
	PBxqkxyZVDSCs=
X-Gm-Gg: ASbGnctO5jP2HLr3wHfnnjMILVOUI0STbDdc9qeUY0eurynBKxvLy1scxKktnrnnmQ7
	mvLwDeV5ioFnE6qyavztGIG3tSkvTYWO6Yl2CJeiwsjRi6bfQQN5d99LKNvuozcTEInswHjhvvt
	tVFgIouEYcKn5wsYejjTb62nSell+Rdl5PA/FwXoDHkFSj/dPpfJ/Ti/vFvbi/1AuimOJ6nJ9QJ
	IFro/zIUxoPJEZlun+5buPRuwL6b0dPcXWzn2DARhXxJT9rOOoX3dkc3GsvYCo5DI9TjIsNF2M=
X-Received: by 2002:a05:620a:4713:b0:7c7:827b:46bf with SMTP id af79cd13be357-7cd01157860mr2152118485a.39.1747120149330;
        Tue, 13 May 2025 00:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHE6qp6nrOSTcG+29z71S/WIjLeU7OplRtOWMeb0fjKhF4V91wQ9LbTTAnYfdMSFrrXtZqgw==
X-Received: by 2002:a05:622a:2290:b0:494:7835:1013 with SMTP id d75a77b69052e-49478351232mr90416531cf.36.1747120132570;
        Tue, 13 May 2025 00:08:52 -0700 (PDT)
Received: from redhat.com ([5.28.174.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49458d378b7sm56066541cf.14.2025.05.13.00.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 00:08:51 -0700 (PDT)
Date: Tue, 13 May 2025 03:08:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250513030744-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org>
 <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org>
 <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KFv5_kQLVWSOEjunGMQ2ZIJrSHIv5sc2K_L6AbPveHU_1747120150
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> On Wed, Apr 30, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > On Tue, Apr 29, 2025 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > > > > is disabled, and any attempt to use it will result in failure.
> > > > > > >
> > > > > > > I think we need to describe why the default value was chosen to be false.
> > > > > > >
> > > > > > > What's more, should we document the implications here?
> > > > > > >
> > > > > > > inherit_owner was set to false: this means "legacy" userspace may
> > > > > >
> > > > > > I meant "true" actually.
> > > > >
> > > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > > applications need to be modified in order to get the behaviour
> > > > > recovered which is an impossible taks.
> > > > >
> > > > > Any idea on this?
> > > > >
> > > > > Thanks
> >
> > So, let's say we had a modparam? Enough for this customer?
> > WDYT?
> 
> Just to make sure I understand the proposal.
> 
> Did you mean a module parameter like "inherit_owner_by_default"? I
> think it would be fine if we make it false by default.
> 
> Thanks

I think we should keep it true by default, changing the default
risks regressing what we already fixes. The specific customer can
flip the modparam and be happy.

> >
> > --
> > MST
> >

