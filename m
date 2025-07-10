Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD398263892
	for <virtualization@lists.linux-foundation.org>; Thu, 10 Jul 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154921; cv=none; b=P1tas6/JIIUf7yCnRSlJz2kUhopdiR/yTPKFNmftivyV/MpJEqP9jxgFOAag1lFQ7UQc0QkMvXVCFcJWMbsXLQESrkOojXNuBkC//yOzpsFBBXr4cKTtRl6uaw+Y9/PVVjMuuPCuSXYiqWwqVv+xhy6y1FQaL48sT5Re+b18wtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154921; c=relaxed/simple;
	bh=R3wYP0vZ7YSmBqpNoEZUZ3lDqGlCvdsW7hEuwVuKihQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbV1EZR/klQW5qlu/iI3NKTuegMWXpkBQ/S8meahdv8MNzG33je9lhq9HamYz9TaCBMkB1B9eBt3hUBGalgolPptJCxQeUlI9yHnZgQw5gNgKvGdA5GhHtzS6b0QU91cCSpGnl/WHGgfOyN/IBrIurYG8TaCu3wRlbM+vbCvsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4Rpgmm/; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4Rpgmm/"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7772B40A26
	for <virtualization@lists.linux-foundation.org>; Thu, 10 Jul 2025 13:41:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m49gbcSJj5YX for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jul 2025 13:41:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C7A9A409AA
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7A9A409AA
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=f4Rpgmm/
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C7A9A409AA
	for <virtualization@lists.linux-foundation.org>; Thu, 10 Jul 2025 13:41:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 06613A54ACD;
	Thu, 10 Jul 2025 13:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9FBC4CEED;
	Thu, 10 Jul 2025 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752154916;
	bh=R3wYP0vZ7YSmBqpNoEZUZ3lDqGlCvdsW7hEuwVuKihQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4Rpgmm/twVfUpYQGZNjRzqk2ZZbkdYqa9MVPVVC56OHPtCAtG2ANZPnmZXqvwDgB
	 cWeWM7bGkQiqtr8ZDlXL8b8dHU55LwAWkrT826GrHv4J98NcCJXsfRFHkCfxSlN1WD
	 CjCs/ppOK4le0TF+O0CHucdjPy5QrG8ty28wPa/U=
Date: Thu, 10 Jul 2025 15:41:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xinyu Zheng <zhengxinyu6@huawei.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
	stefanha@redhat.com, virtualization@lists.linux-foundation.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5.10] vhost-scsi: protect vq->log_used with vq->mutex
Message-ID: <2025071002-festive-outcast-7edd@gregkh>
References: <20250702082945.4164475-1-zhengxinyu6@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702082945.4164475-1-zhengxinyu6@huawei.com>

On Wed, Jul 02, 2025 at 08:29:45AM +0000, Xinyu Zheng wrote:
> From: Dongli Zhang <dongli.zhang@oracle.com>
> 
> [ Upstream commit f591cf9fce724e5075cc67488c43c6e39e8cbe27 ]
> 
> The vhost-scsi completion path may access vq->log_base when vq->log_used is
> already set to false.
> 
>     vhost-thread                       QEMU-thread
> 
> vhost_scsi_complete_cmd_work()
> -> vhost_add_used()
>    -> vhost_add_used_n()
>       if (unlikely(vq->log_used))
>                                       QEMU disables vq->log_used
>                                       via VHOST_SET_VRING_ADDR.
>                                       mutex_lock(&vq->mutex);
>                                       vq->log_used = false now!
>                                       mutex_unlock(&vq->mutex);
> 
> 				      QEMU gfree(vq->log_base)
>         log_used()
>         -> log_write(vq->log_base)
> 
> Assuming the VMM is QEMU. The vq->log_base is from QEMU userpace and can be
> reclaimed via gfree(). As a result, this causes invalid memory writes to
> QEMU userspace.
> 
> The control queue path has the same issue.
> 
> CVE-2025-38074

This is not needed.

> Cc: stable@vger.kernel.org#5.10.x

What about 5.15.y and 6.1.y?  We can't take a patch just for 5.10 as
that would cause regressions, right?

Please provide all relevant backports and I will be glad to queue them
up then.  I'll drop this from my queue for now, thanks.

greg k-h
