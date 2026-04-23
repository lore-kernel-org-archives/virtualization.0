Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C492DC77F
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953930; cv=none; b=RLr4XXdFz104yomecWx83crPmSEGtxiz47hMlUUjd3HKOTFgLlu4IujJbaQkTrJ8w2NX5yyfBTxe6VPT46YWbtjXM2n503cfQkdd7xE0vjw+tTJiEU2evA7s1IwNOwQ5tBHelIDIqWVgGc2f/T9yBvivT59lKkpZbk6pQGSUjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953930; c=relaxed/simple;
	bh=LSJOTkRvgDMochGAG2u+xvbWFmTWnSE6qQ3xJqtS+t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWpJz8l1QLeG9q0CCBfAnOf9p6rxX3K1MyFxF2jYMOxND5UJW/qu6oN6ADe6DdtAwvkCyb3EPoybfCBve+GwasifdD3X33J3KflKRRLHujICLza/wiTP4oolbpfkL/Ry5mlPQMdI27w/06WPcmwEKsJTJFQ+9rodLiMfsgXFcks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=v+MJo+HS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="v+MJo+HS"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MJj2BQ3549026
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 07:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=e95FCMfWZPIOflPX9x4B7yDZMlPKVoCcJEUwN6OatrI=; b=v+MJo+HS/N5D
	fQTCqX9AVRisJuiPh225WBruwA/jUDdds5TjN78vSY40xglltHw7sbQxw5AvTPSf
	nPNNM3WRIeid0dKheMQdeG8V/Zsqw5XBZbUjxDocbW6JXMdsO0ExGuQXsyiu5ZOS
	waD0d7hALvvqpIT/jXEzxvGKRcxR/ZF0HenovdWMeIjCo3droUW9GqF4RFw5i0+T
	W3QLbIBISHFR9/4kZMCfze6WsQB4VbHOKS9fq7FV0uPvSa0NrkT8vjGtC59ZtvUa
	H+Ti/O/LRiHpB22D0rTaVbUaftTG0yfsQSLTtvhLG53LWfHSgk45XjxI9zS4kC5L
	+JBDLK+TLw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepamwtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 07:18:46 -0700 (PDT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12c87ba0890so18442813c88.0
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 07:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953925; x=1777558725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e95FCMfWZPIOflPX9x4B7yDZMlPKVoCcJEUwN6OatrI=;
        b=FuK6xazaWK84w+saS+2ePLsfkcGF43CG7+SAoJXLtrqk+c2Xh2nf3tnBB9cSIssMgJ
         kZrmAZwcy3WGLyRCdfvyPMJf9kYR8umplmZqrx8pbRvGMyYk4fb0a2l5+yTSjkFQoA/a
         YSolDKh4iQl/pEeoiBn3Gq4ESb7zqOvyf82JS6+VnahA8mFUqHiZndNkJ2d5g0MnAsF1
         KvPWGoBOIYcv1OD7AX87d0lHVCPrElvuDDn8+GDMaNdlxr9TSlBVs1XDZeJpNS0M/0CQ
         8cRiGkYJag+ckN93GfdOSs01jmJu5f6GTFe8psmcCivKXv6tzVXoG1A23BTIp0HylGBU
         y+Fg==
X-Forwarded-Encrypted: i=1; AFNElJ9j/xBPX1s06cZmXFUbW30k2koHOMrVSXq0B6uK0LskTO9LiSfj1OJkQpM3k9te0Gi4I9r3nc7yIyUgRI9AGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUCYfYfJQvWivAWiKJCvATBI6VVZSXPzmU9QmFKHvfgnVbZ3aP
	EVlXGEZEJ/A9xKYDzCRNwtG8Bh0NVFUqBxaSK/OvegrVLgqCmg82+IHrcKt/VAX6lY9FDn6jdYr
	Bx7NHBAyJScAlbfKY3eKo22pBOceIN+6btDgGFHwxpQVQ/QYtJ9ffx6Sx1yUwvKo3r5k=
X-Gm-Gg: AeBDietHSkQQgMo1CrAtJMGaNSovlywvQZ/hXMOWebTRmYlaaa2XK2pNXN/svJlVvTO
	v77RrF5TPw3vwDbsWGhmJOwY2NcT8zzC1mEEgVTP/YfEOjfAUPT4AVeFDzy4XyZxzaEZ5VhVboh
	7/bsCA3lepvrABRDWxpRLH93p2XOpdmkUBXUu6ijXbiv0fMN3f+LLk3JpSDgmwNs4O5cqOCJvDQ
	v+kdFiQmZUXpS/pkKjSgymylKnOmWK4zg4cf0uqwQnKKnG5SYabHdvqQ6d+p09O+hB5M8eI5Xrt
	3jrZEdVyoe6Z1XEW08DqbfFYAaiWMR7fIL1Ttf925y5vrrW3YK1kbsG9eURhQ3oSnwgXPV1oWhB
	Ki2/QAO+0ArWoz1y2Vy6y1VuM9ka2QWw/AyXi2LG5
X-Received: by 2002:a05:7022:e22:b0:128:cedb:33c6 with SMTP id a92af1059eb24-12c73f9759emr16988862c88.16.1776953925410;
        Thu, 23 Apr 2026 07:18:45 -0700 (PDT)
X-Received: by 2002:a05:7022:e22:b0:128:cedb:33c6 with SMTP id a92af1059eb24-12c73f9759emr16988839c88.16.1776953924605;
        Thu, 23 Apr 2026 07:18:44 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm41524610c88.10.2026.04.23.07.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 07:18:44 -0700 (PDT)
Message-ID: <1500fb01-3046-4d82-8cb4-3469dc2c848c@meta.com>
Date: Thu, 23 Apr 2026 15:18:39 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/pci: Set up barmap in vfio_pci_core_enable()
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ankit Agrawal <ankita@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
 <yishaih@nvidia.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20260421174143.3883579-1-mattev@meta.com>
 <20260421174143.3883579-2-mattev@meta.com>
 <20260421133123.36fc0353@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260421133123.36fc0353@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FnmgK8Qzf-gml6_mn3htHUZUBBJsK_xV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfX3ABMxERotpkQ
 /aQEL9oCIPOF9DvG4Vk92ndc+nV71hMKaw5JU/kyxRSzfe5oCWsau7YYQlDy1q3+zbMUfKy2Re3
 84LOfm50f03kF4F1dHD9wZn8xjhnb33p5I+v6/KH9gN4fJcfty3+ToYbqvWilIruRsGc3t5iLA2
 SpNJEdPaEtimgNcwqOQCASD5T7vQzh8jBkSFEFIbyhzykPhveaSBlEEqzkcCxe4/6PTHmzQBacy
 DX+JHF9InWn/pvxVHlS8nPdYZtDbLQy8MXKPyjeIYNNOCC3Odf4ydPtB089qrIFE5r8+5BS9wNq
 ERPfJdcEk8P9naX8le3EB8/jLBL97dupFujshDppmXTUX7rANvohSICbTPPYckHsI3WSKXBZQDd
 LzvcM8uSEUnxz1Jo8zwU5xyMm8N3JGs+sjePEGywvOR7qFJlfco9ppdpCOZqI7kSi499afJoswm
 Lm6lLjgKuaUurC0WjhA==
X-Proofpoint-ORIG-GUID: FnmgK8Qzf-gml6_mn3htHUZUBBJsK_xV
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=69ea2a46 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22 a=VabnemYjAAAA:8
 a=iNyBAbhlopIjzdoupJ0A:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

Hi Alex,

On 21/04/2026 20:31, Alex Williamson wrote:
> 
> On Tue, 21 Apr 2026 10:41:40 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> The previous lazy-setup of the barmaps provided opportunities to
>> forget to do it (for example, DMABUF export).  Since all users will
>> ultimately require BAR resources to have been requested, request them
>> in vfio_pci_core_enable.
>>
>> Existing calls to vfio_pci_core_setup_barmap() are now benign, but
>> remain because some callers use it to validate a BAR index.  This
>> fixes at least the case where DMABUF export could succeed before
>> resources were requested.
>>
>> This keeps resource request and ioremap() done at the same time, but
>> in future the ioremap() could be done on-demand (not all VFIO users
>> need it).
>>
>> Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
>> Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c | 63 +++++++++++++++++++++++++++-----
>>   drivers/vfio/pci/vfio_pci_rdwr.c | 25 +++----------
>>   2 files changed, 60 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f8d093aacf8..4a314213f3ae 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -482,6 +482,55 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>>   }
>>   #endif /* CONFIG_PM */
>>   
>> +static void __vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	int i;
>> +
>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> +		int bar = i + PCI_STD_RESOURCES;
>> +
>> +		if (!vdev->barmap[i])
>> +			continue;
>> +		pci_iounmap(pdev, vdev->barmap[bar]);
>> +		pci_release_selected_regions(pdev, 1 << bar);
>> +		vdev->barmap[bar] = NULL;
>> +	}
>> +}
>> +
>> +static int __vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	/* Eager-request BAR resources (and iomap) */
>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> +		int bar = i + PCI_STD_RESOURCES;
>> +		void __iomem *io;
>> +
>> +		if (pci_resource_len(pdev, i) == 0)
>> +			continue;
>> +
>> +		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
>> +		if (ret)
>> +			goto err_free_barmap;
>> +
>> +		io = pci_iomap(pdev, bar, 0);
>> +		if (!io) {
>> +			pci_release_selected_regions(pdev, 1 << bar);
>> +			ret = -ENOMEM;
>> +			goto err_free_barmap;
>> +		}
>> +		vdev->barmap[bar] = io;
>> +	}
>> +	return 0;
>> +
>> +err_free_barmap:
>> +	__vfio_pci_core_unmap_bars(vdev);
>> +	return ret;
>> +}
>> +
>>   /*
>>    * The pci-driver core runtime PM routines always save the device state
>>    * before going into suspended state. If the device is going into low power
>> @@ -568,6 +617,9 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>>   	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>>   		vdev->has_vga = true;
>>   
>> +	ret = __vfio_pci_core_map_bars(vdev);
>> +	if (ret)
>> +		goto out_free_zdev;
> 
> Beyond simply changing to a preemptive mapping scheme, this hard
> failure makes me concerned about regressing userspace.  With the
> current lazy scheme, we only claim the BAR if the user accesses it and
> the failure only occurs in the access path.  That means we could have
> BARs that are never mapped.  With a hard failure here, with might be
> uncovering some latent issues, and if those latent issues are with BARs
> that we never cared to map previously, we're causing trouble for no
> gain.

Thanks.  Hm, so for example a valid non-zero-sized BAR but the 
pci_iomap() hitting ENOMEM.  Good point, that could be annoying if the 
BAR was otherwise unused.

> I'd suggest setup should be a void function that generates pci_warn()
> on conflict or iomap error, but doesn't block the device.  Each usage
> path (including mmap that gets removed in the next path) still needs to
> validate the mapping is present for the given BAR and fail the call
> path otherwise.

I'd hoped to be able to assume resources have been successfully 
requested, since we've at least one example of forgetting to do it 
explicitly (DMABUF export), but no worries.  I'll re-add explicit checks 
to usage paths (incl. for DMABUF export) to make failures consistent 
with current behaviour.

> There's also a subtle range check added in the virtio driver in the
> next patch, is that fixing a bug or paranoia?  Do we need a helper that
> does a range test and barmap test?  Thanks,

That'll be nicer, I agree.  Given the point above, two tiny helpers make 
sense for the two "uses":

- Was resource X requested successfully?   (For DMABUF, mmap, etc.)
- Get X's iomapped base address.  (For rdwr, virtio, nvgpu-grace.)

(The motivation for the range check was just robustness, not a specific 
bug.  It's cheap to sanity-check and Pretty Bad if the index is ever out 
of range.)

Reposting... Thanks,


Matt

