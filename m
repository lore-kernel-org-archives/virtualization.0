Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD08EB64DC
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 23:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B22AC41835;
	Thu,  6 Jul 2023 23:26:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B22AC41835
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XOsOwJYX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OTDkOR6N0zY9; Thu,  6 Jul 2023 23:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EA28B41847;
	Thu,  6 Jul 2023 23:26:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA28B41847
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88DEAC0072;
	Thu,  6 Jul 2023 23:26:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41742C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 23:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 226D161122
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 23:26:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 226D161122
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XOsOwJYX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tkkoHEd6kODM
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 23:26:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F6A26110B
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F6A26110B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 23:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=bDdj2ImLWq3orRh5mZ0i6CkrMO5thDbEKJP5vNXEszQ=; b=XOsOwJYXZVQ33w6XPomj04Renh
 yQFciK3I0zE9Zpzkq3abJrhB3iswgOvCHPxvjEYm27D9reaX9t91tKrcQRzF3ZEIg3mauARWtTTAq
 mkDRH/+DHf7c/IQjBIpMU4PFnWC9fZf/Mk4YhC1PQFDfKPMfiEuFAFgfkEk5RJRjPiB+/vzjoackT
 XUOGbqWSIFLQ12Va6M8GH4/uO7EvdbsNRrkafyM8Gy0Ocy6f6sDkMdBgAAnpJEndbyuC8i6sdMtKm
 oesPnV5GC8cZptTn4JM6aXCMsystUzju5zYlp/j7FmgU2bYHuhRANZ4BtXwvBvgDrM42R/4mR1FSe
 7OmlOTMw==;
Received: from [2601:1c2:980:9ec0::2764]
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qHYMh-002xMC-1W; Thu, 06 Jul 2023 23:26:23 +0000
Message-ID: <d785aec5-10b5-cc75-904c-cafdc194a8f0@infradead.org>
Date: Thu, 6 Jul 2023 16:26:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH virtio] pds_vdpa: protect Makefile from unconfigured
 debugfs
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, jasowang@redhat.com,
 mst@redhat.com, virtualization@lists.linux-foundation.org,
 brett.creeley@amd.com
References: <20230706231718.54198-1-shannon.nelson@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230706231718.54198-1-shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, drivers@pensando.io, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
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



On 7/6/23 16:17, Shannon Nelson wrote:
> debugfs.h protects itself from an undefined DEBUG_FS, so it is
> not necessary to check it in the driver code or the Makefile.
> The driver code had been updated for this, but the Makefile had
> missed the update.
> 
> Link: https://lore.kernel.org/linux-next/fec68c3c-8249-7af4-5390-0495386a76f9@infradead.org/
> Fixes: a16291b5bcbb ("pds_vdpa: Add new vDPA driver for AMD/Pensando DSC")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/vdpa/pds/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/pds/Makefile b/drivers/vdpa/pds/Makefile
> index 2e22418e3ab3..c2d314d4614d 100644
> --- a/drivers/vdpa/pds/Makefile
> +++ b/drivers/vdpa/pds/Makefile
> @@ -5,6 +5,5 @@ obj-$(CONFIG_PDS_VDPA) := pds_vdpa.o
>  
>  pds_vdpa-y := aux_drv.o \
>  	      cmds.o \
> +	      debugfs.o \
>  	      vdpa_dev.o
> -
> -pds_vdpa-$(CONFIG_DEBUG_FS) += debugfs.o

-- 
~Randy
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
