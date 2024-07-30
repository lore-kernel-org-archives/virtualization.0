Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8302194A57
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342747; cv=none; b=kanOCqvAvvIUhQkRDYwkhSxIGqsZCxfXhHnTww8C/4iQZCBpoNhbQ3/4myLliyn9xdPLKJSu90uE5MSiVik3ROaSkiNH/qzfeVNQFGKCO6YbtB0ctDXXcW5+zhgs0iy28N7vprCpMb2tp2BYzsj8eHQtpZXNL8CpssWcsx7wUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342747; c=relaxed/simple;
	bh=S4TKs36zuyYQhQC2wNo65S9DbOgKoxAMU4qhwPg6ZC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9h9Z0oxmDAjCziozgNqDO7Kmgnd2wN0B0JI20FM+2PL2l1jmo/DLZplVJjn3A/TMbiko9w/zZhWA3SsZZp+f2NhJ2JSwsN20uhPCU959ItPRbDhpnLfB2X69012G0G+1bV63iDYNDzbf85DYwXzJ9vyEpwKfSqCSsNW2IB1rlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DRGoe7jK; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DRGoe7jK"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4832940485;
	Tue, 30 Jul 2024 12:32:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.404
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWlYwH-7HoDz; Tue, 30 Jul 2024 12:32:24 +0000 (UTC)
X-Greylist: delayed 5567 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 30 Jul 2024 12:32:22 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A65F34046C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A65F34046C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=ti-com-17Q1 header.b=DRGoe7jK
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.47.23.249; helo=lelv0142.ext.ti.com; envelope-from=a-singh21@ti.com; receiver=<UNKNOWN> 
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A65F34046C;
	Tue, 30 Jul 2024 12:32:22 +0000 (UTC)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UAxNdt007163;
	Tue, 30 Jul 2024 05:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722337163;
	bh=S4TKs36zuyYQhQC2wNo65S9DbOgKoxAMU4qhwPg6ZC0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DRGoe7jKXTG+0vpSFv46vZ0XAtzs/e8IZ4vj7YQ8NCMFawEj8PxHEu4BOVegSmwnI
	 RJQnJI8asevu6QgxWmHceCp1RQ5p9oDKhYLEYqE0YSitIEwfIXd4ltf4I1cm5EkoyN
	 0/orT05a8NzXl1mFbCCRAVdn6lIJ9aiWG0Y6YkxI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UAxN3S122728
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 05:59:23 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 05:59:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 05:59:23 -0500
Received: from localhost (nightbug.dhcp.ti.com [10.24.68.118])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UAxMmB042060;
	Tue, 30 Jul 2024 05:59:23 -0500
From: Amneesh Singh <a-singh21@ti.com>
To: <sstabellini@kernel.org>
CC: <boris.ostrovsky@oracle.com>, <hch@infradead.org>,
        <iommu@lists.linux-foundation.org>, <jasowang@redhat.com>,
        <jgross@suse.com>, <konrad.wilk@oracle.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-kernel@vger.kernel.org>, <mst@redhat.com>, <peng.fan@nxp.com>,
        <virtualization@lists.linux-foundation.org>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Date: Tue, 30 Jul 2024 16:29:10 +0530
Message-ID: <20240730105910.443753-1-a-singh21@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <alpine.DEB.2.21.2007151001140.4124@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2007151001140.4124@sstabellini-ThinkPad-T480s>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Stefano,

First off, apologies for bumping this dead thread.

I came across this patch signed off by you recently
https://github.com/Xilinx/linux-xlnx/commit/72cb5514953be3aa2ac00c57c9eaa100ecc67176

and was wondering if a patch replacing xen_domain() with xen_pv_domain() in
vring_use_dma_api() can be sent upstream? If not, is there a reason why?

Regards
Amneesh
