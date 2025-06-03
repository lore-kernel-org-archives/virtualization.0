Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625D269AFA
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748936071; cv=none; b=MhRN5vwAospwKd2mmqVXNTbd4BHE+t23IoTAmOx4W0NTSNV74FF0HD4GNmtBxWj7Hy7zucL4gBL8n7Guh0siGp0pqbPSzlr/Wmn4GdkB6/1cTpk8ND81FDZPQch2wfBQpzUUfRcHJ0tmMoyC7wLcLnKtPuW5tJgj93QyKzYUdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748936071; c=relaxed/simple;
	bh=M60ItkNS6CkN2L+hERTegzxapFRD6j6tnT2kUl6gmi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0thQwH4ORcR7vtDd0LyKpWXmDd012zxLiIDMONul8yS6BBN86A5gCAyCthk8UDjIkoZxTIPkR1WS+PWdUpbHMdmkJ/iH7YBw+N9Waj/OOAuMg0aICJ66VniyLN1SEj3q7HHDdJtwsSWJcHDjQuSiv2FvdT3SgHdjvE22TAAKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ/bmAU3; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ/bmAU3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EA4160F5C
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 07:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXUBSedzHVTD for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jun 2025 07:34:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EC0B860EC9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC0B860EC9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eQ/bmAU3
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC0B860EC9
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 07:34:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 71929A40BF2;
	Tue,  3 Jun 2025 07:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C24C4CEEF;
	Tue,  3 Jun 2025 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748936067;
	bh=M60ItkNS6CkN2L+hERTegzxapFRD6j6tnT2kUl6gmi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQ/bmAU3Jx2Eng1iDwm5+ctRReKECf2qpsZN7nwKlVwohV12FxbUQn05+0JlsJYKC
	 FCWC7XPBYoKKcOykLhhimycjYAzIqk4OWyi2RcWizYHwtAjYENL2lbfI6oBSMQEqIV
	 0n1yNaVFDsoa6LsG5ovRwXy4JfP1W1IvVFJbNoFd7lveT7cUHh/4Usy+1xMt+JOfZZ
	 ddznlAFTZMGJz0lkAMpOrky4FnlZHyvwUi+mznEntyCVSt/dqmHFBX9+8Ytngt8l8i
	 BMDt3bT8o2y6JgktlLCNuBMMnen0tXKQ6/5rF/z08cVfFyHA9A3Cc7y6deesRLIxDg
	 2BeIZvjH24E9Q==
Date: Tue, 3 Jun 2025 08:34:23 +0100
From: Simon Horman <horms@kernel.org>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND v10 1/3] vhost: Add a new modparam to allow
 userspace select kthread
Message-ID: <20250603073423.GX1484967@horms.kernel.org>
References: <20250531095800.160043-1-lulu@redhat.com>
 <20250531095800.160043-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531095800.160043-2-lulu@redhat.com>

On Sat, May 31, 2025 at 05:57:26PM +0800, Cindy Lu wrote:
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles, it confuses some
> legacy userspace applications, therefore, we are reintroducing kthread
> API support.
> 
> Add a new module parameter to allow userspace to select behavior
> between using kthread and task.
> 
> By default, this parameter is set to true (task mode). This means the
> default behavior remains unchanged by this patch.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c |  5 +++++
>  drivers/vhost/vhost.h | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5ebb973dba..240ba78b1e3f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
>  module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>  	"Maximum number of iotlb entries. (default: 2048)");
> +bool inherit_owner_default = true;

Hi Cindy,

I don't mean to block progress of this patchset.
But it looks like inherit_owner_default can be static.

Flagged by Sparse.

> +module_param(inherit_owner_default, bool, 0444);
> +MODULE_PARM_DESC(inherit_owner_default,
> +		 "Set task mode as the default(default: Y)");

...
