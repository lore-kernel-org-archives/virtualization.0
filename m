Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C92EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 20:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 002CA82B2F;
	Thu, 20 Jul 2023 20:58:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 002CA82B2F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RO3H2Z/R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Qn5rzcukh8P; Thu, 20 Jul 2023 20:58:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F35282343;
	Thu, 20 Jul 2023 20:58:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F35282343
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 666FCC0071;
	Thu, 20 Jul 2023 20:58:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C581C0071
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 20:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEB608234B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 20:58:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEB608234B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O4pVAwO9OqxV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 20:58:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81C55820ED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 20:58:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81C55820ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689886707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4dqf8Jjm5t/QS+Vt8DTpJf/dAD7LQ0qakHIdy8mWAJw=;
 b=RO3H2Z/RUem8b7nhHy0BjzBFtHj8C5zxvI2waCg/Yi1a8TJHJO/xxE/sbUjoIePXJ+mDaV
 wY8aQDZ8UQwI/spjzHsY4Hp/l5h0UgwEdzqgMTF/U10NiuMbU2tBjR6ZNZwqNC86CFBYpP
 G1gu+GJ3OFNX95L1vcn3iv9hgLPMjlI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-SvNj0ZVJPcmImUrG69YhAg-1; Thu, 20 Jul 2023 16:58:24 -0400
X-MC-Unique: SvNj0ZVJPcmImUrG69YhAg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-315a03cae87so1067887f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 13:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689886703; x=1690491503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dqf8Jjm5t/QS+Vt8DTpJf/dAD7LQ0qakHIdy8mWAJw=;
 b=V6aDZpmYjzTYQIkoFqEvZRN9Nv7Fp9HhKhs8zX5BxZJRjkZSvZKkKd2ZsxjIfjXflL
 p1yvaKB4VWUiBn1tnqdzCJJ4HJcZUukES5kbN9OBRb+4iNkh5fmef0Spn+p9Z1KXnSI6
 PeCjuzTzGH7zO2fDGaMThb7XpPTnuEofZLt6AxumIJMET8rONBDAEiKJ5cMMzVy4bbcG
 bCl4rn3V9JN6R+o/qL8eqPCskYnMvazKXv1z1EJ+7LjfE7DyWst+xq8lVBuLgcqg0SP3
 UfB25z2vfho/6+yxt9M6Nij8+lbEvfgBP67ptelxdqZpFpJNc+rgnh1cO9TnWY1b4Bkl
 plMg==
X-Gm-Message-State: ABy/qLaORM/9cWrpA3Ve3Qo6oKS98ChqjjOMIwfjysPb4Pw4QQ1RBSbZ
 zHvxyZjmDmjLSUHso2Xj7nLcF3Ua5Nm3zzspoOqzGK9Q7MYSFa/Y8Nva9QpZNkdoXSRDYFjtyK2
 qykrJm8iNoamCvMNwECr7e471xT2+TcmYL4qPpEai8A==
X-Received: by 2002:adf:fc48:0:b0:314:77a:c2a6 with SMTP id
 e8-20020adffc48000000b00314077ac2a6mr24899wrs.25.1689886703220; 
 Thu, 20 Jul 2023 13:58:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGGVPES+OLvpID+VHOy6r8D1EwH01kkL+pN8O6wPgr+LrofdyHrBq3n7dIj/lcIXZPoNV3xA==
X-Received: by 2002:adf:fc48:0:b0:314:77a:c2a6 with SMTP id
 e8-20020adffc48000000b00314077ac2a6mr24892wrs.25.1689886702902; 
 Thu, 20 Jul 2023 13:58:22 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 h9-20020a5d6889000000b0031432c2fb95sm2275327wru.88.2023.07.20.13.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 13:58:22 -0700 (PDT)
Date: Thu, 20 Jul 2023 16:58:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230720164930-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <b949697e-319a-7cc1-84d8-1391713fa645@amd.com>
MIME-Version: 1.0
In-Reply-To: <b949697e-319a-7cc1-84d8-1391713fa645@amd.com>
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

On Thu, Jul 20, 2023 at 08:31:13AM -0700, Shannon Nelson wrote:
> On 7/20/23 1:38 AM, Jason Wang wrote:
> > 
> > Adding cond_resched() to the command waiting loop for a better
> > co-operation with the scheduler. This allows to give CPU a breath to
> > run other task(workqueue) instead of busy looping when preemption is
> > not allowed on a device whose CVQ might be slow.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
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
> 
> The cover letter suggests that this addresses the infinite poll for buggy
> devices, but I don't see how that is resolved here.  This should make it a
> little nicer to the system, but it still is going to poll forever on a
> device that has gone catatonic.  Is there a reason that I'm missing that we
> don't have a polling limit here?
> 
> sln

we don't know what the limit would be. but given it's a workqueue
now, why does it still have to poll as opposed to blocking?


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
