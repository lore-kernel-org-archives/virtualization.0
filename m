Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D21B0116
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102766; cv=none; b=Wj37SMuKyQ4WGC7lgGxs1/eKqXwRcEmzxPnCE7etLoEHvqv/HRhZs12O6K0UWZDodGEKR772NwMFY1DbFFOuROvRpwT+yBZ6aupppCAr4XUijbR2ItL6DhbJm9vqeA0usIpsndu02jWs/Z1y8t8ktAq/IaOi9Zvt6JEVal9UGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102766; c=relaxed/simple;
	bh=xLWtU+r6HtS/s4pQFfOXx/75eJPmoXke//X9ptIbVgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bddMortRcvBNV/6Y+rqGZ2zvcMAB9lHg+G2MfJofC3XGkATP3LDgjdPyJRqtYhrY+OgKYrjml+EdW97DmNN66ArE5IHJhsXIGhWXHlJh7jT09b4bAC1+7kCzML/EuTXezvy/bzNAIDxOdVff9+44N7zDw3Myx7swqF/nw4mElcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTnJGl8c; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTnJGl8c"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F9CE6085E
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 14:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_RelWd6yzyr for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Jul 2024 14:19:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=will@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F382060851
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F382060851
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YTnJGl8c
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F382060851
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 14:19:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 72BC9CE2F80;
	Thu,  4 Jul 2024 14:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B15C4AF0A;
	Thu,  4 Jul 2024 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102752;
	bh=xLWtU+r6HtS/s4pQFfOXx/75eJPmoXke//X9ptIbVgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTnJGl8c5wfv8pFoMx0MPfIwGiKoZPbKD9Rxv9Todv2zmcHUk2WYqqi7EakObJvTP
	 cuwrJlEwzbj3DkhkX8Xi+2NzeibWQKN8c+0IH1D3hxc7Yz1yuB9d6T2v3Sz4dbYOby
	 0yfPkR9n3aOcy/SrV100v6zbkL4uCKvmWuT2t0f5Zn0tDL7fHVkBbJB0Q9NT0WRGXN
	 SQRmpkDyjP1+VO59dk0xESwKID/YGFse6f1iWhdUgMpk4polojrY4V43zXglekKKl/
	 r+KDoafLXqWOs0tUzdZfuyLOCxTRseSv5aC/kJ+3ib4lJ6xiGDYz/MPCKp123TO063
	 N6AEkbxwqt25g==
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] IOMMUFD: Deliver IO page faults to user space
Date: Thu,  4 Jul 2024 15:18:57 +0100
Message-Id: <172009718026.360360.18220408964887632139.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240702063444.105814-1-baolu.lu@linux.intel.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 14:34:34 +0800, Lu Baolu wrote:
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework. One feasible use case is the
> nested translation. Nested translation is a hardware feature that
> supports two-stage translation tables for IOMMU. The second-stage
> translation table is managed by the host VMM, while the first-stage
> translation table is owned by user space. This allows user space to
> control the IOMMU mappings for its devices.
> 
> [...]

Applied first four to iommu (iommufd/attach-handles), thanks!

[01/10] iommu: Introduce domain attachment handle
        https://git.kernel.org/iommu/c/14678219cf40
[02/10] iommu: Remove sva handle list
        https://git.kernel.org/iommu/c/3e7f57d1ef3f
[03/10] iommu: Add attach handle to struct iopf_group
        https://git.kernel.org/iommu/c/06cdcc32d657
[04/10] iommu: Extend domain attach group with handle support
        https://git.kernel.org/iommu/c/8519e689834a

Jason -- feel free to use this branch as a base on which you can take
the iommufd parts.

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
