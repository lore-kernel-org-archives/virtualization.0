Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37E145A18
	for <virtualization@lists.linux.dev>; Mon, 10 Mar 2025 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573179; cv=none; b=kOm5icf25d9G/FqVdKuk+hzqoj0+96xJ6/13WNrrCwg2pjoiPMwcz6c4aNiUiKEScTFTfO5uEFJcdtVt13tE+cGY6toOA8W5K9IJVFuJWepaGlNAsa3gwGxCSS98NzzYDifccwpfcpW3gDCqi6h7yS8vN4Kp3OFMRVEEznk02mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573179; c=relaxed/simple;
	bh=AtJz09iFJfguCxcJpJrTrHp/B802QUOltbOGPdkAKoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfF3hqB11p195O9xDVWl6zg8A/asUhOwQV0IfP01uPIRgarK1q68UH0CkuRanWFd0LI7Pg3bHFuRY4z9W/UPglsUirkuqkhcO0GSv0TYIJonqPdWLSyZNJdqfpOTvIZ6AAyyquKEVsv7vBWp2jLl34gzvYfv7ppaG7ys1Q9J9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtoJGccV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtoJGccV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741573176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txux+cFqmLt2vXZPROSLCC6ehPEuq9MQWbslAZa6/aU=;
	b=EtoJGccVtkwZXncr0ePMaN1dy2y/XKt9+iq7bMIuEzpuPTvhXkEoNgymYEWGvzIru4fdGz
	JLD/yosWMYRhguQC/jle1Wxruls6atgI8JYpCZSpf68fZNgR9K3Jb9DP8/dWn4OeHAWW5H
	f9W3jFv8m/P9GvaXMEFHdZAitKPrVEY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-0hA1md8SM2eGcV55syW-1Q-1; Sun, 09 Mar 2025 22:19:35 -0400
X-MC-Unique: 0hA1md8SM2eGcV55syW-1Q-1
X-Mimecast-MFC-AGG-ID: 0hA1md8SM2eGcV55syW-1Q_1741573174
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so6226558a91.0
        for <virtualization@lists.linux.dev>; Sun, 09 Mar 2025 19:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741573174; x=1742177974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txux+cFqmLt2vXZPROSLCC6ehPEuq9MQWbslAZa6/aU=;
        b=C4VOY+iTSzxyNnH98l4fyYle8sxkKmCzNYd/VYct3PTxbz1f/2ugk+v7h+fzsWI6cy
         lij8ss77L9f65WckihmtwWDzBiB1dANn1g3tBXQN9C2TR6ixYZs8BGuPUjV9fVy1v+Wu
         ft902hH8RCUZwY/uwyAkaD2MnN2Qw++/Oo1P0fVVRwxKToA3AELVw1GSSYzz833/DMSy
         1TX5m9VVjHyejg7pgVkniWZtyq2ABOlYxx6nengnfP5cyolW+EvAFnn5B5zBu2Oreo5f
         yb/3ir9ZnCacTjxkqZKSgRvSO8PV3bljMZV81OUxscKSgZvxuMLKG3odoUf30VH6wFWm
         LwjA==
X-Forwarded-Encrypted: i=1; AJvYcCXhoKlOX2bE1rqNTxK0K6eXCLftY30f7z2mri0STSquM9G7TZLRQNQ53mh3yM0BQUAA9DVxT2oRFcBNP563dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdBWq2iSx4cLu01Nj4LpS3OqQVKB6LSOUTEaD/gBNggUcPAe3y
	eqlCtWJqsazRmaOXGIX1dxIU/5IVyc2sByyHW/6uAASciJHBhR+yD05kEoTJkvVbZD8dP2WAdDR
	QI8hVImqD4e4Z26KgSIAS7nTq5XpqFSk5lL4SSO+Mm91lVA+oHi46Rr+ztWPZIf8lXtNS+O+NxL
	aTtuWmE2JVSFGXV/HI8l+HDISck8+pLoPKiQRC278=
X-Gm-Gg: ASbGncsAczbgbeS9POHrWIfxuQ9li8HjZESC04EK6UE4M0okrFlk1WK+yhQLa4x4Q75
	LbW+LTpmRoIKIhRTMhCzput57dy1yw6Mz+33tSd1R8K5umNdHsbBCiyBAoI9RXV1lRP5w/JoibA
	==
X-Received: by 2002:a17:90b:4ad2:b0:2fa:137f:5c5c with SMTP id 98e67ed59e1d1-2ff7ce59712mr17785013a91.1.1741573174024;
        Sun, 09 Mar 2025 19:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfi1kUcnjN/MGKScrpXZXxg0LHhjJwKWatCBlfrt9ASrGU0RhKt2zcjhKxKIGQsohJlSyTaOwlLcFFR/095Oc=
X-Received: by 2002:a17:90b:4ad2:b0:2fa:137f:5c5c with SMTP id
 98e67ed59e1d1-2ff7ce59712mr17784996a91.1.1741573173619; Sun, 09 Mar 2025
 19:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250307011215.266806-1-jdamato@fastly.com> <20250307011215.266806-4-jdamato@fastly.com>
In-Reply-To: <20250307011215.266806-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 10:19:22 +0800
X-Gm-Features: AQ5f1Jqyyv20MK_Tuve32OgEwQce7uxyuKX5GI5kUQGIUUAGsE7tTG42f1QJ5Ec
Message-ID: <CACGkMEuwTaH9fTXC00633RsiKd9BMZSAaPG17i-+MPagGwn0dQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] virtio-net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	mst@redhat.com, leiyang@redhat.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: goEv9Ri3LJMZCph8hAIdxYk8OE18IjVFnKl9Gaszy5U_1741573174
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 9:12=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps. Note that the netif_queue_set_napi
> currently requires RTNL, so care must be taken to ensure RTNL is held on
> paths where this API might be reached.
>
> The paths in the driver where this API can be reached appear to be:
>
>   - ndo_open, ndo_close, which hold RTNL so no driver change is needed.
>   - rx_pause, rx_resume, tx_pause, tx_resume are reached either via
>     an ethtool ioctl or via XSK - neither path requires a driver change.
>   - power management paths (which call open and close), which have been
>     updated to hold/release RTNL.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

