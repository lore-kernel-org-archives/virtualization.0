Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC21F93E
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8aMa8e/"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B5E041B5B
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:33:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B5E041B5B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T8aMa8e/
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tZiMn-vOfEmD
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 09:33:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB6E341946
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:33:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB6E341946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701336818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPGqkxEHuVEp3iIXzHQC/P5fkhQe0pvoNr6L4fEyxzU=;
	b=T8aMa8e/FxjFGqV5xyQ+r6ngkt4pFc2YvHxWfAsaEU0I73PVOiKrtTV+gZE54TRLZHudVB
	iOTRWWkPEpmYWmK9fHYi+9yWrfEgl+X9VcTKgr/oA/Vdj1p+P+8Fc4bKzpYjnSjsQEI3WH
	pTRINOPGgUKoan9ZZWGwORhH2k52KAI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-aTkHHhCaNX2thy7KYilDlQ-1; Thu, 30 Nov 2023 04:33:34 -0500
X-MC-Unique: aTkHHhCaNX2thy7KYilDlQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a183a3b682eso9760866b.0
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 01:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336813; x=1701941613;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCExvHYEswKuEfeCmLnGAnokX5PwVgkIGHZN/pMhG/0=;
        b=CoYv1/4mkPd2ik4l6B5IfjWWNlyzRiNGE3BWwXlg9UmB8Xw/cgi4JWz+fwh5QT73ip
         0dQh32m0bmjUF9XA9HwvDkzoMC7RWsYw6Dv/tJiyWfwkyKO1DgcUNNQTvVkXED+uIWPQ
         Bpyk9tvvATxhcHrN8ugMeXdwDYdCM8M4g84xVYb4U+ylXSpHl6MbTBlnXpVswRG3xbnB
         gzhfdd28BIt/L4TqTxw5UgkJ1abFCOPMn2xvsmVHxR5T5sIr/NM9Gl6+CCU4tHF+pS8k
         bOhUF8m2B0KgMMtf99XpDSf1aKLnBn6lCgRGvST5Ct5ghtHS0FAnYIlQi/tg3WfLcoZ8
         UMUg==
X-Gm-Message-State: AOJu0YzorrZpchKC8h5lvJ0V6aowZZhiPFpcnWwRbMlJki9V1YllTShe
	J8NXRHaSPFK59zRpqAjCY5F5W9jkI5RU9pzZn4zbF48i9R5WjRJqH9IzokNYkjvRcBDy2z2xpOR
	D5Qw0l74n6xH6fUtu94uEmugb9/I2yOxzVC/qDhG/ZQ==
X-Received: by 2002:a17:907:390:b0:a01:b9bd:87a with SMTP id ss16-20020a170907039000b00a01b9bd087amr820672ejb.7.1701336813535;
        Thu, 30 Nov 2023 01:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP5pbMR674ut0hyknc6qi/7vtoWZqWf64ILFllSlxQGa/5LjZX7aHjzFBJZ0hRNM8lzBLUKg==
X-Received: by 2002:a17:907:390:b0:a01:b9bd:87a with SMTP id ss16-20020a170907039000b00a01b9bd087amr820654ejb.7.1701336813204;
        Thu, 30 Nov 2023 01:33:33 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-254-39.dyn.eolo.it. [146.241.254.39])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm463853ejb.150.2023.11.30.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:33:32 -0800 (PST)
Message-ID: <8d2ee27f10a7a6c9414f10e8c0155c090b5f11e3.camel@redhat.com>
Subject: Re: [PATCH net-next v5 4/4] virtio-net: support rx netdim
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: jasowang@redhat.com, mst@redhat.com, kuba@kernel.org,
 edumazet@google.com,  davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org,  horms@kernel.org,
 xuanzhuo@linux.alibaba.com, yinjun.zhang@corigine.com
Date: Thu, 30 Nov 2023 10:33:31 +0100
In-Reply-To: <12c0a070d31f29e394b78a8abb4c009274b8a88c.1701050450.git.hengqi@linux.alibaba.com>
References: <cover.1701050450.git.hengqi@linux.alibaba.com>
	 <12c0a070d31f29e394b78a8abb4c009274b8a88c.1701050450.git.hengqi@linux.alibaba.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-11-27 at 10:55 +0800, Heng Qi wrote:
> @@ -4738,11 +4881,14 @@ static void remove_vq_common(struct virtnet_info =
*vi)
>  static void virtnet_remove(struct virtio_device *vdev)
>  {
>  =09struct virtnet_info *vi =3D vdev->priv;
> +=09int i;
> =20
>  =09virtnet_cpu_notif_remove(vi);
> =20
>  =09/* Make sure no work handler is accessing the device. */
>  =09flush_work(&vi->config_work);
> +=09for (i =3D 0; i < vi->max_queue_pairs; i++)
> +=09=09cancel_work(&vi->rq[i].dim.work);

If the dim work is still running here, what prevents it from completing
after the following unregister/free netdev?

It looks like you want need to call cancel_work_sync here?

Additionally the later remove_vq_common() will needless call
cancel_work() again; possibly is better to consolidate a single (sync)
call there.

Cheers,

Paolo

