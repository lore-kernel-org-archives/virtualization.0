Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F2AC25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 06:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FEF940AD9;
	Wed, 17 Aug 2022 06:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FEF940AD9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bUOK0ruy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3tOqDELExSm2; Wed, 17 Aug 2022 06:14:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BE39C4013F;
	Wed, 17 Aug 2022 06:14:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE39C4013F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F18CC0033;
	Wed, 17 Aug 2022 06:14:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9110C007D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 907B060899
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 907B060899
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bUOK0ruy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LUOimDuteI0Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:14:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3719160881
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3719160881
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660716854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5WXq38uVdbQKLKQ0vvxjz7mVWhtnqhwlhqcqZU+NRQ=;
 b=bUOK0ruydJsEjdaijhAVlZdLbSpuDY3jEXIz1+FFFpfefYYDaW1IQWXX3Av4061dUWMlX3
 dXErjt+AXHRzmD+xov16b3oLSNVK9hxRE29G8tFWwrQIWVjnd4WTl6iNyFHteMMCfwf7V9
 RbB/erShuC2rdQuAmMFViDVkGsvZDIU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-iJA9zbypOZWmSy4IY38vqg-1; Wed, 17 Aug 2022 02:14:11 -0400
X-MC-Unique: iJA9zbypOZWmSy4IY38vqg-1
Received: by mail-wr1-f72.google.com with SMTP id
 o13-20020adfba0d000000b0022524f3f4faso112714wrg.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 23:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=b5WXq38uVdbQKLKQ0vvxjz7mVWhtnqhwlhqcqZU+NRQ=;
 b=wDccuqqB7kcqkISgVoJwQ6SQuQXybBw17ogLKueETj1vsMDmzL84iA0mps+PAWDrpO
 p28towXBJh6GhwRHQb9BiWBs71SbIk2X26y9XrrYk5xca4shdAwZQYC0AtC8DcdqbinD
 1sLWYHzlUy/MHt5LVVtRbiL1XsDY92jCI2FhNty2s+Mg5D2m2ddow72aUxIYjVEyROmh
 dGsK3++rReDPejUq3a2W6C9nLhGwoNNPhWvyL+FV/xqoQD8+g8smfsrbfwl1aP56d+D/
 OXocC01qIZbG4uc3WmJBa2bvZH57rVHzofQMDF2uXVko3/b/uqbv3XMniXRYAChF/SFM
 nSwA==
X-Gm-Message-State: ACgBeo1rpC6sYgsdxtrLJHjrP27JEmJPrEIMd//2trPbggOCaet7+Eh/
 ALaUXWlaSv7MypsWKmxI2t7IAIRXKeS7hKlYWXJn5HeAVzwD9WKUGgmVZcnZiyT1uM+Ejcoeyvo
 BAJdhvBcUbX0TlXI/24BK1JzYNgoIuNUdD7JgoIgugg==
X-Received: by 2002:a5d:60c4:0:b0:225:25a0:fc9d with SMTP id
 x4-20020a5d60c4000000b0022525a0fc9dmr614848wrt.117.1660716850294; 
 Tue, 16 Aug 2022 23:14:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR730vle8jBvBqewXF5R967Qxjsub/mx4PScY4o2gdmAV6NnwPQs2WenMM7iE6HcStcrtn+/eQ==
X-Received: by 2002:a5d:60c4:0:b0:225:25a0:fc9d with SMTP id
 x4-20020a5d60c4000000b0022525a0fc9dmr614834wrt.117.1660716850019; 
 Tue, 16 Aug 2022 23:14:10 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 k11-20020a05600c0b4b00b003a4eea0aa48sm1116280wmr.0.2022.08.16.23.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 23:14:08 -0700 (PDT)
Date: Wed, 17 Aug 2022 02:14:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH V5 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Message-ID: <20220817021324-mutt-send-email-mst@kernel.org>
References: <20220812104500.163625-1-lingshan.zhu@intel.com>
 <20220812104500.163625-5-lingshan.zhu@intel.com>
 <e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com>
 <f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com>
 <2cbec85b-58f6-626f-df4a-cb1bb418fec1@oracle.com>
 <a488a17a-b716-52aa-cc31-2e51f8f972d2@intel.com>
