Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080C3A784E
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854953; cv=none; b=rSOHNnHJLLXSYrkscHDkhg+P3qbwJTkINXsKT75DtbOjmOz807fnjVNjykWPAXCxSjWfRxJ9bJASa73epJ44hzrvUZ2WzWgw9NhxT06nURZcB+Y0nA4YA508xu17qaPxApwfQZsNPePx4SFQS2CzQQpeL88fq2dlPodFo3S5/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854953; c=relaxed/simple;
	bh=dTUl62Kvvwt2iA0jmSAM0I0mwQYi1Do7nzl5TFIuOkA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IG/nSk9nJlwo+5wC6tctmCEJEGOpvh28Uk7TOcqva2XGsmF3n4ToQJZuLcGIRykE6qf8NNUoerdVJi2ASw8VONa6Ov1s350EQ+upnMIz7ygQrVoxoXWftEisciFLh3tsUr8nIi2mRJbKVlyelIA3JDEkF6+KLt4m1bdF9bBg3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CHxwwz0s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vzS2YoE7; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CHxwwz0s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vzS2YoE7"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56E587A0104;
	Tue,  8 Sep 2026 04:09:09 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 08 Sep 2026 04:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788854948;
	 x=1788941348; bh=LZo30iPxueLhaEWqWjWy7wIdR3qwNxI+4VleF/3GMuI=; b=
	CHxwwz0sTLz0k4JTDAir0E4LWkmAABV40cTbw0iHVtpW3jH26m9XhmhZgK0DcJVQ
	3AO8q8rT5R4btuZsvUXga1Af7V2hgTufdVHCpB6C+uviqFvxonm/+LhmtVHLPvC7
	LuN5fX3scXykkocuy4xZjxRwTWN5PdmwKlQ29GrItRbkNChjXskdvGpL01t+rgPk
	Q//MiteFc/irdpoDbM4Ko48zgRPkNudKn8u9ywO/bkCJnQ7W74h9/Pt1VuSQp47O
	xTWb2xozavabsaafUjI4EKIwZ7LaFf9XDFSCBoBrwI5xE1aTWzTeE6+adEpAnE7I
	+7VXEzu7NEN+3g0008p7pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788854948; x=
	1788941348; bh=LZo30iPxueLhaEWqWjWy7wIdR3qwNxI+4VleF/3GMuI=; b=v
	zS2YoE7cg1tx+2385UdfQIw1XoQERXgtrB+SQEXZ1l24rm8o2leYZ7bsGukD3sqN
	XM81FfoXUj8f1KeFkEo3fJRLgpCm8K24Veyw7rOmq548EghdcixBHC0YaF2GJ0Rf
	aEl/YJrKsREsJKNgl9Fp6wMN3sG5w2uBNfDUG8FBe8mo+1AuitSdxQmcNIFr9XoK
	ETwFlb3m2n9Ts7n4SJvsw6uniOj6I+mYFjHTQSdZleAqLc4HwdUgeJEDm0n9xMdw
	6X27+0hF47UAbGzwiz88MNfqn+Q+d7nHQyR9wm/oB2QLHG8ryDqVlDre4bP4sJlH
	nlK7BDPg1hNGuVmW9HzHw==
X-ME-Sender: <xms:osKfakv1s0Cj3FdCYlIyLvQu87BLX9JMhxuzNYSkd9IghrBjrhAO6Q>
    <xme:osKfasSms0E7ULU2ZjtHN9fGbBsRJz1Yl30maUHn0RTIDPGtuwTywCKQtAIqfxw_x
    31g6my2zQEpVWI_YBnzXh8xdAn72bxIygAs2ToaRFVmDB57wVrtmoPD>
