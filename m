Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C194C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 10:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6AB281A6F;
	Fri, 11 Nov 2022 10:20:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6AB281A6F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TNmMUbxz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1oI3H20b2r1; Fri, 11 Nov 2022 10:20:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2797B813B8;
	Fri, 11 Nov 2022 10:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2797B813B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA46EC0032;
	Fri, 11 Nov 2022 10:20:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3E4DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 10:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE8E260B2D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 10:19:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE8E260B2D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TNmMUbxz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zGxCFwAW1sRy
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 10:19:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 589F860AFD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 589F860AFD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668161997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hkfcRYtC0WElW4NHIve5Vu7pojHwJ3jYGNzmWzhbSs=;
 b=TNmMUbxz1G4Oi9QAQ5gn/4vROF2lCfGvVXTHlamTCLt7wQwtMkClYOnmVqsk0/uMGul0pn
 sHV1+zRiO1zk8cUFOJGKcQa9V5plm30Ztt3HnG83kYlGZYuIVNsfxY5B3dn1waPVNbdjkz
 0KauNVHkrC5y61hmFW9QNJ4WYedBEf4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-tQs0zYFWNs6_I-GNC33Zkw-1; Fri, 11 Nov 2022 05:19:55 -0500
X-MC-Unique: tQs0zYFWNs6_I-GNC33Zkw-1
Received: by mail-wm1-f71.google.com with SMTP id
 m17-20020a05600c3b1100b003cf9cc47da5so2355494wms.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 02:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hkfcRYtC0WElW4NHIve5Vu7pojHwJ3jYGNzmWzhbSs=;
 b=0qWRibjFcpm+wDSBgoOklClIsc1xzvOVb3pnuwF9c6jZKtpSSorJgtyKedLrl1ewI+
 J/SYrVbpiyYR4nBL8Po+0jWeu5r+1t+kVmUq5KDEX+uMEvDxkR1ibj4gZsCPWHBYQoy6
 tGlyYRaEJ0dZCw9lTfoA6Z9cjJGfV1k13y3BDqPItzvIBJ+/yxs1YuJe+r4+nvc2dws3
 AEXMuaG1dic0xw0+2RA9Y2nNc+AVFWWbhSKYXjqCLdxlq/pTod12zg6OH+TQ5ciXSxgh
 pcNM9TTrc6TZE1scmRrARryBA9QLoJIk5kTyy617ISsh8mgGaVXiF7LG9RJYhA8WB2KM
 5iEw==
X-Gm-Message-State: ANoB5plcfDQuJb09T/+acL1i/01WrlmVbrhfQjVMHO57icwSBypwUcqb
 erYIi5aOyZVMgwR61B1Pu2FbQSvZhX8MBOOP0bJX5qq6WnnmxlP7ksKKybugZY1nPba9M2+hDVg
 7wSu7nVjdKmUEOSgQG4t+za483Sg+uumLlbl5x7lCZA==
X-Received: by 2002:a05:600c:1e83:b0:3cf:6ab3:4a60 with SMTP id
 be3-20020a05600c1e8300b003cf6ab34a60mr790587wmb.32.1668161994645; 
 Fri, 11 Nov 2022 02:19:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf70ADM03fSiBXxKt8gN+ehqGCGFOWip/0wQRvBWYQAaEo/IL6HocExHucBfVrGC9uHugkrPOA==
X-Received: by 2002:a05:600c:1e83:b0:3cf:6ab3:4a60 with SMTP id
 be3-20020a05600c1e8300b003cf6ab34a60mr790576wmb.32.1668161994313; 
 Fri, 11 Nov 2022 02:19:54 -0800 (PST)
Received: from redhat.com ([2.52.3.250]) by smtp.gmail.com with ESMTPSA id
 a11-20020a5d570b000000b0022ca921dc67sm1487153wrv.88.2022.11.11.02.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Nov 2022 02:19:52 -0800 (PST)
