Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B73EC25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 17:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9E7883E2A;
	Wed, 17 Aug 2022 17:03:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9E7883E2A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z0qRAqDJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8tSaPkSVzqx; Wed, 17 Aug 2022 17:03:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A95283E9A;
	Wed, 17 Aug 2022 17:03:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A95283E9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF6AEC0032;
	Wed, 17 Aug 2022 17:03:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D884C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E74C0402FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:03:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E74C0402FB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z0qRAqDJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qszLomBagBSt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:03:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A9B7402EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A9B7402EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660755786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iKDI4wZP72dFon1h0J2l9ajfalLVCP4U7tsE8KQrHV8=;
 b=Z0qRAqDJUk71ih7SpS7ZSVcBLNBQWNXhr88yd+/xovyQjT1XBgZzikVHntbD+6tohJijlk
 Yq57ggwMYp7CrGvcflDSApmHnMupFsQ32IewP1FmpP7iXTW/zljgtw8vaDhYEJ8vARkzUu
 vpbw/33KgZo5ln2qiuLbValZlrVoi0g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-zP9U29AyMRejJYQ7Lq02ow-1; Wed, 17 Aug 2022 13:03:00 -0400
X-MC-Unique: zP9U29AyMRejJYQ7Lq02ow-1
Received: by mail-wm1-f70.google.com with SMTP id
 c17-20020a7bc011000000b003a2bfaf8d3dso6550698wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=iKDI4wZP72dFon1h0J2l9ajfalLVCP4U7tsE8KQrHV8=;
 b=CQI1LIHEZgJoBDg/6rizEdOCk07N4L8pId74PKMoG3dV6LipSKlNm3GMCuPvtOKBqD
 qO6yQ+D2A/+jhuEbJ08nilauGJ2jPu9nVA8BThg2yWbkczbAYF2hkxQ2a7a6YGWXeB8X
 kcty+KkCHOR/Pf4CZWuexh7C8uCcArXqqE7De+UlpsCYWR7HHKtsemZl6nWZ5stQIQGw
 GSFlXyKP8hCbRKF5x2PzlVFRy2RIbKXYkEvXEcITQhJw4rorStOtG8JtC9HrzmyuEUbK
 eokQi2kpizdcfce86mlTEvhINC0D/kyvmcxJqhvvAmFVNFbkf+SI4J2yzd7+Zv/b/MZK
 nq9A==
X-Gm-Message-State: ACgBeo0bc4EuqyzrT2DkZUnJMldbGSM5WuR4iJ8FDXUIeqHM6+Tpe4Pr
 NiSZD4wWLsWC0eQO1Yw81UEFfqIuRm1ooGy91SBzo+aXFDn2kwETQEUbg2vlTxlKajmrOPyxkIW
 mJPy6o15Pi1A1Hbwx+QpnocSeezLxTIS6t+EIcUPmOA==
X-Received: by 2002:a5d:440b:0:b0:225:2106:2f30 with SMTP id
 z11-20020a5d440b000000b0022521062f30mr3175258wrq.533.1660755779410; 
 Wed, 17 Aug 2022 10:02:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5AuDbo8GcZEnqQiqOeyM94DlUbLxyqrhdFN62DfedDuMFRt+WAj8nSt4Xs7jQmlw2zs7JUow==
X-Received: by 2002:a5d:440b:0:b0:225:2106:2f30 with SMTP id
 z11-20020a5d440b000000b0022521062f30mr3175243wrq.533.1660755779078; 
 Wed, 17 Aug 2022 10:02:59 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 h82-20020a1c2155000000b003a319bd3278sm2825504wmh.40.2022.08.17.10.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Aug 2022 10:02:58 -0700 (PDT)
Date: Wed, 17 Aug 2022 13:02:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220817130044-mutt-send-email-mst@kernel.org>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <20220817025250-mutt-send-email-mst@kernel.org>
 <YvtmYpMieMFb80qR@bullseye>
MIME-Version: 1.0
In-Reply-To: <YvtmYpMieMFb80qR@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Wei Liu <wei.liu@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, Dexuan Cui <decui@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Aug 16, 2022 at 09:42:51AM +0000, Bobby Eshleman wrote:
> > The basic question to answer then is this: with a net device qdisc
> > etc in the picture, how is this different from virtio net then?
> > Why do you still want to use vsock?
> > 
> 
> When using virtio-net, users looking for inter-VM communication are
> required to setup bridges, TAPs, allocate IP addresses or setup DNS,
> etc... and then finally when you have a network, you can open a socket
> on an IP address and port. This is the configuration that vsock avoids.
> For vsock, we just need a CID and a port, but no network configuration.

Surely when you mention DNS you are going overboard? vsock doesn't
remove the need for DNS as much as it does not support it.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
