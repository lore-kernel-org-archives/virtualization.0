Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E33E9F70
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204596; cv=none; b=T70+NUilx4QACi8pJAoFHscsIL2bqb1AKCflfqIrcX9n1Burp1ipoYoAvrHb5PSf+PCIDlW+C4B+TCGBwB+yqTVlOJteBNgzshj8SGyhsmwlkXIdXbcRMqX3QnBLLDEMIv1Rg8LeUX95C4gHQc2KIN/2Rx3Py5Cp5NHhzWgcSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204596; c=relaxed/simple;
	bh=ShwI4jCjSP8+m7Os2djvrxNO/fA9bUZq/Yv5KhSFlvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=H65W2oS0ytsJCy5wDxoBEfvR2lZ1oZdNAZ2FGdBOsoPOSvShvhMey7A2z5aeSqD2tDcCOPOCQGyCJTrR7tG6rmNF660RQzKLy87i8vnkLPylAGt+vYifb6KJkwwEHQzLCkQe5Vu4orFM26JNWPmSgdJItYuqcA0SMUiAsFEVemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2YqY09F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2YqY09F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770204595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zqOiwAx1+q0FKyReAOUgZRpz2E1HnCP+W30z4rd0Qx0=;
	b=V2YqY09FtnfjqepMkYJRHTgJimMpvbyLSe9a3u4+0ksKxEwMeJbvVw2VowxA/KBZhNCb2m
	oZGQo3LDLKM1Vs7a6qhli2NQM4yYNMuzMnnuk2TCAuij8A2fHIZ7mv2XREwrh9VGSz6QLN
	Cd+kG9PzVqaIGzXdPJilNLT10SjG0dQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-4dkb687lPma3p4w_18Yk5A-1; Wed, 04 Feb 2026 06:29:53 -0500
X-MC-Unique: 4dkb687lPma3p4w_18Yk5A-1
X-Mimecast-MFC-AGG-ID: 4dkb687lPma3p4w_18Yk5A_1770204593
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435af2d3144so4474022f8f.3
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 03:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770204593; x=1770809393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqOiwAx1+q0FKyReAOUgZRpz2E1HnCP+W30z4rd0Qx0=;
        b=GyR9ZXdvPzkrsZ84YcwnlUxDvS3juTqJN1w9VOEzeUbJoo9bfWvFzOYRvcOIcAWYrE
         KXjgAJUJ2VTqaAnPeOLb2sePL6hA5vinR7dVLCAWkDmuAuxhSAfUIMh8bKTku2XaOrrA
         wk/I1o0UNQPjcKvp8g9nr0eg+CtFwlol5UIU4fk+NUd/v8ZWGAunZ/ndouFPDpvDZjJz
         xblWaeMh6VNEwlqM7x0N8p/R1KQIv8EtXUczCtOewU0VeY+tXWvmqGIg1KkLq8cJYPXT
         VYWkYCwuj2jzNdh+YdT+MtcofeowlRH+tnQgY8ohrS4uxn2uknXhjARq3BVYFjvRA/UY
         C37w==
X-Forwarded-Encrypted: i=1; AJvYcCVnSOS1aRuBVxe7hBQNjB++1tbzk0Op2JRxL359n2puQJMo19NZlHeOEecyHck7gnBkSwbHyJgjVie9iZdlJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXczDOeXD1nlR3EMF74XRzWi5m2BymRItn7joLbntbb4S4eadl
	lxMbuScnUJz0pUAHErYE3wZH5U0qjWKoddbAvuYOPDzULo/2I8XOh1qJQb5ICVxxvNNCX8e6uLR
	9z7e58Qi8cQsSN5cP4fyGnaee1TEszOtjI80YgZH+C17/Epytvm5G12Eh7I4evSuNoA0T
X-Gm-Gg: AZuq6aLg/KSmz594kYNmWK5nmealPCFzzVLIUXEyWePG6sXeBUSuF4Llm0IKoDRmNm3
	dm7r0hnKKyAaf30dpilfa0sq1AUmW8u/2EYlV1z1nhq+AignUUf6i0OIQB9Ch3NVH79XmNRGuas
	t1N7FSVp7CqyQ56+iKa8p/TqUMjMY3Sl0e5/qOqHO5s1bAaN52hbNBRrS8D7ICmMLYaZhZfGYIz
	HaoHU8oUqDjhKfNdygyra7pb41mf+dNrIn986PFeF0zzpTpmCYAAkEptKtddK2Gw/d/62JquuXG
	Nx+DBMmdVoyYxQcXkGu6Khu6Stq4pSs1PCx03sgUedwRwPlQCu71Sg5fBRhQbpVQSrR9Kdd0LJZ
	q1ZEBWSnBqkqD/iy6KFehpKPSkf3i/UL+mYn0s2SStHh9yzNtYv6hCyUnlTo=
X-Received: by 2002:a5d:4573:0:b0:436:1989:46b7 with SMTP id ffacd0b85a97d-436198946c7mr2085565f8f.15.1770204592619;
        Wed, 04 Feb 2026 03:29:52 -0800 (PST)
X-Received: by 2002:a5d:4573:0:b0:436:1989:46b7 with SMTP id ffacd0b85a97d-436198946c7mr2085507f8f.15.1770204592143;
        Wed, 04 Feb 2026 03:29:52 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f87sm6371139f8f.21.2026.02.04.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:29:51 -0800 (PST)
Date: Wed, 4 Feb 2026 12:29:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Simon Horman <horms@kernel.org>, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with
 gcc-16
Message-ID: <aYMqw2HbtKi50b1e@sgarzare-redhat>
References: <20260203163406.2636463-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260203163406.2636463-1-arnd@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qvSK3_jXVfVVWk9pEyDrcVXSP2FPdwqaweOUZ6TiWwo_1770204593
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Feb 03, 2026 at 05:34:00PM +0100, Arnd Bergmann wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>The gcc-16.0.1 snapshot produces a false-positive warning that turns
>into a build failure with CONFIG_WERROR:
>
>In file included from arch/x86/include/asm/string.h:6,
>                 from net/vmw_vsock/vmci_transport.c:10:
>In function 'vmci_transport_packet_init',
>    inlined from '__vmci_transport_send_control_pkt.constprop' at net/vmw_vsock/vmci_transport.c:198:2:
>arch/x86/include/asm/string_32.h:150:25: error: argument 2 null where non-null expected because argument 3 is nonzero [-Werror=nonnull]
>  150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>  164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>      |                 ^~~~~~
>arch/x86/include/asm/string_32.h:150:25: note: in a call to built-in function '__builtin_memcpy'
>net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>  164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>      |                 ^~~~~~
>
>This seems relatively harmless, and it so far the only instance of this
>warning I have found. The __vmci_transport_send_control_pkt function
>is called either with wait=NULL or with one of the type values that
>pass 'wait' into memcpy() here, but not from the same caller.
>
>Replacing the memcpy with a struct assignment is otherwise the same
>but avoids the warning.
>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> net/vmw_vsock/vmci_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Not sure if it's net or net-next material, maybe net to avoid the 
warning/error on v6.19 too ?

Anyway LGTM and thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 00f6bbdb035a..a64522be1bad 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -161,7 +161,7 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
>
> 	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_READ:
> 	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_WRITE:
>-		memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>+		pkt->u.wait = *wait;
> 		break;
>
> 	case VMCI_TRANSPORT_PACKET_TYPE_REQUEST2:
>-- 
>2.39.5
>

