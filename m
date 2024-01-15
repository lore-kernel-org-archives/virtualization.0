Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58D368
	for <virtualization@lists.linux.dev>; Mon, 15 Jan 2024 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtlwTkwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705285935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Fg9eY9UXW8j8bTFXzpNU3C8NoR8z2yKeM8lVp1XLlY=;
	b=UtlwTkwmyffLlC/KSCjedxQ6cTXeTgG76f5hhFhH4L6T+t55e0wZILNmF7NUmCReG2beHI
	YCrNZZUUEVWsEMFHVhGXSFwIUBOVy0VBMVWbOc0Kkwwp4L5yVVAb1nDAn0Xbuz7b+sCAVh
	WNM8mtwNeJGtN5cXirKPg8HdAi/oZH0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-idgpHz1fNOax9VVZRXgWDg-1; Sun, 14 Jan 2024 21:32:13 -0500
X-MC-Unique: idgpHz1fNOax9VVZRXgWDg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce10b4cea9so5788099a12.1
        for <virtualization@lists.linux.dev>; Sun, 14 Jan 2024 18:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705285933; x=1705890733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Fg9eY9UXW8j8bTFXzpNU3C8NoR8z2yKeM8lVp1XLlY=;
        b=TpHH82BG79jdaD5GZXJOoDMqAjCmHHEAUubRm4yrpUeNU5oCLLRDkTrEujHnbVmDkC
         bD/xeXEbzDVGgwBlQlnWo/XyV/yPFL9IYOTr5sAllWdrvn5pYV4ITxY1NqfHfuLfWb49
         IlJDkjRcNrzyoumXZlhUxH5SM4KSmL8HAY+UNfrr6HWBXD6GSid7CAGwar0E+v0lC9vj
         eRPkAmandkO5s0eHi9hFzx4zthAnPaqHRlU8j6kueDbaNGhug7ZUrj3+lZllZHbi0hBL
         AYNMJAqdAiKyjRtxh0SuqwrmtLWt+ucg25nfNqpBE/jkA6An3b+wTsbthSvaSQT8J4AD
         scfg==
X-Gm-Message-State: AOJu0YwkJipi6ebKA0PoIzXwaZleq0YfIXML5N99f6oHkP0g8ejYvcq7
	rJSVddRltCa7LjWZ6/HVt9FgBRNGqXtKTc9LzzQ3v/MmFy+9N8k9JGbGoO5976USDy/n/ckb68C
	fqMSmbocMbbIrpVhgwluraJB+q1b7XTVFQUDFforAnF5AJdu7Cxc=
X-Received: by 2002:a05:6a20:7f8f:b0:19a:256e:3fb9 with SMTP id d15-20020a056a207f8f00b0019a256e3fb9mr6396832pzj.41.1705285932934;
        Sun, 14 Jan 2024 18:32:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9yFXRtdJCPq35hRXm8YwDq4/BupjUcwNGLaeZoIFHgPLuvW8DiRmVshA+kcM/fbrhBwvpynUdAG7aQwZqoes=
X-Received: by 2002:a05:6a20:7f8f:b0:19a:256e:3fb9 with SMTP id
 d15-20020a056a207f8f00b0019a256e3fb9mr6396824pzj.41.1705285932662; Sun, 14
 Jan 2024 18:32:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240113040947.47354-1-lirongqing@baidu.com>
In-Reply-To: <20240113040947.47354-1-lirongqing@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 10:32:01 +0800
Message-ID: <CACGkMEtS9zyYG=zBNAxMeVLAWT42WYTy4w9zwZV7PD1+B-ovyg@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: remove duplicate check if queue is broken in virtblk_done
To: Li RongQing <lirongqing@baidu.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 12:17=E2=80=AFPM Li RongQing <lirongqing@baidu.com>=
 wrote:
>
> virtqueue_enable_cb() will call virtqueue_poll() which will check if
> queue is broken at beginning, so remove the virtqueue_is_broken() call
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

