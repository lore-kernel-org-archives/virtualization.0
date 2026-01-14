Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB539C655
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406075; cv=none; b=FH9++FpUrPEbdhchGR72wvEH/AG0ACeyvlyrZitliSE3qVUKpCOxMh7dCoZaab8nml2TBJnIqypw+90X430P95salVuR64z6qSIdXWZovTmsj5c2EERPp0bDcqjzfjt7euJ32pKGqUbky8gByjUv/h7z+xQMrnpyAytAV1dj0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406075; c=relaxed/simple;
	bh=vu8wNkY+ONyZ11dQOa1RhYbfZ6CIfKh+CDlvLi9Pphk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuMpfbjHgTA53D8M75VbJbfOokPNboLha9vFPxNUe+HwWMU2TTjp0B65MJVceFeZTv2fsNQvBqJ1FLfdHtrUzMxN1hsr1NZbF/hyI65ZFmtKmLyimvBQXvGMYLZeApudOw4tKnYRG0FUL5T256hmT30Dzh/9iUO6mkqBEBrL1yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTNxdkLs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTNxdkLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768406072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45w2Nqp7W5ReZCd4Up6qyFBRnRWCXaqu4990woCkPZ0=;
	b=FTNxdkLs580Jej2gBO999j7WnXjXV/oiyh6CaYfYx32F9HDsHn/WufFtmPAfxwLf4ryeS5
	y7tY9Hdqf58UN6TyLVIc6niWra2mtRrQaA34PGw5HqO9AKJf1FUu1UNX5H3XMfXsIZJOfP
	FnCfMdknoqT6Ez1FDcYaFubJiNXcp58=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-S1sKXu9IODetpBosHMCj9A-1; Wed, 14 Jan 2026 10:54:30 -0500
X-MC-Unique: S1sKXu9IODetpBosHMCj9A-1
X-Mimecast-MFC-AGG-ID: S1sKXu9IODetpBosHMCj9A_1768406068
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34abd303b4aso17688268a91.1
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 07:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406068; x=1769010868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45w2Nqp7W5ReZCd4Up6qyFBRnRWCXaqu4990woCkPZ0=;
        b=GCD97oiUtEHx7ILppkOd2MGAr+1/8jkY4eZBgxR4v1CyLXkcfbJs6EkBB/LEayKjYD
         txfA3uUsTKxkuzeT+BpuTUrnHtdpPTruWgLjUV4xmmivvOTCfeQX8/F46zhX1eJeKt78
         VRm1z9OJpv74Acupnt02s899UPxES/h4wGX5es5FCQUDaUgh+G1SDmnLE2sw1IrmLQGj
         C7NhzPLUK2yoPk2Z3LpCWVq7PV+a7/BmyMiZ3sJBn/8f78kAiZ2Je+SNA/HjJs0NLaGF
         wuC5HspOEWQiWhTKs72PQJVSrjRWywgvOcXNkboy/gNx+hSZDREicCAdHYiqosd0F/tB
         G6NA==
X-Forwarded-Encrypted: i=1; AJvYcCUse1oOY9NLcaz5Li4AMOHNu4gpoILItyidsAJOLt3eElX42HOitHy+oSYTrbJfkpNTSNzZWzzDjcl5Fc6Ajg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZVDus1UqMT5QN95F1gJqHG7vybqq1t3vdQTNz13hntd/ccVct
	tz8sBTmJFGWEuPc6zPSQpy9XTXPwo6CMM/3wx1Lq89BEvz2gsWu5u+6icC4hmCJDY2TPmW4qmHX
	49LVyiQB9TXmaE9tVis9n9ARyyroOyLbRy8nfEhgRXehDKit0zh0ptTyzBk/m0xCCDz5yELHYkq
	vGyCeJ2pedr6c2XjlQGCQ7G/z0I+/hwd/OxElKkcpDWMM=
X-Gm-Gg: AY/fxX4CoqyrfMU/Gfx+7lBOVE9AVUXxdWEQ5SCVl/cduU5IMIZ4rDffGKuhMcksYbW
	ribHf6nluY/y0/WU5YuUGRhAzRqLAvjuyQKEBZ+NXR7eC/pOxCJTaACDKtxR0avQOBJ4SDAxQ8J
	iXtorWytSgkiUxF52V+bIXysj7y9sbKRR0VBwYz/+AeWBjQj82PpR7FhdG3Ft+jcxJ
X-Received: by 2002:a17:90b:590c:b0:34c:f8e6:5ec1 with SMTP id 98e67ed59e1d1-35109163a89mr3116100a91.35.1768406068135;
        Wed, 14 Jan 2026 07:54:28 -0800 (PST)
X-Received: by 2002:a17:90b:590c:b0:34c:f8e6:5ec1 with SMTP id
 98e67ed59e1d1-35109163a89mr3116054a91.35.1768406067530; Wed, 14 Jan 2026
 07:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com> <202601140749.5TXm5gpl-lkp@intel.com>
In-Reply-To: <202601140749.5TXm5gpl-lkp@intel.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 14 Jan 2026 16:54:15 +0100
X-Gm-Features: AZwV_Qg5JTJCQi1Wwfd0jbkgP1qN1I8qkJH4vIis9H-XSIO4o_clOB-LFig_dcA
Message-ID: <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: kernel test robot <lkp@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Long Li <longli@microsoft.com>, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DNZs1HJ_Ynm8Ihd5HApTCF_ODqgWOb012DSry0ZVqpg_1768406068
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 00:13, kernel test robot <lkp@intel.com> wrote:
>
> Hi Bobby,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/virtio-set-skb-owner-of-virtio_transport_reset_no_sock-reply/20260113-125559
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20260112-vsock-vmtest-v14-1-a5c332db3e2b%40meta.com
> patch subject: [PATCH net-next v14 01/12] vsock: add netns to vsock core
> config: x86_64-buildonly-randconfig-004-20260113 (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601140749.5TXm5gpl-lkp@intel.com/
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> >> WARNING: modpost: net/vmw_vsock/vsock: section mismatch in reference: vsock_exit+0x25 (section: .exit.text) -> vsock_sysctl_ops (section: .init.data)

Bobby can you check this report?

Could be related to `__net_initdata` annotation of `vsock_sysctl_ops` ?
Why we need that?

Thanks,
Stefano

