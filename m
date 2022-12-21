Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4BCC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 19:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A389F81FEE;
	Wed, 21 Dec 2022 19:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A389F81FEE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gk2i+C+U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXtpvJt_flyD; Wed, 21 Dec 2022 19:16:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2876181FD7;
	Wed, 21 Dec 2022 19:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2876181FD7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBBB5C0071;
	Wed, 21 Dec 2022 19:16:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 214FCC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 19:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2B1C40241
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 19:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2B1C40241
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gk2i+C+U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vHro91mYGnEv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 19:16:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 632EA400E4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 632EA400E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 19:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671650165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oziG1chFC2ZM07+R9uNqeu7rPi/qIDF9DD7uMEf+XEc=;
 b=Gk2i+C+UEpmi7IYJ3q5OkY5LuaeqqzYELOGrqRgB1nb4MU5IouTV0huyZmgIfpuLwXOdg9
 JyIs+x3FPKfX0nP85YxNluckHcUnDSgS8J06RNbA4HBnm/1sqXMdhbhoUDVaXjlkTW4LDV
 lq8ayAOWsDLAi8MuoZuMVgJBCWDUMBc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-205-T0TaQOBENKKl4DJLWivFnQ-1; Wed, 21 Dec 2022 14:16:03 -0500
X-MC-Unique: T0TaQOBENKKl4DJLWivFnQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 e14-20020a056402190e00b0047005d4c3e9so11813047edz.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 11:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oziG1chFC2ZM07+R9uNqeu7rPi/qIDF9DD7uMEf+XEc=;
 b=vk5oaC6TNvCSyjSa6BhGT5v5dGxTuvlOVkcpOhxRNlfXi5jZfJtNtleg/L84YbzsNB
 QDSq1D3muX2J1BuMhACRwGG4Ts9yj542AoCB0yI9aIrJRy6Tm7ltjOl8LZbMsmRLdr0R
 x4ptSUmcZfbiBsJWdaIOWW4DKJ2qvQjnS5qHaeGDVWaaHaSb5QV1oX57WPVIpL+OMZL2
 GSbUGvrNpe0IyE39N/dDXtbsDjkVwOQsZx0faTz15OikEg/w11RjpK/nVaNC24JtJo8/
 KjhwfwpmxSgoP10ibvL8GoUgcjf9mqgR6PC4BW8gQjynaa/G9baKv+VaHp2i0zwh3DXU
 3RwQ==
X-Gm-Message-State: AFqh2krBP8S9E20daDekoG9IZ3DfZchQlpZdAXGWTC8tRsZEyYRJ0uR1
 dOA6LNMNijeOUSObHhvBe8Fot6QjL3Y4iJzGbQJ3g9PTXxcsSFV4/AmkLb4nqjsXTzNl2UiUU7R
 6SFwS8xdrFogCbcrZ95I3mV0lPy4yAwU8TMsBrG/a6g==
X-Received: by 2002:a17:906:2b16:b0:81b:f931:cb08 with SMTP id
 a22-20020a1709062b1600b0081bf931cb08mr6654983ejg.47.1671650162853; 
 Wed, 21 Dec 2022 11:16:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtYgpQRoajpgpg88+32ygzHFWgzyaQ5djHehL3dJahxgz4ZK1NR86JbdFjj+nGQkHTx6xrXhg==
X-Received: by 2002:a17:906:2b16:b0:81b:f931:cb08 with SMTP id
 a22-20020a1709062b1600b0081bf931cb08mr6654959ejg.47.1671650162588; 
 Wed, 21 Dec 2022 11:16:02 -0800 (PST)
Received: from redhat.com ([2.55.175.215]) by smtp.gmail.com with ESMTPSA id
 mh11-20020a170906eb8b00b007ad69e9d34dsm7460122ejb.54.2022.12.21.11.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 11:16:01 -0800 (PST)
Date: Wed, 21 Dec 2022 14:15:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH v2] virtio-blk: avoid kernel panic on VIRTIO_BLK_F_ZONED
 check
Message-ID: <20221221141451-mutt-send-email-mst@kernel.org>
References: <20221221145433.254805-1-lstoakes@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20221221145433.254805-1-lstoakes@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, virtio-dev@lists.oasis-open.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, Sam Li <faithilikerun@gmail.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

On Wed, Dec 21, 2022 at 02:54:33PM +0000, Lorenzo Stoakes wrote:
> virtio zoned block device support is added by commit 0562d7bf1604
> ("virtio-blk: add support for zoned block devices") which adds
> VIRTIO_BLK_F_ZONED to the features array in virtio_blk.c but makes it
> conditional on CONFIG_BLK_DEV_ZONED.
> 
> In it virtblk_probe() calls virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)
> unconditionally, which invokes virtio_check_driver_offered_feature().
> This function checks whether virtio_blk.feature_table (assigned to
> the static features array) contains the specified feature enum, and if not
> _causes a kernel panic_ via BUG().
> 
> This therefore means that failing to enable CONFIG_BLK_DEV_ZONED while
> using virtio is a guaranteed kernel panic. Fix the issue by making the
> feature test also conditional on CONFIG_BLK_DEV_ZONED.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

I think this was fixed by
Message-ID: <20221220112340.518841-1-mst@redhat.com>


> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ff49052e26f7..94d210b10ebb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1580,7 +1580,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> -	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
>  		err = virtblk_probe_zoned_device(vdev, vblk, q);
>  		if (err)
>  			goto out_cleanup_disk;
> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
