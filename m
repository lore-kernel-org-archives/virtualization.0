Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B9FC433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 11:10:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A3064E00
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 11:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A3064E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B937083927;
	Mon, 22 Feb 2021 11:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lFaKwG5MbALi; Mon, 22 Feb 2021 11:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D3AA8391F;
	Mon, 22 Feb 2021 11:10:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 962DBC000B;
	Mon, 22 Feb 2021 11:10:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C038C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2865F85D92
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B0H0fT6qvRwH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:10:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 93B5F85DCF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613992204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTTgTnnEUriuNUbTSpJOg3TlbAf8UgyHGlIQQW3D8og=;
 b=M/hnLyofc9bFEI9Y+4z20LPlp63yE72OK2KcKrGh2xX89Zl42UrmH2J1tXYyjSlfP1nfHX
 1o9irxib+2vUjwfK+IW0fIg/D/wMKeXNbwVwZp6j0CR67MybjQLAx4uISflH2UcSKRz5Gs
 9bpN65aHQaKQTCuEPoDqMs7rcAsPVJE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-eJTnrFFrMeW2aLjN-z2hsA-1; Mon, 22 Feb 2021 06:10:00 -0500
X-MC-Unique: eJTnrFFrMeW2aLjN-z2hsA-1
Received: by mail-wr1-f71.google.com with SMTP id t14so2638514wrr.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rTTgTnnEUriuNUbTSpJOg3TlbAf8UgyHGlIQQW3D8og=;
 b=PC/RjY2n2MYScU8aCzDQ/7FSfk/g1jrlEUIbRHqREhIObG75Y1SMTzcqBHU4LWOuIN
 dCYSD0xMyLC+P+KcrNVAy/Qbk5e0JFo+h8Z9PpFFTFk/5t32IacZ0hezNogBDYwYa93C
 F49sLNYS/WiuYG0zsHqHs/Db/8Qrze0gSPP3bbxNmRuP5f9dWsTHjD4HVCWFb58ZQ5fi
 MrzI/JF6AYy1nMlK0D6Zh4pSBRdl1s979VAvMFgpBESEpqJHUaLbMHws8rQwjBoT6NiC
 /yqG+RXazg/SLQzd2FzhOZvcEZTjTxm03AuQwt480JlATpQgdk+GbkUPRUGfuw5GxOZi
 ej7A==
X-Gm-Message-State: AOAM5315lU2nahCOkUMzq1NvG8saeKq3isq7hcr5Af7vFVvVfBnNu6HV
 f2SzfjYMp3LJym4H8k+I9zOGUxo097wsiISu+VkO8oxFEGlu09tsTiCoXno3O6IBkQbvO/3lR3F
 OyrEQV3eX5yaHlkHm9UwWPJOHNMDLiif3kua2kq3i5g==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr21067111wro.252.1613992199430; 
 Mon, 22 Feb 2021 03:09:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdwsRnGTQg4evIi4sY1oeSfuGUyHVWJW11J4EDEj0zsR/YaE8ZRE2845KqqVThW1r2aO7OIA==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr21067090wro.252.1613992199287; 
 Mon, 22 Feb 2021 03:09:59 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id o2sm300089wrw.2.2021.02.22.03.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 03:09:58 -0800 (PST)
Date: Mon, 22 Feb 2021 12:09:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 01/19] af_vsock: update functions for connectible
 socket
Message-ID: <20210222110956.3rwm2zm2ntctayci@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053607.1066783-1-arseny.krasnov@kaspersky.com>
 <20210222105023.aqcu25irkeed6div@steredhat>
 <279059b2-4c08-16d4-3bca-03640c7932d9@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <279059b2-4c08-16d4-3bca-03640c7932d9@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Mon, Feb 22, 2021 at 01:58:11PM +0300, Arseny Krasnov wrote:
>
>On 22.02.2021 13:50, Stefano Garzarella wrote:
>> On Thu, Feb 18, 2021 at 08:36:03AM +0300, Arseny Krasnov wrote:
>>> This prepares af_vsock.c for SEQPACKET support: some functions such
>>> as setsockopt(), getsockopt(), connect(), recvmsg(), sendmsg() are
>>> shared between both types of sockets, so rename them in general
>>> manner.
>>>
>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 64 +++++++++++++++++++++-------------------
>>> 1 file changed, 34 insertions(+), 30 deletions(-)
>> IIRC I had already given my R-b to this patch. Please carry it over when
>> you post a new version.
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Thanks,
>> Stefano
>Ack, sorry, didn't know that

Don't worry :-)

It is documented here: Documentation/process/submitting-patches.rst

	Both Tested-by and Reviewed-by tags, once received on mailing list from tester
	or reviewer, should be added by author to the applicable patches when sending
	next versions.  However if the patch has changed substantially in following
	version, these tags might not be applicable anymore and thus should be removed.
	Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
	in the patch changelog (after the '---' separator).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
