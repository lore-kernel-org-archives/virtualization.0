Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7FECE7A94
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 11:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ADF0418B4;
	Mon, 25 Sep 2023 11:24:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1ADF0418B4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=OLKk7KzH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oWj-JHfG8mpV; Mon, 25 Sep 2023 11:24:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 487CB415E5;
	Mon, 25 Sep 2023 11:24:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 487CB415E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12563C0039;
	Mon, 25 Sep 2023 11:24:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C54C7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 11:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 93B6E80C17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 11:24:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93B6E80C17
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=OLKk7KzH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4nMAbAogXSrw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 11:24:28 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 59A4080B98
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 11:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59A4080B98
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=CZlIUfCEZAaduIab/BeYk1An+kVppDAcETHyx1HtxZE=; b=OLKk7KzHiiGpF1sqjWKSHcWnBZ
 92q6oAsLH8WkTJ+FhxjcGNaRuF+h8XwsCxZhYYqda0aMpb2cL4VmSVVm/BkygQ4pqREJW/O9PEsoH
 kGpcMhAXZLjcT2iGMbS73ooDgePc0V9S2npQoXjzsW/GmDP0nW9GDTZdiPVJ1Q+Xj+IX5wXMqaCtE
 IFO648RpE+win1TFMnfxg5RDgEfDQvFgtgXf418BDPcR5oid/G6hnWo9eDcna1Wz9Bxek/r6HC7XD
 jkiltcKNHN6SeLrlkuv6M8SpYywXLT+jiqcyO63cHS7K67XKjPSzn9pbj1sVAWbU/7SkZZB0a8LC0
 WSmJI7FQ==;
Received: from [195.181.170.235] (helo=[172.31.28.226])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qkjhM-001A2F-Jx; Mon, 25 Sep 2023 11:24:20 +0000
Message-ID: <cb5e785d19a15356d85bca11bebf7975c495e948.camel@infradead.org>
Subject: Re: [PATCH] virtio_console: Annotate struct port_buffer with
 __counted_by
From: Amit Shah <amit@infradead.org>
To: Kees Cook <keescook@chromium.org>, Amit Shah <amit@kernel.org>
Date: Mon, 25 Sep 2023 13:24:19 +0200
In-Reply-To: <20230922175115.work.059-kees@kernel.org>
References: <20230922175115.work.059-kees@kernel.org>
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, 2023-09-22 at 10:51 -0700, Kees Cook wrote:
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
> ---
>  drivers/char/virtio_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 680d1ef2a217..431e9e5bf9c1 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -106,7 +106,7 @@ struct port_buffer {
>  	unsigned int sgpages;
>  
>  	/* sg is used if spages > 0. sg must be the last in is struct */
> -	struct scatterlist sg[];
> +	struct scatterlist sg[] __counted_by(sgpages);
>  };

Reviewed-by: Amit Shah <amit@kernel.org>

Greg, please pick this up.

Thanks,

		Amit
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
