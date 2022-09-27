Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F5CC6FA82
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 17:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE6BF605B2;
	Tue, 27 Sep 2022 17:45:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE6BF605B2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHxeK+Lt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QN5jgJvFD3DB; Tue, 27 Sep 2022 17:45:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2FC7460803;
	Tue, 27 Sep 2022 17:45:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FC7460803
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7EF9C0032;
	Tue, 27 Sep 2022 17:45:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 230BEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 17:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE4E660803
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 17:45:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE4E660803
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id htSBYkcUupmC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 17:45:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE615605B2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE615605B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664300732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVgPwMiQwWxz9qpcaIbF4/j9KUJT2Ui1z93QE0upqV8=;
 b=gHxeK+Lt4vQ7HOqDUHrLpieCwCpyUL/I7Io0Tkk74FZ5cek9MIKca2Fs+Hdnn8BLM1+Frj
 5zdWRQFJkezQRAzNpyrTMw4iwt1NC+NQrDgQaxp0tXvQ/HEIuXkXAvAdnq6urbPXGwOpkE
 Ky415FlrKyO3hvh2/1/pf5stQaSvhLE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-466-ikOVFDjWMFCrzJZ_fDRRgw-1; Tue, 27 Sep 2022 13:45:31 -0400
X-MC-Unique: ikOVFDjWMFCrzJZ_fDRRgw-1
Received: by mail-wm1-f72.google.com with SMTP id
 n32-20020a05600c3ba000b003b5054c71faso8467231wms.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 10:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=dVgPwMiQwWxz9qpcaIbF4/j9KUJT2Ui1z93QE0upqV8=;
 b=VtU/+lImsUALMawiioOtXMWTNtwDZZxh7lfr5zeIrNsg6uk813ei+GCocNn6bgwocR
 IFzHMkkteFzhZSck9ihTt4xm8mmvLStxNNBRcgY7Ib3lGK56ekb2SriPoznPQBCaQR/J
 1I3q2L+LWOmHLdg0x8iyUW3EPblwkU48Se2aFB9eIL57ih3j6pyEmjsTjFazioxDKFP9
 unv8/zEe5oWhr2NJ+4xm3jeHbxl6xO6Yosb0OLG95aYOI0dHmhehmL1wKXULDxprINsJ
 9JttuYU+q23geOGGmUDsLo/aA7DmOoeI5Zi67RTThEX7iPexfuTOfnKipOUF7iZCyuCo
 W2Kg==
X-Gm-Message-State: ACrzQf2gvKIrTAUJPIEB1oOtuC4byfxW+DRXxfTt5NzR4wnlvvleL6rC
 ormPIjTWyaB4n2Ybdt19AoV4Sey/aukx8kqA71NoVJSg5LI7eHzZjLhFLcL2+OyYGvstAdxEA8A
 6XyzR+JKJMXtZbRvJcbQKmgdaoQyR9HNAq0fSUzkRAA==
X-Received: by 2002:adf:fb88:0:b0:22a:f742:af59 with SMTP id
 a8-20020adffb88000000b0022af742af59mr17905413wrr.230.1664300728150; 
 Tue, 27 Sep 2022 10:45:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5dw5UsDHXguGm9oaXaX47AcmjEId0lTIHxp/R1KfCc218J6dp6bwNiLDUfGstPRwVpRhUHWg==
X-Received: by 2002:adf:fb88:0:b0:22a:f742:af59 with SMTP id
 a8-20020adffb88000000b0022af742af59mr17905376wrr.230.1664300727822; 
 Tue, 27 Sep 2022 10:45:27 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 g14-20020adfe40e000000b0022ae8b862a7sm2328616wrm.35.2022.09.27.10.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 10:45:27 -0700 (PDT)
Date: Tue, 27 Sep 2022 19:45:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220927174521.wo5ygmmti2sgwp2d@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <20220926134219.sreibsw2rfgw7625@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220926134219.sreibsw2rfgw7625@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-hyperv@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Mon, Sep 26, 2022 at 03:42:19PM +0200, Stefano Garzarella wrote:
>Hi,
>
>On Mon, Aug 15, 2022 at 10:56:03AM -0700, Bobby Eshleman wrote:
>>Hey everybody,
>>
>>This series introduces datagrams, packet scheduling, and sk_buff usage
>>to virtio vsock.
>
>Just a reminder for those who are interested, tomorrow Sep 27 @ 16:00 
>UTC we will discuss more about the next steps for this series in this 
>room: https://meet.google.com/fxi-vuzr-jjb
>(I'll try to record it and take notes that we will share)
>

Thank you all for participating in the call!
I'm attaching video/audio recording and notes (feel free to update it).

Notes: 
https://docs.google.com/document/d/14UHH0tEaBKfElLZjNkyKUs_HnOgHhZZBqIS86VEIqR0/edit?usp=sharing
Video recording: 
https://drive.google.com/file/d/1vUvTc_aiE1mB30tLPeJjANnb915-CIKa/view?usp=sharing

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
