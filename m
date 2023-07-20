Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448A6EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 21:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E50BE41723;
	Thu, 20 Jul 2023 21:03:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E50BE41723
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LW52BvQT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmmXqxyf8uy4; Thu, 20 Jul 2023 21:03:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4D0984172C;
	Thu, 20 Jul 2023 21:03:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D0984172C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 137DDC0071;
	Thu, 20 Jul 2023 21:03:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 193E9C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 21:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E675241731
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 21:03:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E675241731
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ASe1IBETJ3c
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 21:03:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F362341733
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 21:03:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F362341733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689886989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QxbwNNsUJXE4WSdo9/9FQ7rzSbFKTC0HO55OeJQjfDA=;
 b=LW52BvQTNkSQ8a+7oCTsL3qQ32QZB4Iy2vxH1a3Rfte2vqX9kKHhjn/MyfGLeBDcvZmYDt
 hApSl5QD6XvJB5g53yS5Bvi6SuVcA2VCntoue92K5xfTF01g9BayxB1jXeJXqmOQpMRABx
 KJvbWBv8Rdr2DNznerdVXznxBgqvgUw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-IalJWEiUPNOBnR06_1UktQ-1; Thu, 20 Jul 2023 17:03:07 -0400
X-MC-Unique: IalJWEiUPNOBnR06_1UktQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b934194964so12814621fa.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 14:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689886985; x=1690491785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxbwNNsUJXE4WSdo9/9FQ7rzSbFKTC0HO55OeJQjfDA=;
 b=O69KvAtwjhIx8zUPgfKyV8K9nqBc4/kvOgNYAY/ZO2DJ6BWKHr6+tg7pGxB3rwIwQZ
 uF4E5+1mBwFhqNTQaiLm7tj/LJ/2Hs05r9pu8ait5/AbEvF8vkrdlTnmQm0P8rNrhWvn
 EsEVAsPL1MmEUIwHICiWon71sfpJLbGr9B+0G/CayiouNST3qOFIMWfoLLD8P2M4wi2t
 aP7hVeHC3X2Y4mZcL0HL8lfkczYdIFnDPZrBicXc1o6KVNtqUu/t0dy9spczd4P1AEjy
 GZmeaLV/ruWt5Xdok/akwGnuLtNHdwW5OZnHYUDTAiE6GfZ6WGrVhlw/e3jO7xGYOV5M
 wC/A==
X-Gm-Message-State: ABy/qLaek+/tJHPKTJenU7QlW7lL+Mk5TZoynryyMCpBSTAnpOVTmZ/e
 zSD7hiAo626L+h/GepgM8h9AFwI44YL5kT4GDJpP4TjMR9TltWw9wlrwhUq+UZwXJn9pz7m2PX1
 eDql14hwh30XpsI4I28EUKyikfGubKQgKKAruBxIgQg==
X-Received: by 2002:a2e:9dcf:0:b0:2b6:dbc5:5ca4 with SMTP id
 x15-20020a2e9dcf000000b002b6dbc55ca4mr86339ljj.16.1689886985701; 
 Thu, 20 Jul 2023 14:03:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkO9895VB0oEJzz7Mt1u7LjrPYNqoemBmNFeHR6tqktWs0kblZ6OrDWTCIs6FgX5K3EX736g==
X-Received: by 2002:a2e:9dcf:0:b0:2b6:dbc5:5ca4 with SMTP id
 x15-20020a2e9dcf000000b002b6dbc55ca4mr86325ljj.16.1689886985355; 
 Thu, 20 Jul 2023 14:03:05 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 9-20020a05600c248900b003fbb618f7adsm1982153wms.15.2023.07.20.14.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 14:03:04 -0700 (PDT)
Date: Thu, 20 Jul 2023 17:02:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230720170001-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
MIME-Version: 1.0
In-Reply-To: <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, maxime.coquelin@redhat.com,
 pabeni@redhat.com, davem@davemloft.net
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

On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> On 7/20/23 1:38 AM, Jason Wang wrote:
> > 
> > Adding cond_resched() to the command waiting loop for a better
> > co-operation with the scheduler. This allows to give CPU a breath to
> > run other task(workqueue) instead of busy looping when preemption is
> > not allowed on a device whose CVQ might be slow.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> This still leaves hung processes, but at least it doesn't pin the CPU any
> more.  Thanks.
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> 

I'd like to see a full solution
1- block until interrupt
2- still handle surprise removal correctly by waking in that case



> > ---
> >   drivers/net/virtio_net.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 9f3b1d6ac33d..e7533f29b219 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >           * into the hypervisor, so the request should be handled immediately.
> >           */
> >          while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -              !virtqueue_is_broken(vi->cvq))
> > +              !virtqueue_is_broken(vi->cvq)) {
> > +               cond_resched();
> >                  cpu_relax();
> > +       }
> > 
> >          return vi->ctrl->status == VIRTIO_NET_OK;
> >   }
> > --
> > 2.39.3
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
