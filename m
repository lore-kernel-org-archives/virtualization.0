Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7153BC61DA4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 08:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E377861186;
	Thu,  9 Mar 2023 08:31:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E377861186
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gGnIoi6h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LwW4wLv_oghh; Thu,  9 Mar 2023 08:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6288E60E3F;
	Thu,  9 Mar 2023 08:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6288E60E3F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4327CC0035;
	Thu,  9 Mar 2023 08:31:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B12DC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E0E6402CE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:31:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E0E6402CE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gGnIoi6h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mPv-ntHkrfkH
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:31:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D8EC40111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D8EC40111
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678350699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G4DxzMWFw5jGE1+NNVtKuCD9/BZ7uSP6hGTNxIYyrI0=;
 b=gGnIoi6hM6iBb9zeqGoHCc3GZNS73QsR1fmmJft9fbizgOqzNJg8elhmbZ3UXxJoTVoQK6
 GDJjK3meeuCsf3MlLtFJM+nPxdBSqZ1YK5XawY/dv3swbrAmLNZN1ntVTjY99gBfTZZQF8
 ch9DL5IrxQT2OFVJ1QZi6akmVZnFOFs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-WDRwkrXOPTqaNGKHgz10tw-1; Thu, 09 Mar 2023 03:31:38 -0500
X-MC-Unique: WDRwkrXOPTqaNGKHgz10tw-1
Received: by mail-qk1-f199.google.com with SMTP id
 d4-20020a05620a166400b00742859d0d4fso799782qko.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 00:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678350698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4DxzMWFw5jGE1+NNVtKuCD9/BZ7uSP6hGTNxIYyrI0=;
 b=mWCRt90zQKmcDg6jUd4YZ322n9tLRgeDjanahpSspDgxE8nM9c07SCgBQ0528J4RiP
 aN8vJ4LOUto6NaqAIRpEgMhndjyyUNDPWqPsfgohfF2vpMsdtE6fMXCEh+qym35V+zmI
 mrFKfQXbUv0yQMViSJv2FccN3fB8JkN+PlgUjVHE08AsLhcyMfNcxK0bkxeQfldSr3T9
 hqE9BrdU60NjDWxDQtM/lLFcT7Q7rIeLVHYnuiQkIQ3+Jsv/+ylOqMq2YbxVGUpW4xuN
 +mZDIpMC5YoOdJGTHGdSJGumhdSoWY8rb/3BbldCOJvZP372Jhczd8c+brGW23SPglgf
 8aUQ==
X-Gm-Message-State: AO0yUKVS33l1KnHI+mJjnv7I/BDaUQfy3xcE3CIqafhJYN8O5ad9UiYN
 Sstf5P9HPRzicA1QhDx3Po1NfOO/1sS0sohXhXn1TDRIYT+GDLOirTN1HO2C6Pk9N+xNhcl+tFy
 4wzDrhrpgmP782g/H5H84YsTlcBo9jYwoopCT8IWRcw==
X-Received: by 2002:a05:622a:54c:b0:3bf:d9d2:484f with SMTP id
 m12-20020a05622a054c00b003bfd9d2484fmr35189151qtx.11.1678350698223; 
 Thu, 09 Mar 2023 00:31:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+lOQQ30IfqLTp3od+p+eKiTOPO28RD1XBMQ8cVo6/e0bR73jy7mpBYd6WWU+y5fBzb1/Ok4A==
X-Received: by 2002:a05:622a:54c:b0:3bf:d9d2:484f with SMTP id
 m12-20020a05622a054c00b003bfd9d2484fmr35189140qtx.11.1678350697996; 
 Thu, 09 Mar 2023 00:31:37 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 y9-20020ac87089000000b003bfaae103f6sm13229024qto.89.2023.03.09.00.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 00:31:37 -0800 (PST)
Date: Thu, 9 Mar 2023 09:31:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH] tools/virtio: virtio_test -h,--help should return directly
Message-ID: <20230309083133.zfebcl67k35b7rkt@sgarzare-redhat>
References: <tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>, Rong Tao <rongtao@cestc.cn>,
 mst@redhat.com
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

On Thu, Mar 09, 2023 at 02:13:13PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>When we get help information, we should return directly, and we should not
>execute test cases. Move the exit() directly into the help() function and
>remove it from case '?'.
>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
> tools/virtio/virtio_test.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>index 120062f94590..6e348fbdc5d8 100644
>--- a/tools/virtio/virtio_test.c
>+++ b/tools/virtio/virtio_test.c
>@@ -337,6 +337,8 @@ static void help(void)
> 		" [--batch=random/N]"
> 		" [--reset=N]"
> 		"\n");
>+
>+	exit(0);

Please exit with a value different from 0 (e.g. 2).

> }
>
> int main(int argc, char **argv)
>@@ -354,14 +356,12 @@ int main(int argc, char **argv)
> 		case -1:
> 			goto done;
> 		case '?':
>-			help();
> 			exit(2);

Sorry, I meant the opposite, remove exit(2) and leave help().

Thanks,
Stefano

> 		case 'e':
> 			features &= ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
> 			break;
> 		case 'h':
> 			help();
>-			goto done;
> 		case 'i':
> 			features &= ~(1ULL << VIRTIO_RING_F_INDIRECT_DESC);
> 			break;
>-- 
>2.39.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
