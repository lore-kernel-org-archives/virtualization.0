Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399D5C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 07:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDF0040BC6;
	Thu,  9 Jun 2022 07:19:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WIl7ZO7tKUzQ; Thu,  9 Jun 2022 07:19:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 81EE04000B;
	Thu,  9 Jun 2022 07:19:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55143C0032;
	Thu,  9 Jun 2022 07:19:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E18EDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 07:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C255C60B91
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 07:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a01z1f-rV4_k
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 07:19:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AAC860B69
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654759176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LZJhp5L1ykqWD7LdN0E4Ox3CGQKebfkP1ixyik/IJxo=;
 b=HgBstNws9Eunb5gATT8vUJOL42RYBSpfJ7bQ7F+yq9fNyHB3QjRAQDONbgRGaHdiEeJzr6
 YP4YxQOdpUr4q7ghO0ivHQ+/buVf5/Cvy9cL01N+2KjYmThhJ9zHoWyokDM3p6XQxpDvyd
 uuUzdS6e+WWyz086QWgFe6yjfANbnZI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-WGWqAD6ZP4acO-uYgcUmNQ-1; Thu, 09 Jun 2022 03:19:35 -0400
X-MC-Unique: WGWqAD6ZP4acO-uYgcUmNQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 k8-20020a2e92c8000000b0024f249d1770so4262134ljh.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Jun 2022 00:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LZJhp5L1ykqWD7LdN0E4Ox3CGQKebfkP1ixyik/IJxo=;
 b=f8Ib6OOn6ikLhxTTsv5AQR1UycYl8uJsKK3MLmoYgTPQaokfDleYVLrDMzE3n41YOx
 Ixs+Hz7SwL/eCZrTKSI53GFAB4V6i5Nvuw/cLBgZUb3B8ywyFpIZzFtVBb7gm5gZ0YcB
 pl4zW54CIxGW9/7J8AEInqznLUhc0E5Ohs0l/snQuQ8B36gPkbxdil4XnT2NX3RXGrMG
 tDyMbGlWbFhhulsuKgxDz7+JvhJuOApJr5rW6/ElyX1LG9TtdXIYYftza6XIYvq3pwBU
 yjHN1i2yW/W0IiKl+v+PqyS9Azg6/2TxupGNO8GUKYlUSFucEyRtIrTEfQIRQZqrzOcQ
 eCxw==
X-Gm-Message-State: AOAM531rxAzXRqPYUovvq9pl0eqQV1DekGzoBtoDf8eFsjYCuNUg9eRK
 pICx1KgbrVAY3QqC3ReXyrdNrpY1PZSbou4pXJSLu+159vMaXji6rQ96gfhWwGlurH2P6ZIbk2n
 gM2mNEr8kMSm9zA34IsC7Sn228Ut96djyXzLJONq5iSGuDgMXV9kuT+21Zg==
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr60689040ljq.251.1654759173833; 
 Thu, 09 Jun 2022 00:19:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb90dNZuYzoDTn4w+qZtYw1PWxrMu4ox+V+bc3835dZlQxeb3AGEBqe4wWKmMUQZhifbzb0yqD707QLMIfw/4=
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr60689031ljq.251.1654759173667; Thu, 09
 Jun 2022 00:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220603103356.26564-1-gautam.dawar@amd.com>
 <CACGkMEs38ycmAaDc48_rt5BeBHq4tzKH39gj=KczYFQC16ns5Q@mail.gmail.com>
 <DM4PR12MB5841EB20B82969B6D67638AF99A49@DM4PR12MB5841.namprd12.prod.outlook.com>
 <PH0PR12MB54814B1D6E884E50E5C26786DCA49@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54814B1D6E884E50E5C26786DCA49@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Jun 2022 15:19:22 +0800
Message-ID: <CACGkMEsdMzLb+JtdZ7vTmMb=jU7PpM5GaJT1uD6t_tty46x2OA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: allow vdpa dev_del management operation to return
 failure
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wan Jiabing <wanjiabing@vivo.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-net-drivers \(AMD-Xilinx\)" <linux-net-drivers@amd.com>, "Dawar,
 Gautam" <gautam.dawar@amd.com>, "Anand, Harpreet" <harpreet.anand@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Xie Yongji <xieyongji@bytedance.com>, netdev <netdev@vger.kernel.org>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Eli Cohen <elic@nvidia.com>,
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

On Wed, Jun 8, 2022 at 6:43 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Dawar, Gautam <gautam.dawar@amd.com>
> > Sent: Wednesday, June 8, 2022 6:30 AM
> > To: Jason Wang <jasowang@redhat.com>
> > Cc: netdev <netdev@vger.kernel.org>; linux-net-drivers (AMD-Xilinx) <linux-
> > net-drivers@amd.com>; Anand, Harpreet <harpreet.anand@amd.com>;
> > Michael S. Tsirkin <mst@redhat.com>; Zhu Lingshan
> > <lingshan.zhu@intel.com>; Xie Yongji <xieyongji@bytedance.com>; Eli
> > Cohen <elic@nvidia.com>; Parav Pandit <parav@nvidia.com>; Si-Wei Liu <si-
> > wei.liu@oracle.com>; Stefano Garzarella <sgarzare@redhat.com>; Wan
> > Jiabing <wanjiabing@vivo.com>; Dan Carpenter
> > <dan.carpenter@oracle.com>; virtualization <virtualization@lists.linux-
> > foundation.org>; linux-kernel <linux-kernel@vger.kernel.org>
> > Subject: RE: [PATCH] vdpa: allow vdpa dev_del management operation to
> > return failure
> >
> > [AMD Official Use Only - General]
> >
> > Hi Gautam:
> > [GD>>] Hi Jason,
> >
> > On Fri, Jun 3, 2022 at 6:34 PM Gautam Dawar <gautam.dawar@amd.com>
> > wrote:
> > >
> > > Currently, the vdpa_nl_cmd_dev_del_set_doit() implementation allows
> > > returning a value to depict the operation status but the return type
> > > of dev_del() callback is void. So, any error while deleting the vdpa
> > > device in the vdpa parent driver can't be returned to the management
> > > layer.
> >
> > I wonder under which cognition we can hit an error in dev_del()?
> > [GD>>] In the AMD-Xilinx vDPA driver, on receiving vdpa device deletion
> > request, I try to identify if the vdpa device is in use by any virtio-net driver
> > (through any vdpa bus driver) by looking at the vdpa device status value. In
> > case the vdpa device status is >= VIRTIO_CONFIG_S_DRIVER, -EBUSY is
> > returned.
> > This is to avoid side-effects as noted in
> > https://bugzilla.kernel.org/show_bug.cgi?id=213179 caused by deleting the
> > vdpa device when it is being used.
> > >
> User should be able to delete the device anytime.

It requires a poll event to user space and then Qemu can release the
vhost-vDPA device. This is how VFIO works. We probably need to
implement something like this.

But notice that, at the worst case, usersapce may not respond to this
event, so there's nothing more kenrel can do execpt for waiting.

We need to consider something different. I used to have an idea to
make vhost-vdpa couple with vDPA loosely with SRCU/RCU. We might
consider implementing that.

> Upper layers who are unable to perform teardown sequence should be fixed.

I think we probably don't need to bother with failing the dev_del().
We can consider to fix/workaround the waiting first.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
