Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31297330B34
	for <virtualization@lists.linux.dev>; Fri,  6 Feb 2026 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349509; cv=none; b=hVr8Usvx5tjjwDe2q1K164mLyifDNzA6D5O8XCZ+U16OtJe4gVxi3xEM9ANhPi6u46WKrHxSN28JgspQX+eCzbvR9wXRvrj77iQoKPwK0jfGXS0OV8Hx6XayQ9vf74PdEWakR2uPyzv7D9naP3xQ/eFnE+RA1SeDQIBPN9/E7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349509; c=relaxed/simple;
	bh=hnE5I4/wZ5Znpn5z3YA2kW21UHAlwuw/qzxayvYooEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbOEF8hH5unFh8aYq5bvEaHLhNBVKKbxj/+cROp+pg8k5kcSE0al/Y9Ik586os+vTNix7KPdglRJnmwfk8s0HSDT/Gcuv+couK+vCO9Ya7481Y0LoHRxZAo02HBm18higNfH3OgOTGIMueQRl1NJK5qlzX7NuTp15nRKSvabvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=dTfWH5Zw; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="dTfWH5Zw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1770349508; x=1801885508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IuPnlqREwJB3pbqSqs+4wA7Rlfs308sbPiaPxE9gRow=;
  b=dTfWH5Zw+fniwU0SfLL1uN5236QTcNYLv52mUR77XDjz52FGxMYMEwJS
   /JYJfTMoiemqN5XLJXMpUUJ8LOZzKx2gNqpCPAj2JNlkO0ND8XvX+ZfwG
   Rl54slWblphePaBX2SLVX8julAYUI7fs4/TtI2nguQeT+McyZTOiygpH+
   JmvzVc37cVaOeMpT2LssdDjADIgvkdzdtOQreQtmg2d61eGv2AZkqYjuO
   9GpShauS2hi46yoBr9fiKw3plm/xA6p5gi5jMELICrUCoZgp2RihFYXzv
   t8eyVcPsGSLB3MwgCLVWVrwsSJKG7VHkAZNfgNyn5QgamFWfGCICSKZ2P
   Q==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 12:45:01 +0900
X-IronPort-AV: E=Sophos;i="6.21,275,1763391600"; 
   d="scan'208";a="578775205"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 12:45:01 +0900
Date: Fri, 6 Feb 2026 12:44:57 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org, Rahul Bukte <rahul.bukte@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Tim Bird <tim.bird@sony.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/x2apic: disable x2apic on resume if the kernel
 expects so
Message-ID: <aYVjuSkdOlBh06_S@JPC00244420>
References: <20260202-x2apic-fix-v1-0-71c8f488a88b@sony.com>
 <20260202-x2apic-fix-v1-1-71c8f488a88b@sony.com>
 <0149c37d-7065-4c72-ab56-4cea1a6c15d0@intel.com>
 <aYMOqXTYMJ_IlEFA@JPC00244420>
 <722b53a7-7560-4a1b-ab26-73eeed3dffa5@intel.com>
 <aYQzhRN83rJx6DSb@JPC00244420>
 <e5ac3272-795b-488c-b767-290fd50f2105@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ac3272-795b-488c-b767-290fd50f2105@intel.com>

On Thu, Feb 05, 2026 at 03:18:58PM -0800, Sohil Mehta wrote:
> Maybe a warning would be useful to encourage firmware to fix this going
> forward. I don't have a strong preference on the wording, but how about?
> 
> pr_warn_once("x2apic unexpectedly re-enabled by the firmware during
> resume.\n");

That works

> A few nits:
> 
> For the code comments, you can use more of the line width. Generally, 72
> (perhaps even 80) chars is okay for comments dependent on the code in
> the vicinity.
> 
> The tip tree has slightly unique preferences, such as capitalizing the
> first word of the patch title.
> 
> Please refer:
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes

Thanks! I noticed that I also didn't use '()' for function names in the
commit message. I'll fix all these and add the pr_warn_once in v2.
