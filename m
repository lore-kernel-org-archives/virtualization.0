Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9D1304B0;
	Fri, 20 Dec 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679289; cv=none; b=JKyjklwo0ijQ4CZLPijiXanB9VdbpHMYPE0bmMgu0b3Ym7h77Vl+RpkycEgEaXrtg4LQlgNmDxTbpS3lBB9erBrmbkuTRLXELhFWLyu5TcwW/zNDI0LQwEycLORlRC38mBwQIMyUn9Fs2RTxuPdSQt5TaJG4SeodsSe1khgfdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679289; c=relaxed/simple;
	bh=TWEszM/sgQq+Kbe/u4f8toNA9+LONMYNkDNOmNgr7pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS5ZVPQkX9w8XyMsfXMIJO3ntfrUJ79sWTlCR+lxBUFjUNmpOq4OfX/sU5UMu5NxkXbXwbg2BPm+WFrleHea46hPDlxfK462KRTe13IrLH0R3jklLDwkIDpjL90hsEH5yg/ZoFViQiIDNLfctPemNNLsFbP1ktcDqL8XIKdPx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dsOTrcrZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dsOTrcrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F0CC4CECD;
	Fri, 20 Dec 2024 07:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734679289;
	bh=TWEszM/sgQq+Kbe/u4f8toNA9+LONMYNkDNOmNgr7pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsOTrcrZ8m3JiIXQgL32xJeoP0focqML3w1q8bVr7Np0JjcjGBcwbeob9fs25kMpM
	 Rij+o2kdFtYFZy9rquSpXCQVXwsWuMW29vztsFAI1NrhcrLaEm8HT26t3Ut8hTOZ62
	 ffLRLn9kxYuQlo9nuaPE+1NkH04uPkR20CNvoArc=
Date: Fri, 20 Dec 2024 08:21:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org
Subject: Re: [PATCH v5 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <2024122052-unsworn-haziness-ae7f@gregkh>
References: <20241203002328.694071-1-yuanchu@google.com>
 <CAJj2-QFSmtCcQ=dm3yMhNi9F6trbcP0rg5z8cns5V64Pmn0c9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJj2-QFSmtCcQ=dm3yMhNi9F6trbcP0rg5z8cns5V64Pmn0c9Q@mail.gmail.com>

On Thu, Dec 19, 2024 at 10:58:24AM -0800, Yuanchu Xie wrote:
> On Mon, Dec 2, 2024 at 4:24 PM Yuanchu Xie <yuanchu@google.com> wrote:
> >
> > Pvmemcontrol provides a way for the guest to control its physical memory
> > properties and enables optimizations and security features. For example,
> > the guest can provide information to the host where parts of a hugepage
> > may be unbacked, or sensitive data may not be swapped out, etc.
> Hello Greg,
> 
> I addressed the feedback from you earlier at [1]. Let me know how the v5 goes.
> 
> Thanks,
> Yuanchu
> 
> [1] https://lore.kernel.org/linux-mm/2024102220-creed-darkening-aac0@gregkh/

Right now my review queue looks like this:
	$ mdfrm -c ~/mail/todo/
	2474 messages in /home/gregkh/mail/todo/

I recommend taking the time to review other patches from other people to
help reduce the maintainer review load.

thanks!

greg k-h
