Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE2D268;
	Tue,  2 Jan 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sb5aHNMh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9XzDx6zZ6qJD2AqPIsRJuoeK0l+mVQ9Fy8pq/VyTgQM=; b=sb5aHNMhiZ0qDUzXBTFXlfZcgu
	kobm8NLF+hVBiee4q3GhgkRaQw8wzIsvH0uynPzXhfimS7OvE8R/GpYmSKUrKOMgGyEZvRx+yfRkF
	SAGfiyTOF/GTApBL3R8noyyhQVD60PFSovEXGXz0VrUimOwv1qpe7nepDDPrenMJTOScCdNz7mtbs
	ogJnopbaKSLIhGgjab4Ew8nZRv0f1YgRajZ5vgy//W8a4pZbzpmnONzOgxhA+tOfC98J3bh61eqeQ
	7LArNYPuQGCu52EePosEYuW37VF+nkHKtOjiWdYFLgLFFf7iAyNMFhatIf4KmoEvU89SZTiCi8QdC
	BMpIMftg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKbpo-009y51-79; Tue, 02 Jan 2024 10:17:20 +0000
Date: Tue, 2 Jan 2024 10:17:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2/2] virtiofs: Improve error handling in virtio_fs_get_tree()
Message-ID: <ZZPisBFGvF/qp2eB@casper.infradead.org>
References: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
 <5745d81c-3c06-4871-9785-12a469870934@web.de>
 <ZY6Iir/idOZBiREy@casper.infradead.org>
 <54b353b6-949d-45a1-896d-bb5acb2ed4ed@web.de>
 <ZY7V+ywWV/iKs4Hn@casper.infradead.org>
 <691350ea-39e9-4031-a066-27d7064cd9d9@web.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691350ea-39e9-4031-a066-27d7064cd9d9@web.de>

On Tue, Jan 02, 2024 at 10:35:17AM +0100, Markus Elfring wrote:
> >>> So what?  kfree(NULL) is perfectly acceptable.
> >>
> >> I suggest to reconsider the usefulness of such a special function call.
> >
> > Can you be more explicit in your suggestion?
> 
> I hope that the change acceptance can grow for the presented transformation.
> Are you looking for an improved patch description?

Do you consider more clarity in your argumentation?
