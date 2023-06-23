Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2108AEB64D7
	for <virtualization@archiver.kernel.org>; Fri, 23 Jun 2023 13:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B21841F1E;
	Fri, 23 Jun 2023 13:50:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B21841F1E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hAT1OlnZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z2EToy53dzXK; Fri, 23 Jun 2023 13:50:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C148F41F3E;
	Fri, 23 Jun 2023 13:50:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C148F41F3E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FCB8C007A;
	Fri, 23 Jun 2023 13:50:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCD62C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 13:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80D0F40494
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 13:50:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80D0F40494
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=hAT1OlnZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 85RwzCst2E2G
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 13:50:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9291940193
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9291940193
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 13:50:10 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5533c545786so488259a12.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1687528210; x=1690120210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T+1pIFBwxpLNL/VoMpzyTvuzZptHIhilPLYErQwUS8k=;
 b=hAT1OlnZCSwyNFydf13NvIycgXr5/iIfC6r8/nd0zLufzjnG76xScQ8fkAvjuDR9HA
 LKstTMkVB1IimZFBU+AILwUx2GaOikMy+PW2Eg7+k6BnlRwGKiPDbsTCp9VVgh0lD6bi
 8QYBpzPAZyybBHinxa4YFTWPP0+n1bFlI15Wjv6yMRRcN1lRHOpBz63Iootsc/mjPBYf
 YMeoCsk0bHsnceZKYdKo46Nve3OJdWtoZevSnvjANuI1wSA0s6vRTB0FXzEE4I7M2vF+
 lGRMvxSZ4U+bjAWHupE09pIQBGQgCvCiABu5+zuXGjJLJXB75Ua+e9EoKOR+y1vzr1qk
 UKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687528210; x=1690120210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+1pIFBwxpLNL/VoMpzyTvuzZptHIhilPLYErQwUS8k=;
 b=f+2Cbdsturm7CLwq9Xyf5FXjRY9NN1ikR9dFgYsjcC0FxRSHil5iqdp0+ACJQSyQ4/
 TyBmf3tffoV0IPZhiKWvqqrrpueS8AhnLasVWkt1KzDmYQIy4kcbd0VfCD5O3YBH7B9b
 pzCyPam3rO6KSEp0ipAF9Vz+ObEl291chw2pL2091Lzk4Xr4O/QkL/T3l6EtVmh6Q3h6
 indu5FR+OPGdCvZR0JSuHl4NJkEA7XnhiaOeNdYTG34ezTZ1W5/RpJs80gGXjZalpU9+
 bh4SORfpjdwOnbXOB1DJdgNQsP21//MizzulXG77CcF2+M0MOp3FYOV7Wp+4xE6Rkk0s
 IUWw==
X-Gm-Message-State: AC+VfDxc8O1qS1ELEccMQu2OuifCa4JOVZwe0UjtRPMITqw+93xRTWbz
 jZH7ic5qNlWKUKfqngrQrL2GXw==
X-Google-Smtp-Source: ACHHUZ4GZmcSemtE667i1A/XCxE0H28ULkbHrmN2r73R4aAzspqKPCakvWEfvpegChi/MFwoMtwoWw==
X-Received: by 2002:a17:90b:811:b0:25c:7d4:7cd with SMTP id
 bk17-20020a17090b081100b0025c07d407cdmr25932024pjb.24.1687528209792; 
 Fri, 23 Jun 2023 06:50:09 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.25.194]) by smtp.gmail.com with ESMTPSA id
 n59-20020a17090a2cc100b0025bdc3454c6sm1647744pjd.8.2023.06.23.06.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:50:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qChAt-007z7M-Gb;
 Fri, 23 Jun 2023 10:50:07 -0300
Date: Fri, 23 Jun 2023 10:50:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJWjD1ajeem6pK3I@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHaV3GwYXCvfNUBn@ziepe.ca>
 <a3c15dff-c165-57c7-16f6-072e251a9368@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a3c15dff-c165-57c7-16f6-072e251a9368@linux.intel.com>
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

On Fri, Jun 23, 2023 at 02:18:38PM +0800, Baolu Lu wrote:

> 	struct io_uring ring;
> 
> 	io_uring_setup(IOPF_ENTRIES, &ring);
> 
> 	while (1) {
> 		struct io_uring_prep_read read;
> 		struct io_uring_cqe *cqe;
> 
> 		read.fd = iopf_fd;
> 		read.buf = malloc(IOPF_SIZE);
> 		read.len = IOPF_SIZE;
> 		read.flags = 0;
> 
> 		io_uring_prep_read(&ring, &read);
> 		io_uring_submit(&ring);
> 
> 		// Wait for the read to complete
> 		while ((cqe = io_uring_get_cqe(&ring)) != NULL) {
> 			// Check if the read completed
> 			if (cqe->res < 0)
> 				break;
> 
> 			if (page_fault_read_completion(cqe)) {
> 				// Get the fault data
> 				void *data = cqe->buf;
> 				size_t size = cqe->res;
> 
> 				// Handle the page fault
> 				handle_page_fault(data);
> 
> 				// Respond the fault
> 				struct io_uring_prep_write write;
> 				write.fd = iopf_fd;
> 				write.buf = malloc(IOPF_RESPONSE_SIZE);
> 				write.len = IOPF_RESPONSE_SIZE;
> 				write.flags = 0;
> 
> 				io_uring_prep_write(&ring, &write);
>             			io_uring_submit(&ring);
> 			}
> 
> 			// Reap the cqe
> 			io_uring_cqe_free(&ring, cqe);
> 		}
> 	}
> 
> Did I understand you correctly?

Yes, basically this is the right idea. There are more complex ways to
use the iouring that would be faster still.

And the kernel side can have support to speed it up as well.

I'm wondering if we should be pushing invalidations on io_uring as
well?

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
