Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BA1DE89E;
	Tue, 18 Mar 2025 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291522; cv=none; b=hRVkuJFTy5jbuNgp92KNGl3UioiuuMjiwpl1zdd6gaUVaOd+iqWcKcvsPlmEHoUAEsJb5NaubS6TgHOkphtS+73MLH1R2+u0GJ6U49lgt0Z5f8eUvK/xbhEV1J3p/fH4nZETMpMn3/jad8iM+TPeLOyOOH3YfheHUqvKduqcZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291522; c=relaxed/simple;
	bh=pMNUflXWPfZ4sSrGdZfZdPj9WA0/N8peieHNXj+8ohw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BancGsbS+iQfoAN2MtBIPfJPIPZQDPvJo61d5o7B0U+AHECEfek7q7LBcDTDcaOyElm5qfjc2Cc5+OmTFovREGtrmovOngEu0Moi6B06AjWAY+1BDGuTDs1aPis9ILj32PBW692ihuVTtNgnCnSjpJjx5OaweH3yCauviQBm+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4KAWOo9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4KAWOo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CEAC4CEF1;
	Tue, 18 Mar 2025 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742291522;
	bh=pMNUflXWPfZ4sSrGdZfZdPj9WA0/N8peieHNXj+8ohw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Y4KAWOo9YHe72uqjHQbVAB/J9Lhgol2WasXb5prz6t1fMSPERV2oD0+1KkGmrabif
	 +jMhIOdEdnZUWJHprCj17Ao5FuX9+dEiqydVO4veAk6uHW6GYbNcRwWSp+kN/YuIRa
	 e7ZgJCfBAe89WCQA74KYLPz2xew3SPqYclHNt1fAzhxHoWU4c8DpxgweVx4u+aENxT
	 BSZnALkjbJMGHDrW2nRfDftHk/5r4BXmkWJY026y/VMCreW5ZsIn5wCg7FCXBaa/9j
	 UTinhswIqibXKwKT1+A1Fjw9tNUQgLFIT1vPRAl8A54zTp73aTaqi3eH3JpzHdDSkQ
	 L9HEmMmP+81KQ==
Message-ID: <6760518ea9e65ec5d1a18861f88e0a758e0f3fa6.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Amit Shah <amit@kernel.org>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, Niklas Schnelle
	 <schnelle@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com, 
	pasic@linux.ibm.com
Date: Tue, 18 Mar 2025 10:51:58 +0100
In-Reply-To: <62008b201c5a64df28c0039020d9bd7959744014.camel@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
		 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
		 <67efe42ea8c10120f13f14838f7a3d883184ecf5.camel@linux.ibm.com>
		 <35286574f42ae6a413eaca14633a11d50cbadb2b.camel@linux.ibm.com>
		 <12d78b156c65130c60503b3925b4440d570fa245.camel@linux.ibm.com>
	 <62008b201c5a64df28c0039020d9bd7959744014.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2025-03-10 at 14:04 +0100, Maximilian Immanuel Brandtner wrote:


[...]

> Just to make sure that everyone here is one the same page there is
> indeed a difference between the ordering of the control resize
> message
> and the kernel implementation; however as this bug has been around
> for
> ~15 years the spec should be changed instead, right?
>=20
> I would like to get a clear ACK of the issue, as I would like to
> reference this discussion when creating a bug-report on the virtio-
> spec
> github.

I'm afraid you haven't understood the difference between a control
message for an individual port, and the config space for the entire
device.  Please re-read my post earlier in the thread, and follow the
code.  There's no divergence in the implementation and the spec, and
there's nothing to fix.  If anything, there may be a chance to add to
the spec the order for the control message - though I don't think
there's a strong need to.

		Amit
