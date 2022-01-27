Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EE5C433F5
	for <virtualization@archiver.kernel.org>; Thu, 27 Jan 2022 12:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D783D610C8;
	Thu, 27 Jan 2022 12:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PiJdlRhp2U41; Thu, 27 Jan 2022 12:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 60751610C6;
	Thu, 27 Jan 2022 12:41:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32166C0011;
	Thu, 27 Jan 2022 12:41:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C72AC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 12:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBACF84F12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 12:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iJfe0e0KVkyT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 12:41:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D78B284F0F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643287310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uNXpPtb2OXqXG9hmJBWkzD608J4s2s8/JsJidLVyecU=;
 b=FMwClazeMY+BoRJaNbrSAcjtc2N9v3Ac57Z5m5eR01q6CTeb+iZF+3wuaMszcwPtujKz53
 8sXzsUnvTXPedzD7qgA5p9nPebAfCSQZkzZcBfL5E7OVjv+uEwJMka05m3Y27oiKzWDOMb
 uYNnI9ZSZUMOF+T2IJt+TIOCTnJx9Bs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-Edg9vMsbMguppO__mPKoyQ-1; Thu, 27 Jan 2022 07:41:49 -0500
X-MC-Unique: Edg9vMsbMguppO__mPKoyQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 h11-20020a05640250cb00b003fa024f87c2so1370334edb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 04:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uNXpPtb2OXqXG9hmJBWkzD608J4s2s8/JsJidLVyecU=;
 b=STjcqb+gZCcp9FU1a0gjCNX2n6FClWBnCs9iKfytTCk4Kj4M6qI3MN44/8FXfW7o7F
 ipIR30MiDJcLZqlgkQZptmvePHdsDLsfLAVEEjHqcP9rlOUkYHsyxOeDRuwUdr88M6kl
 E5xUnP4RrUkB1JJQGt4+AmIbZ7hTksI8zwM0zEn8kjHJzg/nRypeDNKgcJnVINYlvYC+
 ImLy5D+vXb7rZ6lozM0fpkHdEOK3GF9aQH+W6+X6auAsKZh/gTCMFQGEHaLFjzHgEhCk
 vs9ZHo/BldroR+lGjS+JOnSnASIkiScQqRU3IrlsJ0cRHT5CCLzYsdawUIvlqQ4JcYKA
 V4BA==
X-Gm-Message-State: AOAM5324jid3EKc8AxLWlOqZPLdqmKRX8GP0+X+lsWMXqHeNfIHhGsSS
 BQE7TMyGg2tspJ85KyRAtVNIH7h6chPrtIrsMU8xAi8NRjffRt9YQ0yWD+42VMZxLJrlg6EEeA8
 qkQuYlyhylY46GRNlnDRI3NaXa+4MmWFm6JbJBrwlLQ==
X-Received: by 2002:a17:907:7d89:: with SMTP id
 oz9mr2684964ejc.400.1643287308396; 
 Thu, 27 Jan 2022 04:41:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyotloQ/8jLEyYVrL4x9QKTye3cSBEx1XpJh+giSQrDeyBAnixpRAjtIqNHOtrp8KFRexubOA==
X-Received: by 2002:a17:907:7d89:: with SMTP id
 oz9mr2684950ejc.400.1643287308220; 
 Thu, 27 Jan 2022 04:41:48 -0800 (PST)
Received: from redhat.com ([2.55.140.126])
 by smtp.gmail.com with ESMTPSA id g9sm8674052ejf.98.2022.01.27.04.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jan 2022 04:41:47 -0800 (PST)
Date: Thu, 27 Jan 2022 07:41:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yin Xiujiang <yinxiujiang@kylinos.cn>
Subject: Re: [PATCH] vhost: Make use of the helper macro kthread_run()
Message-ID: <20220127074050-mutt-send-email-mst@kernel.org>
References: <20220127020807.844630-1-yinxiujiang@kylinos.cn>
MIME-Version: 1.0
In-Reply-To: <20220127020807.844630-1-yinxiujiang@kylinos.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

On Thu, Jan 27, 2022 at 10:08:07AM +0800, Yin Xiujiang wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
> ---
>  drivers/vhost/vhost.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..19e9eda9fc71 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -595,7 +595,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  
>  	dev->kcov_handle = kcov_common_handle();
>  	if (dev->use_worker) {
> -		worker = kthread_create(vhost_worker, dev,
> +		worker = kthread_run(vhost_worker, dev,
>  					"vhost-%d", current->pid);
>  		if (IS_ERR(worker)) {
>  			err = PTR_ERR(worker);
> @@ -603,7 +603,6 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  		}
>  
>  		dev->worker = worker;
> -		wake_up_process(worker); /* avoid contributing to loadavg */
>  
>  		err = vhost_attach_cgroups(dev);
>  		if (err)

I think if you do this, you need to set dev->worker earlier.

> -- 
> 2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