MIME-Version: 1.0
In-Reply-To: <a488a17a-b716-52aa-cc31-2e51f8f972d2@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 17, 2022 at 10:11:36AM +0800, Zhu, Lingshan wrote:
> =

> =

> On 8/17/2022 6:48 AM, Si-Wei Liu wrote:
> =

> =

> =

>     On 8/16/2022 1:29 AM, Zhu, Lingshan wrote:
> =

> =

> =

>         On 8/16/2022 3:41 PM, Si-Wei Liu wrote:
> =

>             Hi Michael,
> =

>             I just noticed this patch got pulled to linux-next prematurely
>             without getting consensus on code review, am not sure why. Ho=
pe it
>             was just an oversight.
> =

>             Unfortunately this introduced functionality regression to at =
least
>             two cases so far as I see:
> =

>             1. (bogus) VDPA_ATTR_DEV_NEGOTIATED_FEATURES are inadvertently
>             exposed and displayed in "vdpa dev config show" before feature
>             negotiation is done. Noted the corresponding features name sh=
own in
>             vdpa tool is called "negotiated_features" rather than
>             "driver_features". I see in no way the intended change of the=
 patch
>             should break this user level expectation regardless of any sp=
ec
>             requirement. Do you agree on this point?
> =

>         I will post a patch for iptour2, doing:
>         1) if iprout2 does not get driver_features from the kernel, then =
don't
>         show negotiated features in the command output
> =

>     This won't work as the vdpa userspace tool won't know *when* features=
 are
>     negotiated. There's no guarantee in the kernel to assume 0 will be re=
turned
>     from vendor driver during negotiation. On the other hand, with the su=
pposed
>     change, userspace can't tell if there's really none of features negot=
iated,
>     or the feature negotiation is over. Before the change the userspace e=
ither
>     gets all the attributes when feature negotiation is over, or it gets
>     nothing when it's ongoing, so there was a distinction.This expectatio=
n of
>     what "negotiated_features" represents is established from day one, I =
see no
>     reason the intended kernel change to show other attributes should bre=
ak
>     userspace behavior and user's expectation.
> =

> User space can only read valid *driver_features* after the features negot=
iation
> is done, *device_features* does not require the negotiation.
> =

> If you want to prevent random values read from driver_features, here I pr=
opose
> a fix: only read driver_features when the negotiation is done, this means=
 to
> check (status & VIRTIO_CONFIG_S_FEATURES_OK) before reading the
> driver_features.
> Sounds good?
> =

> @MST, if this is OK, I can include this change in my next version patch s=
eries.
> =

> Thanks,
> Zhu Lingshan

Sorry I don't get it. Is there going to be a new version? Do you want me
to revert this one and then apply a new one? It's ok if yes.


>         2) process and decoding the device features.
> =

> =

>             2. There was also another implicit assumption that is broken =
by
>             this patch. There could be a vdpa tool query of config via
>             vdpa_dev_net_config_fill()->vdpa_get_config_unlocked() that r=
aces
>             with the first vdpa_set_features() call from VMM e.g. QEMU. S=
ince
>             the S_FEATURES_OK blocking condition is removed, if the vdpa =
tool
>             query occurs earlier than the first set_driver_features() cal=
l from
>             VMM, the following code will treat the guest as legacy and th=
en
>             trigger an erroneous vdpa_set_features_unlocked(... , 0) call=
 to
>             the vdpa driver:
> =

