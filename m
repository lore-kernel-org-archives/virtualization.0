Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78E1DACBE
	for <virtualization@lists.linux.dev>; Mon,  6 Jan 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161059; cv=none; b=rtjaUwaEI5/HOPr4Zhkm9HsmaYM795oLfBz7puevLmRWhoh76RsDh6rpbDp9KhYAirZKu/ryaExvE0y2ugQwq3oqdWP6VHxwAP1EYgAmzF3RfStmaEmu6ecbNPgzfNj3v8kcDcoIIlsdtIhngoC+ReXeK7QEcm4KWT5tStVaU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161059; c=relaxed/simple;
	bh=PE4GcSKp0lUdDqbIfdbZcJExRHuMRvf9+YtveZDL1nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpmPvJOdJ8zVqbyI88HeBEE6cuuUC6u7wr4I0C89/BdDUy8zktT29u+Md2uTQomoWtABQF9TGNDMQ1QXsYYCE5elgwFmt0dqvLmbIMEf4E8Z8DJ7FNDW2LS/lyfo9vQVgzc/ftiiB5FtSit12ZGn0ym70bEB/9Zsz3CeHWF02Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D08D68C7B; Mon,  6 Jan 2025 11:57:32 +0100 (CET)
Date: Mon, 6 Jan 2025 11:57:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 03/10] block: add a store_limit operations for sysfs
 entries
Message-ID: <20250106105732.GA21833@lst.de>
References: <20250106100645.850445-1-hch@lst.de> <20250106100645.850445-4-hch@lst.de> <a461bbbc-f251-4f44-89c7-f80f72e6e96d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a461bbbc-f251-4f44-89c7-f80f72e6e96d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 07:46:19PM +0900, Damien Le Moal wrote:
> The freeze must NOT be done for the "if (entry->store_limit)" case. So this
> needs to go int the "else". Otherwise, you still have freeze the take limit
> lock order which can cause the ABBA deadlocks in SCSI sd.

That is fixed in the next patch.  This one is pure refactoring without
behavior change.

