Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9A7C6FA99
	for <virtualization@archiver.kernel.org>; Sun, 12 Mar 2023 16:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60A8C81AEF;
	Sun, 12 Mar 2023 16:24:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60A8C81AEF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkQAwwmo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rIF6eABNOQp5; Sun, 12 Mar 2023 16:24:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EBE0C80EAC;
	Sun, 12 Mar 2023 16:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBE0C80EAC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC241C0071;
	Sun, 12 Mar 2023 16:24:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BBEDC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 16:24:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 603DB60AAE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 16:24:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 603DB60AAE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkQAwwmo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-3-9rVXOye8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 16:24:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA1A060A82
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA1A060A82
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678638267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bO5s8F4TrRTFTkIiOaNt1JBcfb25HmSVDLJ5a2yZrVs=;
 b=XkQAwwmoXsb+RvTtviOhCHX4Z2d+5BVib8A4p9TlLkb0X+k+ex03kHJDxdkr91cSSAN6gx
 1HuWtpVDcJpn8aPx0h/UU9/yj6PWAMCp+XTvt8t8kV/uKlyEOiC3R6Q/HeEILKShNQtmZf
 YBD6erh4uv3HB0o9y8BoyS9TDzTO7cA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-6u-pUEBDMuGWqYwWurKYLQ-1; Sun, 12 Mar 2023 12:24:26 -0400
X-MC-Unique: 6u-pUEBDMuGWqYwWurKYLQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 t1-20020a7bc3c1000000b003dfe223de49so6511319wmj.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 09:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678638265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bO5s8F4TrRTFTkIiOaNt1JBcfb25HmSVDLJ5a2yZrVs=;
 b=7Fa7A0W/TjbGZwsXY9Bw09mIQW4MlJx67gYu717Dpa24YLZ7M6y5r34ZkIij+2hV5A
 unlR382xVaiBhmmJLAOUCpIeV/QSFBj6Edh9EEszsQKfDuS0uRh8ggDKTsLgv5f9f51i
 GkVpnQduVLen1aMR7t+vMCIoFaPNxPz6wH6QzWIf3Pkvpam8DIuXYniLwCOz/lfsDP3n
 62tCQIjH7+/ItnOITHfSubZLRrizu6paEdgrohm++jEi+Kiwmro/dlM9BXmI6Va7GRdY
 xjTxbDuuXT21NwwcEtaobjHMPamo12i2PFay6xu/nmXev/bpNBFaxIxJ2M+oPYctZUqZ
 UQzA==
X-Gm-Message-State: AO0yUKXA35zAgxWR6XpgO0getqXadeHs4VT+ZLqeOH4PyBEAbzhK5U1M
 jKO6lzeUFwwDiqfAk7elGbXYzyJGr2O5Upm/i1z8rX5yIQX/SP7qznlOtsdsizBeaNvAQXDVCII
 74uB1qm1ORYRAtskf8cnow036HQaIBe5elr8eJIbhuw==
X-Received: by 2002:a05:600c:1e16:b0:3eb:37ce:4c39 with SMTP id
 ay22-20020a05600c1e1600b003eb37ce4c39mr8429967wmb.6.1678638265201; 
 Sun, 12 Mar 2023 09:24:25 -0700 (PDT)
X-Google-Smtp-Source: AK7set+IDega9HgRIOmZWNZne9KjRRRmfuS5Q+mVXzxsHmEcRIlirdTYloF/j1PghZHS7WEg5BMMjw==
X-Received: by 2002:a05:600c:1e16:b0:3eb:37ce:4c39 with SMTP id
 ay22-20020a05600c1e1600b003eb37ce4c39mr8429957wmb.6.1678638264914; 
 Sun, 12 Mar 2023 09:24:24 -0700 (PDT)
Received: from redhat.com ([2.52.26.7]) by smtp.gmail.com with ESMTPSA id
 z9-20020a05600c114900b003dc5b59ed7asm6407309wmz.11.2023.03.12.09.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Mar 2023 09:24:24 -0700 (PDT)
Date: Sun, 12 Mar 2023 12:24:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Message-ID: <20230312122355-mutt-send-email-mst@kernel.org>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "perezma@redhat.com" <perezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eugenio Perez Martin <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Sun, Mar 12, 2023 at 01:28:06PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, March 12, 2023 6:25 AM
> > 
> > On Sun, Mar 12, 2023 at 11:10:25AM +0200, Eli Cohen wrote:
> > >
> > > On 12/03/2023 10:58, Michael S. Tsirkin wrote:
> > > > On Sun, Mar 12, 2023 at 10:39:19AM +0200, Eli Cohen wrote:
> > > > > One can still enable it when creating the vdpa device using vdpa
> > > > > tool by providing features that include it.
> > > > >
> > > > > For example:
> > > > > $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 device_features
> > > > > 0x300cb982b
> > > > >
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > What's the reason to turn it off by default? It's generally a
> > > > performance win isn't it?
> > > It has negative impact on packet rate so we want to keep it off by default.
> > 
> The performance characteristics is very workload specific.
> It is less of interest given the primary reason is backward compatibility, more below.
> 
> > Interesting.  I feel this would benefit from a bit more analysis.
> > Packet rate with dpdk? With linux? Is there a chance this will regress some
> > workloads?
> > VIRTIO_NET_F_MRG_RXBUF was designed to save memory, which is good for
> > small tcp buffers.
> 
> Eli,
> Please update the commit message.
> This change is to avoid regression in existing systems.
> The device previously didn't report MRG_RXBUF cap and it was not in use.
> Lately, certain devices are reporting this feature bit and it is breaking the backward compatibility.
> So the driver keeps it disabled by default.
> User should enable it when user prefers to.

OK. And which commit changes that?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
