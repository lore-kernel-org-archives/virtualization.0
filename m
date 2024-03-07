Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8007484
	for <virtualization@lists.linux.dev>; Thu,  7 Mar 2024 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709789672; cv=none; b=FDrru4+oyahpKd8PLNipzHfKMhOgtvGCXvasu4sFN8n05yYTdtCvbXBD8cCuNc4n/ASo3mBKgu7fYpjpTtVYjCLpAU6/bni9nI3FJTYNFVTFmj1hmxOo/T6ZhCVhGnadSdy/BpgSicvCWbgETHnZYxqL9GTEUap4XqMo2+b/M28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709789672; c=relaxed/simple;
	bh=1lFof5+cUchyADJ+6QdukNwbamu6oDIeP0rGwlIGyEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDrKWMe5FKmS75gaUpVcJSQqah54N1kS6NCCGMCKq7KuOq5VdF+oUhnYaAIvuvdLkmE1af2LNQkbhHopjTqLJ6cw6Z/2iWqKdC4PDtIreyHr5TuhLJgFQtdOPZuht9+Uoqek0u2FrjpwbqtnZGNeGY6ahxBx6bzxqdZBZH4QAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vcf/bPgu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vcf/bPgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709789669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCSgLGRp0G+aVLq6Fl8Kwv0NnjeDGnWAJ4DrEBv/aVs=;
	b=Vcf/bPguEqPUFvBldM9bm+uuDQSnyCRGdkKH/QpqY+WqRF6AuImKbd88Q90uvFNI5ZOeei
	qXYlSQHN3GKKKeKKxdwtrpSdQzNoyn4V0LD5pHVMjdU+wonE9ulEJRI4LS/RJV1VqwYsR1
	9ShC5B0ycw0EUveO+XSpiWcbW/OKuME=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-KLDlZwnkNfCrv2KDj0I2MQ-1; Thu, 07 Mar 2024 00:34:27 -0500
X-MC-Unique: KLDlZwnkNfCrv2KDj0I2MQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c22a44deaeso28755b6e.2
        for <virtualization@lists.linux.dev>; Wed, 06 Mar 2024 21:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709789667; x=1710394467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCSgLGRp0G+aVLq6Fl8Kwv0NnjeDGnWAJ4DrEBv/aVs=;
        b=v5O5gWqQf/BJjopOG0XyOvuqc501qiXBJTfQYvwdTI9qRxK9SMw16NXFlLV0RNg+UP
         r7Lojx/zC43bf7amCyz6nng1hunjHfe5KCROWya1vYaJHPJ9vske+C+R2sznP896fv9i
         tdmRiWwjiryirhwoGDvvnKrzUAfmffZKO8jQli033lv3Lh1T5nFq56baW/Cl12C6S0Pk
         aq4Q+ibk1VDNkNLNeHUQFWsoD+8tqtqmjkNBNd9hImxFwEyT94xOB3+Nfa+D57tyID/o
         R/I0tkRuGprfysKB3/bpkGX5uoCKwe3ZRsDL05hwUTjztubeFvqrb2TTF46vJrrp1ltr
         0smw==
X-Forwarded-Encrypted: i=1; AJvYcCVocJNFYLEJ7xvqs+s6qgd0IUjohXC/18L96jNNMCq3qwE50tSyN83GVE/X4Wiqxns0BcKOFyhAFbreJ40ZakFFtKtODruFAKLhD/kAlVc=
X-Gm-Message-State: AOJu0YyCHzOQTVyJGIARBS8rgxKyLSOG2l8IyyiM8WcBYA+i0uYxu0hm
	GroMRr7j0frWJaOz9ZLbTYogUGK7QM+UXQMdfJyNGZ8UFPuYkzUTlqVKTOiIHs4rCmghKaScktd
	F0yxukKjQnc6q/krbfsRIIj4e7n69oTGRnf+MW6RjWiIIUy1pGXM0IwPbOwmo+9YXj/uWIYfc3W
	vz8Xoyxh3DcKaP/zFmEOTLIPo1rBsvaRYOE80snXo=
X-Received: by 2002:a05:6808:198b:b0:3c1:f3ce:5e54 with SMTP id bj11-20020a056808198b00b003c1f3ce5e54mr8626950oib.23.1709789667009;
        Wed, 06 Mar 2024 21:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpSPs8F2aOBgJ6x7TZwcjVxkEz89Sy3npdJm7uWt5xNLOg99EEXM7AUOzp8894fwfLI9nKovKuYNRJGQMW7gY=
X-Received: by 2002:a05:6808:198b:b0:3c1:f3ce:5e54 with SMTP id
 bj11-20020a056808198b00b003c1f3ce5e54mr8626938oib.23.1709789666760; Wed, 06
 Mar 2024 21:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240227144519.555554-1-lingshan.zhu@intel.com>
In-Reply-To: <20240227144519.555554-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Mar 2024 13:34:15 +0800
Message-ID: <CACGkMEsBaC8HDsfbOWG9ix9Ho3ZVYkSPHaW26PiucJfOwXpYDg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: apply maintainer role of Intel vDPA driver
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:45=E2=80=AFPM Zhu Lingshan <lingshan.zhu@intel.co=
m> wrote:
>
> This commit applies maintainer role of Intel vDPA
> driver for myself.
>
> I am the author of this driver and have been contributing to
> it for long time, I would like to help this solution evolve
> in future.
>
> This driver is still under virito maintenance.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ecaaec6a6bf..128ec843eb19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10365,8 +10365,10 @@ F:     include/net/nl802154.h
>  F:     net/ieee802154/
>  F:     net/mac802154/
>
> -IFCVF VIRTIO DATA PATH ACCELERATOR
> -R:     Zhu Lingshan <lingshan.zhu@intel.com>
> +Intel VIRTIO DATA PATH ACCELERATOR
> +M:     Zhu Lingshan <lingshan.zhu@intel.com>
> +L:     virtualization@lists.linux.dev
> +S:     Supported
>  F:     drivers/vdpa/ifcvf/
>
>  IFE PROTOCOL
> --
> 2.39.3
>

