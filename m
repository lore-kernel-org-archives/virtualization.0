Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F76B13CA81
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714573; cv=none; b=b+QMUaUONCXo3NBWeP/bnHzUU6jhAE2GQvIdjK0kqahueKLpzw59zTWG3pk7zmhGMLjhlDDH2q4eAf7WrBeMDWG6Rk4YSU1upa+PQz/U6h547R2oYIyyBL69gIaRtyEJ30825QN4gEibNuNSCX6EBQ8IEwbUiOSUhudTG28XRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714573; c=relaxed/simple;
	bh=xY4Nr0ZV/G5xCs74taELZsVvfH8f1KeA8L+JBKvR6NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAb8Uh1Frb0dTLTZrnptOxgNWlKfjDXX4sSXka/eDN7Oc/OFyJBef5BclgOmZAbxxLX8okAoOk6NNNdcWrIK6mGL6E6GgZm7CorW9Q8WJzKAFp1GSJRNqyMnP7xg2B/HQvSYuaYfMwpkSNSeLJHpCzHQ+YBbep4x/ortwYm1Ua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5faljS2; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5faljS2"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8D26400B5
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 06:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qzFrGDSHoI9C for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 06:02:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DF71240042
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF71240042
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y5faljS2
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DF71240042
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 06:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721714569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY4Nr0ZV/G5xCs74taELZsVvfH8f1KeA8L+JBKvR6NY=;
	b=Y5faljS2bndwHZpNXA/lhQBQ1chKDx8labmkckx42zRw6Y1ghk2E2HIeL+rWb3WPD7Fnzr
	NVPMdBstdTCOHraNla2Nrm2mO9KlRY9iKla56cgZW+ZNcEZX3H7LnHX2AJEuqBMhfuik+G
	QC0zRIpGUDhvxt0WHJhm/Z5LepST2Z0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-owOIOu3ePNKApuhaqkHnug-1; Tue, 23 Jul 2024 02:02:48 -0400
X-MC-Unique: owOIOu3ePNKApuhaqkHnug-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb656e4d97so5826633a91.2
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 23:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714567; x=1722319367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY4Nr0ZV/G5xCs74taELZsVvfH8f1KeA8L+JBKvR6NY=;
        b=m8lKxQ3n9kg0rHmkLfhgfnbuempixwsK/YWw4gC6QksO3kWwKeICfnX4WKKyb80/QQ
         3xwNbeU5nbT1NclayHfYMOcY3U1eNPPuEOVsDZixCCWN3LfzcsxCFrrZh6dUTHWSkSQq
         Tim+hVsoU8XtFRiJySY8Mv2si7YvPDfhENWxnW2VpKiqJ2CwqscFyGiV/5NDR3OXcXMc
         fIAfsXkKdk2DMoobiaRj82MTpkvzjxJSG5CRiLck0gbyaxocumjRgg08qKA/KiaJUmRJ
         7dowRFoa2rwut26O6AnwxBiAdFRnzfWZAE1ebIN+ijPWOHxmaK6oOwxSUxSfBPIafcuG
         N3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQS2ePmW363KmIxFAB+x35r9iQmCAfzJy3ppJT33iLHN2wbfuY2gUTuiYs1Gbxn3M7JlB+ZG8gIc7tNxl+wJnTc3tjIgUTknxrtxtdoIrWrMfy4vfJXyT5Bw==
X-Gm-Message-State: AOJu0YwoEwUUCeK0S/toRh++2UOgpA+abICgbbqYovFoLLouqN0xguOK
	O3wgd4TvuH/orGQ6WKND1thMomTxkzmuE5p3rl6Gs9+qCeqNMR7Qg/InrWcnpbWi2qUejhgdYvS
	fSyIRDN9x41bgZ/2zOZ/wD7eNqf+AFLkce2ibGOIc3lq8LARfblWSvf7atvc5vxl7WegdFaEeZc
	OR7VpRwCm/y+SGtAyFXePMEDeXOECZ9hCNm4iCDu2PpJMA0e1PKWGWO8Kj/lZbzilW
X-Received: by 2002:a17:90a:784d:b0:2c8:6308:ad78 with SMTP id 98e67ed59e1d1-2cd274ade5emr7793405a91.34.1721714566590;
        Mon, 22 Jul 2024 23:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdUHj4K5SDJj0vjuTuGZn7pj0Rf4szKIkdJfWXa0Y2D9tnc4NJZo92YMqIKXjSmlcTOB369VIJKPiI+kROhlA=
X-Received: by 2002:a17:90a:784d:b0:2c8:6308:ad78 with SMTP id
 98e67ed59e1d1-2cd274ade5emr7793385a91.34.1721714566181; Mon, 22 Jul 2024
 23:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-4-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 14:02:33 +0800
Message-ID: <CACGkMEshJ+nKvoiY+P0Xg_A09D_jsEU690y08TY7jkpMLoWeyg@mail.gmail.com>
Subject: Re: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
>
> Tested in ConnectX-6 Dx device
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

