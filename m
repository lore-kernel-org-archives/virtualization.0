Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDC37881D
	for <virtualization@lists.linux.dev>; Fri, 10 Jul 2026 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662338; cv=none; b=XNNldQjbu+zIb9ycI6Klu5H3iIviARFthMYlR3X5bpSGBbKw4oQ1WNCSa4DPAN1bg/eEqoaUdjNNhYrdcODzkHrhOPYfJYT/1Cg12bWIYrsp0VGhnLWdoY3yYlwilMajgOGTgZFHeT9G+4dxFsTSNiMJD+pBqacOALoaHBHOO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662338; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmpvF4cl8u8I8PsOU2aYC40rCwCpQ9ThaMi7mDk0DXShBbXihYE1F4Fwe9mMJ/jEMhM7Fy5dKgVzdg2R9bCRcBpuQg0z/IMq57N2bHSk8QTw/A8ppOq8cg5utCm9wsV0O4KLKtlZccthqNm4Zy+zsD3skxO9aaRfdzfqrl703Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E59068B05; Fri, 10 Jul 2026 07:45:31 +0200 (CEST)
Date: Fri, 10 Jul 2026 07:45:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Baokun Li <libaokun@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio-pmem: allocate flush bio from a
 driver-private bio_set
Message-ID: <20260710054531.GA7613@lst.de>
References: <20260709124455.1547912-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709124455.1547912-1-joseph.qi@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

