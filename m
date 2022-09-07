Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E157C54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 19:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2085C60F6C;
	Wed,  7 Sep 2022 19:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2085C60F6C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DbUkYSqj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fCwa5MbMA8ko; Wed,  7 Sep 2022 19:37:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82C04605B7;
	Wed,  7 Sep 2022 19:37:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82C04605B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60487C0032;
	Wed,  7 Sep 2022 19:37:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62CF8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CC7160DFF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:37:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CC7160DFF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7p_sErVqJEaS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:37:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 428FB605B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 428FB605B7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662579475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TGroVYrUR+FlP7enzDgAT8Dk+QrrDDFqASiVxT9Otco=;
 b=DbUkYSqjwtLBUKPPEXKPfLJinMAk2d0RsgFLaNBAKounUKiV4ssF4mVMqwIn3sGA69DNm1
 oKmKVBYWgOJYzBvOmHKt3dbRWPz3U+mRAOBUUO/sV8iMFERycze7lbG7MWCrlvhR5bAh8U
 DgSEZrK2ZqT8AO+I/q2OCkVLPFTeJ0s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-kAJxZmUxPCOqbVkZgWwGdg-1; Wed, 07 Sep 2022 15:37:54 -0400
X-MC-Unique: kAJxZmUxPCOqbVkZgWwGdg-1
Received: by mail-qt1-f199.google.com with SMTP id
 e30-20020ac8011e000000b00342f61e67aeso12575326qtg.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 12:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=TGroVYrUR+FlP7enzDgAT8Dk+QrrDDFqASiVxT9Otco=;
 b=AVa6WSQM9KgitGAPcJz49zebyBlmfP1JPa54BSZgY+fdSDVmWxZjBA2xL+q1SpGOdq
 e09bgv4osgwDrgWd2wKvt+F2qeH2I0IP4enFhqUyWlcCoYm2HlySYR4Cs4OUqlnC/R27
 f1SrIXo5bgdPqN0fQ/TC+VrTqczPXfjnwhOmcP3KltQyyZ9IX2JrG6yqGX5b0tncfcLy
 3n4NotBR3FV0danxXKj6MRrYZKDbTymMVYdnr+kzoXd2iOEVViZK031p7ew4cldJG9S4
 Qod2TLnNmf/XtfVmAKruvdFnv4FHGL0h2uwOD74Ah1jvFm6RdZ5siidstCagaLkW4Wj9
 6jbA==
X-Gm-Message-State: ACgBeo26z10Di/Xs5cFa9RUajHGl1ry++712FE5Wf9Q3q94Q9qH69Lsx
 hbwL639AVO2Ah+Kw4xG3M2Z3h9SPTqsNEdp3llVvuARX9YBT3I8rlkhjT+VgeUnZGE4xie8urqX
 BD8OTkYWtZHhUVPs9vfoDBHWMPz4gsvqs+SkJeWosLQ==
X-Received: by 2002:a05:622a:5cb:b0:344:551a:c804 with SMTP id
 d11-20020a05622a05cb00b00344551ac804mr4772414qtb.645.1662579473921; 
 Wed, 07 Sep 2022 12:37:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6o8+b3rCTjFRlYR6CJvTMblMf0qs3ibHzjOkhWuqZnfLiHVuUvUmc7APhywpTSHy+5koL1qQ==
X-Received: by 2002:a05:622a:5cb:b0:344:551a:c804 with SMTP id
 d11-20020a05622a05cb00b00344551ac804mr4772386qtb.645.1662579473681; 
 Wed, 07 Sep 2022 12:37:53 -0700 (PDT)
Received: from redhat.com ([45.144.113.241]) by smtp.gmail.com with ESMTPSA id
 c28-20020ac81e9c000000b0034454067d24sm13524561qtm.64.2022.09.07.12.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 12:37:53 -0700 (PDT)
Date: Wed, 7 Sep 2022 15:37:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Message-ID: <20220907153727-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907152156-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481291080EBEC54C82A5641DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907153425-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220907153425-mutt-send-email-mst@kernel.org>
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

On Wed, Sep 07, 2022 at 03:36:16PM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 07, 2022 at 07:27:16PM +0000, Parav Pandit wrote:
> > 
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, September 7, 2022 3:24 PM
> > > 
> > > On Wed, Sep 07, 2022 at 07:18:06PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Wednesday, September 7, 2022 3:12 PM
> > > >
> > > > > > Because of shallow queue of 16 entries deep.
> > > > >
> > > > > but why is the queue just 16 entries?
> > > > I explained the calculation in [1] about 16 entries.
> > > >
> > > > [1]
> > > >
> > > https://lore.kernel.org/netdev/PH0PR12MB54812EC7F4711C1EA4CAA119DC
> > > 419@
> > > > PH0PR12MB5481.namprd12.prod.outlook.com/
> > > >
> > > > > does the device not support indirect?
> > > > >
> > > > Yes, indirect feature bit is disabled on the device.
> > > 
> > > OK that explains it.
> > 
> > So can we proceed with v6 to contain 
> > (a) updated commit message and
> > (b) function name change you suggested to drop _fields suffix?
> 
> (c) replace mtu = 0 with sensibly not calling the function
> when mtu is unknown.
> 
> 
> And I'd like commit log to include results of perf testing
> - with indirect feature on
> - with mtu feature off
> just to make sure nothing breaks.

and if possible a larger ring. 1k?

> -- 
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
