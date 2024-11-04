Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97751AF4EF
	for <virtualization@lists.linux.dev>; Mon,  4 Nov 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715758; cv=none; b=KvDAAXnj1b34J7l10CDn7OXFMog9ZupUnWSwQjhZqDV1Dx9/ztT65YVWca8DEWct9MR6YmesvIKDdi6D+dkaOMwuL6j4s5WmY2fgPmklM5aQ9M+M/B+uahbGDOM6AlW5JfidZsVu+2F9S2I1bsFcODF+kkjCG4RkMnYuupb+ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715758; c=relaxed/simple;
	bh=A0UL6T+JMBlmeQCnuqSKyXXFW6C0TYffPyTQDsuHiuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peF5XxrJ+SPEAmivjGT4edu+qAqDvmVi1N7N5SlebvU5Ld7fVHAEipgKx7nUnAGfmLJ5p7u6HIJjlXVw9kpw/NFKtHqBAs6pN8N95X3WyUaVMGg1huy4Y+U9ePFB1hukndQdgkmsYjsA3lThCxIOI4yIsha6TTDxMHBlZ4+91Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=PR37RNnU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oEM5LkoX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="PR37RNnU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oEM5LkoX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E72321140096;
	Mon,  4 Nov 2024 05:22:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 04 Nov 2024 05:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730715754; x=
	1730802154; bh=UHr/11CY5vimw/kUTbl69+FDNYXMEkNeCHZa+XkrXOk=; b=P
	R37RNnU5KwkJMS1buoBEmY5ES4Suo5WaKshNldMIuDnNUSjYG6Ekpzhi9jgpbUGB
	R+rUe59qdzKeyWBYzSlYb+jv9oKyu6MJ5wLJKdi9svXG2MId2CFYQU6uuoNvO0gr
	DoCePc2RIgA08KfrKDH0tu0K22xA9rSp74+AUYQENTxjNcHrEBUAooHbciRF6JrX
	yTpxWYHL/zaJXd6KK0+u1h1+lu0bbJehzFCSrnXKGVp5HICBKBIsRVHeb/kxFqmj
	Xxd4up3sOjJtBrZGDuHqF6952faOw4k6Kug3GZ6AseGuooYOgElpJ8NGMcY/YGQl
	htO+JEODDeELS5IbYZ+ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730715754; x=1730802154; bh=UHr/11CY5vimw/kUTbl69+FDNYXMEkNeCHZ
	a+XkrXOk=; b=oEM5LkoXN+sqMBZCSUsB2W1aGwf41X6sS/EQwGXOPPxc9a4PfWO
	htfflqEXV6DNLy+OlZ70GpdrqZBtR0k9H+qAxjJjy38GfGFHR5gbqasYGufIdr8s
	zSA1VIe1WM/K/g97s0cxoVgrRS9Xo6zKjjmiO9JrlWA0i6w93pOJw4399SO9IPIw
	yEXbfkPb94Dq+9S7AoPxYA183G/l54WVe/hxkrLr3v5L63gOI81g8OQK5Xom5eer
	m0BLPQc01jqLOOZQoN2+rb+Ojc6EtV8lC3qMn8hfnTJDFlORfUDw4et8Uxy9AkWw
	xJ23O5CUAlng/5l1Zmhs14WBiy//ywzbhUg==
X-ME-Sender: <xms:aqAoZ6KMkUYOv8OD9eGuGlCjbIPFLh-_v1Vlb0PVl-sOChBk5bX1Dw>
    <xme:aqAoZyKJoDn6HFKLb_OZuTU42ynbyKj0KGaO6mWA7g56p574Di0ip8MZLAslebnqb
    _2OztrlJwdU1PSRG_4>
X-ME-Received: <xmr:aqAoZ6tHR6NOP-Mj4yaT2FCNC2KmcOcr862IEro4PLfUNdQ1hRhgacTaLnufngnPgVx1wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepkhhirhhilhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdp
    rhgtphhtthhopehmshhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghsohifrg
    hnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepgihurghniihhuhhosehlihhnuhig
    rdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepvghpvghrvgiimhgrsehrvgguhhgrth
    drtghomhdprhgtphhtthhopehvihhrthhurghlihiirghtihhonheslhhishhtshdrlhhi
    nhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehhohhnghihuhdrnhhinhhgsehlihhnuhigrdhi
    nhhtvghlrdgtohhm
X-ME-Proxy: <xmx:aqAoZ_aRRDDeqN2hDj0MrG_vv1ZNltuKwPb-4PMbgCLUQ8XJAgrpvQ>
    <xmx:aqAoZxbuYEfcBII8kSA9PHJLuqkN4cNTteGJ18O2jjS7Dp0RgZbqTw>
    <xmx:aqAoZ7C_W4sdsgQJu0P_dDKfetQ7KGhYR8v5H7Hx9zaV3b6t2uje5Q>
    <xmx:aqAoZ3ZPJo2-c10dHgUBq8Xyy1tY6mTOliwUw649Pi5Hvg1We_eEsw>
    <xmx:aqAoZ_Nw09S10VgT9tfJqcMhCEJ24SL3QiI4dQ-yo7abUrDCf1qdYeFP>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 05:22:31 -0500 (EST)
Date: Mon, 4 Nov 2024 12:22:26 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <witv2eh3lxidto53m2twxht4lxhfjbcjwzaggalhtnqf73wpng@tzmwda7eeiaa>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <20240808075701-mutt-send-email-mst@kernel.org>
 <yknu4iege3drk6t2x7pvm2l2cocg4r5qk5jzmboej6dqk5ym2z@g4clogtuuibe>
 <20240808105006-mutt-send-email-mst@kernel.org>
 <lszslulefumddbqnhni55sgdfddptw3yb5vfavgnlyiv6wi3vn@44e4tttbvwaz>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lszslulefumddbqnhni55sgdfddptw3yb5vfavgnlyiv6wi3vn@44e4tttbvwaz>

