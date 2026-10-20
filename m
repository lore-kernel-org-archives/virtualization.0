Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516616;
	b=diCYPhW+ge7qCNM0nW1X4l8CbCl/wlzrmpHtrR/Q1hYc7kc/yLrx61N58EoZcZxv013N
	 g0tQs3aYhrt7z0EzicwA+RYAJbq0oENzEoOhz00AHLqTzXt0JLU633JK7lmmBb/wy7H94
	 rqrrzSJJKisLLmFFtpRnKEmYzncn+q/h6AcacVrxVfVNupa/kXVBb0AYT/d3C3Veh3ahv
	 p+yKC+5FlSoKcgN929+rAyi3NbneObxKe0Xmsb/hV/nZ6hA6abbEQVmdhXBVDgtxYKMSt
	 8oI9Cpnuh92EL7A8WZGSV0A8y7H6o1KdMR2/Fz0KVsiU1FVL3BK68ts1ksqpQPptscA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516616;
	h=Received:Received:Received:X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:
	 Feedback-ID:Received:X-Mailer:MIME-Version:Date:From:To:Cc:Message-Id:
	 In-Reply-To:References:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=FPjAFqoQ3uCxhlJR+neifQbJwXA/vEfAzYz3BKKcjZY=;
	b=s7ljxumFQ7DbfLXg3I020qzgH55L7mzjSyGj9QgY4U4OD22dLZsHY/PSFZxRWBzcObPD
	 EgqSEKFfGPGMUGqXi4CiEwM1ZM4mdrDf8hz0wsuf5qayIbWEnU2FTYKADUgcTKxjLJ+83
	 ZS4UbmHElxCPRnWI5+38Pa2WDe7HEvVPFZ6qznl8wK1av0iPrxUDhPfLSR6waAQeEvhyn
	 FcyNaYWEqLHfCVQKsu3x1bf4kxqgP+iaoB8c/CjNGxYAh7DOgDrb7QcYH/BQPsNEMJ8re
	 MnzjafWwX1vJKwGsyZJ4vdEydCmrpVsluBmwVJDgacGPY3XCtazgo83HTOzlKAxVKEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC660A2623;
	Tue, 20 Oct 2026 17:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1451F000CB;
	Tue, 20 Oct 2026 17:16:55 +0000 (UTC)
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfauth.stl.internal (Postfix) with ESMTP id DCDA9780043;
	Tue, 20 Oct 2026 13:16:24 -0400 (EDT)
Received: from stl-imap-11 ([10.204.2.102])
  by stl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 13:16:24 -0400
X-ME-Sender: <xms:6KHXaknjuljWSJ_gLoTQgYf4xJWg4wNsu4fklN3FpLLgaVvabsfADg>
    <xme:6KHXauovoWDDRjZBCpZ0xEraTP2R4PyIicQXMd88LxekLG6Miu8rvmM-vPsnST9PK
    4VIMUx_O8Egp_ftDXFFX2yoqiempAWZnUWpIS_JYpPMs8rpu0TkTpBB>
X-ME-Proxy-Cause: dmFkZTGotKvzjS3n3TRZ0v50m6h3cI6EI0s9z7DT82iBKKE6Q15vLsJzsPvrUeyFhM+Osf
    gQCGSN/0gacl8Z4ETxw3tPKML9dTO4lVuF/F1klvXVv8yGO3r/A3uaav3XzkLOIXYLTMZz
    FFsqF7wAcYpunmwtjqbgXO0l1J4vjGUPW6oukba4cH286gSRIKuXCdz5R98K1OWeaG2m+k
    MQ5HP8jlxADzy9DwGV3VVFP595AkljBUghI3tobW5bE+wnH3T+cxf5UYbM2ZjuXpOuS5bo
    V+Qg4/JbI5PY79uavQTDd/cYy4kHuix8Glymj2Al+JPFRjDOnkjOLZwG9ETDzscip1bYOY
    boWxRTt+GnnWCgRyKBro300WrNS4yllkq7ZKa6W6h0Krfze99kR9JzADcwZ4HiFzM9MvXk
    gdlIsp10OKuK7h0B4l6Lsd6D5IdrwYy2teubhp4ZYsB8ke9VRntGr6uyrRA/O3fA2iV3FW
    Yq1kfPcYST2wK+XfBgxH3qpcHK/xlCgl6APcu1M8SWveBuoA1Gy89zuQ90MiSfiw0mIBsU
    X5dQ1zUbmUCRuvYprsMEfe4l+dnZyJ824lFTaa8BcDRRR3kz4tEviUxn6mS1SPl5tHjq+j
    w9XhYuXSMm3szsIbxNLwfxDLxoUALkZOiu5JN79H+ofWPCDS7pOX/VRTVbMQ
X-ME-Proxy: <xmx:6KHXattWU7Z3Sqk_rm8d5sLXgOXTtvCqoV1ea75btZEI9bRYUnuK3w>
    <xmx:6KHXanY7oblVJYgKYCBiV8pQa6UjratFWQJW9r93TNIGhewYvMYcNA>
    <xmx:6KHXahFbh-gKBMmv64oWRzKlg9qBMbTS7C8NzsEgJv02Uks0cT-lQg>
    <xmx:6KHXairWoPyUbXedVnIjMBlVV5o4AyWXqIw72jOkHezuCsVdipRqAQ>
    <xmx:6KHXakyOkqXNqfvmKNMo2342wwN0RdRYFen0Myp055u5RKEa_tIF-tXz>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 7780619C0067; Tue, 20 Oct 2026 13:16:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 20:16:04 +0300
From: "Leon Romanovsky" <leon@kernel.org>
To: "Logan Gunthorpe" <logang@deltatee.com>,
 "Popov, Pavel E" <pavel.e.popov@intel.com>,
 "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Jim Chow" <jim.chow@broadcom.com>, "Radu Rugina" <radu.rugina@broadcom.com>,
 "Alexey Makhalov" <alexey.makhalov@broadcom.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Michael Kelley" <mhklinux@outlook.com>,
 "Nathan Ciobanu" <nathan.d.ciobanu@linux.intel.com>,
 "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <2db83aed-1137-49a2-99a6-1369f163c273@app.fastmail.com>
In-Reply-To: <db26b21b-8416-4b11-aed8-3829ed5a6cfa@deltatee.com>
References: <20261020161447.GN64621@unreal>
 <20261020163758.GA2342476@bhelgaas>
 <LV2PR11MB6070444E927B9AA891B8180FB2672@LV2PR11MB6070.namprd11.prod.outlook.com>
 <db26b21b-8416-4b11-aed8-3829ed5a6cfa@deltatee.com>
Subject: Re: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Oct 20, 2026, at 19:54, Logan Gunthorpe wrote:
> On 2026-10-20 10:47, Popov, Pavel E wrote:
>> If preferred, we could use for cpu_supports_p2pdma() the pattern Logan
>> suggested for hypervisor_supports_p2pdma() in v1: the whole function
>> under #ifdef CONFIG_X86 with a stub returning false for !CONFIG_X86.
>> The Intel CPU list then moves into the same #ifdef block, which saves
>> one #ifdef, at the cost of also touching the existing AMD part.
>
> I personally would prefer cleaning up the #ifdef style but that's an
> issue that's already in the code. I don't feel the need to make it
> conditional on my Reviewed-by. If you are able to clean that up, I would
> appreciate it.

Sooner or later that cleanup will be done, and I don't see any reason to delay it while we are touching that code anyway.

Thanks 

>
> Thanks,
>
> Logan
