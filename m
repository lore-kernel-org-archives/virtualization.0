Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105CBC77B7E
	for <virtualization@archiver.kernel.org>; Tue,  2 May 2023 09:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C96D6135C;
	Tue,  2 May 2023 09:05:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C96D6135C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a9bnO0mg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PdLbnbUyBMV3; Tue,  2 May 2023 09:05:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19B4E61149;
	Tue,  2 May 2023 09:05:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19B4E61149
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC6F0C0036;
	Tue,  2 May 2023 09:05:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 690ECC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 09:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41A9441484
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 09:05:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41A9441484
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a9bnO0mg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VhpSWjtayuBs
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 09:05:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 289EE414C4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 289EE414C4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683018345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBiSDi663ZNsStzgA6GdXFh74+Kd66TffhftU9nPlhU=;
 b=a9bnO0mg/Q1sO5J2FxNo2O54xdVDeIW91Ueepskr/xo8UypCr8Of/U7fal1kLlZSgQDsIt
 ZK2oXifsPHsegi+zP86tNtuWzfAIFnEvub62Q50Pfw0Na1nFepPDBeTaSGaooT+RCgIi2f
 bXI5s0O6mkXRrhvWremv8UNqZxJQzzE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-3t3O3YviOwK9jJNgcjeMBA-1; Tue, 02 May 2023 05:05:43 -0400
X-MC-Unique: 3t3O3YviOwK9jJNgcjeMBA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f173b5962dso1663275e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 May 2023 02:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683018342; x=1685610342;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f0C+/AMlCSZv9AQrfgdKXuPAa+4+MUJG4w0wWq0+U44=;
 b=ADzOBXgoLYKr+/B6+Bhq2UJp+B+HkQJ/ImP27kptnyCsYiCYDDYdYgw8neYVvT67tv
 Lvu6JIHusknfRGey+fFkZJTJ7sFeQJoEpwBEqtfJ8yQ+I0rPTPQTuu90/m3NrNalLb9H
 UAjf0vEwdfFCM57z5XrolWh9ggApgWqJSwllrCdDpBvbP8mTHx2FYIa1P2snHQigJMvm
 VqEk71DMcEce+bg0WZ8jaf+pxmyMtbxGYns4m00Qk36Zv5I0QN6soRWiMChcJ7i1tkNe
 YRclL/XIUarMfc/kP+kpkTyxKaBGA6AJqgzTCM85pd2qWB49w5xqnB2OQQ3xOAFELt9s
 8CgQ==
X-Gm-Message-State: AC+VfDwzbFYEX3WtkepY1/C2iXRd/u8w2d68SLR/XuDjhIEJ6+Ly0mOu
 onSCF37Xt1Anndg8cbej9BekM10N5BfZrBRDvi3MBByOeSoyH+wiDmJH9rKtyKzijQhHrSHjZhm
 SXdNXYc6ZYm4nOgH4Fvp3/6bwMjoHhcy0lBkCY7jlNw==
X-Received: by 2002:adf:fccd:0:b0:2e4:c9ac:c492 with SMTP id
 f13-20020adffccd000000b002e4c9acc492mr1293380wrs.1.1683018342788; 
 Tue, 02 May 2023 02:05:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rjtYdoyKyhcXOhmiGl12IvQfl4xRWKrtn/zid6aStQkUznSnb92UaWiUzP5pZgPUG9N/gkA==
X-Received: by 2002:adf:fccd:0:b0:2e4:c9ac:c492 with SMTP id
 f13-20020adffccd000000b002e4c9acc492mr1293354wrs.1.1683018342311; 
 Tue, 02 May 2023 02:05:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-253-104.dyn.eolo.it.
 [146.241.253.104]) by smtp.gmail.com with ESMTPSA id
 bl13-20020adfe24d000000b003062d3daf79sm4895245wrb.107.2023.05.02.02.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 May 2023 02:05:41 -0700 (PDT)
Message-ID: <d05564fd4fc47ed212be2c02be4d7c05167fa2b3.camel@redhat.com>
Subject: Re: [PATCH v3] virtio_net: suppress cpu stall when free_unused_bufs
From: Paolo Abeni <pabeni@redhat.com>
To: Wenliang Wang <wangwenliang.1995@bytedance.com>, mst@redhat.com, 
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  zhengqi.arch@bytedance.com,
 willemdebruijn.kernel@gmail.com
Date: Tue, 02 May 2023 11:05:40 +0200
In-Reply-To: <1682783278-12819-1-git-send-email-wangwenliang.1995@bytedance.com>
References: <1682783278-12819-1-git-send-email-wangwenliang.1995@bytedance.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Sat, 2023-04-29 at 23:47 +0800, Wenliang Wang wrote:
> For multi-queue and large ring-size use case, the following error
> occurred when free_unused_bufs:
> rcu: INFO: rcu_sched self-detected stall on CPU.
> 
> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>

Net next is currently closed, but this patch could arguably land on the
net tree - assuming Micheal agrees.

In that case you should include a suitable Fixes tag - reposting a new
version.

> ---
> v2:
> -add need_resched check.
> -apply same logic to sq.
> v3:
> -use cond_resched instead.
> ---
>  drivers/net/virtio_net.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ea1bd4bb326d..744bdc8a1abd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3559,12 +3559,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
>  		struct virtqueue *vq = vi->sq[i].vq;
>  		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
>  			virtnet_sq_free_unused_buf(vq, buf);
> +		cond_resched();

Note that on v1 Xuan Zhuo suggested to do the above check only every a
low fixed number of buffer. I think the current code is a better
option, as the need_resched() check is very cheap and the overall code
simpler.

In any case, when submitting a new revision, please explicitly CC
whoever gave feedback on previous ones.

Thanks,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
