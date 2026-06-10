Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4525B0B3
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071241; cv=none; b=Qy4mjIOQuEOKInoeZyuECbjTw4KNEZOxQ4Yvr5bvU1ezxUyvNVgfYH8kalRLw1h6DmdYJ8S6wTc48YyfdV6wywXzA6rKFGJgoksmBPlxd3AlRggJ7MKTS8p2YFdJlPWWyHdT290zpE3gWeiYMChErWWNejye9wDj+VFI4JnLfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071241; c=relaxed/simple;
	bh=S8CEMNCK3qGJNfDkKioIBoHNvaLuSk/NwLxdKcqC1Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdtE6FvtIHqRH2e3R6dcsnBo/PeuoPAVsimWOk+LwUdrXBgoa8EkNIBbBl1B7qSbZhFcgSsRPxlYzgDXosEexX7rdQmFwmp7mhxnIN+GEHX0OkVqciq6+p62ToLELSW696PDDOOdEtUEbjDdxm99LBfxiLtyJzEmEpXyKt1bFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d8/ACBpG; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d8/ACBpG"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39661f81eacso68365301fa.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781071238; x=1781676038; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gj0YYK+8W8BmuuGLUjKiEFrVEApz47d5/8fZSNVUxGs=;
        b=d8/ACBpGBypWf3IfcRU5rJcS+3AlS0q7U5LqC1q3YEKxJPektpQaD+jp0dRz11Xztw
         zb9IQcgjyC2ArLLqVHrdYf4DsbghKtsS8/SJS/ND6PiowxY9/DGPUQHrNeYAwdQ/5J8X
         cYipc3ufrcLl8z3s7472GTnbPGfb3e4c4LOZxUYiUPH9c72KNUoBTopwnF2mORJyN53G
         nwKg5pbw5tCF1idy68BPcpvZ9OOIhV/SyouPxHqqEqWMReVWJ4PD7ACTMXPjPMQIgs7N
         vZ8DVS7vcMVXoB/2zgpG+mCNcsL0BQcyTxiAEEp6WWCxZEk/laMSt6NFYYim42uYzQFb
         tjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071238; x=1781676038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gj0YYK+8W8BmuuGLUjKiEFrVEApz47d5/8fZSNVUxGs=;
        b=qaRIpGZ3SCimxi9ZkA8nsKT5b58e5LI1lkgI0J+z20qovMhKkVx/4Bfe2Bn2Zq06eB
         YkdnRnFGL+p+hb+Eu3yeGOinQv5JlnOvpEvfxzlM2AbDowrpV+WvnAFTFIH2y2O4UHDT
         gZWnE0Typn+2hHuddcPkp29+3YbuNs/2MFJ/l6mUN/ZJ8RxSHEzWC3N80qUedbBc/7Fb
         ayYwXoTXNceRbGoVrXUu7WPGD93f/fdRx7at+WyynTw0MCKmSSUvPCVECTg42i8zMK7w
         VoLjYbbNbTJpwHqIVl1GaDaJnnfR50pmONFsl7gOgg5OTwRZg8hghf1fZyrPEM7wR0H/
         QLeg==
X-Forwarded-Encrypted: i=1; AFNElJ8RiS1b+epQb0v85GdBF9vAZFBJaSbFm4xr586Od24aSRKXst687g93x/uZrj/BOQvbBXFmz1c00P5t8zmuTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxk3Lg6inrPeEpneaW7MhkN+c+NrJKSW3044QMyM81gKWrv8E8a
	rNB1zW/BvXOq27z9b7n6dIrAr4AvladKO09BkhGMcCsjY/0EQdeYqvIQHryoaoIb4WI=
