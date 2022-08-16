Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C35C25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 21:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 512A94055D;
	Tue, 16 Aug 2022 21:13:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 512A94055D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CypbVMr7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GewJ9DwC-XbC; Tue, 16 Aug 2022 21:13:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C24F24010D;
	Tue, 16 Aug 2022 21:13:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C24F24010D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90BB1C0032;
	Tue, 16 Aug 2022 21:13:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1933EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 21:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D475B8144B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 21:13:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D475B8144B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CypbVMr7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WhXxSIChfOla
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 21:13:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3FA681446
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3FA681446
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660684397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYi2WRVY0WJT21lyY1QoYwOC5FBNKCZk5dLPYuZKuSk=;
 b=CypbVMr74yjO/jehqeQ9S+l/2g8v5MyGRIBsQOl5tV1n1kQjzbPysAbRk6qykZseFDwFDk
 Rywa+9aeR29GSUM6RQKzA7Zi3EhVcp1RAB0VAnB48J4SiJUKIHQh3BZyvY0d0DZp6ELMkz
 +DSKDpKzEV+ExdkbbVoQfwqjKuYsbY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-nBEBoLDSPxyjj8mBQ_zM0A-1; Tue, 16 Aug 2022 17:13:16 -0400
X-MC-Unique: nBEBoLDSPxyjj8mBQ_zM0A-1
Received: by mail-wm1-f71.google.com with SMTP id
 c189-20020a1c35c6000000b003a4bfb16d86so5422928wma.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 14:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=AYi2WRVY0WJT21lyY1QoYwOC5FBNKCZk5dLPYuZKuSk=;
 b=txH477XBVKy1oVwA48Vk3Zxxab7kSda+/igRiYTbv5UYKahXP7IEHLfYMduT40IUH7
 BPaleCHhJFj2ytDPx6FAYXsoDQlSGmfwjpvbKqo+1jn+UbTyHLUFFFG0oUVJMJfvV3oa
 7qF82x+EohfYbkF/HDrCURJFZpFnUJe67I4k5ycPXyobyggfz/pCopS1bzCdEBXiWyh+
 Htv5oXjogPcfSCLPb4/4eIhH3PFwa0h7166fzGQQJ7fWFJoBQNYrEhzPFig0xXK33pFq
 KSL7GeyIVHpLY6b0cS4ObwFEDITDn1sEepjxxAZ51ob/gVVFVErmfoKAB8Wk8Mpu2YVi
 xFvw==
X-Gm-Message-State: ACgBeo1RuF65uOOj2/7NGuvIZSYtySNkZLhHdXxAPSfZgvJrV7GF5Sll
 qugsvEB+u9sc/mttxIjwqQ+8aHIo4S9AzuLw+vs2ZvX1HtVtxQWN1vmtn8f1J9BdDzngbiGCWjr
 gH378cW/erGgu0GdGjGnGniMG++aAoYA4aD0//9hu3g==
X-Received: by 2002:a5d:5949:0:b0:224:e674:534 with SMTP id
 e9-20020a5d5949000000b00224e6740534mr9977935wri.254.1660684395169; 
 Tue, 16 Aug 2022 14:13:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR55aKwS//DmXsaapDe8frvEPqPbRT1KPyjrWnb98GBtsRPDzvJ16TcKJ2nMrDKcC0LZ1eOhNg==
X-Received: by 2002:a5d:5949:0:b0:224:e674:534 with SMTP id
 e9-20020a5d5949000000b00224e6740534mr9977924wri.254.1660684394894; 
 Tue, 16 Aug 2022 14:13:14 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05600c149500b003a604a29a34sm4258950wmh.35.2022.08.16.14.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 14:13:14 -0700 (PDT)
Date: Tue, 16 Aug 2022 17:13:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH V5 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Message-ID: <20220816171106-mutt-send-email-mst@kernel.org>
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
> =

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
> =


I'm not sure who you are asking. I didn't realize this is so
controversial. If you feel it should be reverted I suggest
you post a revert patch with a detailed motivation and this
will get the discussion going.
It will also help if you stress whether you describe theoretical
issues or something observed in practice above
discussion does not make this clear.

-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
