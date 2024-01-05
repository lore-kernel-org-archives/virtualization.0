Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC979364B5;
	Fri,  5 Jan 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eztdRwfW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nMbzOtCbU7XTEYEKAv0oHU42nzHm9G0AGeV1eKduXTE=; b=eztdRwfWypwC8xZv1BIq3Aciu4
	jbIeY4xGqeV/+VMpk0imOJyKUbEyjm5LbIqY4YOXcENrdsYbkbu8okln45v3sYnCZHCbcW3WPSYwn
	totsqvt7HTbWbcy7WhB9rCMr+jrqRc4gpDGuJCNd/F3dgVhl4Su13eo9iS6FxhETKGFtGWc2NVK1h
	QxoAxQr5Pu7F8Dl1l4RIZXE28TGs4JxNkLtikhoDRvrVoKp4slfzg9AtThHPXfZAtMSx5bYlIcPmx
	eO1zZj5wzfVV+8HgXSqLKIizC/9P6Ufvnltk73WxrwhS8Esobha6s9kPYRCl8EkPQSGBd0fiVSlDR
	vgzUAmMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLrGN-001CKP-BM; Fri, 05 Jan 2024 20:57:55 +0000
Date: Fri, 5 Jan 2024 20:57:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, houtao1@huawei.com
Subject: Re: [PATCH v2] virtiofs: use GFP_NOFS when enqueuing request through
 kworker
Message-ID: <ZZhtU0IxUycpLGJe@casper.infradead.org>
References: <20240105105305.4052672-1-houtao@huaweicloud.com>
 <ZZhjzwnQUEJhNJiq@redhat.com>
 <ZZhkrOdbau2O/B59@casper.infradead.org>
 <ZZhpjEwDwMS_mq-u@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZhpjEwDwMS_mq-u@redhat.com>

On Fri, Jan 05, 2024 at 03:41:48PM -0500, Vivek Goyal wrote:
> On Fri, Jan 05, 2024 at 08:21:00PM +0000, Matthew Wilcox wrote:
> > On Fri, Jan 05, 2024 at 03:17:19PM -0500, Vivek Goyal wrote:
> > > On Fri, Jan 05, 2024 at 06:53:05PM +0800, Hou Tao wrote:
> > > > From: Hou Tao <houtao1@huawei.com>
> > > > 
> > > > When invoking virtio_fs_enqueue_req() through kworker, both the
> > > > allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
> > > > Considering the size of both the sg array and the bounce buffer may be
> > > > greater than PAGE_SIZE, use GFP_NOFS instead of GFP_ATOMIC to lower the
> > > > possibility of memory allocation failure.
> > > > 
> > > 
> > > What's the practical benefit of this patch. Looks like if memory
> > > allocation fails, we keep retrying at interval of 1ms and don't
> > > return error to user space.
> > 
> > You don't deplete the atomic reserves unnecessarily?
> 
> Sounds reasonable. 
> 
> With GFP_NOFS specificed, can we still get -ENOMEM? Or this will block
> indefinitely till memory can be allocated. 

If you need the "loop indefinitely" behaviour, that's
GFP_NOFS | __GFP_NOFAIL.  If you're actually doing something yourself
which can free up memory, this is a bad choice.  If you're just sleeping
and retrying, you might as well have the MM do that for you.
