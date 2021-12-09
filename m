Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4384EC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 07:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6995409B2;
	Thu,  9 Dec 2021 07:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZaCRoN41WlRV; Thu,  9 Dec 2021 07:56:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8CAF0404CA;
	Thu,  9 Dec 2021 07:56:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65155C001E;
	Thu,  9 Dec 2021 07:56:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9FCC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 07:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2288B82CDD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 07:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TOFYfoDtfg36
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 07:56:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E34B582CF1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639036566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S66C8CNSKnx/Z7swhzNHa3UhZIUtvxjrYYA62uAg628=;
 b=bqqAscmSYdiVoCENq6+OVrkxwKvNWmhJsinq7yjmuTeBawr6WcJ6KZ4sUaqf51RVmK3qyN
 KixIAqcqY3e2ebuKp0DSYi4Tgp8pBlNFaKiMG8xcueiqd0GTCr62PgfiVYKm6dxQ8FAYZK
 8M/HfmaT7QFtN1P62zrP8ykuCPGGihw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-lFJsogHQNQ2mClqdkLDMxg-1; Thu, 09 Dec 2021 02:56:05 -0500
X-MC-Unique: lFJsogHQNQ2mClqdkLDMxg-1
Received: by mail-lf1-f72.google.com with SMTP id
 u20-20020ac24c34000000b0041fcb2ca86eso92530lfq.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 23:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S66C8CNSKnx/Z7swhzNHa3UhZIUtvxjrYYA62uAg628=;
 b=U3k13jfpDFMOD3LRKfzcnJcG3a0122EPBLBw5v6rUs9dAYzcA2MCZ0hs2+PwDCk+zT
 rUkeSDAxbs+z4vJZGjldlcKKEu0ZGnezdc9TNQ+UnUAPo2jGOvZnV9RNTWfwLSvvdC5O
 pReMo+yY3aPdyswFPwhjE+U8Z14Zr9aj7KghMhNA3VSJnhGGjbjf0sVQaed7WQU9tWWs
 EBQyGCoTJWNR9uBBBCvf3/s+zrZhunaXdotV5u/ulVogLrLDDp3Moxku6eGTHMwF5dha
 tIC6fKrYLGyd8SVpke28dJ76/fznpoHKZIeyTOoUUlqPSp6/9lZ27sQFIOIXPvCrRNOo
 XJaQ==
X-Gm-Message-State: AOAM532lzu1naqdxnpM6eoD32pYiaAkF5agVkFrQyn3gqwF3v4nfCXTX
 VyRzAfd8JxKUd35hBRwW5OYwG+JJ0DQy8So74elTsQjjs58pjeS+YDFFQ9jj8vgcbnLRUhe84hh
 1TmIF59tdePabYLHxDUEa8w0fdEr6p13XnTi11cnvsKj8RnaVD1cNwp1k5w==
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr4680092ljk.420.1639036563942; 
 Wed, 08 Dec 2021 23:56:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8UkUhP3zFfRJtYQZxLVzVzPMYYjaFa7amL06Dm1gdoXcpF4WeSzI+TE+iNnEJvSyyJNJQ0nzMLuTET+RzAik=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr4680069ljk.420.1639036563733; 
 Wed, 08 Dec 2021 23:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-2-elic@nvidia.com>
 <CACGkMEsa82RV2-Yp3V3fYEPgNogfaG_0s-_tGYR6QYmgqB65HQ@mail.gmail.com>
 <20211209070654.GD108239@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211209070654.GD108239@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 15:55:53 +0800
Message-ID: <CACGkMEvcptE733sE_C4D3dx2WfScCxxn4cSB_f=3K-0OCTtyZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] vdpa: Provide interface to read driver features
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Thu, Dec 9, 2021 at 3:07 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Thu, Dec 09, 2021 at 01:33:01PM +0800, Jason Wang wrote:
> > On Thu, Dec 9, 2021 at 4:14 AM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Provide an interface to read the negotiated features. This is needed
> > > when building the netlink message in vdpa_dev_net_config_fill().
> > >
> > > Also fix the implementation of vdpa_dev_net_config_fill() to use the
> > > negotiated features instead of the device features.
> > >
> > > To make APIs clearer, make the following name changes to struct
> > > vdpa_config_ops so they better describe their operations:
> > >
> > > get_features -> get_device_features
> > > set_features -> set_driver_features

[...]

> > > + * @get_driver_features:       Get virtio features in action
> >
> > Maybe "Get virtio driver features .." is better.
>
> I hope the name does not become too long.
> Which one would you favor?
>
> get_vio_driver_features
> get_virtio_drv_features
> get_virtio_driver_features

The name is fine, I mean the comment might be

"Get the virtio driver features in action"

Thanks

>
> >
> > Thanks
> >
> > > + *                             @vdev: vdpa device
> > > + *                             Returns the virtio features accepted
> > >   * @set_config_cb:             Set the config interrupt callback
> > >   *                             @vdev: vdpa device
> > >   *                             @cb: virtio-vdev interrupt callback structure
> > > @@ -276,8 +279,9 @@ struct vdpa_config_ops {
> > >
> > >         /* Device ops */
> > >         u32 (*get_vq_align)(struct vdpa_device *vdev);
> > > -       u64 (*get_features)(struct vdpa_device *vdev);
> > > -       int (*set_features)(struct vdpa_device *vdev, u64 features);
> > > +       u64 (*get_device_features)(struct vdpa_device *vdev);
> > > +       int (*set_driver_features)(struct vdpa_device *vdev, u64 features);
> > > +       u64 (*get_driver_features)(struct vdpa_device *vdev);
> > >         void (*set_config_cb)(struct vdpa_device *vdev,
> > >                               struct vdpa_callback *cb);
> > >         u16 (*get_vq_num_max)(struct vdpa_device *vdev);
> > > @@ -395,7 +399,7 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > >         const struct vdpa_config_ops *ops = vdev->config;
> > >
> > >         vdev->features_valid = true;
> > > -       return ops->set_features(vdev, features);
> > > +       return ops->set_driver_features(vdev, features);
> > >  }
> > >
> > >  void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
> > > --
> > > 2.33.1
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
