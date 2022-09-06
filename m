Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1E1ECAAA1
	for <virtualization@archiver.kernel.org>; Tue,  6 Sep 2022 10:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C054960A7B;
	Tue,  6 Sep 2022 10:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C054960A7B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKrFZA+s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xnhyspnDZxve; Tue,  6 Sep 2022 10:58:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30E4B60A6A;
	Tue,  6 Sep 2022 10:58:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30E4B60A6A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF34FC0032;
	Tue,  6 Sep 2022 10:58:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95AD9C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 10:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D8944030A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 10:58:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D8944030A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKrFZA+s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6fR-hbW5BlFt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 10:58:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D3BE40306
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D3BE40306
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662461923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+0i0KE3XTFGMOugy8WjJQSlLzmOSM4MIpTEpD6UmFME=;
 b=aKrFZA+s6fjpY+GfsCv4x1z/7lGK+0I/VtSQhBw5k9OElK5xZHpNjQ7O4EXN3ioEleoMAa
 0PC8wHvikZ1nGixkAyN0EguYG07Uw/APAIjLhnJAGWnSPGxpKr6jnHTrC0FDyWOBl8Og+r
 g43KbRQcBitYONuIAa8c748HtQxXS1Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-bAp9x8yfPa6uG2qOy7_-wQ-1; Tue, 06 Sep 2022 06:58:40 -0400
X-MC-Unique: bAp9x8yfPa6uG2qOy7_-wQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 s17-20020a056402521100b0044ee4ec88c0so492018edd.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 03:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=+0i0KE3XTFGMOugy8WjJQSlLzmOSM4MIpTEpD6UmFME=;
 b=QVF7CCTP/AF4ovqq3RvE3X4l1MybaGr19HMgk0L7gGovJdPPSIAoA7fRZN4dYOOXy+
 hIhd48bJKYaOTn+YF5xH9/mcVEu0bFfmJwk+EB1TfsSr3vFSECH1sFXzRWfFateG2nqD
 wIjzKyy+8Uz4IaHaqbhyk2I/2M5tjZae7Hkk1JzlYNJNRVLA3Gmt2vhQhRBvCogs4JaF
 T+cLvmPIElzodSQ+PC/86avq9L7Yf9sblnPYCHuntiV/Kgw4EPl1BV4PK0w+ZkI6py/e
 4GfF+Xnt1AVrpPsjGGkqWIdONEtqxM++huGzmCWg5V6WJurbJRb6xjaProJ9WUitFjsL
 e/sg==
X-Gm-Message-State: ACgBeo0gp2irgVk59OeEdb5vVDGBFiGVax/43fL7lXOJgiiboNZP0on3
 CSyawhueOEcu2cw6ZmcOeLrrdseZRW7KzRX6UfzMg6ZDgEriSenf4RA5V4yvsnPkmfeTvz/nDtn
 LaRVBlrFYfXbN4b2QL3LRPOQ9AzPYGfpsbOTX5pO6UQ==
X-Received: by 2002:aa7:cb13:0:b0:448:3759:8c57 with SMTP id
 s19-20020aa7cb13000000b0044837598c57mr37696959edt.8.1662461918964; 
 Tue, 06 Sep 2022 03:58:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7CeyMVILqKWtWY67rp5QKv0h1PSPP4WQMwbXvISz7gKxlfNS4o/vele1usXUc0TW/l8/02Dg==
X-Received: by 2002:aa7:cb13:0:b0:448:3759:8c57 with SMTP id
 s19-20020aa7cb13000000b0044837598c57mr37696947edt.8.1662461918761; 
 Tue, 06 Sep 2022 03:58:38 -0700 (PDT)
Received: from redhat.com ([2.52.135.118]) by smtp.gmail.com with ESMTPSA id
 kv12-20020a17090778cc00b0073d7b876621sm6398731ejc.205.2022.09.06.03.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Sep 2022 03:58:38 -0700 (PDT)
Date: Tue, 6 Sep 2022 06:58:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 3/6] vsock: add netdev to vhost/virtio vsock
Message-ID: <20220906065523-mutt-send-email-mst@kernel.org>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <5a93c5aad99d79f028d349cb7e3c128c65d5d7e2.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <5a93c5aad99d79f028d349cb7e3c128c65d5d7e2.1660362668.git.bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 15, 2022 at 10:56:06AM -0700, Bobby Eshleman wrote:
> In order to support usage of qdisc on vsock traffic, this commit
> introduces a struct net_device to vhost and virtio vsock.
> 
> Two new devices are created, vhost-vsock for vhost and virtio-vsock
> for virtio. The devices are attached to the respective transports.
> 
> To bypass the usage of the device, the user may "down" the associated
> network interface using common tools. For example, "ip link set dev
> virtio-vsock down" lets vsock bypass the net_device and qdisc entirely,
> simply using the FIFO logic of the prior implementation.
> 
> For both hosts and guests, there is one device for all G2H vsock sockets
> and one device for all H2G vsock sockets. This makes sense for guests
> because the driver only supports a single vsock channel (one pair of
> TX/RX virtqueues), so one device and qdisc fits. For hosts, this may not
> seem ideal for some workloads. However, it is possible to use a
> multi-queue qdisc, where a given queue is responsible for a range of
> sockets. This seems to be a better solution than having one device per
> socket, which may yield a very large number of devices and qdiscs, all
> of which are dynamically being created and destroyed. Because of this
> dynamism, it would also require a complex policy management daemon, as
> devices would constantly be spun up and down as sockets were created and
> destroyed. To avoid this, one device and qdisc also applies to all H2G
> sockets.
> 
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>


I've been thinking about this generally. vsock currently
assumes reliability, but with qdisc can't we get
packet drops e.g. depending on the queueing?

What prevents user from configuring such a discipline?
One thing people like about vsock is that it's very hard
to break H2G communication even with misconfigured
networking.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
