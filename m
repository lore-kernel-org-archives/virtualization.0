Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51596274643
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115210; cv=none; b=bphFnF/Ps3jYplUAb9mkUIWeYjGyB2XVN4v3tjFzrwFu9HFOKjrUTIvVABK2NfUcPFbis5xet7H09fBMHTKkqmRKAOQdZQnGhE4pWeLasKR3uA3+HgW4rhq4JN7B6MutD+iYCB5zzR4T4Ve4VhXygm0hKNNoMlrdrMU0IiQN3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115210; c=relaxed/simple;
	bh=ww7N5l7TKyG8ECwwj0D/KDpz3M4iLQ7/Ma6/Z/7fEK4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tY8Xr0EkvJ3nQEwSHv9bh3H3ZnaLXQyoFfXevRmYsbwK/8c8fV66pU/k7dPDLt+7ibsG6QyE+oprJApufyqvGdUoRrIJxbuSz5ZNan52pF9oGEbz/TJeI1ZLH+9vT9qz/0awnDnRNddCW7+7ESsTaY/Cmg7GNlGYKNWzxurzZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JzY+Cfj3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wl9Z6aLv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JzY+Cfj3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wl9Z6aLv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 69E30EC004C;
	Tue,  3 Feb 2026 05:40:06 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 05:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770115206;
	 x=1770201606; bh=46ri+U2S4uPWf8V1Ppjtd8XsI0MHkHcQpXMn2srXH40=; b=
	JzY+Cfj3s3RvET4xNbaq0uLIPZwchKGKUBpz9KRu58dD/LWI7NXp1h78yU0VXm3o
	KZ9Zvv5AB/sLhmBGHfWE+Qd6x8Y9siwTw6cMf4o2Mf/OLEKQqIyWVsGOXRLf/KGY
	aKvTcw5UtSIaZTXmjjNjS31a5gHqu7pF6tM9DUJv27+fPn1Ypiez/pn7jRL/l48/
	HCatRPO0FaJwdU6DnnkzzPoNFR8eCFl/0TnpgBuNGo0Isbey9LgLC9ajtpj5Tk2Z
	7aJaKhGpsN0ygjVvr4zngtFdGFQsP+MUX2z31gwbx/kTGhqMoUsizQMp48Efzyyu
	EkPp8sAGmOyEAip65+kiNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770115206; x=
	1770201606; bh=46ri+U2S4uPWf8V1Ppjtd8XsI0MHkHcQpXMn2srXH40=; b=W
	l9Z6aLvR9SY1hp6iyQSIhlETHcaxVEVwFGg+Wb9CPmc8xWjEpl9lM3sODkvmuxsD
	ifbXhQrpN9QSNoNZom6TX0L9YjstuHwbWXOa1+bEBQovppYaxAjrblVGHbOAersk
	IME3cKfZ9v+0WO04I4+3M02p08LSevPbq8ON0So6bQ1OlxeJ9u6tRUeeGAfrcIkg
	YBU7PH0hUC5sVhSKC4Uia6AxvU7TNXcDdnVjkUBw8P2aG8aY7T/SWFugfRctSylH
	kW4FTVqbitvLOg1jjuxd8H7rRtTQJCEI2V0BKKQ401RAgJ/xKDX3ODlPEf39jvaD
	8NsfCvZ499uk7un/5FkgQ==
X-ME-Sender: <xms:hdCBae0fpMf64oaFawh7oTCuUhkRd8RJ8yo2ZSrnh5jzFJ438YymQQ>
    <xme:hdCBab5Zm0XlG5jI6UJy4ooWJxpDwwZdYvr7qHG7X84jyL9PzaXnPAqMGvIqulsDn
    n28_WzmNgXgJx5qnhiC_kzzb6Aby_PJkiCBuNh7RJ5VjGtBwYJ0RYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepgihivgihohhnghhjihessgihthgvuggrnhgtvgdrtghomhdprhgtph
    htthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgihurghniihhuhho
    sehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepvhhirhhtuhgrlhhiii
    grthhiohhnsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepvghpvghrvgii
    mhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghsohifrghnghesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hdCBafmQlgTeDqQQbgqWB3kRPKJryLxjNMTcuYORPo7CACLiU-T3eA>
    <xmx:hdCBaVZQmwAQapDC6K9BoLl4sNtdO4JXbuElPey21Pvrk5pXX7f8Aw>
    <xmx:hdCBaZRNtPajMYs9do2tOOr0qrbQyBR38IVB8lSmgG1b_SsdOekNFQ>
    <xmx:hdCBaXu1dPLfMemKGOMz4ZdRUCVKBChc0uZVf2Fe2sMMRgTyVMaiJA>
    <xmx:htCBaWUau1g0Q0PIBC6-PK21yCFeUJmjHc9Q6fgNHLtO1GBl-VMjnPi1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4532C700065; Tue,  3 Feb 2026 05:40:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AHNzp7ZveCG3
