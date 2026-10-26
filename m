Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016707;
	b=0hoAdBugWC1vV6Z2vNomwy/1Gbbgjyl7nKnvI89FeKPDLuIKUZJGrapUb7cwJAZGUkyU
	 OnRoak04U4gimYh20iIw2XYmQkdG3/Xi+vlkuu27miMoEPvZxuCL41OBvDo73AlsIR0x9
	 ZAOyLJl0KbdEeP/DoDnWLdre2khWZ/oL+ck1r0/+o/gbOs92EsXtexYkHb43n8CwGu7OU
	 FzxBxsAXxbVMjkx9On8VyG1B5VyLRt9xxvyysVHiHoNsUF+wcwmTzvnmj0DCvk428jdt4
	 Y1VNMFav4POP1kdfI8AlYQsn5/sS06wboTOohfWTkFufX87DHqp6+8xXne1IzEMsOMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016707;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tOGflhYpi6VagQDoSppfiQzQePwAF0Se7756a/8/0Vk=;
	b=jjZhp8n3qSkJ3dEheINrFXO7rlyT94C0Zmz/4RM5sLF+Ms7DlZt4ybJIbrTd8JuZanKQ
	 zX7weNVaXyVAeDyJDxRdjXKHGIaPsZpgbhra8KX2J7Ucej6vbKbGTdP4gnLleRGlWm+YC
	 yFVH17UBV3qgz6Gnhw2TVb2sY+kG8ZqjmrsSpmhQG2R3RGc2fr9rVTxteSIVoXbLlDPYv
	 Dl+VcQIzXeiaDoZfdsC4eynMmxctr0RFF08lqU/SWWWnVM9UlBZmMAWicno67EcCpqZgC
	 7X7PYccmpAJIO9X9sExZf1IzmuENSt++yjrEv3Ow9QZYvWIV0cNc6EZ+aJggrM23LUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3wPN347;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED28606A31E
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3wPN347
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E161F01828;
	Mon, 26 Oct 2026 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016707;
	bh=tOGflhYpi6VagQDoSppfiQzQePwAF0Se7756a/8/0Vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F3wPN347QtZb8E4AkdrV6pYtiZJWlgmt1Hb89T/4BmdgA0cJ1UGAViA8+PePKOl+e
	 6XWRDKLIyc4r/2TVtYEbRgxdVDh8Q4a217kODa5Iwclce/qDTRHueME5ZaGgPVyS5I
	 d8Z0jZYXHRDVRlF8ZIG9292rvsc+QASJAd3pZk09+jdqMS2qo5pWt/ntBGQMZzzi3U
	 c8EmhI+/8G8PigkMhFDPp58eQ4pPx63DKev10kUt4ak3qlnEtq0gmrJt52gJA8ljFe
	 E/yT4EKCuZsV0+oH4+RNrZB6HxFZqLaNXOi0UfPBkPHfm+mYbkczpS89h2S1s99yGT
	 HSBwIsFYOz67g==
Message-ID: <sashiko-outbox-185180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/23] drm/msm/dcp: Add DCP encoder
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-14-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-14-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:11:46 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Create the DRM encoder required to connect a DCP CRTC to its
> firmware-backed output bridge. The encoder must fit the existing MSM
> DRM object model while remaining independent of bridge discovery and
> KMS registration.
>=20
> Implement the DCP encoder wrapper, allocation, and DRM object
> initialization.
>=20
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D14

