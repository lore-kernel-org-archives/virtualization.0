Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A030C60C
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206925; cv=none; b=GFf9SbJT+pzLBhJtfpbUKKLZ4xR1nGYzZIXMYzWOWCqGAAedlmJeuDlHKvV31aSSya7brm93W3ThEhwkBxmQJ1l/ke6/eKEPd/Hd8oI2HGkhDvx5HEaSxPb/vzMYlMX24NL6BKB+YnG4diFhYWuz78I3QZHRLsI+1Ci1va2eWgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206925; c=relaxed/simple;
	bh=E2nns/DliZxoREENQkuqsg1ib0804WSu2rjL3J6FI5w=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UZ2JKySG6OlsdyX/TXQQR/LIarV1lgz0/Q3VvEamxpGPqwkeb99JIG7hCeEpXyEHJlU146DDOGhEG1+OX31Nw9wMnETY0wz7HfArCTN+MVR1FqUbJSWqvM4itF0z8xZHXkLKikoWazdOD8woZnIkgdsGZFe1Y1W23pS4Cc8Oafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Yb8j0Ye/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QD/Bo0ba; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Yb8j0Ye/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QD/Bo0ba"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 71C791D00105;
	Tue, 23 Jun 2026 05:28:42 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 23 Jun 2026 05:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782206922;
	 x=1782293322; bh=CjXgazMnqLpFw54KgAqpoHDm1/t4gbY6X/QRdZvwCG4=; b=
	Yb8j0Ye/sQ+3Ck4AZpAYx2P0zmF05v+LyP+64BzLVsq/R4lmcG/sOpd6bGsBm0jU
	m0Bkjz4RTMRFw1V9BnPBZ5yj9fw97M1QEQ7oz8NhGPd9BtAzY6+gVaS4ko0DyUMv
	rxJm8y1TF88Vq9vbKhG0OREl2Mq4PhEGsY1lPP3IXqOiDRYrzYzRLAuqidm95APC
	xDN3zU0WmU7ORc8KdN5tm4agZM6OcdV3XnN7crsmeQZIABD9OSZ3G3uE86GfQyfC
	+1kRQ7Hv5GqOAMRCufMi4RoUN3cHh8pZidYRrZ+m3CvJ/TDJ/1/N9+Mh01xlG0/j
	xPiQSLUEca6FGLmSuAR3Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782206922; x=1782293322; bh=C
	jXgazMnqLpFw54KgAqpoHDm1/t4gbY6X/QRdZvwCG4=; b=QD/Bo0bayTukmb1QI
	aGhERdsxrl9FcsrjyWvCM9uoabUPu/Eoo7uJFYmLRZTiul0O+Mw4dZ8TRKpuBtu9
	2Epdu3NX2bXOAJewO+60oemvSi8G+8WHJ813LJ8AfqkupwcOhaqamuTiqGU0Tifg
	lqccPldqdoPsBvrU8HHhwrWbJzYkHfdvOEs0MlkcbORy1amAkaw3ueM6/qxUrVRM
	5SVJq/bUpUkxfqN00dWNJgk/8HJrrGcZWjk6tzFPRa3pAsi+FeNWl/l3UbVKu9kt
	DrtnG8e/CwkfcvWX1rwfJaOq8iY9JHHtVG6gdlsTV39kdDF6YK5+6576MH28N+VN
	4PQIg==
X-ME-Sender: <xms:yVE6aiJwXQxrrG_g_AaymANuMVOwBVoNd3q7nHahQYGkoNbncUYeNg>
    <xme:yVE6ak8ebu21OYnBlPlXrRfiZb6kXybxEuZM1Uqh_21rmeFap2XsMQ8LQbZxiMG1V
    xIKnW3zQosS5A_repydKjjdQdKXxctU9TNL3K0H-FqwRGGn5bv7BeI>
X-ME-Proxy-Cause: dmFkZTGgDlZN84FA69B41Y6aqwgWP6FOn6p+OSTkkJOeCMSh6NqKJswB99zPBikh+CYkH5
    TZT9mKcrPMXdYjbRU63r0S+ib88qsO17QuEVyEQ8KSCOGy/FSxOwbARjNagQMQyhi2JsCq
    9B1TeBpM7+za6fjcqtvDy4mRxqAT961Ev/+L40AO5T78yEJuaCsJshf3OlJwCWAjguh/Bj
    IdhEyqaQE6DWzVVho3QdGrG/fUldt6jbSbHnUbiSAgyis+NvruE3CSWWS8AfzColhsN+BA
    2hvUXszIDgAS9CpsLI3oPfHuka8YM1kjKs4Tqxc5NYyxdg/wbVdRRfHriT8NqNQsPhcUkx
    QugqevAGoHAjKNiyLRONJgeXmCmKV8bjsxV1ENGgYShlW1I71hd2yOfcuBFVKgfOpFz22b
    G3NkwsIrpaAUumUrofvZ+LMY3yut03ux1g0Ga1h2ENNeC+QIkhgZ5rv+dYj1ynArXl+Jr+
    PgccGoH7L9kNVnFWZKuuut3VkcPIdmeex7YKY1xUDMfuDiT7yd0g6cb1wic9FugwoAUH9N
    AGSSdIFvhb7RpNbxgkqDHTBRSuYLYclt7if5aR/nVgtige1Zq3Y8U2seI7AQQ9S3P6ECcv
    8TmsVTxaXUQ0MjIsoY6KDj56b2HWT9TH+MhwmSkBYpSk1nTqzAJZDY+L0sbQ
X-ME-Proxy: <xmx:yVE6ai-LuV7aIoQBPJo4YhEAKiSwWRGoJ3TRSFepw5F7kMRIt-r8Dw>
    <xmx:yVE6ama-0RAToEvsdIcnFyVV1hzXhLOPkmhptPZS6kggzpgxUk2vLg>
    <xmx:yVE6ah0QKd1EhjsJ-o9xygdlehXuEzy0m_EzIvMr6p0JB_fKeGCorQ>
    <xmx:yVE6ahZan_NLpb9sBcyH3bVrggwjUo5JUxnaYEe3ReJI6YxKmveB2A>
    <xmx:ylE6arPmM7uTvqIWAcO08kLc04pVfALiH7yBzlz__kE2KksLq_bqMIhx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC5E51820086; Tue, 23 Jun 2026 05:28:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AA2IBIVACavw
Date: Tue, 23 Jun 2026 11:28:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ben Dooks" <ben.dooks@codethink.co.uk>, "Amit Shah" <amit@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <e7255f9b-2393-4754-9695-b0f8400f78c4@app.fastmail.com>
In-Reply-To: <20260623092141.631355-1-ben.dooks@codethink.co.uk>
References: <20260623092141.631355-1-ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] virtio_console: fix endian conversion in handle_control_message()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 23, 2026, at 11:21, Ben Dooks wrote:
> There are a couple of prints in handle_control_message() which should
> have converted cpkt->id through virtio32_to_cpu() before passing to
> a print.
>
> This fixes the following (prototype) sparse warnings:
> drivers/char/virtio_console.c:1538:17: warning: incorrect type in 
> argument 4 (different base types)
> drivers/char/virtio_console.c:1538:17:    expected unsigned int
> drivers/char/virtio_console.c:1538:17:    got restricted __virtio32 
> [usertype] id
> drivers/char/virtio_console.c:1553:25: warning: incorrect type in 
> argument 3 (different base types)
> drivers/char/virtio_console.c:1553:25:    expected unsigned int
> drivers/char/virtio_console.c:1553:25:    got restricted __virtio32 
> [usertype] id
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Arnd Bergmann <arnd@arndb.de>
