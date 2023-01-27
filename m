Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0A2C38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 10:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7690E82B53;
	Fri, 27 Jan 2023 10:38:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7690E82B53
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DbmmsFnm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FEqPefKdwHS0; Fri, 27 Jan 2023 10:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EE86782690;
	Fri, 27 Jan 2023 10:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE86782690
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9B67C0032;
	Fri, 27 Jan 2023 10:38:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDA6CC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6F2B41CD9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:38:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6F2B41CD9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DbmmsFnm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w5Pvfd2WJqqm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE4FD40897
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE4FD40897
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674815881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fk+ipPxiMp+7ND5JXMDPhtIXGWCz80q2gfmOrGgnSTs=;
 b=DbmmsFnmd8mvZ3giwtJqfoBC0GY0PG/tTT7ANn9QtOqlsqhnd0jatJe52GX1sKfqr3JSFn
 lr7ww9EfUtoCpntLdxaMozG5PWpCPxjEf+NTGOyFyMcDL55bcEn5YrJHOZKX3WKIjXkXvo
 W+p5fNQs5grLwx9lqI39shiTtjnUBMg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-YmGX3fzMNbyrxyicwlUfPw-1; Fri, 27 Jan 2023 05:38:00 -0500
X-MC-Unique: YmGX3fzMNbyrxyicwlUfPw-1
Received: by mail-ed1-f69.google.com with SMTP id
 s3-20020a50ab03000000b0049ec3a108beso3310211edc.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 02:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fk+ipPxiMp+7ND5JXMDPhtIXGWCz80q2gfmOrGgnSTs=;
 b=JJyCO7jyLfHz2c0ErwqtnSZY8Oyh36N28TIdrXr4PrXoNkT5bNPoFu1bVr6XlPaYXb
 b4iXB/n/fhjOTDwov94SL7ykwJiQcQO2xggmUwh6idrqrD+qrqbpDOCFOOQcgPyLyyv4
 07Coi1ue4VxotgmVAKsmgjqpN1Dqm7wB7LWqS+6GFVTcEzvlhP/nn200ROvC3w961cFj
 I2w0bOjIXzNJt9JY7IYTnX5g/HX9GvEh2TQIixaZwsf9JdgpAgigL+looCjCwV5iARP9
 Xy7U8WKc7n9F05mijNmowi9Gb2NfmrwLcyC8NAZ2CbRzxiZE++3olr9jnPs3pBVJk10/
 7pfg==
X-Gm-Message-State: AFqh2kqM1HNKgjeZe6arCe5xMLXMg8YlGLmAHyjrRX1QuurolP3YLfuf
 KoFlgoa38By44rsr695FTUTFeqSd05bitJwh/9OufRFuZFr5WXWngWIN3koq9AJOaKBdpOAla2F
 oprDzbamx2TVD3SG0dIGr4baWl51vBGo5S/KkkKKo8g==
X-Received: by 2002:a05:6402:27d3:b0:499:b3db:6aa3 with SMTP id
 c19-20020a05640227d300b00499b3db6aa3mr51028704ede.1.1674815879204; 
 Fri, 27 Jan 2023 02:37:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuCkhc1dIvkqg7CLSpA28ZBiD86VH7jdYHoje2OT9EaPm8dwEocuWCHOEbV3Rx+p6Me5lkY1Q==
X-Received: by 2002:a05:6402:27d3:b0:499:b3db:6aa3 with SMTP id
 c19-20020a05640227d300b00499b3db6aa3mr51028689ede.1.1674815878988; 
 Fri, 27 Jan 2023 02:37:58 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 k20-20020a508ad4000000b004873927780bsm751419edk.20.2023.01.27.02.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 02:37:58 -0800 (PST)
Date: Fri, 27 Jan 2023 05:37:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tanmay Bhushan <007047221b@gmail.com>
Subject: Re: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
Message-ID: <20230127053731-mutt-send-email-mst@kernel.org>
References: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
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

On Tue, Dec 27, 2022 at 10:15:25PM +0100, Tanmay Bhushan wrote:
> >From 7eae04667ddaac8baa4812d48ef2c942cedef946 Mon Sep 17 00:00:00 2001
> From: Tanmay Bhushan <007047221b@gmail.com>
> Date: Tue, 27 Dec 2022 22:02:16 +0100
> Subject: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
> 
> ifcvf_mgmt_dev leaks memory if it is not freed before
> returning. Call is made to correct return statement
> so memory does not leak. ifcvf_init_hw does not take
> care of this so it is needed to do it here.
> 
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
> b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f9c0044c6442..44b29289aa19 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -849,7 +849,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)

BTW your patch was mangled but I fixed it.

>  	ret = ifcvf_init_hw(vf, pdev);
>  	if (ret) {
>  		IFCVF_ERR(pdev, "Failed to init IFCVF hw\n");
> -		return ret;
> +		goto err;
>  	}
>  
>  	for (i = 0; i < vf->nr_vring; i++)
> -- 
> 2.34.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
