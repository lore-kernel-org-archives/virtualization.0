Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58E4C25B06
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 09:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4580A823EB;
	Wed, 10 Aug 2022 09:03:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4580A823EB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ey7gfMSm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HtOsfxEb_Hlh; Wed, 10 Aug 2022 09:03:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A75C681D7D;
	Wed, 10 Aug 2022 09:03:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A75C681D7D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62338C0032;
	Wed, 10 Aug 2022 09:03:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE4D4C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA6F1823CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:03:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA6F1823CF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WAOHadb_cMQs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:03:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8ECA181D7D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8ECA181D7D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660122194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+HMHyPBaTX9PHpl8A8My7WJ1eVNq2ytE1WUSXocNgs=;
 b=Ey7gfMSmdlagqQ+hOMgQjfZj6Z0+6UxXoC1Onvp1bgL08rXtE5lFOlge1mNvpGTVLw1ECc
 RsR6JxN+BcI++3FTeQsMN2KHDZ3gyBKgnJOE7I4RyW+EQqxdmf2hMwoknBPFEkzQ4OHjn8
 uPDUHjZrZRf1NpbTz82VUridBYE1KvE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-AbevjLGKNmuKh84uRzkNTw-1; Wed, 10 Aug 2022 05:03:13 -0400
X-MC-Unique: AbevjLGKNmuKh84uRzkNTw-1
Received: by mail-ej1-f71.google.com with SMTP id
 qa39-20020a17090786a700b007309910696fso3969765ejc.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 02:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=/+HMHyPBaTX9PHpl8A8My7WJ1eVNq2ytE1WUSXocNgs=;
 b=VZTmS/j7KADbvAp7hkiXYtbp+WIDZGGJV+HLO5Xo3paHBS4iOvlrnp5k/nGW0GoIgZ
 Eqd15el0l7OpyblZt5IYfvNZlCPG1IG0t06m+lW8fDtk+AW3CPbrvaP1U+8zi7MoNjXS
 62Jcf1gNbk9pTMNz/3b/aZe1VhvAOSWkiIuNoS5OODxhNYlISpL9nrLQpD/WbIJ//L1M
 zZ580FEx4P7TTumLyx8ml4VjcEKJG6lLYFRGKTPPy28/Rd68rEccypBiUzuz/Ql3DHQI
 uY0Nrw25PAQXSBB92sZzU2dq11QzeNmHRvSG6hjx5nD26nR+pmW9o+juIPx38fVLyHXz
 xGdw==
X-Gm-Message-State: ACgBeo1Z26gFdJ/ESZ1NRxn3BHAZ7iazuY7V/9JVD1ZBln1iXigscxCc
 slFJg4+CRmMgVyVhdSI2dCwMFvPlz0Cu7XKR0nhwGNXt1Dip0Pq5/8CxDZcLfWyD/7gs7xsNYm2
 7VUmQvn95PALAyGtPKib90+jjdZvqK4JDSuNJDiGzkA==
X-Received: by 2002:aa7:ce88:0:b0:442:30f5:433f with SMTP id
 y8-20020aa7ce88000000b0044230f5433fmr4214992edv.317.1660122192091; 
 Wed, 10 Aug 2022 02:03:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4HX08pcwLb83nH98D7oalZSlpuH4GRpZXMjC0XRoiAZVCM50JTulfQFDUvFB/sgJSMTh/6hw==
X-Received: by 2002:aa7:ce88:0:b0:442:30f5:433f with SMTP id
 y8-20020aa7ce88000000b0044230f5433fmr4214971edv.317.1660122191875; 
 Wed, 10 Aug 2022 02:03:11 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 e6-20020a056402104600b0043d18a875d1sm7323709edu.79.2022.08.10.02.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 02:03:10 -0700 (PDT)
Date: Wed, 10 Aug 2022 05:03:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220810050219-mutt-send-email-mst@kernel.org>
References: <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
 <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

On Wed, Aug 10, 2022 at 02:59:55PM +0800, Jason Wang wrote:
> On Wed, Aug 10, 2022 at 2:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Aug 10, 2022 at 02:14:07AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Aug 09, 2022 at 04:24:23PM -0700, Si-Wei Liu wrote:
> > > >
> > > >
> > > > On 8/9/2022 3:49 PM, Parav Pandit wrote:
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Tuesday, August 9, 2022 6:26 PM
> > > > > > To: Parav Pandit <parav@nvidia.com>
> > > > > > Cc: Si-Wei Liu <si-wei.liu@oracle.com>; Jason Wang
> > > > > > <jasowang@redhat.com>; Gavin Li <gavinl@nvidia.com>; Hemminger,
> > > > > > Stephen <stephen@networkplumber.org>; davem
> > > > > > <davem@davemloft.net>; virtualization <virtualization@lists.linux-
> > > > > > foundation.org>; Virtio-Dev <virtio-dev@lists.oasis-open.org>;
> > > > > > jesse.brandeburg@intel.com; alexander.h.duyck@intel.com;
> > > > > > kubakici@wp.pl; sridhar.samudrala@intel.com; loseweigh@gmail.com; Gavi
> > > > > > Teitz <gavi@nvidia.com>
> > > > > > Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length for
> > > > > > big packets
> > > > > >
> > > > > > On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
> > > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > Sent: Tuesday, August 9, 2022 5:38 PM
> > > > > > > [..]
> > > > > > > > > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > > > > > > > > which case the receive buffer will be reduced to fit the 1500B
> > > > > > > > > > payload size when mtu is lowered down to 1500 from 9000.
> > > > > > > > > How? Driver reduced the mXu to 1500, say it is improved to post
> > > > > > > > > buffers of
> > > > > > > > 1500 bytes.
> > > > > > > > > Device doesn't know about it because mtu in config space is RO field.
> > > > > > > > > Device keep dropping 9K packets because buffers posted are 1500
> > > > > > bytes.
> > > > > > > > > This is because device follows the spec " The device MUST NOT pass
> > > > > > > > received packets that exceed mtu".
> > > > > > > >
> > > > > > > >
> > > > > > > > The "mtu" here is the device config field, which is
> > > > > > > >
> > > > > > > >          /* Default maximum transmit unit advice */
> > > > > > > >
> > > > > > > It is the field from struct virtio_net_config.mtu. right?
> > > > > > > This is RO field for driver.
> > > > > > >
> > > > > > > > there is no guarantee device will not get a bigger packet.
> > > > > > > Right. That is what I also hinted.
> > > > > > > Hence, allocating buffers worth upto mtu is safer.
> > > > > > yes
> > > > > >
> > > > > > > When user overrides it, driver can be further optimized to honor such new
> > > > > > value on rx buffer posting.
> > > > > >
> > > > > > no, not without a feature bit promising device won't get wedged.
> > > > > >
> > > > > I mean to say as_it_stands today, driver can decide to post smaller buffers with larger mtu.
> > > > > Why device should be affected with it?
> > > > > ( I am not proposing such weird configuration but asking for sake of correctness).
> > > > I am also confused how the device can be wedged in this case.
> > >
> > > Yea sorry. I misunderstood the code. It can't be.
> >
> > Here's a problem as I see it. Let's say we reduce mtu.
> > Small buffers are added. Now we increase mtu.
> > Device will drop all packets until small buffers are consumed.
> >
> > Should we make this depend on the vq reset ability maybe?
> 
> The advantage of this is to keep TX working. Or we can use device
> reset as a fallback if there's no vq reset.
> 
> Thanks

Device reset is really annoying in that it loses all the state:
rx filters etc etc.

> 
> >
> > > --
> > > MST
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
