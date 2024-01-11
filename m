Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E8EBC
	for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzWISQtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704943241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ySxIr9158TeBUa4+brfKytrmL8cNYEATrtS2LGdz8E=;
	b=OzWISQtUvYbSBYaS6V5lNc2LUTaw23oW6ukUXFRYt0LSdr7DeAAmH6og3DQK1r9PwHaZQp
	i91DODx1i0YRfNjUFZnZzkSaeiPWqXCRIlN9EkvASh6kBs4Ne8S9gQrVHKZvYABGT4Owrk
	rIh3oUO5NZpOHHpFAzjtvNiwsHBOq/8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-QWkD3d9UOIelqDUhVDn-zw-1; Wed, 10 Jan 2024 22:20:37 -0500
X-MC-Unique: QWkD3d9UOIelqDUhVDn-zw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5ce10b4cea9so3341079a12.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jan 2024 19:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704943236; x=1705548036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ySxIr9158TeBUa4+brfKytrmL8cNYEATrtS2LGdz8E=;
        b=UOSS738aqJVy8zIBmH0r6tek9rFUuq7jN6YGUiJ3RBl+7xRH3E9j7etB8uHc6uYXKi
         pctO8ou6Y/x1DgMBD4r7ie03lBrdIf6r5CdrU0O9JSYA663LCRQ5uCZ2TAlm1XvW5IMK
         Qir2s6LXF7S+yIaw0KW8ZHfsnjjmVeBFzhINohPEe7OxstEov4+cB0xz9JTqD8gxIXf7
         B6expox2VfjsGU1tCHmcXAWWqGRBRqe/I1L+5eFXu0c34nBm5jMkvElFchv7qndMQubn
         ROyuOy2gscTlEUiUcW7bQoEo69WtT44+3cTFikSKimhD3qPFTDK1aPwMjY9Y9W3SokQk
         bhRw==
X-Gm-Message-State: AOJu0YwmRwCOLKecekMHRBSvwnnCazqf0qqjEGyawOazM26Dwxq7PHi9
	CslbypsKn4vkF5PPAYyJpfjkA/8Z6FiTujgPznURpa7++RyORlcM9ZLKS2/RP5bB0L64gJwmAWX
	QKF+9VEiRYJN2n7TpfE732OMmk7CACOXCWAc9athJk6V7vZ0UwZA=
X-Received: by 2002:a05:6a21:3b4a:b0:199:f3f7:1906 with SMTP id zy10-20020a056a213b4a00b00199f3f71906mr197810pzb.4.1704943236616;
        Wed, 10 Jan 2024 19:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb//iOIGwN9CPQkZdv0a02qYPN9GCk/FREn+oyN1EysZc3rGY+TX2fdifK8FhGRGGABtZPAG7pGCnTcjuBzA4=
X-Received: by 2002:a05:6a21:3b4a:b0:199:f3f7:1906 with SMTP id
 zy10-20020a056a213b4a00b00199f3f71906mr197798pzb.4.1704943236351; Wed, 10 Jan
 2024 19:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2035137075.1083380.1704867762955.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <2035137075.1083380.1704867762955.JavaMail.zimbra@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:20:25 +0800
Message-ID: <CACGkMEvqg3cqbPDvYe3qAh2BQKNbKYim27or08WsxCAMHmYO6g@mail.gmail.com>
Subject: Re: [PATCH] driver/virtio: Add Memory Balloon Support for SEV/SEV-ES
To: Zheyun Shen <szy0127@sjtu.edu.cn>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	mst <mst@redhat.com>, david <david@redhat.com>, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:23=E2=80=AFPM Zheyun Shen <szy0127@sjtu.edu.cn> w=
rote:
>
> For now, SEV pins guest's memory to avoid swapping or
> moving ciphertext, but leading to the inhibition of
> Memory Ballooning.
>
> In Memory Ballooning, only guest's free pages will be relocated
> in balloon inflation and deflation, so the difference of plaintext
> doesn't matter to guest.

This seems only true if the page is zeroed, is this true here?

Thanks

