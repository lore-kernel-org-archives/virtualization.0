Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C50C4332F
	for <virtualization@archiver.kernel.org>; Tue, 22 Nov 2022 20:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C68F81FB4;
	Tue, 22 Nov 2022 20:06:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C68F81FB4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dtSKglFV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d57vxHfbkZ0k; Tue, 22 Nov 2022 20:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F2677813C2;
	Tue, 22 Nov 2022 20:06:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2677813C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9881C0033;
	Tue, 22 Nov 2022 20:06:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27E4BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 20:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB57581F1B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 20:06:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB57581F1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IGL9qKB_YhsW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 20:06:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30AB2813C2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30AB2813C2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 20:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669147609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0xAdJctF6H+O/M4MLLhKCg5TO/+mCew7BZYqlNiSSIs=;
 b=dtSKglFV62OOCmPHzFZCy0kEw4qmKAJpRNxEw3UZNbcUIvvhl2wfXXOel2mKUqck7TsakN
 hLbNf0RgFJTNrOOJjcql9QKZDCZFeVkORVF0eCEVLqcNguBbxCbA67Nv8Ax0gvXmHluyji
 77rb5kF35QVpZgKf47+53bOC5tDulDQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-8DXgtvY4NZ-8X03YUjqNIw-1; Tue, 22 Nov 2022 15:06:48 -0500
X-MC-Unique: 8DXgtvY4NZ-8X03YUjqNIw-1
Received: by mail-wm1-f69.google.com with SMTP id
 h9-20020a1c2109000000b003cfd37aec58so8564913wmh.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 12:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xAdJctF6H+O/M4MLLhKCg5TO/+mCew7BZYqlNiSSIs=;
 b=P41bhsrgpz2KT+9ztGqEt3krOjTS5QacewCnioi6NWlbPq8e9z5+Kl6tbe81YcWmTb
 WNBgt6uIGIsE7uIXH2qaA+FcGfj85o07KnmVP3a73Zg+6vkHJdt5dGFG+WslmuIR91kR
 bvokdTM94JO/AAZKZzgCGxppTDt+iZHvRkq9aNSZcJG9IyaA1TrPvklcjKBwSGbCNZ0u
 Bqpihvx0CPDu1VX/y0BQIKzBCoMjc8+5GW/QYEE0FlweqH9fJbqRkDAahe5oiQ1Pdk44
 ZgOHgwuQFl+BIj/91DnpyzZ0aUC+bmkBE2WhsGsGHXN4Oz4LVEnMboCi4vmradhK4uPn
 /X+Q==
X-Gm-Message-State: ANoB5pkRBype2n5YJ/ISSMYuCZvKDT1t5GiCrpsVEYUUOT/QZad6IAp7
 IAEVJNgdNzcFnDR8xLwiPBRA6bVqwqP36pH8QcJKy1V3K3ESeQ3HH/NlxsTak72i9mNQAsBtWs1
 Vk+ZdpDLsfNRgjOBnjVqMAvclhScrwCTMnnandr5ENg==
X-Received: by 2002:a05:600c:19d1:b0:3cf:ca1a:332a with SMTP id
 u17-20020a05600c19d100b003cfca1a332amr21535826wmq.118.1669147607590; 
 Tue, 22 Nov 2022 12:06:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YWFh65HU9KyRpvxonEkQl/n1raz9o7hhsaT5c6a6bnb78L5u0hylpoRzGwVF6Heua+k5RZA==
X-Received: by 2002:a05:600c:19d1:b0:3cf:ca1a:332a with SMTP id
 u17-20020a05600c19d100b003cfca1a332amr21535811wmq.118.1669147607355; 
 Tue, 22 Nov 2022 12:06:47 -0800 (PST)
Received: from redhat.com ([2.52.16.74]) by smtp.gmail.com with ESMTPSA id
 c2-20020a05600c0a4200b003cfd4cf0761sm25248305wmq.1.2022.11.22.12.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 12:06:46 -0800 (PST)
Date: Tue, 22 Nov 2022 15:06:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Zetao <lizetao1@huawei.com>
Subject: Re: [PATCH v2] virtio_net: Fix probe failed when modprobe virtio_net
Message-ID: <20221122150459-mutt-send-email-mst@kernel.org>
References: <20221121132935.2032325-1-lizetao1@huawei.com>
 <20221122150046.3910638-1-lizetao1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221122150046.3910638-1-lizetao1@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 cornelia.huck@de.ibm.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
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

On Tue, Nov 22, 2022 at 11:00:46PM +0800, Li Zetao wrote:
> When doing the following test steps, an error was found:
>   step 1: modprobe virtio_net succeeded
>     # modprobe virtio_net        <-- OK
> 
>   step 2: fault injection in register_netdevice()
>     # modprobe -r virtio_net     <-- OK
>     # ...
>       FAULT_INJECTION: forcing a failure.
>       name failslab, interval 1, probability 0, space 0, times 0
>       CPU: 0 PID: 3521 Comm: modprobe
>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>       Call Trace:
>        <TASK>
>        ...
>        should_failslab+0xa/0x20
>        ...
>        dev_set_name+0xc0/0x100
>        netdev_register_kobject+0xc2/0x340
>        register_netdevice+0xbb9/0x1320
>        virtnet_probe+0x1d72/0x2658 [virtio_net]
>        ...
>        </TASK>
>       virtio_net: probe of virtio0 failed with error -22
> 
>   step 3: modprobe virtio_net failed
>     # modprobe virtio_net        <-- failed
>       virtio_net: probe of virtio0 failed with error -2
> 
> The root cause of the problem is that the queues are not
> disable

if you need to resend it:

not disabled

but that's minor, ok to ignore

> on the error handling path when register_netdevice()
> fails in virtnet_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path. This
> makes error handling follow the same order as normal device
> cleanup in virtnet_remove() which does: unregister, destroy
> failover, then reset. And that flow is better tested than
> error handling so we can be reasonably sure it works well.
> 
> Fixes: 024655555021 ("virtio_net: fix use after free on allocation failure")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, LGTM, feel free to merge.



> ---
> v1 was posted at: https://lore.kernel.org/all/20221121132935.2032325-1-lizetao1@huawei.com/
> v1 -> v2: modify commit log and fixes tag
> 
>  drivers/net/virtio_net.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7106932c6f88..86e52454b5b5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3949,12 +3949,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	return 0;
>  
>  free_unregister_netdev:
> -	virtio_reset_device(vdev);
> -
>  	unregister_netdev(dev);
>  free_failover:
>  	net_failover_destroy(vi->failover);
>  free_vqs:
> +	virtio_reset_device(vdev);
>  	cancel_delayed_work_sync(&vi->refill);
>  	free_receive_page_frags(vi);
>  	virtnet_del_vqs(vi);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
