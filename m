Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F7EEB64DB
	for <virtualization@archiver.kernel.org>; Mon, 19 Jun 2023 12:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2768D60615;
	Mon, 19 Jun 2023 12:58:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2768D60615
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Dl0Yh3od
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3srPPuedka8; Mon, 19 Jun 2023 12:58:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F11E605AC;
	Mon, 19 Jun 2023 12:58:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F11E605AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61781C0037;
	Mon, 19 Jun 2023 12:58:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C39F5C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jun 2023 12:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9EF658205A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jun 2023 12:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9EF658205A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=Dl0Yh3od
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZyTP3Ae-UEoO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jun 2023 12:58:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A644C82052
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A644C82052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jun 2023 12:58:19 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-62fec6068bbso30890886d6.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jun 2023 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1687179498; x=1689771498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2EN8SHZPulgVB2NMCjQeN+NgcQzF+fy6eDxvPwaTnFU=;
 b=Dl0Yh3odU6Ibx3U0XI9gO01djO1boB8jD1cQR3R0NpzgPt5gPq9kihHCbswEzs3OYd
 03r5QSYG+lxEISoM2jRdnzGNx9ob6uaG61rTYKda/EyDE5OUeALFKJyKE6aRxEmqtMuT
 yq9zqGabHHd4TXbED/HDtpcORbbbp3Jla0hLbgo8RA4FwWaZ9I4u+bK3oDmxUf3qw4SE
 /6tHL/coP/TP6wYqZrSg+2tLJEV0+DPKoZNSpJOXcv047B3EDisC0wKL9JIHNiPJ4PL9
 fp3Es3PjT7hGqIIjPXQNJdzxvl5kP/uIXH9m3OZQg3WwYAGRQMJnyegfrhfSeGfNrXx4
 RuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687179498; x=1689771498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EN8SHZPulgVB2NMCjQeN+NgcQzF+fy6eDxvPwaTnFU=;
 b=XSrp30KNsP4ZhFKtvn5kpCuj3H8DmXdJyzNDAPAzCJi/JCJN8dX74ihamXjN2nUXjc
 bHB7GxJ2ofUcB+XGSdl0liNA/4Dn/nDHBVx81IVgzXtKqMEtQLuR/LKCjbq7UXUM+CBv
 LsxPC5L7Ow0wz3D/Glwl3udKax9BS4EQ39/PCHMaqT4k+4hB1ejHum0ZEs7Z8Q9mVzQ9
 gkj9XFSGrLKMK/Nl5mJTIz9W0/7Fd1kL5Ba18FRC8gbJoIAuqf+93ehoZ3/Pn+wEjG4s
 AQdlsJXbSmPRFbCRK4oOxcyiThsombSyfAy3roe4o7MEZ2ZaRGI4Y95EnEV2Y2PgWF7E
 e5BQ==
X-Gm-Message-State: AC+VfDzVPvaAgZieQ0Fxm/KbfFJ5nxJBwf/qyLtR9YGp0O0oBWo59+rg
 vFUV7ICsehvu9LrDEm3wfyi3qQ==
X-Google-Smtp-Source: ACHHUZ7aEQ33ZOLHiW7qLtXGbpVR5w4OkoPZd7ZxPgLEVetaPWz6ZAVebnx2vcET93MTDfFQnhj3cw==
X-Received: by 2002:ad4:5cc8:0:b0:62f:fb4b:e28f with SMTP id
 iu8-20020ad45cc8000000b0062ffb4be28fmr12415239qvb.31.1687179498427; 
 Mon, 19 Jun 2023 05:58:18 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.25.194]) by smtp.gmail.com with ESMTPSA id
 l5-20020a0ce085000000b0062439f05b87sm10534957qvk.45.2023.06.19.05.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 05:58:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qBESX-006pH5-Bv;
 Mon, 19 Jun 2023 09:58:17 -0300
Date: Mon, 19 Jun 2023 09:58:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJBQ6Qeg+C5wkhmw@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <20230616113232.GA84678@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230616113232.GA84678@myrica>
Cc: Yi Liu <yi.l.liu@intel.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-kselftest@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Fri, Jun 16, 2023 at 12:32:32PM +0100, Jean-Philippe Brucker wrote:

> We might need to revisit supporting stop markers: request that each device
> driver declares whether their device uses stop markers on unbind() ("This
> mechanism must indicate that a Stop Marker Message will be generated."
> says the spec, but doesn't say if the function always uses one or the
> other mechanism so it's per-unbind). Then we still have to synchronize
> unbind() with the fault handler to deal with the pending stop marker,
> which might have already gone through or be generated later.

An explicit API to wait for the stop marker makes sense, with the
expectation that well behaved devices will generate it and well
behaved drivers will wait for it.

Things like VFIO should have a way to barrier/drain the PRI queue
after issuing FLR. ie the VMM processing FLR should also barrier the
real HW queues and flush them to VM visibility.

> with stop markers, the host needs to flush the PRI queue when a PASID is
> detached. I guess on Intel detaching the PASID goes through the host which
> can flush the host queue. On Arm we'll probably need to flush the queue
> when receiving a PASID cache invalidation, which the guest issues after
> clearing a PASID table entry.

We are trying to get ARM to a point where invalidations don't need to
be trapped. It would be good to not rely on that anyplace.

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
