Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AE183CC1
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050536; cv=none; b=ocH+6K9ZfL7RXg20GjJKnTIIlKFhFLLlkvK5Z35r41ufvp/70qFYbpE7DX7MNVp2Ho6390Nw9l+fIdTgbBiuqwkluumMjXnNmYpQH84FAjOindixOmZjsMdleXBn9zHr973mrZZ+3p58JCn6BvZzj1+nEzwE6lGufY02DpuG8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050536; c=relaxed/simple;
	bh=2SzCZbund/8+O5h+eegsBrUTgDD+fcadIowoFowp6x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HPWu4KiC+KuIoYKq40Rpnr2Y4Kvbwq/sXFD1nAfEOrkDYactO7HuSuTJlPIWbB5AqMLPblqHcpdBe4CCWeM1bwjbvkFE3+byLiWRxQVbx1AOou3lvS+38y7N2hXCMtUvmmn4gK+HZQ1hAkFK4IAiuZiK1fx5IVVbnwMO73GV+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5+jkxMS; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5+jkxMS"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0148940A3B
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 10:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fY1PYA3uFjcU for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Sep 2024 10:28:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7107D40126
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7107D40126
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c5+jkxMS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7107D40126
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 10:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726050531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ungg+nmZJyrc06QTgx8FJetOw+81QXiJdZ2W9hPPJE8=;
	b=c5+jkxMSNRcaJ5EQi5OLNiLP74Ut13HMidczaVTj77+GwjrGabzCRlqQgMIzaNdqoj4zlq
	WUTxTPZMLjxz5Np0tFhjNwCT6aCs95DvTMhE0h4CB/Lus8TpdhhJX1hChxmyt50XC0TB/H
	V+Y2XBwSYeO+WYonMoapNEEYK1CV+Po=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-_OL6As97MoamfKp_VYIhyQ-1; Wed, 11 Sep 2024 06:28:50 -0400
X-MC-Unique: _OL6As97MoamfKp_VYIhyQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a870f3a65a0so477426566b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 03:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050529; x=1726655329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ungg+nmZJyrc06QTgx8FJetOw+81QXiJdZ2W9hPPJE8=;
        b=dIms/Odd8UMGYJ6LhrECVOavKY3qk3y4BdmIIKq3ab7v4pqiYMtAT6A9XECZYe0bmD
         At9+ywNs7/UIPMmJVmID64UlMFl4YVK5YeQc8V82U952gyfKcwdRLobsFcxo/mpYqfue
         AqhVlJpTklw3hji3e2aHdkRVI13xDAtoGjOQAwVzR470+vcojyHCrj14ptNJhaffpGUC
         HBU1SG9xsHLKil0tDHCqcCsoyF7CjABVYUxtAFlVluwffYcGJnbb0nY1gY5Nf/OsuYx8
         jSXKfKZjqeGvDxHGl725npYFLY1YVD60ncy0EsQWbNyOtifnmzASM1xf/SRS3Ps0cZlf
         30xA==
X-Forwarded-Encrypted: i=1; AJvYcCULUiSANLEP097x0KqeDI5wqX2H+bE/+9iwBq7mt8ZIfYYLsqjnzgz7wUdimZzOyqfsEJ0IGm4aAj3HrayW3g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyEdFf2JwKrdf8pTrVcgvUW9GmgKgT5INrJLYHoX/SEjqHIxCIU
	UU2CrCXivawbRDb0G5Q46HK9EKgbqBwdeMb18QcVduFmZOqy9ka/+HUawgHYZMvR3Yc48aTIQ6t
	6jFsPUJ+2uBRb9tREVALREFvIOq5dnjZikebpna5dD2DUG+KZorVx6RtDLak8qb1wTnu6GMXEFV
	VJanOk/tgnmyI=
X-Received: by 2002:a17:907:6088:b0:a7a:a06b:eecd with SMTP id a640c23a62f3a-a8ffaa97ad0mr405395166b.5.1726050529236;
        Wed, 11 Sep 2024 03:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdWhWOZU7QkzTME7FbxXasitdSQaPrXkBs6SATTiPZutMleWrLvta0s5wcF0PEmNDJ7LftVQ==
