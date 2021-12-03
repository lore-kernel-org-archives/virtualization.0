Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FABDC433EF
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 17:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C5DE60BA3;
	Fri,  3 Dec 2021 17:05:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XITPGPlYL4ea; Fri,  3 Dec 2021 17:05:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E253A60B86;
	Fri,  3 Dec 2021 17:05:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6C32C006E;
	Fri,  3 Dec 2021 17:05:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C97F9C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 17:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF63E40263
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 17:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eULN5Eg2rCod
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 17:05:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78CC240157
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 17:05:26 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 x19-20020a9d7053000000b0055c8b39420bso4152049otj.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Dec 2021 09:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=utEWWJWCkIkBpnfbd0GlEWSSdXyFrxBmwVjIY7e8ZOk=;
 b=QOgYXXrH89NVmvg1JknUCwAtXYQETcJIXfkETH/lKpXH48TIx/5VkG+X3WHOPrZD7J
 YMXS5X8IPUoK+ZoJXdX6FJ1gG8XI7/6JTwTjFEUV5mj84ArSl0230nhlqpAoDsyg3PZ8
 n4ez55Vw9+6xol6gNhLvhcCcapGhtIIXrY8TLOfHmabllUmhxXD5qOWS4yBLz9TpoOtp
 VLUJMmujA3VIPU94tGNlYDU7VQzbivSNt8r7xSmsEGSatvubYDMAKu97XXFkso4nakYO
 1aoAR2efqZkU70eYrP6sjpuOXei7gdaPMmkRI59vPCW8CxABmwh5lFSQ1M99hVOpQSJB
 XREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=utEWWJWCkIkBpnfbd0GlEWSSdXyFrxBmwVjIY7e8ZOk=;
 b=eDK6jE8qoeml9Kpx71jcyQ49QPjIPmA7F1U/3/Wp1zg4VskISknNYsnOJ7xAy8kKIr
 16tbIrSjqVkIdt2KOvxWO4cT/IedW3TRO56lBNmUtT5SOOi7XkcSAE/gJH3+zT3ZXizW
 lcetepTFBsFpk7rNecUsH7D2TjJr+PD77llUYvHUKPPc9q9MU+Vm+DTbgTlkmjL5Qcaf
 YW2WunZm0cSUWpQ9ThjucXMZedWWvGybRfqUl3vSg2mr25Wg89XECEJBUOxNzBtSfD27
 ++WfEGVKVhosooYXcWJUFcFqh4TipvNO5f9lEmbM70L5MKlTvC/aeduRbzxAuLXX/VV/
 doHw==
X-Gm-Message-State: AOAM532qZkTGLzWp8AO648vzV8vYxrsFiN+bPGEX5ZJ2ogRfr1cw4FcG
 +KZI3kYNm9bETVfFRWO54Q8=
X-Google-Smtp-Source: ABdhPJxTQr22OYqI+8MVVWX2lPRrsqqfuOBij7hFh8aXcoar0mz8cpSccgVfGj2Djx64YxbporFoXA==
X-Received: by 2002:a05:6830:1e97:: with SMTP id
 n23mr16892839otr.4.1638551125619; 
 Fri, 03 Dec 2021 09:05:25 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
 by smtp.googlemail.com with ESMTPSA id o6sm704286oou.41.2021.12.03.09.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 09:05:25 -0800 (PST)
Message-ID: <3cbabdb5-8c45-68e0-e60e-7bf16fe19f54@gmail.com>
Date: Fri, 3 Dec 2021 10:05:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [iproute2-next 3/4] vdpa: Enable user to set mac address of vdpa
 device
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, stephen@networkplumber.org,
 netdev@vger.kernel.org
References: <20211202042239.2454-1-parav@nvidia.com>
 <20211202042239.2454-4-parav@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20211202042239.2454-4-parav@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
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

On 12/1/21 9:22 PM, Parav Pandit wrote:
> @@ -233,6 +254,15 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
>  
>  			NEXT_ARG_FWD();
>  			o_found |= VDPA_OPT_VDEV_MGMTDEV_HANDLE;
> +		} else if ((matches(*argv, "mac")  == 0) &&

use strcmp; we are not taking any more uses of matches() for parameters.


> +			   (o_all & VDPA_OPT_VDEV_MAC)) {
> +			NEXT_ARG_FWD();
> +			err = vdpa_argv_mac(vdpa, argc, argv, opts->mac);
> +			if (err)
> +				return err;
> +
> +			NEXT_ARG_FWD();
> +			o_found |= VDPA_OPT_VDEV_MAC;
>  		} else {
>  			fprintf(stderr, "Unknown option \"%s\"\n", *argv);
>  			return -EINVAL;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