On Thu, Aug 08, 2024 at 06:28:02PM +0300, Kirill A. Shutemov wrote:
> On Thu, Aug 08, 2024 at 11:03:30AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Aug 08, 2024 at 04:15:25PM +0300, Kirill A. Shutemov wrote:
> > > On Thu, Aug 08, 2024 at 08:10:34AM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Aug 08, 2024 at 10:51:41AM +0300, Kirill A. Shutemov wrote:
> > > > > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > > > > accesses during the hang.
> > > > > 
> > > > > 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> > > > > 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> > > > > 	...
> > > > > 
> > > > > It was traced down to virtio-console. Kexec works fine if virtio-console
> > > > > is not in use.
> > > > 
> > > > virtio is not doing a lot of 16 bit reads.
> > > > Are these the reads:
> > > > 
> > > >                 virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> > > >                 virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> > > > 
> > > > ?
> > > > 
> > > > write is a bit puzzling too. This one?
> > > > 
> > > > bool vp_notify(struct virtqueue *vq)
> > > > {       
> > > >         /* we write the queue's selector into the notification register to
> > > >          * signal the other end */
> > > >         iowrite16(vq->index, (void __iomem *)vq->priv);
> > > >         return true;
> > > > }
> > > 
> > > Given that we are talking about console issue, any suggestion on how to
> > > check?
> > 
> > 
> > If you do lspci -v on the device, we'll know where the BARs are,
> > and can compare to 0x102877002, 0x102877A44.
> 
> 00:01.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)
> 	Subsystem: Red Hat, Inc. Device 1100
> 	Flags: bus master, fast devsel, latency 0, IRQ 21
> 	Memory at 80005000 (32-bit, non-prefetchable) [size=4K]
> 	Memory at 380000000000 (64-bit, prefetchable) [size=16K]
> 	Capabilities: [98] MSI-X: Enable+ Count=4 Masked-
> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
> 	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
> 	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
> 	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
> 	Kernel driver in use: virtio-pci
> 
> 00:02.0 Communication controller: Red Hat, Inc. Virtio 1.0 socket (rev 01)
> 	Subsystem: Red Hat, Inc. Device 1100
> 	Flags: bus master, fast devsel, latency 0, IRQ 22
> 	Memory at 80004000 (32-bit, non-prefetchable) [size=4K]
> 	Memory at 380000004000 (64-bit, prefetchable) [size=16K]
> 	Capabilities: [98] MSI-X: Enable- Count=3 Masked-
> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
> 	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
> 	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
> 	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
> 	Kernel driver in use: virtio-pci
> 
> 00:03.0 Communication controller: Red Hat, Inc. Virtio 1.0 console (rev 01)
> 	Subsystem: Red Hat, Inc. Device 1100
> 	Flags: bus master, fast devsel, latency 0, IRQ 23
> 	Memory at 80003000 (32-bit, non-prefetchable) [size=4K]
> 	Memory at 380000008000 (64-bit, prefetchable) [size=16K]
> 	Capabilities: [98] MSI-X: Enable+ Count=2 Masked-
> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
> 	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
> 	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
> 	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
> 	Kernel driver in use: virtio-pci
> 
> 00:04.0 SCSI storage controller: Red Hat, Inc. Virtio 1.0 block device (rev 01)
> 	Subsystem: Red Hat, Inc. Device 1100
> 	Flags: bus master, fast devsel, latency 0, IRQ 20
> 	Memory at 80002000 (32-bit, non-prefetchable) [size=4K]
> 	Memory at 38000000c000 (64-bit, prefetchable) [size=16K]
> 	Capabilities: [98] MSI-X: Enable+ Count=17 Masked-
> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
> 	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
> 	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
> 	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
> 	Kernel driver in use: virtio-pci
> 
> 00:05.0 SCSI storage controller: Red Hat, Inc. Virtio 1.0 block device (rev 01)
> 	Subsystem: Red Hat, Inc. Device 1100
> 	Flags: bus master, fast devsel, latency 0, IRQ 21
> 	Memory at 80001000 (32-bit, non-prefetchable) [size=4K]
> 	Memory at 380000010000 (64-bit, prefetchable) [size=16K]
> 	Capabilities: [98] MSI-X: Enable+ Count=17 Masked-
> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
> 	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
> 	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
> 	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
> 	Kernel driver in use: virtio-pci
> ....
> Invalid read at addr 0x100C37904, size 2, region '(null)', reason: rejected
> Invalid read at addr 0x1036F9002, size 2, region '(null)', reason: rejected
> Invalid read at addr 0x1036F9002, size 2, region '(null)', reason: rejected
> Invalid write at addr 0x1036F9A44, size 2, region '(null)', reason: rejected
> Invalid read at addr 0x1036F7002, size 2, region '(null)', reason: rejected
> Invalid read at addr 0x1036F7002, size 2, region '(null)', reason: rejected
> Invalid write at addr 0x1036F7A44, size 2, region '(null)', reason: rejected
> ....
> 
> Yeah, looks like it is not BARs.

Michael, can we get back to this?

So it looks like to be a DMA.

It is a TDX guest. Some TDX context: it has concept of private and shared
memory. Private memory in only accessible to the guest. Shared memory is
accessible by both host and guest. It is used for guest/host communication
including DMA.

By default all memory is private and guest kernel converts some memory to
shared. On kexec, we convert all memory back to private, so the next
kernel can start from a known state. This conversion makes DMA impossible.

I think stopping devices before doing this conversion is a reasonable
solution.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
