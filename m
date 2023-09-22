Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC7EE7D0C7
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 03:46:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B56F460AB2;
	Fri, 22 Sep 2023 03:46:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B56F460AB2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V+5XBMEp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PGIUHryEKDB3; Fri, 22 Sep 2023 03:46:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3AE7160B06;
	Fri, 22 Sep 2023 03:46:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3AE7160B06
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04F1AC0039;
	Fri, 22 Sep 2023 03:46:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADE92C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7484A60B06
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7484A60B06
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ev2ioTeKS6tj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:45:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C32F260AB2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:45:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C32F260AB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695354357; x=1726890357;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=v4cdlljyHLqw/8xQkGrTtjHHqC8Nlaq+67sezAeMrhs=;
 b=V+5XBMEpHOH5hrsHzxy8JVZrv+QXqZ7wQMhHMRbryxiG8KhBIhB4Qz9U
 +ZnZL+l/qsLOsX5XUaZ9AyKX2fn4DGt/dQlIVD47vOuZYym/j9oQzWqQI
 aDrZx+DktqWinX2PKfVx5en2PMi7IXN2nrIjAC2k4Bv5TEz+fp9HPhYiY
 7G6QgO+PuOAn7Y9fXzIaGeuRo9BUCg8ojMTUQZB/LN+JWcJhD459Amu7R
 ADL5982DLf+DY1sD3RbnRkSKREGRYOq6PtPyDebZv1wsdw4FDino3iCXh
 LSpFMiDJIZtR4caMCZqBH3AnY9l9O50iMwTQHcslzO9seI/ujJWSLZLip g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="380636237"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="380636237"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 20:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="747392168"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="747392168"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.21.134])
 ([10.93.21.134])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 20:45:50 -0700
Message-ID: <dcf42003-8658-1876-313c-d0ac951d8b97@intel.com>
Date: Fri, 22 Sep 2023 11:45:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230921183926.GV13733@nvidia.com>
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 9/22/2023 2:39 AM, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 12:53:04PM -0400, Michael S. Tsirkin wrote:
>>> vdpa is not vfio, I don't know how you can suggest vdpa is a
>>> replacement for a vfio driver. They are completely different
>>> things.
>>> Each side has its own strengths, and vfio especially is accelerating
>>> in its capability in way that vpda is not. eg if an iommufd conversion
>>> had been done by now for vdpa I might be more sympathetic.
>> Yea, I agree iommufd is a big problem with vdpa right now. Cindy was
>> sick and I didn't know and kept assuming she's working on this. I don't
>> think it's a huge amount of work though.  I'll take a look.
>> Is there anything else though? Do tell.
> Confidential compute will never work with VDPA's approach.
I don't understand why vDPA can not and will never support Confidential 
computing?

Do you see any blockers?
>
>> There are a bunch of things that I think are important for virtio
>> that are completely out of scope for vfio, such as migrating
>> cross-vendor.
> VFIO supports migration, if you want to have cross-vendor migration
> then make a standard that describes the VFIO migration data format for
> virtio devices.
>
>> What is the huge amount of work am I asking to do?
> You are asking us to invest in the complexity of VDPA through out
> (keep it working, keep it secure, invest time in deploying and
> debugging in the field)
>
> When it doesn't provide *ANY* value to the solution.
>
> The starting point is a completely working vfio PCI function and the
> end goal is to put that function into a VM. That is VFIO, not VDPA.
>
> VPDA is fine for what it does, but it is not a reasonable replacement
> for VFIO.
>
> Jason

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
