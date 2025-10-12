Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C3C214807
	for <virtualization@lists.linux.dev>; Sun, 12 Oct 2025 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760253990; cv=none; b=tYodbcbVBsf5kAut1TNTZ1qMnfXleRV4U8l8CU9bX0W65nyTwSz6Npv5QRxcHxQwak6LeK/vE7W7lZ7WMQYVgW4S8CrKNwxfx/MNuhtzMInesxiVNY8CPWQDWa/7Vh72/v1lL1WZAAl7KXmYRp5A6oZv4JHrCGbf3vGrXYsw2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760253990; c=relaxed/simple;
	bh=UEv2x/Lmp84MhY9spkwvdA5qI6xvme3Kk+89d41lEWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qA1S6RYbNKnOryaYrSAOzYlUQ2ZTr1XPmIZunKFfmtlmHoWRdk+7MlTCo5Yub62iD0lCXYtJxOSwHjkZNiqfe/DVl/lBZ8YbEU7/4WhZg7PVuYhdH7eBz+fqgzy1jwC63tFnzDksfe016ytUzCP98Ln8DjLVsCVJrqgKJpqhRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdmKOPcL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdmKOPcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760253988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mg3HCPvWm6jwVlci7BHs0yCEk+Zd1iOvD/o3EJNM9JE=;
	b=BdmKOPcLGmHQBCuih3yJFx7ptznKkA1R7ar72zjy/HdeU79B4j3gBOG4qmW1b2cZ9yQjGO
	1k44Qsh750Ox2XutuhHIGl8sj//CN9znl0zcIjsEGRVHc2S6ZfzeWRUwpNjQZEzhx9FheX
	j9TmfmDgkoECLvNBBxPAcLsqrwnoJpA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-Iu0Vsrd_M2mor0xnftxn8Q-1; Sun, 12 Oct 2025 03:26:26 -0400
X-MC-Unique: Iu0Vsrd_M2mor0xnftxn8Q-1
X-Mimecast-MFC-AGG-ID: Iu0Vsrd_M2mor0xnftxn8Q_1760253985
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso23043525e9.3
        for <virtualization@lists.linux.dev>; Sun, 12 Oct 2025 00:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760253985; x=1760858785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg3HCPvWm6jwVlci7BHs0yCEk+Zd1iOvD/o3EJNM9JE=;
        b=mvh39QVQnKZs7ji92LsocPKBJQO8yf7fjUeKRltBnrGmlku+q46Kyz+Wk+jb57BvP2
         4EmKvenqLQWoBjwMipvDKBPGb8cD06piq5vzqtFL1XWfwQd7zl1ip3TuBz150wOy5ApV
         SR+8NZitxLU3eUgb3CdIlPI715OPRmq63MKqtkUl/Kxl3unkcvzAU3xhJw/AEPsFrVOT
         SpF/pOgkVFPR+4Wu62NBzGWDeRPtY72DWimTInV7uawL+Qj54y+SlsO63bYOPMYK5nbs
         0lc3KYyp4TnSv0m+5wYqW37kKrGxaeVr2cu5BUhQ5u9nIrlzNK2mUkb9UtTktl6EjqXM
         LxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMeXRKH1jYMoHMrvPbmGg7oaSOEp8sHfVtjr+5w31pTgc8CjaYKqow7zMq4VZMFKlrNXu5HTc79yigkAK1TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzupaG2w/vLkKrSMjYTuzx0JU8TaBXvNcSelyu49Ixrc786RWdQ
	3g9Ql/d4arnh0J/L7iVb7Jn8oeyqL0KV9XDX+Or1104nxAeLYM5xpdaG/hvhdp7XndrgMqb+rgr
	ba0L2C0YadW9IavvB6S2I1kmfAwSytWid7pecHWKgxqujffqIdXOfkLmX9J3T0zBSyorR
