Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89A1C43217
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 09:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61C01605DB;
	Mon, 28 Nov 2022 09:29:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61C01605DB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XbbuDL3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id te4JBTyHljQ7; Mon, 28 Nov 2022 09:29:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 06841605B1;
	Mon, 28 Nov 2022 09:29:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06841605B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9E81C0032;
	Mon, 28 Nov 2022 09:29:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEB03C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 09:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C999404A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 09:29:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C999404A6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XbbuDL3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GpxuKbd1qoJs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 09:29:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D75FD400D9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D75FD400D9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669627783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yXe5/Gs5NMc9hqQvF6Q+od4uwWeU4d6k98E6eiWSSHg=;
 b=XbbuDL3BjwfV4Vmwn0kxV6whNzsWb0Z95Dx4P/mWMucnyMwbzBtLjy93AtEkcx/vQkBWHL
 NzQPbqpbaoc/riiiLcLkq6C9WMooENQ0rCk7dlJ4aNL1fXOVj+ezvws0K5Ye8kZRK9OZUP
 QJmtQ64TTPLRV6+FLjfEEHEMSCT4Ugo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-t4GIat8DMeSlKbEERzoolQ-1; Mon, 28 Nov 2022 04:29:42 -0500
X-MC-Unique: t4GIat8DMeSlKbEERzoolQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 c187-20020a1c35c4000000b003cfee3c91cdso6058484wma.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 01:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXe5/Gs5NMc9hqQvF6Q+od4uwWeU4d6k98E6eiWSSHg=;
 b=7nxrNTfRJZsLTHC9guwqJhbf4geeShDPMeEnqTCnFIT234tzasX5StHDpxzNb4zdUH
 ivwBrdVtQVGtlr95OI8djEGgqHwbu+w/O3Q5ELfSLx9KYxErLyZkLnEs3KBxr1pVgaPC
 XqeHBoQDw/EUTzwMFaCA6QxArChvbSBTW0ijPu8nFOIN01eO965mJZJ50DrhlX47JzsX
 t2JiEx9EDhJ4c8Gqm1ALm1+KnHtS8S51YMilVeDZZcY+Vt1HMuqoF06vpVeDKExDM2MT
 Q/dYyho5S+bs/G8tVJjUA9TokGe1wT1qHSKshscAeYJTLgAxwT16xkarcOKiYKqpUFJi
 UrCw==
X-Gm-Message-State: ANoB5pn+esVaDEQ6ldoqoNfAORUT86JrqBxzeQVpybwE4DEARXRNzV+Q
 iy9BeH5Ki8Ki0T9qB7doXYt8/XtostPK1tPBpVtjkNWdQdD9/vn/5Dbsq33zofLSzLzjdEACng+
 jIVpB89B72qKU1mDmAJ270M6Es1c43G9E3RaQ5/Z09Q==
X-Received: by 2002:adf:ebc6:0:b0:241:c6d8:be83 with SMTP id
 v6-20020adfebc6000000b00241c6d8be83mr22842206wrn.454.1669627781379; 
 Mon, 28 Nov 2022 01:29:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5NNWLiFYkS/4BWx2K5W3KIsae1W7cB7QkH/0YG2DaPbKUxNFXJ8iBUflEeJZH3AcNSktTgUw==
X-Received: by 2002:adf:ebc6:0:b0:241:c6d8:be83 with SMTP id
 v6-20020adfebc6000000b00241c6d8be83mr22842182wrn.454.1669627781095; 
 Mon, 28 Nov 2022 01:29:41 -0800 (PST)
Received: from redhat.com ([2.52.149.178]) by smtp.gmail.com with ESMTPSA id
 z14-20020a7bc7ce000000b003cf78aafdd7sm14055513wmk.39.2022.11.28.01.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 01:29:40 -0800 (PST)
Date: Mon, 28 Nov 2022 04:29:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Zetao <lizetao1@huawei.com>
Subject: Re: [PATCH 3/4] virtio-input: Fix probe failed when modprobe
 virtio_input
Message-ID: <20221128042649-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128021005.232105-4-lizetao1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221128021005.232105-4-lizetao1@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, rusty@rustcorp.com.au, ericvh@gmail.com,
 netdev@vger.kernel.org, linux_oss@crudebyte.com, linux-kernel@vger.kernel.org,
 davem@davemloft.net, linux-block@vger.kernel.org,
 v9fs-developer@lists.sourceforge.net, edumazet@google.com, stefanha@redhat.com,
 kuba@kernel.org, pbonzini@redhat.com, pabeni@redhat.com,
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

On Mon, Nov 28, 2022 at 10:10:04AM +0800, Li Zetao wrote:
> When doing the following test steps, an error was found:
>   step 1: modprobe virtio_input succeeded
>     # modprobe virtio_input      <-- OK
> 
>   step 2: fault injection in input_allocate_device()
>     # modprobe -r virtio_input   <-- OK
>     # ...
>       CPU: 0 PID: 4260 Comm: modprobe Tainted: G        W
>       6.1.0-rc6-00285-g6a1e40c4b995-dirty #109
>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>       Call Trace:
>        <TASK>
>        should_fail.cold+0x5/0x1f
>        ...
>        kmalloc_trace+0x27/0xa0
>        input_allocate_device+0x43/0x280
>        virtinput_probe+0x23b/0x1648 [virtio_input]
>        ...
>        </TASK>
>       virtio_input: probe of virtio5 failed with error -12
> 
>   step 3: modprobe virtio_net failed
>     # modprobe virtio_input       <-- failed
>       virtio_input: probe of virtio1 failed with error -2
> 
> The root cause of the problem is that the virtqueues are not
> stopped on the error handling path when input_allocate_device()
> fails in virtinput_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path. After
> virtinput_init_vqs() succeeded, all virtqueues should be
> stopped on error handling path.
> 
> Fixes: 1fcf0512c9c8 ("virtio_pci: modern driver")

Probably 271c865161c57cfabca45b93eaa712b19da365bc


> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/virtio/virtio_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index 3aa46703872d..f638f1cd3531 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -330,6 +330,7 @@ static int virtinput_probe(struct virtio_device *vdev)
>  err_mt_init_slots:
>  	input_free_device(vi->idev);
>  err_input_alloc:
> +	virtio_reset_device(vdev);
>  	vdev->config->del_vqs(vdev);
>  err_init_vq:
>  	kfree(vi);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
