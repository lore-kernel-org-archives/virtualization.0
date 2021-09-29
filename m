Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119DEC433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 12:07:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED45610A2
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 12:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BED45610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B11380EEB;
	Wed, 29 Sep 2021 12:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p2ioYASTpA1w; Wed, 29 Sep 2021 12:07:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BBB2E80EC5;
	Wed, 29 Sep 2021 12:07:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A9ACC000F;
	Wed, 29 Sep 2021 12:07:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA2AAC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D653E60BCD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xwx_tnaCugKz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:07:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C447760BE7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632917237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TjaPtQIVyaNTSa/o4nl21pG4ZxQ2sYUDwxeyKouLuVU=;
 b=MM4ccefcOYnHsAzArEDgBxN4zPNmwJWIFaGEN5NSkqMSE1y2Yan/BDz6QQAU8QVn5GOpdq
 0qazT5l5dCQX/g51N38sP+sqUZnMjbyXM0YCNhe7USUk+5VnC7kzPDn3tFW6QMSN5SfDB6
 3OIozE9EahS7eKKqrdgEhRaPkkuSY9s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-O2mU27B6OW2Crg1BQG_GQg-1; Wed, 29 Sep 2021 08:07:15 -0400
X-MC-Unique: O2mU27B6OW2Crg1BQG_GQg-1
Received: by mail-ed1-f71.google.com with SMTP id
 h6-20020a50c386000000b003da01adc065so2173049edf.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 05:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TjaPtQIVyaNTSa/o4nl21pG4ZxQ2sYUDwxeyKouLuVU=;
 b=hTXKZB/jeQol0WtS29B6ziR4CMaSnTB4MtxHqDSAnzXmaa4hV8Qw3YBT30Ax87K+o6
 4QwnypoAnWC0jsRXDLpnxccDrBKgu5vm38bAPgz2kBB0h157LkjBYCJ7xciGA/rHvI77
 biAY8vFJBI/6mBDhix3IMJQXUTxMvPZD4r+VtH4bbIKxGj0UqYxWN3yORByy4JZeKmHm
 5ZIRiA1VbtexELdQyR+aVLedC12+p0jWFZxwX01d4asZaxeN/auX3A09/GXjUhmd7tgY
 eDkVZ8qY7R7c2qT3Hl5cO1EcHhhjBevP5AeVrfdzl/6hVFEf+lBptLzUmZsCgQg+v4ik
 QIIA==
X-Gm-Message-State: AOAM533rj7yBRLnw9H94IcWuWnMOr+32fWE5B1hCSjKDCJzTmL54B/d9
 iqZa+KN/NTlJwJJA90l85vBLg/Vk0N7eGL4FjTnVmsYIX6n26b9SFldN3+K/4lRCXWzecQtaG+0
 6CClwPd2NUsXfAu8e76ASOhL3uTJy8buh1xvgbe6lSA==
X-Received: by 2002:a17:906:12c6:: with SMTP id
 l6mr12958705ejb.373.1632917234526; 
 Wed, 29 Sep 2021 05:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySy4aeBD+SOCVK11vqzjwO404kU5KKADUFL2KFK6jhqXvMJPjz+GGtWbHgbSz8h+tVzrQ9+A==
X-Received: by 2002:a17:906:12c6:: with SMTP id
 l6mr12958692ejb.373.1632917234340; 
 Wed, 29 Sep 2021 05:07:14 -0700 (PDT)
Received: from steredhat (host-79-34-250-211.business.telecomitalia.it.
 [79.34.250.211])
 by smtp.gmail.com with ESMTPSA id p22sm1325308ejl.90.2021.09.29.05.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 05:07:14 -0700 (PDT)
Date: Wed, 29 Sep 2021 14:07:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20210929120712.annzkdwfy2g3sa2e@steredhat>
References: <20210929113742.GA7928@kili>
 <20210929114652.GV2083@kadam>
MIME-Version: 1.0
In-Reply-To: <20210929114652.GV2083@kadam>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Wed, Sep 29, 2021 at 02:46:52PM +0300, Dan Carpenter wrote:
>On Wed, Sep 29, 2021 at 02:37:42PM +0300, Dan Carpenter wrote:
>>     89         /* The last byte is the status and we checked if the last iov has
>>     90          * enough room for it.
>>     91          */
>>     92         to_push = vringh_kiov_length(&vq->in_iov) - 1;
>>
>> Are you positive that vringh_kiov_length() cannot be zero?  I looked at
>> the range_check() and there is no check for "if (*len == 0)".
>>
>>     93
>>     94         to_pull = vringh_kiov_length(&vq->out_iov);
>>     95
>>     96         bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &hdr,
>>     97                                       sizeof(hdr));
>>     98         if (bytes != sizeof(hdr)) {
>>     99                 dev_err(&vdpasim->vdpa.dev, "request out header too short\n");
>>     100                 return false;
>>     101         }
>>     102
>>     103         to_pull -= bytes;
>>
>> The same "bytes" is used for both to_pull and to_push.  In this
>> assignment it would only be used for the default case which prints an
>> error message.
>>
>
>Sorry, no.  This part is wrong.  "bytes" is not used for "to_push"
>either here or below.  But I still am not sure "*len == 0" or how we

At line 84 we check that the last `in_iov` has at least one byte, so 
vringh_kiov_length(&vq->in_iov) cannot be zero.
It will return the sum of all lengths, so at least 1.

Maybe better to add a comment.

>know that "to_push >= VIRTIO_BLK_ID_BYTES".

vringh_iov_push_iotlb() will push at least the bytes available in 
`in_iov`, if these are less, it will copy less bytes of 
VIRTIO_BLK_ID_BYTES.

Maybe here it would be better to add a check because the driver isn't 
following the specification.

And I'd avoid the subtraction highlighted by Smatch static checker.

Thanks for reporting. I'll send patches to fix these issues.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
