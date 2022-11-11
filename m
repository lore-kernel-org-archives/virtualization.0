Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E17DC4332F
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 07:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7A0840185;
	Fri, 11 Nov 2022 07:17:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7A0840185
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZXlqm5LL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srOZKyC_0_HY; Fri, 11 Nov 2022 07:17:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED0C24011C;
	Fri, 11 Nov 2022 07:17:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED0C24011C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE273C0033;
	Fri, 11 Nov 2022 07:17:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91D6BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 07:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5652E40940
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 07:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5652E40940
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZXlqm5LL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eoSGRjJmSgfo
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 07:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11CA8408F0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11CA8408F0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 07:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668151048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4QndAHwF5T4cRP2zHP2BYS+XxR0b4XY/sv0eiTHsSwQ=;
 b=ZXlqm5LLxsELKDGPvnpWP4VRa2sqaw1Gnunco28jXd59ThOz8Ap2ugAV10fcwmhL9mcdAS
 B0TrkP2255FzKqfGF+zNjNhKA6F4l5YVpNB3bwRIRg9yr4hBZnjpdz2LJW6gLVp+qTQk6a
 i3IBLXxU+BmCw/7CvfswE2j0Pphh3hc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-pnDv1dzvP8WAP6Ldh-Qblw-1; Fri, 11 Nov 2022 02:17:27 -0500
X-MC-Unique: pnDv1dzvP8WAP6Ldh-Qblw-1
Received: by mail-oo1-f71.google.com with SMTP id
 c8-20020a4a87c8000000b0049f149a83fdso1348218ooi.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 23:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4QndAHwF5T4cRP2zHP2BYS+XxR0b4XY/sv0eiTHsSwQ=;
 b=Rlw2700GhP0SnN/iszJI+TXE1UCYGDtE0ThdWVtA5aR/xAsSp1ixXkhK1xqijY9XYX
 ZeJThyO8/lL0Hv/M7JWH1Ncy6oM0l+BV38H2k0aAnkVo+HZD1xpQc5XKfulTsbTTZKv1
 lG0EvdK6bPLaZ8++3iaaf3oRKY5y1YwONDrmwhSFg8Y/7tKbv+JzoR8U4PKMt7Rd6bUO
 QWtTKCr+ml9bdEAW4R5bIMBOK0VDijoe15rWAKLiLi/tvdTIEK5L48LTaEDucC4enAN8
 B+eNdApRhj86k3wa21yyMudvlRLCj7IuesJVKrruglRThuME11s9N2z3t8yFAhIL92kZ
 pevw==
X-Gm-Message-State: ANoB5pkiB71wLD4OtQLD1CYTKlpjlnKPxkrMa3yMqe1dzDKxF9SitxIM
 AogTjmOw7lR80t+MhSEplWiK+R5F3Z2idK3JIHRDP8f6AMqY2oM74o3qTDU/5LeUwJx31yuIHBg
 tz8OrAKSJQcdpCtd7REb6chPhFAcwQMXiG/FUfrE2jI+S1HUK+dBMx5XM1g==
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id
 s13-20020a056830124d00b0066c64d61bb4mr633602otp.201.1668151046425; 
 Thu, 10 Nov 2022 23:17:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ZEx6mPdq+HYSFhWhFwD1Xr1pcZlFnjwz9gp+GBxZsQYEu0r/sKobQ2o5tt/vsUeaP6ytP0eDsJUY4bZUhzVc=
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id
 s13-20020a056830124d00b0066c64d61bb4mr633591otp.201.1668151046080; Thu, 10
 Nov 2022 23:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20221110075821.3818-1-jasowang@redhat.com>
 <20221110055242-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221110055242-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Nov 2022 15:17:14 +0800
Message-ID: <CACGkMEusb5NYi8ZTR-fovDku7n+As=HWitM+kx4CW10=oC87cQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: allow provisioning device features
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Thu, Nov 10, 2022 at 7:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 10, 2022 at 03:58:21PM +0800, Jason Wang wrote:
> > This patch allows device features to be provisioned via vdpa. This
> > will be useful for preserving migration compatibility between source
> > and destination:
> >
> > # vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
> > # dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
> >       negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  man/man8/vdpa-dev.8            | 10 ++++++++++
> >  vdpa/include/uapi/linux/vdpa.h |  1 +
> >  vdpa/vdpa.c                    | 27 ++++++++++++++++++++++++++-
> >  3 files changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
> > index 9faf3838..bb45b4a6 100644
> > --- a/man/man8/vdpa-dev.8
> > +++ b/man/man8/vdpa-dev.8
> > @@ -31,6 +31,7 @@ vdpa-dev \- vdpa device configuration
> >  .I NAME
> >  .B mgmtdev
> >  .I MGMTDEV
> > +.RI "[ device_features " DEVICE_FEATURES " ]"
> >  .RI "[ mac " MACADDR " ]"
> >  .RI "[ mtu " MTU " ]"
> >  .RI "[ max_vqp " MAX_VQ_PAIRS " ]"
> > @@ -74,6 +75,10 @@ Name of the new vdpa device to add.
> >  Name of the management device to use for device addition.
> >
> >  .PP
> > +.BI device_features " DEVICE_FEAETURES"
>
> typo

Will fix.

>
> > +- specifies the device features that is provisioned for the new vdpa device.
>
> I propose
>          the device features -> the virtio "device features" bit-mask
>
> features sounds like it's a generic thing, here's it's
> the actual binary
>
> and maybe add "the bits can be found under include/uapi/linux/virtio*h,
> see macros such as VIRTIO_F_ and VIRTIO_NET_F_ for specific bit values"

