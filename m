Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199421990D9
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992219; cv=none; b=tTFXMICa2dJJLtTBxZX0MTwOk3SpoOsY+ylhhbeGeRRVX7drx2PjiIRtrwBUN5DWymjSZmpqzF/YDKozgbFvQg01DWQWleaKtjbtVj4tIGG6CE//36juuh5nii07sEI36wPnRTAIz+mM+x/54Mlq9NC0P39HuHBQiQAmmuqoYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992219; c=relaxed/simple;
	bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOx9ObmN+oq8e5gjlwtN9rp5O3k11SoLELqTG7YTR77VJ5glNs+0wOc7djs46WLwNYP0eWDr1CnPV+hvk2vIBDi2NDPFcxjZtazVAOJq5kLTBFnXLpgOnr3xYw5FJcTIPPmL3Zu3AsFZ64i5XzH71rvh8Czz9yupdYpx98HMH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frHrTiaf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frHrTiaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750992217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
	b=frHrTiafOM7Ljjd6LT03flhF4GppAu9DzkvKHVIVR8OiVksuqtzTgaELsn0wqJz8q34UZ4
	bLK7woNu4kzlAkOfWrB3d/kpXIqUbfNRpDHUWSCKMejOrWlVtTvZWYVFOC1XHaYe5Wa7TT
	dbVjn3d2uwoEzMxrOqHP8okXJ2StJ9s=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-pE3jOlEVNKWaXw-s_zozzQ-1; Thu, 26 Jun 2025 22:43:33 -0400
X-MC-Unique: pE3jOlEVNKWaXw-s_zozzQ-1
X-Mimecast-MFC-AGG-ID: pE3jOlEVNKWaXw-s_zozzQ_1750992212
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235eefe6a8fso12308665ad.1
        for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 19:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750992212; x=1751597012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
        b=QHv7zXrlCKuBaBmxQqQD6kz4nhCoOoJXgV+EoipNha2yIBE8LpWW+qigyYRxFxvdnR
         ogr4HkJkIRR6hUq2QbVcR2KX+g7RdWSnJDZYdHumzN2jQ/JRJVVnTeiVttdjSuGdICi3
         D+tYgrqb3aYIO3s/m6QCba2W2CkY7shPSoTQNIMgtb9a4znf0iF3Elly9eW5Xd8r1Fbd
         59vHzDPx56kE0iqO1Q4p29e9xN6m3PfOMqvhJLj+hafykvk2UIwU9o/v7/zpK08aDKs+
         DJLlRteC3yepm+kre/MU/w5ZPRBXYEUS972OtY5wKtV1hhUYwrgjs30JEsgughgUm+Dx
         o7bA==
X-Forwarded-Encrypted: i=1; AJvYcCWlLI4L0Uw9KjXfoxapdpdGQNOeIhT9+9ECGw9QiTbe2KxN2JfhACA5Et03pzaRMze1VxKzPh91ApE/lf2Qkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRojqe4Kr2b2c61eQODrGsDUpPLU119V9BDzJgKaZAbDgKUIC1
	/W48t1LfLmBbix64U3kZ1U48rQHqHthyh8jDXwlTmOycZY7PagaWmktErjUimrFFPxWxI1Eoz+9
	IaDj7vv0suPw3oxs+qhHY4f7BRCCRv/K5l9d1xA/zfp1jiQFibAkMW5cESCXBWbi3K5WT5vBPTt
	0djDQkgoLROAKzqClBQ2PgsQbHWC+yLbnJI+yvAqJY8+E=
X-Gm-Gg: ASbGncv3FbNGm1bNrZ/TNDWjGp5DWIG8vDC/XT5AJmIxPDPHrb8rhxh5v31vH8ADeGz
	wrw/7idgQAx5uKA2SD928MOAAcpduaeiAOHaB2Iz/uKuOKiSS69vfJKyufIas8TlpOT2SOfyDO/
	wk
X-Received: by 2002:a17:90a:d64b:b0:312:1dc9:9f67 with SMTP id 98e67ed59e1d1-318c9107a53mr2192668a91.2.1750992212425;
        Thu, 26 Jun 2025 19:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJM16rdnxRskTxwuXyeMZbSoBcs9q4++zM+ywcskISDMXjQ0J0UHxMNSH2KE2x3C2uBazsSFuOebCMbQTd6Tc=
X-Received: by 2002:a17:90a:d64b:b0:312:1dc9:9f67 with SMTP id
 98e67ed59e1d1-318c9107a53mr2192640a91.2.1750992212056; Thu, 26 Jun 2025
 19:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-4-minhquangbui99@gmail.com> <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
 <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
In-Reply-To: <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Jun 2025 10:43:20 +0800
X-Gm-Features: Ac12FXyeaiRss6v-acFo0ljDViofeaY9eNXnTbOP2WE1qi3Xv2JlKX1swLORs6U
Message-ID: <CACGkMEvf18Dmo5Wzdq-GnJf-jOrzKMQ7epZA+ssWPzXvCnCXvw@mail.gmail.com>
Subject: Re: [PATCH net 3/4] virtio-net: create a helper to check received
 mergeable buffer's length
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TPdDS7_efHtX4sPN0l85PGmx5XfKQ1FFZPRrhIKDZmE_1750992212
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:38=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 6/26/25 09:38, Jason Wang wrote:
> > On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> Currently, we have repeated code to check the received mergeable buffe=
r's
> >> length with allocated size. This commit creates a helper to do that an=
d
> >> converts current code to use it.
> >>
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > I think it would be better to introduce this as patch 1, so a
> > mergeable XDP path can use that directly.
> >
> > This will have a smaller changeset.
>
> I'm just concerned that it might make backporting the fix harder because
> the fix depends on this refactor and this refactor touches some function
> that may create conflict.

We can make it a single patch that contains:

1) new helper
2) fixes

as long as the changeset meets the requirement of -stable.

Thanks

>
> Thanks,
> Quang Minh.
>

