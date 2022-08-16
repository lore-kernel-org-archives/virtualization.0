Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8DAC38142
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 08:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72B5160E39;
	Tue, 16 Aug 2022 08:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72B5160E39
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cz8FF9qj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FLXG1-xMApkp; Tue, 16 Aug 2022 08:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1F36600D4;
	Tue, 16 Aug 2022 08:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1F36600D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6C43C0033;
	Tue, 16 Aug 2022 08:23:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A49CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D907560B8A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:23:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D907560B8A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0dgPv28cr8YH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76E8C600D4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76E8C600D4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660638208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4oG1fGIfLDR5f50kJC3AlbvxuOG5rss32LyfKjRXLI=;
 b=Cz8FF9qj8iyLoVG/gZTnuT3IAZrC4Z6prE1rZD249413hVn1RsyFi8LY2dVgOB5ZwryNgp
 8fm4s9i8SQIx4kFdhO+5YRINrWMjtl+KsZa/ZW3BNpKeQamc80e3jMIGOEqPldM+r8rPIL
 tmhWAs7HMtpS2qP3heI3IUnGMSyjoxQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-rXWxPIe4MUW2NlCUqtVVAw-1; Tue, 16 Aug 2022 04:23:27 -0400
X-MC-Unique: rXWxPIe4MUW2NlCUqtVVAw-1
Received: by mail-wr1-f70.google.com with SMTP id
 p9-20020adfba89000000b002238405b027so1647149wrg.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 01:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=V4oG1fGIfLDR5f50kJC3AlbvxuOG5rss32LyfKjRXLI=;
 b=zkA2JXJ0Yjedij6lxN7XafxVTnNg9hA4Bsrga996h3pTW6IjWERcyunIhjzvL/JtYS
 I8Y/ccTD+KSRzTESEO40uUhqRRez+5LBh6zLmjhG9A3HihCWTEmmFXUyjwFa+B19geuc
 M3k9/ZkcROFklfWC8UtaFBlsgiU/l363PGIqWlbN/iV7e5q9V9w0jj5wwUXXfCv4Vt7r
 GrfdPNRoYWK9n8AzT3RqOYvmCtgRy48ALEvAhMXx/lzqPsr3mPL+7YxBDrjCyqs3TTdt
 krLzh39Lq6j/uHbYDNWAlnPxMoSUaWcCx0l2iDGfLNfi/gE9fdUwXRUgaziLshS8GdOw
 BlKA==
X-Gm-Message-State: ACgBeo2Y2Z2krTGE2Y5A+VrQkWNHrMnZ3r0oyWLJJjiM0F+4R/tWdbHB
 R6vsJHELkHngU2E8hv7bbFE99OEmz1snxse9sgFyTdVmu2ejn1wTfPZRv4FMyRTc9buWcmq7Ohy
 nbQulJqs1w3If4IfrYUahz4hyOEMdgb0vb3vIZ4sSpQ==
X-Received: by 2002:a5d:6da8:0:b0:221:7db8:de0a with SMTP id
 u8-20020a5d6da8000000b002217db8de0amr10846360wrs.405.1660638205979; 
 Tue, 16 Aug 2022 01:23:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Be6LbtV7yTGqbSUu3sanvO4iZ86CjPJG2SNzqsNkmuRv69b6+YtLfJuQbl54PznhWVwsbJQ==
X-Received: by 2002:a5d:6da8:0:b0:221:7db8:de0a with SMTP id
 u8-20020a5d6da8000000b002217db8de0amr10846349wrs.405.1660638205760; 
 Tue, 16 Aug 2022 01:23:25 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b003a5c1e916c8sm2328119wmq.1.2022.08.16.01.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 01:23:25 -0700 (PDT)
Date: Tue, 16 Aug 2022 04:23:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH V5 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Message-ID: <20220816042157-mutt-send-email-mst@kernel.org>
References: <20220812104500.163625-1-lingshan.zhu@intel.com>
 <20220812104500.163625-5-lingshan.zhu@intel.com>
 <e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com, Zhu Lingshan <lingshan.zhu@intel.com>
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

On Tue, Aug 16, 2022 at 12:41:21AM -0700, Si-Wei Liu wrote:
> Hi Michael,
> =

> I just noticed this patch got pulled to linux-next prematurely without
> getting consensus on code review, am not sure why. Hope it was just an
> oversight.
> =

> Unfortunately this introduced functionality regression to at least two ca=
ses
> so far as I see:
> =

> 1. (bogus) VDPA_ATTR_DEV_NEGOTIATED_FEATURES are inadvertently exposed and
> displayed in "vdpa dev config show" before feature negotiation is done.
> Noted the corresponding features name shown in vdpa tool is called
> "negotiated_features" rather than "driver_features". I see in no way the
> intended change of the patch should break this user level expectation
> regardless of any spec requirement. Do you agree on this point?
> =

> 2. There was also another implicit assumption that is broken by this patc=
h.
> There could be a vdpa tool query of config via
> vdpa_dev_net_config_fill()->vdpa_get_config_unlocked() that races with the
> first vdpa_set_features() call from VMM e.g. QEMU. Since the S_FEATURES_OK
> blocking condition is removed, if the vdpa tool query occurs earlier than
> the first set_driver_features() call from VMM, the following code will tr=
eat
> the guest as legacy and then trigger an erroneous
> vdpa_set_features_unlocked(... , 0) call to the vdpa driver:
> =

> =A0374=A0=A0=A0=A0=A0=A0=A0=A0 /*
> =A0375=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Config accesses aren't supposed to tr=
igger before features
> are set.
> =A0376=A0=A0=A0=A0=A0=A0=A0=A0=A0 * If it does happen we assume a legacy =
guest.
> =A0377=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> =A0378=A0=A0=A0=A0=A0=A0=A0=A0 if (!vdev->features_valid)
> =A0379=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vdpa_set_features_=
unlocked(vdev, 0);
> =A0380=A0=A0=A0=A0=A0=A0=A0=A0 ops->get_config(vdev, offset, buf, len);
> Depending on vendor driver's implementation, L380 may either return inval=
id
> config data (or invalid endianness if on BE) or only config fields that a=
re
> valid in legacy layout. What's more severe is that, vdpa tool query in
> theory shouldn't affect feature negotiation at all by making confusing ca=
lls
> to the device, but now it is possible with the patch. Fixing this would
> require more delicate work on the other paths involving the cf_lock
> reader/write semaphore.
> =

> Not sure what you plan to do next, post the fixes for both issues and get
> the community review? Or simply revert the patch in question? Let us know.
> =

> Thanks,
> -Siwei

If we can get fixes that's good. If not I can apply a revert.
I'm on vacation next week, you guys will have the time
to figure out the best plan of action.

-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
