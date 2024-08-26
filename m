Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2284A36
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653604; cv=none; b=RwUwvaFjYVtHuk+nH29nYDz+oMWkLhZQ2aYmPkmlwagzZvLFx8Y/nC488FPwGyVpgpqaTelEu6GB47nHKMHRYXCbnyHbBRAVet60oQ64VK2jO21ctLXYNYOTMZCPekily03dZQKkKv0JK6zzf9eO4m7JiNdicvwsn0y5vyLYKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653604; c=relaxed/simple;
	bh=w3vkaU/W58T67d5XGiPbxPt/8Wedb1k+JGHJTDvaXCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhe/NOPWeaVIpzqyZRT2khLYHREwckz7ciAqY0fsWpTNd76mGIvYFOuAKBs75RQR11ETkKoosROW9ZwFK9m518HWjeV/TIMrT6KHvogXWaPliNYFncb34mhTUGICcgJGg07mcJekIrOOJDpOwpHrw4Ce4tIHLRMbCZB3aV50T+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p9Z/ladn; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p9Z/ladn"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EA9381000
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 06:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.398
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CDSLTLr0w2kk for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Aug 2024 06:26:41 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+7bd792e84b2a1d702da5+7673+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7DF3A81003
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=infradead.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DF3A81003
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p9Z/ladn
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7DF3A81003
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 06:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eCVG55oExUlYL1Z32e3+q8IKV8QnAIYOma6x23vOJvQ=; b=p9Z/ladnB/WXP8DuuRoIRzyqIL
	R6lSpSZC4U4G1gMP9uTSPVmnP+verPYl3JnbR/UjLxaiadUWK3Ds9mlKbKV0lVhcM6CnBvQYV3OqV
	vwDYHqPO/CjXsMmnmH9o6WWQPWYFa7CcpGfQ3eBfvNH9Ylgsj8rwfrzm8M0dOYpqIxHUu3b7z22j3
	ndNzCUezI3EaDRPaFPeoD3feobwO+oCVOR9iGc2vPflfS7GJJzj2QK/UaVu2JnGaNzCAS/JbbSH9J
	6SM12cEv/5qGNYmH7NUvRhLWP0TBG1R/b0Y1LCwATRRaVuGgaL5lE4K+shTz8/801cUnLXKgmMIX4
	mZIOtuog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siTBV-000000060kI-0nfR;
	Mon, 26 Aug 2024 06:26:37 +0000
Date: Sun, 25 Aug 2024 23:26:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Cindy Lu <lulu@redhat.com>,
	mst@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
Message-ID: <ZswgHTRUR-wstAHf@infradead.org>
References: <20240819092851.441670-1-lulu@redhat.com>
 <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org>
 <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 26, 2024 at 02:21:52PM +0800, Jason Wang wrote:
> > What is the application visible behavior that the API use is the proxy
> > for?
> 
> Vhost used to be created by kthreadd but some recent patches change it
> to behave like being froked by the owner. So the various attributes
> that interhit from the parent has been changed (scheduling and
> namespace etc).

Well, if that breaks userspace it needs to be changed to opt into the
new behavior rather than requiring a flag to not break the existing
applications.  Assuming the change is intentional to start with.

