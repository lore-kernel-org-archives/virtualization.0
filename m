Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CD4C54EE9
	for <virtualization@archiver.kernel.org>; Fri, 16 Sep 2022 03:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B28A611C9;
	Fri, 16 Sep 2022 03:51:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B28A611C9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y37N6X7X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d5_grWBgzAd4; Fri, 16 Sep 2022 03:51:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 035DF611C7;
	Fri, 16 Sep 2022 03:51:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 035DF611C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7CD8C0032;
	Fri, 16 Sep 2022 03:51:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EECEC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 03:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6570584000
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 03:51:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6570584000
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y37N6X7X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rBh5NLe5AUNS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 03:51:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F77D83FFE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F77D83FFE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 03:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663300296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C/CNirb5aNM2+/jDbEf4rfvjRpTSCtEdOZAcwKqI7yU=;
 b=Y37N6X7Xh/f5l99QkEjFJkwk9T1hLSiaUkciHhuVdV44Bc4ZSN/vbfO90NdRpZIOtBQVrj
 AQHCIzB6EjSXfgX0zIH/o/z3wag/BYhJ3SfcxdUpa+WvpPMx4kgWab3NC5/mSpHCFlfRKu
 7KHyQygC9fgNjznG7VOS1Rkb+Bjhf7M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-0nxfRhGXMVC_U-YfzLVVAA-1; Thu, 15 Sep 2022 23:51:34 -0400
X-MC-Unique: 0nxfRhGXMVC_U-YfzLVVAA-1
Received: by mail-lf1-f72.google.com with SMTP id
 y17-20020a056512045100b0049e83e1053fso1532433lfk.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 20:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=C/CNirb5aNM2+/jDbEf4rfvjRpTSCtEdOZAcwKqI7yU=;
 b=Xyc6p/j2js8NtrxzZP4YHvNofyY2EKoixifh9zEHmvhLK9pLPSSgpmgtO8ydMlK2UQ
 QVN/TjejqroEjjSm60sKylpLqa4s0V+IWF+4h/KOH2VwOgRSaWZZ7Ys5X1MlYkZWecAA
 WjKvjwBX57CF/z3PJnegLC6k9SiW2FPCYHLsZ3XfsbfYudcGbzSgGBnhp0qVC3XG7poU
 1qz/4Ns0yq63Ar2cNI/2fUjMDmQY2jDo1lZVyrNV8TfnLZ7ZllBum1vYaF1OoUjSnAG5
 kuDORsk8pX7Mfc6zKmhEbwoYerXY4Jr4r4/avLEuFrEcli7u2SNz6X4rakuI7LS38Q2A
 LFbA==
X-Gm-Message-State: ACrzQf0fajk08Ey1EPGB9+hw9YwGowjRdbD1OqhspqEu8c+D3DUir/Rq
 xDhZRDzdjM62t+jaL96sxrsfQPeBZz0yzY3jNcy7pUXZqlnT+p/QELGV6Wef4h8w8nwv+hN75xT
 levPuNYJdJ6Rk5ZHkpo5JAnplgZeO0oSkk51qg/5Mpe+d8ckAwyIKbmaTnw==
X-Received: by 2002:a05:6512:3d17:b0:497:9e34:94f2 with SMTP id
 d23-20020a0565123d1700b004979e3494f2mr941129lfv.285.1663300293447; 
 Thu, 15 Sep 2022 20:51:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4KIjQQOQEAz2rfnCXfJXK795QetoyHr8NUQ0oWj6eNCqrdNbxhUg53OGOwyxCvA4D1rGGNQcSqWMcwTJW2PsE=
X-Received: by 2002:a05:6512:3d17:b0:497:9e34:94f2 with SMTP id
 d23-20020a0565123d1700b004979e3494f2mr941108lfv.285.1663300293246; Thu, 15
 Sep 2022 20:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <YxdKiUzlfpHs3h3q@fedora> <Yv5PFz1YrSk8jxzY@bullseye>
 <20220908143652.tfyjjx2z6in6v66c@sgarzare-redhat>
 <YxuCVfFcRdWHeeh8@bullseye>
 <CAGxU2F5HG_UouKzJNuvfeCASJ4j84qPY9-7-yFUpEtAJQSoxJg@mail.gmail.com>
 <YxvNNd4dNTIUu6Rb@bullseye>
In-Reply-To: <YxvNNd4dNTIUu6Rb@bullseye>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 16 Sep 2022 05:51:22 +0200
Message-ID: <CAGxU2F5+M2SYKwr56NJ9s2yO5h40MWQFO82t_RkSvx10VRfbVQ@mail.gmail.com>
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

On Mon, Sep 12, 2022 at 8:28 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>
> On Mon, Sep 12, 2022 at 08:12:58PM +0200, Stefano Garzarella wrote:
> > On Fri, Sep 9, 2022 at 8:13 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > >
> > > Hey Stefano, thanks for sending this out.
> > >
> > > On Thu, Sep 08, 2022 at 04:36:52PM +0200, Stefano Garzarella wrote:
> > > >
> > > > Looking better at the KVM forum sched, I found 1h slot for Sep 15 at 16:30
> > > > UTC.
> > > >
> > > > Could this work for you?
> > >
> > > Unfortunately, I can't make this time slot.
> >
> > No problem at all!
> >
> > >
> > > My schedule also opens up a lot the week of the 26th, especially between
> > > 16:00 and 19:00 UTC, as well as after 22:00 UTC.
> >
> > Great, that week works for me too.
> > What about Sep 27 @ 16:00 UTC?
> >
>
> That time works for me!

Great! I sent you an invitation.

For others that want to join the discussion, we will meet Sep 27 @
16:00 UTC at this room: https://meet.google.com/fxi-vuzr-jjb

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
