Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C701C47085
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 14:52:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009BA6143E
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 14:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009BA6143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE0A760AF9;
	Tue, 25 May 2021 14:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pQzCdgq2L1DW; Tue, 25 May 2021 14:52:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F67660887;
	Tue, 25 May 2021 14:52:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19695C000D;
	Tue, 25 May 2021 14:52:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 551CCC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4448860887
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xZDU6aqqXMh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:52:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C1B660AF6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621954347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qSC9QpCDqCazF2mZq6d/82qLDoFltpJkJoLoXKJjvvg=;
 b=bAPrhT3X+BsXJjEChRcuqP/BkzyERT88goTS543qCi4vsGdLDposhrjF2l4Cd/mSkcw5fl
 CM0kgzZjPWFqM17hQ2IRUoAzBxj9hwerMbHhWypx9fiNlJICk9Y55ukQPVuBhNCYJYmn6Y
 Qj4hoTBOy2HITFSGbEjmhM4eU3l9y8o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-X2hPbTaOMKC-ayyGeXAm9A-1; Tue, 25 May 2021 10:52:24 -0400
X-MC-Unique: X2hPbTaOMKC-ayyGeXAm9A-1
Received: by mail-ed1-f71.google.com with SMTP id
 q18-20020a0564025192b02903888712212fso17454711edd.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 07:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qSC9QpCDqCazF2mZq6d/82qLDoFltpJkJoLoXKJjvvg=;
 b=WYH8jyX89Feis1DCGaUREEPK4UrFnmRj+dHKKRNcipA6YaVDe1wnDxVGyBsMGc4r0K
 xaP+qdNLdzaB+vgigtv403z2ONJXDvM0h/yeJUCFV1WE/WGAupBYcwit7/Xk5uvHemLr
 VQQvPwu+PFaO5J80IHqyoSXaXSULcatEwFJ2Oqp1ZVYJGK7ajZmDG2EfO7sy0GB6R2Fu
 vhqj6FOy8FcuS93fAFArNYrLTm/dZbYx83V3knBEOoKa45wpMOOv3g/UOewA+a8AwUg2
 hmuXSaGGMr2XNZNXh6HmLaeEmi4PnTYVSmZXIydeoeF/Fp1H+Zsv2YHmsWbBRDcCzG7W
 Zvew==
X-Gm-Message-State: AOAM530t/Bw4hed1ThcMGwwHWfEJ7RswA9x3+6oCg8NjgsdU94sXLY2/
 OTMGDvsOYzIYCmGNICWKPLlIeCUa4/UAdZSY+gicl1VNU1zXwWN8cmdU6n4Dp7pzZDSt0irXVkY
 cjCS9GWJPKzOvty6NCE0v/H+PJOyCPHPTSDd8qiVdug==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr32220061eds.270.1621954343100; 
 Tue, 25 May 2021 07:52:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDlSSMgDZFTIhLb5CNVeQ1FOGcYDV/D4Z+HKGAvXmcW1X5RbFzEx/ev3BuN5v5ARSJGUCLSQ==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr32220039eds.270.1621954342913; 
 Tue, 25 May 2021 07:52:22 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id h9sm10912173edt.18.2021.05.25.07.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 07:52:22 -0700 (PDT)
Date: Tue, 25 May 2021 16:52:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 00/18] virtio/vsock: introduce SOCK_SEQPACKET support
Message-ID: <20210525145220.amzme5mqqv4npirt@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210521075520.ghg75wpzz42zorxg@steredhat>
 <108b0bba-5909-cdde-97ee-321b3f5351ca@kaspersky.com>
 <b8dd3b55-0e2c-935a-d9bb-b13b7adc4458@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <b8dd3b55-0e2c-935a-d9bb-b13b7adc4458@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

On Tue, May 25, 2021 at 11:22:09AM +0300, Arseny Krasnov wrote:
>
>On 23.05.2021 15:14, Arseny Krasnov wrote:
>> On 21.05.2021 10:55, Stefano Garzarella wrote:
>>> Hi Arseny,
>>>
>>> On Thu, May 20, 2021 at 10:13:53PM +0300, Arseny Krasnov wrote:
>>>> 	This patchset implements support of SOCK_SEQPACKET for virtio
>>>> transport.
>>> I'll carefully review and test this series next Monday, in the mean time
>>> I think we should have at least an agreement about the changes that
>>> regards virtio-spec before merge this series, to avoid any compatibility
>>> issues.
>>>
>>> Do you plan to send a new version of the specification changes?
>>>
>>> Thanks,
>>> Stefano
>> Hello, sorry for long answer. I'm on vacation now, but i plan to send
>>
>> it in next several days, because with current implementation it is short
>>
>>
>> Thank You
>
>Hello, here is spec patch:
>
>https://lists.oasis-open.org/archives/virtio-comment/202105/msg00017.html
>
>Let's discuss it

Yep, sure.

About this series I think is better to split in two series since it 
became very long. Patchwork [1] also complains here [2].

You can send a first series with patches from 1 to 7. These patches are 
reviewed by me and can go regardless of the discussion of the VIRTIO 
specifications.
Maybe you can also add the patch with the test to this first series.

Please specify in the cover letter that the implementation for virtio 
devices is under development and will be sent later.


When it will be merged in the net-next tree, you can post the second 
part with the rest of the series that implements SEQPACKET for virtio 
devices, possibly after we received an agreement for the specifications.

Please use the "net-next" tag and take a look at 
Documentation/networking/netdev-FAQ.rst about netdev development.


Anyway, in the next days (hopefully tomorrow) I'll review the rest of 
the series related to virtio devices and spec.

Thanks,
Stefano

[1] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=486011&state=*

[2] 
https://patchwork.kernel.org/project/netdevbpf/patch/20210520191449.1270723-1-arseny.krasnov@kaspersky.com/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
