Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED091C4332F
	for <virtualization@archiver.kernel.org>; Tue, 15 Nov 2022 06:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5196140863;
	Tue, 15 Nov 2022 06:37:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5196140863
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fLlGFUJz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wTnyqlV6hqvr; Tue, 15 Nov 2022 06:37:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D2B4F40425;
	Tue, 15 Nov 2022 06:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2B4F40425
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A271BC0033;
	Tue, 15 Nov 2022 06:37:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A6C5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 06:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D99560ABD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 06:37:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D99560ABD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fLlGFUJz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZLcMeIxybIod
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 06:37:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F79460ABB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F79460ABB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 06:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668494222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6bJoVHzy3RlJx4jYJ+y0CmrUIaNDVSWq8qO2kVGMAJ4=;
 b=fLlGFUJzOWi4zAT27sLtBu8zOGD9K9A26VkbrgK50MZV1oraqXzRrtqRcTmFfbYW0FGl4G
 CIU2BZn0SmBIBMxkGNrIrF8EcUQobeOgJqgxZqS48ws2CJGGH7AKXRwpFscNEi/UxYPWrc
 SfYsFs37QkKAw0WQZwik5bLZ4r8t/3g=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-2L12DNyxPhGfvH67o7plCA-1; Tue, 15 Nov 2022 01:36:58 -0500
X-MC-Unique: 2L12DNyxPhGfvH67o7plCA-1
Received: by mail-ot1-f72.google.com with SMTP id
 a22-20020a0568300b9600b0065c0cef3662so7325100otv.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 22:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bJoVHzy3RlJx4jYJ+y0CmrUIaNDVSWq8qO2kVGMAJ4=;
 b=fhUJC0CQqaulD1nluc7xyWC8mVGBzqVRs4HsqIItVWzMMaTbI7ZKTcluP5JLzuLSoK
 t+lNPNDEqNALWnBj5Vq9cKD7zNL4repQE1CQPNgr+IT6ACCgolmGmxRvYyyu88K+Wryj
 fRUjhLOohgcqeTx8gLxVmvvnykrLql872boUhidwhJA3WKFSZqusW86OnXfq8lUohrUr
 o5OXcopqsNZzgrhPmZjrZkt3v/qv0n8YE8dYi4NeyK2DB7KgSPke0HzdYmClT2of2GXP
 5DKAMWBM1X3LJ+qlM/Xnmie02zn1RZuDJaopXISAjiqQExeA6f5KU43Hla+Uyy2gMpOU
 jL5w==
X-Gm-Message-State: ANoB5pnNxk3Bkd3CsNYaUWPEvbu+DOd1Pj+c7WSf7rad4VKHJ8WyE26x
 UTZXJ4uaTytMC9tg2U1sQxfWw4J1yLcZh+/VCt2sSnfYvjHIIywF9i5USLpd7c3Zf4J68At1Rj7
 0raBmlbpjPenNJzRMQZ253Ej00s1UkL47FIOM8ZCc8l9i8bUazyM19bmrVQ==
X-Received: by 2002:aca:bd57:0:b0:359:f5eb:82ec with SMTP id
 n84-20020acabd57000000b00359f5eb82ecmr225857oif.280.1668494217464; 
 Mon, 14 Nov 2022 22:36:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4KHCFZzxBhKVg/SwOhjXt7exqSZYVqCC2djG3887xnaIvkfgFRU2eByajzKvFcEYGJwBfxoXrWJMFd7nVbaIk=
X-Received: by 2002:aca:bd57:0:b0:359:f5eb:82ec with SMTP id
 n84-20020acabd57000000b00359f5eb82ecmr225852oif.280.1668494217094; Mon, 14
 Nov 2022 22:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20221110075821.3818-1-jasowang@redhat.com>
 <20221110055242-mutt-send-email-mst@kernel.org>
 <CACGkMEusb5NYi8ZTR-fovDku7n+As=HWitM+kx4CW10=oC87cQ@mail.gmail.com>
 <20221111051432-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221111051432-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Nov 2022 14:36:45 +0800
Message-ID: <CACGkMEtfdmwNNGZQJufmRDcqw67uSLmb15rpEMLxJXXBT1CTSA@mail.gmail.com>
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

