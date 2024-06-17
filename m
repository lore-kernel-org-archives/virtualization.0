Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770115EFC9
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589168; cv=none; b=CRsSqVEF/NyaHmkBfSwnYTkyUxuyycZ3KdMBn7SK3Jk7JCV1luVYT26ryq9ju3ctUst8jZoktFTH0DFjakHNPhgZarevAM9zHQRX8aRCMRk3hKubetqu6FsaHOy+YmgLUGQKNkEb7ELOnj9G8TknXdHrALZoBWIvjlnaCJKqhdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589168; c=relaxed/simple;
	bh=sTJ/iuTrsEdSBS5qgmnl6h5mYl1g8hs6XygUrJRR7A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWKNW9B7pnOTWutadoajuOWod9zGkqH+3XOq1V6EpWIpm+62cM+pvC3JGVDRgKk1ppfidBpNQokimXmirtnp5TVrN7Dyovgu1WEjy4wD2u8QjpnWt7K4SCD/fx0VI+vpDxlqekUBd9Kb2Yi5+G3cST1wLhx4AghqG9tmOd6YAr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG7hTXmV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG7hTXmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718589165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTJ/iuTrsEdSBS5qgmnl6h5mYl1g8hs6XygUrJRR7A0=;
	b=JG7hTXmV3s0xf+D/2sfXCpw3XmY6Ugp/wcgpzfeEotPn0NzFkoo5+X5Q9qnSrCHTrQTlHY
	9XgESgIbzcTR+OGs5Oy4g018xq4AfoYcC629pzSv/YXKBjYHX3MFdvSkFesbuEhMPY0Ee3
	Unqq1elvb0uk/AVaTQaOq/MDtEd+nPU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-087T4DDcMxChGFTbrPudeg-1; Sun, 16 Jun 2024 21:52:44 -0400
X-MC-Unique: 087T4DDcMxChGFTbrPudeg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c2d89be34cso4251571a91.2
        for <virtualization@lists.linux.dev>; Sun, 16 Jun 2024 18:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718589163; x=1719193963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTJ/iuTrsEdSBS5qgmnl6h5mYl1g8hs6XygUrJRR7A0=;
        b=vm7kC23kDbyPNPHGUPJMYHcEW+8o7fsnCqtCDqkLlGVEs+H2Bi7wqQQvEetvSW3YWp
         tREdxMpgDL+5SlUow9+MbvSCruRntbjd9FMpEHL9fNw5GcLVeFEW7+6mQBE6OPB7ogCI
         ra9w4G76v3KkFsSqlIMeM2ELSoNawF4x1wugbYfA9dHS0VrOuHTHAeOlmxZTCY59oFQb
         G1ARdzzaaEjpazVMXQ2nherv8xMnmvB7IvIp13rwuzHhH+iory50H3mYGx6JKwV/bfXy
         zq7OsDNbGNVhb0iM/z4FPsprRSh8NUKtObaWKhsQ95N3oZfMTecZcEAkYD9Tn+lKnM1W
         vTbg==
X-Forwarded-Encrypted: i=1; AJvYcCX21fuMyVR2elnyMrvSKHP57Tp5xqB9adzqWjUzfJbvRKGIVUH7p0rHUr3JBG9a1svNJFUX95X95PAuh9wZWMc7lWRZU8Vd+RTcSfs79PI=
X-Gm-Message-State: AOJu0YzVKy/thwARUt6OPycRfUrA25T4e80Y994xg+erBRP7DDnUGibm
	W0jwWt84bqzdKa7ugt0f7aLFltkcF5MtnkfK/CNfHZbczOfiFhloEScg/9kcU2YhbclFLLTV83D
	7edCsbLw9AG7NaZiG6exHaCGYY87xxuD+YYaTlh8KTSgro6k88kSijw7qdb0utBvmePVE+IYD4L
	rTxExJ2JvHhS6MrCbzyS6smcRx1DAWOZWjUTRX4K4=
X-Received: by 2002:a17:90b:1213:b0:2c4:a974:bc79 with SMTP id 98e67ed59e1d1-2c4dba4cf41mr9455805a91.36.1718589163038;
        Sun, 16 Jun 2024 18:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+QQNT5453eJc8Q6wrY2MwQONVCUdTNKrjoTG9l0wExtAxoW4PcawA6CbvZ6/VnsBDwc00gN9K/+tJsC+cH0k=
X-Received: by 2002:a17:90b:1213:b0:2c4:a974:bc79 with SMTP id
 98e67ed59e1d1-2c4dba4cf41mr9455799a91.36.1718589162769; Sun, 16 Jun 2024
 18:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240516-md-vringh-v1-1-31bf37779a5a@quicinc.com>
In-Reply-To: <20240516-md-vringh-v1-1-31bf37779a5a@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:52:31 +0800
Message-ID: <CACGkMEvdL4ieDDbpwy+MGBbHjia5UbbJQfUidh2btG9vPcvWpg@mail.gmail.com>
Subject: Re: [PATCH] vringh: add MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 9:57=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> Fix the allmodconfig 'make w=3D1' issue:
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>

