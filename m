Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFCBCE7A88
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 23:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E9DD419D7;
	Fri, 22 Sep 2023 23:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E9DD419D7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=J9GA0BsW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORXY5VEsH6iW; Fri, 22 Sep 2023 23:33:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 531FB419C0;
	Fri, 22 Sep 2023 23:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 531FB419C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 271D8C0071;
	Fri, 22 Sep 2023 23:33:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 462F6C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 23:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1113A4089A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 23:33:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1113A4089A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=J9GA0BsW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fjwlzwrcGiiS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 23:33:12 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83C0F402BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 23:33:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83C0F402BE
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d7b91422da8so3532018276.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1695425591; x=1696030391;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+8rKKRCqUyQLWkNEBe6s/yUPdVExxmOivIwMSOHwl/8=;
 b=J9GA0BsWHkEbcUi1CIeQs2HpJIyHSqrgbn8Zxhti45Kk+q5208RD2hgNbBtdfUlWPq
 YWtLeC681uatC+NDpnEX19z4j3TLZemxrA6oEUr5OnhTLndPgwk0vrh4A7yoRPmSPqx2
 l6zJRqPljZjDJBD9RhE7EV7WTzBU3xbSPD+lfFb3dl/VkbKzpBi73q4I0a3GcQdp+29G
 KXwqn7APRvr1WCCvUEPuagfI7Zy2LjhEbfEpFvW0dOsYcIuaBHgeWx5E7uO3ditZSa0g
 L5jdaGNlQOJfkCixu9+jCu4OlrIotqVFHcKSLmZQ4OEP5Z9sNBJlBbN6dGuz6CQZb2G2
 a63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695425591; x=1696030391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8rKKRCqUyQLWkNEBe6s/yUPdVExxmOivIwMSOHwl/8=;
 b=Dqp/X2IvSmtZ8ko9pGmwWbD/05T5qLaI9vOGnHgLdrs9Du+kSsi7Gmb7ey8EG2dNHH
 tVX6PQrU66r62gglTf/Jg/l08s7wezzzJw7gbUGGOk3D7NzYuQa8MPMNIX6OV++TsSPQ
 o9A0C2eppwjahJ9gsdvmHo8iQCXJ8C5iwpFECHCjua2efV6pP9FolPJiWZEV9BgChDRg
 Tq3XKbrW7ZHJ6+4250EkmZ0VXejJjjsoprLQn+oxdXuKxboTIJ7UjFFxqGQbPw0SDX2h
 Og0MsBkQUgT+ehU2Pzz93R41IqYSzZj9HC+/cmma1UFSfpNJumtqwuvSUmJ2MlEC+uf+
 OiQw==
X-Gm-Message-State: AOJu0YzKLJrO35DHDq6fZk8UsroGsN7FYrrm6uJMrlsTOBJbWic/27KY
 3nt9BcOtCuC3ReG2++xx8+5gag==
X-Google-Smtp-Source: AGHT+IHXIm3CPio25fJfcUEZEUoMW195I/INyvWWRxd2/4S04spIkfTN65/K48HdwB4EwzmNKU/gPg==
X-Received: by 2002:a25:dbcc:0:b0:d81:4168:3a83 with SMTP id
 g195-20020a25dbcc000000b00d8141683a83mr680844ybf.25.1695425591345; 
 Fri, 22 Sep 2023 16:33:11 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 i15-20020a0cf10f000000b0064f523836fdsm1838074qvl.123.2023.09.22.16.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 16:33:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qjpe1-000eFO-UF;
 Fri, 22 Sep 2023 20:33:09 -0300
Date: Fri, 22 Sep 2023 20:33:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922233309.GI13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>
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

On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:

> virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
> either; it sets it once it's discovered any instance, since apparently it's
> assuming that all instances must support identical page sizes, and thus once
> it's seen one it can work "normally" per the core code's assumptions. It's
> also I think the only driver which has a "finalise" bodge but *can* still
> properly support map-before-attach, by virtue of having to replay mappings
> to every new endpoint anyway.

Well it can't quite do that since it doesn't know the geometry - it
all is sort of guessing and hoping it doesn't explode on replay. If it
knows the geometry it wouldn't need finalize...

> > What do you think about something like this to replace
> > iommu_create_device_direct_mappings(), that does enforce things
> > properly?
> 
> I fail to see how that would make any practical difference. Either the
> mappings can be correctly set up in a pagetable *before* the relevant device
> is attached to that pagetable, or they can't (if the driver doesn't have
> enough information to be able to do so) and we just have to really hope
> nothing blows up in the race window between attaching the device to an empty
> pagetable and having a second try at iommu_create_device_direct_mappings().
> That's a driver-level issue and has nothing to do with pgsize_bitmap either
> way.

Except we don't detect this in the core code correctly, that is my
point. We should detect the aperture conflict, not pgsize_bitmap to
check if it is the first or second try.

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
