Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953553FB074
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965573; cv=none; b=j9t4H3XXiV36Fm+04lryGH7NRJeR3RhmsivSUZ5roenbp061pi7nnPmHXFZjJWX6Jl6l8L8WM2Y5M+xN/fw9zvvE+MPoc+lYTaOs1nP2G+bs2r4iEm4tD6V0boBs16XmFa6OCCuOdBnb/2RmlPvwPbgDyZ/FTl/uKJSytM21YQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965573; c=relaxed/simple;
	bh=5OWGFl21V9RSEovb01TSZ+iqJKacVvSf+AnktVRnIfE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FvNTRyHCQ/5tpiOF9WE4U3oOuYI3GkN94HSy303s7Mz2u5BTmUB0YFZGzPSO6SDCirI+8oPNBSIz6yA/jTf4YR4BwJ4JA+LTU5u/fJ5U2EoM26MhqArrxAXNnqt7nGNB2NC9uMiEbOMLey34pzmVGLa8YN5m6i4lJWjjft56cGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=K7QK5rJl; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="K7QK5rJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786965567; x=1787570367; i=markus.elfring@web.de;
	bh=gUnkfYclqtknfhgjiDTv5FQoT3LwqeiUQJbMvcgZOqg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K7QK5rJlAOnpuMp2eJcFkYsc6AF/sKUwhaKoJWKO5CT7AqYrb6sedBg2pACaZIVv
	 Bt8OgNLSg+0MdeERHRzRbvTqdpmkNpXrAwVBTwl8211JcckyV4LZ4T1nIMk2us6pG
	 +STqk9bmk9ODvMsarKJ52mQyXAJghfJHksS2ABL04Fw4lK7hHMQkeok20XtYklOS2
	 c9XNqdVtrdaHKqvBV97XbQa0/+81WXAVPVZ4rfG0YG2VU6K01a60gbLUOetc+o3SS
	 iiQHdSMFiv/5pMYlS5RZ5MWV48GjNyae9qnwaGzYtlYhAX/5tVs3bwcA0w2M3b/RJ
	 c+4DI770nyaP90ITsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3qK-1wSeCO0kzS-00ak71; Mon, 17
 Aug 2026 13:13:30 +0200
Message-ID: <11265d47-39c6-43cc-9115-022d464bc154@web.de>
Date: Mon, 17 Aug 2026 13:13:14 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiong Weimin <xiongweimin@kylinos.cn>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowangio@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260811022055.3465420-1-xiongweimin@kylinos.cn>
Subject: Re: [PATCH] virtio_net: roll back RSS state on control failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260811022055.3465420-1-xiongweimin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u2F7T1aWt33OKU9emrR8XZ2J8XTkOEGTnkz/yq5HRfYeYv93WvV
 cCyKKp9EX0Y+9u+FZiZEwF7bo4IYQBj0ZQC9OUdIXm0Fzlvg/mEQ9sTpsAhqAYjeFDDW1h3
 t+bNFBPUKFvseIS4DPFIYaBWdcOikRzz0a2RjN06ljCsAhB9DyQ/Z9lXbfs+qTOImdn37in
 2F0toGg5sQZFsDwIOPV3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TYfuObVzNzI=;uaKr+24jI3pl/40AFEyGGWBlW+1
 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
 fpR5p8z7q0wQGVe3hA31qsTiceSI=

=E2=80=A6
> Preserve the previous local state around RSS/hash control commands and
> restore it when the device update fails, while propagating the error to
> the caller.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc7#n34


> v1 -> v2:
=E2=80=A6
> ---
>  drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++----------
=E2=80=A6

Please move patch version descriptions behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n795

Regards,
Markus
