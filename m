Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD01C4332F
	for <virtualization@archiver.kernel.org>; Mon, 21 Nov 2022 17:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4173481B53;
	Mon, 21 Nov 2022 17:46:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4173481B53
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQP/TWio
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c8vjOsB_ZfC3; Mon, 21 Nov 2022 17:46:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 912CC81B3E;
	Mon, 21 Nov 2022 17:46:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 912CC81B3E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CE7CC0032;
	Mon, 21 Nov 2022 17:46:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F107C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 17:46:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43AF460F2E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 17:46:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43AF460F2E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQP/TWio
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sLd6RoIZekbD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 17:46:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8165E60EDB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8165E60EDB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669052760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZsWyTZbLbUwrYvkp8yOiWqpRLocI1SdRjfKrEd8kUBM=;
 b=DQP/TWioIeexU4VM/pH2dnVfTfm4iledcdanii1GYBVbQI2aaFxxphj0pVrsrg38+jw/2/
 NZnRDfJL9F0NB9hNplNGkr9mI1mRwVnHGHaWP/zow9MHINR9joVZNjcKUUNvZ66BH4fCaV
 H8dpJ9rBISzI4beMlZ5D827nXI41lhQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-3L0sR5-zNWmc_USgcYLH0w-1; Mon, 21 Nov 2022 12:45:57 -0500
X-MC-Unique: 3L0sR5-zNWmc_USgcYLH0w-1
Received: by mail-wm1-f70.google.com with SMTP id
 m34-20020a05600c3b2200b003cf549cb32bso9636561wms.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 09:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsWyTZbLbUwrYvkp8yOiWqpRLocI1SdRjfKrEd8kUBM=;
 b=5NY2gAVpm/NTuf5QFkf4NKuA1kLeUSpXtWqyZPnwr5qSWtUKi8aEEM0mKuRCTHeI6a
 IEqMLfvyALD3rxV4t9C7YXAS2N1u0zA0LHZF3858PsjRlXWdJus9uJPWKBDwXWFkIhQY
 wRnhXxVtnWn92UUCyj1cgGL5AD00fXW+Q/HomZaHv32jL1Bhs5yru4szbNKbKtk9/ZXY
 Wrv6CLkTKXmOxygHZIWoVY1DSwSKEfE4bVUVxM8+pXvGYvgCSQXNEiS4ihAG2eIs2elY
 eKTWiLF0ydw/qysuxGRUDId6n/0CtvH3K1BPAi6yS4NAcJm5GxUbqBSB2LLj/2AT9DpO
 aWWw==
X-Gm-Message-State: ANoB5pmReJXNoLPQVeSnjNkq8zbclG59WfQDcz4xPHm2ZqP6w89AM+gf
 SfXLAMz9Gy3GfX/Dc45jMrI1u7U7apnGvQ2JiWJItLa7En34ZIFSPXfS2k+teA8zKogO9I4d0PU
 QxT46znzpqIjSmtUTLlj0dZ53fKFeV+TT5N6oQ3Doow==
X-Received: by 2002:a5d:6f0f:0:b0:236:5b81:1daa with SMTP id
 ay15-20020a5d6f0f000000b002365b811daamr2731137wrb.17.1669052756111; 
 Mon, 21 Nov 2022 09:45:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf606hSl3n2BZu1EpWbRdyPFuVmG8FXTdeOoGCjgArVy0T55wZnFAwMi/mCKF2NG3Vmm9g7JDA==
X-Received: by 2002:a5d:6f0f:0:b0:236:5b81:1daa with SMTP id
 ay15-20020a5d6f0f000000b002365b811daamr2731121wrb.17.1669052755799; 
 Mon, 21 Nov 2022 09:45:55 -0800 (PST)
Received: from redhat.com ([2.52.21.254]) by smtp.gmail.com with ESMTPSA id
 y10-20020a5d620a000000b002366dd0e030sm11871438wru.68.2022.11.21.09.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Nov 2022 09:45:55 -0800 (PST)
Date: Mon, 21 Nov 2022 12:45:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Zetao <lizetao1@huawei.com>
Subject: Re: [PATCH] virtio_net: Fix probe failed when modprobe virtio_net
Message-ID: <20221121123438-mutt-send-email-mst@kernel.org>
References: <20221121132935.2032325-1-lizetao1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221121132935.2032325-1-lizetao1@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Mon, Nov 21, 2022 at 09:29:35PM +0800, Li Zetao wrote:
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
> disable on the error handling path when register_netdevice()
> fails in virtnet_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path.
> 
> Fixes: 1fcf0512c9c8 ("virtio_pci: modern driver")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

I would add to this:

------

This makes error handling follow the same order as normal device cleanup
which does:

static void remove_vq_common(struct virtnet_info *vi)
{
        virtio_reset_device(vi->vdev);

        /* Free unused buffers in both send and recv, if any. */
        free_unused_bufs(vi);

        free_receive_bufs(vi);

        free_receive_page_frags(vi);

        virtnet_del_vqs(vi);
}

static void virtnet_remove(struct virtio_device *vdev)
{
        struct virtnet_info *vi = vdev->priv;

        virtnet_cpu_notif_remove(vi);

        /* Make sure no work handler is accessing the device. */
        flush_work(&vi->config_work);

        unregister_netdev(vi->dev);

        net_failover_destroy(vi->failover);

        remove_vq_common(vi);

        free_netdev(vi->dev);
}


So unregister, destroy failover, then reset - and that flow
is better tested than error handling so we can be reasonably
sure it works well.

-----


I would thus probably also include this tag instead:

Fixes: 0246555550 ("virtio_net: fix use after free on allocation failure")

this is what introduced the difference in cleanup order,
modern driver just added hardware support.


Besides extending the commit log

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
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
