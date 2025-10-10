Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773E2C3250
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Oct 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089451; cv=none; b=A3RLyibcogo0fk5sjTl5fiV2ul9s01httFJhohnrh17eA26yUoXOITSxVwjhHGAesIBlPqTW/V6Bgdhh/vuE992EhhyPEAfqfyRSK3HdOF5e/AJ2/nFGou6OTLt779GxPPN2WRBPzdneoN3rbWjUSNyGFw+7OmCWZFVGOl6Mb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089451; c=relaxed/simple;
	bh=52Q2ubmZ/97eCocS/WIEhCPzq+9F1kzrUmMOADe9ZII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ty4GFYBR48Q4wiuaG5z2wSW7EwP0o596dXw7Ao/xAFXXwe0prdTvJ+oNa3uRBqWA038CfQV311CGdRAiLBc2gJBs5LMyGEt/BfeckCVWosxMhOM+kuSKOlCBI14RKPigE6yUl0c9yYi0CZgRXpY2kXX86kcpZwL6vSMj7ZBUgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RP/CPQr7; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP/CPQr7"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D139841198
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Oct 2025 09:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d5Mz_SpS9vvq for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Oct 2025 09:44:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7CBAE403FE
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CBAE403FE
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RP/CPQr7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CBAE403FE
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Oct 2025 09:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760089441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4G1bzjK9vBge6G29XbbJt+l9nLYVQfJGhDgZgV1//U=;
	b=RP/CPQr76CbK+SBX7Et2MLeo9t9C2VNKeccSTRcaoivCpOJJ1XtDERwz/Ghy0w1tygkYiv
	tL6QokXxC3Dt8yTpl7kS57dRMQGdHzHHrawPfBs+9p5a3aNGANyWDv8QJs/7/pwVgznIDC
	HShdZSg/ZPkqatBpKYLej38xPMfll6g=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-1PgvnGtGMEOGanHsoIQ0lw-1; Fri, 10 Oct 2025 05:44:00 -0400
X-MC-Unique: 1PgvnGtGMEOGanHsoIQ0lw-1
X-Mimecast-MFC-AGG-ID: 1PgvnGtGMEOGanHsoIQ0lw_1760089440
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-748d8d78d98so44555037b3.2
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Oct 2025 02:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089440; x=1760694240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4G1bzjK9vBge6G29XbbJt+l9nLYVQfJGhDgZgV1//U=;
        b=FfaPizy2AHUVSi2GXAl1iDUwPFe/vQa+1Cp7a82O9VEZ3ynZqrIb7YIrhyxfZgFKXf
         4xivlAi37LFi1d3P/NDe+eQZSvh5z/z5UtACvI31LVmY11lSv8nFThmapqZVlLd1asRI
         9ABRe0El0jarr+7lodGV92fqQy6RdFRkDu2oMUuu+Uov/aRgZmtRonrOaqT8t/oSNtCu
         uNG7s9B7qdgINfBgd/FxLs/cTu3nIQdBp7sSio64AaOcAreZtOL9NlqAMGHW/kSc451Z
         WbE+jVGYIQ6NnhlJ0CaebAIAPemB7VBNVLPmNQEKOdkyi9t9nWQ0ekg5A/IY3i6aXSIw
         b9dw==
X-Forwarded-Encrypted: i=1; AJvYcCWk8/dhRxnqYySJlmvW02qutImHRYzFsWcNjv/xt/PdVmlLQg/cu4+3OtqYieGgsA1rtsQb8N46tO2JimgqLw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwjJg2cnSMwDhQnyzGagw8Q3UAwHIm9IF5BGMrkG7acE0N2Legp
	6PJJanv2+76D1h/4lxA1oe/zrt5a8AUIOB6NBXF7I3dE1kQwmw480nchedaEyRRqFbQofZwHKxN
	P6yWS9aCV8z7rCaNz6rODa6WCERaB3XrFU/Z+3NpUbjck7pmud28/xbbFFt6xPbZKVVFk7J108v
	YLyEOulIIGEVtmrEWp65xoZHPvqhDzP3kb1DQRe70rLXj4ImPOr2UvCCA86A==
X-Gm-Gg: ASbGncsyrakXT1D2W+eOtQIFe1mwuCXCBDIW3y39+oWHQ6nYSWNlGI52ediZR5HVvzs
	tjvsypEcfQ4zvmC9t9JZKRAzb9FycSwYf+zBe1ygGOyya9nlQCVGj/yUhR8uCqSqU1I5qV8zctw
	CIo93XqW55wYqQb1eFpH9CwVqMQtcp0LmssAVZhP+kSNnhzECgKWO3PkJv2uuRY4RVfSNydS7mY
	F1b5J+H
X-Received: by 2002:a05:690c:9a85:b0:77e:b290:58c4 with SMTP id 00721157ae682-780e160d16fmr132369117b3.54.1760089440151;
        Fri, 10 Oct 2025 02:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNFqjBBMxsgMxgtJUKSRYSRStZ2s0QlvOkVlhDNdy7dlspu5Qx8MC1UnD03swxF8s8e0HCcFtPSZ399+s/O+o=
