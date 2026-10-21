Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577477;
	b=uGjlYkgJFcdfxbUn2QpLxZufrm+Yh0NFv/UkXoIn2RZpvKXBMpPoS9Feox5k+ieCQv0O
	 LmdbzzOBCzA+wQs2HBT6D3L/H13giLZqIC4hSDnk7/Rsq6BpEK7bGPLd3DlOXsG5rpoSv
	 ojUxk/m2Bt7xiyTR82ipNeFyuwJculRLM5g8P0pG4mQ9E6mFCuPoXJJWQofNKqspDbS+2
	 uMi5VHs5MrkAmCgHX3Bk9GRcO/BJJ5niTtQnEbfGgNQCHWESEU3yPwWX5aHjQTxkDzAcK
	 vNWNVIyGSeVlgh8OWY23CGLiuC2bmIXOtm6Rq1ef9CYiYjke9DAE4/qbpkLfAVVKR+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577477;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
	b=qZgT6Z4OdEiM63AMcIKNDMTcVXbodwSG9bP474uoRJHZRebYCIYMNpQUGApC9FuplxCn
	 SXeTgxXGEDK6TJjEebSQP/bAYjLw789dnxAVZy1Vl25rB9gbUaJNOo6c4i9YV0qD0QOz7
	 QE9C54QLdVrNn/aBBqEqTJp0FZHfx8ZqElhdBDSDHE/+aVfGp91SjxXvi5tvI5fWE3K+4
	 gTdfOXqouBbuDsUX85PV9dC9KtbSa2mjYA6DC7DCdSubBdtjtA7OyRDObCx8Dd+aX39m9
	 SrO5JIE8ZK4zOID5TiCXRt1Fu4DYQqUnQ6qnEJYBypFAXriv3oF/0VySCQKEesPGMNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jLOF5yQk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F677606A327
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 10:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F677606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jLOF5yQk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792577476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
	b=jLOF5yQkOrgbomRKLaB2zLa83kZ3WJ7l5YxBAQ1IRfj+vTOn8uGh9PIA9fJ0COJqahi/XX
	b5qJ7rxYuBUcwcQPoxJnjyme+JbMJ3WomFGMsUoBr5iqGHI4/HFyDXXcyXYrPOVnusBqDK
	sEC89FNlO5tFvxLCRUv4dBj+33HSEa8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-CSPJupwKNeucMDxTy5PBUQ-1; Wed, 21 Oct 2026 06:11:12 -0400
X-MC-Unique: CSPJupwKNeucMDxTy5PBUQ-1
X-Mimecast-MFC-AGG-ID: CSPJupwKNeucMDxTy5PBUQ_1792577472
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df5b058ddso395002f8f.0
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 03:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577471; x=1793182271;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
        b=N5uN2xNHSxe4E1ImbdTyh8Pi1OPvVfIcfUR3MEf0F/7lTxBoakRQKfLqYxyw5zotQS
         FcTdKBSUIR55wYonyYk074sRX/untZAwkfHR3/d8pxpWQb0sPg6jEAM2pAwQo9VVozON
         G5fVAvswOTaysWcI9ScmbloSqAQLf3DBkAkYK2tieVhPYCv7PFXx70I0+7UKurpY89Kj
         Vdq6aXvX5DIz0LgOWn8VD4Nyx4e9TBR9vdTd3vB5OPGSdp9JMZPmts1hV3O6B5eikffl
         nQWSGd1qUFSrgNEJPaPSHVudlh9eUbsq07dcqu2YRyenM8/OR4/JlKzFZQB9apmzsNJ4
         g9Wg==
X-Forwarded-Encrypted: i=1; AKwUvByh+Zhjh+sphHd5gVnwc/3/dabt/5g2iLFOngEXdA4rJs1/zvoQh376CQFRhtMsBZzc57fSDeeL+JrlENp0VA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKV2oxE9XYsQrE5JKk0Hucl0CjQTRo3D41SXujZXfsTGzSKeoxH
	j/QAsv8P/G8RikeemkOQNAT6RrnGJ7Ltxx7QOrK/MNueGNkM4suxJIRiqfb1pUE6jKNVXBHIhPY
	O5NSalLW537YBEoHTDRKWd4/K5xejemNB2TgyYOafyDOHmeUYCZ7GL2P9Q+hVXj9eAJSD
X-Gm-Gg: AYBFou3B3T1MCk7y+FWAUyYKegfq+9L9QMnac6RT7WjZQbqudiIx4Hedzd8ddnC6ra0
	5X6z2Gbd8cn9g4oVsxczPUhtcuF1ZW0sjo/y3jeNMrnCM9YbX29qRYbWyNSWgVPYv8JljVZY3Vd
	Xzj3tWDXTDkxlAy2TuOyWgQt0qSI+N6YRELcxmkKOFPtEmcnR0KSsZDFI9dreW5piTwE19ihNov
	vIfncp49BP7dXdincLicIz9gWJavogFiRr04zb+O4Eu338i537F/NYDuYB+q8a1WiI6xsiHPW9X
	qaLI8gn/fI5RiYad6T/C1W2RiJIwBEvNi/by3MDc773RghGCiXNG8QKA84WAPlubmvM/ag4K/FD
	e0RZPMA==
X-Received: by 2002:a05:600c:34ce:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a1fd8a7d77mr31195105e9.2.1792577470696;
        Wed, 21 Oct 2026 03:11:10 -0700 (PDT)
X-Received: by 2002:a05:600c:34ce:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a1fd8a7d77mr31194065e9.2.1792577469551;
        Wed, 21 Oct 2026 03:11:09 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d699dasm152330945e9.12.2026.10.21.03.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:11:08 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:11:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v4 2/7] vsock: rename the vsock pernet operations
Message-ID: <atiPgleCntfwV4-N@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-2-047527cfccfc@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261020-vsock-guest-ns-v4-2-047527cfccfc@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C768m4oVqtsEYH0Cca1teehPQPXZ1ITBaPcm79VgqcU_1792577472
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Oct 20, 2026 at 06:15:05PM -0700, Bobby Eshleman wrote:
>vsock_sysctl_ops and its two callbacks are named for the sysctl tables
>they register, but the init callback already does more than that: it
>also initialises the per-namespace vsock state through vsock_net_init().
>
>Rename them to vsock_pernet_ops, vsock_pernet_init and
>vsock_pernet_exit, so that later per-namespace work can be placed here
>too.
>
>No functional change.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> net/vmw_vsock/af_vsock.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

