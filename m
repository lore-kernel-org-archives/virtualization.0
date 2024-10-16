Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CD18870B;
	Wed, 16 Oct 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102221; cv=none; b=s9Ffbken3FqngEMFq04YrwBCPdYi95yDzZKNcWvJYQQnYLtgVzrGhb6vBt+yvahAkC0/wAFzzGBet43kaysGwaxeaX+Wzir/jkvov8iK+EaxBaYKzqzpkdFOSKo1cAykhuqqgaz/Ppin/WnnQ6gMlvWslqGNbW/2C1cZRYvR1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102221; c=relaxed/simple;
	bh=4ouiN0MYYhVbG6KDc/Tt5xYhAg2O11nhP+BMcc2vYAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnikYVwIHn3bFh9ZzGYCP30ZLkhuQCoFyFlQVXsUzLlzvPM033iiyFfuvqW7COudXgJkPES8ydsVJobd8+t1Gd3daK3Jea4god7/owbwOxyyUX0PxLd9aWTQmotTMqAkjsBUh+LOaKVQvM1B4AIE5GALzGeNiBveSDL+Gue2zUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=scsgIV7v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="scsgIV7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24137C4CEC5;
	Wed, 16 Oct 2024 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729102217;
	bh=4ouiN0MYYhVbG6KDc/Tt5xYhAg2O11nhP+BMcc2vYAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scsgIV7vhp6x1UneNN+lCqLog7fKjoFKyhRHLgxDgyyt2biVhAgiptLQXmMuJ6Glt
	 gPiPUzfWTFvNX5najsk4jUyYpeuZ/zQhObnKXp2slSjgIDvpDQqxZksO9R4MMW/OTO
	 mMXi8YWS377qu9ro6RKyUUqCRZgoUTU3115X+bJI=
Date: Wed, 16 Oct 2024 20:10:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Wei Liu <liuwe@microsoft.com>,
	Rob Bradford <rbradford@rivosinc.com>, Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <2024101637-stretch-tweak-7dff@gregkh>
References: <20241001011328.2806686-1-yuanchu@google.com>
 <CAJj2-QHKLHTPn-Qoih_=5RbOf3eyenKMmFn0jz6ALQ9KDAbisw@mail.gmail.com>
 <CAJj2-QEEk19yPp45U0fL1GhosRuhZKHxKFo_2O9vLSYjQ=g2RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJj2-QEEk19yPp45U0fL1GhosRuhZKHxKFo_2O9vLSYjQ=g2RQ@mail.gmail.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Oct 16, 2024 at 10:53:24AM -0700, Yuanchu Xie wrote:
> Hi Greg,
> 
> Are there any other changes that you'd like to see with this driver
> since your last comments [1]?
> 
> [1] https://lore.kernel.org/linux-mm/2024051414-untie-deviant-ed35@gregkh/
> 
> Thanks,
> Yuanchu
> 
> On Mon, Sep 30, 2024 at 6:14 PM Yuanchu Xie <yuanchu@google.com> wrote:
> >
> > I made a mistake. This is supposed to be v3.

I'd like to see a properly submitted patch series :)

this is long gone from my review queue for this reason alone.

thanks,

greg k-h
