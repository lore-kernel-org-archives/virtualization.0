Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231A17C61
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171154; cv=none; b=jh23dIrhYuBcsak27kkuBBJnaNBwykK+Ku3MsYMMWhL5vLJ/GuKHqgcFiVh4gmv6hbl7J4Tc6+RnAprFLq/ytm4wj4kQglR6YsG148SAgOG4O5x7U1/C6ZHuLJI1lMuvKNNRtaOhHPXyTO2QjrwdQlBY4diqrXTaSi136Rq4I/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171154; c=relaxed/simple;
	bh=9iZDsOrwFbNhFUiQrCQV8ZvnDuL4DsA+Z6fFe12B2C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n/a8w7ODfeik3FMZ3gPLlMdcwwCx5+xajRg+qSDoqAZ5Da4vkavLDOBemIGPB114sH77Efk5BtghhTcKp7/UPypPZtFv1mP+a96HWeRYbJrN0SNPVvpOSgSHzuZHb+udPsk4ctF2tNEJlJHJ6xvgetMHScwK3Q3qYEYQpOXoErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJULUgE4; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJULUgE4"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5AE7642EF6
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:25:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AE7642EF6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EJULUgE4
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y5v3QN3PpXAP
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 08:25:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5CF3B400C6
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CF3B400C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706171150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yorbOu4W949PDf1wJwUQ2ZcnYgGGHn5INiZOwEc64I=;
	b=EJULUgE4YgEr5HfC6r02tYnByMq90Xyd3Q6RhzRB7foFrHIRv6OlJqGGOkMwL7Q2kgqWoe
	dElvEQ1bUtBaUoNmIHpcf/9MHgk6sUDhqBQvwG+cLV+u01651Z1WP2MdtNfrJFq7mLiFB1
	CnU4bYSUXrTuhBUm7bJwNQhlYeFkDjs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-xAytskjnO-yvPkAc6us3IA-1; Thu, 25 Jan 2024 03:25:48 -0500
X-MC-Unique: xAytskjnO-yvPkAc6us3IA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2d1e1fa245so282834966b.2
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 00:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171147; x=1706775947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yorbOu4W949PDf1wJwUQ2ZcnYgGGHn5INiZOwEc64I=;
        b=dwC67pyjUccqoN50ryKdsGnSmNK6Z9UJl1Y7tAweAlNtnARWKKddzzprrKcK7txtoy
         OEqgpyORRI7k1qu5iAzBUSSP6Cazdfv10CI4Ls8uftQAhL82N3SV4F2HKI3YSiR96iQ9
         yKEAKNSeEe7zflegqCt2dI4csrEA26Zv7pZ3VMEfSpL96lH9p84xKXfaZOadIqnJvgjF
         F/lLQkr9IhGl+3zklNL5yV4XdKvrAOoxzlEwKXPHQhP+0cRXyGzBp+hg9P+RqBM50uGk
         1hVk+7Sd8aFUqL/zi+7OTJR+rnby3jp3LMhAsXOR/6ktIzQfl8QsiO9+ypl9VOaOLjSg
         5qCw==
X-Gm-Message-State: AOJu0YwSWDX8MnM313cqoNxy1GWO0u+jDgiEZi/yiqlNU5xhgKV7mo1x
	rC4saHtguDzy6x2/ihV9U1IA1gI/8kJvDe0llbB9aodxNDXWBGKvo0j9KdJ1eg4jF5Zj8gR1Pss
	rIZJKi8rNobqHaniDeCq3M6Vnrf0Nwvg5rTwsB1YLQ9nUPE6ZamA2avsVKtpSyzG0qSk4lqsq/E
	ZgPDY=
X-Received: by 2002:a17:906:194a:b0:a23:5672:735 with SMTP id b10-20020a170906194a00b00a2356720735mr200639eje.290.1706171147584;
        Thu, 25 Jan 2024 00:25:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtAmXQ4VLJ33gfVHQUvreFWKCVhdbCgy8sC+T+BXXLfj7avWyKayxGoOmLBlfAtzRcbKl+LA==
X-Received: by 2002:a17:906:194a:b0:a23:5672:735 with SMTP id b10-20020a170906194a00b00a2356720735mr200626eje.290.1706171147221;
        Thu, 25 Jan 2024 00:25:47 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-71.business.telecomitalia.it. [87.12.25.71])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a3177f658afsm411613ejc.206.2024.01.25.00.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:25:45 -0800 (PST)
Date: Thu, 25 Jan 2024 09:25:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1] vsock/test: print type for SOCK_SEQPACKET
Message-ID: <nsnvxue53rbvtyxwcouebcev6uk7izz62htxyqrngpfvl26qs2@jubx6oacqcck>
References: <20240124193255.3417803-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240124193255.3417803-1-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 24, 2024 at 10:32:55PM +0300, Arseniy Krasnov wrote:
>SOCK_SEQPACKET is supported for virtio transport, so do not interpret
>such type of socket as unknown.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> tools/testing/vsock/vsock_diag_test.c | 2 ++
> 1 file changed, 2 insertions(+)

Yeah, LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_diag_test.c b/tools/testing/vsock/vsock_diag_test.c
>index 5e6049226b77..17aeba7cbd14 100644
>--- a/tools/testing/vsock/vsock_diag_test.c
>+++ b/tools/testing/vsock/vsock_diag_test.c
>@@ -39,6 +39,8 @@ static const char *sock_type_str(int type)
> 		return "DGRAM";
> 	case SOCK_STREAM:
> 		return "STREAM";
>+	case SOCK_SEQPACKET:
>+		return "SEQPACKET";
> 	default:
> 		return "INVALID TYPE";
> 	}
>-- 
>2.25.1
>