X-Gm-Gg: Acq92OGkxsRrGCGKRaH1BtIGOlVue+N5UQiT1i1XXrnl8W6Hg0HvoQ4ZPCKrRf8Anjq
	vVbCZJVs/h/zM4WpUId6X1q85cyTqSSWRxVJIQppmi5SF9ct9oDWZlHgxiBQXriHIPu/d+u9bH7
	EyggoApaHo2AIFTqeX/syzzKutp0LdGv0sa2Med4aS4+qpE6zhsetNN+cIWaDhdZsADJeoDuZAu
	VvNjn+3Hk/xz3FLH+3ySKYyVJwq+CncTVA0MCKiEEe9NGh+AKVryXTRUbXkPpOaOCB3NUc797O2
	RfqWWL2tbg1+x0Xs4d7FBz5jaoRfeGCZ7raVT6w1PdR2yINjTC430ZGpEnlZIYhLE/OlMCoWtGL
	WYb6RUsf5e2mDddyku0CqMjVivRyd3AMuqkPd1bDCtCfkG8FbKtMwh3kwkFdFHbA9G0mtmoIA6X
	CP2qlyrjk9V3l2yo1TcfhucKseOhGrvKgp205TfgkfCXGeYvOR7qeHXtF7JIyHDik9xelREQQ=
X-Received: by 2002:a2e:b8cd:0:b0:396:a647:76f5 with SMTP id 38308e7fff4ca-396d285f55dmr58137321fa.5.1781071237888;
        Tue, 09 Jun 2026 23:00:37 -0700 (PDT)
Received: from ?IPV6:2001:a62:1439:d001:a0af:1164:c6fd:8c51? ([2001:a62:1439:d001:a0af:1164:c6fd:8c51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396abd6cbe6sm59530741fa.0.2026.06.09.23.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 23:00:36 -0700 (PDT)
Message-ID: <21746ee7-cff3-4db8-959d-dd693389492d@suse.com>
Date: Wed, 10 Jun 2026 08:00:30 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] scsi: scan: allocate sdev and starget on the NUMA
 node of the host adapter
To: Sumit Saxena <sumit.saxena@broadcom.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 Adam Radford <aradford@gmail.com>, Khalid Aziz <khalid@gonehiking.org>,
 Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
 Matthew Wilcox <willy@infradead.org>, "Juergen E . Fischer"
 <fischer@norbit.de>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Finn Thain <fthain@linux-m68k.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
 Jamie Lenehan <lenehan@twibble.org>, Ram Vegesna <ram.vegesna@broadcom.com>,
 target-devel@vger.kernel.org, Bradley Grove <linuxdrivers@attotech.com>,
 Satish Kharat <satishkh@cisco.com>, Sesidhar Baddela <sebaddel@cisco.com>,
 Karan Tilak Kumar <kartilak@cisco.com>, Yihang Li
 <liyihang9@h-partners.com>, Don Brace <don.brace@microchip.com>,
 storagedev@microchip.com, HighPoint Linux Team <linux@highpoint-tech.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Brian King <brking@us.ibm.com>, Lee Duncan <lduncan@suse.com>,
 Chris Leech <cleech@redhat.com>, Mike Christie
 <michael.christie@oracle.com>, open-iscsi@googlegroups.com,
 Justin Tee <justin.tee@broadcom.com>, Paul Ely <paul.ely@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
 megaraidlinux.pdl@broadcom.com,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 mpi3mr-linuxdrv.pdl@broadcom.com,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Ranjan Kumar <ranjan.kumar@broadcom.com>, MPT-FusionLinux.pdl@broadcom.com,
 Daniel Palmer <daniel@thingy.jp>, GOTO Masanori <gotom@debian.or.jp>,
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Geoff Levand <geoff@infradead.org>,
 Michael Reed <mdr@sgi.com>, Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com, Narsimhulu Musini
 <nmusini@cisco.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 linux-hyperv@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
 virtualization@lists.linux.dev, Vishal Bhakta <vishal.bhakta@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, James Rizzo <james.rizzo@broadcom.com>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-2-sumit.saxena@broadcom.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260609121806.2121755-2-sumit.saxena@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/26 14:18, Sumit Saxena wrote:
> From: James Rizzo <james.rizzo@broadcom.com>
> 
> When a host adapter is attached to a specific NUMA node, allocating
> scsi_device and scsi_target via kzalloc() may place them on a remote
> node.  All hot-path I/O accesses to these structures then cross the NUMA
> interconnect, adding latency and consuming inter-node bandwidth.
> 
> Use kzalloc_node() with dev_to_node(shost->dma_dev) so allocations land
> on the same node as the HBA, reducing cross-node traffic and improving
> I/O performance on NUMA systems.
> 
> Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
> Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>   drivers/scsi/scsi_scan.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
