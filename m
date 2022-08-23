Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CABC32772
	for <virtualization@archiver.kernel.org>; Tue, 23 Aug 2022 20:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EC9E409C1;
	Tue, 23 Aug 2022 20:57:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EC9E409C1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M5lkpdiJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x50Mmoh8GOzn; Tue, 23 Aug 2022 20:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B72254012B;
	Tue, 23 Aug 2022 20:57:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B72254012B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F393C0032;
	Tue, 23 Aug 2022 20:57:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D02DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28FA240999
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:57:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28FA240999
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M5lkpdiJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aQ2k5yCEEsCk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:57:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EF474092F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EF474092F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661288226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ye9Fi4oA+sgS1EZvFu2xD8Gq2Q7V2mGd9cMXbr5HfE=;
 b=M5lkpdiJ6Gbd1EZg3Yc1yf+6u2VORasYLIt0WZSwVAlg6jenFZSYVqGYqYQap74dYj93vp
 79LIYe+JcN6NAkqfcDTevziFZyXQ21KK4wn3Yd/JvoYtYn4PNvly0xR8NQbmA7cqrfZR6u
 p7sHV1fPYYThQf174McRiADXHZ8PXUU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-471-Ov8l_TcMNJuw14RAi2L5bg-1; Tue, 23 Aug 2022 16:57:04 -0400
X-MC-Unique: Ov8l_TcMNJuw14RAi2L5bg-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay27-20020a05600c1e1b00b003a5bff0df8dso1120269wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 13:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc;
 bh=3Ye9Fi4oA+sgS1EZvFu2xD8Gq2Q7V2mGd9cMXbr5HfE=;
 b=UCrtQY5jgiv9qr9H8zo8bs7Ku6iEH2X2OG/biY+evr8yTvOP2MoorIsD22LtEhZW7j
 pMFu/XycnOZvEiX+DFEC2apRzcADg6V+R+eEmy/eOE8x6UwXvnblBZvJEjlOIhfytxu2
 RY3kyJ38ELm0xbOP5Sfa8xZJC2sn2X6Ydgu0/JXqAn1wbv+83dumG7B+f/8bmC9gjRYC
 GWWQc7Zn1yoP+NQlMXL/Qz+u3U2WLZqIqgHICIVMG8nkas8mt/xS9I/33ieibv+SMt1B
 AjjqVJXuPQuZJ8BG0UaPsURFgKynvr8h8dQYFVW8FQRwxMog7uydQZ731sQ37LVcADP1
 KHKg==
X-Gm-Message-State: ACgBeo3nIJrbdBO7BElls/8nnSxPzWvfcw7yowSx0DAdLstPySVUw/BO
 gE/xGFVkmrtSLS/8rIkIs1BiZav4KcX+KGrqBHcFk/pSjZ2xI56NcZAnne4hO5EIr+OW3IHLsVY
 w+B5gp2EHong259HQw1C+HmvAKLEj0mEzJMXhZK9tZw==
X-Received: by 2002:a5d:6d8c:0:b0:225:57a2:9564 with SMTP id
 l12-20020a5d6d8c000000b0022557a29564mr7076794wrs.139.1661288223804; 
 Tue, 23 Aug 2022 13:57:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR54Q25oOQQy6ncWsx6VrUpN/F0yvxwJjNCy88FJ6OQgWy/SD0qe1rcQwPjDrsdsaDlIGDXXRg==
X-Received: by 2002:a5d:6d8c:0:b0:225:57a2:9564 with SMTP id
 l12-20020a5d6d8c000000b0022557a29564mr7076778wrs.139.1661288223584; 
 Tue, 23 Aug 2022 13:57:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it.
 [146.241.97.176]) by smtp.gmail.com with ESMTPSA id
 25-20020a05600c029900b003a62bc1735asm280179wmk.9.2022.08.23.13.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Aug 2022 13:57:03 -0700 (PDT)
Message-ID: <5174d4ef7fe3928472d5a575c87ee627bfb4c129.camel@redhat.com>
Subject: Re: [PATCH net-next v4 0/9] vsock: updates for SO_RCVLOWAT handling
From: Paolo Abeni <pabeni@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Date: Tue, 23 Aug 2022 22:57:01 +0200
In-Reply-To: <YwU443jzc/N4fV3A@fedora>
References: <de41de4c-0345-34d7-7c36-4345258b7ba8@sberdevices.ru>
 <YwUnAhWauSFSJX+g@fedora> <20220823121852.1fde7917@kernel.org>
 <YwU443jzc/N4fV3A@fedora>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vishnu Dasa <vdasa@vmware.com>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 2022-08-23 at 16:30 -0400, Stefan Hajnoczi wrote:
> On Tue, Aug 23, 2022 at 12:18:52PM -0700, Jakub Kicinski wrote:
> > On Tue, 23 Aug 2022 15:14:10 -0400 Stefan Hajnoczi wrote:
> > > Stefano will be online again on Monday. I suggest we wait for him to
> > > review this series. If it's urgent, please let me know and I'll take a
> > > look.
> > 
> > It was already applied, sorry about that. But please continue with
> > review as if it wasn't. We'll just revert based on Stefano's feedback
> > as needed.
> 
> Okay, no problem.

For the records, I applied the series since it looked to me Arseniy
addressed all the feedback from Stefano on the first patch (the only
one still lacking an acked-by/reviewed-by tag) and I thought it would
be better avoiding such delay.

We are still early in this net-next cycle, I think it can be improved
incrementally as needed.

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
