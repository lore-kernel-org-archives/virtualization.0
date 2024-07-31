Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8B1FA4
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 03:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395600; cv=none; b=sQtG+tjMehsl7kESnuQNmBT5vx7qDCHHBl2WlEG52JLik1pMd5i9huHKtJ0fo+UREFIyx4cc4M9YZxlYLCvSqg3RXqhcgSuNnH7tDY5sZ+xn4fe0VX+hGEVRVZpkr+378TLsvWbavB6u8wefrGAJHdHHzUZWPuzq8DTJW2rKk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395600; c=relaxed/simple;
	bh=2QXPLbv8fw3NvYw8Bln5EqfyJklqNgMg6tLmX+z8Ai4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVvRwgmkdeKIvewOiWtsZp/vLEMnNnOVz+ihf85qbS2NSzCZtpAtzC/k+ubv9elarxWERAKSi8yCBCij40uxTBFnioKbn+V9bCCIamdwiXJ7aLfmvw6zhR6WSUgk+iHJz5dJFRQ5LJWs/i9Dyiu9n9iN8g/YXhohF0oUHSJquMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJi8qm41; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJi8qm41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722395597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QXPLbv8fw3NvYw8Bln5EqfyJklqNgMg6tLmX+z8Ai4=;
	b=jJi8qm41fiEaeN0xtno+cGvPp4rEdQBNeT+0VvZWtbmtaW3/sqnZvmxEXIyw1yBXLXGb6C
	YABNzuWRrNo9Z2LP7QA4Kio+FRu6l6a7AOoXzX3bOsP/nhd7gsy/j5YOzLoOCixBuukyjd
	k2GNkaQPqJP+yYPO7TWpmtF+2NIry8o=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-9t6zsw7KONeYiU9wIXgLkw-1; Tue, 30 Jul 2024 23:13:16 -0400
X-MC-Unique: 9t6zsw7KONeYiU9wIXgLkw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7104d2cac39so296925b3a.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 20:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395595; x=1723000395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QXPLbv8fw3NvYw8Bln5EqfyJklqNgMg6tLmX+z8Ai4=;
        b=mpeueJridqM+w1NgWdfl4xaEw8WRH/mid8oqlKMxOcu5ESukjCKAk1sNsXhlt64OeZ
         ON2P+2pKn5b2vZ8NdWRL7N2crV4HIGMwWRcrgDUfGba/X0hf9MDpdOQK8RW8lG3to3yn
         lEYd8IMZVUZRniJp8CVMQJyuqOi+hzMPf6+QTL3dtWE8U3zHNonL8v8WUeNcKQ26vlYe
         0iqNhXTcSGOSsmqhHBrzkzmzKmf/fcASo4IWZ7Q7DW599j+dzSUQ37+QstzYistx0Y0K
         1vXe2fXc8UaPd77ifk6uGPw6SEltnwx2rw/t4GboZzdy6K0VCR1ncMC1iY47tMiDCbfq
         xagQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiSi6Kob2P0mYIM6ElnWmBSlKaij6mJxW8uIaUr0GcIjmgAqaaY+QGIhX6wGHjAdvW/Dr6PMV5+C/JFHZAnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9UeSwZBjA4m92opEVA2gRvLwRaN+rsgH4j4co6UZr8wpIroxT
	Hb4TTdRLD65Fwoj3NNwhksCXA+jG8jtxJKzYre+oA4GyKyFg6JZWfwBC1Mgb9pYFvdrtuSckxDr
	ySNyFjdGY1HEKKlBgoTVlDGFXS/rIpYfUpfEzrX+w21Kfy/Gx2meyhnBH7ACfjN/hQYwDro7zga
	LcjamILe77T+sfMbzVXWm7r6eo/yxbGJR1zXuHM8XcbuCNl90raw==
X-Received: by 2002:a05:6a21:6daa:b0:1c4:8293:76db with SMTP id adf61e73a8af0-1c4a12f65eemr13100312637.29.1722395594834;
        Tue, 30 Jul 2024 20:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvWLIEukL31v5QVulnv3XiOgnyvuE+tF13uwsuSJxLKEt/9oZ3s6vbViz6RDp5OX0m0i/Kp92DHcVMBTzewS0=
X-Received: by 2002:a05:6a21:6daa:b0:1c4:8293:76db with SMTP id
 adf61e73a8af0-1c4a12f65eemr13100287637.29.1722395594365; Tue, 30 Jul 2024
 20:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729124755.35719-1-hengqi@linux.alibaba.com> <20240730182020.75639070@kernel.org>
In-Reply-To: <20240730182020.75639070@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:13:03 +0800
Message-ID: <CACGkMEuxvLVLuKCLNi2eBy5ipzNn+ZGM+RSRBXk-UA0bJCKgZg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 9:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 29 Jul 2024 20:47:55 +0800 Heng Qi wrote:
> > Subject: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescin=
g commands
>
> subject currently reads like this is an optimization, could you
> rephrase?

It might be "virtio-net: unbreak vq resizing when coalescing is not
negotiated" ?

Thanks

