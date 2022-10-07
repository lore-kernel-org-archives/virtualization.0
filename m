Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8516C433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Oct 2022 13:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40C0360AF2;
	Fri,  7 Oct 2022 13:03:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40C0360AF2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DNzGyfMW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5d9cVs0CBRUI; Fri,  7 Oct 2022 13:03:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 825A260BBE;
	Fri,  7 Oct 2022 13:03:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 825A260BBE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F15DC0032;
	Fri,  7 Oct 2022 13:03:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C2A0C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 13:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28D9760BCB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 13:03:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28D9760BCB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x_ybnE7wOPZd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 13:03:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0478660BBE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0478660BBE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665147790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Wu7zkDvh9Y7YMMhVMehTcCNW6maACM0iCCQHnBi68g=;
 b=DNzGyfMWO3CzRZzCZgEN8LIn5Am6xBJ46HDqrOKM0gI12ZC0I1E56qN/OC0uOXTuuZti7H
 FtX69h1eywmNBJNeljuVJoqWbzJkVjpIn6S8dYsDINUvFbx7BBx/9fNkbZxUijK9btVtmd
 mlGEkrdLFAL3JwmetusFzpEzg5e91Dg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-a7nJ1vLdOS2kojS_ktgcFQ-1; Fri, 07 Oct 2022 09:03:09 -0400
X-MC-Unique: a7nJ1vLdOS2kojS_ktgcFQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 r4-20020adfbb04000000b0022e5ec02713so1417779wrg.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Oct 2022 06:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Wu7zkDvh9Y7YMMhVMehTcCNW6maACM0iCCQHnBi68g=;
 b=GRcyM/fo73xre2o70klbUussdR5nnxwAIY5sbrPBzkTkJ3rTUmNvHwiQ/XTnRtStHY
 9mcnXvkmKfpuDWBjl5ZjVHUBpJ15YoZf4lbrx2cLza4niCkpeKMZNCc3FE02HX9+N00p
 yPHY1lkw61En5d6bab+MrWmvGRhod2sGuppKavGOMio+ppbdDGQ2Kkp6SBcM0AWVDwDL
 Dx4HISd7+oCxvb06dN78oAhLlE57fXYSNMtVcKatNbWpOFRm+WofASObrxOMHfKOXRWA
 X2FGaSAhV9VpmQiENuWNbcWmfRYWUr+Ch+5SFtQEpOxRWgFt0niZ4DGEfUsCE+zsl+F1
 o4Ng==
X-Gm-Message-State: ACrzQf3823E4F/YN/cIPtHEOzuVoWPFy+PeJsExL8Tv/3MI4ExqG7/2B
 3BSe0E0HwdAz1motckeA2wg9AWn9a5Dn5/AfonXphZs7/eyXcPDWcqSOaiMe/3jEkL7ivT1bGIy
 r8CLZSZubIl/RmK+Dt/lz17odW0tR440tXSJqm5Gn+Q==
X-Received: by 2002:a5d:6f17:0:b0:22e:33e7:6f6c with SMTP id
 ay23-20020a5d6f17000000b0022e33e76f6cmr3084364wrb.201.1665147788494; 
 Fri, 07 Oct 2022 06:03:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6VJmA4yooQeEP6AWSZxrXCNMZ+Dd6ecWo+EA97vi7kYl5IewCjyra5zBCUEt/PMfgtrGiKeg==
X-Received: by 2002:a5d:6f17:0:b0:22e:33e7:6f6c with SMTP id
 ay23-20020a5d6f17000000b0022e33e76f6cmr3084320wrb.201.1665147788101; 
 Fri, 07 Oct 2022 06:03:08 -0700 (PDT)
Received: from redhat.com ([2.55.183.131]) by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003a5c999cd1asm2822460wmj.14.2022.10.07.06.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Oct 2022 06:03:07 -0700 (PDT)
Date: Fri, 7 Oct 2022 09:03:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Skalkin <igor.skalkin@opensynergy.com>
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20221007090223-mutt-send-email-mst@kernel.org>
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

Ping. If we still have no maintainer I'm marking it broken, users
should at least be warned.


> Our virtio bluetooth device has two backends - HCI_USER socket backend for one
> platform and uart backend for the other, and works well (after applying your
> "[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "device
> removal" problem can probably be considered solved .
> We could help with the rest of the problems you listed that can be solved
> (specification, QEMU support).
> And the only problem that is difficult to solve (because of the need to change
> UAPI header files) is just this one with unaligned configuration fields.
> At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_HCI
> (Indicates vendor command support) feature negotiated, the driver does not
> read the non-aligned configuration fields.
> 
> So, what would you advise us to do? Continuing to use the "marked broken"
> driver, start writing a specification for a new from scratch, better one?
> Or is there any way to bring this one back to life?
> 
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
