Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8E372EE4
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074545; cv=none; b=tITllBWHLXrY+v+x7c8HdhRYDHKk9fDr8hImqtZ9FS0nZLqG3ZV6OJH1F9p3MuHiA7FFlQqgL8Oz7X0HCBpQy8VKkL61FCMtrx7k+GfPyoMofV2RlYwB5d3Azz9Nb3YoNBfOM8sLu0Fm8GATK54ltdlKbBv0/zLEYtmeZNKGpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074545; c=relaxed/simple;
	bh=v1G81fSMYgNdms1mmT6DUAvJQaO9m4Ey6uGu/sN0GUA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qi+ja6XkwiGm5bwA6o4oWJCTrNe/MO1D8dlIUCD3XwCKs6Zv11VVoXVWtizfm52qAWayPIg/C4TZieEK5kJShAETZrgu78w6Ob8lrDPFOmnVg0QQKzAYNOg2wO8v/bMXAvgK4hVfSn5Xr84BTUznNO+TXNq6+bA8Wcqgzn1IKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Or7aDVhP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DsddPZ+W; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Or7aDVhP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DsddPZ+W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 41D901D00109;
	Wed, 10 Jun 2026 02:55:43 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 02:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781074543;
	 x=1781160943; bh=oAi3ZDEIe2fbzc8UkmArUFR2SarWpW9gmJL4DvA6+Bc=; b=
	Or7aDVhP23b9yIYf01Fs9noBArp+JVwnhv645H8PPs7ILsR1YI4Iczvph5ABxbMb
	UJS/ajrMvOMMXnKVd7X+Jz7Gt+Rd6Ze9eGKy377Xi7TNw8Ug6g0oy6zacLQMqmzI
	qWvLBD0i/CHApCCbLlV077hR5ji6IYQTW8uA6hg5QxZkg2fFAvgg6USkEYTL0/CT
	AjOYK3Ef4rDVObjfooCOGjP1DiCTqKcKYiHg0Ip78SUG3fdgMLJoXjKtC7CLTtug
	DDzRHa6zgJ3p773PG6qxvEbKzgzuN2J4q9eY0XTn3BuZ/bOVHKsYKylusqHqGAYR
	XRr7/06gG34hrQb3AdZrow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781074543; x=
	1781160943; bh=oAi3ZDEIe2fbzc8UkmArUFR2SarWpW9gmJL4DvA6+Bc=; b=D
	sddPZ+WHeZwMxHFt5js5Xhf/AUG7QPim3cFRw04JqNbTha98PpIDzGyLDbNnl/9I
	sGZmk2YnCVE7yrNc2X43t4N3254jkYNOa3efUcty9YQ0va8GpYni3iXbIXQlALfW
	tssO6Cp+oKHwvTXVssgX4Tqnz8vfygk4HHz9vVMYnD/xYFwxvoZLUrT2lJX+3FVA
	V/GXlIhCFY1sgrujwAz6+lUCtbRh8iSQhCkqI1UFUrFEsJIdj50xWDigb8kHaTaB
	umCTJy1Vu9b7MMT8DwA6lgoKXNJJkUAZ1ikLJkVWV+eSyZFQRZE9COEV+foHS+wM
	Lq7Au7rQ1Bi2vSkw9+LNg==
X-ME-Sender: <xms:bQopavQXYS1oPwD-IOobSAIg1T9u1aTtV3JonNmZwTc8N2x0Kbmfyw>
    <xme:bQopark-WxapRwFYwiSLMCxVWdrma4avlmW4fNX0kEL0Rdhourj-A3jyg7-rCitik
    9-d0fLxAEA6szEpav4vr2jSguTE2Qzd07brfEp-YXxEYyscMzd1zg0>
