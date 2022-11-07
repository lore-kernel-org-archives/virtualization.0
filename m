Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DE5C4332F
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 09:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D35DE80C57;
	Mon,  7 Nov 2022 09:14:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D35DE80C57
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJm8VOht
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKStdhTTAOcU; Mon,  7 Nov 2022 09:14:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BEBF80B7A;
	Mon,  7 Nov 2022 09:14:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BEBF80B7A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4328FC0032;
	Mon,  7 Nov 2022 09:14:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C68EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67ACB40887
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:14:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67ACB40887
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJm8VOht
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4c2V26rMYkAp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:14:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 804434087D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 804434087D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667812478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODD1ZGgE/joRUxe72IIKk0W+RdNnjnLWhwebrM3eS0I=;
 b=RJm8VOhtUKI0mTyt0MOjhXw0mtDHJ4Nx5achv2F3AbSPk7CIU3zJU7u3F3As4a+BaLUTEH
 hlw4dDEp/bAIKzawWvaH/A4bCuH/LTzkIFz0NLXf4v2BbIL5NQrMVRkOfsT7K4J8J8lb7O
 gw23Y3+VHbyi538wLhhM6y01uNT/J84=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-SJeaN84OM52FrSMJ0R5X7A-1; Mon, 07 Nov 2022 04:14:34 -0500
X-MC-Unique: SJeaN84OM52FrSMJ0R5X7A-1
Received: by mail-qk1-f198.google.com with SMTP id
 bi5-20020a05620a318500b006faaa1664b9so4612688qkb.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Nov 2022 01:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODD1ZGgE/joRUxe72IIKk0W+RdNnjnLWhwebrM3eS0I=;
 b=gLc1LVOFYKA7s3t7wujwaixO2OaPhbL03hqlXHIZMvyBTENO2RrN7NV150pMLVhv5u
 Ef6fakCBWMFoLag6oRT05WxJ9EUtYf0o988wRbGva/4hm03zHtOVbyi/9qNpgbV5DhRL
 EwvnDC28T4lzpZ/DIUxlGkm1ZMfSAuu/S2N6qWaHd6tf4AlFduNvwVrMu3Q2+YnlxQmC
 io5203ih5CdPElHneVwEytGTm7hvTHyHk8akGXIDmzJcg3DKMoLadlWY5ZsVf7Adn3y0
 G+tA/S+0G2sXI9YJXnItdkWShCIyAsiu5a0x+2eUF4iDCq0DXkb2T/S+EG9GVnkFjELp
 Id0w==
X-Gm-Message-State: ANoB5pnEYdzzoum8+n2a7VtqrX7TiTk6XPBROhpQEdILKK7U9B+4Ll3T
 cF9KslYfCDjbXJTwK+4r/F1vIt8z6dH5br3PRy/rcv3cZcVw3PvSxYhDKi772d10U+666fcsa+u
 WodyqQTw6LVshUA6/IXzx14PpgsJQZI0lU/ASZ/XCcQ==
X-Received: by 2002:ac8:4053:0:b0:3a5:89c9:3f3a with SMTP id
 j19-20020ac84053000000b003a589c93f3amr3366231qtl.277.1667812473903; 
 Mon, 07 Nov 2022 01:14:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ljjdNUz/NfeWybL5wh31/NNHiuP8MnAjjMocAGhKGlSLI6x8BHYMSXB/uLf5d4ihl8gtWYA==
X-Received: by 2002:ac8:4053:0:b0:3a5:89c9:3f3a with SMTP id
 j19-20020ac84053000000b003a589c93f3amr3366216qtl.277.1667812473639; 
 Mon, 07 Nov 2022 01:14:33 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 bp30-20020a05622a1b9e00b003a50248b89esm5765634qtb.26.2022.11.07.01.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Nov 2022 01:14:33 -0800 (PST)
Date: Mon, 7 Nov 2022 10:14:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa_sim: fix possible memory leak in vdpasim_net_init()
 and vdpasim_blk_init()
Message-ID: <20221107091424.dqlus2qdcsr2bmq3@sgarzare-redhat>
References: <20221104083423.2090463-1-ruanjinjie@huawei.com>
 <CACGkMEuxfB+9m1WW34L3sF6_F1iKCF9CSs9_P2V9jLh4sFXyAA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuxfB+9m1WW34L3sF6_F1iKCF9CSs9_P2V9jLh4sFXyAA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, ruanjinjie <ruanjinjie@huawei.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com, gautam.dawar@xilinx.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 07, 2022 at 03:41:42PM +0800, Jason Wang wrote:
>On Fri, Nov 4, 2022 at 4:41 PM ruanjinjie <ruanjinjie@huawei.com> wrote:
>>
>> If device_register() returns error in vdpasim_net_init() or
>> vdpasim_blk_init(), name of kobject which is allocated in dev_set_name()
>> called in device_add() is leaked.
>>
>> As comment of device_add() says, it should call put_device() to drop
>> the reference count that was set in device_initialize() when it fails,
>> so the name can be freed in kobject_cleanup().
>>
>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>
>Should we have a fixes tag and cc stable?

Yep, I think so.

The fixes tags should be:

Fixes: 899c4d187f6a ("vdpa_sim_blk: add support for vdpa management tool")
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

With them:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
