Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E104C433E0
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 08:00:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D5022CA1
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 08:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVctKqeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D5022CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 245CB87804;
	Tue,  4 Aug 2020 08:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mfRhdWQMLowH; Tue,  4 Aug 2020 08:00:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3F88E873CE;
	Tue,  4 Aug 2020 08:00:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35B91C0050;
	Tue,  4 Aug 2020 08:00:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C0DAC004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3E43E874DA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:00:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nDQFZxQOHtVh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:00:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E059B860CE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:00:49 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id d6so27554936ejr.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Aug 2020 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ka4ursZWzHeHcUfmCrEOqwNJhgydKg059CXG4PMpUJs=;
 b=GVctKqeEnzKv6JRsSZhMZ2HE6w6h79tHOaCY1SYi03CdT4HFUPh3sdxTNEKwQLRLLD
 faOVMHGokNejpY9ge0Bi83TyNLyLghDLHPAWPCeEjDauGZkzDNJRp3919MugXe4nW11X
 rLA0SN4Uc8b825rKOKODkOUWijYRgih9cnG4PkXHSeVhAtPG/gq/udGOn3xJcVs2YblA
 9EFZsHbANwiYMpQfwPXYTYdwHQZHaOwcwWShTp3sAbnUUjG/vIlWYeweONtTtTDELaE+
 vhd8VIhCfQec0Qoz+9YcFoMNsigWfuSPeESXwOOYdEYrQo0DkJPMn5SzcO9lEe/5NsA7
 XQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ka4ursZWzHeHcUfmCrEOqwNJhgydKg059CXG4PMpUJs=;
 b=Wrs3JcUpRcqSuCTEA5Wuap/Smi4LZMellPnqRi/Bkch20DyruHl3vuu67+XTOXc/qW
 dNokJnkdSRIgpObJcf7+dl/LntMnLb/rp6A4mnzzdq6VsUEypqzArq5jkPb2zJht1UVO
 c/RtEtVjKsfLt/0gUOjoXluvbYxKjn+XzPpcYI21A96RBVXrDRmZp98M5cZothjFMjkp
 1NbQqu8IblHh76WyNKYF4VaX/HCizBvINmdTY/0Q270vQc5rwyPJKW10mRrBcvoXn+pk
 jjvuoyRh3Evp2hWR/OvAajKdKJKZr75Y+IEfNjBjw4UM/LSiRinO6YoZ5Iypu09zYj/p
 j/dA==
X-Gm-Message-State: AOAM531pb6Qsgc1NZvx0QOqoAWR++6umuVwpcJ0RE24tvQbjt8r7nNgC
 7AMOwMIjpdjGNq2bDxfnAM7l9A==
X-Google-Smtp-Source: ABdhPJxrlGJh09BGvoR0QWYGdbnyOOjs0CW/dihPJP8QgqlGuW4JhFWaUSVZDKlIm9nZikFhSK1kww==
X-Received: by 2002:a17:906:990c:: with SMTP id
 zl12mr19610454ejb.488.1596528048284; 
 Tue, 04 Aug 2020 01:00:48 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 32sm9260296edf.83.2020.08.04.01.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 01:00:47 -0700 (PDT)
Date: Tue, 4 Aug 2020 10:00:26 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 12/24] virtio_iommu: correct tags for config space
 fields
Message-ID: <20200804080026.GA284384@myrica>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-13-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-13-mst@redhat.com>
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

On Mon, Aug 03, 2020 at 04:59:27PM -0400, Michael S. Tsirkin wrote:
> Since this is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

And tested with the latest sparse

> ---
>  include/uapi/linux/virtio_iommu.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 48e3c29223b5..237e36a280cb 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -18,24 +18,24 @@
>  #define VIRTIO_IOMMU_F_MMIO			5
>  
>  struct virtio_iommu_range_64 {
> -	__u64					start;
> -	__u64					end;
> +	__le64					start;
> +	__le64					end;
>  };
>  
>  struct virtio_iommu_range_32 {
> -	__u32					start;
> -	__u32					end;
> +	__le32					start;
> +	__le32					end;
>  };
>  
>  struct virtio_iommu_config {
>  	/* Supported page sizes */
> -	__u64					page_size_mask;
> +	__le64					page_size_mask;
>  	/* Supported IOVA range */
>  	struct virtio_iommu_range_64		input_range;
>  	/* Max domain ID size */
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
> -	__u32					probe_size;
> +	__le32					probe_size;
>  };
>  
>  /* Request types */
> -- 
> MST
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
