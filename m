Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EFC2EBBAF
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464413; cv=none; b=VQ+jHZVK+M5F7l7ncwvhda498N6UDOOP12seZxKjQTEKGCsaYKyfelJ28eQ9rO2rp7A6hU1QrRrU2kLM9m9nSgikL4ew8zxLW6085frc0wcP31sy3LUja2ikOB0ySvP3oZWtrEbdETru9qEGki2Zho5bmwtGGnJ4J2efQA8jzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464413; c=relaxed/simple;
	bh=YYKrxV2AZQhRnJ00tNgIh3bvn8s5lLdgMAfAr/Gmrz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxuxmZUi+46WRBqOOIqlXCMIqos3argQ9BccqYKbQJcukbr56ZAatPRPf4DQfdLy9CBbt5oRytuBOjDSMmjXi9pUi+yB7svvehRQuyqZHF/shAcHKv+/K3/Yj83sQfsbaQBe3tePd9SO7JXPiRcjmmiKb+vLJiT5GlNkYew5LEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTqzZpEt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTqzZpEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768464410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYeJH5iwrjkE5YHFAvciAB40NU8q+zvI5r6LRHVgH+g=;
	b=TTqzZpEtf8l/PJFKK5E2UVsMjXQPQmHf39Ecs7Jyehb8OvCyKo3tGFX0ct2gh46Eqcs+tw
	201fly7ynJf4RX7yW/RSFLo+6CgxGiqj1OCMDPJkeo+3vYTmkWCmoF5KV1UFUKAJT3BZvq
	A/3Gzk6F130vxbHMGF8+Peely/RJTfM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-fpf-EVGWM_aDCSeThDTw8Q-1; Thu, 15 Jan 2026 03:06:49 -0500
X-MC-Unique: fpf-EVGWM_aDCSeThDTw8Q-1
X-Mimecast-MFC-AGG-ID: fpf-EVGWM_aDCSeThDTw8Q_1768464408
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c6e05af3bso575747a91.3
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 00:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768464408; x=1769069208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XYeJH5iwrjkE5YHFAvciAB40NU8q+zvI5r6LRHVgH+g=;
        b=n0W0moRwHM77kvcE78GiY8CWVT2qqCM6Njm6d4MbqU0RzleKaaCoY3aWL11O/TyG01
         ZhEotVX8LYfHTYlawPjws8QQjwK/wDEBe8hdCKKJMSV//XsBfDgP056UXhSCoiWx0vOz
         YhZz4CSdHs4qAv4IU6W/P3I0uc1d5kLA55vDa9OfQa9EC0fv6VI6DVhbgMYp97ODWIDe
         MLVRw3NuaSmZ8FytaG7iid0n8QGjvtONHDc5n/A7NyXrYq14NPZMWoS7rR217kGgsVQg
         pEzTVav+GwKEZuz1pToYBJj/GkbKMAa2+eWchh2xkH+CoC5dYVG0hsECfofBaUVBFa2F
         N3mg==
X-Forwarded-Encrypted: i=1; AJvYcCUyxhp/cHy2z+tlwvEsYUWuOcJFmVl+Axefjs0dUKa7vWsQIjIcXvieu/JwSF/S/EgfvptxvSfUgZOTp0vw8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUWc0jbofmeDBP8Qnt5TvJL+Cgo7pCaO3WscgIXsYWTMNCWG3C
	14AAfnebAm3z8160+N0NgH/3SsqmEUNT9uOHquCxE7pNCkBvGJwzvVQJBogfRqnUIR0cGwGA8jN
	4uVHJ678Q6H0iuOsbeFr1mEmDZNbKifE2uQ7lHgdkDRK6EYPYho08W/ZZFqxUOzr4ECmchl6n07
	zm0w0PxAS5cQALxxnwtCyrRrqBnwHxRxy0BFQ8g3yLpSEGUh5GOIc=
X-Gm-Gg: AY/fxX7rXE67g0nYyYeV+hIctntZu4i82thPepx4LCF7Nf7WJuxUf3PdpL5uwYFURNF
	LLrLtEMe+/7VnsMhPWsmb+PTccV85tz7FrFqFV7TRyvLF+SZG8HqFtAG1llkgZts4lDC8Ukz/Cd
	s9+4jteRHbVYMc13k+9WWle3mYK4AX3L1CjVKIcFxy3PqQFdoaDSq8m9CC74j3iuJDEh0=
X-Received: by 2002:a17:90b:2e0c:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-35109091ab9mr5183387a91.6.1768464408241;
        Thu, 15 Jan 2026 00:06:48 -0800 (PST)
X-Received: by 2002:a17:90b:2e0c:b0:32b:baaa:21b0 with SMTP id
 98e67ed59e1d1-35109091ab9mr5183366a91.6.1768464407771; Thu, 15 Jan 2026
 00:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114123627.102579-1-lange_tang@163.com>
In-Reply-To: <20260114123627.102579-1-lange_tang@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Jan 2026 16:06:34 +0800
X-Gm-Features: AZwV_Qj7q54TlRHSQPucZuDsppHP1c45KxpfXT__jWoE7GkZys3WFTu0M1IYExg
Message-ID: <CACGkMEt4AqSAhPCmXCSOO8==PDqGxd0t7jmMc24=DTumbjsqyw@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_net: add traces for tx/rx and INT response events.
To: Longjun Tang <lange_tang@163.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	tanglongjun@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CZnNlP_ZLZhofM6AGYlHrNdePhtKbIFd2jLWAxiEPVo_1768464408
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:36=E2=80=AFPM Longjun Tang <lange_tang@163.com> w=
rote:
>
> From: Longjun Tang <tanglongjun@kylinos.cn>
>
> To facilitate tracking the status of virtqueue during rx/tx and
> interrupt response, add trace point at  corresponding func.
>
> Also,to avoid perf hured,it olny available under debug condition.
>
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> ---

Could we simply use eBPF instead?

Thanks

