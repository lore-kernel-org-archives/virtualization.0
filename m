Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66C158DC2
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637615; cv=none; b=j0Wb21C60d3biaXLbn6lBf+iZduR6EAHJ62l3RdSXaq45aHN6xtKgO9fIp3G1Qf9pE3g658kaNcEhwHYc+A5DQe42SKl8QTczV2iqCRFDLOB5O5LRCR9kNpjtoqehq+IwOzF59ewEjoBzAatAFvznPg0TxXfdeCAx8uJdvnnU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637615; c=relaxed/simple;
	bh=9jJLrF/6NbGsgQCvXVBt2x6elX8/EKdyI2Lp4Ov7Puo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHwA/VV0y5q4Cqj84d2jqbNvjC4aktGzLQ1nBCYTS0bC2JgHUQ3Lvl8tIV+1UnDdfYZo03pwpxgy5pnl9hUABzjjt8wDj8ERm0GlhCyuu6qFWwF5sMWSCdrwBgHj62Th2atrK+CsB2MoX8vz++lYhvzLlJlz41YtlALGJIOq1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0Egcz5w; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0Egcz5w"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74D1181368
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 15:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-lggCkhfhsA for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 15:20:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 326F68135E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 326F68135E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b0Egcz5w
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 326F68135E
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 15:20:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C0099CE0F19;
	Mon, 17 Jun 2024 15:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34F1C2BD10;
	Mon, 17 Jun 2024 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718637604;
	bh=9jJLrF/6NbGsgQCvXVBt2x6elX8/EKdyI2Lp4Ov7Puo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b0Egcz5wY6JJJbRJH2mJFg5nSWE0RQ5nxe5jOaXHpK9HpjJ270esJtCpRCwruMWTW
	 x/4mrJFaVgVt40jkUhq1qLNGp6O8JxSI9UGq0OrBHx1rRZTG6wxvjPOn/ppwm+X3gK
	 KfvHbXLD6U1YdS6Pyv+YwJRI4b9D3g09o9ptfDy3eGr3QZ09ipRA8XBbb3+LasYFhz
	 hawzEYBp85tfKfU+/HYlzhr6LRN0JA7plSXGNpLbX/lsuAiB5QoQ6lQqnzqtPxXT7D
	 2AVgXredJjvRuuaV+5J+6qF05XljQaer6vA0zYiKH5VTXS7OIyLVZ+H8lPlIm/ZBi0
	 uIlvM5Ke9jjyQ==
Date: Mon, 17 Jun 2024 08:20:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>, Jason
 Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240617082002.3daaf9d4@kernel.org>
In-Reply-To: <20240617094314-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
	<20240611185810.14b63d7d@kernel.org>
	<ZmlAYcRHMqCgYBJD@nanopsycho.orion>
	<CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
	<PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
	<ZnAETXPWG2BvyqSc@nanopsycho.orion>
	<PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
	<ZnAgefA1ge11bbFp@nanopsycho.orion>
	<PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
	<ZnAz8xchRroVOyCY@nanopsycho.orion>
	<20240617094314-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 09:47:21 -0400 Michael S. Tsirkin wrote:
> I don't know what this discussion is about, at this point.
> For better or worse, vdpa gained interfaces for provisioning
> new devices. Yes the solution space was wide but it's been there
> for years so kind of too late to try and make people
> move to another interface for that.
> 
> Having said that, vdpa interfaces are all built around
> virtio spec. Let's try to stick to that.

But the virtio spec doesn't allow setting the MAC...
I'm probably just lost in the conversation but there's hypervisor side
and there is user/VM side, each of them already has an interface to set
the MAC. The MAC doesn't matter, but I want to make sure my mental model
matches reality in case we start duplicating too much..