X-Received: by 2002:a17:907:6088:b0:a7a:a06b:eecd with SMTP id a640c23a62f3a-a8ffaa97ad0mr405392566b.5.1726050528519;
        Wed, 11 Sep 2024 03:28:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a09e21sm597513166b.84.2024.09.11.03.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:28:47 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:28:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
Message-ID: <20240911062741-mutt-send-email-mst@kernel.org>
References: <20240909020138.1245873-1-lulu@redhat.com>
 <20240910032825-mutt-send-email-mst@kernel.org>
 <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
 <20240910044139-mutt-send-email-mst@kernel.org>
 <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 11, 2024 at 11:45:33AM +0800, Jason Wang wrote:
> On Tue, Sep 10, 2024 at 4:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 10, 2024 at 04:37:52PM +0800, Jason Wang wrote:
> > > On Tue, Sep 10, 2024 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> > > > > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > > > > vhost removed the support for the kthread API. However, there are
> > > > > still situations where there is a request to use kthread.
> > > > > In this PATCH, the support of kthread is added back. Additionally,
> > > > > a module_param is added to enforce which mode we are using, and
> > > > > a new UAPI is introduced to allow the userspace app to set the
> > > > > mode they want to use.
> > > > >
> > > > > Tested the user application with QEMU.
> > > >
> > > > Cindy, the APIs do not make sense, security does not make sense,
> > > > and you are not describing the issue and the fix.
> > > >
> > > >
> > > > The name should reflect what this does from userspace POV, not from
> > > > kernel API POV.  kthread and task mode is not something that any users
> > > > have any business even to consider.
> > > >
> > > >
> > > > To help you out, some ideas:
> > > >
> > > > I think the issue is something like "vhost is now a child of the
> > > > owner thread. While this makes sense from containerization
> > > > POV, some old userspace is confused, as previously vhost not
> > > > and so was allowed to steal cpu resources from outside the container."
> > > >
> > > > Now, what can be done? Given we already released a secure kernel,
> > > > I am not inclined to revert it back to be insecure by default.
> > >
> > > It depends on how we define "secure". There's plenty of users of
> > > kthread and if I was not wrong, mike may still need to fix some bugs.
> > >
> >
> > which bugs?
> 
> https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com/T/

Isn't this exactly what Cindy is trying to address?
You made it sound like there is something else.

> >
> > > > But I'm fine with a modparam to allow userspace to get insecure
> > > > behaviour.
> > > >
> > > >
> > > > Now, a modparam is annoying in that it affects all userspace,
> > > > and people might be running a mix of old and new userspace.
> > > > So if we do that, we also want a flag that will get
> > > > safe behaviour even if unsafe one is allowed.
> > >
> > > I am not sure this can help. My understanding is that the flag is
> > > sufficient. Otherwise the layered product needs to know if there's old
> > > user space or new which seems to be a challenge.
> > >
> > > Thanks
> >
> > this will be up to userspace to resolve.
> 
> I actually mean the module parameter. It would be very hard for the
> layered product to decide the value for that.
> 
> Thanks

We can make it writeable, if that helps.


> >
> >
> > > >
> > > >
> > > > Is this clear enough, or do I need to elaborate more?
> > > >
> > > > Thanks!
> > > >
> > > > > Cindy Lu (7):
> > > > >   vhost: Add a new module_param for enable kthread
> > > > >   vhost: Add kthread support in function vhost_worker_queue()
> > > > >   vhost: Add kthread support in function vhost_workers_free()
> > > > >   vhost: Add the vhost_worker to support kthread
> > > > >   vhost: Add the cgroup related function
> > > > >   vhost: Add kthread support in function vhost_worker_create
> > > > >   vhost: Add new UAPI to support change to task mode
> > > > >
> > > > >  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++++--
> > > > >  drivers/vhost/vhost.h      |   1 +
> > > > >  include/uapi/linux/vhost.h |   2 +
> > > > >  3 files changed, 240 insertions(+), 9 deletions(-)
> > > > >
> > > > > --
> > > > > 2.45.0
> > > >
> >

