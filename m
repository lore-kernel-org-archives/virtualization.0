Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BD9CD5BC0
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 13:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F61260E4E;
	Tue, 19 Sep 2023 13:36:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F61260E4E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=enFmpdmP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UeLqPSw-z3hI; Tue, 19 Sep 2023 13:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFCF0608D8;
	Tue, 19 Sep 2023 13:36:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFCF0608D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5AEAC0039;
	Tue, 19 Sep 2023 13:36:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9A79C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 13:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EA4D416F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 13:36:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EA4D416F8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=enFmpdmP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ck2yapiLVwtm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 13:36:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B49140165
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 13:36:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B49140165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695130561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQmRjXCmgAQl3a6tpa/J+d//osgH4H/G1TUy2TGbM10=;
 b=enFmpdmPnDJUjCGdFo2A+7ljU6lVl06QBRf4XfQhtrxaUVwKsHRoWSV+7i9iVDfpwhyY6i
 29utuKROz4Fz2xuWWGsdyX6yx2zoVL6xdDqJVQEUMrtY1OQ1Ssrv+2Xd/dSNnH+nTIGzaS
 LHj14iahnvgWIw7pomcemw5UDyvxLxM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-C2lTgcPINrW2Yfcv9N3L-Q-1; Tue, 19 Sep 2023 09:35:59 -0400
X-MC-Unique: C2lTgcPINrW2Yfcv9N3L-Q-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-770ef96aa0bso760155385a.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 06:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695130559; x=1695735359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQmRjXCmgAQl3a6tpa/J+d//osgH4H/G1TUy2TGbM10=;
 b=YOisztdL5wejhVPJzHKjmhFgso4yHbK9gjSb3rY+Rh2oGOfTBr0R/rK1ez10IRAbgY
 hbhJ2VpZf6zClVXJN3IQ83LTOZZRUYGVZLsDUuvYbkFru+odNSQ2Ghi8fHeZQx6GCvRz
 KHMk9a55JWmviMvhaFHzVuO+ZN07XVaqkPN3EevIgh/eb2wvZREt6J9x+t2Z94w6KH4n
 Vki4/WpAFCvfuLu//9dPhzwTxtBB9oU6fITh4YFC5rYRn1MalP9gzTp09PR3xjku0jk7
 3i9kxreWXzFLskhYD7/VRqUjstn7jU8suzVkGOSb9K/63309LtOdC2nOxgcwSOP4pCF2
 TmZw==
X-Gm-Message-State: AOJu0YxYWicn+I4VfTvrMed16y+uw/5mK/D3E34XJMyrvJ8Bvac9SyCt
 yNWFg9h8gbz3pMtnN8hiU8aeWXFBR33wvV2qKQ3xjQxvubSfHzX8nHQxtM/ycZxW3xcvViu1CYP
 g4mUmrVwdoqcIqgOUPTJWGmoK/yGg1z3Dhat5sFnkTA==
X-Received: by 2002:a0c:f001:0:b0:656:4a25:2080 with SMTP id
 z1-20020a0cf001000000b006564a252080mr7874559qvk.14.1695130559372; 
 Tue, 19 Sep 2023 06:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELog22rYA2MEE9wvtU9k2iQ0qP5GVCV4XB9+NFnOEeZMlYRp+cnMnNZiRhNH7IqEct7Tt4FA==
X-Received: by 2002:a0c:f001:0:b0:656:4a25:2080 with SMTP id
 z1-20020a0cf001000000b006564a252080mr7874542qvk.14.1695130559155; 
 Tue, 19 Sep 2023 06:35:59 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.165.38])
 by smtp.gmail.com with ESMTPSA id
 g28-20020a0caadc000000b0064d6a81e4d4sm1773184qvb.113.2023.09.19.06.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 06:35:58 -0700 (PDT)
Date: Tue, 19 Sep 2023 15:35:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <hq67e2b3ljfjikvbaneczdve3fzg3dl5ziyc7xtujyqesp6dzm@fh5nqkptpb4n>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
 <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
 <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
 <a5b25ee07245125fac4bbdc3b3604758251907d2.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a5b25ee07245125fac4bbdc3b3604758251907d2.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, Arseniy Krasnov <avkrasnov@salutedevices.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Tue, Sep 19, 2023 at 03:19:54PM +0200, Paolo Abeni wrote:
>On Tue, 2023-09-19 at 09:54 +0200, Stefano Garzarella wrote:
>> On Mon, Sep 18, 2023 at 07:56:00PM +0300, Arseniy Krasnov wrote:
>> > Hi Stefano,
>> >
>> > thanks for review! So when this patchset will be merged to net-next,
>> > I'll start sending next part of MSG_ZEROCOPY patchset, e.g. AF_VSOCK +
>> > Documentation/ patches.
>>
>> Ack, if it is not a very big series, maybe better to include also the
>> tests so we can run them before merge the feature.
>
>I understand that at least 2 follow-up series are waiting for this, one
>of them targeting net-next and the bigger one targeting the virtio
>tree. Am I correct?

IIUC the next series will touch only the vsock core
(net/vmw_vsock/af_vsock.c), tests, and documentation.

The virtio part should be fully covered by this series.

@Arseniy feel free to correct me!

>
>DaveM suggests this should go via the virtio tree, too. Any different
>opinion?

For this series should be fine, I'm not sure about the next series.
Merging this with the virtio tree, then it forces us to do it for
followup as well right?

In theory followup is more on the core, so better with net-next, but
it's also true that for now only virtio transports support it, so it
might be okay to continue with virtio.

@Michael WDYT?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
