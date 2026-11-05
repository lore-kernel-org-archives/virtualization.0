Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885472;
	b=CBGjaLW04fogSV4TxdW/m8y7yoFRbpiM7oqc0wlsUr/k3hcpMOYUX1q5mOM7akRj6eN0
	 QHgO3B8OkKpHCt2mFP/umT/ajKEFJCRvibpQ9JPZbXkf+HhBD+0fqlkeEx20Zan7Bl1b9
	 N2WtYUG5E/9fG51N5Pi+8bq55DgeeM2GqeHAmg2fY3MB98OVN2MQKzvnZyahIb0HCATls
	 IIW7OpLKCazqcmHBcYscIGXAW01A7XKUfhPZdZfclinPE2WEPAvc2peO7EwBKaUxbVnvN
	 L6HwA4RLpvvB75X9Woaw5Prkf1PwSRuJ1qlUUR0Sk+52HRYdyvhMbsd62ItfMlJaxyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885472;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OTj7VcL8EtaUVu5A+k9DcHPWHRakiG5znMzxvaq8fkE=;
	b=aHlZvKkOl1qMQz1uQRU2XscP26ou9X0klHoU5/YfU5N4btMSXhn9bjyZd29QDjF0zhTp
	 VSwTJP5jeTF/U7S4o9F0lW9pTS9XSFqJxhkKumWF2OuoDbKdtAZDS/4I8dfdMFaQ7i1Yu
	 oIcDbAM32s5HfD3ldI77sHnc9JsXfS+x6gPDbuZR3zG5xqGE2NunjRsb3bIeb+fizcVn/
	 lzP5l+548Ba5bfps/8XFBJc/ctJaGJ46XXJSiL9k3kjBEikh4ptvA03CzwhXx46ckjob4
	 Yxnd5AvO2TgcdxYMXWQP0t/QT+nfQyRiC7Aij/KRBPvxKxCI6NSaV0/IIZewzfzbLbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnu1M2Ts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BAD606A31B;
	Thu,  5 Nov 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnu1M2Ts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BF81F00A15;
	Thu,  5 Nov 2026 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885472;
	bh=OTj7VcL8EtaUVu5A+k9DcHPWHRakiG5znMzxvaq8fkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mnu1M2TsU3zdfheVZHEF+9BVafth3sxi7nH6Dt3ZwU7WcE0FLlcFYCMeyGPjWf2iQ
	 MCJJJPpi2nwReAATz2Pl0HcuTT+VoXubG2FLtLmS0TxyF8D5qwoy6UmAVlxBHSubIu
	 gTlnQUwjIMeJS91fFxHv9T2NfFugw0c50959dNjQ6C5UCi3qS86i52WRpcW03MUpb6
	 EoISckRHBrtuwCFscOqS7VdMHIV9UvQ0Hd4+FY5PnMf53qVDkEWo9rmxq4klyNjovU
	 2OGB/YkeJzJSaHjyx/uJ/lfngekokSLtVllbwZWzKwopvm3oAtg5Jfj44cWWOGLk3+
	 qqpBJ+PnFtwaA==
Date: Thu, 5 Nov 2026 13:31:08 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: sashiko-reviews@lists.linux.dev, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net 2/2] net: validate xmit skbs in generic_xdp_tx()
Message-ID: <20261105133108.GR865646@horms.kernel.org>
References: <20261030114753.185281-1-vladimir.oltean@nxp.com>
 <20261030114753.185281-2-vladimir.oltean@nxp.com>
 <20261030114753.185281-1-vladimir.oltean@nxp.com>
 <20261030114753.185281-2-vladimir.oltean@nxp.com>
 <sashiko-outbox-191926@kernel.org>
 <sashiko-outbox-191926@kernel.org>
 <egj2sjr6palh4p7daxvw7t547eghkl5mzprjaaxzijtzg2ghpo@wahu23aivld3>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <egj2sjr6palh4p7daxvw7t547eghkl5mzprjaaxzijtzg2ghpo@wahu23aivld3>

On Tue, Nov 03, 2026 at 01:39:26PM +0200, Vladimir Oltean wrote:
> On Sat, Oct 31, 2026 at 11:48:09AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > - [High] net: out-of-bounds read in qdisc_pkt_len_segs_init() via generic_xdp_tx()
> > - [High] net: shared skb->head corruption on cloned broadcast skbs in generic_xdp_tx()
> > - [Medium] net: WARN_ONCE in skb_checksum_help() from generic_xdp_tx() after XDP resize

...

> In short, I don't think this patch makes any of the above problems worse
> than they already are.

I also believe that response can be extened to the overlapping feedback
provided by netdev-bot+sashiko@kernel.org 

Reviewed-by: Simon Horman <horms@kernel.org>
