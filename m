Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2421DC433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 08:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7E32408DA;
	Tue, 18 Jan 2022 08:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Ogt0DWhusDy; Tue, 18 Jan 2022 08:38:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 37BEC408DD;
	Tue, 18 Jan 2022 08:38:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFAD5C0039;
	Tue, 18 Jan 2022 08:38:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4E14C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D05560D6A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KBcpPyHAatFV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:38:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CB0860D69
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642495106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iRNkibkhXodBDsNyGIHnIIBvejLu1ysleOeboUpiz8=;
 b=WlBMqYc1KpILTp90N+y0Wq2TTujX1ypr5866y13OldqNjX+0GcGapdKzgUiPiQa/sJDYtE
 zrexMgBwudEcLjlhKdx3fa3pjEngxxlbIVLawAN1K1Xl+f+to4629+2GShxj6oz5m4iHqR
 q/uMvY0c+IBna7dM/0CyPj94TOorc1A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-TLHV4a6VPDWk2DyB3zBbUw-1; Tue, 18 Jan 2022 03:38:24 -0500
X-MC-Unique: TLHV4a6VPDWk2DyB3zBbUw-1
Received: by mail-ed1-f72.google.com with SMTP id
 s9-20020aa7d789000000b004021d03e2dfso6083423edq.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 00:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=0iRNkibkhXodBDsNyGIHnIIBvejLu1ysleOeboUpiz8=;
 b=mik/tXfIReCHCx2AUZylWHWI4lf4TL6BWjHUhAeOHPkaykWy4e2I60zUKXeqfyvIYp
 rxdO7DpRNm3SaBLqgoHdVbAkSeVr4gxBiZQy+joWAxomxEavBYr/l+A3vqgWMI02BKIJ
 1zU9BROoQ+xnf3yWdSva4scWNhSDVwKpUKbslHg2sRk7eO5YpgIRM5oe/utVVJJgUPLw
 tsvs50dR6YujCs2KwaHKyFcps+tmWJeuiFuuYmxO5+qWoTsz2znpsRhsC9iaP50U+res
 YAPWwB598+PG7tsZOwvEQucFwDY9GsyPNWqPAp2sy2euck+Qiem1bAjOHJ9xxPdO/6dR
 p9Uw==
X-Gm-Message-State: AOAM5324SSj7HftdpGe5Cjm+dvhaWNQbtxAtWyX8T4ojBXgWiD8Wr2hA
 vHs9jvWP+1Bwi+qZEa4cPcX1pws4nWIXoaU7UJ4gPrAOKb74d3ZKh47BkVaAGUM56zgAlGFVgE6
 lO8iBTHA0n+I1XJ5SRqvhQoWRLvZfpqBx7kzzBYyLeQ==
X-Received: by 2002:aa7:c79a:: with SMTP id n26mr18006539eds.350.1642495103231; 
 Tue, 18 Jan 2022 00:38:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGWfHNyyyhH1BL7uKc7knrncBIRd2dEONU5PVnA443woEu855mFoClmmk3extL/YzdtzxFOA==
X-Received: by 2002:aa7:c79a:: with SMTP id n26mr18006526eds.350.1642495103032; 
 Tue, 18 Jan 2022 00:38:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:2500:5b4d:fa8e:5311:1e28?
 (p200300cbc70c25005b4dfa8e53111e28.dip0.t-ipconnect.de.
 [2003:cb:c70c:2500:5b4d:fa8e:5311:1e28])
 by smtp.gmail.com with ESMTPSA id gv35sm1890371ejc.122.2022.01.18.00.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jan 2022 00:38:22 -0800 (PST)
Message-ID: <4fe8127e-6e24-64bd-c53b-bf4ffa15b4b4@redhat.com>
Date: Tue, 18 Jan 2022 09:38:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
To: Gavin Shan <gshan@redhat.com>, virtualization@lists.linux-foundation.org
References: <20220118013431.167347-1-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] drivers/virtio: Enable virtio mem for ARM64
In-Reply-To: <20220118013431.167347-1-gshan@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S . Tsirkin" <mst@redhat.com>, shan.gavin@gmail.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On 18.01.22 02:34, Gavin Shan wrote:
> This enables virtio-mem device support by allowing to enable the
> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
> architecture.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/virtio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 34f80b7a8a64..bf3f6ebdaa3b 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>  config VIRTIO_MEM
>  	tristate "Virtio mem driver"
>  	default m
> -	depends on X86_64
> +	depends on X86_64 || ARM64
>  	depends on VIRTIO
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE

With MEMBLOCK_DRIVER_MANAGED in place upstream, kexec should be fine.


Can you adjust/rephrase the comment as well? Like

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 34f80b7a8a64..88028ca01c8f 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -116,8 +116,9 @@ config VIRTIO_MEM
         This driver provides access to virtio-mem paravirtualized memory
         devices, allowing to hotplug and hotunplug memory.
 
-        This driver was only tested under x86-64, but should theoretically
-        work on all architectures that support memory hotplug and hotremove.
+        This driver was only tested under x86-64 and arm64, but should
+        theoretically work on all architectures that support memory hotplug and
+        hotremove.
 
         If unsure, say M.
 


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
