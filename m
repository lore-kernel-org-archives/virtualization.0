Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F202DC00448
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 02:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 693BA6102B;
	Thu, 25 Aug 2022 02:27:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 693BA6102B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HeXk1U6U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l4I_cmSU6snY; Thu, 25 Aug 2022 02:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 06B0C61029;
	Thu, 25 Aug 2022 02:27:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06B0C61029
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DE14C0033;
	Thu, 25 Aug 2022 02:27:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8B0BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 02:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 827CE831A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 02:27:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 827CE831A5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HeXk1U6U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5uQYbMgYWe7Z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 02:27:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B688282F13
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B688282F13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 02:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661394470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7oCxRBbuY8aIO0Ao6tZmCfYWlpBTx31oDreFNCWBJ84=;
 b=HeXk1U6UpeZXqJaYFsotPYrSdUyJ2ssH4Rc2aDlvYfN0U7QjL4fdrlMM/hUAHGcAxPv/89
 RvwxMQv8dQsjrIejg0hQyS0WWQO1aJIX6tg+bvzLsPYshzqByuJES5EoLPAnbQrxOQq1Vn
 7VGvj/B9Lxc+A51SbD8XuMx3mnlKpU8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-LUXYw4OFNQiKZwesyJGosA-1; Wed, 24 Aug 2022 22:27:48 -0400
X-MC-Unique: LUXYw4OFNQiKZwesyJGosA-1
Received: by mail-lj1-f197.google.com with SMTP id
 x10-20020a2ea98a000000b00261b06603cfso3671425ljq.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 19:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=7oCxRBbuY8aIO0Ao6tZmCfYWlpBTx31oDreFNCWBJ84=;
 b=I11MxXl51iJvh8QcMlTCbafzDTau1CD83s+RobM7J76LwEG64oRH8ORe3++OtVnsoI
 Dd9W7IX1+DnQOXTqoHBzUd7DVjJpAyknog3wvnJgFkrWvdDfa2EFV0tQWuZiPmIzbcue
 1kIXbwJ6toTJLQXm4t4++f/xJs6cm7Cn7QLJ8RSGbuXmDaha556UsI8wKCJklCrE2VWs
 aj0/4qoFkItMfgIFZFwoSCF7fVNJO1reMvzTTEBcpyhXNki3X0KJdF3KjWRXv6q2IiGZ
 vFIAHXYNpEcZxsAfPLq51r5C+HMnjrl8jGBc0V+rR/d2E3OWkb6upaSOW+8uF44f2/Yc
 UtwQ==
X-Gm-Message-State: ACgBeo06aZN36rZz/B3f3YBkRsWwQ4KA6npcsjp9QYiOreDrHpmysWBW
 U435p5K6Rw0rlaBcvF0oXVSIUAs4lSIEI9RwvylW2CRierhjPDLtvSa2TdKbz4q7QhhFOwNnj72
 4Bz2w3FkuVxZJZ9f5jCSXC0dbN/dZJKZuAb8zOopLlPcpTw+7vB9YR4LrXg==
X-Received: by 2002:a05:6512:6cb:b0:492:da9e:4689 with SMTP id
 u11-20020a05651206cb00b00492da9e4689mr526839lff.641.1661394467509; 
 Wed, 24 Aug 2022 19:27:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6U8XhoJVnI2RVp+3YSEfWuqyClKHvHxcoqoOUbT6GJGes4+qDLQq+nj/kACvTXoP5ZOlW5sCm/IsnSyJiVacM=
X-Received: by 2002:a05:6512:6cb:b0:492:da9e:4689 with SMTP id
 u11-20020a05651206cb00b00492da9e4689mr526835lff.641.1661394467338; Wed, 24
 Aug 2022 19:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
 <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
 <CAJs=3_Cnf29Om2yB=JkdASuu=YBPRmZ4i7ncFfTzrftTkYZVmQ@mail.gmail.com>
In-Reply-To: <CAJs=3_Cnf29Om2yB=JkdASuu=YBPRmZ4i7ncFfTzrftTkYZVmQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Aug 2022 10:27:36 +0800
Message-ID: <CACGkMEvQwhOhgGW6F22+3vmR4AW90qYXF+ZO6BQZguUF2xt2SA@mail.gmail.com>
Subject: Re: Virtio-net - add timeouts to control commands
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Aug 24, 2022 at 5:16 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> Hi Jason,
>
> > Or reset but can we simply use interrupt instead of the busy waiting?
>
> I agree that timeouts are not needed using interrupts.
> This can be done, but seems like a big change.
> All functions calling virtnet_send_command expect to get a response immediately.
> This may be difficult, since some of the commands are sent in the
> probe function.

We can put the process into interruptible sleep, then it should be fine?

(FYI, some transport specific methods may sleep e.g ccw).

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