Date: Fri, 11 Nov 2022 05:19:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: allow provisioning device features
Message-ID: <20221111051432-mutt-send-email-mst@kernel.org>
References: <20221110075821.3818-1-jasowang@redhat.com>
 <20221110055242-mutt-send-email-mst@kernel.org>
 <CACGkMEusb5NYi8ZTR-fovDku7n+As=HWitM+kx4CW10=oC87cQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEusb5NYi8ZTR-fovDku7n+As=HWitM+kx4CW10=oC87cQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, dsahern@kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 elic@nvidia.com
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

On Fri, Nov 11, 2022 at 03:17:14PM +0800, Jason Wang wrote:
> On Thu, Nov 10, 2022 at 7:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 10, 2022 at 03:58:21PM +0800, Jason Wang wrote:
> > > This patch allows device features to be provisioned via vdpa. This
> > > will be useful for preserving migration compatibility between source
> > > and destination:
> > >
> > > # vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
> > > # dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
> > >       negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  man/man8/vdpa-dev.8            | 10 ++++++++++
> > >  vdpa/include/uapi/linux/vdpa.h |  1 +
> > >  vdpa/vdpa.c                    | 27 ++++++++++++++++++++++++++-
> > >  3 files changed, 37 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
> > > index 9faf3838..bb45b4a6 100644
> > > --- a/man/man8/vdpa-dev.8
> > > +++ b/man/man8/vdpa-dev.8
> > > @@ -31,6 +31,7 @@ vdpa-dev \- vdpa device configuration
> > >  .I NAME
> > >  .B mgmtdev
> > >  .I MGMTDEV
> > > +.RI "[ device_features " DEVICE_FEATURES " ]"
> > >  .RI "[ mac " MACADDR " ]"
> > >  .RI "[ mtu " MTU " ]"
> > >  .RI "[ max_vqp " MAX_VQ_PAIRS " ]"
> > > @@ -74,6 +75,10 @@ Name of the new vdpa device to add.
> > >  Name of the management device to use for device addition.
> > >
> > >  .PP
> > > +.BI device_features " DEVICE_FEAETURES"
> >
> > typo
> 
> Will fix.
> 
> >
> > > +- specifies the device features that is provisioned for the new vdpa device.
> >
> > I propose
> >          the device features -> the virtio "device features" bit-mask
> >
> > features sounds like it's a generic thing, here's it's
> > the actual binary
> >
> > and maybe add "the bits can be found under include/uapi/linux/virtio*h,
> > see macros such as VIRTIO_F_ and VIRTIO_NET_F_ for specific bit values"
> 
> That's fine.
> 
> >
> > > +This is optional.
> > > +
> >
> > and if not given what are the features?
> 
> As in the past, determined by the parent/mgmt device, do we need to
> document this?

I think so, yes.

