Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF3CC433F5
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 15:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A4E6400C9;
	Tue, 15 Mar 2022 15:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16_lc4tNiDAR; Tue, 15 Mar 2022 15:16:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D32274057C;
	Tue, 15 Mar 2022 15:16:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92FDAC0012;
	Tue, 15 Mar 2022 15:16:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 540F2C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 15:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3510560FDB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 15:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ZHEYx9xoFKD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 15:16:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0EA860FD5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647357360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kyz2RUFrfzcWwytFdN8JKP5rzgj6KOwPxkBy/7oRIpU=;
 b=Mt1FuisqvzWfDbARf0R7HR5XQoTbO7KmXS9keGZiqiTBp/yppxgn3gVGuK1q99pwKC2TIX
 3ZF0zY5ouhKmtQPME2GVQlnssiR48n6xI+/JjReD0MPhSFotzZLmttLuBTY7YMeHpfaENU
 QdEDoqjPFd97V8dLbbD3yZR0BQ+JES0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-q9iuvsSCMMK_TJbkRRXsbQ-1; Tue, 15 Mar 2022 11:15:57 -0400
X-MC-Unique: q9iuvsSCMMK_TJbkRRXsbQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 t2-20020a7bc3c2000000b003528fe59cb9so1290068wmj.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kyz2RUFrfzcWwytFdN8JKP5rzgj6KOwPxkBy/7oRIpU=;
 b=jS9z2SfXbGivNH5R8c0IV9S3qVC+FIlS7RNbs1DwhjV79fJlgyU1dGyMMQdZuUcTbM
 PBTltFO8dKJO9GV2BOYMJXWLDBk/JP3g49Enn60VhIy2sl7t7Z4fcGOEbc+zrmC459CA
 NTfD9qbFnrcxlttycdyzb/bfvn0WAOI6JULw/w8eyNIosUsIYgUOiTOczuLzLraJcXys
 DMJHm+/2NVlK3EOg0/F4CkNzrDKCVuvm+piMt6BeuiHWpVyt8ZjYWF0BGmmIY8KDEcsp
 DwtBD1ApLimuiIBvsC/Lytd8+Dy55vOpeFmBwzT4E1xJeZC8VxgWLyDmhnFwDOL3QiGU
 RQow==
X-Gm-Message-State: AOAM5328Ju3EguoLDzsStBmgXRR0Eb1Fo85J7tfx20Ff2nlNT7Ex3xPZ
 3bSGV+ygbT3Z7PgYjxsHVi2aqR2I0kMv/HV2mIbv2DkSd6hkbNdzZ+bPMtCJxbLb2vXAk8hZN4E
 sSLfQgMK+NGu9qRGvk14gkTbxg8vW3QjXdHzMqXOtJQ==
X-Received: by 2002:a05:6000:3c3:b0:203:6976:6942 with SMTP id
 b3-20020a05600003c300b0020369766942mr20348024wrg.584.1647357355936; 
 Tue, 15 Mar 2022 08:15:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypmXByJXceCvTyDTeaeG4rtFjn8ylgA1heE6UhT+IFbX4r7V634CRa98A5VvIu9kER2FggTQ==
X-Received: by 2002:a05:6000:3c3:b0:203:6976:6942 with SMTP id
 b3-20020a05600003c300b0020369766942mr20347991wrg.584.1647357355683; 
 Tue, 15 Mar 2022 08:15:55 -0700 (PDT)
Received: from redhat.com ([2.53.2.35]) by smtp.gmail.com with ESMTPSA id
 ay24-20020a05600c1e1800b00389a420e1ecsm2498962wmb.37.2022.03.15.08.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 08:15:55 -0700 (PDT)
Date: Tue, 15 Mar 2022 11:15:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] vDPA/ifcvf: match pointer check to use
Message-ID: <20220315111456-mutt-send-email-mst@kernel.org>
References: <20220315124130.1710030-1-trix@redhat.com>
 <20220315092656-mutt-send-email-mst@kernel.org>
 <512a392d-23d7-c25b-7576-571001f28288@redhat.com>
MIME-Version: 1.0
In-Reply-To: <512a392d-23d7-c25b-7576-571001f28288@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: llvm@lists.linux.dev, ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, nathan@kernel.org,
 xieyongji@bytedance.com, lingshan.zhu@intel.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 15, 2022 at 08:03:26AM -0700, Tom Rix wrote:
> 
> On 3/15/22 6:28 AM, Michael S. Tsirkin wrote:
> > On Tue, Mar 15, 2022 at 05:41:30AM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > Clang static analysis reports this issue
> > > ifcvf_main.c:49:4: warning: Called function
> > >    pointer is null (null dereference)
> > >    vf->vring->cb.callback(vring->cb.private);
> > >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > The check
> > >    vring = &vf->vring[i];
> > >    if (vring->cb.callback)
> > > 
> > > Does not match the use.  Change dereference so they match.
> > > 
> > > Fixes: 79333575b8bd ("vDPA/ifcvf: implement shared IRQ feature")
> > Thanks a lot! I squashed this into the offending patch - no point in
> > breaking bisect. Pushed to linux. However I'm now
> > having second thoughts about applying that patchset - I'd like
> > soma analysis explaining how this got through testing.
> 
> static analysis is something i do treewide.
> 
> There are currently ~2500 issues in linux-next, do not panic! many are false
> positives.
> 
> It is pretty easy to setup and once you have a baseline you can filter only
> your files.
> 
> Tom

Thanks for that info! I was actually directing this question to the
contributor since the code does not look like it could have ever
worked. I don't have the hardware in question myself.


> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >   drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > index 3b48e717e89f7..4366320fb68d3 100644
> > > --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> > > +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > @@ -46,7 +46,7 @@ static irqreturn_t ifcvf_vqs_reused_intr_handler(int irq, void *arg)
> > >   	for (i = 0; i < vf->nr_vring; i++) {
> > >   		vring = &vf->vring[i];
> > >   		if (vring->cb.callback)
> > > -			vf->vring->cb.callback(vring->cb.private);
> > > +			vring->cb.callback(vring->cb.private);
> > >   	}
> > >   	return IRQ_HANDLED;
> > > -- 
> > > 2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
