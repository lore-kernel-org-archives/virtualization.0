Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA438CFEE;
	Fri, 12 Jun 2026 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266593; cv=none; b=YNB+DJlrHsce+oARk+lhXm258984TLWXfDeJ6AQH3Sh0QWWLAz5LFqzEj8gEOG3CUp2Sf7asOOM/Klos4HxXnn3FbUTkKBw+ormr61d3oAOx6PEYTMKnP8+JowLCtTuA5Kt17WoRTCNXQk0K7FDfRYGhqQZ7l1YKGyFf9+SkkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266593; c=relaxed/simple;
	bh=MvRdm06rZKMbO4EVPd6yMwfwCQ0klR2fBkQwcF8Stvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2Gs6K3n61mcitcGC+OCEWWHfHyQAuNIR/IXNYv3WLYil2hsoQAPK+pkZwp7xdjo4qElOxKLXHY0Zo7I00mcfPjNAQYCkIJOi0tvoxm53XNo24in/nqJmpGxcNYX2TwLshagp8GpNG/90o++reAseojbYcVnpnDyOIbYzJywyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilOHRK5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilOHRK5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAD71F00ACA;
	Fri, 12 Jun 2026 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781266588;
	bh=vGSmBF5h/RB7YTZKVrW5RE/2VVRMk2vSn9DGHLEhNAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ilOHRK5NxfK+8CMEHirbyAVSAbwnxSzWviTQWCjde5sTf/fnHpJsGkN8vrA/+gMJ4
	 PBNg+6059F67G2PQ99a+ExpxozmmTyRRr0s10tnVnrj1HqrQDHv77mm91joJg8bmbh
	 EpFyiwVjVnlyW020f+0QxuPe+y5JiRzSRBokkT1znbPZASAT3+vZ+OYXW5OLZ6dA0w
	 19sWfh0x/I60N3l0dGnt/8LaYAbAtXA3brSM9ptC3PgHJ5ynL5hKgIUBt4yhwiX657
	 XPNo4MVdLt9OIP7uJKwOI9hH0N2wF6Xsls9TmqKX45cSe/hXV5Nd91oD0qbja3JxK3
	 0rP1jPPxKIzOQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 864B0F40071;
	Fri, 12 Jun 2026 08:16:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 12 Jun 2026 08:16:26 -0400
X-ME-Sender: <xms:mvgrahfHv5ucDfXZPU3L_z3IJvmBFU8aLkHSLuLqVWxQOXDYPdve7w>
    <xme:mvgrar-YH7d_KdHb_u2D20mLJaProiRTUTPhem78kHvYsJjP0srdX0p1J9AhwVNT_
    Qo16y_hJgi03Y3LrdmNdjiLpye5_VYsDFT2qfFzxMwmYfwsW-Ou2jjw>
X-ME-Received: <xmr:mvgraqFt5ZWDHBAnvZLDGDLZ-YshATccsY3jkh_CL-cXC0GQnphGiISo4qO-2A>
X-ME-Proxy-Cause: dmFkZTFbfEtKxAiJn+RDHCKs45grmHsr1zwKvodZPkvAIZ8fB4SoZtWnknwhT7REpXww6k
    ykBlulBGR/YL27mjhMYp61FWNmZImoaHOZWagnAIwvcl7gogKHEqP+aYvfa8PAhrHIC0Qg
    FC7QxWX/gwM3xtgtOncU3vmwyGk6BYMndynAmcNQ+nIzqK9eB3lkiPqXK4WrpPIKNObQYD
    p8kzdHx1s8whj5W2jUDYuR2gmDyeyuo5v6ZgKXgUCcFpTRSAk+CIqGzzKRml33fPQADjbE
    wbH1NmZ6FXdY2xxLACCOWIH6oEieZLwVpaUaVYJySSKVXTdmetmwDfZ7LMLDkyk0P//MCA
    ErvJjrfeoDaoJGNz/RKrnKA/L3u9wwF5H6Jw/KE3L7P9EKw8J+kjkj2gqU3wcUOIniNWta
    XEPhEqLaVTibEZGdx7vaBICQc/vY4uG4Y7Lc9RWkGxXOZoemTLqB4FrOvG4XiOze12NnRp
    IJvCuEcIp1QM4gxJzt4wzyKgn9xnTxDbBIL/a0Df6PQuxv6HZaEeZELGfUSyhGa8QFU9Qp
    JlqYJZCQ3V1TVnPB2F5CPHm3pMcUhR7cgjMWn/4ZYcPeawzpfxPLGMaaUqVhHisiN7YPAn
    EjiM7gbxe6kGz100FQz0aEm93th5Fq3IZQs4tsBAIuROHVn3d/sS57XzW+Jg
X-ME-Proxy: <xmx:mvgrajmu_nQSq1bG1--aWfqecdsMwesgMwN6OCXdD6RJOXdcyMI0PQ>
    <xmx:mvgrah_H7TIQ4awmDCk7C58V3ncCQuGyeu-zHl0dQsVm_s3CHzOogQ>
    <xmx:mvgrapDmkBetTxj97vBcMxv2I2GPV6x5tDrmSgp9ypAh7TcYXUJ0UA>
    <xmx:mvgraq15KZvZRBWVBOST9In4Sxp0H7xBwMW6CiU1qR-ztS5X_-Q4-Q>
    <xmx:mvgraormrZOfUXpFhc6mE6RChXT2xlWbvtGFHEhEOB1JGoYojlpnj7Pr>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 08:16:23 -0400 (EDT)
Date: Fri, 12 Jun 2026 13:16:18 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: marcandre.lureau@redhat.com, david@kernel.org, 
	rick.p.edgecombe@intel.com, prsampat@amd.com, pbonzini@redhat.com, mst@redhat.com, 
	peterx@redhat.com, chenyi.qiang@intel.com, elena.reshetova@intel.com, 
	michaeluth@amd.com, ackerleytng@google.com, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, x86@kernel.org, 
	yilun.xu@intel.com, xiaoyao.li@intel.com, chao.p.peng@intel.com
Subject: Re: [RFC PATCH 0/6] Support virtio-mem memory hotplug in TDX guests
Message-ID: <aiv0y-Op9bfP-CVO@thinkstation>
References: <20260604093551.1511079-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604093551.1511079-1-zhenzhong.duan@intel.com>

On Thu, Jun 04, 2026 at 05:35:45AM -0400, Zhenzhong Duan wrote:
> 2. Re-accepting already-accepted memory returns errors. Ignoring these errors
> can mislead the guest into believing re-accepted memory is zeroed when it
> contains stale data.

Re-accepting concern is valid, but often overblown. Reaccepting memory
that never got allocated is fine.

> == About this series ==
> 
> This series takes a different direction, supporting start-private memory
> and addressing the limitations of previous series [1] by implementing a
> callback-based infrastructure that integrates TDX memory acceptance and
> release operations with proper subblock granularity.

You are presenting these callbacks as generic memory hotplug thingy, but
it is only plugged into virtio mem. ACPI hotplug won't accept/release
memory unless I miss something. Are you expecting them to cover non
virtio cases too?

And these callbacks feels like very ad-hoc solution.

> See Rick and Paolo's
> discussion about using TDG.MEM.PAGE.RELEASE in [1].

Having RELEASE in hotplug path without addressing private->shared
conversion first is odd. That's the most obvious path that has to be
covered first.

Hm?

> == Future work ==
> support lazy accept

It would be nice to have some outline on how we will get there to
understand if this patchset is stepping stone or dead end that has to be
thrown away later on.

Hot[un]plug is often used to manager overcommited host. Eager accept
might be counter-productive.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
