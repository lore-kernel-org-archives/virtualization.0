Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055328;
	b=34aDvSciu+VuXD/et3jyybROxuAfCrviCUTTrPI9Ma0bgr465Eguo5eqmO8APXFcfqDF
	 a49wBhyGO4RZR82CpwtMrUl46/NIDZ5eygYnosoCrkoBzxQv66UYyZNx7D6ohzV84QK8E
	 EUSYVztHth5IpAAF09nDp3apBDJUxLuvTqm5hUTFwQekJnxLpsrKDJ/va/qXR+DCiUMW0
	 Vx+pXH+PCLJpiB/u5ugM3O+eh9alElTF+Vh7X8lwEVAAhGKjFQrHyPrgxMlL3i8NvtX4g
	 jDbvCGFyn606IQIZ/yrlKP3p0FMWSbmRdhkpYX6T8JO9UHgGymo80+Xs7p2xad9G6EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055328;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VSmr5vXbmsuCRGN7b7MuI6UN6XrNtVVzPed/LUHALvg=;
	b=PtcKdM5/s7H0yo6P1thEp61epdoV9IkHTrT3EDmJXMAOKslq8dOFK4PgGTPdx9MjG52G
	 YQ4Y9PXU9CYyBN3K/NBumzPOWbKVfpsDdZRiXzEWm8FFX7JzrnrMnMccbqoPwjTaZL8Q0
	 z4ARHI/ql7NPwTb5hSDZ8Kx9TMnAnbFBEtk7TXryLDYqVoH+pxppFSe3aw7GXpLtzkXZc
	 4z2WQjrcWJNVLZ91DHgD6Oy5KS2CwjugKv8AIo+1LzZbQEFFHSl9dxTf3Cy2IXpPUto/d
	 iZnT/lNt6BGjkDyGthw+kGQE1Z07z3F0AzKvR5z9BAefFgjrzHfADq0iU5Mj4QrFnNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCf8TzyK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26248606A330;
	Thu, 19 Nov 2026 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCf8TzyK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85101F000C4;
	Thu, 19 Nov 2026 02:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795055327;
	bh=VSmr5vXbmsuCRGN7b7MuI6UN6XrNtVVzPed/LUHALvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QCf8TzyKY+FlztwuipmblRq0WGMCQ00jFnkGWbjo5MJ4EngICXY+S6N0DfoO5YAjp
	 c9M4WFmnKvN75qwy32jrIRSBJfG/hJz3sNpIHm9n6K6c1EevqY118uf9Gosph6nz7y
	 NsFPPqZ1wZyUp18XZXx2uTZ5+0AP4zoX2WQwj8xViiLt73GxQ/OfUcBPYOk9rM2cIX
	 /i4yXRU59k7XNjxjy/8F8PM/vIOJTFbfuXWKi5ruEs65omlMkreIHesaYmkx2GItNH
	 jHJkHQ5axVnvJY1hsnPLFvy4a0/Y5iejnpry8NLSsu23kEHhqq7axp5ZxWA7/WeaQf
	 3oYcL2bSn71YQ==
Date: Wed, 18 Nov 2026 18:28:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@kernel.org>, George Zhang <georgezhang@vmware.com>, Andy
 King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <sargun@sargun.me>, <jlinbox@meta.com>, Bobby Eshleman
 <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v7 0/7] vsock: assign the guest vsock device to
 a network namespace
Message-ID: <20261118182846.4ab756d1@kernel.org>
In-Reply-To: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 17:54:43 -0800 Bobby Eshleman wrote:
> vsock network namespaces let a host put each VM in a namespace of its
> own. A guest has no equivalent yet. It has a single G2H device that
> cannot be assigned to a network namespace.

PW says this did not apply at the time of posting, pls respin
