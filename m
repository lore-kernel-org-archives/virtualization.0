Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C11C4320A
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 20:11:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2042960EFF
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 20:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2042960EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D12E0608A9;
	Mon,  2 Aug 2021 20:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oc7CzcK49Ukl; Mon,  2 Aug 2021 20:11:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7D56B608FA;
	Mon,  2 Aug 2021 20:10:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5511FC001A;
	Mon,  2 Aug 2021 20:10:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA28FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9F6083A41
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zPN2f-XYgFlA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:10:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31BB783976
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627935055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LA8evM7BHjBr4jABvi1M9utaaAjmimAJTMztodEqWno=;
 b=Sdbwc2nyDANJY1mFTAktqUhIeYe1Hs7Q9uW6bdmTOawW+OsHzwxayFV7TqtNuUqjreizyr
 j5JSnYuDyIG8hmLLiH6bWL9w4EvJjicSw4UpSNJxrIfxK+EzjzDXCRTBlca2ypY62nWf5h
 CsDI2jPkmvvVZ2z/by52UsefAJR7tZU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-3lvx6VZ7PEaazGUy7U2Ecg-1; Mon, 02 Aug 2021 16:10:54 -0400
X-MC-Unique: 3lvx6VZ7PEaazGUy7U2Ecg-1
Received: by mail-ej1-f70.google.com with SMTP id
 lu19-20020a170906fad3b029058768348f55so5145341ejb.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 13:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LA8evM7BHjBr4jABvi1M9utaaAjmimAJTMztodEqWno=;
 b=kiO0FONsfSWIc1GrZMAk8/MFpkovfuoJBDNJN2tEs5bkMhYfIuOIlwXt9kMc0z5dG9
 QKGgbyG5Xh9bm9gtwVsL7V3loGJU/G2gQE/oadbO7NyNogVsSdVM/ROYr5HL3zgLfVJE
 qIn/HfyCXlRQWHMBTVXpfM+vSC2fOIurnDFN7vYIiHsHgucA2FSrpi4Ak/hTuwBIgv3h
 zfxNk3LNXIsIqnvSQQd8KYyyb9ucv0wvqxCoLyzY2ZTYVon4oElcVpNWFTuja9VKjZ4z
 mqFcWxXx8z1TUXzBenGGFybnXScLHpXnbACqXCPJB2fNCFLrJ5mkriFtBHAkw5ACZq3P
 8HPg==
X-Gm-Message-State: AOAM532Lo6UTK7sXB3YtUby4WTC7Oh82rjpAvfLZnCijDVc7bY6ABq1I
 r+I55lAijtAQhK2/BcMoH1s82dmu2BXQUHUul2wAMCdB5D3kTSNYTQDw6D/myNEilCzG3pj5cAT
 m7QtaVZDrTVXd/OVnPX5qvN0pBOHTH6TNmjXbhB3Acg==
X-Received: by 2002:a17:906:4b18:: with SMTP id
 y24mr16671489eju.42.1627935053630; 
 Mon, 02 Aug 2021 13:10:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQDGepqRHg1s0zF2qekNjn1VPDNh8LoMDbONxjezTZrGQTTG2YxoZ166f6S0JBTqWT6JZH/A==
X-Received: by 2002:a17:906:4b18:: with SMTP id
 y24mr16671470eju.42.1627935053501; 
 Mon, 02 Aug 2021 13:10:53 -0700 (PDT)
Received: from redhat.com ([2.55.140.205])
 by smtp.gmail.com with ESMTPSA id g8sm6748637edw.89.2021.08.02.13.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 13:10:52 -0700 (PDT)
Date: Mon, 2 Aug 2021 16:10:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: fuguancheng <fuguancheng@bytedance.com>
Subject: Re: [PATCH 1/4] VSOCK DRIVER: Add multi-cid support for guest
Message-ID: <20210802160815-mutt-send-email-mst@kernel.org>
References: <20210802120720.547894-1-fuguancheng@bytedance.com>
 <20210802120720.547894-2-fuguancheng@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210802120720.547894-2-fuguancheng@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andraprs@amazon.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, colin.king@canonical.com, kuba@kernel.org,
 arseny.krasnov@kaspersky.com, davem@davemloft.net
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

On Mon, Aug 02, 2021 at 08:07:17PM +0800, fuguancheng wrote:
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c998860d7bbc..a3ea99f6fc7f 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -17,6 +17,13 @@
>  
>  #define VHOST_FILE_UNBIND -1
>  
> +/* structs used for hypervisors to send cid info. */
> +
> +struct multi_cid_message {
> +	u32 number_cid;
> +	u64 *cid;
> +};
> +
>  /* ioctls */
>  
>  #define VHOST_VIRTIO 0xAF


In this case, a kernel pointer in a UAPI struct is suspicious.
So is padding after number_cid.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
