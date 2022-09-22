Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE24C6FA86
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 09:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7E32833CD;
	Thu, 22 Sep 2022 09:27:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7E32833CD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eb2SELK6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Lbyl_s3pv2S; Thu, 22 Sep 2022 09:27:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C58928141D;
	Thu, 22 Sep 2022 09:27:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C58928141D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8ED8BC0033;
	Thu, 22 Sep 2022 09:27:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42496C007E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 170B581418
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:27:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 170B581418
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nvEokgZyiPQr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:27:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F849813F5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F849813F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663838821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yj3DJI23V+LSbLbOkpD05qbfoHmBLlLfe1GL1sqUY0E=;
 b=eb2SELK6dTwXF1BUbx9GJ6YskCLGJzDXj9KWmRr8uiXW3S0bQf9rSUEHZ5Id4t6siu4cgj
 GUXcztmvQKGL9xr2ceif6qi4DuZck+Qt4rM+XDE4edLkh+NOAA4CBVDCIGyLeZEDP63EqR
 KMzeZ5VuX8KvRL08qveAcORXbGcXbIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-N-KMPRfBNFKqaE2z_2gdVQ-1; Thu, 22 Sep 2022 05:26:58 -0400
X-MC-Unique: N-KMPRfBNFKqaE2z_2gdVQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 n7-20020a1c2707000000b003a638356355so3820803wmn.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=yj3DJI23V+LSbLbOkpD05qbfoHmBLlLfe1GL1sqUY0E=;
 b=ArvDJFlyS7bzwgLTyeiI/WEjCFt2oGtlDy4RaAnyn9KjGl73vTDPyfEEeUMqsZoCmM
 JsrW2hka9T3c4YAlaNP6G5+dERg4to0nqFYGfBU+gWDtfWTmAiC5zT/hXPdn90tpKduV
 V1gKSLWfKkJOJN3xu2tsAETAZyt4KvrcbFjGfVaGNHxpsq2MNEgqwvKHyfbSswTtpdf4
 b1vl1U463SJ3X0oPS7QdkIWEfiMEPMH5MzPYDfcrGJM2bbTARnFMlEGKkPRY8mnvNsLZ
 5FR83Iqa60J0yMlEw9nhmhFfjlM1+WR201k7z1yPuKeUfxbY6aIhuxM22vo1z8K7Rm4l
 QRew==
X-Gm-Message-State: ACrzQf2BV/vKL713ww0rkK1XQUIOQfHTVWXb0UNG1CLwSEuU2p2es2aZ
 XPyro2x+9pJTxup0EWFgj2PgLnTAQQXknXFFxLHXrdsVytnROIRMNqk82bsIZzjL81oU6IhamyZ
 Tu5HDTqQlMk/lN8sFZUUsq+/BywKSBoLzky9DR7hCww==
X-Received: by 2002:a5d:64ab:0:b0:226:d997:ad5c with SMTP id
 m11-20020a5d64ab000000b00226d997ad5cmr1341544wrp.602.1663838816933; 
 Thu, 22 Sep 2022 02:26:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6w8zI1PSOatdXcP+bXy3/Br5lytITKBUKb/YxbFrzsjnCQAQ3nJh7CECAIbmV5DzXtXp2xAQ==
X-Received: by 2002:a5d:64ab:0:b0:226:d997:ad5c with SMTP id
 m11-20020a5d64ab000000b00226d997ad5cmr1341524wrp.602.1663838816660; 
 Thu, 22 Sep 2022 02:26:56 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 a1-20020a5d5701000000b00228de58ae2bsm4759663wrv.12.2022.09.22.02.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 02:26:55 -0700 (PDT)
Date: Thu, 22 Sep 2022 05:26:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Message-ID: <20220922052233-mutt-send-email-mst@kernel.org>
References: <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907152156-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481291080EBEC54C82A5641DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907153425-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815E541D435DDC9339CA02DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815E541D435DDC9339CA02DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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

On Wed, Sep 07, 2022 at 07:51:38PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 7, 2022 3:36 PM
> > 
> > On Wed, Sep 07, 2022 at 07:27:16PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, September 7, 2022 3:24 PM
> > > >
> > > > On Wed, Sep 07, 2022 at 07:18:06PM +0000, Parav Pandit wrote:
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Wednesday, September 7, 2022 3:12 PM
> > > > >
> > > > > > > Because of shallow queue of 16 entries deep.
> > > > > >
> > > > > > but why is the queue just 16 entries?
> > > > > I explained the calculation in [1] about 16 entries.
> > > > >
> > > > > [1]
> > > > >
> > > >
> > https://lore.kernel.org/netdev/PH0PR12MB54812EC7F4711C1EA4CAA119DC
> > > > 419@
> > > > > PH0PR12MB5481.namprd12.prod.outlook.com/
> > > > >
> > > > > > does the device not support indirect?
> > > > > >
> > > > > Yes, indirect feature bit is disabled on the device.
> > > >
> > > > OK that explains it.
> > >
> > > So can we proceed with v6 to contain
> > > (a) updated commit message and
> > > (b) function name change you suggested to drop _fields suffix?
> > 
> > (c) replace mtu = 0 with sensibly not calling the function when mtu is
> > unknown.
> 
> > 
> > 
> > And I'd like commit log to include results of perf testing
> > - with indirect feature on
> Which device do you suggest using for this test?

AFAIK most devices support INDIRECT, e.g. don't nvidia cards do this?


> > - with mtu feature off
> Why is this needed when it is not touching the area of mtu being not offered?

I don't really like it that instead of checking the MTU feature bit
everywhere the patch sets mtu variable to 0. Because of this
it wasn't all that obvious that the patch did not affect !MTU
performance (the code does change).

Rereading it afresh I think it's ok. But explicit check for !MTU
would be better imho making it obvious we do not need to test !MTU.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
