Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB026C433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 15:03:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5EB64D9F
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 15:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5EB64D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 015C787090;
	Mon, 15 Feb 2021 15:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FamfmSG-7Nf3; Mon, 15 Feb 2021 15:03:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 22EBE87028;
	Mon, 15 Feb 2021 15:03:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10304C0893;
	Mon, 15 Feb 2021 15:03:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A194C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 15:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F87C6F4A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 15:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BEagcUj3YaFc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 15:03:35 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 76F736F494; Mon, 15 Feb 2021 15:03:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D973D6F4A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 15:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613401412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6OX4vimRIYcAltpLrS5Z53hifPCnMBDqbANLVQyXP1s=;
 b=F8RurZ0ZPHzEyWL8V46Kc/onknZSfjNLApHm1u8TaHfFVNV3D5jEpqCS1sa9OMbatLrxbW
 TcBiMBMQ2cE8AkpfYcdo8girm3WiA+kfcGjWzskT+AdNj/ncm1RNEj4K7f8hBzTHinQYmP
 3AowOrtqDLczSS9IMVFLOEx7B1bdx+s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-UToNXvIUNge6d-QsjQ9l1A-1; Mon, 15 Feb 2021 10:03:31 -0500
X-MC-Unique: UToNXvIUNge6d-QsjQ9l1A-1
Received: by mail-wm1-f72.google.com with SMTP id j204so7869376wmj.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 07:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6OX4vimRIYcAltpLrS5Z53hifPCnMBDqbANLVQyXP1s=;
 b=i5KXiscg5zfcDrfUmFRccLIBmKoYnVUeF/MrThf5DmCBHwDcWkGZWssfUDNNpx7/MJ
 wg+Xl30xGZM9DTN/hg9iDstBLXrWS1geiZ4gLX34SzcWm09IfdP3jrhqxSiLowb/L94F
 af6LHGBeZIG9NbSdPbChJP05OwHF9prwVUnR0ikcxmGH9bkbTiT6hY7Uc1p62uXAsEzV
 BhWTmVul8227FOw8lHX1FxyA6g94ucj0StSESXrDHJskj8LdX3A3/UcKsTBpv7MO2F2+
 FZfQfKsLP16r+Se1oyeo9m1JEnEdOFTHJybj65C2kgQgaDDf56gfAsdbaCtv6c1y3o6o
 rF5A==
X-Gm-Message-State: AOAM533yj4GQengYogsK2DVHguclGxsyJu6pQpE1s8VMwYwFJdXvaKko
 w49MAoXL9W/bAgj4yW77rSf39tK4upKoBT+8rrYj+ThqKx7WtfljQXywqWy5KXHoImIY0I3gxwd
 ZjvcoDFVBplIfRV7N8HoTtaGi/l+UsenrNXyVFhTFlg==
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr4159122wmb.155.1613401405895; 
 Mon, 15 Feb 2021 07:03:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/AtAp079VBfkMV3Qo2wZFlU4QfgHEV8WJ1TqhKlNz8DDguCYh2aLXGYfoY3y+v1FTjOTtKQ==
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr4158972wmb.155.1613401404026; 
 Mon, 15 Feb 2021 07:03:24 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s10sm23992860wrm.5.2021.02.15.07.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 07:03:23 -0800 (PST)
Date: Mon, 15 Feb 2021 16:03:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH for 5.10] vdpa_sim: fix param validation in
 vdpasim_get_config()
Message-ID: <20210215150321.anwcogkifg6sefp6@steredhat>
References: <20210211162519.215418-1-sgarzare@redhat.com>
 <YCqF891BLn5zsUwd@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YCqF891BLn5zsUwd@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eli Cohen <elic@nvidia.com>
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

On Mon, Feb 15, 2021 at 03:32:19PM +0100, Greg KH wrote:
>On Thu, Feb 11, 2021 at 05:25:19PM +0100, Stefano Garzarella wrote:
>> Commit 65b709586e222fa6ffd4166ac7fdb5d5dad113ee upstream.
>
>No, this really is not that commit, so please do not say it is.

Oops, sorry.

>
>> Before this patch, if 'offset + len' was equal to
>> sizeof(struct virtio_net_config), the entire buffer wasn't filled,
>> returning incorrect values to the caller.
>>
>> Since 'vdpasim->config' type is 'struct virtio_net_config', we can
>> safely copy its content under this condition.
>>
>> Commit 65b709586e22 ("vdpa_sim: add get_config callback in
>> vdpasim_dev_attr") unintentionally solved it upstream while
>> refactoring vdpa_sim.c to support multiple devices. But we don't want
>> to backport it to stable branches as it contains many changes.
>>
>> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>> Cc: <stable@vger.kernel.org> # 5.10.x
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 6a90fdb9cbfc..8ca178d7b02f 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -572,7 +572,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>>  {
>>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>
>> -	if (offset + len < sizeof(struct virtio_net_config))
>> +	if (offset + len <= sizeof(struct virtio_net_config))
>>  		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
>>  }
>
>I'll be glad to take a one-off patch, but why can't we take the real
>upstream patch?  That is always the better long-term solution, right?

Because that patch depends on the following patches merged in v5.11-rc1 
while refactoring vdpa_sim:
   f37cbbc65178 vdpa_sim: make 'config' generic and usable for any device type
   cf1a3b35382c vdpa_sim: store parsed MAC address in a buffer
   a13b5918fdd0 vdpa_sim: add work_fn in vdpasim_dev_attr
   011c35bac5ef vdpa_sim: add supported_features field in vdpasim_dev_attr
   2f8f46188805 vdpa_sim: add device id field in vdpasim_dev_attr
   6c6e28fe4579 vdpa_sim: add struct vdpasim_dev_attr for device attributes
   36a9c3063025 vdpa_sim: rename vdpasim_config_ops variables
   423248d60d2b vdpa_sim: remove hard-coded virtq count

Maybe we can skip some of them, but IMHO should be less risky to apply 
only this change.

If you want I can try to figure out the minimum sub-set of patches 
needed for 65b709586e22 ("vdpa_sim: add get_config callback in 
vdpasim_dev_attr").

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