That's fine.

>
> > +This is optional.
> > +
>
> and if not given what are the features?

As in the past, determined by the parent/mgmt device, do we need to
document this?

>
> >  .BI mac " MACADDR"
> >  - specifies the mac address for the new vdpa device.
> >  This is applicable only for the network type of vdpa device. This is optional.
> > @@ -127,6 +132,11 @@ vdpa dev add name foo mgmtdev vdpa_sim_net
> >  Add the vdpa device named foo on the management device vdpa_sim_net.
> >  .RE
> >  .PP
> > +vdpa dev add name foo mgmtdev vdpa_sim_net device_features 0x300020000
> > +.RS 4
> > +Add the vdpa device named foo on the management device vdpa_sim_net with device_features of 0x300020000
> > +.RE
> > +.PP
> >  vdpa dev add name foo mgmtdev vdpa_sim_net mac 00:11:22:33:44:55
> >  .RS 4
> >  Add the vdpa device named foo on the management device vdpa_sim_net with mac address of 00:11:22:33:44:55.
> > diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
> > index 94e4dad1..7c961991 100644
> > --- a/vdpa/include/uapi/linux/vdpa.h
> > +++ b/vdpa/include/uapi/linux/vdpa.h
> > @@ -51,6 +51,7 @@ enum vdpa_attr {
> >       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> >       VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
> >       VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> > +     VDPA_ATTR_DEV_FEATURES,                 /* u64 */
> >
> >       /* new attributes must be added above here */
> >       VDPA_ATTR_MAX,
> > diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> > index b73e40b4..9a866d61 100644
> > --- a/vdpa/vdpa.c
> > +++ b/vdpa/vdpa.c
> > @@ -27,6 +27,7 @@
> >  #define VDPA_OPT_VDEV_MTU            BIT(5)
> >  #define VDPA_OPT_MAX_VQP             BIT(6)
> >  #define VDPA_OPT_QUEUE_INDEX         BIT(7)
> > +#define VDPA_OPT_VDEV_FEATURES               BIT(8)
> >
> >  struct vdpa_opts {
> >       uint64_t present; /* flags of present items */
> > @@ -38,6 +39,7 @@ struct vdpa_opts {
> >       uint16_t mtu;
> >       uint16_t max_vqp;
> >       uint32_t queue_idx;
> > +     __u64 device_features;
> >  };
> >
> >  struct vdpa {
>
> why __u and not uint here?

That's possible, will do.

>
> > @@ -187,6 +189,17 @@ static int vdpa_argv_u32(struct vdpa *vdpa, int argc, char **argv,
> >       return get_u32(result, *argv, 10);
> >  }
> >
> > +static int vdpa_argv_u64_hex(struct vdpa *vdpa, int argc, char **argv,
> > +                          __u64 *result)
> > +{
> > +     if (argc <= 0 || !*argv) {
> > +             fprintf(stderr, "number expected\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return get_u64(result, *argv, 16);
> > +}
> > +
> >  struct vdpa_args_metadata {
> >       uint64_t o_flag;
> >       const char *err_msg;
> > @@ -244,6 +257,10 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
> >               mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, opts->max_vqp);
> >       if (opts->present & VDPA_OPT_QUEUE_INDEX)
> >               mnl_attr_put_u32(nlh, VDPA_ATTR_DEV_QUEUE_INDEX, opts->queue_idx);
> > +     if (opts->present & VDPA_OPT_VDEV_FEATURES) {
> > +             mnl_attr_put_u64(nlh, VDPA_ATTR_DEV_FEATURES,
> > +                             opts->device_features);
> > +     }
> >  }
> >
> >  static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
> > @@ -329,6 +346,14 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
> >
> >                       NEXT_ARG_FWD();
> >                       o_found |= VDPA_OPT_QUEUE_INDEX;
> > +             } else if (!strcmp(*argv, "device_features") &&
> > +                        (o_optional & VDPA_OPT_VDEV_FEATURES)) {
> > +                     NEXT_ARG_FWD();
> > +                     err = vdpa_argv_u64_hex(vdpa, argc, argv,
> > +                                             &opts->device_features);
> > +                     if (err)
> > +                             return err;
> > +                     o_found |= VDPA_OPT_VDEV_FEATURES;
> >               } else {
> >                       fprintf(stderr, "Unknown option \"%s\"\n", *argv);
> >                       return -EINVAL;
>
>
> should not we validate the value we get? e.g. a mac feature
> requires that mac is supplied, etc.

This isn't an "issue" that is introduced by this patch. Management
device is free to give _F_MAC even if the mac address is not
provisioned by the userspace. So this should be the responsibility of
the parent not the netlink/vdpa tool.

> in fact hex isn't very user friendly. why not pass feature
> names instead?

This can be added on top if necessary. In fact there's a plan to
accept JSON files for provisioning.

The advantages of hex is we don't need to keep the name  synced with
the new features.

Thanks

>
>
>
> > @@ -708,7 +733,7 @@ static int cmd_dev_add(struct vdpa *vdpa, int argc, char **argv)
> >       err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
> >                                 VDPA_OPT_VDEV_MGMTDEV_HANDLE | VDPA_OPT_VDEV_NAME,
> >                                 VDPA_OPT_VDEV_MAC | VDPA_OPT_VDEV_MTU |
> > -                               VDPA_OPT_MAX_VQP);
> > +                               VDPA_OPT_MAX_VQP | VDPA_OPT_VDEV_FEATURES);
> >       if (err)
> >               return err;
> >
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
