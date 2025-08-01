Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B728D8D1
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084227; cv=none; b=HfKfNm6UW0R7AHRrCDzKNblilLO2f7oTaVckW03XAnC+z7J1QiaSK+ILwCe27HnCmJSBPcwbRH0G5QWM7XJ0EJv/9sNSTn7lJmzxl568BXAMWNnGKhdESOTkLxAcrx58b7DRLXpRAAtVUN45D0ZN4zTgYuYaJXiMjKvkHawK7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084227; c=relaxed/simple;
	bh=PVeG3LcWV98xhs5CzZv3kX6ost9c8KHyZTHCcL+3rrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieVgB6TjEz2D4mmY32iXuYH3NwAn4GHhjyyTu4NHq2KQ82f93J5KtAiga3xHxDaKpQ1M+jw2I3uVvTaUGqemUfMtErgGnh7WZMc458IuvcFe1MmR7dmpXEzfBbto2yjVQOW79kOopGjQKOzNLMbrrSYiZN1EuE2i4qaJ7VwprGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Hk1SCEXa; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Hk1SCEXa"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 611AF40336
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TDQDXJrW3MTm for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Aug 2025 21:37:03 +0000 (UTC)
X-Greylist: delayed 2156 seconds by postgrey-1.37 at util1-new.osuosl.org; Fri, 01 Aug 2025 21:37:03 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 73D8E402E9
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=treblig.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73D8E402E9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256 header.s=bytemarkmx header.b=Hk1SCEXa
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:5b::1; helo=mx.treblig.org; envelope-from=dg@treblig.org; receiver=<UNKNOWN> 
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 73D8E402E9
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=f4EUtpQvfD1GWjXjCaIBDDisUV6m4mX8lVb0bZq8pMw=; b=Hk1SCEXal1ou/150
	I+6mXB1y9B7k9Q+ydLpadDDD2e2UjgCFVqoCK/ULop1nwGYg6+meyRcdx9E2JDWrfMwNSGungqARM
	DQKxNDPjOGksuP3j6MIRlG0lxjzdPc8H/sgQeK6PF7hheyOj8vd5gJRveye1hOXa2DVcCd1TMsAaC
	EDD3hGCccHVa4iLuIIE9VB+qunPwNEkZB1uxmUcCV0y8FCD2fhbtxOwFgS7v7IscuD1OzAKLVTa1B
	wbog1jbONAgWuO7TmZtMaVwgerXHoTEpwTyTVViy28/Xc1gKjQdo0wwmwH4Yc1Ozr7N1d6rbJWUoX
	kQ7N6IEHDYyU7XSxMw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uhwsB-001mFM-00;
	Fri, 01 Aug 2025 21:01:03 +0000
Date: Fri, 1 Aug 2025 21:01:02 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com,
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com,
	eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com,
	kraxel@redhat.com, leiyang@redhat.com, lulu@redhat.com,
	michael.christie@oracle.com, parav@nvidia.com,
	si-wei.liu@oracle.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org,
	wquan@redhat.com, xiaopei01@kylinos.cn
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
Message-ID: <aI0rDljG8XYyiSvv@gallifrey>
References: <20250801091318-mutt-send-email-mst@kernel.org>
 <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:59:29 up 96 days,  5:13,  2 users,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Linus Torvalds (torvalds@linux-foundation.org) wrote:
> On Fri, 1 Aug 2025 at 06:13, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >         drop commits that I put in there by mistake. Sorry!
> 
> Not only does this mean they were all recently rebased, absolutely
> *NONE* of this has been in linux-next as fat as I can tell. Not in a
> rebased form _or_ in the pre-rebased form.

My notes say that I saw my two vhost: vringh  deadcode patches in -next
on 2025-07-17.

Dave

> So no. This is not acceptable, you can try again next time when you do
> it properly.
> 
>             Linus
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
