Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC8EC00528
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 09:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15B956131A;
	Thu, 27 Jul 2023 09:46:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15B956131A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YRPRoDTC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XmmogTrfYzBE; Thu, 27 Jul 2023 09:46:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B2436131D;
	Thu, 27 Jul 2023 09:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B2436131D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61695C0071;
	Thu, 27 Jul 2023 09:46:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C32B8C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 09:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96E406131D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 09:46:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96E406131D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uGhA40l2maQf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 09:46:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE0936131A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 09:46:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE0936131A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690451212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9OkPmAayPDeHyXcIMrmOokqY8foYhEAqmOlnJq34vJA=;
 b=YRPRoDTCtwCBtgscYwKZLIKnueEXAMdhIisvEZFEnfAJpClJ6+BAafAloGnsE1Ds5CfxXG
 3Xxv3tpD1ugl4byMtEw2LRe3hlcEczbnR6Freyflah3Fvlq56FoPzT04EB0h7WUhFxUnZf
 TYrs7qZ8Twe7VJGjQbYUf0VS52w5iYg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-ReGBins2Oe667tKoVSTdCg-1; Thu, 27 Jul 2023 05:46:51 -0400
X-MC-Unique: ReGBins2Oe667tKoVSTdCg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-52231d5eecdso459006a12.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 02:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690451210; x=1691056010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OkPmAayPDeHyXcIMrmOokqY8foYhEAqmOlnJq34vJA=;
 b=kyFWLUYfCDZcTBuW76cv8NCTZ5OuEoTZ1jL/yKpA5NdbL7PAtD/COP7FCgaBtDMiNF
 j7kxsaLGY0vsuLYb4RMvQ6SU19+mRfZ4z/xNwncK8NoWJIiVywlABTBXegpDmXQ4fPw8
 PWgQoHo7OK6dHHf75BDVEsuMryCi/67jzbqC80wFdTUKf/lTfWonrRtgvoJgpDl+B/T1
 5WaXU0o5gBdsZcmJxoG8gwGbs+rKyz9k1W+gmYH0xxS4rT14CQgakm9q5vGhlQ8gumpR
 LH5Tu2lrj0qsyPsMy/km8QUzrbhYUiooIj77ZQt8L7ktxe8//jwxzu6CwT+knoXEPdM7
 HICg==
X-Gm-Message-State: ABy/qLZDiBYpgrjLEplmoRM9gBStET9JHt+2yN52KFNSP9g+FzxgudSt
 Lu6/1PmDaDHb5Y4ihgKc4PomKQ33twwRvkx8+lZ6k/F51Zkv2oNf+V0IsR5GJGez8sCBpiu6P21
 1HxPd5eiXZ205ppdTBDru43Lcu99uq+JdxJq5wg6XJA==
X-Received: by 2002:a05:6402:1489:b0:522:3b94:c6f8 with SMTP id
 e9-20020a056402148900b005223b94c6f8mr1250123edv.37.1690451210315; 
 Thu, 27 Jul 2023 02:46:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpfTNLuZLnTtrO8TWZKOIkB4YOY++DfnrAeL6F4rjv9p1h9W8it7NG7YKv6G2vviq2+n3zxQ==
X-Received: by 2002:a05:6402:1489:b0:522:3b94:c6f8 with SMTP id
 e9-20020a056402148900b005223b94c6f8mr1250106edv.37.1690451210017; 
 Thu, 27 Jul 2023 02:46:50 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 n10-20020aa7db4a000000b00522584bb58esm436315edt.24.2023.07.27.02.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 02:46:49 -0700 (PDT)
Date: Thu, 27 Jul 2023 05:46:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230727054300-mutt-send-email-mst@kernel.org>
References: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > They really shouldn't - any NIC that takes forever to
> > program will create issues in the networking stack.
> 
> Unfortunately, it's not rare as the device/cvq could be implemented
> via firmware or software.

Currently that mean one either has sane firmware with a scheduler that
can meet deadlines, or loses ability to report errors back.

> > But if they do they can always set this flag too.
> 
> This may have false negatives and may confuse the management.
> 
> Maybe we can extend the networking core to allow some device specific
> configurations to be done with device specific lock without rtnl. For
> example, split the set_channels to
> 
> pre_set_channels
> set_channels
> post_set_channels
> 
> The device specific part could be done in pre and post without a rtnl lock?
> 
> Thanks


Would the benefit be that errors can be reported to userspace then?
Then maybe.  I think you will have to show how this works for at least
one card besides virtio.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
