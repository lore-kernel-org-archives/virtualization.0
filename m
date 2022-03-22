Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E4AC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 14:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BE8740AF3;
	Tue, 22 Mar 2022 14:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UcURimw4sJSl; Tue, 22 Mar 2022 14:07:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AF56340B15;
	Tue, 22 Mar 2022 14:07:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 825F3C0012;
	Tue, 22 Mar 2022 14:07:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62BE3C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BB7540B15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4O6uyoNSj6K
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:07:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA69340AF3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647958034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKHL9IfU8rsbWgmlsBY7UeKDRyHZ9mbeqT00XEDZRos=;
 b=Y1KIQAovrIPimxm0j+yq50Cs9Bgo1Y61zoz4eH1SrTi04yu4oLQ8aD5feWMuKjLmwpiV+7
 hpHBBSEkIOh2Yd9dXia4dQlZ9iyGjofhF9nIvgNw6RILOjcld4DniQRwz9/e/DDzCmR1mn
 tDs+wIuWWrHg7BAtoIGQqGkWOKxOz6I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-4gQUG6tCPEmi8V2g2hHvcQ-1; Tue, 22 Mar 2022 10:07:12 -0400
X-MC-Unique: 4gQUG6tCPEmi8V2g2hHvcQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 c126-20020a1c3584000000b00380dee8a62cso6947664wma.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 07:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lKHL9IfU8rsbWgmlsBY7UeKDRyHZ9mbeqT00XEDZRos=;
 b=a7tRZLssYw5IIV/2WjKesG7rsg3Bwxu0+owJFB+On8GYhUwpxyr20e2Ki4dB+Ungyt
 PDGNhPAJixOvQYDk+v3ehcCe6ZDX4YTS8G+fMu26FUfby7ADTRXNV7hTE6uO+oX6R0zF
 +6AkR8FXqadmPuQv93qFfrpgyAVUSJSAZVKojL5DZ3aLVLtvknGZHMWrArx+GptCVD+f
 z5vVs1trT7si7gMJQ9vL/PUoDynqIcWS+rM3TetRAUZ69RWs35oEZ5ozeq5TJK2bqjq2
 jYD/jIv2Te2voKr+GfR5rm5OHGjgKfpkJa3qVvyJOcbaLx4IKVZ4rC7RVmPQpzz2xVoD
 fFcg==
X-Gm-Message-State: AOAM5312H2wo/P9YAcMD2UVQq2F9A9p8r5C/3Y8ab1exLqFSgo4lK3Of
 y+2rczBML1FdWNzyhrdRF7XjGQmZlJA0lC5one3lhXc4HCeO4/DeobJyTVK1oGI589/XZpEZv4X
 GkWGIXsZPiqxrC/PtVIok+wNdykXbktqzMQQSdwfuqQ==
X-Received: by 2002:a5d:40c8:0:b0:205:2a3b:c2c with SMTP id
 b8-20020a5d40c8000000b002052a3b0c2cmr2630283wrq.13.1647958031628; 
 Tue, 22 Mar 2022 07:07:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpUT4GTrICCXrARvwlWmXcr/WqvuOsVfXAI5wRSHV+YMDxvpl+mz5oT10MHN/wvskk0SFTJw==
X-Received: by 2002:a5d:40c8:0:b0:205:2a3b:c2c with SMTP id
 b8-20020a5d40c8000000b002052a3b0c2cmr2630265wrq.13.1647958031363; 
 Tue, 22 Mar 2022 07:07:11 -0700 (PDT)
Received: from redhat.com ([2.55.132.0]) by smtp.gmail.com with ESMTPSA id
 r15-20020a5d6c6f000000b002040552e88esm9357838wrz.29.2022.03.22.07.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 07:07:10 -0700 (PDT)
Date: Tue, 22 Mar 2022 10:07:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220322100635-mutt-send-email-mst@kernel.org>
References: <20220322114313.116516-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220322114313.116516-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Mar 22, 2022 at 12:43:13PM +0100, Stefano Garzarella wrote:
> After waking up a suspended VM, the kernel prints the following trace
> for virtio drivers which do not directly call virtio_device_ready() in
> the .restore:
> 
>     PM: suspend exit
>     irq 22: nobody cared (try booting with the "irqpoll" option)
>     Call Trace:
>      <IRQ>
>      dump_stack_lvl+0x38/0x49
>      dump_stack+0x10/0x12
>      __report_bad_irq+0x3a/0xaf
>      note_interrupt.cold+0xb/0x60
>      handle_irq_event+0x71/0x80
>      handle_fasteoi_irq+0x95/0x1e0
>      __common_interrupt+0x6b/0x110
>      common_interrupt+0x63/0xe0
>      asm_common_interrupt+0x1e/0x40
>      ? __do_softirq+0x75/0x2f3
>      irq_exit_rcu+0x93/0xe0
>      sysvec_apic_timer_interrupt+0xac/0xd0
>      </IRQ>
>      <TASK>
>      asm_sysvec_apic_timer_interrupt+0x12/0x20
>      arch_cpu_idle+0x12/0x20
>      default_idle_call+0x39/0xf0
>      do_idle+0x1b5/0x210
>      cpu_startup_entry+0x20/0x30
>      start_secondary+0xf3/0x100
>      secondary_startup_64_no_verify+0xc3/0xcb
>      </TASK>
>     handlers:
>     [<000000008f9bac49>] vp_interrupt
>     [<000000008f9bac49>] vp_interrupt
>     Disabling IRQ #22
> 
> This happens because we don't invoke .enable_cbs callback in
> virtio_device_restore(). That callback is used by some transports
> (e.g. virtio-pci) to enable interrupts.
> 
> Let's fix it, by calling virtio_device_ready() as we do in
> virtio_dev_probe(). This function calls .enable_cts callback and sets
> DRIVER_OK status bit.
> 
> This fix also avoids setting DRIVER_OK twice for those drivers that
> call virtio_device_ready() in the .restore.
> 
> Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> 
> I'm not sure about the fixes tag. That one is more generic, but the
> following one I think introduced the issue.
> 
> Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")

Jason what should we do about this one BTW? Just revert? We have other
issues ...


> Thanks,
> Stefano
> ---
>  drivers/virtio/virtio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 22f15f444f75..75c8d560bbd3 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
>  			goto err;
>  	}
>  
> -	/* Finally, tell the device we're all set */
> -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
> +	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		virtio_device_ready(dev);
>  
>  	virtio_config_enable(dev);
>  
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
