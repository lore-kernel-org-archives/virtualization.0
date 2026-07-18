Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3769265606;
	Sat, 18 Jul 2026 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352552; cv=none; b=fjRKjlNj4aja5HCZP2HRmRJwPbvunLCPJZrxjphcEFBVPHI/d8OLHkp016ca/D+4vMTl9NKRgHlCJm9FxspQYGWPu+63cx4v/wXSNhGx8QH8B4DeDoI5HoPhkSTOhHB3sF27LJcUTIf83r8EMiLiM5gfLchzP5/lBbfEedrNwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352552; c=relaxed/simple;
	bh=EeeYnfnMT/3PvMhv9rEFSKUrAf7GLDsqrhnkjC2+iTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mACuGukUEs4uXUmKb6Ur/SDuXG3FxrcDjvnyD0wKtU3dniRF+47A5sbNMTKeGDVxXR0pNfNJnNmjuRxNph1Cv1bFedBZw8T3ysotz01p1clBTHHA1GCONbSxbwbeDjLsheWg35j5T2a1bjTZ/OYEuQwNxtiHZsI27qpncSmElfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vduUTPwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vduUTPwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF3F1F000E9;
	Sat, 18 Jul 2026 05:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784352550;
	bh=997wC+KPNjHsDvSh7ZibnIOMK6gPiT8aAIeKcyRqs+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vduUTPwfNH/P+uGQo4u/DLO5h3puuHQFW8YgY5p19hvs5qXhekWWbKOEO+rxyXRxF
	 y6q/qr2lL3GTaYZXv2ahVYCdpzrX8aNFrW73miIVHpsNLZlyfdLpBL0mopH37+bWmQ
	 mT7Qk9ciH9acfcec2PZzgSzh+VkVkYNk9rABY3kM=
Date: Sat, 18 Jul 2026 07:29:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <2026071803-passage-dares-8240@gregkh>
References: <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>

On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
> Historically, one of the biggest criticisms of coco, especially around
> device hardening, was that there were too many values that a
> malicious/buggy device could misreport, making it a losing battle. That is
> no longer the case with LLMs, and we have the advantage (and challenge) of
> open-source dev, which allows us to receive many of these fixes "for free".
> If others want to burn their tokens, let them :)

I have lots of tokens to burn :)

So along those lines, any suggestions on how best to fuzz these code
paths?  Any workloads you all use for testing that I can take advantage
of?

thanks,

greg k-h
