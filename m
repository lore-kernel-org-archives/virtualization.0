Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BE8C00144
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 15:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8955260B3B;
	Mon,  1 Aug 2022 15:18:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8955260B3B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RdazHXXl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LjRGsD5eBWcS; Mon,  1 Aug 2022 15:18:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 646DA605E8;
	Mon,  1 Aug 2022 15:18:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 646DA605E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49484C0033;
	Mon,  1 Aug 2022 15:18:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61321C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 15:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26F4781C93
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 15:18:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26F4781C93
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RdazHXXl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mlO0BS9yd5yB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 15:18:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CA6A81C81
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CA6A81C81
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659367099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmwCfvO79GM4Sb0KX9aVjYyXH2nYh9vRvkB4m2BrJVg=;
 b=RdazHXXluGnxXPqhjF3Ci5AB+cugu1u2FURt+dkCFCj/tNGWiO3WJAH17BUqyX8BUhjmLn
 Ev5ycoQGLW4Mw7HlsesA8c87ahQpWLoceQXihCeDNU7eQbWcyYeSLrWKiNMKjUCDbp/T43
 N2Yw/2nXMWrQvIC5HBHMp0pumWVnt14=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-iH83W0Q1O5CIPqslXR1AtA-1; Mon, 01 Aug 2022 11:18:17 -0400
X-MC-Unique: iH83W0Q1O5CIPqslXR1AtA-1
Received: by mail-wr1-f70.google.com with SMTP id
 t13-20020adfe10d000000b0021bae3def1eso2665515wrz.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Aug 2022 08:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=qmwCfvO79GM4Sb0KX9aVjYyXH2nYh9vRvkB4m2BrJVg=;
 b=70TzVQpdkMvdNlxiB2aQLYi3uLA7i4ILQ4yCfkgvGK+w/OAtkLfSC10ncnOmyj4/XD
 HX6hxujXN9s+zk5Uq5Nyvtex8riyrlu8tLmme4dnS2Zf+pyT4JYhniuvzbOFbk9Nr/9n
 uZxcO79nb2VDncVT4Uzmc5qupq6XWR9QgbU9u9ka9dAiIAyjkyhXh5CKO1DMvVszdBHH
 E+0B//Ygc6V8Yd28EEBOZVvIsQmm6Dm5mXHc74yiUNpUWTCpH1ZO2vbjnUoy2DLkqKjy
 8j56AwPBv/sUu4qR5uuqg1tokWn8SQrlACzUfnBGYlTGoW2agXfDhyGyXwpZklloml9l
 l8wA==
X-Gm-Message-State: ACgBeo1RD53E3k1xHl5znmXj1/+AaRxL90/Ma0MJj5Nj+Prgop9zJ3Gy
 BtXtfWP86uiCsG7AYczCP79DvSPJ/yafq4kiA2EGSG5bN85o0h895Lh08OzbB9KXd3pPZ6VKyhM
 KmP9UuSnxoRHgU5mHOTJ0s0DX+fxibqyb96AzSter4Q==
X-Received: by 2002:adf:ea03:0:b0:21f:151e:780e with SMTP id
 q3-20020adfea03000000b0021f151e780emr9228512wrm.25.1659367096763; 
 Mon, 01 Aug 2022 08:18:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7CD+jmqLFTdLdFoaEGCeYOhayHo+uUEGsK0zaCWfH0H5Dwh4FurG3MWyM+NFtr+0DTi2WW0A==
X-Received: by 2002:adf:ea03:0:b0:21f:151e:780e with SMTP id
 q3-20020adfea03000000b0021f151e780emr9228501wrm.25.1659367096455; 
 Mon, 01 Aug 2022 08:18:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00?
 (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de.
 [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
 by smtp.gmail.com with ESMTPSA id
 c7-20020adffb07000000b0021e501519d3sm12211786wrr.67.2022.08.01.08.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Aug 2022 08:18:16 -0700 (PDT)
Message-ID: <2d0703da-ae89-7002-f500-300a4b5d206b@redhat.com>
Date: Mon, 1 Aug 2022 17:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/2] Create debugfs file with virtio balloon usage
 information
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel@openvz.org, linux-kernel@vger.kernel.org,
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

On 26.07.22 16:08, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host
> and how that memory is accounted.
> 
> It is useful when debugging out of memory conditions,
> as well for userspace processes that monitor the memory pressure
> and for nested virtualization.
> 
> Depending on the deflate on oom flag memory is accounted in two ways.
> If the flag is set the inflated pages are accounted as used memory.
> If the flag is not set the inflated pages are substracted from totalram.
> To make clear how are inflated pages accounted sign prefix the value.
> Where negative means substracted from totalram and positive means
> they are accounted as used.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> V2:
>   - fixed coding style
>   - removed pretty print
> V3:
>   - removed dublicate of features
>   - comment about balooned_pages more clear
>   - convert host pages to balloon pages
> V4:
>   - added a define for BALLOON_PAGE_SIZE to make things clear
> V5:
>   - Made the calculatons work properly for both ways of memory accounting
>     with or without deflate_on_oom
>   - dropped comment
> V6:
>   - reduced the file to minimum
>   - unify accounting
> 
> I didn't understand if you agree to change the accounting to be the same
> so following part 2 is about it.
> 
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f4c34a2a6b8e..97d3b29cb9f1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -10,6 +10,7 @@
>  #include <linux/virtio_balloon.h>
>  #include <linux/swap.h>
>  #include <linux/workqueue.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -731,6 +732,59 @@ static void report_free_page_func(struct work_struct *work)
>  	}
>  }
>  
> +/*
> + * DEBUGFS Interface
> + */
> +#ifdef CONFIG_DEBUG_FS
> +
> +/**
> + * virtio_balloon_debug_show - shows statistics of balloon operations.
> + * @f: pointer to the &struct seq_file.
> + * @offset: ignored.
> + *
> + * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
> + *
> + * Return: zero on success or an error code.
> + */
> +

Superfluous empty line. Personally, I'd just get rid of this
(comparatively obvious) documentation completely.

> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
> +{
> +	struct virtio_balloon *vb = f->private;
> +	s64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);

Rather call this "inflated_kb" then, it's no longer "pages".

> +
> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		num_pages = -num_pages;

With VIRTIO_BALLOON_F_DEFLATE_ON_OOM this will now always report "0".

which would be the same as "num_pages = 0;" and would deserve a comment
explaining why we don't indicate that as "inflated: ".

Thanks.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
