Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80AAC77B7A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 12:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E4448444C;
	Fri,  2 Jun 2023 12:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E4448444C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ws+9iL6G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0OQgfRdMqRTF; Fri,  2 Jun 2023 12:21:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 850768441E;
	Fri,  2 Jun 2023 12:21:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 850768441E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F601C007A;
	Fri,  2 Jun 2023 12:21:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3DD6C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B18D426E3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:21:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B18D426E3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ws+9iL6G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Eo2ZQatrHV3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:21:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91921424D7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91921424D7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685708502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nQc+dQ9N7hxFd8nYxANjIMvreVhJ4zSmud0CQLehlr4=;
 b=Ws+9iL6GcKPHMPPjgduKHJN1voBdVL4mOL6FahyP9XgCze4FslYXXP78zmNEGczjQVjcT8
 pUefn/vgefQexdzsqbNH/92CJtcgEqvmOgr1JvqqVHBDPPQShCg53p0BucxfYbMyy7Q2jt
 RbP9cRXg0z5QPY3OZOdkx3z3tDreljw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-_G-xm8eXNVaobZTpBxftVQ-1; Fri, 02 Jun 2023 08:21:40 -0400
X-MC-Unique: _G-xm8eXNVaobZTpBxftVQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f5847463baso1647274e87.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 05:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685708499; x=1688300499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQc+dQ9N7hxFd8nYxANjIMvreVhJ4zSmud0CQLehlr4=;
 b=c3oDXYyxx4jJJAoSRzltw3Iz7619I6sAIqJjxurVeDcLmVsCYe/j2Ni1FykpeiVhUV
 f3mb0d9HToTSoVKdylPyVPcxYhwAlYctriWeog/yW/OKJ8LThoII8jfz1/GOIHQ4MpRN
 0ODzFji+tH3pQ64yY1u+1owIPVtoQJt4QwC/b/dd77egSp9qcaQtbsvA1yjPBVHCmRxd
 2uDMUwki5500NlI3G99iH6Vhsq1RpCqnxGr9rJVYPedzxKIbGJ+WSoaSJQBL2ckt1IGC
 PEPzVwrjKLFMG+EfagKl67Yj86k5emKB1urwWyiWiUHLB17RgEvAfspWwUUMbQtSg78J
 eKyw==
X-Gm-Message-State: AC+VfDwY11bRwXpAidj+0SYrs/rm1eCQ8euY/aV6qahaH7WOO9NQzG2y
 +i3mlxVMlfp8EOVJxLTTlv4KvgfgxgbWst6D0VzOXf8EA5UJzOPaebuAkFAgzd1ijUnn4TsDp58
 ABApGBnqIWhyIwN5Q0Qe39e/fJy2PEwn7GyO4cZy2fw==
X-Received: by 2002:a19:ee13:0:b0:4f4:d0ab:97d5 with SMTP id
 g19-20020a19ee13000000b004f4d0ab97d5mr1614033lfb.14.1685708499262; 
 Fri, 02 Jun 2023 05:21:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4iN5Oe/RT3maTUFxPJtLsYD98n3iirnzACiGYutNMW7rzu2KHAOeZV6Y6R1APlKy07KjCHMg==
X-Received: by 2002:a19:ee13:0:b0:4f4:d0ab:97d5 with SMTP id
 g19-20020a19ee13000000b004f4d0ab97d5mr1614027lfb.14.1685708498916; 
 Fri, 02 Jun 2023 05:21:38 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 n11-20020a7bcbcb000000b003f60d0eef36sm5349518wmi.48.2023.06.02.05.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 05:21:38 -0700 (PDT)
Date: Fri, 2 Jun 2023 08:21:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Message-ID: <20230602082125-mutt-send-email-mst@kernel.org>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
 <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
 <20230504145110-mutt-send-email-mst@kernel.org>
 <8e1f076cb09560ee2bcda2092c0de10a701ba00b.camel@nvidia.com>
 <20230512093000-mutt-send-email-mst@kernel.org>
 <c450ffd5-39c2-2fe1-de3f-7db45f01f7a4@amd.com>
MIME-Version: 1.0
In-Reply-To: <c450ffd5-39c2-2fe1-de3f-7db45f01f7a4@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Fri, May 12, 2023 at 04:55:38PM -0700, Shannon Nelson wrote:
> On 5/12/23 6:30 AM, Michael S. Tsirkin wrote:
> > 
> > On Fri, May 12, 2023 at 12:51:21PM +0000, Dragos Tatulea wrote:
> > > On Thu, 2023-05-04 at 14:51 -0400, Michael S. Tsirkin wrote:
> > > > On Thu, May 04, 2023 at 01:08:54PM -0400, Feng Liu wrote:
> > > > > 
> > > > > 
> > > > > On 2023-05-04 a.m.9:50, Dragos Tatulea wrote:
> > > > > > External email: Use caution opening links or attachments
> > > > > > 
> > > > > > 
> > > > > > The referenced patch calls set_vq_affinity without checking if the op is
> > > > > > valid. This patch adds the check.
> > > > > > 
> > > > > > Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading
> > > > > > mechanism")
> > > > > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > ---
> > > > > >    drivers/virtio/virtio_vdpa.c | 4 +++-
> > > > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > index eb6aee8c06b2..989e2d7184ce 100644
> > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > @@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device
> > > > > > *vdev, unsigned int nvqs,
> > > > > >                           err = PTR_ERR(vqs[i]);
> > > > > >                           goto err_setup_vq;
> > > > > >                   }
> > > > > > -               ops->set_vq_affinity(vdpa, i, &masks[i]);
> > > > > > +
> > > > > > +               if (ops->set_vq_affinity)
> > > > > > +                       ops->set_vq_affinity(vdpa, i, &masks[i]);
> > > > > if ops->set_vq_affinity is NULL, should give an error code to err, and
> > > > > return err
> > > > 
> > > > Given we ignore return code, hardly seems like a critical thing to do.
> > > > Is it really important? affinity is an optimization isn't it?
> > > > 
> > > > > > 
> > > set_vq_affinity is optional so it's not an error if the op is not implemented.
> > > 
> > > Is there anything else that needs to be done for this fix?
> > > 
> > > Thanks,
> > > Dragos
> > > 
> > 
> > no, it's queued already.
> 
> Are these queued into a repo that is accessible?  I haven't seen activity in
> the vhost.git where I would have expected it.  After stumbling over and
> debugging this same problem, I was happy to see it fixed, and I'd like to
> pull from a repo that has the current updates.
> 
> Thanks,
> sln

Pushed to next now.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