On Fri, Nov 11, 2022 at 6:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Nov 11, 2022 at 03:17:14PM +0800, Jason Wang wrote:
> > On Thu, Nov 10, 2022 at 7:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Nov 10, 2022 at 03:58:21PM +0800, Jason Wang wrote:
> > > > This patch allows device features to be provisioned via vdpa. This
> > > > will be useful for preserving migration compatibility between source
> > > > and destination:
> > > >
> > > > # vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
> > > > # dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
> > > >       negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  man/man8/vdpa-dev.8            | 10 ++++++++++
> > > >  vdpa/include/uapi/linux/vdpa.h |  1 +
> > > >  vdpa/vdpa.c                    | 27 ++++++++++++++++++++++++++-
> > > >  3 files changed, 37 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
> > > > index 9faf3838..bb45b4a6 100644
> > > > --- a/man/man8/vdpa-dev.8
> > > > +++ b/man/man8/vdpa-dev.8
> > > > @@ -31,6 +31,7 @@ vdpa-dev \- vdpa device configuration
> > > >  .I NAME
> > > >  .B mgmtdev
> > > >  .I MGMTDEV
> > > > +.RI "[ device_features " DEVICE_FEATURES " ]"
> > > >  .RI "[ mac " MACADDR " ]"
> > > >  .RI "[ mtu " MTU " ]"
> > > >  .RI "[ max_vqp " MAX_VQ_PAIRS " ]"
> > > > @@ -74,6 +75,10 @@ Name of the new vdpa device to add.
> > > >  Name of the management device to use for device addition.
> > > >
> > > >  .PP
> > > > +.BI device_features " DEVICE_FEAETURES"
> > >
> > > typo
> >
> > Will fix.
> >
> > >
> > > > +- specifies the device features that is provisioned for the new vdpa device.
> > >
> > > I propose
> > >          the device features -> the virtio "device features" bit-mask
> > >
> > > features sounds like it's a generic thing, here's it's
> > > the actual binary
> > >
> > > and maybe add "the bits can be found under include/uapi/linux/virtio*h,
> > > see macros such as VIRTIO_F_ and VIRTIO_NET_F_ for specific bit values"
> >
> > That's fine.
> >
> > >
> > > > +This is optional.
> > > > +
> > >
> > > and if not given what are the features?
> >
> > As in the past, determined by the parent/mgmt device, do we need to
> > document this?
>
> I think so, yes.

Ok.

