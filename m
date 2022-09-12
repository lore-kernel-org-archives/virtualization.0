Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075BAC6FA82
	for <virtualization@archiver.kernel.org>; Mon, 12 Sep 2022 18:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FCC2410A4;
	Mon, 12 Sep 2022 18:14:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FCC2410A4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LxCUxafr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OvYY6YGhdQ1r; Mon, 12 Sep 2022 18:14:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BB6740A01;
	Mon, 12 Sep 2022 18:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BB6740A01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61D66C0032;
	Mon, 12 Sep 2022 18:13:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF589C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Sep 2022 18:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88AAB4012D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Sep 2022 18:13:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88AAB4012D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LxCUxafr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ooUU6ALnH22g
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Sep 2022 18:13:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 190DF4016A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 190DF4016A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Sep 2022 18:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663006394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIivuanKSjygaobAWTqz6Vlrz5BF6yE307kFzPCTliY=;
 b=LxCUxafr+fdcBffQA1WP2dgTI8xDz9gq4GmpmphlAF3KHdqC9DJTJ5ymgEna9bmTrXan3R
 0wOW4QNHvn+5Nc2ixgN6cmQJc5qQT5G7H3hpY3foZ+WwvQuBITCS5dA4CcScWftkBHmjO6
 TkooGEFrUQGw9iDyBzcPFb7NfBHPhWM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-qBVo8STcMhqhfqMR8dPshA-1; Mon, 12 Sep 2022 14:13:11 -0400
X-MC-Unique: qBVo8STcMhqhfqMR8dPshA-1
Received: by mail-lf1-f72.google.com with SMTP id
 z1-20020a0565120c0100b0048ab2910b13so3150408lfu.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Sep 2022 11:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=MIivuanKSjygaobAWTqz6Vlrz5BF6yE307kFzPCTliY=;
 b=QzmkZVoj3+EYRL34DSnSjERNVf4220uno1qO2PtzEOsM7hnKLdYlMZxjI8NoGGsfwz
 ko7g7p1mJ7iSDd8toEYyqT0TExjC24YBTrjKXhezDhFwYGeHXLDZzsHphRhQC91L/5mZ
 AWsijl5gyFyhtxtLhW9v7mwMwbYx593S7T+Pm+EDEreXlhUbi1Z2lc1mJAugOdnxG6IM
 S3B7MkB3zjjL0lQPu7xYIRq+49IswXGptCPCEia0sROjtA0OpLXkOgAIgw/J/TzOY/4D
 oQnOUxDlBYfTXkOpBLeY2p74I4QvlRxXIuh9lN6TF9WEhuFZvPRT5dUJnNLo+lkszJio
 SG6Q==
X-Gm-Message-State: ACgBeo3HlnPgSEuVt2JmYEWfykZy3a9CVVDcJJMxKu3m7X2OWHrtoIO8
 S+4aoYMWs+6G0rhwNIN72wHvvlG3ui6U6PbRxQ0uyZASRCh2Swx1ohdq+2G0KdA6Ry77XMPPeCW
 8xZmCTevNxWt2cKnj0wMQV6ZmaKpLY2nRomRHsevabthn/mv2F13FGsHbjQ==
X-Received: by 2002:a05:6512:3b1e:b0:49b:49d9:cb9e with SMTP id
 f30-20020a0565123b1e00b0049b49d9cb9emr877203lfv.201.1663006390223; 
 Mon, 12 Sep 2022 11:13:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ppAN5/qdHGxQeudg4Zh5HihxK1wLBPBp6mq9A3a1ed9G1ccE8gIbz65FRZyZtWK+AopezeLNQh/bU8TMuMvk=
X-Received: by 2002:a05:6512:3b1e:b0:49b:49d9:cb9e with SMTP id
 f30-20020a0565123b1e00b0049b49d9cb9emr877188lfv.201.1663006389976; Mon, 12
 Sep 2022 11:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <YxdKiUzlfpHs3h3q@fedora> <Yv5PFz1YrSk8jxzY@bullseye>
 <20220908143652.tfyjjx2z6in6v66c@sgarzare-redhat>
 <YxuCVfFcRdWHeeh8@bullseye>
In-Reply-To: <YxuCVfFcRdWHeeh8@bullseye>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 12 Sep 2022 20:12:58 +0200
Message-ID: <CAGxU2F5HG_UouKzJNuvfeCASJ4j84qPY9-7-yFUpEtAJQSoxJg@mail.gmail.com>
Subject: Re: Call to discuss vsock netdev/sk_buff [was Re: [PATCH 0/6]
 virtio/vsock: introduce dgrams, sk_buff, and qdisc]
To: Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-hyperv@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Vishnu Dasa <vdasa@vmware.com>, Jiang Wang <jiang.wang@bytedance.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, Sep 9, 2022 at 8:13 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>
> Hey Stefano, thanks for sending this out.
>
> On Thu, Sep 08, 2022 at 04:36:52PM +0200, Stefano Garzarella wrote:
> >
> > Looking better at the KVM forum sched, I found 1h slot for Sep 15 at 16:30
> > UTC.
> >
> > Could this work for you?
>
> Unfortunately, I can't make this time slot.

No problem at all!

>
> My schedule also opens up a lot the week of the 26th, especially between
> 16:00 and 19:00 UTC, as well as after 22:00 UTC.

Great, that week works for me too.
What about Sep 27 @ 16:00 UTC?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
