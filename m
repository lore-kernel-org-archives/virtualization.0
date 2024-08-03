Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B978289
	for <virtualization@lists.linux.dev>; Sat,  3 Aug 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722725751; cv=pass; b=rvtXg4kOzs9Q8/Dvi+eCbk21ZxvfLAcN2jDpBkRqHSkwTJe+w6gMUrted0BPa8F6xDqoNmHM1fgjO7JEzifIdjr4yobFjPnaN54K6NIwprCmp08/oboiQtjSC5NlBuyOxeRcBSH4up1n6hh/PvyoRG7K0FIantRIyCTCtpODoJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722725751; c=relaxed/simple;
	bh=3IDFR8Dn1X9TyGXo29DEnYOGPP3TAu4hLiLdChoT+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHqNb+JAsPThIuLfrUFKzF3n7ISBsdcXkzqaYdnqOquYlIa6Yj58d3VyBYkfBx9T76eef/dGDrV9GvTMnWbU4k4a+pQRPPLCNnpZblgzazTZGuJh37sLneZoBul2RNqfRyrdt1+NeAd7MP4Ea61pkwzHci08CL32rSJTsGCzv7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=GpYabR1+; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="GpYabR1+"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 10EC8765040;
	Sat,  3 Aug 2024 22:16:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6CAFA764F42;
	Sat,  3 Aug 2024 22:16:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1722723360; a=rsa-sha256;
	cv=none;
	b=hFk2kgHBt29yPVAmxIr0BT2kAVTLhuPFEJWixFeQ3SATTc5vNU/ClwSXlmZAsgZXIKSEY9
	PJvY8LbYSAJuVD/SH3cLZ7IBII9xgH3kyU44Jjygv6Lm3JwctUckJ2o/7F/To0BUCp2IJs
	OX9a8908gJ4+HcdM3jSMoyb+MAYNjPJpJMAfHsv8UJgjvwfgr0u9jhBjx+h85+z7lDlOxU
	UXsuJR/vwx3fUyIc2ymCUVUt+ZJ1Z/Yb+6wRM8ghccfhIFu8m6F3MaeFQ5O6pGKOp+8TjX
	qeXtlSfZdgV9ka5DwRhet2LqG6vRSb/EEJLgJIVqeUuxi7a/+FvykKii/udo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1722723360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qoRbMol++GV7pnk5stu7PzDGVi+tenflIWLybgOoYpQ=;
	b=7+B06R7YSjX90KfvakiO0Uonq2rg+dgsxjvO/wQdp9hpDNlzYxd5r1zDwDJdzPadnU8/SG
	TpGy1XZji59IncgdqP6iguvgylQLxyz0XLHwrmBv7lYTJyS3/4IYfd1NsMd/TKnbJfdLa3
	X8LW0u2f1onPw+dKU4cZSxiVAADKxiOqfqDsZ7JqrpLNQoUFxImyI/i9OwOahU5Iux7F0q
	cu90G1e7Gze2e/4KAeBUmgjP6Mvke1Aj6+eycGMp1KhTmUqZwZMFltSbszqqUF7sbU82gN
	2u8so1TSyWJBn9fT3ptWwe4sg2AXKCFEeJ1f32w+Nn9ggYa6r+qeLfwxc8Pkmg==
ARC-Authentication-Results: i=1;
	rspamd-55f4674486-hbgb2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thread-Stupid: 09d5df1d60412c51_1722723360802_4286893693
X-MC-Loop-Signature: 1722723360802:2481035165
X-MC-Ingress-Time: 1722723360802
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.30.162 (trex/7.0.2);
	Sat, 03 Aug 2024 22:16:00 +0000
Received: from offworld (unknown [104.36.30.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4WbxqM2cqwzHZ;
	Sat,  3 Aug 2024 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1722723360;
	bh=qoRbMol++GV7pnk5stu7PzDGVi+tenflIWLybgOoYpQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=GpYabR1+JldGHYgLU8Fam2TUJW7/XqSXwlEXNK59ht97fYY5HwxMDh1e/PlvpFnTx
	 rHz2ZtDYcwC+NoXhbOw5Klj25mqpcsm3B/UQikKPjr4X2TcTlSO3fOmLkFaKx2lYwI
	 TFz5kfHvy2qo2kYIRL4jG6l2Cw3MO6vtVw8jS3YY6F5vq5dTj/2WqAuSLZt2YEWb1u
	 y0cEY8RZeOb98a/hzA+ROzPurR7bdunFhjtYuQamdNxDn9wnsL/PlAbWnNhxVWExoa
	 EK4dgtQvYr6tqFOqD7Q5lqPeNi0fmeTNLkO3ojtGegX72iGEfawZdCxXyEADIQM5VP
	 PntjJJdH45gxA==
Date: Sat, 3 Aug 2024 15:15:56 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <3mevqjzu2emxd2f3zkrurnzcal67k4lpkcdqzfs75qhp4uflbn@skz6q5odetdr>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>, 
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, torvalds@linux-foundation.org
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <ZqDw7qoaopnYt3-P@tiehlicka>
 <CAGsJ_4x1k-z7OcQPSgqXhxTM8Z_D3Og6mGkC1pWu2+pR3YRKvw@mail.gmail.com>
 <ZqHtwqyj4seB-eut@tiehlicka>
 <l47ief3pnjdymvciylpnzkiuto7tsth6bc3q2mum3l42queggg@q573yeen4a5s>
 <ZqeCFLykU059gNmN@tiehlicka>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZqeCFLykU059gNmN@tiehlicka>
User-Agent: NeoMutt/20240425

On Mon, 29 Jul 2024, Michal Hocko wrote:
>Because it is really hard to figure out what it is supposed to mean.
>If the caller uses __GFP_NOFAIL then it is (should be) impossible and if
>NOFAIL is not used then why does it need to check for
>	(gfp & ~__GFP_NOFAIL) != GFP_KERNEL?

Agreed, this is pointless - and cannot recall why it was justified to have
in the first place.

But I think we should revert back to the original check then, which is there
to distinguish failure cases between normal (GFP_KERNEL) and nested (GFP_ATOMIC)
contexts. Removing the check altogether would change the fallback for regular
allocations.

So this would be:

-       if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
+       if (tbl == NULL && gfp != GFP_KERNEL) {

Thanks,
Davidlohr
