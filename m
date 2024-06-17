Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F00A16630E
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642666; cv=none; b=pg1LLkCueXzeVp78W+kwU2W8j2FjyITXx8R1LpiDWuaREDY4gl7FBncb81J+Km58sgaG60izfizy772dvW/YlCgirUsutkQv6AJD3Sg4gQdxCeFJOb9ohaF/UbkAebtWczocdGUafgXpF3Aj/85meEcUW4kY/YBpdXYB7AGqBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642666; c=relaxed/simple;
	bh=bAwok2w5sDP9uSS8/aitt6u/za/o92q1BPRXfbSXSF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X98O0IjuLqxSR7BEyR0OQCUOkvNsP8xM/Pg6Ft35GtpFyiWpOkY2eAjitpSBUTTfcuCM19d3GcvXrSlytvgsOJqEOGBLaBP8qpqQSPP1eh3pMseYDBkqEqC2ENjmxE26NJ7oSidoVuLKuidbIdPhEokjSXiyuUO4aBsfm0zaBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8Sl0b7q; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8Sl0b7q"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C378F60779
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 16:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6lKub-V8IYba for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 16:44:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2B3366072D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B3366072D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a8Sl0b7q
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B3366072D
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 16:44:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 01FC1610A4;
	Mon, 17 Jun 2024 16:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C045C4AF49;
	Mon, 17 Jun 2024 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642662;
	bh=bAwok2w5sDP9uSS8/aitt6u/za/o92q1BPRXfbSXSF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a8Sl0b7qpaha1QMp71OCXfr2vSE/3r1mHkBm3sV9wzCTAvWuz+r9jaKzuLAw1R9qd
	 ml/1W7WPnNouDIUN6XFg6c/Wrn6v8E/Z8YLKWcB6TJQwbaoOCTgbirmifO5tCbqDGc
	 bBm0c7TBMnKDom1KH6MiloCvC/dGCJp2H7VsfV5x8tYLPEbxVQzXNIA9eAVqB5t8c/
	 KGc6QIIOazLIm6TOMebtFp8IKjE+AQdWCa31uEv/GHIWgaFP286EZcGgR+5pjyav52
	 Cr7l63Iz11hPxGtu0iYBGyaYFiwRkuXU2EUXy9KCEZGn+thaGZSWrxanV0h/Fx+l3L
	 VPAtHMOncmY6Q==
Date: Mon, 17 Jun 2024 09:44:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>, Jason
 Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240617094421.4ae387d7@kernel.org>
In-Reply-To: <20240617121929-mutt-send-email-mst@kernel.org>
References: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
	<CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
	<PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
	<ZnAETXPWG2BvyqSc@nanopsycho.orion>
	<PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
	<ZnAgefA1ge11bbFp@nanopsycho.orion>
	<PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
	<ZnAz8xchRroVOyCY@nanopsycho.orion>
	<20240617094314-mutt-send-email-mst@kernel.org>
	<20240617082002.3daaf9d4@kernel.org>
	<20240617121929-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 12:20:19 -0400 Michael S. Tsirkin wrote:
> > But the virtio spec doesn't allow setting the MAC...
> > I'm probably just lost in the conversation but there's hypervisor side
> > and there is user/VM side, each of them already has an interface to set
> > the MAC. The MAC doesn't matter, but I want to make sure my mental model
> > matches reality in case we start duplicating too much..  
> 
> An obvious part of provisioning is specifying the config space
> of the device.

Agreed, that part is obvious.
Please go ahead, I don't really care and you clearly don't have time
to explain.
