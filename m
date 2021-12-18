Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D88C433EF
	for <virtualization@archiver.kernel.org>; Sat, 18 Dec 2021 20:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57A134026F;
	Sat, 18 Dec 2021 20:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4AbX-FAJ6Kbt; Sat, 18 Dec 2021 20:53:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5FA240190;
	Sat, 18 Dec 2021 20:53:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B29DCC002F;
	Sat, 18 Dec 2021 20:53:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 846A0C0012
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 20:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7178160B31
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 20:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DFC1uIDEWnN5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 20:53:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FF1F60B2D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 20:53:05 +0000 (UTC)
Received: by mail-il1-x130.google.com with SMTP id s11so4465443ilt.13
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 12:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=D9CxRDuwaO90NwhAK/YCc4eVCem0FDVJQCMxRvIwU18=;
 b=PHo3EkosCS1Goy5mvbAZw1YeJmX28wLDrsT60u7SJSycSUJdvQpHxML7EZWzOJUxgs
 xrdI2lW3OJv7x73Qh1GmediVxMGXJG3dr2Y4ttb09lt/EbrWyoDcJhOL9x0oXARpY5DU
 d2xQjWat5QVZUD9aETgGkwAE6QwMuL+o/t6p2bCVlfdcCuN1AlKHMo2Sa3dGdNQy8N7G
 a4zOSxgNXO53E8Su56z1hz3OpukzXfDLu/iLh83Noh3T49bQ81ReHN+UdaNXlWL8eSG0
 xpz2KCXF64l+RzCWmchEko40rwKJODV15PTpE7hjgqtVx++Mu+1FsPO0GHdYKIJpPbuq
 4/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=D9CxRDuwaO90NwhAK/YCc4eVCem0FDVJQCMxRvIwU18=;
 b=oOXSmGEL3ux4BKJPfxsqf4U0QVR9vsn+JORzuskczEc15H7NG6iRkYhmHjmUG2xc02
 Wi7rXddVId8xbjz9TExtUy7m1LpSJlPiI/h8gKHmCkPu6LiBxd7wGyraaSbKtRlthONh
 BDnrpzu6Oauff+2SsG/1EAT7qN4y4abJGiTFBZbqNPCmUTo7U/nz4ncOJhGBta4jn+LX
 xQ7ByzXbPGKi1teJFgRmz/o5FJiMh5xldL+m7E1IsX3xrcUCBlUvsUIwXLGb2STa7Jyr
 NmHT6FhtKMmhEmoKoD9i1iU+EiGl7IvK/LTpeTTu1V3cpJVqtp2Rrnil+ZG+N2yCCKIl
 wpig==
X-Gm-Message-State: AOAM5310A4N+7s9OJIX9BEl1QbF1j0WQnK0utQyXnQpSSqwds8SzWXDy
 Bblb+PCVnIrG1KkbHghVGjc=
X-Google-Smtp-Source: ABdhPJxw/Xi25FdgBQAjQARai8EDFZ54aU8vWuKnGsbpVbuIbszpAmQaZ7OnJEHRiRhsPvKZBmmjbA==
X-Received: by 2002:a05:6e02:170e:: with SMTP id
 u14mr620316ill.111.1639860784719; 
 Sat, 18 Dec 2021 12:53:04 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
 by smtp.googlemail.com with ESMTPSA id a12sm7082127iow.6.2021.12.18.12.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Dec 2021 12:53:04 -0800 (PST)
Message-ID: <a38a9877-4b01-22b3-ac62-768265db0d5a@gmail.com>
Date: Sat, 18 Dec 2021 13:53:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [iproute2-next v2 4/4] vdpa: Enable user to set mtu of the vdpa
 device
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, stephen@networkplumber.org,
 netdev@vger.kernel.org
References: <20211217080827.266799-1-parav@nvidia.com>
 <20211217080827.266799-5-parav@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20211217080827.266799-5-parav@nvidia.com>
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

On 12/17/21 1:08 AM, Parav Pandit wrote:
> @@ -204,6 +217,8 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
>  	if (opts->present & VDPA_OPT_VDEV_MAC)
>  		mnl_attr_put(nlh, VDPA_ATTR_DEV_NET_CFG_MACADDR,
>  			     sizeof(opts->mac), opts->mac);
> +	if (opts->present & VDPA_OPT_VDEV_MTU)
> +		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MTU, opts->mtu);

Why limit the MTU to a u16? Eric for example is working on "Big TCP"
where IPv6 can work with Jumbograms where mtu can be > 64k.

https://datatracker.ietf.org/doc/html/rfc2675

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
