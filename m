Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91F226522
	for <virtualization@lists.linux.dev>; Thu,  6 Feb 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836280; cv=none; b=O25myE4dVx61id7+viKVzD3ru+BFrM5iJUkkcn+6SHzfFUACkovtu594yrOmyDRWx5jYk89lCp3sFUhm23mf1OxWW1dQm8Pp7I02z/rIPc41qsWzzMPcAJQF0wGJMSCy9QeKPyEu5UD+WtDPZVL0fUXzfuUCCkPJySGxKLOaOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836280; c=relaxed/simple;
	bh=pzwXnf2CUivg5l0fXHjyl9Qf6NkaFqUJy/SQ9lNidzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wi5KG1SFftH81FcfFwGtkD5HHCT+M7248eVyDy22qjSu5pCYh1FAzXQwz8J88R4W7NWVDh90Y2bo2v1oMGRmAPAD1/kWTw9f9ND5kgbYW3Xkp4bhexLcwjhUvif5uUxQtFx2ZWq3geK+etrssaYLWP3g1+sf6Wl7r7wI/ng/HME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0VeLl4v; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0VeLl4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738836279; x=1770372279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pzwXnf2CUivg5l0fXHjyl9Qf6NkaFqUJy/SQ9lNidzc=;
  b=Q0VeLl4v1g6mVuL8Sfsh95anGdvjD+8kWLAvQweOg5VvTyQfQQ7xjGii
   cj+m0Js1yVjKkXu+fmg4cdS748xkYTDw0FXgcHvbt4g6a3asmDvsNt7eK
   tBIiKGbnm9huA+g6wyTGqIx6sYcv7vhQdM3SXEdFj9knvJ98saPx4c5YH
   zsJ1dVqP1jwvLagrCscwSR9PXljx7dMSUz8p09YLIJJUp5dgP06niHN9y
   KOniKNpAsEe188S8zYLkfnxV6FahYF23gCsAUXObbC1Tqd49Pkm25vaQ1
   T5/QgFQcCVpDST7qwHZJLmFzA+PK8F1/RAPwSUXlreX50w9Gc13UpREuA
   g==;
X-CSE-ConnectionGUID: lNlmofUeQpekXGoQYfoMkQ==
X-CSE-MsgGUID: 4q0sQ0jESTCs4GYEwcpi6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38660991"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="38660991"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 02:04:38 -0800
X-CSE-ConnectionGUID: SsO8ILu0T5SHkrN1Q5HQ0w==
X-CSE-MsgGUID: C60LQ62BS42v1VFSi0SVwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111363400"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 06 Feb 2025 02:04:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BFACE164; Thu, 06 Feb 2025 12:04:34 +0200 (EET)
Date: Thu, 6 Feb 2025 12:04:34 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Eric Auger <eauger@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <pnpkqz6keacwz4myydc6aak6gkdmomqn2lo376przlhb3mscsq@tdsfxwb2ujpk>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>

On Thu, Feb 06, 2025 at 09:59:58AM +0100, Eric Auger wrote:
> Hi,
> 
> On 2/4/25 12:46 PM, Eric Auger wrote:
> > Hi,
> > 
> > On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
> >> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
> >>> Hi Kirill, Michael
> >>>
> >>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
> >>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> >>>> accesses during the hang.
> >>>>
> >>>> 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> >>>> 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> >>>> 	...
> >>>>
> >>>> It was traced down to virtio-console. Kexec works fine if virtio-console
> >>>> is not in use.
> >>>>
> >>>> Looks like virtio-console continues to write to the MMIO even after
> >>>> underlying virtio-pci device is removed.
> >>>>
> >>>> The problem can be mitigated by removing all virtio devices on virtio
> >>>> bus shutdown.
> >>>>
> >>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> >>>
> >>> Gentle ping on that patch that seems to have fallen though the cracks.
> >>>
> >>> I think this fix is really needed. I have another test case with a
> >>> rebooting guest exposed with virtio-net (backed by vhost-net) and
> >>> viommu. Since there is currently no shutdown for the virtio-net, on
> >>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
> >>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
> >>>
> >>> Normally device_shutdown() should call virtio-net shutdown before the
> >>> IOMMU tear down and we wouldn't see any spurious transactions after
> >>> iommu shutdown.
> >>>
> >>> With that fix, the above test case is fixed and I do not see spurious
> >>> vhost IOTLB miss spurious requests.
> >>>
> >>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
> >>> IOTLB callbacks when IOMMU gets disabled,
> >>> https://lore.kernel.org/all/20250120173339.865681-1-eric.auger@redhat.com/)
> >>>
> >>>
> >>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>> Tested-by: Eric Auger <eric.auger@redhat.com>
> >>>
> >>> Thanks
> >>>
> >>> Eric
> >>>
> >>>> ---
> >>>>  drivers/virtio/virtio.c | 10 ++++++++++
> >>>>  1 file changed, 10 insertions(+)
> >>>>
> >>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> >>>> index a9b93e99c23a..6c2f908eb22c 100644
> >>>> --- a/drivers/virtio/virtio.c
> >>>> +++ b/drivers/virtio/virtio.c
> >>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
> >>>>  	of_node_put(dev->dev.of_node);
> >>>>  }
> >>>>  
> >>>> +static void virtio_dev_shutdown(struct device *_d)
> >>>> +{
> >>>> +	struct virtio_device *dev = dev_to_virtio(_d);
> >>>> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> >>>> +
> >>>> +	if (drv && drv->remove)
> >>>> +		drv->remove(dev);
> >>
> >>
> >> I am concerned that full remove is a heavyweight operation.
> >> Do not want to slow down reboots even more.
> >> How about just doing a reset, instead?
> > 
> > I tested with
> > 
> > static void virtio_dev_shutdown(struct device *_d)
> > {
> >         struct virtio_device *dev = dev_to_virtio(_d);
> > 
> >         virtio_reset_device(dev);
> > }
> > 
> > 
> > and it fixes my issue.
> > 
> > Kirill, would that fix you issue too?
> gentle ping.

I am on vacation this week. Will try to get around to it next week.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
