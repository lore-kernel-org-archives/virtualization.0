Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764782EAB82
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259106; cv=none; b=RErtzw/EdT8r0PM4VKB7Eom+fGntesxXUmCQz7E8sgiSlL0CyBjfPtdZeBRlcrr6oG6ADW4SsCzgWvodLHWZm7QseXxCmScEWMOJPGOZJYl+ErsR/GIySRhHoBGk/hMEEHI6R6BaI17slXNWRZ89Q/CwTJRJjP2Gp4CWPJX3A4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259106; c=relaxed/simple;
	bh=OS/a38wPwu2CZuiLDSjpOnSFIDOgby2Z6O0lK0fR6Tk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=HUl/pvgUgmcSyeD5p34IU1yN7I1z7au7ZrPauSMpPjFRceWwKktQYvY1FpgAvS0n+xufxUDlIqIgnBmfLI2UTbezjPoy1Dqra3X0iZWO8D3P4uAWekeRsaqe8YrlyAItA4eGFV/aI6Mz89oZp1LVM183JQU1+4tqjUKg5dUIpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 273D645DCC;
	Fri, 12 Jun 2026 12:11:36 +0200 (CEST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 net] virtio_net: do not allow tunnel csum offload
 for non GSO packets
From: Gabriel Goller <g.goller@proxmox.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
 Gabriel Goller <g.goller@proxmox.com>, Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <6c3b6c47fb05c100f384630dc48f3975cf37b67a.1781195144.git.pabeni@redhat.com>
References: <6c3b6c47fb05c100f384630dc48f3975cf37b67a.1781195144.git.pabeni@redhat.com>
Date: Fri, 12 Jun 2026 12:11:28 +0200
Message-Id: <178125908823.12688.1056224435757971178.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1781259045904

> Fiona reports broken connectivity for virtio net setup using UDP tunnel
> inside the guest and NIC with not UDP tunnel TSO support in the host.
> 
> Currently the virtio_net driver exposes csum offload for UDP-tunneled,
> TCP non GSO packets. Such packet reach the host as CSUM_PARTIAL ones
> with the 'encapsulation' flag cleared, as the virtio specification do
> not support this specific kind of offload.
> 
> HW NICs with UDP tunnel TSO support - and those drivers directly
> accessing skb->csum_start/csum_offset - are still capable of computing
> the needed csum correctly, but otherwise the packets reach the wire with
> bad csum on both the inner and outer transport header.
> 
> Address the issue explicitly disabling csum offload for UDP tunneled,
> non GSO packets via the ndo_features_check op.
> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Gabriel Goller <g.goller@proxmox.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Tested it on our testbench, consider:

Reviewed-by: Gabriel Goller <g.goller@proxmox.com>
Tested-by: Gabriel Goller <g.goller@proxmox.com>

-- 
Gabriel Goller <g.goller@proxmox.com>

