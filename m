Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B933FC433EF
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 10:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59D0961664;
	Fri, 27 May 2022 10:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FF_7Gzg5irca; Fri, 27 May 2022 10:19:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E94CD6162D;
	Fri, 27 May 2022 10:19:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE710C0032;
	Fri, 27 May 2022 10:19:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8405CC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72B5061652
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rnEvEZKvoYaK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:19:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A622B60BBA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653646773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0t2zU9MXz4VT6MECWOHvsoDoBu3fXaqhY69+YDYTXFs=;
 b=PzbBO2iDLIv6MgX4ehfAfp0Lo0wcB/Dh8wXV9pciHKi65Byp3w0toRuyXRCupQ9T3E0e9d
 Ai17R62ZN40/z1dSr77Q8B+0oOpCOMdxWzXJC3dwE+WuEX1kPWURLdTS8exFH0n4464v+S
 Q6xUM+Gtp7/xHk1917Wc9Mwlqb1UyI0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-byV-ZiA1M3W-chfpak0CJQ-1; Fri, 27 May 2022 06:19:29 -0400
X-MC-Unique: byV-ZiA1M3W-chfpak0CJQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 m9-20020a50ef09000000b0042bd6839fd5so2798016eds.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 03:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0t2zU9MXz4VT6MECWOHvsoDoBu3fXaqhY69+YDYTXFs=;
 b=DBllw5dOnmBFMLO6M8ccPQkENiJjq/ZKOSUMi87bG/vxz0sqfv9gcLxufW8pY2Mj6g
 HHWXqQOWfaz6g4Ur7+L6NIy6jIa3d+Ig2SFhxuK/tBiq852DUyBd+YUcrg3Nb2ya8cme
 fH8c8AMlTktCHY6IKmInxvTD1qbCpAThyi4HEUiqlclFy46x3AlMevM/PiTIqWzuBULZ
 PVF9MSfMhAVWU/dIFDxQhrdP4WcHu8WTMBr/325TLSidWKN1KzuQh1zrm+2ecSn7G8yK
 nISJsgKnI4gztShpZMjZb3baPnNpgMZLj791imap0QW4eRhhc+y2yZMozeknrtSEqNR5
 KuGg==
X-Gm-Message-State: AOAM5335FVPbeBh3KP60Z8DlB8s+gqg+jjnrfIx/AhR6ignfOAGCH5rf
 koFYc6oKfojHe9C7QzUyUpWxUAUgRO4zxedKHCBN13aKeT4xc+CRubDBT51lMutSPeuq/6RzcHI
 PGVILivWTqrlYtObu87oFTUF3ckimdS8HJQIcg1JNDg==
X-Received: by 2002:aa7:cc01:0:b0:42a:402b:b983 with SMTP id
 q1-20020aa7cc01000000b0042a402bb983mr44184444edt.257.1653646768542; 
 Fri, 27 May 2022 03:19:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2w1aOFqWoL18Qhgq6ACsfKPjRn/tewWbSjC97sWOBqBfI9rnw+ZKnDTyxZqb0tSdLhb6XOg==
X-Received: by 2002:aa7:cc01:0:b0:42a:402b:b983 with SMTP id
 q1-20020aa7cc01000000b0042a402bb983mr44184423edt.257.1653646768272; 
 Fri, 27 May 2022 03:19:28 -0700 (PDT)
Received: from redhat.com ([2.55.130.213]) by smtp.gmail.com with ESMTPSA id
 s23-20020a1709064d9700b006fe8b3d8cb6sm1338752eju.62.2022.05.27.03.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 03:19:27 -0700 (PDT)
Date: Fri, 27 May 2022 06:19:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 4/4] virtio-blk: remove deprecated ida_simple_XXX()
Message-ID: <20220527061845-mutt-send-email-mst@kernel.org>
References: <fa54e172-ef9d-fba5-ad37-72a6698c7cb8@wanadoo.fr>
MIME-Version: 1.0
In-Reply-To: <fa54e172-ef9d-fba5-ad37-72a6698c7cb8@wanadoo.fr>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: keliu <liuke94@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

On Fri, May 27, 2022 at 10:04:46AM +0200, Christophe JAILLET wrote:
> (Resend, my email client sent it as HTML. So sorry for the duplicate)
> 
> 
> Hi,
> 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 74c3a48cd1e5..e05748337dd1 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -720,8 +720,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> > 		return -EINVAL;
> > 	}
> >
> >-	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> >-			     GFP_KERNEL);
> >+	err = ida_alloc_max(&vd_index_ida, minor_to_index(1 << MINORBITS),
> >+			    GFP_KERNEL);
> > 	if (err < 0)
> > 		goto out;
> > 	index = err;
> 
> 
> this patch, already applied to -next, is wrong.
> 
> 
> The upper bound of ida_simple_get() is exlcusive, while the one of
> ida_alloc_max() is inclusive.
> 
> So, 'minor_to_index(1 << MINORBITS)' should be 'minor_to_index(1 <<
> MINORBITS) - 1' here.
> 
> 
> (adding keliu in cc: because he is proposing the same kind of patches, so he
> will see how to to these changes that are slighly tricky)
> 
> 
> CJ

I will drop this for now, please resend with either
a corrected version or a comment explaining why it's correct.

Thanks!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
