Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0331FC6FD19
	for <virtualization@archiver.kernel.org>; Mon, 13 Mar 2023 21:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 675D940471;
	Mon, 13 Mar 2023 21:25:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 675D940471
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MhL6l0cy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xvZRQctZtGEM; Mon, 13 Mar 2023 21:25:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1B16402D0;
	Mon, 13 Mar 2023 21:25:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1B16402D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B2D1C0071;
	Mon, 13 Mar 2023 21:25:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9D9EC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84A0681416
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84A0681416
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MhL6l0cy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RvRbtY9Js89w
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:25:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CBC08195D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CBC08195D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678742725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dWdoNpnh8bKU1U2QHyZ+hikG13rJFFZOkYTJ0g0y2yo=;
 b=MhL6l0cyzRIYkO8Eme5GeNN7fUoRHem8ZKd2njZmnVMJiDBreSniVr3UXPa/GB2iKtSTTK
 i0PHMI7QXoi13CoAYTZmjKlhO9M5iFGQ9HY0G3KBgkhgGw4IGnowwrR538eVIfp0pIygHx
 MQxYKAbMCHfsH+LsdwBfgYW2wsFJVhg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-AiQl0YmEODirw1Se40OHlA-1; Mon, 13 Mar 2023 17:24:12 -0400
X-MC-Unique: AiQl0YmEODirw1Se40OHlA-1
Received: by mail-oo1-f69.google.com with SMTP id
 m14-20020a4add0e000000b0052010e01597so3782176oou.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 14:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678742638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWdoNpnh8bKU1U2QHyZ+hikG13rJFFZOkYTJ0g0y2yo=;
 b=DQXsb4cZ0jO/ApNImdwax6vHKhUlSjxI4zbasYMY0fkl/Fcl+Ky0qBCWhzjMJKfee2
 i+J/Z2T76RpGrbG8sE/EU2G8lSF0EWPs7UC1AvGyevHfc6/XAwcYdCHSvV3QDh5I+BzM
 Rn8XFIVfnEz3QcNCR0aAhO8OaV6sJ+VLZSCACxsTxf4XnlwzblKxhKjUhBWlRim04Kgm
 ZU37NzJCfBRprXsRmPaDlG4AdJVVBsbGF2jDN70WET3uH7J+3pEL28jxdcIG2gA1WWgo
 d9sNyUazN9/VGTC0ciCKmg0YX1BrTx5OPtfllvIqNubuxHCoNKW3D64vWuW46zxLkc36
 ZKNw==
X-Gm-Message-State: AO0yUKUiq1YSk0JrBTzf+jWVJvxH90E4W3sL5M44wdQerVImi7lyB2BE
 fcx6sBLzb0HskkmsPmHZzqnSn9/p/CmW6mwtKpXTUDHzpc5gJMQSKyPgsX7kl0O2/dv7/8qZ6wf
 GUsVunUhrtf4J0YoyDrMc3srwTqNywR6EomW2QrYdyw==
X-Received: by 2002:a05:6870:1214:b0:177:86ef:1957 with SMTP id
 20-20020a056870121400b0017786ef1957mr6678302oan.52.1678742637792; 
 Mon, 13 Mar 2023 14:23:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set8fIVPPPEr7EEnRI1LESRx3s8cJar3Ckd9nBSR5XM2CNPzrXz4WuhUojWoQtsN05SUddXW2wA==
X-Received: by 2002:a05:6870:1214:b0:177:86ef:1957 with SMTP id
 20-20020a056870121400b0017786ef1957mr6678293oan.52.1678742637478; 
 Mon, 13 Mar 2023 14:23:57 -0700 (PDT)
Received: from redhat.com ([2.52.26.7]) by smtp.gmail.com with ESMTPSA id
 dw50-20020a056870773200b0017703cd8ff6sm449339oab.7.2023.03.13.14.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Mar 2023 14:23:57 -0700 (PDT)
Date: Mon, 13 Mar 2023 17:23:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Message-ID: <20230313172309-mutt-send-email-mst@kernel.org>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230312122355-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548140734E1A0A8A2FD2CE30DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548140734E1A0A8A2FD2CE30DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Mon, Mar 13, 2023 at 09:14:38PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, March 12, 2023 12:24 PM
> > 
> > On Sun, Mar 12, 2023 at 01:28:06PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Sunday, March 12, 2023 6:25 AM
> > > >
> > > > On Sun, Mar 12, 2023 at 11:10:25AM +0200, Eli Cohen wrote:
> > > > >
> > > > > On 12/03/2023 10:58, Michael S. Tsirkin wrote:
> > > > > > On Sun, Mar 12, 2023 at 10:39:19AM +0200, Eli Cohen wrote:
> > > > > > > One can still enable it when creating the vdpa device using
> > > > > > > vdpa tool by providing features that include it.
> > > > > > >
> > > > > > > For example:
> > > > > > > $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2
> > > > > > > device_features 0x300cb982b
> > > > > > >
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > What's the reason to turn it off by default? It's generally a
> > > > > > performance win isn't it?
> > > > > It has negative impact on packet rate so we want to keep it off by default.
> > > >
> > > The performance characteristics is very workload specific.
> > > It is less of interest given the primary reason is backward compatibility, more
> > below.
> > >
> > > > Interesting.  I feel this would benefit from a bit more analysis.
> > > > Packet rate with dpdk? With linux? Is there a chance this will
> > > > regress some workloads?
> > > > VIRTIO_NET_F_MRG_RXBUF was designed to save memory, which is good
> > > > for small tcp buffers.
> > >
> > > Eli,
> > > Please update the commit message.
> > > This change is to avoid regression in existing systems.
> > > The device previously didn't report MRG_RXBUF cap and it was not in use.
> > > Lately, certain devices are reporting this feature bit and it is breaking the
> > backward compatibility.
> > > So the driver keeps it disabled by default.
> > > User should enable it when user prefers to.
> > 
> > OK. And which commit changes that?
> vdpa dev add command [1] has the ability to set the desired features.
> The commit log of this patch has an example too.
> 
> [1] https://elixir.bootlin.com/linux/v6.3-rc2/C/ident/vdpa_nl_cmd_dev_add_set_doit

I mean if this is claiming to fix a performance regression it should have
a Fixes: tag with the commit that introduced the regression.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
