Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFAEC2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 08:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03B3560E61;
	Tue, 16 Aug 2022 08:41:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03B3560E61
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dKi4lKyS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29WJYqsYRDEZ; Tue, 16 Aug 2022 08:41:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 706EF60E39;
	Tue, 16 Aug 2022 08:41:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 706EF60E39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CB97C0033;
	Tue, 16 Aug 2022 08:41:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D7F6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A40560E61
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:41:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A40560E61
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hDS6sJSdW7Ga
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:41:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A10960E39
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A10960E39
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660639270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhzHSnD8m6MoYMeJjcaDLkKFr2qic5jMfN3mxxe71ZQ=;
 b=dKi4lKyS8qHPbkbciKneaLOzlGK3p7vWL5yoqIFynrfG6m+cHufjMsCxLlspETuVAylQcY
 Iww7lHIPgLiGXxFS+HOBGwOuXkSRk1IjxAwQE0vG8jf+gQVp5niU5N1Jmn7oDMh+BAGC94
 e+FOlElis0Al60scov7ApRqpiONET/c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-349-KYijqH8hMbSJm3dHMIYqjA-1; Tue, 16 Aug 2022 04:41:08 -0400
X-MC-Unique: KYijqH8hMbSJm3dHMIYqjA-1
Received: by mail-wr1-f72.google.com with SMTP id
 j7-20020adfa547000000b00224f7782df0so1288672wrb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 01:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=JhzHSnD8m6MoYMeJjcaDLkKFr2qic5jMfN3mxxe71ZQ=;
 b=4nYiu2fsMAvKyv06y03eBfwgxQbv4ZgE4FWJrqAAOTv6yLS3orLIOwd47NB7UDtRPH
 epQ3KP2A0HUfpLrLuhYs5U/6FnWUpUo1bnV3msGiQOr50hi7UNQ2hefYh3B3bYq6euw0
 bFjEPTUfXupje6wBI4EiqVPizPeBK3cec+2pmo8nBNDfGgP01KmLdqm4mq91Kt2//zda
 wdSOlG9CD6FK6ntCAcNcNFDnY/7P+hufq9GyrivyvWpZQwMJfz4LuANfUUjzMpxwJ4oE
 Nl72fgnVntfkpbp885p+2U1KAWeLackS0dc7s+GDKKH7dL68iHDYUFJquqJjT2D7qhGR
 QRMw==
X-Gm-Message-State: ACgBeo1kQqCb6C94+nt6tQ9DyYH/IgnUWpbBKOt4cVBijniHWTcTTn5K
 ufMwO5sYGYm4R4ud16Td1Xf0bOYF+6aSk7mn0OY7j1EmUT72VsCnN8GufN4dsb+UpDqESbJ9G+E
 BR6DCfEWCHDEipflIzEw4zvPJJwePSnhV+LKQlxHBVA==
X-Received: by 2002:a05:6000:1682:b0:221:599b:a41e with SMTP id
 y2-20020a056000168200b00221599ba41emr10782096wrd.522.1660639267035; 
 Tue, 16 Aug 2022 01:41:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7hrdq7Ri8Q9AJDYs6MtPPkgKJ3b2KGzM97zG859G9nTVxxin8BZSl5mWCVhZdEFvHN2HuLFA==
X-Received: by 2002:a05:6000:1682:b0:221:599b:a41e with SMTP id
 y2-20020a056000168200b00221599ba41emr10782082wrd.522.1660639266740; 
 Tue, 16 Aug 2022 01:41:06 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 p185-20020a1c29c2000000b003a4f1385f0asm12704773wmp.24.2022.08.16.01.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 01:41:06 -0700 (PDT)
Date: Tue, 16 Aug 2022 04:41:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH V5 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Message-ID: <20220816044007-mutt-send-email-mst@kernel.org>
References: <20220812104500.163625-1-lingshan.zhu@intel.com>
 <20220812104500.163625-5-lingshan.zhu@intel.com>
 <e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com>
 <f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com>
MIME-Version: 1.0
In-Reply-To: <f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com>
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

On Tue, Aug 16, 2022 at 04:29:04PM +0800, Zhu, Lingshan wrote:
> =

> =

> On 8/16/2022 3:41 PM, Si-Wei Liu wrote:
> =

>     Hi Michael,
> =

>     I just noticed this patch got pulled to linux-next prematurely without
>     getting consensus on code review, am not sure why. Hope it was just an
>     oversight.
> =

>     Unfortunately this introduced functionality regression to at least two
>     cases so far as I see:
> =

>     1. (bogus) VDPA_ATTR_DEV_NEGOTIATED_FEATURES are inadvertently expose=
d and
>     displayed in "vdpa dev config show" before feature negotiation is don=
e.
>     Noted the corresponding features name shown in vdpa tool is called
>     "negotiated_features" rather than "driver_features". I see in no way =
the
>     intended change of the patch should break this user level expectation
>     regardless of any spec requirement. Do you agree on this point?
> =

> I will post a patch for iptour2, doing:
> 1) if iprout2 does not get driver_features from the kernel, then don't sh=
ow
> negotiated features in the command output
> 2) process and decoding the device features.
> =

> =