Date: Tue, 03 Feb 2026 11:39:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jason Wang" <jasowang@redhat.com>,
 "Xie Yongji" <xieyongji@bytedance.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <fb0a4664-4509-4a50-b717-4ce842ab2a6a@app.fastmail.com>
In-Reply-To: <20260203050216-mutt-send-email-mst@kernel.org>
References: <20260202224835.559538-1-arnd@kernel.org>
 <20260202224835.559538-2-arnd@kernel.org>
 <20260203050216-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH 2/2] [v2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 3, 2026, at 11:22, Michael S. Tsirkin wrote:
> On Mon, Feb 02, 2026 at 11:48:08PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> These two ioctls are incompatible on 32-bit x86 userspace, because
>> the data structures are shorter than they are on 64-bit.
>> 
>> Add a proper .compat_ioctl handler for x86 that reads the structures
>> with the smaller padding before calling the internal handlers.
>> 
>> Fixes: ad146355bfad ("vduse: Support querying information of IOVA regions")
>> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> The code is directly copied from the native ioctl handler, but I
>> did not test this with actual x86-32 userspace, so please review
>> carefully.
>
> More importantly, I'm not applying this until it's tested)

Sure

> ifndef CONFIG_COMPAT around the structs will make it clearer
> they are only for this purpose.
>
>> + * i386 has different alignment constraints than x86_64,
>
> why i386 specifically? many architectures have CONFIG_COMPAT
> and it looks like all of them will have the issue.

No, the weird alignment rules are only on arc, csky, m68k,
microblaze, nios2, openrisc, sh and x86-32. Out of those,
x86 is hte only one that currently has a 64-bit version
(arc and micrblaze 64-bit support never made it upstream,
sh64 was removed since there were no products).

All the other architectures with compat support (arm,
powerpc, mips, sparc, riscv) have the same alignment rules
for 32-bit and 64-bit builds and align all integers naturally.

>> + * so there are only 3 bytes of padding instead of 7.
>> + */
>> +struct compat_vduse_iotlb_entry {
>> +	compat_u64 offset;
>> +	compat_u64 start;
>> +	compat_u64 last;
>> +	__u8 perm;
>> +	__u8 padding[__alignof__(compat_u64) - 1];
>
> Was surprised to learn __alignof__ can be used to size
> arrays. This is the first use of this capability in the kernel.
>
> I think the point of all this is that compat_vduse_iotlb_entry
> will be 4 byte aligned now? Very well. But why do we bother
> with specifying the hidden padding? compilers adds exactly
> this amount anyway. Just plan compat_u64 will do the trick.

Right, I could remove the padding field here, since this is
just used to document the size of the otherwise implied
padding.

The patch I used to find the issue originally adds explicit
padding to all uapi structures with implied padding, so I
did the smae thing here.

>> +#define COMPAT_VDUSE_IOTLB_GET_FD	_IOWR(VDUSE_BASE, 0x10, struct compat_vduse_iotlb_entry)
>> +
>> +struct compat_vduse_vq_info {
>> +	__u32 index;
>> +	__u32 num;
>> +	compat_u64 desc_addr;
>> +	compat_u64 driver_addr;
>> +	compat_u64 device_addr;
>> +	union {
>> +		struct vduse_vq_state_split split;
>> +		struct vduse_vq_state_packed packed;
>> +	};
>> +	__u8 ready;
>> +	__u8 padding[__alignof__(compat_u64) - 1];
>> +} __uapi_arch_align;
>
> it's a global variable? I'm not aware of this trick. What is this doing?

My mistake, that should not have been here.

>> @@ -1678,7 +1799,7 @@ static const struct file_operations vduse_dev_fops = {
>>  	.write_iter	= vduse_dev_write_iter,
>>  	.poll		= vduse_dev_poll,
>>  	.unlocked_ioctl	= vduse_dev_ioctl,
>> -	.compat_ioctl	= compat_ptr_ioctl,
>> +	.compat_ioctl	= PTR_IF(IS_ENABLED(CONFIG_COMPAT), vduse_dev_compat_ioctl),
>
> Too funky IMHO. Everyone uses ifdef around this, let's do the same.

Sure. I only used this because you asked for fewer #ifdefs in
my v1 patch. If I use an #ifdef around this one, I also have
to add one around the function definition. In that case, I'd
probably change it back to the x86 check there, and use

#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
      .compat_ioctl = vduse_dev_compat_ioctl,
#else
      .compat_ioctl = compat_ptr_ioctl.
#endif

      Arnd
