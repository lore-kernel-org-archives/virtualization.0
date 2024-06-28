Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24F1BC49
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623516; cv=none; b=J1edzXMICZ0GPqJVgCMoi+InTvjvKAv1ZGVeKGhq54JK5oHFL+Q1BBPpKVjB7bY5AHUKlSLbd6u3XdYguzsmtGGvzVfT5XOm6UcIRd2jFjqYDube0OitdO6LX5sj8OVqAA0tJg9/0DvqtFMGO4hoYJb4nGBJTqbzXEHr1IexihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623516; c=relaxed/simple;
	bh=4J+wv41/qTOW/XeXcWFye1zeMVG+o14N+SygBRQYWno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6XnmekdCPBm31PodEzben/yIORozkml43I7ctPjDg7VHYcYgtBkaYbymFIm1vhoKTTiKRMlQiuDVLG9qRsgFXJIBIP6ln4bTnYBMI/NhUMiX55wAIBDjCORfD7QPRWVZg0+9j7nBOCdsHXIPdK+6B6X7OD3OsZU4KFb+S0uGOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lQffNqpG; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lQffNqpG"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ADBDC400E7
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yMG-YKjGvjm4 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jun 2024 01:11:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C6FC840131
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6FC840131
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lQffNqpG
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C6FC840131
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:51 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3d561d685e7so787163b6e.1
        for <virtualization@lists.linux-foundation.org>; Fri, 28 Jun 2024 18:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623510; x=1720228310; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxuCmnV0ZWEWENto9tfINCmCrw1xBxkvM+e/Do3ps+0=;
        b=lQffNqpGrdZgcKjcPnKugSCOAxbNbizYcumzhBnLHg54x4QQC8qTwcuVbB1GeXzjF1
         ktX8zE7tNosV+PFfu57mrF+pf/hilTA+k8zx+b3Wk2wicSnatngRH8fr317Z7GcCVTtd
         TsXeqPdow/sCPBjMjc2Tum/Y2E39JrBwak+TpnplMem471AxrQaIvSxoAHzUuMuwW/CE
         C7G1CxjGfbklcVJ39rzAHpHZ355GoggpNyzhixvZIgNeftTYHixjI2bIBBPLNxj5njuB
         Ns+sBdCNcmTMnBNLiSGNBuni7UYJj7EUlBokUD68myx+0jS8eEtIUg4fbUbCtewbg2+h
         FOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623510; x=1720228310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxuCmnV0ZWEWENto9tfINCmCrw1xBxkvM+e/Do3ps+0=;
        b=Ki0iAOSL/7YH49OlewrquxJlOLGPe3ArFOyBculv/JZKWZgnC6mZQnAT1ONPfPBBtk
         sdBeTAvA/MP1MVjaYMNW9ccbB0CaDzqgacrnTGIQ0x/kX+NpspuGJVWdYgJQjVBYixYN
         bhjW0T9MZhLUrdOkLNj5gDcb6UlJRip2LHWUCh1ViemRTTskLka1Aj6z5EnmWXXhxEOD
         PmL7Lv6lgvafuXVG4bIfXXGUnrleH+YyKgR9uFZBSxc6ececwiyDbhm7m8K4LuEWfsdF
         rk0cE4NxNN/KZrxAC3ciLZKHs4IceVRAMfgjtDyI3Dj627/L8AHJu+THJZIPDxM8a08r
         JP5A==
X-Forwarded-Encrypted: i=1; AJvYcCXLnpn/BcJG4QqaZ59//qbc7jA7ea22oPfSKqzGGzD0v8MjsgwX2uBLb56/cxfkzj31/sAbFu8W9ghy7gzkHk+e32PG1DGx4QJ3FOt1hn66CnVXoZOeiLfLIg==
X-Gm-Message-State: AOJu0YyqRv1qjRhiUVsq4SGop88hyI9Ojo5RO1P1XGUbSg45R1a9c5J/
	cKR4YK1q8pqGBNQRonIY07NMVwLoaRSU3jmEWjYhua/eAqKaY1GJ6juD6IPmtRg=
X-Google-Smtp-Source: AGHT+IE5gW6TwhDu3dVXkufILwe5Riqxu4x8VUh+MyIJSeF3+uS0xeub7USzPp5b3oOGLO8VOeb/KQ==
X-Received: by 2002:a05:6808:1783:b0:3d6:7726:a4c6 with SMTP id 5614622812f47-3d67726a926mr283479b6e.10.1719623510666;
        Fri, 28 Jun 2024 18:11:50 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:50 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNJqL-0004ne-OK;
	Fri, 28 Jun 2024 19:13:21 -0300
Date: Fri, 28 Jun 2024 19:13:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <Zn81gdjwJBfjXekJ@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-9-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-9-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:53PM +0800, Lu Baolu wrote:

> @@ -308,13 +315,29 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  		goto out_put_pt;
>  	}
>  
> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> +		struct iommufd_fault *fault;
> +
> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> +		if (IS_ERR(fault)) {
> +			rc = PTR_ERR(fault);
> +			goto out_hwpt;
> +		}
> +		hwpt->fault = fault;
> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> +		hwpt->domain->fault_data = hwpt;

This is not the right refcounting for a longterm reference... The PT
above shows the pattern:

	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
	hwpt_paging = iommufd_hwpt_paging_alloc()
            	refcount_inc(&ioas->obj.users);

	iommufd_put_object(ucmd->ictx, pt_obj);

Which is to say you need to incr users and then do the put object. And
iommufd_object_abort_and_destroy() will always destroy the ref on the
fault if the fault is non-null so the error handling will double free.

fail_nth is intended to catch this, but you have to add enough inputs
to cover the new cases when you add them, it seems like that is
missing in this series. ie add a fault object and hwpt alloc to a
fail_nth test and see we execute the iommufd_ucmd_respond() failure
path.

--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -14,7 +14,7 @@ static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
                iommu_domain_free(hwpt->domain);
 
        if (hwpt->fault)
-               iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
+               refcount_dec(&hwpt->fault->obj.users);
 }
 
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
@@ -326,18 +326,17 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
                hwpt->fault = fault;
                hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
                hwpt->domain->fault_data = hwpt;
+               refcount_inc(&fault->obj.users);
+               iommufd_put_object(ucmd->ictx, &fault->obj);
        }
 
        cmd->out_hwpt_id = hwpt->obj.id;
        rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
        if (rc)
-               goto out_put_fault;
+               goto out_hwpt;
        iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
        goto out_unlock;
 
-out_put_fault:
-       if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID)
-               iommufd_put_object(ucmd->ictx, &hwpt->fault->obj);
 out_hwpt:
        iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