X-ME-Proxy-Cause: dmFkZTFrxSklx/r/qR0SHpR5EIuPSC17Cn1xW60iZc3ohZIwmrGLdbYVjUQ/lwPhUxWNmS
    eDV3a8N9aj+fxJmSmdag7pra5DkADMYuLjIVPImqiwDszjmW57SYCi2DQ6FTQF3UCOrnhx
    0PoI34Y6crVf5GJxeSlCONbqQFSVkvkYo4f2I569irgUCNTBhC8pDhmtsIqGvapWLaYyGu
    isevgowfhHoJ2pzjadeamhnOpb6BdBwMSukgmr0EWIfmWIunU/nyQ+SEVyhRDfekeTYFbr
    EISkR2lMDBb8ucqE/h2lLNbBytqI3ky+xwUD8xgv3o8AtYe67mPFcrbEPlinWhCSm5P5A+
    Xsr6hSqsuZM1b19EqjS0aQPtPjsnuhZEmqX5kUdyEP/ilHnAMJMYAbDmZoDWxmyCxs7lu8
    hQJr/4xtHXmSu6fgkXnqtiF5umSRocQXIkEf7I4eGMdhWgGf7SFZdPeoTg71G5jE3JdHOv
    BXGZg+TG/NK5hYrw2ME7O4hvJwm0lHdkR3jQmTcK1ozPMdMwFsuk7jVWLVCCGqX+sf/sII
    cyk1fvnPUJ6aWCuXSpse7Q1k90H3GwAWOKPi+atHptSsSEWou/VZmR+9V0Pvr8TFF4Kgf+
    FsFOtA1P57Mqh8wYOUllR73DqEp0/YHqYDjmDyzUZdP8FNJYHNYv9Z3/hQtA
X-ME-Proxy: <xmx:bQopam03s6I6DC5UcQYskxpHIIMbUAEmgy3S5piN32EneOVdSkGXlA>
    <xmx:bQopahSYCKsF-EtJFukyjX3_57t9aU6libebCTl9u9n_Eob22EdTVA>
    <xmx:bQopaqd6NZ-ISf8c6Bp-MjS7oGxo0gnqVy1OSJH_2wvlP_9sWSs81g>
    <xmx:bQopaifJYxxmcRqWB-hyPy4ZHLBcFGvOFJcF7bNMSg0ZsqpXlwJM4Q>
    <xmx:bwopatgyi5_D--ptj1a9yz_UTBMSxGrSIqARG2BXLEJQ1IAAV3conbwl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE3AC182007E; Wed, 10 Jun 2026 02:55:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AIistrz8V3Hc
Date: Wed, 10 Jun 2026 08:54:59 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jason Wang" <jasowang@redhat.com>,
 "Xie Yongji" <xieyongji@bytedance.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Anders Roxell" <anders.roxell@linaro.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <0134edd1-de51-46b3-9ea8-bdbcf48b878f@app.fastmail.com>
In-Reply-To: <20260610012421-mutt-send-email-mst@kernel.org>
References: <20260213154051.4172275-1-arnd@kernel.org>
 <20260610012421-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] [v3] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 10, 2026, at 07:26, Michael S. Tsirkin wrote:
> On Fri, Feb 13, 2026 at 04:40:46PM +0100, Arnd Bergmann wrote:
>> +	};
>> +	__u8 ready;
>> +	__u8 padding[3];
>> +} __uapi_arch_align;
>
> what is this __uapi_arch_align supposed to be doing?
>
> It compiles by luck because gcc thinks it's a global variable.

Sorry, that should not have been part of this patch, it is
part of the series of changes I was testing when I noticed
the problem here, but that other series is unfortunately
still not ready for merging.

The background here is that I'm adding -Werror=padded to
the UAPI checks in usr/include/Makefile, in order to find
any instances of data structures with implied padding,
and then instead add explicit padding using architecture
specific macros. In vduse_vq_info, this includes a final
32 bit of padding on architectures with naturally
aligned __u64 but no padding when __u64 has a smaller
alignment.

The __uapi_arch_align macro in turn is what I add to
structures with optional padding, in order to be able
to reduce the alignment of a structure when building the
kernel with a higher default alignment than userspace
(e.g. on m68k with -malign-int).

Removing the __uapi_arch_align is the correct fix for the
moment. Let me know if you would like me to send a
replacement patch without it, a fixup patch on top, or if
you will fix it up yourself.

     Arnd
