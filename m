Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3CF24DFE3
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348598; cv=none; b=KJx/LFuJYw5Ln/llU+MnbvIgK/cwkTqwboI+0UcFasaHc6xTPj0Qq8OCfE+5U3Z/WV/slpBk2Qv0LkqvZvXpJ+0auouO27jyl/MNpqx9NgQCuBHecZdePv0BDZq1ci662A9pjzUiUU5swZ6iwQCq+Llo1U+xs5onJVOfqZyxBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348598; c=relaxed/simple;
	bh=GV92ClXjvz4/MTW4YP/XSUB8BPHIDGjT8AUblei2M/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYdGAsBCQcITGytUE1JE8L8+GzLs3mx+ma6FOFLHoNOoT4APRkN8jt4d/jhMr3zffkWP+xjC/Z8LpkIL5JQMN6lwd96jwX/WchBU25JtwnNNYL4TGq+/JgqNmHzdcHycTwH5vLzBUCb4Q4ve5NmDeyllAn7j9GpdDAnabXJ2jQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaTX+0H3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaTX+0H3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GV92ClXjvz4/MTW4YP/XSUB8BPHIDGjT8AUblei2M/Q=;
	b=eaTX+0H3GiSvKDJqKhA71t3MKM/EDL5HXNClbCY+IQgR5RGrtIcwtEFp0ZsWp5jk9EjKG4
	OXhX9yUg3+X+BI6vSE67zhlecEefxRrsD3lN+tpCdgOHYN0cC2JjHi+urQY9AUtusFfm83
	ivBsIqVxTrA/NaFQyKOISbxYTxAFAtw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Pl9PdV1WPjO2_hU36cPH-Q-1; Tue, 18 Mar 2025 21:43:13 -0400
X-MC-Unique: Pl9PdV1WPjO2_hU36cPH-Q-1
X-Mimecast-MFC-AGG-ID: Pl9PdV1WPjO2_hU36cPH-Q_1742348592
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff69646218so10039042a91.3
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 18:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348592; x=1742953392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV92ClXjvz4/MTW4YP/XSUB8BPHIDGjT8AUblei2M/Q=;
        b=B0GPzpyEAXGnPG+2KJvus+3EH3UYY+LmH4fdaLtXAG94/IJcbWv3KNi3SgakjKm1MA
         fWVTLfQ2QN2sgHsdGjTElG4+ibWhd/4xg8FSHlSzAqsbOle/1FSUw7ue/nBdIwBgCmmh
         ujOc4hVDhXfIUO5D27JMV3cXKr2fhux1xEYbuuCMI9k6TLeJKUi4xFCdRJjDHGuWlhh0
         KZDKQFmaz4VaMk+Wpf4InnuWKn8NjWZuQVG4EsxoWmTJvvreZ9oZXJ0/+zjJWi6Lk4Jg
         AfCrRXQiCoIEPFBHs53LvKZKsKpVbLpplBWEWLelR1fAGQwa2ugO8PCbet3AtvrbiQeA
         USVw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7m5dKG9WCAB6AIOcHQiNPVv431HCbSBjc2E2qnyLXhcdvIHUqsA5E8jV/w6V0t6AEc5cX3nYcHZ5mQho3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YziGhxiNovhSvXAPN+3YOAdmgag4I1yDPf++6zwLQqo4NSPD9T/
	Xx1wi5k05Hhd3SqAEnvTDpUfcrRk9Xlbg5qIR+SuDQbaVCvp1aqxMMxlffdTQsj8Qegi+lOAnCA
	WlLMTC77xCNeoHtd5lgTpasxkR3fhHJnVSUs8+vH+opWxmhkkbkwY4KKUrnYprbuRY0PHnRJVdp
	gk1GxexeIeIw11dkyaXZ8V54PPsmR9GDieTlaQuEQ=
X-Gm-Gg: ASbGnctol6YaNJyF9JES2DCwmC+YseViTisYtFeFNdCjI6ca7OPeNWjcmfMmI2nWB0P
	LfHgZw7fDA2KEKlZ6u3Rlk20EiZBYmQfO8HHp0qGwUIhypO8CAo+Ghkcm5mvBtXhHzBA5J5rK
X-Received: by 2002:a17:90b:1811:b0:2ff:5ed8:83d1 with SMTP id 98e67ed59e1d1-301bdf8fe6dmr1172333a91.19.1742348592287;
        Tue, 18 Mar 2025 18:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3xUKmc/HaZKbY2Dl8pCa58A8bYMdk6rBE8YTKkC3nogLq+BbetaOi+Z7lREjD84lMdYnVJXjJq88sniZ07Ns=
X-Received: by 2002:a17:90b:1811:b0:2ff:5ed8:83d1 with SMTP id
 98e67ed59e1d1-301bdf8fe6dmr1172297a91.19.1742348591933; Tue, 18 Mar 2025
 18:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-1-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-1-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:42:59 +0800
X-Gm-Features: AQ5f1JotJK4za7GHDUjLaHu15ZgN8MdATNrjp2GqHsHDNV3hc5BHA8yY_muRp9w
Message-ID: <CACGkMEv4EXUcZ68SZ7RzKnJ1+etf4jvqLLUG9-dXUDc9jSsOiw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] virtio_net: Split struct virtio_net_rss_config
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0o37UUDDwFcYBl_8mCXvymGSzM3IK0MwbwvyrrLBacM_1742348592
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> struct virtio_net_rss_config was less useful in actual code because of a
> flexible array placed in the middle. Add new structures that split it
> into two to avoid having a flexible array in the middle.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

