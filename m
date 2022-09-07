Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B5EC6FA82
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 19:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DE7383E57;
	Wed,  7 Sep 2022 19:36:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DE7383E57
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dq9f1/By
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P0X4tqDLwpb2; Wed,  7 Sep 2022 19:36:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1039483E56;
	Wed,  7 Sep 2022 19:36:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1039483E56
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5FEDC0032;
	Wed,  7 Sep 2022 19:36:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1976C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 861504163E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:36:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 861504163E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dq9f1/By
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id odBh9EWSNgsE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:36:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B5564161D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B5564161D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662579378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SRUzgyu3ke1r6hM2I/CiksoK/WuG/G+5SB3dVoLb2kg=;
 b=dq9f1/ByM2airxGAXNiLJMB19FXL7OUBJATbyH6+KZA6PY8SeMm1+ptNQXU4oGQAmcHEsG
 C/fJJ4ADqH7Sp7MgvLTGMgrmtsAr99nwaEouzL/Uwqny44Q2iTKxjR1uVuiF8pW762BqeJ
 xGXuRpQaU8c2GHGuI6bDM4er6QrqTo0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-9zkIPcg7OwmlPtbo2GXhhA-1; Wed, 07 Sep 2022 15:36:16 -0400
X-MC-Unique: 9zkIPcg7OwmlPtbo2GXhhA-1
Received: by mail-qt1-f198.google.com with SMTP id
 bz20-20020a05622a1e9400b003436a76c6e6so12531017qtb.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 12:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=SRUzgyu3ke1r6hM2I/CiksoK/WuG/G+5SB3dVoLb2kg=;
 b=cOmf08evQ4anWgoH/pv1K7IrLEfvXk8NQSIWDmy3UMRhznlABLMbIKSITX2g+tAL6m
 TQ1/lN6iXK0C55pOSvG8/PYJ0deexiLXLq5iLs8fdIfu9tqGJz0QExhQXRt2v5Qkxgdg
 J1Crvemn1tFU6OJYbOaxkzavr2nvrJEmF7ffG190zsC1Cab5vjbAZR2LWUcBEhc3W+dL
 4apDa4DBZrgtnSHkGIsjAWgfVJth6gQ+I1CYbtZjNR6X+qCYHSKUU5AonOC3ZAJHceYj
 9JIMIIYTaONvZgQnvdNdEtpqwL38OZYapxpL4VC+nb8CDoqIo6+ZCihgheN43NWd+x+7
 eEgw==
X-Gm-Message-State: ACgBeo388fc5/jqTRh4hHUrFkzdvJ98yqpgGxZJs14EcdCJdVcpKfC+u
 rA75D7aDtJYWYEdYV87hX6+1G6IJv9MSt1tFeGCKjKzKpc1pGgrFJMrcRb78bA6eJSkSPEldTED
 w4xCDh5tIy6fTBrLPY1ODAwsSPM4uHyArxliTG1XtLQ==
X-Received: by 2002:a05:622a:134f:b0:344:df2b:9afe with SMTP id
 w15-20020a05622a134f00b00344df2b9afemr4952680qtk.279.1662579376519; 
 Wed, 07 Sep 2022 12:36:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6nukJaa/Xp+rVNNei888VY7Jy1p9nTUTUXc0lDaKJKAHlJSyYYknx7ao2/KUNUwmeztil1Lw==
X-Received: by 2002:a05:622a:134f:b0:344:df2b:9afe with SMTP id
 w15-20020a05622a134f00b00344df2b9afemr4952660qtk.279.1662579376283; 
 Wed, 07 Sep 2022 12:36:16 -0700 (PDT)
Received: from redhat.com ([45.144.113.241]) by smtp.gmail.com with ESMTPSA id
 a5-20020ae9e805000000b006b93ef659c3sm14104168qkg.39.2022.09.07.12.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 12:36:15 -0700 (PDT)
Date: Wed, 7 Sep 2022 15:36:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Message-ID: <20220907153425-mutt-send-email-mst@kernel.org>
References: <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907152156-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481291080EBEC54C82A5641DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481291080EBEC54C82A5641DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Wed, Sep 07, 2022 at 07:27:16PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 7, 2022 3:24 PM
> > 
> > On Wed, Sep 07, 2022 at 07:18:06PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, September 7, 2022 3:12 PM
> > >
> > > > > Because of shallow queue of 16 entries deep.
> > > >
> > > > but why is the queue just 16 entries?
> > > I explained the calculation in [1] about 16 entries.
> > >
> > > [1]
> > >
> > https://lore.kernel.org/netdev/PH0PR12MB54812EC7F4711C1EA4CAA119DC
> > 419@
> > > PH0PR12MB5481.namprd12.prod.outlook.com/
> > >
> > > > does the device not support indirect?
> > > >
> > > Yes, indirect feature bit is disabled on the device.
> > 
> > OK that explains it.
> 
> So can we proceed with v6 to contain 
> (a) updated commit message and
> (b) function name change you suggested to drop _fields suffix?

(c) replace mtu = 0 with sensibly not calling the function
when mtu is unknown.


And I'd like commit log to include results of perf testing
- with indirect feature on
- with mtu feature off
just to make sure nothing breaks.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
