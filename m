Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0971D9A79
	for <virtualization@lists.linux.dev>; Mon, 27 Jan 2025 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015680; cv=none; b=tMiUNGRCIjj8TjQITumGXAHhmMyzmuFOQSQK9YEJM4RHC4IHSytptC+RsjEgQF38iiMJquOF3u+rVpQAzTq1SuxiBTh2fUy7kcCwG+P7uuW9ODU1IqSLpYGOzOrkjhP2Ztsg64bGMbHi0CY16FD8OB4IE6KcZWLCQR3RG7kz/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015680; c=relaxed/simple;
	bh=OjW398BTWizDSrwZF2nXzwsTgBr9BNV0I55QSA9En5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn7WrUm7NX9WGx3feFvJYExOFpTBQXb5dODF4KtxakNTqmpYenXb687/mc0d2HP57foLI/dm0NoI/V37sBfrZLp0hropvKBsg4wKiVoiFr9jNZ5Y62+O4AX7C73MW3YkVdseGxr7VGDd54myJ+1QLd6nHtjABOoN6frK7w0wugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qV8e2eim; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qV8e2eim"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6eeff1fdfso473322785a.2
        for <virtualization@lists.linux.dev>; Mon, 27 Jan 2025 14:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738015677; x=1738620477; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP5GnQgJZ2/sm68pEmuVw5VQauWjnaDO1BrGzC8Sagk=;
        b=qV8e2eims24AJtZpe+ML9V3o01khoqnmVRBTcqK9UWx8VH2BCg/JrhjDOtHCZ+mtxT
         7sN2cPLlU4ciWwDWFfkbETFG/qf5xt5neKalFViKG00XnldW47k9baNrUyqH/NNr2fal
         EqJ+y9mF7kmL4px2HBb8DfqLV1DypcY5DcTs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738015677; x=1738620477;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aP5GnQgJZ2/sm68pEmuVw5VQauWjnaDO1BrGzC8Sagk=;
        b=AVH3uW7l1IYd5aosMQ8GjiOiVs4GIjzC6xZDfTpNaIO69YZNsJx5tyozB7dkpExsoz
         b9QEVs0x0lxmJVh+Zel6a84neOPSugcejM81QbVscGBXL8Lcqjj7elu4/uIbVU7Bibek
         l0tzIUG17kHuQrrC1KgEkh2sznZRvAYCDoi+AJaXDSJK18lq/ogZCnmnFM0WQ5fSf7Ql
         OC22uTQDag/tZhj4pYMf5d6R8h1e8a3so0VWavKyfqayRL3PmExwLbHj+A5T0aPwAEsG
         0vfEVuZ65+zFUoiYwWeEVmsTkTW7EDGC0ynajfaVqCXVDLBvfnlwft+/2DlhuOCQxVTF
         dZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrxRTb5trE6AF5Jp064i2wMjgEAGu3tNbzGXr7b9NA2T/dV2+/BQ9H5PVDYy/16DKmliegMDY95XwpWpQ6dA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8xsl4RNEBTMYVRE4V90nh/3GWxiPWS7v9Xz9lif4XRBH5PZM4
	RyAOpc/nLpCL2ss6REEGZYCyEfawtDy1Mpc84Jz8MX5VvWbHKrzMY4CiIhNtKmg=
X-Gm-Gg: ASbGncuyUlOEbMSf9aC54iYDUiGMlD2OEw4KA3uOJ0Y0WMh6eL1pTwcZV2MOXyrwnQ9
	/K/voM3IysPPIfcjybtvt8UqmBXCvl7LoAnMfpzdqESf4qiMDRTIaUurQ33EvN3oYwy6Qa0BL30
	2oDMjPh1iEsOTRxd1JwnzS2O0VB9VXNSYE9spslRSwZKzNeUVbV6KxJ/Z6l8TxTdamB8ZgXEmdw
	Fg2luaHFSWngiz13cjWXWKTrVIEYxe87EOR0EL9EHdkdw1LsvIqeSuup+HH+gjlnrI9uuaQ4e+B
	kdx52hGvrS5sKX3+bCYHZQjiBr4eR4Pg6DFloOA/U2o=
X-Google-Smtp-Source: AGHT+IGTdVygXNueO3vCZK4btjxRGHvCS781WeHwgFOuP3bnDqU55mAl0oUxDT4tkYkUoR9+a4Hv8A==
X-Received: by 2002:a05:620a:2490:b0:7b6:e9be:97dc with SMTP id af79cd13be357-7be6320be81mr7301033485a.8.1738015677499;
        Mon, 27 Jan 2025 14:07:57 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8aaf1sm434734685a.40.2025.01.27.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 14:07:56 -0800 (PST)
Date: Mon, 27 Jan 2025 17:07:54 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5gDut3Tuzd1npPe@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
 <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
 <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
 <Z5P10c-gbVmXZne2@LQ3V64L9R2>
 <CACGkMEv4bamNB0KGeZqzuJRazTtwHOEvH2rHamqRr1s90FQ2Vg@mail.gmail.com>
 <Z5fHxutzfsNMoLxS@LQ3V64L9R2>
 <Z5ffCVsbasJKnW6Q@LQ3V64L9R2>
 <20250127133304.7898e4c2@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127133304.7898e4c2@kernel.org>

On Mon, Jan 27, 2025 at 01:33:04PM -0800, Jakub Kicinski wrote:
> On Mon, 27 Jan 2025 14:31:21 -0500 Joe Damato wrote:
> > Actually, I missed a patch Jakub submit to net [1], which prevents
> > dumping TX-only NAPIs.
> 
> That patch only addresses NAPI ops, here I think we're talking about
> attributes of the queue object.

Yea, that's true.

> > So, I think this RFC as-is (only calling netif_queue_set_napi
> > for RX NAPIs) should be fine without changes.
> 
> Weak preference towards making netdev_nl_queue_fill_one() "do the right
> thing" when NAPI does not have ID assigned. And right thing IMO would
> be to skip reporting the NAPI_ID attribute.

Ah, right. Your patch was for netdev_nl_napi_fill_one, so presumably
a similar patch would need to be written for
netdev_nl_queue_fill_one.

> Tx NAPIs are one aspect, whether they have ID or not we may want direct
> access to the struct somewhere in the core, via txq, at some point, and
> then people may forget the linking has an unintended effect of also
> changing the netlink attrs. The other aspect is that driver may link
> queue to a Rx NAPI instance before napi_enable(), so before ID is
> assigned. Again, we don't want to report ID of 0 in that case.

I'm sorry I'm not sure I'm following what you are saying here; I
think there might be separate threads concurrently and I'm probably
just confused :)

I think you are saying that netdev_nl_napi_fill_one should not
report 0, which I think is fine but probably a separate patch?

I think, but am not sure, that Jason was asking for guidance on
TX-only NAPIs and linking them with calls to netif_queue_set_napi.
It seems that Jason may be suggesting that the driver shouldn't have
to know that TX-only NAPIs have a NAPI ID of 0 and thus should call
netif_queue_set_napi for all NAPIs and not have to deal think about
TX-only NAPIs at all.

From you've written, Jakub, I think you are suggesting you agree
with that, but with the caveat that netdev_nl_napi_fill_one should
not report 0.

Then, one day in the future, if TX-only NAPIs get an ID they will
magically start to show up.

Is that right?

If so, I'll re-spin the RFC to call netif_queue_set_napi for all
NAPIs in virtio_net, including TX-only NAPIs and see about including
a patch to tweak netdev_nl_napi_fill_one, if necessary.
