Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B722853FD
	for <virtualization@lists.linux.dev>; Fri, 19 Dec 2025 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766111267; cv=none; b=u3fn+hn5XN0WfM4VbHA2uPBEamfQQpvpV9EwDBU6PLBnK4zFQo4N2lef34fRBV7b0VfIN0F7rt0cPaip0fU9un43bPZ2Mij4S530WCHN0z7g14Ey+MXd+Sh655F1HuDkcOUD7f0T0dyRLbDTyo0Xx6TAfzstqpCjywWK4tH5sp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766111267; c=relaxed/simple;
	bh=zzWTfLen8COuX/q/sKLUzJAtj9cSvrwCqbBUYVz6l10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=dtNoeI5zE1jjcwuJiL/vR3ynZ5k6uIIHu1glOMnyNy5TrnzlPD9Dmd0X1WnZDJvyMQ74LJkcfVIKTcGvxC94A/mgHOkQb7nz9f7hHyKIKzisRY7rUEjDwe+jfw8WhL7wVB0KOzFWdLz8+MK0XKmBNmYK2yDjIKjWICp7iGg7ItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f9b6Yn9l; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f9b6Yn9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zzWTfLen8COuX/q/sKLUzJAtj9cSvrwCqbBUYVz6l10=; b=f
	9b6Yn9lpfldBIebFac8ZhjCAfipn5whg40ODcftNj/pMJAS2/R1nEXKECOUF7mwa
	7En0Kk5Lg4n9rU5PPO6f68NY4XANcZg8Fzn5k6pqs6vSexPCUr0vRBgls48z1Tnh
	g5amu67ah9mCP9PLJqN6C0uL0XSMwEiycAExhK7HFg=
Received: from 15927021679$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-107 (Coremail) ; Fri, 19 Dec 2025 10:27:09 +0800
 (CST)
Date: Fri, 19 Dec 2025 10:27:09 +0800 (CST)
From: =?GBK?B?0NzOsMPxICA=?= <15927021679@163.com>
To: "Leon Romanovsky" <leon@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	"David Hildenbrand" <david@redhat.com>,
	"Jason Wang" <jasowang@redhat.com>,
	"Stefano Garzarella" <sgarzare@redhat.com>,
	"Thomas Monjalon" <thomas@monjalon.net>,
	"David Marchand" <david.marchand@redhat.com>,
	"Luca Boccassi" <bluca@debian.org>,
	"Kevin Traynor" <ktraynor@redhat.com>,
	"Christian Ehrhardt" <christian.ehrhardt@canonical.com>,
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
	=?GBK?Q?Eugenio_P=A8=A6rez?= <eperezma@redhat.com>,
	"Xueming Li" <xuemingl@nvidia.com>,
	"Maxime Coquelin" <maxime.coquelin@redhat.com>,
	"Chenbo Xia" <chenbox@nvidia.com>,
	"Bruce Richardson" <bruce.richardson@intel.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	"RDMA mailing list" <linux-rdma@vger.kernel.org>
Subject: Re:Re: Implement initial driver for virtio-RDMA device(kernel)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20251218163008.GH400630@unreal>
References: <20251218091050.55047-1-15927021679@163.com>
 <20251218163008.GH400630@unreal>
X-NTES-SC: AL_Qu2dBP2avkop7yKcYukfmU0VgOc9XsWwu/Uk2YRXc+AEvhn91i0NcGBfB13x3/C3Cw2orgSHdD9v4+NFc5ZjnscnuIaIph6uoKKQX33d3Q==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <7076944c.4ac4.19b346eb549.Coremail.15927021679@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aygvCgBnhST9t0Rps8U_AA--.11607W
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0R2YIWlEt-1cmgAA3U
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgoKQXQgMjAyNS0xMi0xOSAwMDozMDowOCwgIkxlb24gUm9tYW5vdnNr
eSIgPGxlb25Aa2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBUaHUsIERlYyAxOCwgMjAyNSBhdCAwNTow
OTo0MFBNICswODAwLCBYaW9uZyBXZWltaW4gd3JvdGU6Cj4+IEhpIGFsbCwKPj4gCj4+IFRoaXMg
dGVzdGluZyBpbnN0cnVjdGlvbnMgYWltcyB0byBpbnRyb2R1Y2UgYW4gZW11bGF0aW5nIGEgc29m
dCBST0NFIAo+PiBkZXZpY2Ugd2l0aCBub3JtYWwgTklDKG5vIFJETUEpLCB3ZSBoYXZlIGZpbmlz
aGVkIGEgdmhvc3QtdXNlciBSRE1BCj4+IGRldmljZSBkZW1vLCB3aGljaCBjYW4gd29yayB3aXRo
IFJETUEgZmVhdHVyZXMgc3VjaCBhcyBDTSwgUVAgdHlwZSBvZiAKPj4gVUMvVUQgYW5kIHNvIG9u
Lgo+Cj5TYW1lIHF1ZXN0aW9uIGFzIG9uIHlvdXIgUUVNVSBwYXRjaGVzLgo+aHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjUxMjE4MTYyMDI4LkdHNDAwNjMwQHVucmVhbC8KPgo+QW5kIGFz
IGEgYmFyZSBtaW5pbXVtLCB5b3Ugc2hvdWxkIHJ1biBnZXRfbWFpbnRhaW5lcnMucGwgc2NyaXB0
IG9uIHlvdXIKPnBhdGNoZXMgYW5kIGFkZCB0aGUgcmlnaHQgcGVvcGxlIGFuZCBNTCB0byB0aGUg
Q0MvVE8gZmllbGRzLgo+Cgo+VGhhbmtzCgoKU2luY2UgdGhpcyBmZWF0dXJlIGludm9sdmVzIGNv
b3JkaW5hdGVkIGNoYW5nZXMgYWNyb3NzIFFFTVUsIERQREssIGFuZCB0aGUga2VybmVsLCAKSSBo
YXZlIHN1Ym1pdHRlZCBwYXRjaGVzIGZvciBhbGwgdGhyZWUgY29tcG9uZW50cyB0byBldmVyeSBt
YWludGFpbmVyLiBUaGlzIGlzIHRvIAplbnN1cmUgdGhhdCBzZW5pb3IgZGV2ZWxvcGVycyBjYW4g
cmV2aWV3IHRoZSBjb21wbGV0ZSBhcmNoaXRlY3R1cmUgYW5kIGNvZGUuCgoKVGhhbmtzLg==
