Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5D17D2
	for <virtualization@lists.linux.dev>; Fri, 11 Apr 2025 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367562; cv=none; b=N+RCCz3iHIq6d1FwP9qoyNu8yyQmDqnxwooM/hYk0e7f1WKWtiG0nBfL6yzhWROVJmDcT781UTFcwYDdRTP1PsZZOZSIvGXWj7NoynPyLz27RBe5l1uW1HQ5vphXFbEaJ4ojX0iRyA0YRYYwpmwJCy1d//wQppiJnAlva+R+80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367562; c=relaxed/simple;
	bh=dZAp+0aFkf7MK8MICOzGUOv26hrZwzczT8o2iMxm/5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NTk5oxlquXQRcIEG5/Hak6u5uj9qq6JVCLJbCJnJaJxtwT/bLr5zX06Tc2f8x8rj0hIVJwnvjRgo2gcZOaUXg+S0vQ4dkxaJ20qim1e5uwInGBVysOeQSQpoyZVKtQviUpWIK+jrrbWSnV5ODRdlCd+Rx/QWXqm8zrjMErA9uno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hU5nJAaI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU5nJAaI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744367559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Y+9d61eT9fS3Nx5t35n8P/kCjRV2k1+1b7KNobnOYs=;
	b=hU5nJAaIQaJNWI75mBI1kKDJRG2IS8FVrAiZ+2OHFVY/XMZUJYcoyPwpwgibeaG3LlwPER
	V6LG++kTMiuUJjWjPZMK6B/HYxUCqxpcaCwMsPeYibiGv5fkYlquTRA20Gvs+0SeBNv9V2
	hLWo3NHmGZ+lNIW6Q2Jo6J12FcfhgEE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-X5Y-nB8CMXKNDWBRqF-9yQ-1; Fri, 11 Apr 2025 06:32:38 -0400
X-MC-Unique: X5Y-nB8CMXKNDWBRqF-9yQ-1
X-Mimecast-MFC-AGG-ID: X5Y-nB8CMXKNDWBRqF-9yQ_1744367557
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e636b06d34so1964112a12.1
        for <virtualization@lists.linux.dev>; Fri, 11 Apr 2025 03:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744367557; x=1744972357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y+9d61eT9fS3Nx5t35n8P/kCjRV2k1+1b7KNobnOYs=;
        b=dbdr4WOj4u5W4vhfEdnVSwdNdz3dfXVtmV8PdxrxOcDnl1FZcTUViGLo/gDEySl8dB
         Po8y21wxkW0C+1fD2ap8B9XmLASX8dNJvRc/cd13yh40CH5E0+H29LtQWMPh0sjAta2s
         B7pJDWo6/cyytFlnuOC0NNDIw6oDG1cpVIENTcRnHLLQ2OTJlc4t3JmRaET4tWExFZ5H
         rFJ1qJ/i4gcgRqVii9n0uDL2xkxLpZmBsbLt3sw+E1u1GCV7dbrTTWXJtVTccIX4Mzhc
         NQoskOcuixYnRD7N+SQ3yL5N7q94HjABx1tSJ5npiPtzxmqwHOUp9iGrAioNugVB/CRG
         ztVA==
X-Forwarded-Encrypted: i=1; AJvYcCUyod7R6qcs5VoGkLNmYC7Yl0THrjkb0M7rWAZzy8f31eju+gzXrUo/9SIVwQiMXMonlEpYnotUt9QqhDQ4pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcApTf1JbcpAzTxr0qu+jRvtIzY5rjtI/upBuUT3hB3Ykrx+AN
	+8hrKD3oS+cYUlef5RmRMoOLG8EfV3SeKE8K9fuYOasYYPgglYlbHaxhi7sZ9KqbDRNkXZtPqip
	C1whsCbt/VV5S9wIkA6Vcv+wrayA+66S7H+8bU7VYyqn093wGpIrOcMok1clIqNw0
X-Gm-Gg: ASbGnctwZVpmUy0ltDeKD+O+ZM0IpLg42T34u5Yi36izXJsshWImkbx9LcPdep65A5B
	RMFBetiHasKB3D4wWJ5GrVie4dCQjVpjPKCrvarFjCoz3OKX8cFP6zdoXwjDUcNqpuQ9JM97CzQ
	ya7KK7l9oVgUMGMGu5r+TWmQfT/GWRvUeSII65Y78s1M/ItmAEDbO22rXLGopi6GFiViA66pmcq
	zS229h3S7mUqA8s3zxCDHSBFagADdUyH3c1Mins9HCVUs34B1xkEpxVRmD6rShd4I/lno6bde0W
	3+7bKVS3jMoU6R5zfrDwg8EmrWZEQISjPrdS6Y8bJrjd004vFCZfWseLWp0K
X-Received: by 2002:a05:6402:5106:b0:5ec:cd52:27c9 with SMTP id 4fb4d7f45d1cf-5f370298d8dmr1508113a12.31.1744367557235;
        Fri, 11 Apr 2025 03:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+YAD1Ckz71pvCMRdEbnpWp0EQ9xGd4Ocngq4UiSw7duGE/YHv0R0ZgCt/NsMlKk+AEHR8Kw==
X-Received: by 2002:a05:6402:5106:b0:5ec:cd52:27c9 with SMTP id 4fb4d7f45d1cf-5f370298d8dmr1508083a12.31.1744367556669;
        Fri, 11 Apr 2025 03:32:36 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54e11sm789475a12.2.2025.04.11.03.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:32:36 -0700 (PDT)
Date: Fri, 11 Apr 2025 12:32:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] vsock: Linger on unsent data
Message-ID: <hu4kfdobwdhrvlm5egbbfzxjiyi6q32666hpdinywi2fd5kl5j@36dvktqp753a>
References: <20250407-vsock-linger-v1-0-1458038e3492@rbox.co>
 <20250407-vsock-linger-v1-1-1458038e3492@rbox.co>
 <22ad09e7-f2b3-48c3-9a6b-8a7b9fd935fe@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <22ad09e7-f2b3-48c3-9a6b-8a7b9fd935fe@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EK6yCX3_9Z2HucZC6sgwABcBDvej_eqK3Ru2ANIy8oY_1744367557
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Apr 10, 2025 at 12:51:48PM +0200, Paolo Abeni wrote:
>On 4/7/25 8:41 PM, Michal Luczaj wrote:
>> Change the behaviour of a lingering close(): instead of waiting for all
>> data to be consumed, block until data is considered sent, i.e. until worker
>> picks the packets and decrements virtio_vsock_sock::bytes_unsent down to 0.
>
>I think it should be better to expand the commit message explaining the
>rationale.
>
>> Do linger on shutdown() just as well.
>
>Why? Generally speaking shutdown() is not supposed to block. I think you
>should omit this part.

I thought the same, but discussing with Michal we discovered this on
socket(7) man page:

   SO_LINGER
          Sets or gets the SO_LINGER option.  The argument is a
          linger structure.

              struct linger {
                  int l_onoff;    /* linger active */
                  int l_linger;   /* how many seconds to linger for */
              };

          When enabled, a close(2) or shutdown(2) will not return
          until all queued messages for the socket have been
          successfully sent or the linger timeout has been reached.
          Otherwise, the call returns immediately and the closing is
          done in the background.  When the socket is closed as part
          of exit(2), it always lingers in the background.

In AF_VSOCK we supported SO_LINGER only on close(), but it seems that 
shutdown must also do it from the manpage.

Thanks,
Stefano