>             =A0374=A0=A0=A0=A0=A0=A0=A0=A0 /*
>             =A0375=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Config accesses aren't su=
pposed to trigger before
>             features are set.
>             =A0376=A0=A0=A0=A0=A0=A0=A0=A0=A0 * If it does happen we assu=
me a legacy guest.
>             =A0377=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>             =A0378=A0=A0=A0=A0=A0=A0=A0=A0 if (!vdev->features_valid)
>             =A0379=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vdpa_s=
et_features_unlocked(vdev, 0);
>             =A0380=A0=A0=A0=A0=A0=A0=A0=A0 ops->get_config(vdev, offset, =
buf, len);
> =

>             Depending on vendor driver's implementation, L380 may either =
return
>             invalid config data (or invalid endianness if on BE) or only =
config
>             fields that are valid in legacy layout. What's more severe is=
 that,
>             vdpa tool query in theory shouldn't affect feature negotiatio=
n at
>             all by making confusing calls to the device, but now it is po=
ssible
>             with the patch. Fixing this would require more delicate work =
on the
>             other paths involving the cf_lock reader/write semaphore.
> =

>             Not sure what you plan to do next, post the fixes for both is=
sues
>             and get the community review? Or simply revert the patch in
>             question? Let us know.
> =

>         The spec says:
>         The device MUST allow reading of any device-specific configuration
>         field before FEATURES_OK is set by
>         the driver. This includes fields which are conditional on feature=
 bits,
>         as long as those feature bits are offered
>         by the device.
> =

>         so whether FEATURES_OK should not block reading the device config
>         space. vdpa_get_config_unlocked() will read the features, I don't=
 know
>         why it has a comment:
>         =A0=A0=A0=A0=A0=A0=A0 /*
>         =A0=A0=A0=A0=A0=A0=A0=A0 * Config accesses aren't supposed to tri=
gger before features
>         are set.
>         =A0=A0=A0=A0=A0=A0=A0=A0 * If it does happen we assume a legacy g=
uest.
>         =A0=A0=A0=A0=A0=A0=A0=A0 */
> =

>         This conflicts with the spec.
> =

>         vdpa_get_config_unlocked() checks vdev->features_valid, if not va=
lid,
>         it will set the drivers_features 0, I think this intends to preve=
nt
>         reading random driver_features. This function does not hold any l=
ocks,
>         and didn't change anything.
> =

>         So what is the race?
>    =

>     You'll see the race if you keep 'vdpa dev config show ...' running in=
 a
>     tight loop while launching a VM with the vDPA device under query.
> =

>     -Siwei
> =

> =

> =

>        =

>         Thanks
> =

>        =

> =

>             Thanks,
>             -Siwei
> =

> =

>             On 8/12/2022 3:44 AM, Zhu Lingshan wrote:
> =

>                 Users may want to query the config space of a vDPA device,
>                 to choose a appropriate one for a certain guest. This mea=
ns the
>                 users need to read the config space before FEATURES_OK, a=
nd
>                 the existence of config space contents does not depend on
>                 FEATURES_OK.
> =

>                 The spec says:
>                 The device MUST allow reading of any device-specific
>                 configuration
>                 field before FEATURES_OK is set by the driver. This inclu=
des
>                 fields which are conditional on feature bits, as long as =
those
>                 feature bits are offered by the device.
> =

>                 Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>                 ---
>                 =A0 drivers/vdpa/vdpa.c | 8 --------
>                 =A0 1 file changed, 8 deletions(-)
> =

>                 diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>                 index 6eb3d972d802..bf312d9c59ab 100644
>                 --- a/drivers/vdpa/vdpa.c
>                 +++ b/drivers/vdpa/vdpa.c
>                 @@ -855,17 +855,9 @@ vdpa_dev_config_fill(struct vdpa_dev=
ice
>                 *vdev, struct sk_buff *msg, u32 portid,
>                 =A0 {
>                 =A0=A0=A0=A0=A0 u32 device_id;
>                 =A0=A0=A0=A0=A0 void *hdr;
>                 -=A0=A0=A0 u8 status;
>                 =A0=A0=A0=A0=A0 int err;
>                 =A0 =A0=A0=A0=A0=A0 down_read(&vdev->cf_lock);
>                 -=A0=A0=A0 status =3D vdev->config->get_status(vdev);
>                 -=A0=A0=A0 if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>                 -=A0=A0=A0=A0=A0=A0=A0 NL_SET_ERR_MSG_MOD(extack, "Featur=
es negotiation not
>                 completed");
>                 -=A0=A0=A0=A0=A0=A0=A0 err =3D -EAGAIN;
>                 -=A0=A0=A0=A0=A0=A0=A0 goto out;
>                 -=A0=A0=A0 }
>                 -
>                 =A0=A0=A0=A0=A0 hdr =3D genlmsg_put(msg, portid, seq, &vd=
pa_nl_family,
>                 flags,
>                 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VDPA_CMD_DE=
V_CONFIG_GET);
>                 =A0=A0=A0=A0=A0 if (!hdr) {
> =

> =

> =

> =

> =

> =

> =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
