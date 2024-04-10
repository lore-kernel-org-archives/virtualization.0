Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0ED262A8
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729373; cv=none; b=bFNjvUfJptk/c2oy2ri+Qh275cSBJwR7JJL3tQ0+9gvisWabBoSJ53MmPBQDGoXoLQeyNPbtW8wXSa6F+Aq+Q7IKuMPVzkMjO4l7KcswNjSQs8KbACKbf8u6wGWQlwN75AotWuIBd3/8gmhViUBofzVH2DWLNDA+3Z1yuLvLxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729373; c=relaxed/simple;
	bh=TgEnH+juOE9q3+l0Iy/5OigfN5ANC+3jzENCinlc60M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3yO6hDubn2xIfvtAcOXPmdX+vvgawaoMQEiQPktB4iV2OTVjD0n19DocS79E3jQXQaCm/CNlrMACMmU4UfvNfSuXOhy4r9+8J84INFIgqinpCp1jpJ9XsUSNSAsinTQyjj1acbznh3rIySy1oR8HMx29gAQx5EAISc0ktPKwp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8FG5FY8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8FG5FY8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgEnH+juOE9q3+l0Iy/5OigfN5ANC+3jzENCinlc60M=;
	b=J8FG5FY89TQS2x3QZOfSECo2JtHO3uzAk81JzlxR/1GRTfDbIlXXMU4jOZxdE9pIefsU+5
	sAmC0qiHq06XPdUPReKx+hA5RgQtXieHsSKiVrn86Y0tVkFiYYws4dwBswmZkp7StwU+Yq
	8KUQ59t/Zri3Aovq06NlElxMVih+RQU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-cECeuosZNgyxbk_ivZkaKw-1; Wed, 10 Apr 2024 02:09:29 -0400
X-MC-Unique: cECeuosZNgyxbk_ivZkaKw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ed58bc3d23so1355522b3a.2
        for <virtualization@lists.linux.dev>; Tue, 09 Apr 2024 23:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729368; x=1713334168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgEnH+juOE9q3+l0Iy/5OigfN5ANC+3jzENCinlc60M=;
        b=dKBl+R02jPfGbsmL1UxdRDy2ghgA1lGrolwCw4dAELbjGC9s4RrQZUzqGV/BLchQwu
         JeeAac6rISTKF+xH8+WqbGLb2B4ePZhLSa1Y5vdJlPupQI53b9UKxCVt1P7OuSeubIgu
         DizJMl3kJN2N6QbSyAOce52efPjmoxmwzcHi8Dsex/aoWf/TI27bSyQfJQLcOP7ueR4K
         jl6NHMeZnLc6cJl2NRV4LU2U9zPgArye6brT6ovsyy0gK7fwwokgX8BO3ORuUokqAjew
         pqsvzCmmyUGJqbWrd8sNEQUG4IWel3bGcc0++OvbJkfTmKW88BdKPg/SE+tbqvc6GYx1
         hULA==
X-Forwarded-Encrypted: i=1; AJvYcCWu/PPzOOZL9/HuAjFKJBtvl0hgywPxxX6I0s5/CQL7JIXXykQBg7mBbWUcWsyUO+EJrRQdY3bra0rndrx3Ua5qncxYHHI8jUhW3VYJmEM=
X-Gm-Message-State: AOJu0YyH7VVE9Er63PLeov7PjLINpl1f5o004G2K/vwX1pG2AlPf3UZ6
	zPxOlsxXO3DQpddJS3dYpYQxklfCiQQcInSsap7fXNTAS5kGQh4xBvDpzY4HqYQT118wx4nwLis
	9tSrk4lIRLiOf8lKdIiuWs6fKIqgqy1PajGQKEfC6UdiYrzqJVUjsUIw/Bz9xg5Ded4NvBjbgC0
	eMTIxNgArOQK/hF2ctfgjebdaQGNn2BCjS8cd2A90=
X-Received: by 2002:a05:6a21:186:b0:1a7:912c:4a60 with SMTP id le6-20020a056a21018600b001a7912c4a60mr2157244pzb.4.1712729368460;
        Tue, 09 Apr 2024 23:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU6Br+y7ZLlNLo4KSKT8o6SK3mGKJFVCb2xmJ2+EI/QnRnzH+iDld5ZX3v968qQ7jPjyAIw5rA42aTXkGCrl8=
X-Received: by 2002:a05:6a21:186:b0:1a7:912c:4a60 with SMTP id
 le6-20020a056a21018600b001a7912c4a60mr2157239pzb.4.1712729368160; Tue, 09 Apr
 2024 23:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:16 +0800
Message-ID: <CACGkMEv=u19rOf_84rp3GP=FwxJ-5XAChyHwR_s_iao0xUma_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/9] virtio_net: remove "_queue" from ethtool -S
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The key size of ethtool -S is controlled by this macro.
>
> ETH_GSTRING_LEN 32
>
> That includes the \0 at the end. So the max length of the key name must
> is 31. But the length of the prefix "rx_queue_0_" is 11. If the queue
> num is larger than 10, the length of the prefix is 12. So the
> key name max is 19. That is too short. We will introduce some keys
> such as "gso_packets_coalesced". So we should change the prefix
> to "rx0_".
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

