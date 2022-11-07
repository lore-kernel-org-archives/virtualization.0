Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5675C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 23:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62C3E4040B;
	Mon,  7 Nov 2022 23:06:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62C3E4040B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C4ohJ9JW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NGuA6QKnzmgn; Mon,  7 Nov 2022 23:06:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79D8A4033B;
	Mon,  7 Nov 2022 23:06:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79D8A4033B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58330C0032;
	Mon,  7 Nov 2022 23:06:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E546BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 23:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFCF581359
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 23:06:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFCF581359
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C4ohJ9JW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NMl8VLcy4D5a
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 23:06:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D991181354
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D991181354
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 23:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667862370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ql3/+AzyhVuxEaK0XBBzJjHyQy15pEZbdDGEtiC6+IA=;
 b=C4ohJ9JWxYbVrYt67x/MInFVnr3eIbjXThHuBMN/62KXenkSM/mi138EPjpNTZDGcA/I2T
 LnuL4CDu2s8H0EGZCoBd9T7WInFdYJOi5SoBkECDw4CIwR4v8x6K5lL4Q1IzLqAi/5YRqZ
 07y56Wp0U0sctVcGibUgQVT2KJFw26w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-WpmY00Q0ORyhEVFsDFJ6jA-1; Mon, 07 Nov 2022 18:06:09 -0500
X-MC-Unique: WpmY00Q0ORyhEVFsDFJ6jA-1
Received: by mail-qk1-f197.google.com with SMTP id
 bq13-20020a05620a468d00b006fa5a75759aso11427078qkb.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Nov 2022 15:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ql3/+AzyhVuxEaK0XBBzJjHyQy15pEZbdDGEtiC6+IA=;
 b=L9qRfJAd8oAY+W6x3bSXDBEOQu7EG8NxOxKZInG+gF6nNVgtTzikFz2N3jhWM8E6gq
 OaUIet4tzRHxXRyAM3X15aKrFjmVrs/yeMVkvn9Np/lvGsM/TPUSrodQZUuf7I4Q2LBD
 HIhgyud6dlD0K/HS7WGgglS9V5r5VIQxEqnneO+ibB0KD7k9k1x5yyfZilZXIeGoGJ8X
 3YOcxFPV7EDL/Rbtu9H+PuKddJU5iSb4R9A5/hwo7wK4mY2/56uEXS6nSCXlyCFhjH04
 y929ubRkU/JvPB4HSo9EzkFPZboXQg8xwwrKSxgcvuCgQ6PFbKFtzixRJpmI8F32N7/u
 IZtw==
X-Gm-Message-State: ACrzQf2OVchX5AAk4v9DzPwF2UU0yUkFBQgzh4Myw7Ljq9sxrIe00pIv
 fglEPMel3pe8IjrU65ukjwlBMmZfR8Kiv286Lu6VfnxS01fdr1jKk9Dd4GtMyDcI2vzhu65Xmn6
 x/wdKSyecrmEW5ZJwoIj1vQ9wWiFivlEGKUnjQlOKeQ==
X-Received: by 2002:ae9:e111:0:b0:6fa:1ea0:69e1 with SMTP id
 g17-20020ae9e111000000b006fa1ea069e1mr34568768qkm.370.1667862368962; 
 Mon, 07 Nov 2022 15:06:08 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7mmkvNGzkIVQsl0WH5rThaFl+Pp3Ew/JlRdT6tjQRoUw9VLkIT++tsBdx42M1W6auzIeyiWg==
X-Received: by 2002:ae9:e111:0:b0:6fa:1ea0:69e1 with SMTP id
 g17-20020ae9e111000000b006fa1ea069e1mr34568749qkm.370.1667862368734; 
 Mon, 07 Nov 2022 15:06:08 -0800 (PST)
Received: from redhat.com ([87.249.138.11]) by smtp.gmail.com with ESMTPSA id
 k11-20020a05620a0b8b00b006fab68c7e87sm1387980qkh.70.2022.11.07.15.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Nov 2022 15:06:08 -0800 (PST)
Date: Mon, 7 Nov 2022 18:06:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
Message-ID: <20221107180022-mutt-send-email-mst@kernel.org>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eric.auger.pro@gmail.com
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

On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> Hi Michael,
> On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> >> When the vhost iotlb is used along with a guest virtual iommu
> >> and the guest gets rebooted, some MISS messages may have been
> >> recorded just before the reboot and spuriously executed by
> >> the virtual iommu after the reboot. Despite the device iotlb gets
> >> re-initialized, the messages are not cleared. Fix that by calling
> >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>  drivers/vhost/vhost.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index 40097826cff0..422a1fdee0ca 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> >>  	}
> >>  
> >>  	vhost_iotlb_free(oiotlb);
> >> +	vhost_clear_msg(d);
> >>  
> >>  	return 0;
> >>  }
> > Hmm.  Can't messages meanwhile get processes and affect the
> > new iotlb?
> Isn't the msg processing stopped at the moment this function is called
> (VHOST_SET_FEATURES)?
> 
> Thanks
> 
> Eric

It's pretty late here I'm not sure.  You tell me what prevents it.

BTW vhost_init_device_iotlb gets enabled parameter but ignores
it, we really should drop that.

Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
and then cleared, iotlb is not properly cleared - bug?


> >
> >
> >> -- 
> >> 2.37.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
