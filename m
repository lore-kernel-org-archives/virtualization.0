Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C5FEB64DC
	for <virtualization@archiver.kernel.org>; Fri, 21 Jul 2023 15:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FEF5417D1;
	Fri, 21 Jul 2023 15:10:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FEF5417D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dlO6oamh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBZfePbskL5P; Fri, 21 Jul 2023 15:10:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BE826417CB;
	Fri, 21 Jul 2023 15:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE826417CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97A99C0072;
	Fri, 21 Jul 2023 15:10:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 745ADC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 15:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CDD2417CB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 15:10:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CDD2417CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ko6QEaNiOUe
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 15:10:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7656A417CA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 15:10:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7656A417CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689952241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4yccWO+Y9iiMNd9c5vDAerEwJTFNEtbyszoY3g0yOQ=;
 b=dlO6oamhcr6NK2Z9zGRUvRYFDrZGdl7q7rXXS6k9+eBKqS9Wf4hGlCDElHpKnujkzFykLf
 7x/XfbTDayvVbAanK/7LKQAdqlfnPEU+bzcN1Knhea4368eWd6Ao2YfOdn82BF5glBH2P0
 BHawBh8dPNhRJbk4Dmoc7C52xMdAGVE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-0nIjSpgvO-GJER8xLFU04g-1; Fri, 21 Jul 2023 11:10:40 -0400
X-MC-Unique: 0nIjSpgvO-GJER8xLFU04g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fbcdca8fcbso2006502e87.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 08:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689952239; x=1690557039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4yccWO+Y9iiMNd9c5vDAerEwJTFNEtbyszoY3g0yOQ=;
 b=G0pfH/BOFZzfLQp56e0lLgq2aQShzgS6hukeUiBpTYfpPK8KwozN52lBIUWmBA5NOF
 9aeW894ri8ZemXo3Fkn4yXv3J85YDoelpYREuJBKPEgr6ZMui55EAq4Z70e0fBMnPR3W
 q0ZreIb86AnRbKMFslKFw5Atj/ZgcVDvX21813L6N9UEJ4Iv9S6CjmOo6MZQtxPVoc/M
 tow6B8E2OLOLDvQDxRkjgSpXsoaYLGsTEyBEF0REG3PciS/P2VKZtvISF0FofkHI6bCK
 BhlOe0+jG/miEnPlk8xU9vUW+DAWWyaY2fYZ8Z9H5f8naTWDRcivYcIPV+E+dCQQ5dxI
 lXPQ==
X-Gm-Message-State: ABy/qLZtxcTtfGJYjRi3aFRMG697OzAUhkb56OIE7og3ylJWs/+M5Zaw
 OiuNJeLcoVQ6ps/BknTYnpo415wbyEGrzHqBoTmx85JbitwNiiglZSu+F74/rud6ixnRt8v0x+0
 VwOd+VJ0lOBB5FkaLpBKVaK5sqtdHGJKpMnwdEdMaIA==
X-Received: by 2002:a05:6512:1110:b0:4f8:752f:3722 with SMTP id
 l16-20020a056512111000b004f8752f3722mr1478930lfg.5.1689952239046; 
 Fri, 21 Jul 2023 08:10:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG80UHLozH4ZU/PWhBiy+uFifJgDbYZi2tfCTx1oFIwZIyUo80XDUOdkU+6dUavycXACm+s+Q==
X-Received: by 2002:a05:6512:1110:b0:4f8:752f:3722 with SMTP id
 l16-20020a056512111000b004f8752f3722mr1478907lfg.5.1689952238563; 
 Fri, 21 Jul 2023 08:10:38 -0700 (PDT)
Received: from redhat.com ([193.142.201.81]) by smtp.gmail.com with ESMTPSA id
 d14-20020aa7d5ce000000b00521cb435d54sm2249319eds.37.2023.07.21.08.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 08:10:37 -0700 (PDT)
Date: Fri, 21 Jul 2023 11:10:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230721110925-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> 
> 
> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > 
> > > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > 
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > 
> > > > > This still leaves hung processes, but at least it doesn't pin the CPU any
> > > > > more.  Thanks.
> > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > 
> > > > 
> > > > I'd like to see a full solution
> > > > 1- block until interrupt
> > > 
> > > Would it make sense to also have a timeout?
> > > And when timeout expires, set FAILED bit in device status?
> > 
> > virtio spec does not set any limits on the timing of vq
> > processing.
> 
> Indeed, but I thought the driver could decide it is too long for it.
> 
> The issue is we keep waiting with rtnl locked, it can quickly make the
> system unusable.

if this is a problem we should find a way not to keep rtnl
locked indefinitely.

> > > > 2- still handle surprise removal correctly by waking in that case
> > > > 
> > > > 
> > > > 
> > > > > > ---
> > > > > >     drivers/net/virtio_net.c | 4 +++-
> > > > > >     1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > >             * into the hypervisor, so the request should be handled immediately.
> > > > > >             */
> > > > > >            while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > +               cond_resched();
> > > > > >                    cpu_relax();
> > > > > > +       }
> > > > > > 
> > > > > >            return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > >     }
> > > > > > --
> > > > > > 2.39.3
> > > > > > 
> > > > > > _______________________________________________
> > > > > > Virtualization mailing list
> > > > > > Virtualization@lists.linux-foundation.org
> > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
