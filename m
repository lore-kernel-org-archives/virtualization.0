Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6244C54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 19:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5079F60F3C;
	Wed,  7 Sep 2022 19:24:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5079F60F3C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=guPsxyzw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NzDJ1x8pz1gt; Wed,  7 Sep 2022 19:24:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC93160F8B;
	Wed,  7 Sep 2022 19:24:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC93160F8B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC7B0C0032;
	Wed,  7 Sep 2022 19:24:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63BEAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E00C409BA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:24:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E00C409BA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=guPsxyzw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxnPI4X5R7MW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:24:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D76AC4109E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D76AC4109E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662578646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYnZZ/3twYWT2HM0ZS6NnUha3knYPuZH8nbGiQU3O6Y=;
 b=guPsxyzw6jIPh4KAXd0C/mo2bweEEVs/OYVzXIA1gEqolpqem5E6lut2aJQDZfljmIG8oz
 2LK0iU9VMXad1cn2YO3ZdIUXAgkuUB1ghACvmO0h+lIUluGUlMKyWeubSWHYIyI2cljhkn
 DpbwJ90ezdkWb5F6m6qeF2T71GXr6wk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-110-IM4Enp4dNRirTL3B9LsSmg-1; Wed, 07 Sep 2022 15:24:05 -0400
X-MC-Unique: IM4Enp4dNRirTL3B9LsSmg-1
Received: by mail-qt1-f198.google.com with SMTP id
 v13-20020a05622a188d00b00343794bd1daso12771273qtc.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 12:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=sYnZZ/3twYWT2HM0ZS6NnUha3knYPuZH8nbGiQU3O6Y=;
 b=wN8bqiT1PBgi8u9P5PQWWUk1KH6idkGRPaooRXR8cpeb94DYvkqME3Y3grRnxWlSGI
 uDY87m4CmhUib8lv1RDHoJr4OW0QF8RjZi8wFmJiDssgA4zyGNIFWkonEtfFWwJRBVqD
 RQFh12gIQaHiUAB35Mj1TqwcjHxr+zAFBR3CfcniEb5MG2i1ywC8u7L1U/Uk5jJuBucF
 6RbARezRnNAlaWAqyy4tqgNsF5fq9EuJTnHlm84D8zreP/bIeatGomu2CukbLBBT9Ico
 tJJ+u9iwgH+NP8tt1D0AcrDlWILcqcV/t7C9QjLEwy7XH9nm+i9Ink1e+bCZ3rGAo7qb
 lxfA==
X-Gm-Message-State: ACgBeo3P5hylkKck7jwBuxY7060tu3UneBFAqnUuPIlGUsvURYiEroVE
 RBe2HfGOL/Qj/A3OVbdLm9h95sBGFaDy5SDA9+EOtCBSSnCdl5ia6XiDWCHxmxjr4CWKqYs6Uvj
 k3OdaJGN4SQ0j1dSSj0LHiezX/mRpNcU2D+HrZ5Rapg==
X-Received: by 2002:a05:6214:622:b0:4aa:9e48:d469 with SMTP id
 a2-20020a056214062200b004aa9e48d469mr4547446qvx.65.1662578645218; 
 Wed, 07 Sep 2022 12:24:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ZlbAA5CZ2VKWrhrxKuPB9BV37ohMQbYVc9OBJtHvmQ8Oa7r7SJS/mbUp0rzu5HI59srwtKA==
X-Received: by 2002:a05:6214:622:b0:4aa:9e48:d469 with SMTP id
 a2-20020a056214062200b004aa9e48d469mr4547428qvx.65.1662578644986; 
 Wed, 07 Sep 2022 12:24:04 -0700 (PDT)
Received: from redhat.com ([45.144.113.241]) by smtp.gmail.com with ESMTPSA id
 fy9-20020a05622a5a0900b0034359fc348fsm13431448qtb.73.2022.09.07.12.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 12:24:04 -0700 (PDT)
Date: Wed, 7 Sep 2022 15:23:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Message-ID: <20220907152156-mutt-send-email-mst@kernel.org>
References: <20220907052317-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Wed, Sep 07, 2022 at 07:18:06PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 7, 2022 3:12 PM
> 
> > > Because of shallow queue of 16 entries deep.
> > 
> > but why is the queue just 16 entries?
> I explained the calculation in [1] about 16 entries.
> 
> [1] https://lore.kernel.org/netdev/PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com/
> 
> > does the device not support indirect?
> >
> Yes, indirect feature bit is disabled on the device.

OK that explains it.

> > because with indirect you get 256 entries, with 16 s/g each.
> > 
> Sure. I explained below that indirect comes with 7x memory cost that is not desired.
> (Ignored the table memory allocation cost and extra latency).

Oh sure, it's a waste. I wonder what effect does the patch have
on bandwidth with indirect enabled though.


> Hence don't want to enable indirect in this scenario.
> This optimization also works with indirect with smaller indirect table.
> 
> > 
> > > With driver turn around time to repost buffers, device is idle without any
> > RQ buffers.
> > > With this improvement, device has 85 buffers instead of 16 to receive
> > packets.
> > >
> > > Enabling indirect in device can help at cost of 7x higher memory per VQ in
> > the guest VM.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
