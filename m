Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9898C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 16:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EAF382F50;
	Tue, 11 Jan 2022 16:36:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AmDENW4RCXIz; Tue, 11 Jan 2022 16:36:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 91DA482F11;
	Tue, 11 Jan 2022 16:36:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D140C002F;
	Tue, 11 Jan 2022 16:36:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B545C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5268D82F50
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MjkbiQEFg2Ak
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:36:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F30682F11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641918968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gn+nUfUnJ8bM6O0Cx1Mu1MvQAS+2xdXz355bjhwI1V4=;
 b=dUKxn7JOnGKmgT5+iUUUdeKsOsdOVUwZrKsVg7JN5eEsGtsspc1zINkDBE9J535JnxJd61
 Mh0xzVCG1l2+2yHHzvh3yqKQPv2sXS+IC/VUCBMoYIp0mta+bbRI2k7lnhwOnb2i5M8BK0
 7xsvuPoc3IMudr9M3R/yy4+h0SqUYKI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-z4q82nJ7PyKTf8_1xVdQag-1; Tue, 11 Jan 2022 11:36:07 -0500
X-MC-Unique: z4q82nJ7PyKTf8_1xVdQag-1
Received: by mail-ed1-f72.google.com with SMTP id
 x19-20020a05640226d300b003f8b80f5729so13706753edd.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gn+nUfUnJ8bM6O0Cx1Mu1MvQAS+2xdXz355bjhwI1V4=;
 b=d6oJd1IPGRay6xHrAOqWCNavYwUQN724OmoyJoOwnnMOc4MEQsNn0nij2Yb5xxNPJh
 iSLMonkoCZAfbsXKQuWH5PUabizcnsKYRL9IRUy9leAbsWGbBOGUuXWEkvogdU5axJQ1
 LsyDhNinEdWBC867A1uenG+qAMTmMDkgC7DKPyg0/sxnITvWuOEi4qa8lpW5x5pTKFSo
 gG/6oOb8MfMNZfSIG3WWHHbbogupkStzC5pe222uUkf99vWeRYXnzv2E3jeG8xIgE3PB
 r/7q57qKKFhgN3BZw62wrj2YNys/UVMYG5+eJ918WM/R9tgj5fEvxra/US3wqB+yg+L3
 f/WQ==
X-Gm-Message-State: AOAM5335IBeqWnkm0wjj09TCqPn4z/TQO1+x8jjcHZ+P3lT9EFyIqBVA
 8NMpGYpq9MLJ3/HrhgQSnYpnmSsFQoX1SCCt08rUfdRVb1QxQAEHsC9NkZrDhL5wtvzBM682sUe
 jO6jJBFSh06cMfxXIzNunihzXCIXUMKLqj7Uu51zpSQ==
X-Received: by 2002:a05:6402:2791:: with SMTP id
 b17mr5162146ede.373.1641918966178; 
 Tue, 11 Jan 2022 08:36:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAOGAa8XxbjlR5ChM+jqwSxHXDq5DATsCueJccfCjF776h61ZJMAndY2vvZhU5tChwCuBSYQ==
X-Received: by 2002:a05:6402:2791:: with SMTP id
 b17mr5162131ede.373.1641918965991; 
 Tue, 11 Jan 2022 08:36:05 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id gt38sm642440ejc.114.2022.01.11.08.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 08:36:05 -0800 (PST)
Date: Tue, 11 Jan 2022 11:36:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/4] vdpa: Protect vdpa reset with cf_mutex
Message-ID: <20220111112941-mutt-send-email-mst@kernel.org>
References: <20220111072217.101836-1-elic@nvidia.com>
 <20220111105833-mutt-send-email-mst@kernel.org>
 <20220111161238.GA168233@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20220111161238.GA168233@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, si-wei.liu@oracle.com
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

On Tue, Jan 11, 2022 at 06:12:38PM +0200, Eli Cohen wrote:
> On Tue, Jan 11, 2022 at 11:01:01AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Jan 11, 2022 at 09:22:17AM +0200, Eli Cohen wrote:
> > > Call reset using the wrapper function vdpa_reset() to make sure the
> > > operation is serialized with cf_mutex.
> > > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > The motivation is vague here, this does not really explain.
> > Which operations are we trying to serialize?
> > Multiple reset requests from userspace?
> > Is anything broken right now without this patch?
> 
> vdpa_reset will reset the features which can be read or even be set
> through devlink (see vdpa_get_config_unlocked()). So this lock ensures
> serialization of the operations to ensure consitent value is read.

My point is that this is the kind of thing that needs to go into commit log.
A good log for a bugfix looks like this:


if XYZ triggers a vdpa reset while ABC is reading the features through
devlink, with the result that EFG.  Similarly for write which can lead
to HIJ.

Fix this by calling reset using the wrapper function vdpa_reset() to make sure the
operation is serialized with cf_mutex.

Fixes: <hash> ("subject")



> > 
> > > ---
> > >  drivers/vhost/vdpa.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 6e7edaf2472b..fe0bbea4dab6 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -155,7 +155,6 @@ static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
> > >  static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> > >  {
> > >  	struct vdpa_device *vdpa = v->vdpa;
> > > -	const struct vdpa_config_ops *ops = vdpa->config;
> > >  	u8 status, status_old;
> > >  	int ret, nvqs = v->nvqs;
> > >  	u16 i;
> > > @@ -177,7 +176,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> > >  			vhost_vdpa_unsetup_vq_irq(v, i);
> > >  
> > >  	if (status == 0) {
> > > -		ret = ops->reset(vdpa);
> > > +		ret = vdpa_reset(vdpa);
> > >  		if (ret)
> > >  			return ret;
> > >  	} else
> > > -- 
> > > 2.34.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
