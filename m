Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E953C05027
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 05:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCA594174E;
	Sun, 29 Jan 2023 05:47:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCA594174E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JYhjRIsh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZMrUVkLdPG0; Sun, 29 Jan 2023 05:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 256B64173E;
	Sun, 29 Jan 2023 05:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 256B64173E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E65BEC0033;
	Sun, 29 Jan 2023 05:47:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31985C002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAADF81DFC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:47:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAADF81DFC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JYhjRIsh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSO4fgabxuv8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:47:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7ACE981C04
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7ACE981C04
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674971256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tphhCAxDZYJ2LTB6FYhPTBLXCb38alsFESQTQXvgBWs=;
 b=JYhjRIshdp++Sk+Zy7s3jOgXH8EZ2M0/6GLDgb9ZTEVj0qFsUHhTfeoB9zXfAcnWqJLUEq
 nsKzpVh+LDdCJMRdLRNA5f7CIldSNxE4HGCo1bqswJPFzdrG2LQa4D7LIFzww3U24Hj5HY
 A3U7sRngSQFAZ977wYzqxxzzbXXfYmg=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-zrj2msgsOR-ALSx8UX9b1w-1; Sun, 29 Jan 2023 00:47:34 -0500
X-MC-Unique: zrj2msgsOR-ALSx8UX9b1w-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1632b78625cso3093306fac.22
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Jan 2023 21:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tphhCAxDZYJ2LTB6FYhPTBLXCb38alsFESQTQXvgBWs=;
 b=6srhhTYB6m7+Cz9OEdlPkqh7vVK9RI/yJrw7N22xhVo91KxBCHEvKypmGiyeaFdfG3
 E2ytg5BZTCLXxKYUqWajmyUFer5YdpWyrG078mOoc6zm9M+KJiz3ZAOwJDvQsQpc0gSQ
 GE/SiIJl5MF3yHEZL5xhRIcN20PYyEm8M9I4IHuUGkP5Gg6BhqozcMAD8JaIZbxuwRyj
 NXFdetayRpAAgnlg2I0G7ReSFMZJPXEdrXPWlH09YY+0QLU1+RcYnaJk65JagTB4hNV1
 AeIybcJE/2/I9XE1mDne3h6Czy6jzGwX7pM8li9kmWn8lUnEB/e2688t7xX9QNj9WalV
 1hog==
X-Gm-Message-State: AFqh2kqM0NAlo5gr4X3b+lld/YCOLz7LFHb2BQ7UJHG4sSDOL3bhKeQg
 h3vObC9e+FLUeRP9I9s6EBC0jiYF1D1j2vve4wis/cZdLjWJOk341Ri4ds0YKv2zX/8ogVBt9YC
 uq3/2+jsXGIcBesHPP3TlF+N4yX+Jv9ZDP6QKn2TK/4heFhcAWWlBH8gl6A==
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id
 m126-20020aca3f84000000b0036ef5f8cce1mr789754oia.35.1674971253938; 
 Sat, 28 Jan 2023 21:47:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu4L143R3NJsjNmkthKVkYXMjUbXNs9jA0GlrAw7Vj0fC09s68MgNkw4fOiThtvdWjm/P7Isb2r/10/5A6QBh8=
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id
 m126-20020aca3f84000000b0036ef5f8cce1mr789748oia.35.1674971253564; Sat, 28
 Jan 2023 21:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20221223060021.28011-1-jasowang@redhat.com>
 <20221223092656.ccs2fwwysu2gqzjo@sgarzare-redhat>
 <CACGkMEsjEJyrZvKus8rWNw4zgi-8FeWGBU+LYm6p41K7-j5gpQ@mail.gmail.com>
 <20230127052843-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230127052843-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Jan 2023 13:47:22 +0800
Message-ID: <CACGkMEsPX7KswcrXodwZs6F+pv9JMBrj+bXcNqFi61v_bcLMnQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: get rid of DMA ops
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com, hch@lst.de
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

On Fri, Jan 27, 2023 at 6:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 26, 2022 at 12:12:42PM +0800, Jason Wang wrote:
> > > >@@ -682,6 +553,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> > > >       if (asid >= vdpasim->dev_attr.nas)
> > > >               return -EINVAL;
> > > >
> > > >+      if (vdpasim->iommu_pt[asid]) {
> > >
> > > We are in the vdpasim_dma_unmap, so if vdpasim->iommu_pt[asid] is true,
> > > should be better to return an error, since this case should not happen?
> >
> > So it's a question of how to behave when unmap is called without a
> > map. I think we can leave the code as is or if we wish, it needs a
> > separate patch.
> >
> > (We didn't error this previously anyhow).
> >
> > Thanks
>
> OK I picked as is. Do we want WARN_ON maybe?

This could be triggered by the userspace, so I'm not sure it's worth it.

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
