Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D75C0502E
	for <virtualization@archiver.kernel.org>; Mon, 29 Aug 2022 13:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3FB641682;
	Mon, 29 Aug 2022 13:52:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3FB641682
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b7TvfXIw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ALJhcd8pQlOi; Mon, 29 Aug 2022 13:52:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05C0341674;
	Mon, 29 Aug 2022 13:52:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05C0341674
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9EF1C0033;
	Mon, 29 Aug 2022 13:52:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C785FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 13:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CDFD41674
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 13:52:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CDFD41674
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HPWoV5X0j6vS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 13:52:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DA904163E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DA904163E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661781162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iyHeN9+d/43uz8k3pFTHk3cYxNwEdqT76Jr80vsE+YA=;
 b=b7TvfXIwzZn/si/V6Ypre2FkAA/uENEvKly5yuku4IDjnTwGnR3Tpk3yvN2Mca/Mo2oSZT
 Ta24c8+H8rTusefFlNh5X0Br8eMgv0+iM8OknjOG3x9mqu4JPAuXpGESMSGSkL7FkDR1vb
 TExAWYZJvrdDzrMZUUDJzoHUsQgb/3U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-292-PQA3KOi6OUGdNbaVdEgF5Q-1; Mon, 29 Aug 2022 09:52:40 -0400
X-MC-Unique: PQA3KOi6OUGdNbaVdEgF5Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 b16-20020a05600c4e1000b003a5a47762c3so5083767wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 06:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=iyHeN9+d/43uz8k3pFTHk3cYxNwEdqT76Jr80vsE+YA=;
 b=gIQ0o+djZkFXV44Q1JJzFQIxhiHafmqhpgnwJ2r34MBaL7EPBGiSHG3jojvMw6VpBC
 I+BOX91gPQ3qauczQphrVApp/0qAi1/uAPj6f4r24vuNogHUkCSct+3o4wwXmw6Y47OL
 f2WPtWXNAFqZih3zjkzox6d/8PUrYqa02mLsUNxpB3ALJ09MdyCsyNy03ckUg92jK3Ei
 66WtwOexXp/g8xVYXwz/ArO/4U67L5fEQJtxNKdIzqmu043NVJ8QPqE+0K/UjUC/ZuNy
 jtIDj7RVw6HQz6pae9VN9X41kj0PAQQQ4yWKFefKpbfGc18mwrRwnryGIW2lubrgyUjT
 A5zg==
X-Gm-Message-State: ACgBeo3D1o/hedqhrA8ZfAYLQzfXQ9bwJIhmelwDv+tjcISlz2Grd9oJ
 Q4IAPihA7uKLak+ZJglBe/HENylYImL1Bn9ncEwV5zrmeZmWsTA7PSZNyN/zEt4OJJmTuvPXdFI
 ijtBP5+M10au/+Jd4nV5hP8uH9F8iGwdkOrid+9rx7Q==
X-Received: by 2002:a05:600c:4fcd:b0:3a6:2694:e3ba with SMTP id
 o13-20020a05600c4fcd00b003a62694e3bamr7190900wmq.160.1661781158966; 
 Mon, 29 Aug 2022 06:52:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xbddiyuXZsWvO+FPWILzn4jZoImEslyYwS/WpzMw1kUYVPH1Nn8dBrnVo9BLMC4eze3xuOw==
X-Received: by 2002:a05:600c:4fcd:b0:3a6:2694:e3ba with SMTP id
 o13-20020a05600c4fcd00b003a62694e3bamr7190887wmq.160.1661781158752; 
 Mon, 29 Aug 2022 06:52:38 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.88.130])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a056000019200b00226d13a25c7sm6869906wrx.17.2022.08.29.06.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:52:37 -0700 (PDT)
Date: Mon, 29 Aug 2022 15:52:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 0/9] vsock: updates for SO_RCVLOWAT handling
Message-ID: <20220829135229.rcyefaabajt3btqt@sgarzare-redhat>
References: <de41de4c-0345-34d7-7c36-4345258b7ba8@sberdevices.ru>
 <YwUnAhWauSFSJX+g@fedora> <20220823121852.1fde7917@kernel.org>
 <YwU443jzc/N4fV3A@fedora>
 <5174d4ef7fe3928472d5a575c87ee627bfb4c129.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5174d4ef7fe3928472d5a575c87ee627bfb4c129.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
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

On Tue, Aug 23, 2022 at 10:57:01PM +0200, Paolo Abeni wrote:
>On Tue, 2022-08-23 at 16:30 -0400, Stefan Hajnoczi wrote:
>> On Tue, Aug 23, 2022 at 12:18:52PM -0700, Jakub Kicinski wrote:
>> > On Tue, 23 Aug 2022 15:14:10 -0400 Stefan Hajnoczi wrote:
>> > > Stefano will be online again on Monday. I suggest we wait for him to
>> > > review this series. If it's urgent, please let me know and I'll take a
>> > > look.
>> >
>> > It was already applied, sorry about that. But please continue with
>> > review as if it wasn't. We'll just revert based on Stefano's feedback
>> > as needed.

Just back, and I'm fine with this version, so thanks for merging!
I also run tests with virtio-vsock and everything is fine.

>>
>> Okay, no problem.
>
>For the records, I applied the series since it looked to me Arseniy
>addressed all the feedback from Stefano on the first patch (the only
>one still lacking an acked-by/reviewed-by tag) and I thought it would
>be better avoiding such delay.

Yep, from v3 I asked some changes on the first patch that Arseniy 
addressed in this version, and we were waiting an ack for VMCI changes 
(thanks Vishnu for giving it).

So, it should be fine.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