X-ME-Proxy-Cause: dmFkZTF2ejYEg7vU73wlHTaeZh8Z3R3H4y/Jp6pMlwGiasL4kvZUon27hKxkM8hw6/mQ04
    hY9MTmaHW5g1hnqDrzYUkr3504WI2mRVE6UyQ7saF0RlX+KO0nRU3sXzqRybSsGT8ett0I
    7Y/fgXJvd+KIhMDxKAnRu9N7pWMnW7bnY8/bFGLEHyabbhSQNjjSK/NBdZGsRmyGoJfmz2
    BDHGnqh0/IDmY6VHu/sBhYj/9R2RYJmTKAqHcmXkTl4zMolRTtabcARJKvE63DYHGN/dPB
    ewd+cB9i9akIN/9eRe7JlioQOAlW3zYTNlwkAaX3xmBVBG1FJ4fL6mhp9MdfF01A2psVV7
    EDBTOtO6yQkX9Ypy1BP3GXAip22yoc9496CW78lbDAJPZL59D/c4zvhiJGcSd8iiYw2bXs
    dr8eJrBNfSHMl/uUtI8L2MovZZUstFTlB+PGJ3nOdqs/zPwbxCYhPotcVfvWV7E6tOrD0H
    aqbPePLYFQcih9vwhU6yZlt8JKFr2LYloh5X4q4k6GHfWyErnuBCH59n/imcNWmum2rfVU
    QCG1JLVX6RpLURTW/LufaXkK/zXm8Sgz7WCvxrSoXYHUAh4v4RHCXcq5mIBH/JqxrPU9Kf
    6A8Kvguyml2dVBxi5ZRenM//rU20TnabwmGCCcGs8j1BB1W+VzD9t6D1YifQ
X-ME-Proxy: <xmx:o8KfagM8Lk4oGiM5PdoQEo-99gtl-RS6XNHnHer8gwkMBnleBlIhWw>
    <xmx:o8Kfah5ejk8n0N1O-qQraN-54ChxKX2S91wmJr33PuE2qGUjl3I85g>
    <xmx:o8KfamR93Z0hvwuau9cNxXACeLr-AEVyeFfH93CDqR-m1Mn6WCQdnA>
    <xmx:o8KfauA_9IT7jrffeHNvF5XMJjoer-m_L4oM8qlkjzZGrlrRk2Q-3w>
    <xmx:pMKfaszjhBKrkEHB0bxsf84nU0D8lU3qJUY3VZnfO22E6_oRkV2RtUYt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 830B032A0078; Tue,  8 Sep 2026 04:09:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AWdwJ18nw8go
Date: Tue, 08 Sep 2026 10:08:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Linfeng Sun" <linfeng.sun.dev@gmail.com>
Cc: "Jason Wang" <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <ea3ba5cc-ae68-4c1d-a3a9-c2840a1cb9e7@app.fastmail.com>
In-Reply-To: <20260908035646-mutt-send-email-mst@kernel.org>
References: <20260908-fix-vduse_dev_compat_ioctl-v1-1-62264d9bfb8d@gmail.com>
 <20260908035646-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] vduse: return compat ioctl results directly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 8, 2026, at 09:57, Michael S. Tsirkin wrote:
> On Tue, Sep 08, 2026 at 03:31:51PM +0800, Linfeng Sun wrote:
>> The compat handler handles VDUSE_IOTLB_GET_FD and VDUSE_VQ_GET_INFO, but
>> then calls the native handler. Their different command sizes make native
>> dispatch return -ENOIOCTLCMD.
>> 
>> For GET_FD, this overwrites receive_fd()'s return value after the
>> descriptor is installed, leaking one fd per call. Return handled compat
>> results directly and use native dispatch only for other commands.
>> 
>> Fixes: 455a2a1af926 ("vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO")
>> Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
>
> indeed, I will apply.

The fix looks correct to me, thanks!

> But ... how was the original patch working then? Arnd, what gives?

It looks I either broke it during refactoring from two functions
into one, or I just didn't do it right in the first place.

I did write in the extra patch text

| The code is directly copied from the native ioctl handler, but I
| did not test this with actual x86-32 userspace, so please review
| carefully.

but obviously should have caught this one myself since it is a much
less subtle bug than the one I was trying to fix in the first place.

      Arnd
