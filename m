Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C83C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Mar 2022 16:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E12D3405E9;
	Fri, 11 Mar 2022 16:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k_TiPz_cF7aM; Fri, 11 Mar 2022 16:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2CA95400AF;
	Fri, 11 Mar 2022 16:19:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0065CC001D;
	Fri, 11 Mar 2022 16:19:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72E7FC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 16:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5ACD582726
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 16:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AHomZVIxUsCB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 16:19:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4EB881985
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647015541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJnh/WTVytD4QJ+LQjSrAhkCQ4EpEF75dMKosoE5+jw=;
 b=Qapvkj8nB3XF3032JRKfvEvpCV003SsTsL+WgjfwoLsWP8X96NPP0TIMpxFZEw5jDVuK9B
 DUxLZ2ooXcFhyCJQWHDG6c3erIgdgmCU/d2ljqqbTD8TiKNd+ptU/DxVXd5td/cZmCqAzG
 h5jGOqhZZLB1WsSaJZ/YXpCGTg2SUzA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-fjwN8T99MMCaPW-Gmpnsgg-1; Fri, 11 Mar 2022 11:19:00 -0500
X-MC-Unique: fjwN8T99MMCaPW-Gmpnsgg-1
Received: by mail-wm1-f72.google.com with SMTP id
 a26-20020a7bc1da000000b003857205ec7cso3632352wmj.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 08:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AJnh/WTVytD4QJ+LQjSrAhkCQ4EpEF75dMKosoE5+jw=;
 b=p7XCFxbIrTUb6OrNNLJD7+RAiED7VUC+PfhhCyy5xQQLMrdRioT4A/chTaz5vBHADI
 XlNv8MBpDhTiZ+hCC8V87+ouPiEWkmzhK4kqso8/zb/dVuuxFDQKJK4bcL/gMdKIWDvf
 sw9FRp0mnyK/dK6Wimfy5snr11+ZPK1d57YrzBKH9PNpYBDouNUpl0uaLkM3S5/Y9U2Y
 dpfXUv+KbeWBSw4JAj80Zht24XhjC20paw7Gufo2efYjXWY3IWq79RD7fP36oNTdQZjd
 /ddJMoqdoIYxmH4FHk6aA4ewyIV1beEM5GniZhPSX5q2l+nSPXY0C8FOtoWwqKwNIGbi
 ziFw==
X-Gm-Message-State: AOAM530rg0+XS6nL//bTrEvAQvqp4UwjIIicUHKmXjG4fZJdCZLyf+eF
 nRVF0Ll+hKxIICqvm4NRJLrxyQA8V8pjjGFF0f2FccfTtVD90eTi+xh8nDUarBDtC/w58gW1P34
 nX7PSiJB+OgHcfcxJCPHZncKv74SvFsw1wLJ0TF6V6Q==
X-Received: by 2002:a5d:49c9:0:b0:1f0:16b2:584f with SMTP id
 t9-20020a5d49c9000000b001f016b2584fmr7904051wrs.710.1647015538981; 
 Fri, 11 Mar 2022 08:18:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyl/ZBDUcyVD5pvPIubD+ihVN6dxnz+tjurlLQCrzXPmvl14giKcpyIB02nshY5MQ84ii1LTA==
X-Received: by 2002:a5d:49c9:0:b0:1f0:16b2:584f with SMTP id
 t9-20020a5d49c9000000b001f016b2584fmr7904034wrs.710.1647015538767; 
 Fri, 11 Mar 2022 08:18:58 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 l1-20020a05600c4f0100b00387369f380bsm11873652wmq.41.2022.03.11.08.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Mar 2022 08:18:58 -0800 (PST)
Date: Fri, 11 Mar 2022 11:18:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220311111815-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <YitzuxYHywdCRKVO@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com, suwan.kim027@gamil.com
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

On Sat, Mar 12, 2022 at 01:07:23AM +0900, Suwan Kim wrote:
> On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
> > On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > > index d888f013d9ff..3fcaf937afe1 100644
> > > --- a/include/uapi/linux/virtio_blk.h
> > > +++ b/include/uapi/linux/virtio_blk.h
> > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > >  	 * deallocation of one or more of the sectors.
> > >  	 */
> > >  	__u8 write_zeroes_may_unmap;
> > > +	__u8 unused1;
> > >  
> > > -	__u8 unused1[3];
> > > +	__virtio16 num_poll_queues;
> > >  } __attribute__((packed));
> > 
> > Same as any virtio UAPI change, this has to go through the virtio TC.


Notice this pls.  Remember to copy one of the TC mailing lists.

> > In particular I don't think gating a new config field on
> > an existing feature flag is a good idea.
> 
> Did you mean that the polling should be based on a new feature like
> "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> and features[]? If then, I will add the new feture flag and resend it.
> 
> Regards,
> Suwan Kim

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
