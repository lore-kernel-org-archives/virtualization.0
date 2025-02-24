Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F119C55E
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362275; cv=none; b=PLjcAtwitBFcVgeEHvvZJasBcAnyptZ2rrje6Xq/n41ZiML/koKLgq1XSij35TcqxO4+jthXYNIP9E9UA53S0NeIv+kFYtxWVZxZwmLm3AMU2HAtABdg3REuhrWFsMLQSd2+EgQUnH/LE0FSRHJXRXX+SrJ+kCpg2BJIuEjbaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362275; c=relaxed/simple;
	bh=vaLbHjmidwioWvktfwCGhYibt4VsmiTOJwXQD5tcJAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHTuLprQZr65X5GjpUniC7cmMSe8xw9nQ2MV2AOf7yzxZ/eTu0d9QWVGJSHqrG8pf0lL2ZluddC+ZZ3yBF8RumZrRsH5/P+LpH72kMvSYGKPCyDUwnsNd90v7LXOi15p2Bo8VOZ6P4fmXwnBTATT9pp5uD96poxHIM9kMdF0bQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsqrljAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsqrljAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaLbHjmidwioWvktfwCGhYibt4VsmiTOJwXQD5tcJAE=;
	b=XsqrljAtLk2wvNJoaoOVcOz/Q5Jns3bIdPtkGFNZvhU64iSmK3gU9Zg9dC+uL0hPtFy0qX
	HRWoxdLzzsm3xmgrFMXcxVUd5o4My9azjI1gK1OTAbS5k8ld6Z3EoM16M88AyjvcBAUqFl
	JEAt5C5bnVce6RlYXWfDgi8urh6YcHI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-zje38Au4PXStwsVtcrXHcQ-1; Sun, 23 Feb 2025 20:57:51 -0500
X-MC-Unique: zje38Au4PXStwsVtcrXHcQ-1
X-Mimecast-MFC-AGG-ID: zje38Au4PXStwsVtcrXHcQ_1740362270
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc17c3eeb5so8214829a91.1
        for <virtualization@lists.linux.dev>; Sun, 23 Feb 2025 17:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362270; x=1740967070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaLbHjmidwioWvktfwCGhYibt4VsmiTOJwXQD5tcJAE=;
        b=N1uDskFacEMlmFx+fdlAHsIxRpegetiBeVjwffLYkeG593DhXw23LTcTbQcVRMGvQJ
         sYv8JgirAbnkyWfyKbZuiO9MZSKeo2D5UG4OLghqqTMi8NgY1pXFxotLKkVaBLw+zdLN
         97ls5av+agzpFCUZyAXmuS9ZgEfI9JfQ5h+Fub5/NNV5xg/POA862GsQzEsEPXsvXNUU
         ZzKikKr6uFOJre9vw06QylrjLBEB8UU2hvrX0BNXKqi1gpgIPxPQvP0v6hSMyIkamYYz
         S5r+HdjApT8c0Nfr9rwLZBADRp9sBgIlfPPjQq4vq/4XY3xcX+I+qUChShB6dHzCtPGx
         t3iw==
X-Forwarded-Encrypted: i=1; AJvYcCWt5aBLfq1EcISoWh1Hf1rAZimwcsE3TmAEmVRoVrKLVwdxbIW+epzFSY9sMneKIrvdozq7mEwKswx1Jcq/uA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbW7OgaBZn5LFlcHc4Y1mOdw3PWbZ+J+Vmryk9Z6gHSDsIKYgn
	FPKkB8TbjIwfcwDjKlKHLIR12LRIow+Uo6iG4BuQlQt/nucrr/v44NkAJhgrOLqWoABCxjsASyu
	Pd4pNvnDCjeDC3apK+Izu2XZ6WMIUkwergOQNUszlxsd223JxH7ntq+xJow7DuI64pxq48reTai
	YSU1OvJ7oMz8M19gBVTeQlDDdEK5wcoA8GeM9u8Z4=
X-Gm-Gg: ASbGncvCmODh300Y6jMI3mgBERmoce9xxZu3+n151wMxQ+8fkvq5e4ZSG9WmVaT6beW
	uofjY5cqtE5NNk+WR6U9ew7egOmJdCh2gWNezvNE1OLNKUBADYL899TiFCWJ7AgGtkLtscp+Zpg
	==
X-Received: by 2002:a17:90b:4c10:b0:2ee:b4bf:2d06 with SMTP id 98e67ed59e1d1-2fce86d0e70mr17216794a91.19.1740362270357;
        Sun, 23 Feb 2025 17:57:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA6Evp1R/AVQM43Rg9j9ev6km34s4eDr/KxTbJj7NcHwjPHvLjbL/J1ySnYtiKgEU50Z9QwUmLV9TIPv82Ck4=
X-Received: by 2002:a17:90b:4c10:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-2fce86d0e70mr17216773a91.19.1740362270040; Sun, 23 Feb 2025
 17:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-2-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:57:38 +0800
X-Gm-Features: AWEUYZkwPGV2vcMfr-OnyHZZ9WyqXX4DsYi3NmTeAiBb2tUM_BD0LSWZEVb2-QY
Message-ID: <CACGkMEurYAGHx1FF5YgS=T-4CDY8dn4B2sQJB_ojRxDdiqB2YQ@mail.gmail.com>
Subject: Re: [RFC v2 1/5] vduse: add virtio_fs to allowed dev id
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XMh0QcUqMY6AIE9HabES7iLu5Q8VZSPGfjn0OLSvXYc_1740362270
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 1:06=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> A VDUSE device that implements virtiofs device works fine just by
> adding the device id to the whitelist.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---

Let's separate this from this series.

Thanks