>
> > >
> > > >  .BI mac " MACADDR"
> > > >  - specifies the mac address for the new vdpa device.
> > > >  This is applicable only for the network type of vdpa device. This is optional.
> > > > @@ -127,6 +132,11 @@ vdpa dev add name foo mgmtdev vdpa_sim_net
> > > >  Add the vdpa device named foo on the management device vdpa_sim_net.
> > > >  .RE
> > > >  .PP
> > > > +vdpa dev add name foo mgmtdev vdpa_sim_net device_features 0x300020000
> > > > +.RS 4
> > > > +Add the vdpa device named foo on the management device vdpa_sim_net with device_features of 0x300020000
> > > > +.RE
> > > > +.PP
> > > >  vdpa dev add name foo mgmtdev vdpa_sim_net mac 00:11:22:33:44:55
> > > >  .RS 4
> > > >  Add the vdpa device named foo on the management device vdpa_sim_net with mac address of 00:11:22:33:44:55.
> > > > diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
> > > > index 94e4dad1..7c961991 100644
> > > > --- a/vdpa/include/uapi/linux/vdpa.h
> > > > +++ b/vdpa/include/uapi/linux/vdpa.h
> > > > @@ -51,6 +51,7 @@ enum vdpa_attr {
> > > >       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> > > >       VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
> > > >       VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> > > > +     VDPA_ATTR_DEV_FEATURES,                 /* u64 */
> > > >
> > > >       /* new attributes must be added above here */
> > > >       VDPA_ATTR_MAX,
> > > > diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> > > > index b73e40b4..9a866d61 100644
> > > > --- a/vdpa/vdpa.c
> > > > +++ b/vdpa/vdpa.c
> > > > @@ -27,6 +27,7 @@
> > > >  #define VDPA_OPT_VDEV_MTU            BIT(5)
> > > >  #define VDPA_OPT_MAX_VQP             BIT(6)
> > > >  #define VDPA_OPT_QUEUE_INDEX         BIT(7)
> > > > +#define VDPA_OPT_VDEV_FEATURES               BIT(8)
> > > >
> > > >  struct vdpa_opts {
> > > >       uint64_t present; /* flags of present items */
> > > > @@ -38,6 +39,7 @@ struct vdpa_opts {
> > > >       uint16_t mtu;
> > > >       uint16_t max_vqp;
> > > >       uint32_t queue_idx;
> > > > +     __u64 device_features;
> > > >  };
> > > >
> > > >  struct vdpa {
> > >
> > > why __u and not uint here?
> >
> > That's possible, will do.
> >
> > >
> > > > @@ -187,6 +189,17 @@ static int vdpa_argv_u32(struct vdpa *vdpa, int argc, char **argv,
> > > >       return get_u32(result, *argv, 10);
> > > >  }
> > > >
> > > > +static int vdpa_argv_u64_hex(struct vdpa *vdpa, int argc, char **argv,
> > > > +                          __u64 *result)
> > > > +{
> > > > +     if (argc <= 0 || !*argv) {
> > > > +             fprintf(stderr, "number expected\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     return get_u64(result, *argv, 16);
> > > > +}
> > > > +
> > > >  struct vdpa_args_metadata {
> > > >       uint64_t o_flag;
> > > >       const char *err_msg;
> > > > @@ -244,6 +257,10 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
> > > >               mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, opts->max_vqp);
> > > >       if (opts->present & VDPA_OPT_QUEUE_INDEX)
> > > >               mnl_attr_put_u32(nlh, VDPA_ATTR_DEV_QUEUE_INDEX, opts->queue_idx);
> > > > +     if (opts->present & VDPA_OPT_VDEV_FEATURES) {
> > > > +             mnl_attr_put_u64(nlh, VDPA_ATTR_DEV_FEATURES,
> > > > +                             opts->device_features);
> > > > +     }
> > > >  }
> > > >
> > > >  static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
> > > > @@ -329,6 +346,14 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
> > > >
> > > >                       NEXT_ARG_FWD();
> > > >                       o_found |= VDPA_OPT_QUEUE_INDEX;
> > > > +             } else if (!strcmp(*argv, "device_features") &&
> > > > +                        (o_optional & VDPA_OPT_VDEV_FEATURES)) {
> > > > +                     NEXT_ARG_FWD();
> > > > +                     err = vdpa_argv_u64_hex(vdpa, argc, argv,
> > > > +                                             &opts->device_features);
> > > > +                     if (err)
> > > > +                             return err;
> > > > +                     o_found |= VDPA_OPT_VDEV_FEATURES;
> > > >               } else {
> > > >                       fprintf(stderr, "Unknown option \"%s\"\n", *argv);
> > > >                       return -EINVAL;
> > >
> > >
> > > should not we validate the value we get? e.g. a mac feature
> > > requires that mac is supplied, etc.
> >
> > This isn't an "issue" that is introduced by this patch. Management
> > device is free to give _F_MAC even if the mac address is not
> > provisioned by the userspace. So this should be the responsibility of
> > the parent not the netlink/vdpa tool.
>
> right but now user can supply an invalid config. What validates it?

It should be the parent driver. Btw, we've already suffered from this:

root@10:~# vdpa dev add name foo mgmtdev vdpasim_net
root@10:~# vdpa dev config show foo
foo: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
  negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM

Fixing this in the userspace requires more work, e.g query the default
features from the mgmtdev. So I think we need to fix that separately.

>
> > > in fact hex isn't very user friendly. why not pass feature
> > > names instead?
> >
> > This can be added on top if necessary. In fact there's a plan to
> > accept JSON files for provisioning.
> >
> > The advantages of hex is we don't need to keep the name  synced with
> > the new features.
> >
> > Thanks
>
> right but it also means we can't interpret them in any way.

Probably, but we can start from this while adding a new interface on
top. (E.g it's similar to the way we currently used in
/sys/bus/vdpa/device/virtio0/features, the difference is that sysfs
uses bitmap).

Thanks

>
>
> > >
> > >
> > >
> > > > @@ -708,7 +733,7 @@ static int cmd_dev_add(struct vdpa *vdpa, int argc, char **argv)
> > > >       err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
> > > >                                 VDPA_OPT_VDEV_MGMTDEV_HANDLE | VDPA_OPT_VDEV_NAME,
> > > >                                 VDPA_OPT_VDEV_MAC | VDPA_OPT_VDEV_MTU |
> > > > -                               VDPA_OPT_MAX_VQP);
> > > > +                               VDPA_OPT_MAX_VQP | VDPA_OPT_VDEV_FEATURES);
> > > >       if (err)
> > > >               return err;
> > > >
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
