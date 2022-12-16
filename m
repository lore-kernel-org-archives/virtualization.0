Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D5BC4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 08:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 206B2405FB;
	Fri, 16 Dec 2022 08:17:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 206B2405FB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RHQZZild
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TRUOh011yFnw; Fri, 16 Dec 2022 08:17:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A151A40187;
	Fri, 16 Dec 2022 08:17:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A151A40187
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6673EC0033;
	Fri, 16 Dec 2022 08:17:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6978C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 08:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AC0261102
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 08:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AC0261102
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RHQZZild
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zo0OwZVLKIVv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 08:17:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AB0961101
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AB0961101
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 08:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671178666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4KGOKUTEvzrBvEA1jxN7kPdKtnidXxtFVRo6lZX+D2Q=;
 b=RHQZZildndplTTcuTN4PN1ht4ZLFtS/qANn82bYYYxrg3XzDoJrlYh49/xWqXvXaw8tD9F
 LjfQln9M53T0l8CQ9qWxZJXtwSEvVMrOrRQluUPzh9dNLhXOYPZ9B+wQH32iqgXz58m8my
 akKefLyHzpXhDcHwMBRwkId0nXJChSg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-349-OYJoDTDYPQeRHqVJD_PXWQ-1; Fri, 16 Dec 2022 03:17:44 -0500
X-MC-Unique: OYJoDTDYPQeRHqVJD_PXWQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 w20-20020a056402269400b004700a51c202so1350059edd.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 00:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KGOKUTEvzrBvEA1jxN7kPdKtnidXxtFVRo6lZX+D2Q=;
 b=OWHkEUQ768RwB1xMKuXFGxA2m7eg8vUpsiB+TedneuZS1uc7YGkiB+MLF+UCRXMLgU
 jjcEOIoTXR42CkKrN25X9jcflcRWqY7Y54fNhOrV/Gn6rxW8X1r86QkcZqKxPkR2Kyr8
 g+VHskf3rv21zKQvkbBdA8hxwhRZQHNdYftN7kalmYhVCIgk4k1eePwHPcCEcyUvY9oz
 k4EHYjxwXxsA9Y5HedUYyhb6OyTKNzqFEywLX6mRtGyShov+WwyK1Mk4n5O0IwYbYDmK
 rwaAKiTuodwmvIL/HjkBccURagr6acSnjgcLfTGoreP8CcpqQ3ggUKsZ75xNQ/FsTZ0U
 vfjw==
X-Gm-Message-State: ANoB5pknr2NErbFW8E45TCBdXYUtSfIOzrqZFNipcZu4DFt5c2KRiGAF
 DpQYi6PLFp7LlkQUOzVylFIzKpZ9COrJgOCHMvndLL5J7hkEgn9oBXny60LI98foqlLiAntF/gQ
 y5+wG6HdVtMwVQ7rdP3RB5QyDJF1XrBr0PlJIkl1fZg==
X-Received: by 2002:a17:906:2a8c:b0:78d:f454:3771 with SMTP id
 l12-20020a1709062a8c00b0078df4543771mr24774192eje.20.1671178663700; 
 Fri, 16 Dec 2022 00:17:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6sZCQNVVSH0tlQ7oUCjhdaY1lAQnZ7t2cnJ55GlYG5/67gf8hOOHfNI/lL3sZrJTgcetWSDA==
X-Received: by 2002:a17:906:2a8c:b0:78d:f454:3771 with SMTP id
 l12-20020a1709062a8c00b0078df4543771mr24774184eje.20.1671178663487; 
 Fri, 16 Dec 2022 00:17:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 10-20020a170906328a00b007bc8ef7416asm574385ejw.25.2022.12.16.00.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Dec 2022 00:17:42 -0800 (PST)
Date: Fri, 16 Dec 2022 09:17:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 1/6] vdpa: add bind_mm callback
Message-ID: <20221216081738.wlhevfmvzfs3rsrg@sgarzare-redhat>
References: <20221214163025.103075-1-sgarzare@redhat.com>
 <20221214163025.103075-2-sgarzare@redhat.com>
 <CACGkMEtB6uQ_6fKU5F-D0vG+gQz9mMdYWUQwre-yp1sVpGvKPQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtB6uQ_6fKU5F-D0vG+gQz9mMdYWUQwre-yp1sVpGvKPQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

On Fri, Dec 16, 2022 at 02:37:45PM +0800, Jason Wang wrote:
>On Thu, Dec 15, 2022 at 12:30 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> This new optional callback is used to bind the device to a specific
>> address space so the vDPA framework can use VA when this callback
>> is implemented.
>>
>> Suggested-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/linux/vdpa.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index 6d0f5e4e82c2..34388e21ef3f 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -282,6 +282,12 @@ struct vdpa_map_file {
>>   *                             @iova: iova to be unmapped
>>   *                             @size: size of the area
>>   *                             Returns integer: success (0) or error (< 0)
>> + * @bind_mm:                   Bind the device to a specific address space
>> + *                             so the vDPA framework can use VA when this
>> + *                             callback is implemented. (optional)
>> + *                             @vdev: vdpa device
>> + *                             @mm: address space to bind
>
>Do we need an unbind or did a NULL mm mean unbind?

Yep, your comment in patch 6 makes it necessary. I will add it!

>
>> + *                             @owner: process that owns the address space
>
>Any reason we need the task_struct here?

Mainly to attach to kthread to the process cgroups, but that part is 
still in TODO since I need to understand it better.

Maybe we can remove the task_struct here and use `current` directly in 
the callback.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