>     2. There was also another implicit assumption that is broken by this =
patch.
>     There could be a vdpa tool query of config via vdpa_dev_net_config_fi=
ll()->
>     vdpa_get_config_unlocked() that races with the first vdpa_set_feature=
s()
>     call from VMM e.g. QEMU. Since the S_FEATURES_OK blocking condition is
>     removed, if the vdpa tool query occurs earlier than the first
>     set_driver_features() call from VMM, the following code will treat the
>     guest as legacy and then trigger an erroneous vdpa_set_features_unloc=
ked
>     (... , 0) call to the vdpa driver:
> =

>     =A0374=A0=A0=A0=A0=A0=A0=A0=A0 /*
>     =A0375=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Config accesses aren't supposed t=
o trigger before features
>     are set.
>     =A0376=A0=A0=A0=A0=A0=A0=A0=A0=A0 * If it does happen we assume a leg=
acy guest.
>     =A0377=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>     =A0378=A0=A0=A0=A0=A0=A0=A0=A0 if (!vdev->features_valid)
>     =A0379=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vdpa_set_featu=
res_unlocked(vdev, 0);
>     =A0380=A0=A0=A0=A0=A0=A0=A0=A0 ops->get_config(vdev, offset, buf, len=
);
> =

>     Depending on vendor driver's implementation, L380 may either return i=
nvalid
>     config data (or invalid endianness if on BE) or only config fields th=
at are
>     valid in legacy layout. What's more severe is that, vdpa tool query in
>     theory shouldn't affect feature negotiation at all by making confusing
>     calls to the device, but now it is possible with the patch. Fixing th=
is
>     would require more delicate work on the other paths involving the cf_=
lock
>     reader/write semaphore.
> =

>     Not sure what you plan to do next, post the fixes for both issues and=
 get
>     the community review? Or simply revert the patch in question? Let us =
know.
> =

> The spec says:
> The device MUST allow reading of any device-specific configuration field =
before
> FEATURES_OK is set by
> the driver. This includes fields which are conditional on feature bits, a=
s long
> as those feature bits are offered
> by the device.
> =

> so whether FEATURES_OK should not block reading the device config space. =

> vdpa_get_config_unlocked() will read the features, I don't know why it ha=
s a
> comment:
> =A0=A0=A0=A0=A0=A0=A0 /*
> =A0=A0=A0=A0=A0=A0=A0=A0 * Config accesses aren't supposed to trigger bef=
ore features are set.
> =A0=A0=A0=A0=A0=A0=A0=A0 * If it does happen we assume a legacy guest.
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> =

> This conflicts with the spec.

Yea well. On the other hand the spec also calls for features to be
used to detect legacy versus modern driver.
This part of the spec needs work generally.


> vdpa_get_config_unlocked() checks vdev->features_valid, if not valid, it =
will
> set the drivers_features 0, I think this intends to prevent reading random
> driver_features. This function does not hold any locks, and didn't change
> anything.
> =

> So what is the race?
> =

> Thanks
> =

> =

> =

>     Thanks,
>     -Siwei
> =

> =

>     On 8/12/2022 3:44 AM, Zhu Lingshan wrote:
> =

>         Users may want to query the config space of a vDPA device,
>         to choose a appropriate one for a certain guest. This means the
>         users need to read the config space before FEATURES_OK, and
>         the existence of config space contents does not depend on
>         FEATURES_OK.
> =

>         The spec says:
>         The device MUST allow reading of any device-specific configuration
>         field before FEATURES_OK is set by the driver. This includes
>         fields which are conditional on feature bits, as long as those
>         feature bits are offered by the device.
> =

>         Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>         ---
>         =A0 drivers/vdpa/vdpa.c | 8 --------
>         =A0 1 file changed, 8 deletions(-)
> =

>         diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>         index 6eb3d972d802..bf312d9c59ab 100644
>         --- a/drivers/vdpa/vdpa.c
>         +++ b/drivers/vdpa/vdpa.c
>         @@ -855,17 +855,9 @@ vdpa_dev_config_fill(struct vdpa_device *vde=
v,
>         struct sk_buff *msg, u32 portid,
>         =A0 {
>         =A0=A0=A0=A0=A0 u32 device_id;
>         =A0=A0=A0=A0=A0 void *hdr;
>         -=A0=A0=A0 u8 status;
>         =A0=A0=A0=A0=A0 int err;
>         =A0 =A0=A0=A0=A0=A0 down_read(&vdev->cf_lock);
>         -=A0=A0=A0 status =3D vdev->config->get_status(vdev);
>         -=A0=A0=A0 if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>         -=A0=A0=A0=A0=A0=A0=A0 NL_SET_ERR_MSG_MOD(extack, "Features negot=
iation not
>         completed");
>         -=A0=A0=A0=A0=A0=A0=A0 err =3D -EAGAIN;
>         -=A0=A0=A0=A0=A0=A0=A0 goto out;
>         -=A0=A0=A0 }
>         -
>         =A0=A0=A0=A0=A0 hdr =3D genlmsg_put(msg, portid, seq, &vdpa_nl_fa=
mily, flags,
>         =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VDPA_CMD_DEV_CONFIG=
_GET);
>         =A0=A0=A0=A0=A0 if (!hdr) {
> =

> =

> =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
