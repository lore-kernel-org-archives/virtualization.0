Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960BCEB64DD
	for <virtualization@archiver.kernel.org>; Fri, 21 Jul 2023 14:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 430D541794;
	Fri, 21 Jul 2023 14:45:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 430D541794
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YYjhWN34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZc2PjqF3jL0; Fri, 21 Jul 2023 14:45:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D20E940135;
	Fri, 21 Jul 2023 14:45:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D20E940135
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 973C4C0072;
	Fri, 21 Jul 2023 14:45:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 233A5C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 14:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F164D61336
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 14:45:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F164D61336
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YYjhWN34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fidXnvjdYiQ4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 14:45:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFF3A61335
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 14:45:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFF3A61335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689950752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSmxBWHZqife/wyZDuG2oCanXHyMdbvWN3yQVprkoXU=;
 b=YYjhWN34Ehwg8Tj7GfqM0khJ97J3v3J4oav4Mnt9AzTDZ75JQHJycLpSqVciIVV0jcHMgz
 I61VEBo9n+CNzCP/IUE4Dd4OyA5CCgiDOI1oMRQWY19/9USPachyhLMzGJk4HJulQgpbkN
 rYQI05dIqrd67yZMnamiVPWzLVSoxsg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-miaaSv49OZaH9Vp6wKYCZw-1; Fri, 21 Jul 2023 10:45:50 -0400
X-MC-Unique: miaaSv49OZaH9Vp6wKYCZw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51e10b6148cso2501817a12.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689950749; x=1690555549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSmxBWHZqife/wyZDuG2oCanXHyMdbvWN3yQVprkoXU=;
 b=a4fPchy9UtrzbaMjXMf83MkHhDTYy8uaRREIlfvHC8XImyVBydiULo35Z49qjI5lrt
 b6MNSJzWKg+L25iS812wjSjj9Jz8uZ16sBdKpz12kbJihTu0j0rvq3WYrI5d12/WAKod
 SIunlBqLpyz3sStObfzunsjgWebPrUR7D0zpeIDwsDxbFwrvcu6yEuGLzc5BNftt65eI
 /cHP5+u63+WIECFhVy7pKnSDPoT4je8vkDGNRge/TxX5fTsXAhUcNYzgM7wcFCLLyalu
 vVC8HXE8zkiU8JCb14+f9DoqGWSAfytfx2lnRTf3tru7h3rcWKDyJV/3EOMrt08ttHdh
 dUuA==
X-Gm-Message-State: ABy/qLZA07YbKphToVkmrINeZZ68+MQ1l+9yMupYdQ3+L3ziCyq7dQdz
 7pTmhfKTHEM7ChPsKxQ6kSS4aJW9oeUlpiMRyWEs256dcwU8YbtCmMkLLVBF14xJ8nrzjJQp3hJ
 zV30k/NwkmH/SQDIzzEMr23UGENh4SOGRDYjyhLT6CA==
X-Received: by 2002:aa7:db4e:0:b0:521:29a:8ee3 with SMTP id
 n14-20020aa7db4e000000b00521029a8ee3mr2186355edt.5.1689950749651; 
 Fri, 21 Jul 2023 07:45:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFz1BiswVaH2Ai9c9vtY6LU5i5/TJTickO+NhgBFmERPHi2WvB/4gjph5Mu4Wx8zxL3o3ikyw==
X-Received: by 2002:aa7:db4e:0:b0:521:29a:8ee3 with SMTP id
 n14-20020aa7db4e000000b00521029a8ee3mr2186331edt.5.1689950749277; 
 Fri, 21 Jul 2023 07:45:49 -0700 (PDT)
Received: from redhat.com ([193.142.201.78]) by smtp.gmail.com with ESMTPSA id
 r26-20020a056402035a00b00521a3d8474csm2212152edw.57.2023.07.21.07.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 07:45:48 -0700 (PDT)
Date: Fri, 21 Jul 2023 10:45:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230721104445-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
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

On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> 
> 
> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > 
> > > > Adding cond_resched() to the command waiting loop for a better
> > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > run other task(workqueue) instead of busy looping when preemption is
> > > > not allowed on a device whose CVQ might be slow.
> > > > 
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > 
> > > This still leaves hung processes, but at least it doesn't pin the CPU any
> > > more.  Thanks.
> > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > 
> > 
> > I'd like to see a full solution
> > 1- block until interrupt
> 
> Would it make sense to also have a timeout?
> And when timeout expires, set FAILED bit in device status?

virtio spec does not set any limits on the timing of vq
processing.

> > 2- still handle surprise removal correctly by waking in that case
> > 
> > 
> > 
> > > > ---
> > > >    drivers/net/virtio_net.c | 4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > >            * into the hypervisor, so the request should be handled immediately.
> > > >            */
> > > >           while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > -              !virtqueue_is_broken(vi->cvq))
> > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > +               cond_resched();
> > > >                   cpu_relax();
> > > > +       }
> > > > 
> > > >           return vi->ctrl->status == VIRTIO_NET_OK;
> > > >    }
> > > > --
> > > > 2.39.3
> > > > 
> > > > _______________________________________________
> > > > Virtualization mailing list
> > > > Virtualization@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
