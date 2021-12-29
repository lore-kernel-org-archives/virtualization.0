Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C522C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Dec 2021 14:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15D62607B5;
	Wed, 29 Dec 2021 14:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LdPsX_J2pSwV; Wed, 29 Dec 2021 14:06:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B742600B9;
	Wed, 29 Dec 2021 14:06:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6651CC002F;
	Wed, 29 Dec 2021 14:06:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86068C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Dec 2021 14:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 711C44011B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Dec 2021 14:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZqbH_v2zVn_I
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Dec 2021 14:06:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AF34400E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Dec 2021 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640786793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aO/4Yp6T43XLmNMDQP+OwTqaYv7whlIlyBDq4dbPFsg=;
 b=H4uN9kuFYKp06DXETLs651CfCfMow5IxU1wso1WjUjemw+q+GszkuqbBaRHdFqRJfqqWGr
 MI2bpyBE0SmetWDmhcD93tlcZfxtVftbYE6NOfcNysHSFFWCWS9Wek9upKsTV+L2xR0Wos
 ZyHDbWLh2sVqDfFTa5QcqlrWVLJd6rs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-prSZEUTmORmVlaL5isOMdQ-1; Wed, 29 Dec 2021 09:06:32 -0500
X-MC-Unique: prSZEUTmORmVlaL5isOMdQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 de12-20020a05620a370c00b00467697ab8a7so12845383qkb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Dec 2021 06:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aO/4Yp6T43XLmNMDQP+OwTqaYv7whlIlyBDq4dbPFsg=;
 b=eC8hc+fMhB8rZuhei2usfrujZm+wN42qgnrx7anemUMNodKjxPay43UJX0hbWPyk8N
 fz6IbYfKGwNm5MWxgUeyzZBvfJ5C1wkPUAXUWpILtO1sF3LLnGE150la0PHLWLxp8c+2
 VJfafAedHWJH/YQopkKBy6wddcEn4fSIDbqrKyysfuWj3Dgsprj+vVoK5Rd18gECNr4x
 cl3LGH3bGN4Li8ZUE1sDS07GRxN0U8o+c6IlaMa6QUyGOpxr8Qyd78onFwgl7CFMvp7q
 Ypbe00XlDEh5hoPqHLhsFjkRO4jO6X9WUiHrA8Y0quGt6r7vXi0SfyeXZtgwk6/n7Lck
 Rgww==
X-Gm-Message-State: AOAM532jW/NgRaIosf8wwdULEbVRuWocRkuD+NOAJRYv+qKCDICaj2OF
 PjJFuAX85/gNUck9LKx54HhBGu3IEAfM9y/iQwG0V1g5UcyrlX5KhjsH0dwm6jaDMXp3dbu7Mze
 +WLdmzAQ2ssQGwTB6mDGB9z1s2Em10MsDnpcRvjkNkg==
X-Received: by 2002:a05:620a:4003:: with SMTP id
 h3mr18549163qko.153.1640786790511; 
 Wed, 29 Dec 2021 06:06:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyimHrQiLRtzxiuwvtJVztliA6HApJnsXsaqWdLb9ltPripN76oNC87N68Zld9IushfHCBQfg==
X-Received: by 2002:a05:620a:4003:: with SMTP id
 h3mr18549076qko.153.1640786790152; 
 Wed, 29 Dec 2021 06:06:30 -0800 (PST)
Received: from steredhat (host-87-10-236-9.retail.telecomitalia.it.
 [87.10.236.9])
 by smtp.gmail.com with ESMTPSA id h2sm18124352qkn.136.2021.12.29.06.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Dec 2021 06:06:29 -0800 (PST)
Date: Wed, 29 Dec 2021 15:05:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf-next v2] net: don't include filter.h from net/sock.h
Message-ID: <20211229140557.cuap5jjqz47yevda@steredhat>
References: <20211229004913.513372-1-kuba@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wintera@linux.ibm.com, andrew@lunn.ch, mustafa.ismail@intel.com,
 pablo@netfilter.org, ast@kernel.org, andrii@kernel.org,
 george.mccollister@gmail.com, anthony.l.nguyen@intel.com, ralf@linux-mips.org,
 linux-hams@vger.kernel.org, hawk@kernel.org, steffen.klassert@secunet.com,
 linux-s390@vger.kernel.org, pkshih@realtek.com, f.fainelli@gmail.com,
 herbert@gondor.apana.org.au, daniel@iogearbox.net,
 linux-bluetooth@vger.kernel.org, linux-rdma@vger.kernel.org,
 bridge@lists.linux-foundation.org, john.fastabend@gmail.com,
 kadlec@netfilter.org, jgg@ziepe.ca, dledford@redhat.com,
 coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, nikolay@nvidia.com,
 linux-wireless@vger.kernel.org, habetsm.xilinx@gmail.com, yzaikin@google.com,
 vivien.didelot@gmail.com, wg@grandegger.com, ath11k@lists.infradead.org,
 woojung.huh@microchip.com, johan.hedberg@gmail.com, arnd@arndb.de,
 marcel@holtmann.org, jhs@mojatatu.com, linux-can@vger.kernel.org,
 wenjia@linux.ibm.com, Marc Kleine-Budde <mkl@pengutronix.de>,
 viro@zeniv.linux.org.uk, luiz.dentz@gmail.com, jiri@nvidia.com,
 xiyou.wangcong@gmail.com, michael.chan@broadcom.com,
 virtualization@lists.linux-foundation.org, shiraz.saleem@intel.com,
 trond.myklebust@hammerspace.com, kvalo@codeaurora.org,
 linux-nfs@vger.kernel.org, leon@kernel.org, keescook@chromium.org,
 netdev@vger.kernel.org, dsahern@kernel.org,
 linux-decnet-user@lists.sourceforge.net, fw@strlen.de, tariqt@nvidia.com,
 kgraul@linux.ibm.com, ecree.xilinx@gmail.com, mcgrof@kernel.org,
 netfilter-devel@vger.kernel.org, jreuter@yaina.de,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, olteanv@gmail.com,
 saeedm@nvidia.com, anna.schumaker@netapp.com, ap420073@gmail.com
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

On Tue, Dec 28, 2021 at 04:49:13PM -0800, Jakub Kicinski wrote:
>sock.h is pretty heavily used (5k objects rebuilt on x86 after
>it's touched). We can drop the include of filter.h from it and
>add a forward declaration of struct sk_filter instead.
>This decreases the number of rebuilt objects when bpf.h
>is touched from ~5k to ~1k.
>
>There's a lot of missing includes this was masking. Primarily
>in networking tho, this time.
>
>Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>v2: https://lore.kernel.org/all/20211228192519.386913-1-kuba@kernel.org/
> - fix build in bond on ia64
> - fix build in ip6_fib with randconfig

For AF_VSOCK:
Acked-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
