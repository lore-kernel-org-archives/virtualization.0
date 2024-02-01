Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842F79DA7
	for <virtualization@lists.linux.dev>; Thu,  1 Feb 2024 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766572; cv=none; b=t4vbTVeqCmJK8ghL2wrGDjc1a41rfCq5p5hNT+eyYwtcYAkw0Qi5LfGF5aMcVbVbpUYjbAinwCQgGeLgvYVagkfhxlGUo5kUXMprenbfOzowozc9CCyltCdh9G076QkW1mPNSgxUrGdwOqHeOBukXqJ6m3pLl8cZZNWsty2H3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766572; c=relaxed/simple;
	bh=KIExdWHVmutlvlT3+obd3h+YUc2wXhpfig1qUZ2NMOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyHDRqs6Bu3JhLG7FcbXXvl9E7cQ3jpLkq5Mo4FQB2JN/ff3kNiWp8Whxvewi6rztYM000oeQuFFSUYhy46SYdE6nu8VVBqMxBxbTPV3cD3yEVg6nH3XQhA89F+8ORHPxDm83rGmchQ4XG5yXWTBk9pRcP7P/jfQj7nGSmlZ/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0pPId+z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0pPId+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706766567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgbdx/AAaJZ7DeK9FOsHQhtQNYQ6A6a2HZZVAxKhKQQ=;
	b=L0pPId+zhlo0Pwu4s5nrOK9D82CNTYCmCKxQTyVP7VJEGgoEZ02DSWIFcxAi0V0GVaYEq1
	H+1Jo5N1zEatsWEnBtNeHaEaizzq1UpCaWpVUr7QzzMRpz5+xCcM16LiTvJjztEzT0sX9D
	bgur50i3QydrIto4o48nH21JpOP4Fho=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-j-zgOmyJMQWxuhSE3HZZNg-1; Thu, 01 Feb 2024 00:49:24 -0500
X-MC-Unique: j-zgOmyJMQWxuhSE3HZZNg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3be76c32883so528997b6e.2
        for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 21:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706766563; x=1707371363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgbdx/AAaJZ7DeK9FOsHQhtQNYQ6A6a2HZZVAxKhKQQ=;
        b=N8S1kqa4eEeLrNnkhvkSK1ZIHZQZ2ZkkvOG8FW0Msn0mGw4w/8V9RgdnJylQcNLlHd
         5bePK6QmB4S+Qb/+rdJxzc2R9wUwEbS97nwyD8lTJO5Lt49GBwfsbKZBmNAvn2xKGCeE
         Cjo8vagzDNDDKzi9UDT4QoYYttVa/44OBLIq/VmNr8eOUxA8kBCL/tCa43Xv8uV+YIHm
         Av/1YeKH3lxOHTltn9bCXrEWNxZyZZyTFryvF3PHnVzvn6ME8aVI70/+rq39042A9wmh
         cyluk/uAE1blrD7uyTvUYzrPM0f4exjjlHEyqpt6LNwkT8uIK5SgOGL3HIx1Ek6Rimk/
         z2tw==
X-Gm-Message-State: AOJu0Yw23EFRc+DpJzEWj4XZwpu1sV6k+eXc4WPh1IJDdIBMZF0dntEi
	8BIDvn6FxaqNrZPi7PT+jTmgMQkikWsatlbNoBQahpAfWFN0QYVYisnF9AhndVuj81R+DuPm2V+
	4yQaAhSAUQ8TvLp3GJLKUJYfis1x0h6PEH+P8DCAvrI7rtoFuW0COZFERMGdawiJ6cu80klZMXL
	NaS8rp4h9MFQGfbxJlTbnQY+/g/Reya7MeYNX15FA=
X-Received: by 2002:a05:6808:3092:b0:3be:37ff:47d5 with SMTP id bl18-20020a056808309200b003be37ff47d5mr4229260oib.32.1706766563544;
        Wed, 31 Jan 2024 21:49:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXjMe0eEIqZ9DC5AR6JP7575RarbQIvdtQ/UTHdrVnUvzMt8FJ1hfqImdtib1VNlENwMqnPvjlqh4Qnql0aEg=
X-Received: by 2002:a05:6808:3092:b0:3be:37ff:47d5 with SMTP id
 bl18-20020a056808309200b003be37ff47d5mr4229249oib.32.1706766563285; Wed, 31
 Jan 2024 21:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240130112740.882183-1-pizhenwei@bytedance.com>
In-Reply-To: <20240130112740.882183-1-pizhenwei@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 13:49:11 +0800
Message-ID: <CACGkMEsrMcAbrsfupDJ_fK_RTA8zRtGh77UBHeXZMiRxCaWypg@mail.gmail.com>
Subject: Re: [PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, mst@redhat.com, herbert@gondor.apana.org.au, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, nathan@kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	davem@davemloft.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:28=E2=80=AFPM zhenwei pi <pizhenwei@bytedance.com=
> wrote:
>
> sizeof(struct virtio_crypto_akcipher_session_para) is less than
> sizeof(struct virtio_crypto_op_ctrl_req::u), copying more bytes from
> stack variable leads stack overflow. Clang reports this issue by
> commands:
> make -j CC=3Dclang-14 mrproper >/dev/null 2>&1
> make -j O=3D/tmp/crypto-build CC=3Dclang-14 allmodconfig >/dev/null 2>&1
> make -j O=3D/tmp/crypto-build W=3D1 CC=3Dclang-14 drivers/crypto/virtio/
>   virtio_crypto_akcipher_algs.o
>
> Fixes: 59ca6c93387d ("virtio-crypto: implement RSA algorithm")
> Link: https://lore.kernel.org/all/0a194a79-e3a3-45e7-be98-83abd3e1cb7e@ro=
eck-us.net/
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