> >
> > >  .BI mac " MACADDR"
> > >  - specifies the mac address for the new vdpa device.
> > >  This is applicable only for the network type of vdpa device. This is optional.
> > > @@ -127,6 +132,11 @@ vdpa dev add name foo mgmtdev vdpa_sim_net
> > >  Add the vdpa device named foo on the management device vdpa_sim_net.
> > >  .RE
> > >  .PP
> > > +vdpa dev add name foo mgmtdev vdpa_sim_net device_features 0x300020000
> > > +.RS 4
> > > +Add the vdpa device named foo on the management device vdpa_sim_net with device_features of 0x300020000
> > > +.RE
> > > +.PP
> > >  vdpa dev add name foo mgmtdev vdpa_sim_net mac 00:11:22:33:44:55
> > >  .RS 4
> > >  Add the vdpa device named foo on the management device vdpa_sim_net with mac address of 00:11:22:33:44:55.
> > > diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
> > > index 94e4dad1..7c961991 100644
> > > --- a/vdpa/include/uapi/linux/vdpa.h
> > > +++ b/vdpa/include/uapi/linux/vdpa.h
> > > @@ -51,6 +51,7 @@ enum vdpa_attr {
> > >       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> > >       VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
> > >       VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> > > +     VDPA_ATTR_DEV_FEATURES,                 /* u64 */
> > >
> > >       /* new attributes must be added above here */
> > >       VDPA_ATTR_MAX,
> > > diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> > > index b73e40b4..9a866d61 100644
> > > --- a/vdpa/vdpa.c
> > > +++ b/vdpa/vdpa.c
> > > @@ -27,6 +27,7 @@
> > >  #define VDPA_OPT_VDEV_MTU            BIT(5)
> > >  #define VDPA_OPT_MAX_VQP             BIT(6)
> > >  #define VDPA_OPT_QUEUE_INDEX         BIT(7)
> > > +#define VDPA_OPT_VDEV_FEATURES               BIT(8)
> > >
> > >  struct vdpa_opts {
> > >       uint64_t present; /* flags of present items */
> > > @@ -38,6 +39,7 @@ struct vdpa_opts {
> > >       uint16_t mtu;
> > >       uint16_t max_vqp;
> > >       uint32_t queue_idx;
> > > +     __u64 device_features;
> > >  };
> > >
> > >  struct vdpa {
> >
> > why __u and not uint here?
> 
> That's possible, will do.
> 
> >
> > > @@ -187,6 +189,17 @@ static int vdpa_argv_u32(struct vdpa *vdpa, int argc, char **argv,
> > >       return get_u32(result, *argv, 10);
> > >  }
> > >
> > > +static int vdpa_argv_u64_hex(struct vdpa *vdpa, int argc, char **argv,
> > > +                          __u64 *result)
> > > +{
> > > +     if (argc <= 0 || !*argv) {
> > > +             fprintf(stderr, "number expected\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return get_u64(result, *argv, 16);
> > > +}
> > > +
> > >  struct vdpa_args_metadata {
> > >       uint64_t o_flag;
> > >       const char *err_msg;
> > > @@ -244,6 +257,10 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
> > >               mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, opts->max_vqp);
> > >       if (opts->present & VDPA_OPT_QUEUE_INDEX)
> > >               mnl_attr_put_u32(nlh, VDPA_ATTR_DEV_QUEUE_INDEX, opts->queue_idx);
> > > +     if (opts->present & VDPA_OPT_VDEV_FEATURES) {
> > > +             mnl_attr_put_u64(nlh, VDPA_ATTR_DEV_FEATURES,
> > > +                             opts->device_features);
> > > +     }
> > >  }
> > >
> > >  static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
> > > @@ -329,6 +346,14 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
> > >
> > >                       NEXT_ARG_FWD();
> > >                       o_found |= VDPA_OPT_QUEUE_INDEX;
> > > +             } else if (!strcmp(*argv, "device_features") &&
> > > +                        (o_optional & VDPA_OPT_VDEV_FEATURES)) {
> > > +                     NEXT_ARG_FWD();
> > > +                     err = vdpa_argv_u64_hex(vdpa, argc, argv,
> > > +                                             &opts->device_features);
> > > +                     if (err)
> > > +                             return err;
> > > +                     o_found |= VDPA_OPT_VDEV_FEATURES;
> > >               } else {
> > >                       fprintf(stderr, "Unknown option \"%s\"\n", *argv);
> > >                       return -EINVAL;
> >
> >
> > should not we validate the value we get? e.g. a mac feature
> > requires that mac is supplied, etc.
> 
> This isn't an "issue" that is introduced by this patch. Management
> device is free to give _F_MAC even if the mac address is not
> provisioned by the userspace. So this should be the responsibility of
> the parent not the netlink/vdpa tool.

right but now user can supply an invalid config. What validates it?

> > in fact hex isn't very user friendly. why not pass feature
> > names instead?
> 
> This can be added on top if necessary. In fact there's a plan to
> accept JSON files for provisioning.
> 
> The advantages of hex is we don't need to keep the name  synced with
> the new features.
> 
> Thanks

right but it also means we can't interpret them in any way.


> >
> >
> >
> > > @@ -708,7 +733,7 @@ static int cmd_dev_add(struct vdpa *vdpa, int argc, char **argv)
> > >       err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
> > >                                 VDPA_OPT_VDEV_MGMTDEV_HANDLE | VDPA_OPT_VDEV_NAME,
> > >                                 VDPA_OPT_VDEV_MAC | VDPA_OPT_VDEV_MTU |
> > > -                               VDPA_OPT_MAX_VQP);
> > > +                               VDPA_OPT_MAX_VQP | VDPA_OPT_VDEV_FEATURES);
> > >       if (err)
> > >               return err;
> > >
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
