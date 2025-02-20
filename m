Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7941E9B2A
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039222; cv=none; b=qovDCj32+aw/KKEilBuqsURSqojpuXBCRj1G3eTUeR/pC/bIR4a0MjCED8zQJpCv7U1IKkZMw03UCciVTkox6ZdlY8011PFIAUv55aA5ABHu3Rop8ubODLETbHB4Bxl8zxSRA4WoWwUjiqRTgMy6XgW7XMXKRXE2eLzjAE6pqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039222; c=relaxed/simple;
	bh=NR1AzEHW3X4hTDfCdv4wws5y6bJ4IHoskvMdZyfEWxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvAGPEZDpgyd8NHUMWfzAoSyL+Bq5sp4YQj/QA8Y5FTzMeGcvOo/m4I7s8hc2I97yFR3L8sRAxXjXDBf7UbXUjWl5/dQfolWovafazCww8U7FP00HmuZowLvjKSZ0RYE6BxlCt/OV4tsR9eZcNkDw9csJcP0vgKWfRRX+3rsxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIWs7Mxt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIWs7Mxt"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c92c857aso11511785ad.0
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 00:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039220; x=1740644020; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz/pGvR+evldl5mhlvuI0J68W2mI9FP4/s36oM1FYLQ=;
        b=VIWs7MxtJtaBviMN79tVmNJ1c0csWLHPp85DKZydDcWtsI2DgDsLmNdu95m+aWtfgB
         pEOWiHw4guuRkHNCEsz0JHnqBasXYB5nnyMPJaOTPskGqGdnNV35SBd3/TXVpPlVwTGS
         7au/5PGD1izDSf+Ds1odYZXtLSKK9f+V7tv0pqJP+NIVTSSvmHSIzJjreVHzpEL405WK
         Pg8gF7P9SJiCHk5dvPQv988zTj9jtxg9f9GmGHtQLZTS3wxpaKUozHsOGY9ucJCwG/QE
         T6qQOOFO9+vgUpH3V13Gt802uYUM5NYQE8T9htZvlIfOYoEOUc2CDHA0d4drs7pGziYM
         WMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039220; x=1740644020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz/pGvR+evldl5mhlvuI0J68W2mI9FP4/s36oM1FYLQ=;
        b=BTPiOLUVy65QFL8yWzTceJnkFxDkzAv1xQX2P6pU2f0X61LWMfG+/Q9Pj2sPvgTS0u
         RSOl5cYZXl/n0Vn8mLg6oYEZtOblBTGgiaaw5xZWjQ+8KeHZWNDFMRAl6mjOEWpgi9kd
         ettN29mNJC0n6cRMrCB8pfcVsQegjArZ+kZqE/y7y1HBlrhPcRwrqb6bBJEDjdb+GDvE
         qlGllcAkVd8l6/eR5HPBY7C7dEFMMDdkiSeYUkQVfXvdWmX+KEG1+Wv8Qehdp9SOxGbQ
         Uhv565el2QI4i+iYtNppwZSA0FGZ4cHon6gJMzw7QMJ0LNM8eaCUcE5RrodMzwXvhccv
         2lsA==
X-Forwarded-Encrypted: i=1; AJvYcCVVRdyAREt3W9KFrOzw7+Fd5ZqKE29JNn536QN166AHKZYTjrWAKilCyzJhcvTZyuQRntRVnOF/e+KJyuGVQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx29NdpscASyNSP0PhvPgc78cuCPNtE3Hzcr1zaHoRZcPMqFlBd
	5tqYcTt7N8wchGxYMNHBEsKwUx3vYRI1FrNfqzRejSmWe0ucolgJMzKRnA==
X-Gm-Gg: ASbGncvEj2rEQ7O+6dQR4S4d5jup8DF5UcFl+OLtWkfjAS70ph6cI3NeCdsctSuH5M5
	5JbPn7cxOwZSX+mgXalkeVUM0CHlcEGqy++oAsESUGCKh+yRuw351B+vGJq+Wjo5HUf2bCb5lfC
	qxLmCxcvBek/TnB74bKaeJ61Sq5ZBA6p6poNVpM3oo3d/7f+mXvu/EW8taza8DP5KciQ7yPzsm8
	H7trqA7U+ztUkPQOY2Q9jAgQJBSUIxhRzb/pvy3Mjwh9qUYC8qUEn0f0SndUgu7aO+y8456SBDu
	KnqGmMCbvg1akPc=
X-Google-Smtp-Source: AGHT+IF3zZoqfKWUfFNv+FPNQ0UuIwZSkcWXCgHzMPO8Q84I63xMG6/s+7OLxm4EjnPNFrOg1ROUQQ==
X-Received: by 2002:a17:903:40cc:b0:215:58be:3349 with SMTP id d9443c01a7336-2218c41f67dmr48108495ad.14.1740039219629;
        Thu, 20 Feb 2025 00:13:39 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349634sm114661275ad.31.2025.02.20.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:13:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id C04B84208FB6; Thu, 20 Feb 2025 15:13:35 +0700 (WIB)
Date: Thu, 20 Feb 2025 15:13:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 5/9] net: add devmem TCP TX documentation
Message-ID: <Z7bkL7uuy8prxfTe@archie.me>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3ck8zPX3Nllt0fQ"
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-6-almasrymina@google.com>


--j3ck8zPX3Nllt0fQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 02:09:10AM +0000, Mina Almasry wrote:
> +The user application must use MSG_ZEROCOPY flag when sending devmem TCP.=
 Devmem
> +cannot be copied by the kernel, so the semantics of the devmem TX are si=
milar
> +to the semantics of MSG_ZEROCOPY.
> +
> +	setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +
> +It is also recommended that the user binds the TX socket to the same int=
erface
> +the dma-buf has been bound to via SO_BINDTODEVICE.
> +
> +	setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifnam=
e) + 1);
> +

Wrap both setsockopts above in literal code-block (just like other snippets
for consistency).

> +The user should create a msghdr where,
> +
> +iov_base is set to the offset into the dmabuf to start sending from.
> +iov_len is set to the number of bytes to be sent from the dmabuf.

Should above be bullet list?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--j3ck8zPX3Nllt0fQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ7bkKQAKCRD2uYlJVVFO
o2s0AQCqEcmu39fAQOLMTwOYkn6NbqUyjT/e6q34LK5lpFeB7gEAw4iw+0dFGzFm
S+/rpVCO8Pfw8Mt4Xg/RDLmSlwuOhgs=
=QlMN
-----END PGP SIGNATURE-----

--j3ck8zPX3Nllt0fQ--
