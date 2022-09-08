Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106F2C38145
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 14:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E81441600;
	Thu,  8 Sep 2022 14:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E81441600
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QbIlCjgN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TW7FuBSzvYdG; Thu,  8 Sep 2022 14:37:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A663941603;
	Thu,  8 Sep 2022 14:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A663941603
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A84BC0032;
	Thu,  8 Sep 2022 14:37:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C93BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 14:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 188526F931
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 14:37:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 188526F931
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QbIlCjgN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sff_-LF_EI_O
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 14:37:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4C1B60B09
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4C1B60B09
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662647820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wFcDqpqfo5+BlCFcCMK6T6o/K8WN6HmeBg3zPocSOsQ=;
 b=QbIlCjgNx9J2Q77eday2QeT5PwYMI8cKX9Nz+5HimDyXUB5wSYzPcGkleNfZajy1d1AMu+
 AheUGYsTGT0MX79CtWPpaqiLqf4AfKHYTWbXXp/ddUOGTxAKRFcqumPHdAp8mbgjO/8IIi
 nWCTn6RBpob3WAxByef3KwceFSs7Fi0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-364-WxKrbA_aNeKCb_qEVIPibg-1; Thu, 08 Sep 2022 10:36:59 -0400
X-MC-Unique: WxKrbA_aNeKCb_qEVIPibg-1
Received: by mail-wm1-f69.google.com with SMTP id
 c128-20020a1c3586000000b003b324bb08c5so970388wma.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Sep 2022 07:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=wFcDqpqfo5+BlCFcCMK6T6o/K8WN6HmeBg3zPocSOsQ=;
 b=Yr2cgczxfII/DZW2PDBDK28aR/U/P9dUa6+ZQCmBPnT1YatamMSei7zx/XTm5r9ayL
 7UcXiQC6zoqo7Bbmhz1OEcCAXLqjO1Z+HUk8uxqEbGcwQPpOr07tPRv1xidDWaI3DAId
 lTt4h1BRLbFDlmC1NPa8bj/4CBNxkNvfIzLY2kyZYkn2iXZRBW2HT0LJFlxbZrEPRggg
 jfGpvTtxVxf3CVy/QVxNUL55RsVMHJbjbx5XEGrG3kOANmrxFeE/h8fpcCq4H3Al8crC
 sGJcd96PvZ8KGdOwiJRMqz2xYAy8XoyQStCdf3kfrAYC182TDVEQWY7gckoLyxm1Krf6
 tiYQ==
X-Gm-Message-State: ACgBeo1MHqST11J7wOUY4Jy6pxWWpUzWQM+//J/X/Wr44rExxN90Jmv3
 UfIHGcDneS0JACxTy0L4XacXNFy9/n/sN85RFQJo8kYiHwzTbRY4ph4grta9joiGcb3ANjTYiuL
 HhucG1RMMDNIV7va8tnVswdbP3IL335/VwPT4CE5DwQ==
X-Received: by 2002:a5d:6da2:0:b0:228:64ca:3978 with SMTP id
 u2-20020a5d6da2000000b0022864ca3978mr5285533wrs.542.1662647818276; 
 Thu, 08 Sep 2022 07:36:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6BEGVkHcFX/ZuPLpySO7WMaIWzsWXcmGzFBbS0MxMsqv14mvHPWdYH6rv4OjZ1+HxLnAXdhw==
X-Received: by 2002:a5d:6da2:0:b0:228:64ca:3978 with SMTP id
 u2-20020a5d6da2000000b0022864ca3978mr5285510wrs.542.1662647818042; 
 Thu, 08 Sep 2022 07:36:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it.
 [87.11.6.69]) by smtp.gmail.com with ESMTPSA id
 v11-20020a05600c444b00b003a3442f1229sm3131212wmn.29.2022.09.08.07.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Sep 2022 07:36:56 -0700 (PDT)
Date: Thu, 8 Sep 2022 16:36:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Call to discuss vsock netdev/sk_buff [was Re: [PATCH 0/6]
 virtio/vsock: introduce dgrams, sk_buff, and qdisc]
Message-ID: <20220908143652.tfyjjx2z6in6v66c@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <YxdKiUzlfpHs3h3q@fedora> <Yv5PFz1YrSk8jxzY@bullseye>
MIME-Version: 1.0
In-Reply-To: <Yv5PFz1YrSk8jxzY@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Wei Liu <wei.liu@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Bobby Eshleman <bobby.eshleman@gmail.com>,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
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

On Thu, Aug 18, 2022 at 02:39:32PM +0000, Bobby Eshleman wrote:
>On Tue, Sep 06, 2022 at 09:26:33AM -0400, Stefan Hajnoczi wrote:
>> Hi Bobby,
>> If you are attending Linux Foundation conferences in Dublin, Ireland
>> next week (Linux Plumbers Conference, Open Source Summit Europe, KVM
>> Forum, ContainerCon Europe, CloudOpen Europe, etc) then you could meet
>> Stefano Garzarella and others to discuss this patch series.
>>
>> Using netdev and sk_buff is a big change to vsock. Discussing your
>> requirements and the future direction of vsock in person could help.
>>
>> If you won't be in Dublin, don't worry. You can schedule a video call if
>> you feel it would be helpful to discuss these topics.
>>
>> Stefan
>
>Hey Stefan,
>
>That sounds like a great idea! I was unable to make the Dublin trip work
>so I think a video call would be best, of course if okay with everyone.

Looking better at the KVM forum sched, I found 1h slot for Sep 15 at 
16:30 UTC.

Could this work for you?

It would be nice to also have HyperV and VMCI people in the call and 
anyone else who is interested of course.

@Dexuan @Bryan @Vishnu can you attend?

@MST @Jason @Stefan if you can be there that would be great, we could 
connect together from Dublin.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