X-Gm-Gg: ASbGncvLiJOgbb70zBakGnATRX1R1qA8cyOm+jMVqy2AC9mPIFUhKFN7BFUGOE/bQTP
	TcMg0lOT1LqNURwzJCs0TeiFnK0tqivvTprzcxF9nbLrlyq+xvrll0EBJLSL+qK+IHs26HhOHiH
	wXeBrV2XYAjslt9S/YW1N4iuVex7ZbZ4ruEsQBSJrgAQ1+ALQOPgrgji0cPNR0WmikxN5pDxE1w
	MQccFdJLMuaDm2UqpBnQkqbGfOyuIn4X+5eQKdOXqpGXy/AHWYBXijnjHI0q3wzR7xG7B2IjTgM
	BowE35Q57lt5tvnWcH0qmCKWML1ZK0oXHw==
X-Received: by 2002:a05:600c:1c96:b0:46f:c0c9:6961 with SMTP id 5b1f17b1804b1-46fc0e7f6e7mr21553955e9.14.1760253985220;
        Sun, 12 Oct 2025 00:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3gaXMtNNYza81JdpwSjq/QqGvQLh5iun4C2wC9jv6BcMxYyPNrpdbHApBSwlfgxaXbiFriA==
X-Received: by 2002:a05:600c:1c96:b0:46f:c0c9:6961 with SMTP id 5b1f17b1804b1-46fc0e7f6e7mr21553775e9.14.1760253984757;
        Sun, 12 Oct 2025 00:26:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb483bcf9sm127107785e9.6.2025.10.12.00.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 00:26:24 -0700 (PDT)
Date: Sun, 12 Oct 2025 03:26:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] virtio: dwords->qwords
Message-ID: <20251012031758-mutt-send-email-mst@kernel.org>
References: <cover.1760008797.git.mst@redhat.com>
 <350d0abfaa2dcdb44678098f9119ba41166f375f.1760008798.git.mst@redhat.com>
 <26d7d26e-dd45-47bb-885b-45c6d44900bb@lunn.ch>
 <20251009093127-mutt-send-email-mst@kernel.org>
 <6ca20538-d2ab-4b73-8b1a-028f83828f3e@lunn.ch>
 <20251011134052-mutt-send-email-mst@kernel.org>
 <c4aa4304-b675-4a60-bb7e-adcf26a8694d@lunn.ch>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c4aa4304-b675-4a60-bb7e-adcf26a8694d@lunn.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PP1ebvDw4QItFRUhzsIaUYCxwTeRdvr3FWD0oOhmyPs_1760253985
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 11, 2025 at 08:52:18PM +0200, Andrew Lunn wrote:
> > That's not spec, that's linux driver. The spec is the source of truth.
> 
> Right, lets follow this.
> 
> I'm looking at
> 
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html
> 
> Is that correct?
> 
> That document does not have a definition of word. However, what is
> interesting is section "4.2.2 MMIO Device Register Layout"
> 
> DeviceFeaturesSel 0x014
> 
> Device (host) features word selection.
> Writing to this register selects a set of 32 device feature bits accessible by reading from DeviceFeatures.
> 
> and
> 
> DriverFeaturesSel 0x024
> 
> Activated (guest) features word selection
> Writing to this register selects a set of 32 activated feature bits accessible by writing to DriverFeatures.
> 
> I would interpret this as meaning a feature word is a u32. Hence a
> DWORD is a u64, as the current code uses.
> 
> 	Andrew


Hmm indeed.
At the same time, pci transport has:

         u8 padding[2];  /* Pad to full dword. */

and i2c has:

The \field{padding} is used to pad to full dword.

both of which use dword to mean 32 bit.

This comes from PCI which also does not define word but uses it
to mean 16 bit.




I don't have the problem changing everything to some other
wording completely but "chunk" is uninformative, and
more importantly does not give a clean way to refer to
2 chunks and 4 chunks.
Similarly, if we use "word" to mean 32 bit there is n clean
way to refer to 16 bits which we use a lot.


using word as 16 bit has the advantage that you
can say byte/word/dword/qword and these do not
cause too much confusion.


So I am still inclined to align everything on pci terminology
but interested to hear what alternative you suggest.


-- 
MST

