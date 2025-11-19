Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7BB23C4F3
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517211; cv=none; b=l7zHgOLYspnAJYpfsPf5A28MPnGZl1XT5BRQnpgKcELWDB8+hIbhAZkjr02AAx6GxdiWCAoHt4y9HReMBaMeJlObMZeWVJNLE+lDcUp1iRHWW+WQGp744jRrIZdMIff6rAGX7Hkw9YiozFRrVI4r+qsLh9Qswd3GYmF9n/lLnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517211; c=relaxed/simple;
	bh=KyrZzK9mqPm9s39/r9lrWoYLT4pjxbJQMQSDqyYyq8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLIrB+A40axuD/NGQ3W8IzY8oAHG8skLJEiy1B7tbOkI8cmXax1POX3+R8JOVZ9eF2MYiERfInfqfXpFzx1Kq1OqBqvlNQ7R3ZZJQ4J7YWAgVV8YbjNVomnDI90AFFA3nRB2oVbKstzLV4ovE/98S/hJqPf0nmEg7rbH//0whZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHfBhFGU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHfBhFGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763517207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyrZzK9mqPm9s39/r9lrWoYLT4pjxbJQMQSDqyYyq8Q=;
	b=NHfBhFGUNvA0R/JeeSMowgOUJvb1NF1iVTcG49Da/cYvayxI3H6lctjfIbFPaQ1dgix2RO
	jZ6lLmkP1B3pbDzfkCOpUXL0CYEeIOT8UyvlaBbtrcvyVaX1qZ7O0KWCTCcv2rroi0wypx
	3XLGsKZKnlw2i9FfHSwYxOOyTA7gUmw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-3ESQXUQmO4K_SfDxxVJ_rw-1; Tue, 18 Nov 2025 20:53:25 -0500
X-MC-Unique: 3ESQXUQmO4K_SfDxxVJ_rw-1
X-Mimecast-MFC-AGG-ID: 3ESQXUQmO4K_SfDxxVJ_rw_1763517204
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343bf6ded5cso15359710a91.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 17:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763517204; x=1764122004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KyrZzK9mqPm9s39/r9lrWoYLT4pjxbJQMQSDqyYyq8Q=;
        b=uKte7X+RCCSWo1Vb7k/6kmZUmjjHZLC1F9ifVh8RcRdXfvl0H0pl2awBeYQzpchdD3
         syS5y8Uo8pIvpmdy4IyM3Vo+pD/0EbE55uK5QqYnv0syRpyO2FFmAkvM9Jn0rmEbjsbI
         eiUoh9mWlp6tHylNJFtKEX6bmQBhda0+h9WxJme5zq16cz4Aax+DN1/2gBnEd9kp4K7/
         EfePAhVPGlOnadbMnIRyIHA8SlNKJdxMFC8jiZy6qz2jrLSP8pRJTJoJ66MpGQ++if8a
         jHbUOe+kAu903nmJeIkEDGKqRgnna+Zde2Et1NACUQsDM2SH8I7+HIdbm5uDWw4P9yeX
         TxpA==
X-Forwarded-Encrypted: i=1; AJvYcCX3auaSyWS56UIly3PqH8+hCX//v95fU1Y2NEoN0bdg8gHr2BFExdol8VU4ExyRo9AXyqf+jtrFgB73paNE7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA83Awxu4ZAH9GiFoHEb0CQUeskHlCpfCT/KS90742cO50H01+
	GAp0CppRRkgFCjMBeEAvm6tuNrTdCYPHVSu/0f4fBwdONjhh3JYQdVkQ1ztIKYo/tjTx2po6Hx6
	b2By90b3p6dbGJbkQV68EcCJ6JiHA5z6Zhytu81kn68PBb6hG9w1hpq3ZtD0AK3lo7ecuE9k4YV
	0hf6D2NV5u1eDCHn6DL/fEwNgUcHIgmd9GRMF81wpSMxI=
X-Gm-Gg: ASbGncuqZQb2+68ZV/rjJ1LPPgOYMmQX/CUDWnQA0lsEH+BXDOnhc46wEYh4b3AG0NT
	GcQqitcU3HWbxN78+S2HVdJxCRdn7RTQZBWOBPWDGheSDdc827DM4ERmxqhJj9qUrU3cFS0NPlX
	k5USYf3uVFfY12hDOY1YQ5/U9MfQe0UfL5MTgMh5+1Du9hzFvsIaYB7dibWmbImxM=
X-Received: by 2002:a17:90a:c2c5:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-343f9ed96e7mr18500453a91.13.1763517203958;
        Tue, 18 Nov 2025 17:53:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK0BojLkbLsinUEMLK9poTO5T3VKUI0LJ7vBrGV4ZQeudjfClMdb+kGPfFRQFUzDtww/LkSD4FupuTf50Ci1E=
X-Received: by 2002:a17:90a:c2c5:b0:32e:a5ae:d00 with SMTP id
 98e67ed59e1d1-343f9ed96e7mr18500412a91.13.1763517203120; Tue, 18 Nov 2025
 17:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1763278093.git.mst@redhat.com> <67ae57499e779aef2c5bd7ee354af5d4af39bf60.1763278093.git.mst@redhat.com>
In-Reply-To: <67ae57499e779aef2c5bd7ee354af5d4af39bf60.1763278093.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 09:53:11 +0800
X-Gm-Features: AWmQ_blKYAEU3q3XwJg467m-DKxSN_o3KNaIqr46lnM6uOA9mljHAoG_O8bYpVw
Message-ID: <CACGkMEvgQmUNVOzceNscLJiBxUiJDwJeST4Fe4Up7yBgbpxu4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] virtio: clean up features qword/dword terms
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: anBuV7XMpZiMAWoZ7p2MpYvYjfdpd0YRI3iByxRWpME_1763517204
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 3:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> virtio pci uses word to mean "16 bits". mmio uses it to mean
> "32 bits".
>
> To avoid confusion, let's avoid the term in core virtio
> altogether. Just say U64 to mean "64 bit".
>
> Fixes: e7d4c1c5a546 ("virtio: introduce extended features")
> Cc: "Paolo Abeni" <pabeni@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@=
redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

