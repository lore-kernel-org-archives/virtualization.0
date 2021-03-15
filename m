Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8BDC433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 17:06:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E3264DE0
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 17:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E3264DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E1876F48E;
	Mon, 15 Mar 2021 17:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y6uADU_9j64C; Mon, 15 Mar 2021 17:06:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4553F6F504;
	Mon, 15 Mar 2021 17:06:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18EC4C000B;
	Mon, 15 Mar 2021 17:06:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A455CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 17:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A5CA83478
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 17:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RyaouGxwNveM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 17:06:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABA16834DB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 17:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615827974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J/vGkdsnQYAk+OhLsLeLAuUC9tdXLy1WCBIdxzujSVI=;
 b=U+l8X+L32ca3MJXY0fFR3gjZlTXRxCo6Uai3OzMv8+C+8E8EAV+y7HLOA6fiaVfgoMu99i
 hYlU1pGXZoHG7j1wTbsyN7mO8KFV+Xfy+sUV+MtvTFXbWPIehKXJfPOuQxh3lMcgPdFlVf
 Ign5HhnqdDMU0RRSAWDcgIhKFz4tA5k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-opRVkQt4PSuzaNDbZOgkBg-1; Mon, 15 Mar 2021 13:06:11 -0400
X-MC-Unique: opRVkQt4PSuzaNDbZOgkBg-1
Received: by mail-wr1-f69.google.com with SMTP id m23so10342112wrh.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 10:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J/vGkdsnQYAk+OhLsLeLAuUC9tdXLy1WCBIdxzujSVI=;
 b=bKK4SiGxZ4ro8VPQE3NBI7ZncyKj/PS5g01xIBTXCndOyabq8nVmwjqsJuDNz3O6Rf
 msVlebLfovt2hrwugF3x4qAOZPgAuXvctJ0mrG9Q3T1snNYPCufQVnaz8RrSrxpmx4+8
 5F11ZhNQrsguo+qNUNkK2jfcWbZF5kdLYz1khyiAxetI2AgBaZDwxOfP404sfnJwi0SO
 892LcnRQ9elXc4oTnRZkNHiGOIaukJsakjQ4mpmHM3jzxJsRrYRDX++XX/BXaud0FVWT
 4jdIQEgXROhWEACTJ9ktOl2zw68iUyMpRwFZkqqR2iLfzwhe4FJ1t8yvtyqGIVOlkSR4
 wi6Q==
X-Gm-Message-State: AOAM533yY37EBEsJsvB/6Or0Thaupgdpu6Z2ysrQvg4oV/71eJx+EUbh
 4ZoteN92NB18fqoxw8T3VfrEBr5eV0yQhrrdQN/Nlf0plvenkUiAOdZWgriGHKdKxKsR8hnsPvy
 xiohhNNlAbreqbMZjPzjVWQLzJxsEUAvT1U22Ha7OzA==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr661767wrr.302.1615827970006;
 Mon, 15 Mar 2021 10:06:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB2RlJqBtvYUnzW0bm+UEON3/wM1HGbq8FitDx5F3L0+jguIDUzug5Ca5xtj3gBuGabiQNOw==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr661748wrr.302.1615827969836;
 Mon, 15 Mar 2021 10:06:09 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id l22sm19448508wrb.4.2021.03.15.10.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 10:06:09 -0700 (PDT)
Date: Mon, 15 Mar 2021 18:06:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v4 06/14] vringh: add vringh_kiov_length() helper
Message-ID: <20210315170607.3lajkedzkxa4elmr@steredhat>
References: <20210315163450.254396-1-sgarzare@redhat.com>
 <20210315163450.254396-7-sgarzare@redhat.com>
 <b06eb44c-d4e5-e47c-fbf5-26be469aae9e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b06eb44c-d4e5-e47c-fbf5-26be469aae9e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, Mar 15, 2021 at 05:51:30PM +0100, Laurent Vivier wrote:
>On 15/03/2021 17:34, Stefano Garzarella wrote:
>> This new helper returns the total number of bytes covered by
>> a vringh_kiov.
>>
>> Suggested-by: Jason Wang <jasowang@redhat.com>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/linux/vringh.h | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
>> index 755211ebd195..84db7b8f912f 100644
>> --- a/include/linux/vringh.h
>> +++ b/include/linux/vringh.h
>> @@ -199,6 +199,17 @@ static inline void vringh_kiov_cleanup(struct vringh_kiov *kiov)
>>  	kiov->iov = NULL;
>>  }
>>
>> +static inline size_t vringh_kiov_length(struct vringh_kiov *kiov)
>> +{
>> +	size_t len = 0;
>> +	int i;
>> +
>> +	for (i = kiov->i; i < kiov->used; i++)
>> +		len += kiov->iov[i].iov_len;
>> +
>> +	return len;
>> +}
>
>Do we really need an helper?
>
>For instance, we can use:
>
>len = iov_length((struct iovec *)kiov->iov, kiov->used);
>
>Or do we want to avoid the cast?

Yes, that should be fine. If we want, I can remove the helper and use 
iov_length() directly. I thought vringh wanted to hide iovec from users 
though.

Anyway talking to Jason, as a long term solution we should reconsider 
vringh and support iov_iter.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
