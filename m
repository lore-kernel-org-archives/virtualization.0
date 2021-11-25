Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E42C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 16:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8439D82779;
	Thu, 25 Nov 2021 16:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EG9oFxgFPm6G; Thu, 25 Nov 2021 16:22:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA56A82730;
	Thu, 25 Nov 2021 16:22:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 815DFC001C;
	Thu, 25 Nov 2021 16:22:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94947C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 16:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DCC9408FC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 16:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0KAFgYgbjyTr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 16:22:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2F62408FB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637857330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YTzp3Im+u9TWe7xoUSb1kOKhGSmltgh2ZdfYzHshjlo=;
 b=dW0CLEtBhZOVvIb7yV07GNdsF+SXYrw01uUY6shL6cuSug/SP27i6AHX74McD8YhM2lZTU
 Hsna78CDaH/hVLdUo/q++E3mtA17t+L5WsiDvnM6yyCLpCsan7wi2HJalR1pUw8FxaCJVL
 tgFgAY9OoLm7Jqr6zUXXiImjeBxgilc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-avTmOwkbNPeMpKG2jWJAoQ-1; Thu, 25 Nov 2021 11:22:07 -0500
X-MC-Unique: avTmOwkbNPeMpKG2jWJAoQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 v22-20020a50a456000000b003e7cbfe3dfeso5845636edb.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YTzp3Im+u9TWe7xoUSb1kOKhGSmltgh2ZdfYzHshjlo=;
 b=qlYm7vezUzghQPIb2xcULb9QENV1R4SuGZMqReHkmhcydn599gIHbuDilo6BFTdMPi
 RPaZSMqduaV5G1F5Wgq7jWqVZ5keUMpPCHPw+4IFtCH+NuGETySRTl5lJGCmrLsPU05b
 OUG/5449AEGIl/OJoIaKRAYkDlynRVu8UbZ9TouXcCixuqdpolNZ61WWOmi++fEriXaX
 SQM9XOTsnpi22Yhdakqp8vX5A3A/c8A602BfaiHL+qg3ycu5e2hO1sE1dXXTZ5Rq12/L
 4HTpXVtx6MGtxfvoSYV2GOiSRMGcgvvZ+CJE3tEtgkKKkpQZim/uT2xED0YGdHdP4GLh
 u1Pg==
X-Gm-Message-State: AOAM530Qd5vdWHtNq0lDTXvKych/iCLDBDjBjLX2X6/x8B8XtvjhwDOv
 6LWQi+onoCQxmrxYKo1KLTf6LTlIl4ij0SCpAfI3wlWE7n81Y8hOGBKcJO4+5dxLt0IBDN3ho+Y
 0x2bmiMysImMOn/xiwLuGF+P6XBcrKKXhDNxQrWxG+w==
X-Received: by 2002:a17:906:dc8d:: with SMTP id
 cs13mr32249053ejc.109.1637857326004; 
 Thu, 25 Nov 2021 08:22:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydbU5h+y0REbEoizdTuPyMjAfEKg6p4uEzWYWZvaNZU48JRl2Yw5f3/n++KiFekhNjLy0hsg==
X-Received: by 2002:a17:906:dc8d:: with SMTP id
 cs13mr32249020ejc.109.1637857325837; 
 Thu, 25 Nov 2021 08:22:05 -0800 (PST)
Received: from redhat.com ([176.12.197.47])
 by smtp.gmail.com with ESMTPSA id r11sm2484191edd.70.2021.11.25.08.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 08:22:05 -0800 (PST)
Date: Thu, 25 Nov 2021 11:22:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] net/mlx5_vdpa: Increase the limit on the number of
 virtuques
Message-ID: <20211125111936-mutt-send-email-mst@kernel.org>
References: <20211124171953.57858-1-elic@nvidia.com>
 <20211125022011-mutt-send-email-mst@kernel.org>
 <20211125072953.GA213638@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20211125072953.GA213638@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, si-wei.liu@oracle.com
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

On Thu, Nov 25, 2021 at 09:29:53AM +0200, Eli Cohen wrote:
> On Thu, Nov 25, 2021 at 02:21:43AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Nov 24, 2021 at 07:19:53PM +0200, Eli Cohen wrote:
> > > Increase the limit on the maximum number of supported virtqueues to 256
> > > to match hardware capabilities.
> > 
> > Hmm and are we going to have to tweak it each time new hardware/firmware
> > is out? Can't this be queried in some way?
> 
> I thought to make the allocation dynamic once we have support for
> setting max queues through vdpa tool.


Well this will make things a bit harder to figure out then,
right now you can assume no vdpa tool support -> max 16 VQs.
The patch breaks this. Is there a motivation to up this right now,
or should we just wait a bit for vdpa tool support?

> > In fact there's a suggestion in code to remove the limitation -
> > any plans to do this?
> 
> Can you be more speicifc, where?

It's right there in the patch:

  /* We will remove this limitation once mlx5_vdpa_alloc_resources()
   * provides for driver space allocation
   */
> 
> > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > typo in subject
> What typo?

virtuques. ispell is your friend.

> > 
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index ed7a63e48335..8f2918a8efc6 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -135,7 +135,7 @@ struct mlx5_vdpa_virtqueue {
> > >  /* We will remove this limitation once mlx5_vdpa_alloc_resources()
> > >   * provides for driver space allocation
> > >   */
> > > -#define MLX5_MAX_SUPPORTED_VQS 16
> > > +#define MLX5_MAX_SUPPORTED_VQS 256
> > >  
> > >  static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > >  {
> > > -- 
> > > 2.33.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
