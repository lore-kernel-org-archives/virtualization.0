Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E0CC4332F
	for <virtualization@archiver.kernel.org>; Thu,  2 Nov 2023 12:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79DF48502B;
	Thu,  2 Nov 2023 12:47:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79DF48502B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bgo+GULy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ukmnx7Fhgs2x; Thu,  2 Nov 2023 12:47:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 32EC785035;
	Thu,  2 Nov 2023 12:47:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 32EC785035
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F138AC0039;
	Thu,  2 Nov 2023 12:47:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89F29C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 12:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 645EA43402
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 12:47:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 645EA43402
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=bgo+GULy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZmSrNTmaMuqW
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 12:47:45 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12A2D41468
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 12:47:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12A2D41468
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7789923612dso49959885a.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Nov 2023 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1698929264; x=1699534064;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WQ+GdWawOo3FT7vEf5mwevTBQUu7eDKWKnvNYW/PsMc=;
 b=bgo+GULyl/S7mgs3vD/NG8Zv2Vo55x4RUtW1mJ8vFtgaMbqb+++gR4IgAXORKfKrMw
 z7cmShQX0V1rR7oFLA1W1a/7Me1alnviQLGlHJOZVIfenmCUYTZlmJejMi/IglK//fpD
 P4Bh/79Jq3XWeO7YElrmQu2tQ7IBa4wsKCg54gSmVp1Mt4q0x4M24448GzW5jCBcz2mU
 NjJsTXGgi0aQRm+K7KIqrER8nSTKEB3ObRv4kUW+xqjuJeAggfYDqxzMuW12MRTUEJ4U
 eNEwxSRbfuDZ9KewvTDFiWXhGEh2p2R7EtIOXPZb09vIUoHkYRFzZ6uFL8S3PFaHtT0i
 tMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698929264; x=1699534064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQ+GdWawOo3FT7vEf5mwevTBQUu7eDKWKnvNYW/PsMc=;
 b=E5RinBv34URijUv/vfraIt1A692oIQEgdZ0jjoyZgl4DEoBLxwB7TejHrhyi7zLu5d
 +RC3GnqH/4YI6wyCwi7EUtQgi9GgQjIPahI4ja1dlidP3C3ePgQfyyeqriwR0vpQk0jg
 kOr00ypLtSDwcg+CNfVWr3ukUOY0y6QQa/Az2MjJ1mTa6TliS5W/ay7VWKF9ShSkx/Py
 JuqCS8p5X7VCXh2XpsbgQFUZV+AJkX96rwWNVezdHauVM9axWbIkHroHvdpG3NTBRP1Q
 SXR08PrchDNVGkf6YWLKn97lYX7eIBfqktO62qwBC22nOATt2FY1XoO10OQYfQ6t22Ql
 yPWQ==
X-Gm-Message-State: AOJu0Yy83SyxVoLLOQkXcu8YjX1ACXbVI0eOnBFRDq/QG4Cz5gBFtB3g
 37LUzpEmdA+eA2/X918DzbOxPA==
X-Google-Smtp-Source: AGHT+IFxFiOR7UXzaPpwFSzkWqw0zJo0m72p87r7wZ2km12vbMwY4rfJeHI3ydNPhYo9BA85V7lP4Q==
X-Received: by 2002:a05:620a:35e:b0:775:9bb1:9ac4 with SMTP id
 t30-20020a05620a035e00b007759bb19ac4mr18012659qkm.61.1698929263726; 
 Thu, 02 Nov 2023 05:47:43 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 r18-20020a05620a299200b007770673e757sm2291720qkp.94.2023.11.02.05.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 05:47:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qyX6s-0004kn-JW;
 Thu, 02 Nov 2023 09:47:42 -0300
Date: Thu, 2 Nov 2023 09:47:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231102124742.GA4634@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yi Liu <yi.l.liu@intel.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-kselftest@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> Hi folks,
> 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework for nested translation. Nested
> translation is a hardware feature that supports two-stage translation
> tables for IOMMU. The second-stage translation table is managed by the
> host VMM, while the first-stage translation table is owned by user
> space. This allows user space to control the IOMMU mappings for its
> devices.

Having now looked more closely at the ARM requirements it seems we
will need generic events, not just page fault events to have a
complete emulation.

So I'd like to see this generalized into a channel to carry any
events..

> User space indicates its capability of handling IO page faults by
> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> for page fault delivery. On a successful return of HWPT allocation, the
> user can retrieve and respond to page faults by reading and writing to
> the file descriptor (FD) returned in out_fault_fd.

This is the right way to approach it, and more broadly this shouldn't
be an iommufd specific thing. Kernel drivers will also need to create
fault capable PAGING iommu domains.

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
