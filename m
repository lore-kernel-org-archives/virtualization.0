Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00875C64EC7
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 21:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C285A417DE;
	Tue, 28 Feb 2023 21:36:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C285A417DE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SNIo3FCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0DVFTTGYOuhZ; Tue, 28 Feb 2023 21:36:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 111014176D;
	Tue, 28 Feb 2023 21:36:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 111014176D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D76EAC0033;
	Tue, 28 Feb 2023 21:36:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 866FBC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 21:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E09C400D2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 21:36:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E09C400D2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SNIo3FCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JEhu7LTxrf9C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 21:36:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E78C400C8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E78C400C8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677620192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fr6G339eh4CzZb9wRNzdMKECxjo2Rk+TLv6cPbI33P8=;
 b=SNIo3FCAGjAJvRoLuaxJ3/RkQJ3sBqXZ3+mUk7R74WAR/wjyWRPDsfCS5UjT/xZoq7OtlM
 h3nE0xTi1hdTzWOnjGPYZuGMNC0vSX6i32oG6x9Jryxjz/CTF4vSYJEDsPxyd5+gKNdyQl
 iJj4e/PHj9gdIa/4fLhrj5o8Y126wh4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-WTEoXZy5OvWqPSrCgUnJ0w-1; Tue, 28 Feb 2023 16:36:30 -0500
X-MC-Unique: WTEoXZy5OvWqPSrCgUnJ0w-1
Received: by mail-wm1-f71.google.com with SMTP id
 j6-20020a05600c1c0600b003eaf882cb85so4725182wms.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 13:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677620189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fr6G339eh4CzZb9wRNzdMKECxjo2Rk+TLv6cPbI33P8=;
 b=6HhLrZfSSFSKPuJxDh3+fGC1nirpc/pC57B7geKOY12ZzQAsBBR3wpKpKo3rnTIf/9
 5RN+5QaZqog2DjYhqavv80csEURTCZ1MHLUrUuN34GSC5gbwq0ch/7owfXUI1mKhhU79
 BptatPhEfK7KkjIIo6BP8JSiPsYdDyMzD2ncJwtW9/KJqkdsbD73+NDH4wkTdLI0X3I1
 uvNxKXXGe5T3U7Sft9mQ2XBv6ykBeVb955qEMrXsRFCeiGxJ9Vd9TeJuYvCdkAodBDtq
 RAoIssPypQsKqU13Ncl6anR070AZdiTmR1Ev1Gx7n6ae9fa8SCkvKSYsBhPnpNJS9tTm
 Kp7Q==
X-Gm-Message-State: AO0yUKUz5P5BsC233zb5UGZBaqexXIYKi6XB30kiydG+GcBOYuW/XwyV
 4Rl2hzAvmxxhuIhonJDDsoQ9nLJxgi8rih/+uM7SXoiO/dAbowRCvZ3nf0fIFsrteOuJHGgGdRO
 kuGjtnSDaKSEldKWMNieQlzSIw+BgdpDslY5JxiZWQQ==
X-Received: by 2002:a05:600c:310c:b0:3eb:395b:8b62 with SMTP id
 g12-20020a05600c310c00b003eb395b8b62mr3713267wmo.39.1677620189703; 
 Tue, 28 Feb 2023 13:36:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9Z8lGr1yxjI9Ypmg9yFzicADc+OvbqqKFlwiu50yEmyScxxP766NN0zApqhzmUJ0CYnPz/ow==
X-Received: by 2002:a05:600c:310c:b0:3eb:395b:8b62 with SMTP id
 g12-20020a05600c310c00b003eb395b8b62mr3713241wmo.39.1677620189364; 
 Tue, 28 Feb 2023 13:36:29 -0800 (PST)
Received: from redhat.com ([2.52.141.194]) by smtp.gmail.com with ESMTPSA id
 m25-20020a7bca59000000b003db0bb81b6asm13684976wml.1.2023.02.28.13.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Feb 2023 13:36:28 -0800 (PST)
Date: Tue, 28 Feb 2023 16:36:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next v3 1/3] vsock: support sockmap
Message-ID: <20230228163518-mutt-send-email-mst@kernel.org>
References: <20230227-vsock-sockmap-upstream-v3-0-7e7f4ce623ee@bytedance.com>
 <20230227-vsock-sockmap-upstream-v3-1-7e7f4ce623ee@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230227-vsock-sockmap-upstream-v3-1-7e7f4ce623ee@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cong Wang <cong.wang@bytedance.com>, kvm@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@google.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yhs@fb.com>, Paolo Abeni <pabeni@redhat.com>,
 KP Singh <kpsingh@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Hao Luo <haoluo@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 28, 2023 at 07:04:34PM +0000, Bobby Eshleman wrote:
> @@ -1241,19 +1252,34 @@ static int vsock_dgram_connect(struct socket *sock,
>  
>  	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
>  	sock->state = SS_CONNECTED;
> +	sk->sk_state = TCP_ESTABLISHED;
>  
>  out:
>  	release_sock(sk);
>  	return err;
>  }


How is this related? Maybe add a comment to explain? Does
TCP_ESTABLISHED make sense for all types of sockets?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
