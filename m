Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC87C433EF
	for <virtualization@archiver.kernel.org>; Sat, 27 Nov 2021 17:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDA8D40340;
	Sat, 27 Nov 2021 17:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vc6Ij95KqRgl; Sat, 27 Nov 2021 17:09:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7AA9A402DC;
	Sat, 27 Nov 2021 17:09:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 558B4C0012;
	Sat, 27 Nov 2021 17:09:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C62E1C000A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B58AD402B7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63Ogaw3UBT5v
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:09:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1359C40290
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638032990;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRURtkQMrygkkpJa5/CnJXDZ5sDcZbWT4igezBUS9pQ=;
 b=FhlLh9TTl0kug+3h2TFFb6fVP/OmNCJtFmJjLeh/nX6/loPdfy/nFljhdfDf0dRDG8cMJ4
 UTVgHdKH3CWt43HV3ATRI/NnYQBIrhBt3U3NHAA8PAvh/popRGP3I92CQO5bjuhfUWigeY
 B80j7SF+QmsxzHoVeeIm+eaOjGZXElk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-B221F7jPOU-vsmZfsLXHpw-1; Sat, 27 Nov 2021 12:09:48 -0500
X-MC-Unique: B221F7jPOU-vsmZfsLXHpw-1
Received: by mail-wm1-f72.google.com with SMTP id
 144-20020a1c0496000000b003305ac0e03aso8933773wme.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 09:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=vRURtkQMrygkkpJa5/CnJXDZ5sDcZbWT4igezBUS9pQ=;
 b=sdFz3qV6ivh1cmEZSngwIVZQoKkrAGO8lWIrN0Aql8zkEUO0ukgNfVSpSq3g5Md2uL
 6ugAAKIDEI67dzh9lrhF1DLLhe5xsHN+4Ldg8tncnbVB3yqTj482TACrDJbDHB3e0aWG
 norm4LNNQT8rlctZ6DjEq91JzeYbkDV8+zwlNSbeuf0X5NvQgs2BsiYskZWWlTstyydS
 /vILx/TUNnv4MHEM5yUync53kwGZLIAVRzmt7gxMWwzjRkaIF3BHCW4G9m6Uh3ANrY9h
 c6eMXudkAr1y6wsSU5fL5eVld8TC+cHh+BqkFXnyC0mlpAZjuQIUEtXOz2hImr+SeeBq
 Sm6g==
X-Gm-Message-State: AOAM530VSA5MAZsvrMLDDITO722TVkNNFLktRlXk/SshekMKZrKqhZjQ
 WbxYK0TL50u6iRzK91gQqGzLZYy8/6M4B549RDKUHLXYooIJXG7GuypxTc7tyj5sKWxB+iqvFCg
 HXhAceUSklbmrGm7ZlCjDKK2RbWlJ0RHCWY6ALoo1Uw==
X-Received: by 2002:a5d:668c:: with SMTP id l12mr22379159wru.19.1638032987548; 
 Sat, 27 Nov 2021 09:09:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5OwWLf9ZEjV2RgLp40TCTTOZhK1sLUiAq9n/cmFpfXGNuE0qdAugxQT46s7QMau7MCbU2rA==
X-Received: by 2002:a5d:668c:: with SMTP id l12mr22379138wru.19.1638032987388; 
 Sat, 27 Nov 2021 09:09:47 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id f15sm12165030wmg.30.2021.11.27.09.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Nov 2021 09:09:46 -0800 (PST)
Subject: Re: [PATCH v2 3/5] iommu/virtio: Sort reserved regions
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org, mst@redhat.com, jasowang@redhat.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-4-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <96a911b2-abca-eee1-334b-52a5bb5a9b6e@redhat.com>
Date: Sat, 27 Nov 2021 18:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-4-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Jean,

On 11/23/21 4:53 PM, Jean-Philippe Brucker wrote:
> To ease identity mapping support, keep the list of reserved regions
> sorted.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/virtio-iommu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index ee8a7afd667b..d63ec4d11b00 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -423,7 +423,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  	size_t size;
>  	u64 start64, end64;
>  	phys_addr_t start, end;
> -	struct iommu_resv_region *region = NULL;
> +	struct iommu_resv_region *region = NULL, *next;
>  	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
>  	start = start64 = le64_to_cpu(mem->start);
> @@ -454,7 +454,12 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  	if (!region)
>  		return -ENOMEM;
>  
> -	list_add(&region->list, &vdev->resv_regions);
> +	/* Keep the list sorted */
> +	list_for_each_entry(next, &vdev->resv_regions, list) {
> +		if (next->start > region->start)
> +			break;
> +	}
> +	list_add_tail(&region->list, &next->list);
>  	return 0;
>  }
>  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
