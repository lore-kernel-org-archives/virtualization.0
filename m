Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BABB34250B;
	Tue, 16 Dec 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866529; cv=none; b=uzIegAIVt8cMshXZxjANErxD0m9DTqq3YGLY9Ko/JZK5HHfHx0m4oSGEHVhzawgOBQ/ajWnlT7JVypibcaK0+VBGSMG9EsrIaQtg27CE1cvMaKSMfdLJ1k2rBu+2Fm8D3lccylzdV114WjJqVxhTQg1Jn97M/tHAnlWuFSDSiOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866529; c=relaxed/simple;
	bh=hl72qZuidi/fLgdA/aZejsYqHxbC0jiouCeZm+C2tmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSeAeZLAFJECqlrYNKouOyZ/EdSNkQ0sqkuUH5i0rQuEP2O/lVqAX+XDXJtMU2/hxTxUs2LkhrhqJg5e1eJjLMEPZy2gUxDy1lSMPjvgvtt7DthmiId13G2cKZaT0rLasciBTlelhOdA8QSGyFNvO3UyKuEltdfMpiSi4wLsreU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XKCGse6H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XKCGse6H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=smT/G1a4XecMcL84CdWCKffzAtjOi+pTXpLkQzVzlqg=; b=XKCGse6HX6ygPEKIC4nnxVc0w/
	ouqT7bgGYHzBIljt18QKaG8+f2Qgi8XEdZE70cbbq7ex1S13MwYG71H6WAjYPtEvROhq9PsQ6hXtJ
	UD/m91O3zYdDb/WWvTcQM02diehZ+F6kzYqwWp/GE88kt0htOmGfJCNrsxmUaolMB5MITTzMCynbm
	uayHye2qDA6HgJ/LtIU5GbNi0Iq0YZ8jsY5gfWXTNO/phmWc+bmEp0uDOJVIVG7FsTM3H1tftVOBd
	QnXXlniND2SUrbv11u/PlNzlTv2bJShenznMBPw6owlCsLoVoCd16oT18MnuTtbRi5xSJoKZOqCy0
	hqxuoN1Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVOY1-00000004mqx-2Hc8;
	Tue, 16 Dec 2025 06:28:37 +0000
Message-ID: <f4ec1d06-0579-4484-adbe-5247374c4a57@infradead.org>
Date: Mon, 15 Dec 2025 22:28:35 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel-doc comment with anonymous macro?
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux.dev>,
 Linux Documentation <linux-doc@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>
References: <aUCkM-lRUmIMAh6N@archie.me>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aUCkM-lRUmIMAh6N@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bagas--

On 12/15/25 4:13 PM, Bagas Sanjaya wrote:
> Hi,
> 
> ./scripts/kernel-doc reports warning on include/linux/virtio.h:
> 
> Info: include/linux/virtio.h:16 Scanning doc for struct virtqueue
> Info: include/linux/virtio.h:139 Scanning doc for struct virtio_device
> Warning: include/linux/virtio.h:183 struct member 'VIRTIO_DECLARE_FEATURES(features' not described in 'virtio_device'
> Info: include/linux/virtio.h:217 Scanning doc for struct virtio_driver
> Warning: include/linux/virtio.h:183 struct member 'VIRTIO_DECLARE_FEATURES(features' not described in 'virtio_device'
> 1 errors
> 
> struct virtio_device is defined as:
> 
> struct virtio_device {
> 	int index;
> 	bool failed;
> 	bool config_core_enabled;
> 	bool config_driver_disabled;
> 	bool config_change_pending;
> 	spinlock_t config_lock;
> 	spinlock_t vqs_list_lock;
> 	struct device dev;
> 	struct virtio_device_id id;
> 	const struct virtio_config_ops *config;
> 	const struct vringh_config_ops *vringh_config;
> 	const struct virtio_map_ops *map;
> 	struct list_head vqs;
> 	VIRTIO_DECLARE_FEATURES(features);
> 	void *priv;
> 	union virtio_map vmap;
> #ifdef CONFIG_VIRTIO_DEBUG
> 	struct dentry *debugfs_dir;
> 	u64 debugfs_filter_features[VIRTIO_FEATURES_U64S];
> #endif
> };
> 
> where VIRTIO_DECLARE_FEATURES() is an anonymous macro.
> 
> What can I do to fix the warning?

Yeah, I had seen this one also. My only though is to special-case it and then
declare
    union {
	u64 features;
	u64 features_array[];
    };
in kdoc_parser.py. Something similar to what syscall_munge() does there.
I hope that would work but I don't know for sure.

At least one downside to that is that we might end up needing to add special case
after special case ....


I guess we are waiting for the summit/LPC group to read and find time to
respond.

-- 
~Randy

