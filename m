Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCB16F27E
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957785; cv=none; b=F3E1zc+qk+w0E2PAnSw4mK82OMUsA6egCPoZizy4/js7N5hQzmzfoQs6lvSUVeAp2RLr96cJIdbY3OvmnW5Ex/TjACOWEMl1GpWaL9Kv8SbnMEQUDfRzGOnO+1nc15sE1cBXGBstXoa7tMDhidIBZYPxTvH/6IT1NWPpi0sTVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957785; c=relaxed/simple;
	bh=ihGFXKSdNq1acfmeBeiDK3GKtbP9QbngzFbcDCCyUBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sRWHtWSjjVuZFaB5lCA3vS8yd6jSBh/ZRsjdYKB4rO0RWzHlrj7wvwew/gJ6+PsXVUz6LaW/CgyM0F3vljthaIiL8X8eSzESyHKfIJETcErpV4C0yHgAAaeI5r2kFSDkF3hqoInYZOdZ0o/U/ALRUDFhyhQWwjMfTW4aouAHbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHn+tIHI; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHn+tIHI"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6699440450
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 08:43:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 94X32YgJwpXk for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Sep 2024 08:43:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4B992401A4
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B992401A4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EHn+tIHI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B992401A4
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 08:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725957782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTFhbUrNZRNdJ67rXYj34xiYWTFaYUZHryTDusV4E/w=;
	b=EHn+tIHIFY8Hw2CY6KbMU9Zl7OjzfVfMaXG3ogkS2tNLgmewF9JihFoGYULNGG5/PEjtmB
	l/37bD63ZNhKZQAiNHYeS2GqPD+9YfT/Io2TKJ7gZnYEoR4gpAnXhVN0v0S+fmN65dGeQu
	wkLRtn66CyerwfUISY7YaGSYzeNLvB8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-HxRS8-9oNSeJtR4QmiqXPQ-1; Tue, 10 Sep 2024 04:43:01 -0400
X-MC-Unique: HxRS8-9oNSeJtR4QmiqXPQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb99afa97so13484375e9.2
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Sep 2024 01:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957780; x=1726562580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTFhbUrNZRNdJ67rXYj34xiYWTFaYUZHryTDusV4E/w=;
        b=bhfNRNXOZy8umdl2LrBHNVqBcJ/ZSZtI4McixIVlGeeQOPFt7KIayy55ODmtg8haj+
         nXi3z3g7XGCmwJN+iiIre0GkOqy36yrRHJOSCI2NZoBNPKUJVGuupjbVpvzOaXTOsdHB
         uXovVrq7p+wweg0Em31osMHnE5Uu/obA1wz19+iIgCuCIp1h4OsYp+s+lssFEG7LcAIV
         UWqROeIVxAEsQfnSC1hKHkXlRWZqwvy4HrQwSKR6Wv1r6B8XYs64d/GuXIxvho0P+g2t
         vvS49yHL2khlt7DYtER7QrogShmKwZcS0hME8gvZFy8ru8hlcDlaFXYa4z3Tf7GXH3YB
         qCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVafUVDz7dfnL19x6VaaybRaGr/arnQnaB1G7G71/6AuwoE1QattcE2a54aBxzk2c8OranDHyEV8kEOyw7DAA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxTNkzioDT83g4k1dSODocl0DhKMLaB1SsBphGSXUfnYFNYVlQT
	e2yB9ZnU7PhlRl+BObpvXTtXLKQX9vTKqYrS2hAbmM5knEWoVwvGr4Fzy+CfTAni3v18WyfxdqW
	wSoQnx3zDHADnQ2Om+dfsk+DBZjRiOymTEhVEz+jgbVzvjVF6ES6N9e1Y8rWOkaibahWE3EstCv
	oTuMg=
X-Received: by 2002:a05:600c:1d8a:b0:42c:b0f9:9b28 with SMTP id 5b1f17b1804b1-42cb0f99c0amr67407165e9.28.1725957779664;
        Tue, 10 Sep 2024 01:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPns4vTGAdO8znaVJVGMHVa1kyeW8lXfvHZwGX/F3imSQLPTE0WFTpfxqcqz4Ud12xzFMAwg==
X-Received: by 2002:a05:600c:1d8a:b0:42c:b0f9:9b28 with SMTP id 5b1f17b1804b1-42cb0f99c0amr67406955e9.28.1725957779082;
        Tue, 10 Sep 2024 01:42:59 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca7cccd35sm121482885e9.18.2024.09.10.01.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:42:58 -0700 (PDT)
Date: Tue, 10 Sep 2024 04:42:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
Message-ID: <20240910044139-mutt-send-email-mst@kernel.org>
References: <20240909020138.1245873-1-lulu@redhat.com>
 <20240910032825-mutt-send-email-mst@kernel.org>
 <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Sep 10, 2024 at 04:37:52PM +0800, Jason Wang wrote:
> On Tue, Sep 10, 2024 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> > > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > > vhost removed the support for the kthread API. However, there are
> > > still situations where there is a request to use kthread.
> > > In this PATCH, the support of kthread is added back. Additionally,
> > > a module_param is added to enforce which mode we are using, and
> > > a new UAPI is introduced to allow the userspace app to set the
> > > mode they want to use.
> > >
> > > Tested the user application with QEMU.
> >
> > Cindy, the APIs do not make sense, security does not make sense,
> > and you are not describing the issue and the fix.
> >
> >
> > The name should reflect what this does from userspace POV, not from
> > kernel API POV.  kthread and task mode is not something that any users
> > have any business even to consider.
> >
> >
> > To help you out, some ideas:
> >
> > I think the issue is something like "vhost is now a child of the
> > owner thread. While this makes sense from containerization
> > POV, some old userspace is confused, as previously vhost not
> > and so was allowed to steal cpu resources from outside the container."
> >
> > Now, what can be done? Given we already released a secure kernel,
> > I am not inclined to revert it back to be insecure by default.
> 
> It depends on how we define "secure". There's plenty of users of
> kthread and if I was not wrong, mike may still need to fix some bugs.
> 

which bugs?

> > But I'm fine with a modparam to allow userspace to get insecure
> > behaviour.
> >
> >
> > Now, a modparam is annoying in that it affects all userspace,
> > and people might be running a mix of old and new userspace.
> > So if we do that, we also want a flag that will get
> > safe behaviour even if unsafe one is allowed.
> 
> I am not sure this can help. My understanding is that the flag is
> sufficient. Otherwise the layered product needs to know if there's old
> user space or new which seems to be a challenge.
> 
> Thanks

this will be up to userspace to resolve.


> >
> >
> > Is this clear enough, or do I need to elaborate more?
> >
> > Thanks!
> >
> > > Cindy Lu (7):
> > >   vhost: Add a new module_param for enable kthread
> > >   vhost: Add kthread support in function vhost_worker_queue()
> > >   vhost: Add kthread support in function vhost_workers_free()
> > >   vhost: Add the vhost_worker to support kthread
> > >   vhost: Add the cgroup related function
> > >   vhost: Add kthread support in function vhost_worker_create
> > >   vhost: Add new UAPI to support change to task mode
> > >
> > >  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++++--
> > >  drivers/vhost/vhost.h      |   1 +
> > >  include/uapi/linux/vhost.h |   2 +
> > >  3 files changed, 240 insertions(+), 9 deletions(-)
> > >
> > > --
> > > 2.45.0
> >

