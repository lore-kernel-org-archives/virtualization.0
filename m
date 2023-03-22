Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71EDC6FD1C
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 16:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C021417DF;
	Wed, 22 Mar 2023 16:29:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C021417DF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IJTKhSGH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Xh4J2EshAPG; Wed, 22 Mar 2023 16:29:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AE0A8401F3;
	Wed, 22 Mar 2023 16:29:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE0A8401F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 822DEC0071;
	Wed, 22 Mar 2023 16:29:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C32FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 080406147D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:29:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 080406147D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IJTKhSGH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9sdQZJabGGjY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C4A16068F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C4A16068F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679502579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4co9urht5Jz8vflH9r+hMUVr864YiUEsCYrVDvmygMc=;
 b=IJTKhSGHmaJQ+L40rNKmbr/7XSg+GDVT4ZrMUV03ZR+1MVbavP428JnwKsbuhhqtIt27rm
 tUMfTtGUcFTNhTKiZF1pcw4BqCuafSYwMPmQ4XkV4FzCsZ1h6U77RpU4OcmcmccNlYJZCq
 RxDqkmG4wteunWwv9rDEp/EDP6shNUs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-j9YcFYmXPIWNl9otNGsoQw-1; Wed, 22 Mar 2023 12:29:37 -0400
X-MC-Unique: j9YcFYmXPIWNl9otNGsoQw-1
Received: by mail-ed1-f69.google.com with SMTP id
 y24-20020aa7ccd8000000b004be3955a42eso28332692edt.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 09:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679502576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4co9urht5Jz8vflH9r+hMUVr864YiUEsCYrVDvmygMc=;
 b=TMG1R/d21pDYf42YXnaN/73xISSuocr75CI/qxgEieEQPT/+C1xmIcPGVEGE8lW/Rn
 FkK1c6RBHuxTMKyNZ0TqyL/7zrOPBNF3xt1/SQpAbpA8ksMEvmU8WYRfkdXiTwqWoZlr
 PQiqMNq21eqlik4AiWuwUqRODYG1PDWXxQjBSgEOPMJC/mRAXUEG+j8Jq9kX9c3kqWw1
 OcNjkNNDZzv7pyscFU1hjCWbYYIFVy/AFau9yGxDrK50XIuk2IZFpsM8j/Z7b5RcYgPT
 MTIiKLec573w+mGpQc1l/+oZ1CoxQrr3yQcJdRw5kEozW8INN6tQlmvFfeC4ZAWH6HhR
 uwBQ==
X-Gm-Message-State: AO0yUKU7wWbwFj3WcRsMf7C4FiZZOXvRzr5cL02pCX0lu48p0g6Mk/s6
 WBYwwtxcZJ6BG9MHbD3d1y68Gekuu8kEQFZf+26XxfUhQzcS4YNtqLQGQSbOzk0WMehPPJ7oCu0
 4WrGxQCa4tAB2tpNmjJ9zovcaz0HWNQO49+vNvkOubA==
X-Received: by 2002:a05:6402:104b:b0:500:2cac:332c with SMTP id
 e11-20020a056402104b00b005002cac332cmr6624524edu.25.1679502576360; 
 Wed, 22 Mar 2023 09:29:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set8u2RK5fI05lgRdtt4jEAs/A+jF7kGyrDaTZ/+2ngyMsnuzSivl/5iu9W4gc21psUfOwvCj1Q==
X-Received: by 2002:a05:6402:104b:b0:500:2cac:332c with SMTP id
 e11-20020a056402104b00b005002cac332cmr6624507edu.25.1679502576005; 
 Wed, 22 Mar 2023 09:29:36 -0700 (PDT)
Received: from redhat.com ([2.52.143.71]) by smtp.gmail.com with ESMTPSA id
 t21-20020a50d715000000b004af7191fe35sm7970134edi.22.2023.03.22.09.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Mar 2023 09:29:35 -0700 (PDT)
Date: Wed, 22 Mar 2023 12:29:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH] tools/virtio: fix build break for aarch64
Message-ID: <20230322121905-mutt-send-email-mst@kernel.org>
References: <20230322075945.3039857-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
In-Reply-To: <20230322075945.3039857-1-peng.fan@oss.nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mie@igel.co.jp
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

On Wed, Mar 22, 2023 at 03:59:45PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> "-mfunction-return=thunk -mindirect-branch-register" are only valid
> for x86. So introduce compiler operation check to avoid such issues
> 
> Fixes: 0d0ed4006127 ("tools/virtio: enable to build with retpoline")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  tools/virtio/Makefile | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 7b7139d97d74..1a9e1be52e4f 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -4,7 +4,26 @@ test: virtio_test vringh_test
>  virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
>  
> -CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
> +TMPOUT = .tmp_$$$$

if you are going to do this pls use mktemp.
But I don't see why not just use -o /dev/null

> +try-run = $(shell set -e;		\
> +	TMP=$(TMPOUT)/tmp;		\
> +	trap "rm -rf $(TMPOUT)" EXIT;	\
> +	mkdir -p $(TMPOUT);		\
> +	if ($(1)) >/dev/null 2>&1;	\
> +	then echo "$(2)";		\
> +	else echo "$(3)";		\
> +	fi)
> +
> +__cc-option = $(call try-run,\
> +	$(1) -Werror $(2) -c -x c /dev/null -o "$$TMP",$(2),)
> +cc-option = $(call __cc-option, $(CC),$(1))
> +
> +CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
> +
> +CFLAGS += $(call cc-option,-mfunction-return=thunk)
> +CFLAGS += $(call cc-option,-fcf-protection=none)
> +CFLAGS += $(call cc-option,-mindirect-branch-register)
> +

As far as I can tell this will do the dance with the empty input
each time CFLAGS is evaluated.

Which seems unnecessarily baroque - just use ":=" and it will
be evaluated once.


>  CFLAGS += -pthread
>  LDFLAGS += -pthread
>  vpath %.c ../../drivers/virtio ../../drivers/vhost
> -- 
> 2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
