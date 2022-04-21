Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B12C4332F
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 13:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F9A7410CA;
	Thu, 21 Apr 2022 13:51:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pOp2sNVp3-Ve; Thu, 21 Apr 2022 13:51:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 76E684148A;
	Thu, 21 Apr 2022 13:51:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 543BAC0033;
	Thu, 21 Apr 2022 13:51:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 747FAC002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 13:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53F2D405DB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 13:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kpg5tIQIiVx9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 13:51:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F717400E4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650549065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9X5WXrysF88Ouj/slnEAN9ILrlD7gwjjZO9fEL4BbEQ=;
 b=GTSRfaAYaznYDSI/X9hE5BSC/oHMz9Mb02073TIcuR9Kk+ZHZ396fbTW+h1qW+BXJE+h1+
 QOk7JvSD0z0aLKEq1lvlJhq+9dzHjMoyGNHlkAru5thKNOL8YzOOKQJtHeqaqc4deDRwjs
 ogyr/tkr6PWKMoqyeHWbe6FRgYFYTyY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-U7hW-1OfN5KYb2PoCd_n9w-1; Thu, 21 Apr 2022 09:51:03 -0400
X-MC-Unique: U7hW-1OfN5KYb2PoCd_n9w-1
Received: by mail-ed1-f72.google.com with SMTP id
 b24-20020a50e798000000b0041631767675so3263538edn.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 06:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9X5WXrysF88Ouj/slnEAN9ILrlD7gwjjZO9fEL4BbEQ=;
 b=ey6aHBomyG/BuJVXCXg9eUl5SyHTwwU4W2R4p0/5JkyuyIYTnXYviSaVmKHUpL6KPI
 FgX7OaLU5BmapBl4GEpV+foNCf7Mt1tZHyqCuo05/+NFuQiGf6YbHgwigay13Z2k2a/l
 ZmQoLK8SjTvhZKlckAW+CFG9uJSRV37VnvpioguCpAxwzS9LuEWPsIJFEWKbrnmG10Jr
 qBjSCznbWEMQvl7rJMkiqps0Q7IM6PkY4gDY7UHAOSkS+ngmCQxzQjXy0Wa7sworOqUu
 tToCno24oD4PYyOHeic15GqGw9hdplwzxZs4JUUGQLd6+4rPHdLrrHunfLPmSitIIMM9
 H3ug==
X-Gm-Message-State: AOAM532nDLTQQdGREEP+33aHFN/0Xeuvrr1myVB94edg5B+F5vKyfOtn
 bej4Bb3wi7omHDvwSpc3EfTvPqFYdXRlktCLTtJGiiysTpEdA4kgehJdKGtHC8gLSazxWzmuEoE
 34vx0GNeHa1jWOEcfAjplLGO8vhhIKFTNboTZYolVaQ==
X-Received: by 2002:a05:6402:26cd:b0:423:b43d:8b09 with SMTP id
 x13-20020a05640226cd00b00423b43d8b09mr28005751edd.400.1650549062689; 
 Thu, 21 Apr 2022 06:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTS+Y4ILLrJT3QP2BpwpnOM5BPXge8ufksj1+vy8uCme6m2CyXJ309d3wnCuvShf6eaPoQKg==
X-Received: by 2002:a05:6402:26cd:b0:423:b43d:8b09 with SMTP id
 x13-20020a05640226cd00b00423b43d8b09mr28005722edd.400.1650549062455; 
 Thu, 21 Apr 2022 06:51:02 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.75.76])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a170906174700b006e80a7e3111sm8096281eje.17.2022.04.21.06.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 06:51:01 -0700 (PDT)
Date: Thu, 21 Apr 2022 15:50:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: Re: [PATCH 1/5] hv_sock: Check hv_pkt_iter_first_raw()'s return value
Message-ID: <20220421135057.57whrntjdv25jqpl@sgarzare-redhat>
References: <20220420200720.434717-1-parri.andrea@gmail.com>
 <20220420200720.434717-2-parri.andrea@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220420200720.434717-2-parri.andrea@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Wei Liu <wei.liu@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, netdev@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
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

On Wed, Apr 20, 2022 at 10:07:16PM +0200, Andrea Parri (Microsoft) wrote:
>The function returns NULL if the ring buffer doesn't contain enough
>readable bytes to constitute a packet descriptor.  The ring buffer's
>write_index is in memory which is shared with the Hyper-V host, an
>erroneous or malicious host could thus change its value and overturn
>the result of hvs_stream_has_data().
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>---
> net/vmw_vsock/hyperv_transport.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index e111e13b66604..943352530936e 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -603,6 +603,8 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
>
> 	if (need_refill) {
> 		hvs->recv_desc = hv_pkt_iter_first_raw(hvs->chan);
>+		if (!hvs->recv_desc)
>+			return -ENOBUFS;
> 		ret = hvs_update_recv_data(hvs);
> 		if (ret)
> 			return ret;
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
