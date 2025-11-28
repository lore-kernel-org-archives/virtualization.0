Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56EE221546
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296506; cv=none; b=TrpGNjslw9DdPPvZ/iz1FzF6QgWZOXPFoemjpNBGkEzcC3M6Fich1I7e91HMU0SlxmDrv+YtzxCA3n8jZxsu2o0M8keRePOZlvjXH0GKbwiw8KCVPI8ns4Y8c3hxaZ9PaTcwcg8QJTovgBi7LgJ6DQte+QheIycXvQh0lp22oLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296506; c=relaxed/simple;
	bh=il1FYaJ579SBQnfZ8qzgIWiYgFEtgkzL+JZ38yo/Bls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YStopHAHkUHVnebzdyFu4XGXHqFHBBCVy9ELdEl1KZ/c5u2fd/h5/h2Cfgt9qXCS7hX5K9ZP6MX31F3x24jFS6moHNjvZRRTXjm6HYENoCZZwkg6/b2gXT8ezW1PoyDqjjgtnvIQpYkwQO+4Cp/uwbjzGVenREvRAYOUQjGysFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGZS7ENl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGZS7ENl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764296503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=il1FYaJ579SBQnfZ8qzgIWiYgFEtgkzL+JZ38yo/Bls=;
	b=KGZS7ENlikBCuv3ps1Yzg2/bS1Xo5DKd+BY42FAUBfXGOyiuwEJ/X86AaFdR+VY/avlC2Z
	mL6zUx2b5kVfCuJU5GCIrt5mcDxKuWrwV1i3BM0j/qjuqIVxK7EKvTXsS38sjCcdFnrIuh
	qbbNPk3p445QUkUrGURQXqOaP359Yy4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-J7l0b-j2May04u6m4cekqQ-1; Thu, 27 Nov 2025 21:21:42 -0500
X-MC-Unique: J7l0b-j2May04u6m4cekqQ-1
X-Mimecast-MFC-AGG-ID: J7l0b-j2May04u6m4cekqQ_1764296501
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343daf0f38aso1335517a91.3
        for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 18:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764296500; x=1764901300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=il1FYaJ579SBQnfZ8qzgIWiYgFEtgkzL+JZ38yo/Bls=;
        b=Vp50ADj4eTQAJCYYJq5XAbnPToEbDu+4DCuclx2UPGJxm/0sXUMgFIkjh20xoCsCTV
         /1hVTKBRm/9iBs+TTVVhYH0KDFiace7dZv/crrAnt6s5HtF5BAmUPOb75MVtd7XaVsey
         GxckWW7TT+GIEqTzymebtbIAUPxXKaajXE+ueOCkj6FyQf/gws1Vhq4jPMpK7W1n1cyB
         0KlmKpTYByrKYEjylw5qya/fxUwpKbmULx/IOVIrSOqohSb754s3H8vKDX9sZPIMBxqB
         6q1XZejXjxeHKUdZj/40FeGhdMyNP6WVBrR8zY6ltRiToaKTma/GqGNsfI5K4mzAlNNg
         NCTg==
X-Forwarded-Encrypted: i=1; AJvYcCUKjq7+ftbvb1UlwOeklcwtDwuxKk6XaLTHU70zxK3HvsecIAP+RxOaOxD/Z3POuZyfbDkigDDYDA+T9jz/sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKRfszkuAeMhUiCUlSMhst9HJCfqY51crQR/ST4Lh43bTgZDQu
	StHi9UQcLt5dl8rfHx/3QTulVJCaIWjr3hndCG9RaqCQvIBDRKchqUlHnQB0KxU6jXnhc5+EgZu
	mxOZDPQ+t1ea9+Y4kI3wjfyxyR8+dvAtdEgH3TkzUJ3TCWPPR2vydrRligJTbAxNOCNFfEkCN5C
	8WskUGOMnRVStCxGp9LPhhTRSigdXQCN34o24gV7epvzdcXuHzQls=
X-Gm-Gg: ASbGncsc1IYkrgxVPTNgJCsjoFXq7aV799hiQrfod/pSy06qcaTZblmCnbjNbgUuxzR
	0nyqKP4mUm3KBdkn+hXAiRob0xjBTNo5FwR5GykIUCR97uYXYcHxkK/Dj6gVorEb9BFSJmRNM/P
	nBmiNzSTUCVRrrmYwfq7oQIh0U75rGaOkv4LbI8b3UvBBNYIB1S95uAPJ/I/aoHLRC
X-Received: by 2002:a17:90b:5744:b0:327:9e88:7714 with SMTP id 98e67ed59e1d1-3475ed7d917mr13437554a91.37.1764296500655;
        Thu, 27 Nov 2025 18:21:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeF0nCaZqOxCG1xUSIBsnSR94kVRYw2K2FzvP/RCBrDIzJyLAOuWq5zjoztRktNpDBk6HavgOnwpIfjIlKyxQ=
X-Received: by 2002:a17:90b:5744:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-3475ed7d917mr13437526a91.37.1764296500215; Thu, 27 Nov 2025
 18:21:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251127032407.33475-1-lange_tang@163.com> <20251127032407.33475-4-lange_tang@163.com>
In-Reply-To: <20251127032407.33475-4-lange_tang@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Nov 2025 10:21:29 +0800
X-Gm-Features: AWmQ_bk8IGGeg3vhrm9qoz5hwCJTt6OlugQXb6rGzEuf4KSke5d0KHE6Dz3yA0Q
Message-ID: <CACGkMEv7szm0oYXZGPcRjdV8jOCzm9JYWttCeeCtA7pea5vA7w@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] tools/virtio/virtnet_mon: add kprobe start_xmit
To: Longjun Tang <lange_tang@163.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, tanglongjun@kylinos.cn, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uicDPvAJiR14rTxMwC4Wzej0AftVZOI-cin4Rxp9vCA_1764296501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 11:33=E2=80=AFAM Longjun Tang <lange_tang@163.com> =
wrote:
>
> From: Tang Longjun <tanglongjun@kylinos.cn>
>
> track skb and virtqueue through the kprobe start_xmit function
>
> Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
> --

Can you explain what's the use case for this or why we need to
duplicate virtio-net driver codes here?

Thanks

