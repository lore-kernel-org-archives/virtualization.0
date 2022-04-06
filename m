Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433CBC433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 11:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C94B9405E6;
	Wed,  6 Apr 2022 11:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDVEMHLv57wF; Wed,  6 Apr 2022 11:44:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5D7B940360;
	Wed,  6 Apr 2022 11:44:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30D28C001D;
	Wed,  6 Apr 2022 11:44:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63A2BC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39F3460E62
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RyhflzDoPKjX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:44:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 299B360A79
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649245467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lwNNz6rv0ilLVyQt3W6CEr1qMQ3DvsSiZ2/o8ivJazg=;
 b=gdgTCtIqmm0SduwQqNSqxaF2PJozpO4GjpMIMdzFaI1YkpbNtgbsMZzRMovSXbVrg3ev0X
 Tn9SfMIDZObDcXX8lvMZQuwwFK09H/6DtEouQOwnZVPQ3UT3KIfK71pr1z9qutMHXobUjX
 ubgAscW1lU0LQxiDejfwdUb+VKN3JkQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-Z3I9xkWsPSyLivDrtCC3Sw-1; Wed, 06 Apr 2022 07:44:26 -0400
X-MC-Unique: Z3I9xkWsPSyLivDrtCC3Sw-1
Received: by mail-ed1-f69.google.com with SMTP id
 b24-20020a50e798000000b0041631767675so1061439edn.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 04:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lwNNz6rv0ilLVyQt3W6CEr1qMQ3DvsSiZ2/o8ivJazg=;
 b=2/boP6Vy9z11v/zG7vlg4CavOBnjVkzH5ULcIuOF+xWq73GGCq/vsGz1rxn3lZ9FKD
 55ElsUtz6xV/C31H2deAD0Q196E5sk+58UwlaPKTAXGzblwd/hJLywFT+AsK6FT+6xwZ
 WVjzG28wwT7c8bSCRraIKCHwmnnDURBzrvsBc2mnh2/VoH+4OPgGnE88ptOB3HFYwets
 CcQ4OEgs9IZ71FpZj3uEPAdrr+xmiq60pJtcThu3Cvs1cE8+brgolK/u3lz6D1re7wc3
 NrW8dX4ma1XOcnPgXBbbXaKQ+jbI3XskMQl33VxAYiCtlnuuLq9XOpkuMWWpKUcGXyyc
 r3yg==
X-Gm-Message-State: AOAM5322HOjc+r/YJcgKDB+6LlGHNf0YDM0JbCyM4mkn7WMa+Y2ZY+In
 0KPGFqA062Xr9O/kRkw8tdWkH78ovtDVT+JpIYl+fkyGOttMYP7yzg6CV8EzzY9LORxS4QOMjlq
 5SluAT362NQAazaQWpTHeRcJfsopmsbfVON7HwH2fyA==
X-Received: by 2002:a05:6402:524c:b0:419:4d8c:e959 with SMTP id
 t12-20020a056402524c00b004194d8ce959mr8424478edd.398.1649245465595; 
 Wed, 06 Apr 2022 04:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyKyG/d/nbodp530VzQNr4iKM6ymM514uQFrWnWG0H+UPlyK/E2bEzixWxtvJ10YNdOZnTlA==
X-Received: by 2002:a05:6402:524c:b0:419:4d8c:e959 with SMTP id
 t12-20020a056402524c00b004194d8ce959mr8424453edd.398.1649245465410; 
 Wed, 06 Apr 2022 04:44:25 -0700 (PDT)
Received: from redhat.com ([2.53.144.12]) by smtp.gmail.com with ESMTPSA id
 n9-20020a05640205c900b00418d79d4a61sm8070317edx.97.2022.04.06.04.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 04:44:24 -0700 (PDT)
Date: Wed, 6 Apr 2022 07:44:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 1/5] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220406073803-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220406083538.16274-2-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

patch had wrong mime type. I managed to extra it but pls fix.

> 
> 
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> It will allows us

will allow us

> to do extension on virtio_device_ready() without
> duplicating codes.

code

> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
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

it's unfortunate that this adds an extra vmexit since virtio_device_ready
calls get_status too.

We now have:

static inline
void virtio_device_ready(struct virtio_device *dev)
{
        unsigned status = dev->config->get_status(dev);
                
        BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
        dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
}


I propose adding a helper and putting common code there.

>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
