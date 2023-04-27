Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9661EC77B73
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 17:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 190BB4052C;
	Thu, 27 Apr 2023 17:52:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 190BB4052C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kKcDZn/T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OO_-u48x-BPH; Thu, 27 Apr 2023 17:52:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 67A0C4028D;
	Thu, 27 Apr 2023 17:52:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67A0C4028D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C8ACC0036;
	Thu, 27 Apr 2023 17:52:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E45EC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 17:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2931F4028D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 17:52:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2931F4028D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4HT_Y9ccHR-a
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 17:52:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9649E401AD
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9649E401AD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 17:52:47 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DD3836103A;
 Thu, 27 Apr 2023 17:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7CDC433EF;
 Thu, 27 Apr 2023 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682617966;
 bh=xkU2AxBp2cbLfWG1K4LLB2Ca1SteiY+51uE8jz1bWrA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=kKcDZn/T+nclBpGkLojCKhUXmmsC1cLCya0LHePqG3NifX0AER6TEP4W0p4XXljMB
 mpIyNM/P9rgu63Hnp+rdVLv2HhWGRGSqdQICFSgeFRy/3jstP09jFDiIbdkKz+LyIG
 zyWjnXdq6Csu1oXhTM/8kd3dxLeAr6bP1xBjZgc6MDzsVAv0MoGCyRJbpCVE62JKrN
 6mXyx5UN84bPPXmqeHtsInENRxLJePawXrkjBLojzPVJGv0z5tVa83xt9mx23Ax/6S
 thPo4fiOlWzrdjXlItb+A8Pfh/zbaCoDEY56z8LqCAu3XhdBASlyfgHjXnOVF1yb1s
 ya3JEpBPvzoXA==
Date: Thu, 27 Apr 2023 12:52:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH v2 0/3] Introduce a PCIe endpoint virtio console
Message-ID: <20230427175244.GA261197@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230427104428.862643-1-mie@igel.co.jp>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ren Zhijie <renzhijie2@huawei.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>
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

On Thu, Apr 27, 2023 at 07:44:25PM +0900, Shunsuke Mie wrote:
> ...
>   PCI: endpoint: introduce a helper to implement pci ep virtio function
>   virtio_pci: add a definition of queue flag in ISR
>   PCI: endpoint: Add EP function driver to provide virtio-console
>     functionality

Capitalize the first word consistently to match history ("Introduce",
"Add").

Capitalize "PCI" in English text.

Capitalize "EP" since it's sort of an acronym (you did once, but do it
both places :))

Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