X-Received: by 2002:a05:690c:9a85:b0:77e:b290:58c4 with SMTP id
 00721157ae682-780e160d16fmr132368867b3.54.1760089439771; Fri, 10 Oct 2025
 02:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1675725124-7375-1-git-send-email-si-wei.liu@oracle.com>
 <1675725124-7375-5-git-send-email-si-wei.liu@oracle.com> <CAJaqyWdEZbURGZtmobrED_jBq34DnQEuC8kUoPMH5=p2K7NE0w@mail.gmail.com>
 <f5897b60-8e4f-4a3c-a88d-f85be0bc7705@oracle.com> <CAJaqyWd2sRSMeR294sQGxyEFg3dPbd5AgUmG+C85oCCZXqCEBQ@mail.gmail.com>
 <eb3e016a-8b65-4547-9755-3ec03e248462@oracle.com>
In-Reply-To: <eb3e016a-8b65-4547-9755-3ec03e248462@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 10 Oct 2025 11:43:22 +0200
X-Gm-Features: AS18NWB2nJVCSMr4OeW-GC9Nrnvl0TUHL6Huhyhnkv39nxKLsynDHt3i6TqfWX4
Message-ID: <CAJaqyWczfXrUjm0u8kXuE1sj-jTaKD765Wb4pLgyDu+-KqPc=A@mail.gmail.com>
Subject: Re: [PATCH RESENT v4 4/6] vdpa: validate device feature provisioning
 against supported class
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Dragos Tatulea DE <dtatulea@nvidia.com>, Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GYUTCvO2e3XQh9gAzH_OjfrN0cmsIp1EsehJN3pKclw_1760089440
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:44=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/2/2025 12:27 AM, Eugenio Perez Martin wrote:
> > On Thu, Oct 2, 2025 at 1:27=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.co=
m> wrote:
> >> Hi Eugenio,
> >>
> >> On 10/1/2025 6:26 AM, Eugenio Perez Martin wrote:
> >>> On Tue, Feb 7, 2023 at 12:15=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>> Today when device features are explicitly provisioned, the features
> >>>> user supplied may contain device class specific features that are
> >>>> not supported by the parent management device. On the other hand,
> >>>> when parent management device supports more than one class, the
> >>>> device features to provision may be ambiguous if none of the class
> >>>> specific attributes is provided at the same time. Validate these
> >>>> cases and prompt appropriate user errors accordingly.
> >>>>
> >>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>> ---
> >>>>    drivers/vdpa/vdpa.c | 59 ++++++++++++++++++++++++++++++++++++++++=
+++++--------
> >>>>    1 file changed, 50 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >>>> index 1eba978..8da5120 100644
> >>>> --- a/drivers/vdpa/vdpa.c
> >>>> +++ b/drivers/vdpa/vdpa.c
> >>>> @@ -460,12 +460,28 @@ static int vdpa_nl_mgmtdev_handle_fill(struct =
sk_buff *msg, const struct vdpa_mg
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mde=
v,
> >>>> +                                   unsigned int *nclasses)
> >>>> +{
> >>>> +       u64 supported_classes =3D 0;
> >>>> +       unsigned int n =3D 0;
> >>>> +
> >>>> +       for (int i =3D 0; mdev->id_table[i].device; i++) {
> >>>> +               if (mdev->id_table[i].device > 63)
> >>>> +                       continue;
> >>>> +               supported_classes |=3D BIT_ULL(mdev->id_table[i].dev=
ice);
> >>>> +               n++;
> >>>> +       }
> >>>> +       if (nclasses)
> >>>> +               *nclasses =3D n;
> >>>> +
> >>>> +       return supported_classes;
> >>>> +}
> >>>> +
> >>>>    static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, st=
ruct sk_buff *msg,
> >>>>                                u32 portid, u32 seq, int flags)
> >>>>    {
> >>>> -       u64 supported_classes =3D 0;
> >>>>           void *hdr;
> >>>> -       int i =3D 0;
> >>>>           int err;
> >>>>
> >>>>           hdr =3D genlmsg_put(msg, portid, seq, &vdpa_nl_family, fla=
gs, VDPA_CMD_MGMTDEV_NEW);
> >>>> @@ -475,14 +491,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_=
mgmt_dev *mdev, struct sk_buff *m
> >>>>           if (err)
> >>>>                   goto msg_err;
> >>>>
> >>>> -       while (mdev->id_table[i].device) {
> >>>> -               if (mdev->id_table[i].device <=3D 63)
> >>>> -                       supported_classes |=3D BIT_ULL(mdev->id_tabl=
e[i].device);
> >>>> -               i++;
> >>>> -       }
> >>>> -
> >>>>           if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLA=
SSES,
> >>>> -                             supported_classes, VDPA_ATTR_UNSPEC)) =
{
> >>>> +                             vdpa_mgmtdev_get_classes(mdev, NULL),
> >>>> +                             VDPA_ATTR_UNSPEC)) {
> >>>>                   err =3D -EMSGSIZE;
> >>>>                   goto msg_err;
> >>>>           }
> >>>> @@ -566,13 +577,25 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct=
 sk_buff *skb, struct genl_info *i
