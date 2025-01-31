Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32243145B0B
	for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738309745; cv=none; b=jDwx5/+gBT5uvbO7Yaeg4dic35LwjfOgh7YoXUlc4bMn8gWAgE6uy1VAEmzgBClXA0swxVKwE+TweHbBNCmv+nVKot4bcukxYZJBRvcLfFMpK+F3uvxOkMyK2tO5vEhWzdOFDOgGM+VP5HlKX6P0L3CsN19yo+4+jvHWgCGO01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738309745; c=relaxed/simple;
	bh=AHtujq9AUL0r5JBnOO7rqiXl33q6R2L4lARHJfO+LgU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Di7xDtO9FNqdJd5/eH+W6qTmyE+Edd7GouIz2av5NNF3FEXYYyVEo8ZHO1oa7RFvfctqfVji8avEGjbioCuJ8FBJXz2RS/Hvv6j01IJ9sHakc9Fg8fF7KBUDnQu8jmAgIoVDIMnPKu9O+l2FP1hu2SAoxmonND26IfPvmjfrQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bZBHnLER; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U05yoB8B; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bZBHnLER";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U05yoB8B"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B39411401A1;
	Fri, 31 Jan 2025 02:49:03 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 31 Jan 2025 02:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738309743;
	 x=1738396143; bh=CLs8lrMbTXfsWo526vCMom84HCVc8uRGSWPX9ea0vpk=; b=
	bZBHnLERiC3ZUEdkZR536WxfHtQMTr+WQ1LGuux+1WLZTLEjbxW2Ft2PZXguvDi/
	vlBUl0cnwN+tQOqh9fC0oqYlEa9F54sLfjA+ocYI83sC5LF82wameQbEmgcjnoBs
	qDMe+Loyk+3DHgVYT6Ap3Tu7M/ApJ1k6dBKP2/ebzdyKajrGL501FNIu6j8oGhzI
	UnJpmgEPwTIHlMEGrT7ZzuD4akonDJB3meHZ4MXjKFF233pAjqoMSDTgaNJ5zZv6
	qsjxNfPM/yNfotF1Z9sGS+gGsa0PAsFoRJXUyRsB7cne4opZ0lE7aJ5mgbeRgXDK
	qYMMu4158RHP0omWCSCjLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738309743; x=
	1738396143; bh=CLs8lrMbTXfsWo526vCMom84HCVc8uRGSWPX9ea0vpk=; b=U
	05yoB8BUNrqVlfPxJEfz5c74geRWi4Ugio+7w06eLA9k2mNLplex3CdgW3HoZBLX
	TMJolx/pjguUIaTYqKcM2QbyxShViKHimwH757ulQ0bSsoJRjeoECcuZnDllq7YA
	R7PKRlBAH9rGBsM7uy0OJsqum0QuD0b0AP1LfkAH+qZy1jvkVnErkT/NdcT61S98
	WGMtApYkLIdLL558hDjWqIYZQfziMP0YWAXWPhxGHc4cjkaXHfpFf5Wt0rMveQzn
	ucGbNPUZ67Uqa3+JQ8icNCjauRFoeLN5aoqHsuYCCOx1p5erOMyA7x5YiDc1Yn0D
	O7kLZFhILfYA8rTSTFHxg==
X-ME-Sender: <xms:bYCcZ6_4JIzX-HybFr_crzqeUTIG78YR-mnMlpWF8u3y5o9sE9B1pw>
    <xme:bYCcZ6s4dS6lz-_4TsZzg3WY1Va_plGsn14inSG4j26nIhj1Fqus2b1FTLNEsyA62
    1NKnEQERAbxaUbRk0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhushhhihigihhonhhguddtvdehse
    duieefrdgtohhmpdhrtghpthhtoheprghmihhtsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehouhhshhhigihiohhngheskhihlhhinhhoshdrtghnpdhrtghpthhtohepghhrvg
    hgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepvhhirhht
    uhgrlhhiiigrthhiohhnsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bYCcZwAb15eDBb6IuvMnfxf0vAFOtz76pVigVbYmJdPv70D4NQ_8JQ>
    <xmx:bYCcZyfruxHPxOugDZV13GbbxP2TGXrezQPMG0BSIhRk4zZKfzcsYA>
    <xmx:bYCcZ_PtfzgVrpfYWD-OaH-OszitF21YD4AQnfKbskr7kd-GI_0Q4A>
    <xmx:bYCcZ8k-K5WatFyPIgVE3hnUcVm69OyU6tUbaxT9MIWMcOtgS10E4w>
    <xmx:b4CcZ60jJwYswira3C4qR2KmnseJUmxnV1iHwF7_V6jMX-7X9awDklJP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7D2C32220073; Fri, 31 Jan 2025 02:49:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 31 Jan 2025 08:48:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: oushixiong <oushixiong1025@163.com>, "Amit Shah" <amit@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 oushixiong <oushixiong@kylinos.cn>
Message-Id: <6d092e0b-3b1d-4d5d-babf-f8c5a4c501d3@app.fastmail.com>
In-Reply-To: <0e5fcde2-140a-4896-8880-5f90f2a134c4@163.com>
References: <20250128055241.30760-1-oushixiong1025@163.com>
 <9a10b435045556f5625afe83bd41bc4d4f9be80b.camel@kernel.org>
 <0e5fcde2-140a-4896-8880-5f90f2a134c4@163.com>
Subject: Re: [PATCH] virtio_console: Convert to use devm funcs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025, at 12:48, oushixiong wrote:
> =E5=9C=A8 2025/1/28 17:39, Amit Shah =E5=86=99=E9=81=93:
>> On Tue, 2025-01-28 at 13:52 +0800, oushixiong1025@163.com wrote:
>>
>> Hm, I'm not entirely sure about this - the devm_ interface is better,
>> but to me that just says that it's an extra safety net that avoids
>> memleaks when we forget to kfree, and not that we deliberately do not
>> free and get lax about managing allocated memory.
>>
>> So I'd prefer a patch that keeps all current frees as they are, but
>> with the added advantage of using the devm interfaces.
>>
>
> Hi, I don't think driver need to=C2=A0 call kfree() by manual if drive=
r use=20
> the devm_ interface

Calling the plain kfree() on memory allocated by devm_kmalloc()
is a bug, it has to be freed when the device is released or
explicitly using devm_kfree(). The explicit devm_kfree() in
turn is what you'd use only if memory has to be freed early
while the device is still going to be used.

> in the probe() phase. This can simplifies the code.
>
> This is similar to the=C2=A0 commit=C2=A0 "55dd7378ba94 (fbdev: imxfb:=
 Convert to=20
> devm_kmalloc_array())"

I don't think it's worth converting drivers that correctly use
kmalloc()/kfree() already. For new drivers, the devm_* functions
are usually the easiest to use and review, and it makes sense to
convert drivers that have known memory leaks from incorrect
cleanup paths, but I don't think it's a good use of developer
or reviewer time to convert drivers that are not wrong for the
sake of simplicity. There is a memory overhead in the devm_*
functions and there is a risk of introducing bugs if the conversion
is done incorrectly, e.g. when a regular kfree() is left behind,
or when changing allocations that are meant to be freed before
.release() is called.

       Arnd
