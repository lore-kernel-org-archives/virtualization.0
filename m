Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924D3D6D
	for <virtualization@lists.linux.dev>; Fri,  1 Dec 2023 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTF7kSho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701408028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X88JSiziG/o7myWzNFddeB9QrNNoNgpJlb1gQar3PoQ=;
	b=hTF7kSho2PW7k/yLjqQzIZgVJ5SG6AlneOXtkZAwTWsY9Yybl6GwJ6X/r1ICGLKGEi4GFB
	1sFizwwy/MIAV0m7Ss0QzZ6svkRyvrakmJFBsnKf/XI2iifs0/T4wm90tzwYfkA1wJXipS
	i9S+EHwLi6LMEfr1nAng8jQiRGTw+FI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-O1cyV3rIMkCOUd_vIoMBwA-1; Fri, 01 Dec 2023 00:20:26 -0500
X-MC-Unique: O1cyV3rIMkCOUd_vIoMBwA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50bc4fcc347so1671322e87.2
        for <virtualization@lists.linux.dev>; Thu, 30 Nov 2023 21:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701408025; x=1702012825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X88JSiziG/o7myWzNFddeB9QrNNoNgpJlb1gQar3PoQ=;
        b=qbuDauHWAmXnsGT4TweS9VK3boLSggYx1l6GSLz5kEN4GqGQWUXdgSgZ9EnJ8M7pW/
         b0RsMW6lSjSaY4A3i01w651ztyh7deq63yO0EFcPkNsj9Qv5OI6aIOAohE6mcuf2J/8j
         RiR0dIej/MEew3KBKsOlTd6SUf9kqwrD/RSIHXlpbI2ORy5YUU1IpvXyjfYJhMZuLlHO
         +W4/IEMsJ+VOMNgjMyPFuNyYIDMMdczJ1C3QqLZoOBhLBrrRFlY9rZIncBXwMO6KHYai
         iDxGlDzIjl24DPgLXKV10ikNXAbaYtTkafjNsy2iFJU3jgmRbRnLhI07GtWtCcz2u2Ve
         Wi2A==
X-Gm-Message-State: AOJu0YzfZfOL/WfqRgOIMHGqBo2tSnbhbSbn7P2EUMsvyx6Vhh1fGpq0
	FUXfycpm7PScyN/etMlxemnlIBnwLMaDixyV9YuoLQb+ptaqx2GmmJRaMerQ9X9GQ4N4IT/NM9G
	CiDOb4Z4SCy5FOmNXYJ+ijQj1f/IY0qHf+fq80+p1n0w=
X-Received: by 2002:a19:a408:0:b0:50b:c9b6:3216 with SMTP id q8-20020a19a408000000b0050bc9b63216mr343636lfc.8.1701408025514;
        Thu, 30 Nov 2023 21:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESdjRg/qOdpcOoc9ha3XIN7XwU3jvK2LnYcltjH/CQeP85eYFX50MTqViiFNs+mh7TXHCkLsXficufvdwpKuo=
X-Received: by 2002:a19:a408:0:b0:50b:c9b6:3216 with SMTP id
 q8-20020a19a408000000b0050bc9b63216mr343629lfc.8.1701408025249; Thu, 30 Nov
 2023 21:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231130113001.29154-1-jirislaby@kernel.org>
In-Reply-To: <20231130113001.29154-1-jirislaby@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Dec 2023 13:20:14 +0800
Message-ID: <CACGkMEtc962wXcFP7kQFcyxRqqyXAF55kpZwv-tQbcCWuOHGTw@mail.gmail.com>
Subject: Re: [PATCH] tty: virtio: drop virtio_cons_early_init()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-alpha@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 7:31=E2=80=AFPM Jiri Slaby (SUSE) <jirislaby@kernel=
.org> wrote:
>
> The last user of virtio_cons_early_init() was dropped in commit
> 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport").
>
> So now, drop virtio_cons_early_init() and the logic and headers behind
> too.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: virtualization@lists.linux.dev
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

