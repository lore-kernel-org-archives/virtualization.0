Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22AAC433ED
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 09:48:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB89611CA
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 09:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB89611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F39D600D4;
	Mon, 17 May 2021 09:48:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o8koYBx-OjdZ; Mon, 17 May 2021 09:48:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5BE8608BA;
	Mon, 17 May 2021 09:48:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3D70C000E;
	Mon, 17 May 2021 09:48:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D082C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E1E7404B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uYPW0WcsqMMJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:48:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B899404A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621244920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tEiWMxvFfDaLBpfAi6mBYrtAgfz0m3EOWCPsuf6C4M=;
 b=UYDg9s0PlzjEBbN1XOopxRoaoaA39BXAmNsAiqMJrGCCTOnaU5C+ROXWjkphWj/g9LMnaP
 uEKlYnZrdWmXBByzOV9asql52fEoe2DX+WjEC04Tna3mzkvSjRSmYMkbPlTwtBi0a8sQo4
 JpINJenZ2KsnKKnmI9n5s9+f88sQpzw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-LQHmc7RkNQ28ouvrJRS-dQ-1; Mon, 17 May 2021 05:48:36 -0400
X-MC-Unique: LQHmc7RkNQ28ouvrJRS-dQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 n127-20020a1c27850000b02901717a27c785so2132622wmn.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 02:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1tEiWMxvFfDaLBpfAi6mBYrtAgfz0m3EOWCPsuf6C4M=;
 b=d6oIY6OITDBti//Pzbf8OQzquEv6NVQRYOhl0KWRwPaGh2rHN/fgjwpr55z3Osd5xZ
 PpUeSsC4gA3hzkDZt3O4OULHEdCn7u3pC8VSmPcqXzazgPUReKaq4t4HIV/QzJVlVh4+
 2wjzmBor99BWXG7EL869mZL62ZmStmfVD/abCPKqNduuu+7UI21mEe+/AQ/UDWkfacKf
 OXWax6+DPODgokW9V8VhPdcb2eJCXTJ+pqZa7Raxylutal4Cw0DP/BhdmnF4i42oRQe8
 mZqDSxFGX+XYCFGnGldPZMde8Znrw3UbwrA17eVhGuBwcqacBbbcEQnEzGwiVVABkQK4
 3wyg==
X-Gm-Message-State: AOAM530dglcQwo/Vtrx2uwTvLgmw35Oome74TVqn4zc+nd1hHjx19mlR
 5DQP7A6Ghsbu6uS5Up9qIrKQkX84bIfhVj3xJ1td54y15O0TmLd3Spa6MF1Eb5Uawd0NsDzAHxR
 2laABz+jmBSy44tcNPRIWELEFlTDarPea8/06RCvrLw==
X-Received: by 2002:adf:ab54:: with SMTP id r20mr5015707wrc.303.1621244915287; 
 Mon, 17 May 2021 02:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuGZWmkxNmth9iAq6lB+UpMloyMQwHTboefJhsB1s2BlK2Srhv7jCp8ez8YpU/rBwomOcu5A==
X-Received: by 2002:adf:ab54:: with SMTP id r20mr5015679wrc.303.1621244915043; 
 Mon, 17 May 2021 02:48:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6833.dip0.t-ipconnect.de. [91.12.104.51])
 by smtp.gmail.com with ESMTPSA id
 g66sm13847531wma.11.2021.05.17.02.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 02:48:34 -0700 (PDT)
Subject: Re: [RFC PATCH 13/15] virtio-mem: Handle virtio_device_ready() failure
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 jasowang@redhat.com, stefanha@redhat.com
References: <20210517093428.670-1-xieyongji@bytedance.com>
 <20210517093428.670-14-xieyongji@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <20e1d79f-c3f6-5553-d6b6-1f1051c39ccc@redhat.com>
Date: Mon, 17 May 2021 11:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517093428.670-14-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: ohad@wizery.com, jean-philippe@linaro.org, amit@kernel.org,
 airlied@linux.ie, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, virtualization@lists.linux-foundation.org,
 vgoyal@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 17.05.21 11:34, Xie Yongji wrote:
> Now virtio_device_ready() will return error if we get
> invalid status. Let's handle this case on probe.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/virtio/virtio_mem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 32a8e359a5c3..1148c392ff94 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2602,13 +2602,17 @@ static int virtio_mem_probe(struct virtio_device *vdev)
>   	if (rc)
>   		goto out_unreg_mem;
>   
> -	virtio_device_ready(vdev);
> +	rc = virtio_device_ready(vdev);
> +	if (rc)
> +		goto out_unreg_device;
>   
>   	/* trigger a config update to start processing the requested_size */
>   	atomic_set(&vm->config_changed, 1);
>   	queue_work(system_freezable_wq, &vm->wq);
>   
>   	return 0;
> +out_unreg_device:
> +	unregister_virtio_mem_device(vm);
>   out_unreg_mem:
>   	unregister_memory_notifier(&vm->memory_notifier);
>   out_del_resource:
> 

I assume this will really be a corner case to hit, right?


Failing after essentially being done initializing looks sub-optimal, anyhow:

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
