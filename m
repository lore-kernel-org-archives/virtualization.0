Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A9DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 13:06:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5630B6120F
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 13:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5630B6120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 248958423E;
	Wed, 22 Sep 2021 13:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sUHU4nYJaoO4; Wed, 22 Sep 2021 13:06:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B002B84231;
	Wed, 22 Sep 2021 13:06:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82FD6C000F;
	Wed, 22 Sep 2021 13:06:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6A69C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6914613D0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:06:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NXgLM_i9gTiX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:06:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2857613D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:06:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F7D1611CA;
 Wed, 22 Sep 2021 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632315973;
 bh=oNdKNGeEDSMsQZb0QR79jAvNFQsEnJOIQSDq8mmnnzs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZmZut9FaGDBMBk0SNp1LqarjL1dNIa9LJeP0D32JOFaldMmVLyxNsVJ5ye+/213Vb
 Y046E+hu85twyYidfc5wmzc5AmSKuc+XzHEgENvVUzw8bRu5CSGd5JJ2siUC9sjmmK
 cX83OJtY+o4t2AZ9D3hXac09JxL7f/a4uYR9TLVg0j7ZYKpSPvFrQlq30WzyPHa6OT
 5AIha5qJjIg+YSHBe58gEGciD3IPjh9f1quU8Ay3WYTdk+GbuatGI+3QG6cPJuNp/0
 fru4jCWvG50H6w/4YLaxXYgzhZL82FCR5vR0sbMrjZzxgDsHUFugPDQDkbA25HUO1j
 O7AhSCzM57NFg==
Date: Wed, 22 Sep 2021 16:06:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junji Wei <weijunji@bytedance.com>
Subject: Re: [RFC 0/5] VirtIO RDMA
Message-ID: <YUsqQY5zY00bj4ul@unreal>
References: <20210902130625.25277-1-weijunji@bytedance.com>
 <20210915134301.GA211485@nvidia.com>
 <E8353F66-4F9E-4A6A-8AB2-2A7F84DF4104@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E8353F66-4F9E-4A6A-8AB2-2A7F84DF4104@bytedance.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jason Gunthorpe <jgg@nvidia.com>,
 mst <mst@redhat.com>, RDMA mailing list <linux-rdma@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, yuval.shaia.ml@gmail.com,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, Doug Ledford <dledford@redhat.com>,
 =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>
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

On Wed, Sep 22, 2021 at 08:08:44PM +0800, Junji Wei wrote:
> > On Sep 15, 2021, at 9:43 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:

<...>

> >> 4. The FRMR api need to set key of MR through IB_WR_REG_MR.
> >>   But it is impossible to change a key of mr using uverbs.
> > 
> > FRMR is more like memory windows in user space, you can't support it
> > using just regular MRs.
> 
> It is hard to support this using uverbs, but it is easy to support
> with uRDMA that we can get full control of mrs.

What is uRDMA?

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
