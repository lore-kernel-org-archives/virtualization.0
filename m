Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16789C4708E
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 15:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 877DF60EA4;
	Wed,  7 Dec 2022 15:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 877DF60EA4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mndqs8kI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id azPGwSVNly11; Wed,  7 Dec 2022 15:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3408F60E73;
	Wed,  7 Dec 2022 15:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3408F60E73
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0671FC0032;
	Wed,  7 Dec 2022 15:02:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A393C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 15:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6822C60E84
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 15:02:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6822C60E84
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZkLlmxSIQQs
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 15:02:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17AA560E73
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17AA560E73
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670425326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yAFoepezIvCP3uAHr/BFfLPVvO1u5OHDj5w9FAPQ8+I=;
 b=Mndqs8kITbAWXcMcnwXN+hog/bjx4nKEPqEZHGN5/PZQqoM26kTROE+HQbxXxCMSolQtAa
 +0BdC1B8ZG8HBNXhSCbWz3ZZimQl2GdlKq0jON4rS7JWVFtHkHftDGSZGTHVYZzfxX3xuh
 hnrm0zsxR8Onq9SngzfGzk7Qw8zKpKw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-aPLALjkANG2a1C-1aRix_g-1; Wed, 07 Dec 2022 10:01:58 -0500
X-MC-Unique: aPLALjkANG2a1C-1aRix_g-1
Received: by mail-wr1-f70.google.com with SMTP id
 x1-20020adfbb41000000b002426b33b618so2412068wrg.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 07:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAFoepezIvCP3uAHr/BFfLPVvO1u5OHDj5w9FAPQ8+I=;
 b=31J06qYAyfhhzEgqRIGJsJUPHGesipA8ZUaWX7bGL0P2DfnnU4hDoylym+Lmp6MSVd
 wI6MCU/5pJPrSkUsaJcSDco678BdcbzZP8ixya+3Jk9m9jDxYBFyFPHoykvY1UUYYJzr
 CTue2OI9Sb61yAmqriWeni8utvmTbB0r4ivQcazldr2TCQCcIDfE9tl98tM5ZctTEA81
 sKUW8sVyDsF62bVJvu19MgckkJG4zoBE6KcwO5rQqmmN7klQ36zgLfWbqX0hnpbJqY2j
 HPNgF17gmjQPJxA4ZPEQxZhdEQfBVy47ZR8JwCJkLMuV+wqaUAelK9mwSMOrBMGXIXa3
 CySw==
X-Gm-Message-State: ANoB5pm3xVx95BYBN2KNlFVUBdpha5gR1AsQLUGYs8hHPBVBq1v8xBSd
 +0wR9T78EAa4cGqrSfgtDDz6a1I+ppbkiw4LYul/Msd3+cM+GGtVkJSaAjJDvL+uJefQQnp9ERo
 s/gpj5uE+FyUKiobA6Q1U6ofi6DfTtf911HbAUvPjaw==
X-Received: by 2002:a05:6000:137a:b0:242:5b1f:3dd0 with SMTP id
 q26-20020a056000137a00b002425b1f3dd0mr10163867wrz.633.1670425317214; 
 Wed, 07 Dec 2022 07:01:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7WjIG9s5h6WW8iRE/Pz9BUs/TQH8zSEuM+9DqTqN/19T1vpGwnC7f+e6cMwuAEoG4IwzH/4A==
X-Received: by 2002:a05:6000:137a:b0:242:5b1f:3dd0 with SMTP id
 q26-20020a056000137a00b002425b1f3dd0mr10163852wrz.633.1670425316889; 
 Wed, 07 Dec 2022 07:01:56 -0800 (PST)
Received: from redhat.com ([2.52.154.114]) by smtp.gmail.com with ESMTPSA id
 e4-20020adff344000000b00236488f62d6sm20203849wrp.79.2022.12.07.07.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 07:01:56 -0800 (PST)
Date: Wed, 7 Dec 2022 10:01:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Subject: Re: [PATCH v1] drivers/vhost/vhost: fix overflow checks in
 vhost_overflow
Message-ID: <20221207100028-mutt-send-email-mst@kernel.org>
References: <20221207134631.907221-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20221207134631.907221-1-d-tatianin@yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Dec 07, 2022 at 04:46:31PM +0300, Daniil Tatianin wrote:
> The if statement would erroneously check for > ULONG_MAX, which could
> never evaluate to true. Check for equality instead.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

It can trigger on a 32 bit system. I'd also expect more analysis
of the code flow than "this can not trigger switch to a condition
that can" to accompany a patch.

> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 40097826cff0..8df706e7bc6c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -730,7 +730,7 @@ static bool log_access_ok(void __user *log_base, u64 addr, unsigned long sz)
>  /* Make sure 64 bit math will not overflow. */
>  static bool vhost_overflow(u64 uaddr, u64 size)
>  {
> -	if (uaddr > ULONG_MAX || size > ULONG_MAX)
> +	if (uaddr == ULONG_MAX || size == ULONG_MAX)
>  		return true;
>  
>  	if (!size)
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
