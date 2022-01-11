Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8E0C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 12:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C076082FEA;
	Tue, 11 Jan 2022 12:09:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f5pLcvFuXy1I; Tue, 11 Jan 2022 12:09:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 732EC82DE6;
	Tue, 11 Jan 2022 12:09:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49FD8C0030;
	Tue, 11 Jan 2022 12:09:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62403C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 498BE605AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I2zcdKWmGZ5w
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:09:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EFBF60590
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641902970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PeE3Tf77Cb+2Y4AonN3yi26inPlr5CgfY3ebDWbArog=;
 b=h2rhy0sKQ2gRvTEUdyCcrHetjDJr71dA7v7w+6x8IWhtqdY5V87YTyqktF0kv676VgymJb
 97kZ4qEUmLHpsGZrB49gZBIpZo8KQ4geJXxTkXu8nytNXk5rhLTmOiGLDx8aCrDlVFCbxj
 a79Nw/9sSGrpO+2N+o9VatG4uskVWuI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-cjx9FYgEPzO7qz60qqSoxw-1; Tue, 11 Jan 2022 07:09:29 -0500
X-MC-Unique: cjx9FYgEPzO7qz60qqSoxw-1
Received: by mail-wr1-f71.google.com with SMTP id
 i23-20020adfaad7000000b001a6320b66b9so2986071wrc.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PeE3Tf77Cb+2Y4AonN3yi26inPlr5CgfY3ebDWbArog=;
 b=krf7LOKiyzFVORyq5K7NH+e3U1GurqlYzRTVkccoTHSxaU0mL0IiB9899MPqHWr21k
 8yUexXAE/GGCIGNNCTMjvj9J1jFvGjPPwz0ylyZEVtEeZfqRYyDC9txgh+dYTr11FoZ7
 6Uq+uvAMuDuUp+vgrIM+lwbeps5mKiwz/8s+Kz4Ip/HPHzTLX2+xMFC5Rrghkm9luU1Q
 SKcOb/4WaS3oQc4BC2ap0S/ekaL1i5iae1mxfqFDreD6lCtkzBKbC4J/nEy/jj6z+7CQ
 lIoPfKnSbv/9T5eG5qKt9RxhEuLXcpg43ZnBM/9i7N8pV/WX31QQ989rjMv2js18KJrX
 AFPQ==
X-Gm-Message-State: AOAM530ofJ6dP9mr3XrEudogR0+Y6WjYJQNb5y7D7CHkNUB+Plwrho0j
 Q9LhgRdMXgITnHGqqun1qwQoeCP2Cp+IzOLiU+qM2yWbu5N6SXRuhzawROf6C6m7Oaku7dlZMJ0
 R1ibgb6qaH7Q+5UZE9TSlKFOZZM+PMS3IU2dB1TfJ/Q==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr3802575wrb.545.1641902967938; 
 Tue, 11 Jan 2022 04:09:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTTHa+qHQF58EMSKXgKDdt0SWmOkIBg8CcYgRME6zT1N+wjiAFF3ji6fGFC8xXuG9R4J4A7w==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr3802560wrb.545.1641902967770; 
 Tue, 11 Jan 2022 04:09:27 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id m7sm1495468wmi.13.2022.01.11.04.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 04:09:27 -0800 (PST)
Date: Tue, 11 Jan 2022 07:09:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 2/4] vdpa/mlx5: Fix is_index_valid() to refer to features
Message-ID: <20220111070856-mutt-send-email-mst@kernel.org>
References: <20220111072253.101884-1-elic@nvidia.com>
 <00619365-173b-bd2c-3a9f-c6d7084631fb@oracle.com>
 <20220111111617.GA156130@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20220111111617.GA156130@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Tue, Jan 11, 2022 at 01:16:17PM +0200, Eli Cohen wrote:
> On Tue, Jan 11, 2022 at 01:31:28AM -0800, Si-Wei Liu wrote:
> > 
> > 
> > On 1/10/2022 11:22 PM, Eli Cohen wrote:
> > > Make sure the decision whether an index received trough a callback is
> > > valid or not consults the negotiated features.
> > > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> > 
> > Is there more for this series? Subject says there're 4 patches in total?
> 
> No,there were unrelated patches in my tree that went out.
> 
> Let me see if there are more patches for me to send and if I do, I will
> resend this in the previous one again.

Yea the series is malformed. Not a single thread, etc.


> > 
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++---
> > >   1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index d1ff65065fb1..9eacfdb48434 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -133,10 +133,14 @@ struct mlx5_vdpa_virtqueue {
> > >   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > >   {
> > > -	if (unlikely(idx > mvdev->max_idx))
> > > -		return false;
> > > +	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > +		if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > +			return idx < 2;
> > > +		else
> > > +			return idx < 3;
> > > +	}
> > > -	return true;
> > > +	return idx <= mvdev->max_idx;
> > >   }
> > >   struct mlx5_vdpa_net {
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
