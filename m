Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30BDCE7A88
	for <virtualization@archiver.kernel.org>; Sat, 23 Sep 2023 17:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C1EE81F8F;
	Sat, 23 Sep 2023 17:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C1EE81F8F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=hiUjETCW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yJ34jf5vWLsB; Sat, 23 Sep 2023 17:41:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9FDF781E6C;
	Sat, 23 Sep 2023 17:41:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FDF781E6C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78485C0039;
	Sat, 23 Sep 2023 17:41:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF691C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Sep 2023 17:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C378281F8C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Sep 2023 17:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C378281F8C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ADnxcSXLbiQ9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Sep 2023 17:41:38 +0000 (UTC)
Received: from omta040.useast.a.cloudfilter.net
 (omta040.useast.a.cloudfilter.net [44.202.169.39])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B246781E6C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Sep 2023 17:41:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B246781E6C
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
 by cmsmtp with ESMTP
 id jx8cqAQgDyYOwk6dNq1yKd; Sat, 23 Sep 2023 17:41:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with ESMTPS
 id k6dMq8RlJZb7Mk6dNq6DPN; Sat, 23 Sep 2023 17:41:37 +0000
X-Authority-Analysis: v=2.4 cv=Z57/oVdA c=1 sm=1 tr=0 ts=650f2351
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=Z4Rwk6OoAAAA:8 a=cm27Pg_UAAAA:8
 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=HkZW87K1Qel5hWWM3VKY:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=++nWpQa97CCPvpYPRMBMXBNuReyoQn5UM5gamZgvfKA=; b=hiUjETCWBnOvOBAmo4j3aqv+Az
 ZC2FHST4P/vjIZumiA51c46rgJUfR+nRKsNwKFeI/lwVUQ5WqVx8lexT8dkGMekA5zYY/9tbtElmu
 hnzc+lmCnVnUJjsNSjXCf1WwxI0UvKM0BzB5J/rXMngV8aJ0nY9afKCx+hwpQyHJjvTE32FzqRzAU
 Lz4MwLXUiCdMbv4JH5fr77qx2KoND8icMOPR4RIyarRB+tCqhmDRB39Dq/V0wG3pYh/G6jLVwDzq1
 u/+9Ks0lDFOI/2NtflfA99I7gIlUDAyjOUdtlMzASf8DpOf9OBtI0vXgHlzujEkQESaIzyKUY5H7o
 TRUwiQnQ==;
Received: from [94.239.20.48] (port=38088 helo=[192.168.1.98])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <gustavo@embeddedor.com>) id 1qjy2r-003aT7-0v;
 Sat, 23 Sep 2023 03:31:21 -0500
Message-ID: <e76a0e1a-3afd-d77c-c716-edd285506fe5@embeddedor.com>
Date: Sat, 23 Sep 2023 10:32:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] virtio_console: Annotate struct port_buffer with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Amit Shah <amit@kernel.org>
References: <20230922175115.work.059-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175115.work.059-kees@kernel.org>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.linux-foundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjy2r-003aT7-0v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:38088
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP6uq1e0NSd9/g8l5UDJlWHHl4MhSk5cCtsWHaSuppsOmo8ZrwsjiH+sTcFl/y5CHjOgsLrJhcEJ6xwTjI3tbuW65idChJgLkmXjUQGmgu6ov9UajIaI
 B2bF0PvnTzJahm6Zpp8raAxjSN+T1qVpcp/WRj8Dc+jIeqPq8l9vXAkvbaRVf1JicBBZ12HcEpISCSiAFGRuUp4Oj6DhT2CijG4KDEtWHeFpejnscKtEMC2z
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org,
 Tom Rix <trix@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 9/22/23 11:51, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct port_buffer.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/char/virtio_console.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 680d1ef2a217..431e9e5bf9c1 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -106,7 +106,7 @@ struct port_buffer {
>   	unsigned int sgpages;
>   
>   	/* sg is used if spages > 0. sg must be the last in is struct */
> -	struct scatterlist sg[];
> +	struct scatterlist sg[] __counted_by(sgpages);
>   };
>   
>   /*
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
