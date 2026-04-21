Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478DF382F35
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757144; cv=none; b=qS7upknyH1cgGCtKNBLOSNl2p+8zHOAzbXdcx4T3P3P2OVoaR9axv0aFymlTDSFMg4mWzuf8cYMyR4bTPhikQUnRgGIq54ebeduhPC9LIU6DgnQj2o3cWL7zhqVi9N4KMqvEKTtqkJsH0Gde2evEQYazaTSVGgShj/KUD4bXzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757144; c=relaxed/simple;
	bh=F046JDo/HP0PPx3wId+tDW0xeVYMGYmS9SI55Gsjamw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ALxtGo320UYtiTgDKuwixruXcyUiiwUAGybhZqh3GVp8Ub/JnJYn6Q/w+u5rL3l0LYPwEslBSL2EKulBhj/sHFChZHqZ06FFaieOooZmH4nu6ygSmBsJHAalEEfBD8DLzUwtyLFOkroGNmpX0IJOy0HjCaQczr3u37IEP+Bv7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PAkHZQG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iz4llzCN; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PAkHZQG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iz4llzCN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 47C0B1D00280;
	Tue, 21 Apr 2026 03:39:01 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 21 Apr 2026 03:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776757141;
	 x=1776843541; bh=jeZM0pri14EBWhIc5+K46G2Vv61YT8jSoFg/tdp6zKU=; b=
	PAkHZQG7HEcIqVo1KdFoF6WR8t3IDuKkTKnj3YKg0DP/VQD4UHFwi0IXe0Qvl+k2
	fiPxy/Ljy4bNn4cokKBvCuGDlpuZvHDaNQExKN4GGQB5HqbSfMz85jCyU1nwHLb6
	gVsGCQymjZNdGQCtNGCkVl1Ty+jhI6DeEBTndWhW5IOWjvFtOcMWpjs0q25QYXmQ
	OHvrVJIR4I7e4cSbPA5eE6leWruitsgel+mLHr/BRbCvrWI7m5m9EhCb8mAy7zEw
	6rxxCfwQXL9O0KYL/2k63LpFfh+rSGgrlaALceR4GVXnpjBi6MMCtFW6sR/JdVCa
	QFRHm480lelPSlCmBUkfAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776757141; x=
	1776843541; bh=jeZM0pri14EBWhIc5+K46G2Vv61YT8jSoFg/tdp6zKU=; b=I
	z4llzCNhpljgpYHmV/8rxvfx8hPNG0niUV7+WrqEdRe7PxP+BQt+/oWzexpc7mfW
	gfJU3sDeXMT9qFINhUmK9FqZpzovLlGNkQ8KVI/Jf/TP7rjBxlr994Sxjq4h1bDC
	JtWom72DCNlSqYcckyqdat+1NVuEv+OoAnudJQIwFJad5TLmeRYqZUe4LhnU5HTa
	QtyhXMromBG+hHjxwU6k5XeuhbcSyqnrXZDOMfbeth7TOUqnaxY/EyLPEmQbKASM
	Ftb2dDRugVz5RD6WOggQsCORskpcyrL81uQAi/hG2GF1n7KBDKIpr4a2ZQW9s5Dr
	msb0gZbDsnkLw0NFz+HRw==
X-ME-Sender: <xms:lCnnaR-EtUoHRcegh4kSiZ9R2HSLC2UDrMZou-JSpKnZ0vplv-PYvg>
    <xme:lCnnaQjvH27NBBzvFszRA2bkNqERZ_j9Ipz9Ccl2hLY74gwcBicx0ropjJfEsZrMP
    cLOXzZ_nfmQbzdWTt6QjikPmbR1EyKI7bwyIg8US0nbTw8M3LRWSZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegrmhhitheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkh
    hhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepvhhirhhtuhgr
    lhhiiigrthhiohhnsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepphgvnh
    hgrdihrghnghesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepkhgvrhhn
    vghlsehquhhitghinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lCnnafjtqGH6YwZhiUI1MG5zcK7FCzD_4AXKWyeX6j1HepzhoI8AZA>
    <xmx:lCnnaeQmKMrd6gl6qIiNioCnHh-sJoWWH5JLKsoDgpN_b6WH32S6CA>
    <xmx:lCnnaRVDfaP2cxxMEaVxKCXbta48lfgL4fkq-EQ2OqyQJ3DgOZ7tKw>
    <xmx:lCnnaSTcpcLNScqhehjYHMmyKXcwKxzjukU-JQSJxsRXqg7LziSrOA>
    <xmx:lSnnaWLn6TpGjN7sZtTVlFlQ-owSOWqtUNEJffeNuSpI3Qd45rM_wjVz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AF1C470006B; Tue, 21 Apr 2026 03:39:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AunhbntQmaLB
Date: Tue, 21 Apr 2026 09:38:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peng Yang" <peng.yang@oss.qualcomm.com>, "Amit Shah" <amit@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: kernel@quicinc.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <37b513d6-770b-4442-b3b3-93b2801f3c71@app.fastmail.com>
In-Reply-To: 
 <20260420-add_timeout_to___send_to_port-v1-1-6c32d33bf4f2@oss.qualcomm.com>
References: 
 <20260420-add_timeout_to___send_to_port-v1-1-6c32d33bf4f2@oss.qualcomm.com>
Subject: Re: [PATCH] virtio_console: add timeout to __send_to_port() spin loop
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 21, 2026, at 08:57, Peng Yang wrote:
> __send_to_port() busy-waits in virtqueue_get_buf() while holding
> outvq_lock with IRQs disabled. If the host stops draining the TX
> virtqueue, this loop never terminates.
>
> This was observed during secondary VM boot: virtio_mem plugged memory
> in multiple iterations, each emitting dev_info() messages through the
> hvc console. A writev() on the hvc TTY entered __send_to_port() and
> stalled in the spin loop. When the watchdog bark ISR fired on another
> CPU, it attempted printk(), which tried to acquire outvq_lock through
> the same path and spun indefinitely. With all CPUs stuck, the watchdog
> could not be serviced and triggered a bite.
>
> Add a 200 ms deadline using ktime_get_mono_fast_ns() to bound the spin
> loop. ktime_get_mono_fast_ns() reads the hardware counter directly and
> is safe to call with IRQs disabled and spinlocks held.
>
> The 200 ms value is chosen to be far above normal host response latency
> (microseconds) to avoid spurious exits, yet well below the watchdog
> bark-to-bite window (typically 3 s) so that CPUs can escape the loop
> and complete the bark handler before a bite occurs.

Which host implementation do you use? The way the virtio_console
driver works really assumes that virtqueue_kick() consumes the
buffer synchronously. Even though that is not how virtio is
specified, this does tend to work. ;-)

> @@ -632,10 +634,18 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
>  	 * buffer and relax the spinning requirement.  The downside is
> 	 * we need to kmalloc a GFP_ATOMIC buffer each time the
> 	 * console driver writes something out.
> +	 *
> +	 * To avoid spinning forever if the host stops processing the
> +	 * TX virtqueue (e.g. during VM shutdown), a 200ms deadline is
> +	 * used to break out of the loop as a fallback.
 	 */

Did you by any chance mean to use microseconds instead of milliseconds?
Waiting this long with interrupts disabled likely breaks a lot
of assumptions, e.g. in the scheduler. If you have to deal with
a hypervisor that does not handle the console output synchronously,
the alternative suggested in the existing comment would likely
be more appropriate.

      Arnd
