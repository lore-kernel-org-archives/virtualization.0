Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176D111A7;
	Thu,  4 Jan 2024 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kezb9ASk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d/ZyyrczRRAg41dHk676oMumSI1/RuUVWYEm5uVQf9A=; b=Kezb9ASk4oEH4XR0eJzJzv5hSZ
	2MHZYHHVOAOZaIQfKvgIhS3/QnU4aNQEsIDTRmj54EIrDAmHV20po0OfqfITzTJQKpCieuHEPhNK3
	pvc0SQS3rC+vet3misG0FmIeF+yrKih7FBICbQCluyM5i1UxaiosseLqexKaN2z6YZ8FMZJY4cjyN
	9JhFnUMkr67PYeCvjQr0WJFl8ybL2qv6KCjqdj8D/7rwnpYrqfuBmLKQg2OzG6QdvA/Nut6u7n3eG
	QfZVOv5fbYTurJvbys1v3Ydwmfc4chjHaMDVoIH1T5Hw/H/A9twSB4UdyTzZ7i6h58Frjw9vwExuN
	k72lEOKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLDtW-00E7Ni-Bx; Thu, 04 Jan 2024 02:55:42 +0000
Date: Thu, 4 Jan 2024 02:55:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, houtao1@huawei.com
Subject: Re: [PATCH] virtiofs: use GFP_NOFS when enqueuing request through
 kworker
Message-ID: <ZZYeLn1l35pUSv6o@casper.infradead.org>
References: <20240104015805.2103766-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104015805.2103766-1-houtao@huaweicloud.com>

On Thu, Jan 04, 2024 at 09:58:05AM +0800, Hou Tao wrote:
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
> -				 struct fuse_req *req, bool in_flight);
> +				 struct fuse_req *req, bool in_flight,
> +				 bool in_atomic);

Better to pass the gfp_t directly instead of a bool.

