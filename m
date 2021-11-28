Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07415C433EF
	for <virtualization@archiver.kernel.org>; Sun, 28 Nov 2021 07:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8899D83051;
	Sun, 28 Nov 2021 07:45:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4idg4k3-yIFB; Sun, 28 Nov 2021 07:45:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D11583033;
	Sun, 28 Nov 2021 07:45:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8290C001C;
	Sun, 28 Nov 2021 07:45:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C47EC000A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 07:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EE9141BF6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 07:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qSDVVMzGJiZT
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 07:45:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F365E41BF2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638085534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z08EGI7tQBLg65GMt02gA8JynjRy6lC2as9YkmM/wdI=;
 b=fYvbmpMtFAqS6zl7IFdFYMa5ZCRvs5f0JgpX/KnctV44JaZJsKUm+eTzk8/oI8vomyWUvm
 J26BpgIIQ4qXLaT7F1gAxfJ9B7Ave4JLsr5JtFa0NY0Gvnkft00QYtCA8VFP9NVJMve2O4
 zqAq6poRbemcFXmSOAk6AwmO8xElgI0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-dkAlT-kgNM6WmhfyFUh_sA-1; Sun, 28 Nov 2021 02:45:33 -0500
X-MC-Unique: dkAlT-kgNM6WmhfyFUh_sA-1
Received: by mail-ed1-f69.google.com with SMTP id
 t9-20020aa7d709000000b003e83403a5cbso11109905edq.19
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 23:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z08EGI7tQBLg65GMt02gA8JynjRy6lC2as9YkmM/wdI=;
 b=C+up4MnZ6jGcYg14cUS8SRJ7FblqxHmd6jMaXhwNDY8VheAwWXjnStJeBYGRYfXFkl
 rF4Zxpb6nvtY5kh98OJwK7B2+c4+Z6ewxoVWuVMGNZ23L9crTOGe59zISjLrlQ3JK4of
 RcLMsOQdKDv4Yp8UGVn3SIfeOCaZm4EQN/biBxgf/m9evYD7h/5qL07zoqA1fmb2YKma
 5DfUEfvRuYK83bIbf3lkNxEFqO31bEVLdiquCul5JnVmV82QVd3P0lEQFa/eqp2RjHVd
 WeJyghFYlsNBG72Oqxh1WXqPqJUUDcRMM0rDZ3i9SKGPttXa3UNx54CxoYWnh6Fz0r8D
 8H9Q==
X-Gm-Message-State: AOAM5316tz/ho+9ZXjDeyiv1RaUqF976De/x6CFvKCotm48k4CTWuFjh
 Xnh6SDsPdIpytqcl0H7crjxtS3oEMYWiXAz47qru5I5r+uBaa1jwcurH+q3Q2VuoXhDrNo9q6H/
 mlc1yXOylZla3xX1Hymi75MTn9IX3WcEIai7+zLA0cg==
X-Received: by 2002:a17:906:128d:: with SMTP id
 k13mr52481724ejb.517.1638085531875; 
 Sat, 27 Nov 2021 23:45:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkWlbeB6VAhnUWHCz1wbS9/RSFtufEB+7eUoN2h/ifaRlddcSii60fj/U2nHH4ps4pkXvriA==
X-Received: by 2002:a17:906:128d:: with SMTP id
 k13mr52481701ejb.517.1638085531669; 
 Sat, 27 Nov 2021 23:45:31 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207f:33c6:2c25:1862:302e:8fc2])
 by smtp.gmail.com with ESMTPSA id w23sm6807390edr.19.2021.11.27.23.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Nov 2021 23:45:31 -0800 (PST)
Date: Sun, 28 Nov 2021 02:45:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa: Consider device id larger than 31
Message-ID: <20211128024206-mutt-send-email-mst@kernel.org>
References: <20211125180915.649652-1-parav@nvidia.com>
 <CACGkMEtF+kjj_vryxXAo6PqeX3Puk-XxaaQMcu4mhB1WZRXEpw@mail.gmail.com>
 <20211128071435.GB99190@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20211128071435.GB99190@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, kbuild@lists.01.org,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Sun, Nov 28, 2021 at 09:14:35AM +0200, Eli Cohen wrote:
> On Fri, Nov 26, 2021 at 10:48:12AM +0800, Jason Wang wrote:
> > On Fri, Nov 26, 2021 at 2:09 AM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > > virtio device id value can be more than 31. Hence, use BIT_ULL in
> > > assignment.
> > >
> > > Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > > ---
> > >  drivers/vdpa/vdpa.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 7332a74a4b00..e91c71aeeddf 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -404,7 +404,7 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
> > >                 goto msg_err;
> > >
> > >         while (mdev->id_table[i].device) {
> > > -               supported_classes |= BIT(mdev->id_table[i].device);
> > > +               supported_classes |= BIT_ULL(mdev->id_table[i].device);
> > >                 i++;
> > >         }
> > >
> 
> type of mdev->id_table[i].device is __u32 so in theory you're limited
> to device ID's up to 63.
> Maybe add assert here?

I think 1 << 63 is illegal though.

> > > --
> > > 2.26.2
> > >
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
