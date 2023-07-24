Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1372C0015E
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 06:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 312DC8176E;
	Mon, 24 Jul 2023 06:46:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 312DC8176E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BO3m2+YK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3xmu6WCzhTs; Mon, 24 Jul 2023 06:46:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9902D8176B;
	Mon, 24 Jul 2023 06:46:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9902D8176B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 828B1C0072;
	Mon, 24 Jul 2023 06:46:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 148B3C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D50524012E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:46:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D50524012E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BO3m2+YK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F17IVHZHw9nh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:46:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A779D40106
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:46:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A779D40106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690181197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTud+4xJIlrBtYDivlKsgCTpB5copH4qn7rSFdRl64g=;
 b=BO3m2+YKkQbH6zFuRVcXFV/KUAgn5iv7fPURszQx3peawfF0PRGiJO/XsdnmiwiBbeOFx3
 ngt1ePf99r7rURbGVqcNxgJMxsvtJpD+DotdTzzLuzzHyqxly6xQYNQxJZ7mbENKJcyhMn
 ienbqLu+nyJcw0zlXy3GtMJKAOyXJS8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-WHvg-6BZP4G8VW4LbMq_Rw-1; Mon, 24 Jul 2023 02:46:35 -0400
X-MC-Unique: WHvg-6BZP4G8VW4LbMq_Rw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31444df0fafso2421073f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 23:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690181194; x=1690785994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTud+4xJIlrBtYDivlKsgCTpB5copH4qn7rSFdRl64g=;
 b=SicgWdM843k+P2ahklbCU0yWOQQzIumyVnPXkWCucx1aea2ld431HNtS8aGFZoCBLk
 B1TxQBWhYVFNKNgD3s4wqiMC3zQJb/12HCNpyN1FoXmehT/5QKFkDzhG1X3gNaOkXBIJ
 puy9uRKI99CXGXheFB2mLhduMMt3tgQnnwQghyBPuJrwdtCKRNzlwtHIFWmAaflT1jCM
 F7ZcpZucoFCV+JUR2J/TgzCkK6lofEyBjL5bJkvuf0Q1V4LhF8AJKCRjmVKMwTcbB660
 LoHNKvm+KnVrgQbD0YE3bNKbQ1xUTj9gl0WpgOqwWSqmUM/vLclKCbSeNhWCbxrKI8c2
 xgBw==
X-Gm-Message-State: ABy/qLat2LuW1XYCEVgmjlgmb+LeOywzUwziFwYp61MFXnS8p4K6duj4
 V2l7H6hVfVuhTF5uwfdicTriHyjQRgPHYDjq7tWhDyUt+iRFXb3BHRHs6DUiUaX9H2sqeI+fIh5
 zPdEjQfTEXVz4m3xfYmrt5/2CnWdRqUmitENshE5uZg==
X-Received: by 2002:a5d:424c:0:b0:317:63d0:39b7 with SMTP id
 s12-20020a5d424c000000b0031763d039b7mr327866wrr.59.1690181194739; 
 Sun, 23 Jul 2023 23:46:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7cP9fOXzAr0jWfZwNJi+YrbNFUYBFxWMQGqWLEJY1T7WSzpkq4AQlu25w+diyWyfiqS0faw==
X-Received: by 2002:a5d:424c:0:b0:317:63d0:39b7 with SMTP id
 s12-20020a5d424c000000b0031763d039b7mr327851wrr.59.1690181194315; 
 Sun, 23 Jul 2023 23:46:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e0:3800:a16e:b2a0:7d06:58aa])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a5d5545000000b0031437ec7ec1sm11827434wrw.2.2023.07.23.23.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 23:46:33 -0700 (PDT)
Date: Mon, 24 Jul 2023 02:46:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230723053441-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
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

On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
> 
> 
> On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > > > 
> > > > > 
> > > > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > 
> > > > > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > > > 
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > 
> > > > > > > This still leaves hung processes, but at least it doesn't pin the CPU any
> > > > > > > more.  Thanks.
> > > > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > > 
> > > > > > 
> > > > > > I'd like to see a full solution
> > > > > > 1- block until interrupt
> > > > > 
> > > > > Would it make sense to also have a timeout?
> > > > > And when timeout expires, set FAILED bit in device status?
> > > > 
> > > > virtio spec does not set any limits on the timing of vq
> > > > processing.
> > > 
> > > Indeed, but I thought the driver could decide it is too long for it.
> > > 
> > > The issue is we keep waiting with rtnl locked, it can quickly make the
> > > system unusable.
> > 
> > if this is a problem we should find a way not to keep rtnl
> > locked indefinitely.
> 
> From the tests I have done, I think it is. With OVS, a reconfiguration is
> performed when the VDUSE device is added, and when a MLX5 device is
> in the same bridge, it ends up doing an ioctl() that tries to take the
> rtnl lock. In this configuration, it is not possible to kill OVS because
> it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
> net.

So for sure, we can queue up the work and process it later.
The somewhat tricky part is limiting the memory consumption.


> > 
> > > > > > 2- still handle surprise removal correctly by waking in that case
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > > ---
> > > > > > > >      drivers/net/virtio_net.c | 4 +++-
> > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > >              * into the hypervisor, so the request should be handled immediately.
> > > > > > > >              */
> > > > > > > >             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > +               cond_resched();
> > > > > > > >                     cpu_relax();
> > > > > > > > +       }
> > > > > > > > 
> > > > > > > >             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > >      }
> > > > > > > > --
> > > > > > > > 2.39.3
> > > > > > > > 
> > > > > > > > _______________________________________________
> > > > > > > > Virtualization mailing list
> > > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > > > 
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
