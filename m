Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1016DC19F29
	for <virtualization@archiver.kernel.org>; Tue,  2 Aug 2022 08:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7707A404B1;
	Tue,  2 Aug 2022 08:04:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7707A404B1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ep/F+MZJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aX80grmXSQ3C; Tue,  2 Aug 2022 08:04:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 105DE4018E;
	Tue,  2 Aug 2022 08:04:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 105DE4018E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDBFBC0032;
	Tue,  2 Aug 2022 08:04:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C19FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 08:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64450812F9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 08:04:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64450812F9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ep/F+MZJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ANg5HwZftxSi
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 08:04:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B13CF812ED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B13CF812ED
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 08:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659427470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PnAgHb+qwkYr0eoeRI+miU3649J+IzbjO84fBGvUAWw=;
 b=ep/F+MZJgno/g4KEO/PavR5Zz8NweHNiutfkARlrXbMorBdcM3f+Coq3MPazmXeRb70fD6
 2CeqrtNeEfHJlPtWAGQe5cPAEc5PYED7hKyOVTgec39YGbLU3vxDAZYy15AEZtWbFwB/F6
 JeoCtUKLSkA7szepzyTe7lEl1MQEdTw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-n6YpS9DyOSaBzEV4ktql5w-1; Tue, 02 Aug 2022 04:04:29 -0400
X-MC-Unique: n6YpS9DyOSaBzEV4ktql5w-1
Received: by mail-qk1-f200.google.com with SMTP id
 j16-20020a05620a411000b006b5fb8e5d95so11025398qko.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Aug 2022 01:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=PnAgHb+qwkYr0eoeRI+miU3649J+IzbjO84fBGvUAWw=;
 b=dtwLKQJjzo+44hUlin9VTehDWqedM0qUiC3ap+g6uGhzr/dtKg1a//N752QKnJE1pU
 FVCrCFazyybOkhd52Yx2PusguUeZPpvaiVUF287DoPLWNwQ09PcI5OJVkpJezwhV7deg
 fIeJ3cEwiJPZg81UeAb//x2IwyITCORuq1VH4NZEk0yzMxEGQbsxwR8fWtouYuLzlfS7
 v4m1b63HmJQOK76IrqDyYgsRqjTHVJ3CFAOHDuRq0r4XCAtW4BU0pB5KlHlQIfdFOmzR
 DOoDkwi66oHOVfFMCU+nuBCUDbFxkt+vxE8TX29qVfAIrwYh1K4b8qjghWlan3qtiR6V
 ujHA==
X-Gm-Message-State: AJIora+Z8HtfGOKTfNCQyNNIn2hOxgW/tz9hCUYHm43mnMAZGv70i03K
 9UR2Nyl9CSqNgADGte9TFr2SLI+TtB8Sgay9OfG59zKeNLVZt6e8wq54b/nARRRc2jWGRrNgMz9
 70tb8Zz9XwWOsMODhRLdAC9syPvtonx9IGO6BxANYCA==
X-Received: by 2002:ac8:5b96:0:b0:31f:1931:b2b1 with SMTP id
 a22-20020ac85b96000000b0031f1931b2b1mr17183318qta.17.1659427468873; 
 Tue, 02 Aug 2022 01:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8d3getE7v6ehQxa40+uRjwcWSGfnrWrzaZU1/gX3jMXiALvanlrDyYV5QWSN3xAJSiT9vUw==
X-Received: by 2002:ac8:5b96:0:b0:31f:1931:b2b1 with SMTP id
 a22-20020ac85b96000000b0031f1931b2b1mr17183303qta.17.1659427468660; 
 Tue, 02 Aug 2022 01:04:28 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 g18-20020a05620a40d200b006b8d1914504sm636431qko.22.2022.08.02.01.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Aug 2022 01:04:28 -0700 (PDT)
Date: Tue, 2 Aug 2022 10:04:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [RFC PATCH v2 0/9] vsock: updates for SO_RCVLOWAT handling
Message-ID: <20220802080417.xyfwdidlirklr4oj@sgarzare-redhat>
References: <19e25833-5f5c-f9b9-ac0f-1945ea17638d@sberdevices.ru>
 <20220727123710.pwzy6ag3gavotxda@sgarzare-redhat>
 <D7315A7C-D288-4BDC-A8BF-B8631D8664BA@vmware.com>
MIME-Version: 1.0
In-Reply-To: <D7315A7C-D288-4BDC-A8BF-B8631D8664BA@vmware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Pv-drivers <Pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

Hi Vishnu,

On Tue, Aug 02, 2022 at 05:35:22AM +0000, Vishnu Dasa wrote:
>> On Jul 27, 2022, at 5:37 AM, Stefano Garzarella <sgarzare@redhat.com> 
>> wrote:
>> Hi Arseniy,
>>
>> On Mon, Jul 25, 2022 at 07:54:05AM +0000, Arseniy Krasnov wrote:

[...]

>>>
>>> 3) vmci/vsock:
>>>  Same as 2), but i'm not sure about this changes. Will be very good,
>>>  to get comments from someone who knows this code.
>>
>> I CCed VMCI maintainers to the patch and also to this cover, maybe
>> better to keep them in the loop for next versions.
>>
>> (Jorgen's and Rajesh's emails bounced back, so I'm CCing here only
>> Bryan, Vishnu, and pv-drivers@vmware.com)
>
>Hi Stefano,
>Jorgen and Rajesh are no longer with VMware.  There's a patch in
>flight to remove Rajesh from the MAINTAINERS file (Jorgen is already
>removed).

Thanks for the update! I will contact you and Bryan for any questions 
with VMCI in the future :-)

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