> >>>>                                    BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU=
)     | \
> >>>>                                    BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX=
_VQP))
> >>>>
> >>>> +/*
> >>>> + * Bitmask for all per-device features: feature bits VIRTIO_TRANSPO=
RT_F_START
> >>>> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000ffffff=
f for
> >>>> + * all 64bit features. If the features are extended beyond 64 bits,=
 or new
> >>>> + * "holes" are reserved for other type of features than per-device,=
 this
> >>>> + * macro would have to be updated.
> >>>> + */
> >>>> +#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1)=
 | \
> >>>> +                             ((1ULL << VIRTIO_TRANSPORT_F_START) - =
1))
> >>>> +
> >>>>    static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, stru=
ct genl_info *info)
> >>>>    {
> >>>>           struct vdpa_dev_set_config config =3D {};
> >>>>           struct nlattr **nl_attrs =3D info->attrs;
> >>>>           struct vdpa_mgmt_dev *mdev;
> >>>> +       unsigned int ncls =3D 0;
> >>>>           const u8 *macaddr;
> >>>>           const char *name;
> >>>> +       u64 classes;
> >>>>           int err =3D 0;
> >>>>
> >>>>           if (!info->attrs[VDPA_ATTR_DEV_NAME])
> >>>> @@ -649,6 +672,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct =
sk_buff *skb, struct genl_info *i
> >>>>                   goto err;
> >>>>           }
> >>>>
> >>>> +       classes =3D vdpa_mgmtdev_get_classes(mdev, &ncls);
> >>>> +       if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
> >>>> +           !(classes & BIT_ULL(VIRTIO_ID_NET))) {
> >>>> +               NL_SET_ERR_MSG_MOD(info->extack,
> >>>> +                                  "Network class attributes provide=
d on unsupported management device");
> >>>> +               err =3D -EINVAL;
> >>>> +               goto err;
> >>>> +       }
> >>>> +       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> >>>> +           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> >>>> +           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> >>>> +           config.device_features & VIRTIO_DEVICE_F_MASK) {
> >>>> +               NL_SET_ERR_MSG_MOD(info->extack,
> >>>> +                                  "Management device supports multi=
-class while device features specified are ambiguous");
> >>>> +               err =3D -EINVAL;
> >>>> +               goto err;
> >>>> +       }
> >>> Hi! I need to question this last if() :). What's the point of error
> >>> when we specify features device-specific, from net or blk?
> >> Because device specific features belong to different feature space, fo=
r
> >> instance, VIRTIO_BLK_F_SIZE_MAX (1) on block device and
> >> VIRTIO_NET_F_GUEST_CSUM (1) on network device both use same feature bi=
t
> >> value of (1<<1)ULL, but they belong to different type of devices.
> >>
> >>> In the VDUSE case both blk and net are supported. I want to use
> >>> device_features to limit the net features that the VDUSE device
> >>> exports.
> >> Then we have to extend to the vdpa CLI to add "class ..." attribute to
> >> explicitly indicate which type of device the creation has to be, so
> >> eliminate the ambiguity entirely.
> >>
> >>> Also, why is this limited to only net devices?
> >> Actually, this is not limited to only net I think, we can even remove =
the
> >>
> >> classes & BIT_ULL(VIRTIO_ID_NET)
> >>
> >> conditional if mgmtdev and vdpa dev instance is 1:1 bound. But at the
> >> point when this code was written, it's not clear to me how multi-class
> >> can be supported - such that does it limit to one vdpa instance
> >> supporting one single class 1:1, or it is even possible to support bot=
h
> >> or multiple classes (multi-facets) per vdpa instance i.e. 1:N.
> >>
> >>>    does this part:
> >>>
> >>> classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1
> >>>
> >>> Means that it is ok to specify more than one class as long as the set
> >>> does not contain net?
> >> Exactly, that's why it is coded in that odd way. For instance, if a
> >> multi-facet vdpa instance needs to be provisioned with respective
> >> feature bits for both block and iSCSI device types at the same time, w=
e
> >> may have to extend the CLI usage to support that.
> >>
> > Right I get the algorithm, but I still don't get what this is trying
> > to solve :).
> Well the code was written at a time before any vdpa block device was
> added to vdpa, and it was anticipated to expand the same to other type
> of devices. The feature bit provisioning at this mgmtdev layer is
> expected to be only meaningful when you know which type of device you
> want to create, or it may have to defer to the device specific way to
> provision features. vduse is the latter example where it has the freedom
> to defer device class binding and have its client drive the feature
> provisioning.
>

Does it mean it is ok for you to move this code to the backend itself?
Should we do any change in any current backend in that case?

