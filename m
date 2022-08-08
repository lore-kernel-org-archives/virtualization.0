Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D51C25B0C
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 12:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB4EA605EC;
	Mon,  8 Aug 2022 12:16:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB4EA605EC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FP1n6iFy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hYTOgboxL6sE; Mon,  8 Aug 2022 12:16:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 57CCE60E33;
	Mon,  8 Aug 2022 12:16:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57CCE60E33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28D23C0033;
	Mon,  8 Aug 2022 12:16:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 976F8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DB7F60E33
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:16:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DB7F60E33
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RjYOeUigI_-o
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:16:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41A33605EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41A33605EC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659960973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQglINn5qIliFhQxdXnssuNFpnHg6itQvnE5dnSG+xE=;
 b=FP1n6iFyjMAzd1nqUb8NLw9Lt4Rndo7fzS+J+5s70Dog01aZwPTVMeRJVjZiNcVBDZ32eu
 7PgKkfEyzZ3xk42sBa8Wcm2YT6W02oHxAlmrZciQRqWCRdhCTWwdPH/9wfqmhMmyTCbahk
 IajlHigGVgG7I5noxW1u0y2gEO+Uf+8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-vzuelUTUPYqkwEoBNyDx8Q-1; Mon, 08 Aug 2022 08:16:12 -0400
X-MC-Unique: vzuelUTUPYqkwEoBNyDx8Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 r10-20020a1c440a000000b003a538a648a9so1797440wma.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 05:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=KQglINn5qIliFhQxdXnssuNFpnHg6itQvnE5dnSG+xE=;
 b=VasaaXA3d7zVITt50BzzY24VO1uywzAnP7fPm7mpN6LESkYdiw4BqGrg91OY1MXVrO
 F91PmXcaX6kWgo1f9eJazUW7+Ztp3Qx4wQredNIfxPoiD3tlkxO0/6QrvVw6WgdQZy+u
 v2kRmMagkNQFU5pm8c4yR0XW+THFy0u6lqNOUwG+B5kUtQeV2NKPI5ExE+QrRuZ7RHJN
 tkw0jH8eIDXfz0o8QPo1Seiml9rmN9A8b+W4BOL2M8oQNmy4IsKKrUoq3quW0wiTnWDF
 ZhTtv3hj5zqoCFlaTvwY2NYNtRR+pfBRS+jb47p5bTUZUDyQKIUXzKFETBn76GhsMENz
 LwCA==
X-Gm-Message-State: ACgBeo1GydcDH5TBxakO/MehXJn+RewfRjRdY1vmPl8dS48vmQmwEoo/
 CqBMXE51N0VORnAdmk6Vc2t90WPfaVNLyJzzhhxmUH+8BCqYf66rVqBitfLN8jM0o387ceYFcft
 7c/jx3mFmXZTcdZ+THpqaA3AmTbBSyMcD+GSWoPs8ag==
X-Received: by 2002:adf:ecc7:0:b0:220:5fef:6d40 with SMTP id
 s7-20020adfecc7000000b002205fef6d40mr11346422wro.5.1659960971201; 
 Mon, 08 Aug 2022 05:16:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zU6VHrKnAMD/aDkLqilJynNkwCVR51Kx58+rPxKSAaPZ1EV8m5UjTlEMZZCTPAQylrfDvzg==
X-Received: by 2002:adf:ecc7:0:b0:220:5fef:6d40 with SMTP id
 s7-20020adfecc7000000b002205fef6d40mr11346410wro.5.1659960970977; 
 Mon, 08 Aug 2022 05:16:10 -0700 (PDT)
Received: from redhat.com ([2.52.21.123]) by smtp.gmail.com with ESMTPSA id
 c24-20020a7bc018000000b003a53731f273sm5898667wmb.31.2022.08.08.05.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 05:16:10 -0700 (PDT)
Date: Mon, 8 Aug 2022 08:16:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Skalkin <igor.skalkin@opensynergy.com>
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220808081054-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, mgo@opensynergy.com,
 Marcel Holtmann <marcel@holtmann.org>
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

On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> On 8/8/22 01:00, Michael S. Tsirkin wrote:
> 
>     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> 
>         According to specification [1], "For the device-specific configuration
>         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
>         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
>         and aligned accesses for 32 and 64 bit wide fields.".
> 
>         Current version of the configuration structure:
> 
>             struct virtio_bt_config {
>                 __u8  type;
>                 __u16 vendor;
>                 __u16 msft_opcode;
>             } __attribute__((packed));
> 
>         has both 16bit fields non-aligned.
> 
>         This commit fixes it.
> 
>         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> 
>         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> 
>     This is all true enough, but the problem is
>     1. changing uapi like this can't be done, will break userspace
>     2. the driver has more issues and no one seems to want to
>        maintain it.
>     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
>     to merge it for this release.
> 
> This is very sad. We already use this driver in our projects.

Really?  Can you step up to maintain it? Then we can fix the issues
and it won't be broken.

> Our virtio bluetooth device has two backends - HCI_USER socket backend for one
> platform and uart backend for the other, and works well (after applying your
> "[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "device
> removal" problem can probably be considered solved .

Can you post a Tested-by tag for that?

I need to go back and review it, I think I saw some issues but must be
fixable.

> We could help with the rest of the problems you listed that can be solved
> (specification, QEMU support).
> And the only problem that is difficult to solve (because of the need to change
> UAPI header files) is just this one with unaligned configuration fields.
> At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_HCI
> (Indicates vendor command support) feature negotiated, the driver does not
> read the non-aligned configuration fields.


Hmm. So how about this:
- add a new feature flag
- add new aligned format
- mark the old memory reserved in the spec


> So, what would you advise us to do? Continuing to use the "marked broken"
> driver, start writing a specification for a new from scratch, better one?
> Or is there any way to bring this one back to life?

If someone is prepared to work on this we can bring it back.



> 
> 
>         ---
>          include/uapi/linux/virtio_bt.h | 2 +-
>          1 file changed, 1 insertion(+), 1 deletion(-)
> 
>         diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
>         index a7bd48daa9a9..adc03709cc4f 100644
>         --- a/include/uapi/linux/virtio_bt.h
>         +++ b/include/uapi/linux/virtio_bt.h
>         @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
>          };
> 
>          struct virtio_bt_config {
>         -       __u8  type;
>                 __u16 vendor;
>                 __u16 msft_opcode;
>         +       __u8  type;
>          } __attribute__((packed));
> 
>          #endif /* _UAPI_LINUX_VIRTIO_BT_H */
>         --
>         2.34.1
> 
> --
> 
> Best regards,
> 
> Igor Skalkin
> Software Engineer
> 
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
> 
> igor.skalkin@opensynergy.com
> www.opensynergy.com
> 
> registered: Amtsgericht Charlottenburg, HRB 108616B
> General Management: Rolf Morich, Stefaan Sonck Thiebaut
> 
> 
> Please mind our privacy notice pursuant to Art. 13 GDPR. // Unsere Hinweise zum
> Datenschutz gem. Art. 13 DSGVO finden Sie hier.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
