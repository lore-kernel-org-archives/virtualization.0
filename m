Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311D1C433FE
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 13:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 86C6340A1E;
	Tue, 15 Mar 2022 13:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lLwk5uPFTJ8I; Tue, 15 Mar 2022 13:28:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1FAE40A19;
	Tue, 15 Mar 2022 13:28:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2166EC0012;
	Tue, 15 Mar 2022 13:28:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2248C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 13:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B4728142B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 13:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JvTV3whDaHEX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 13:28:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D67E281420
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647350923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iPwMDqoeq62hMQvUW+d6m4fa4n/Ezhwwm7xT9axVhHI=;
 b=J0zWCN56MPLv4yWFJ6Ei4g1Kt1gC9VCRndxeP8ZLhCNT+s1R/vltZuKmYyK8xPKWdVS22s
 Vt0uUFIBScU2Qr/9z1L58jeond2sOy5a4iOMsXBnfAeWj6196jlgI8bnRhQLf+Rq7f2d/0
 IYF6vizxSZIDNzEWsUSSTFMqE2bJB60=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-t__ui_bDNnaSJt_WmjVtZw-1; Tue, 15 Mar 2022 09:28:42 -0400
X-MC-Unique: t__ui_bDNnaSJt_WmjVtZw-1
Received: by mail-wr1-f70.google.com with SMTP id
 o9-20020adfca09000000b001ea79f7edf8so5287029wrh.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 06:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iPwMDqoeq62hMQvUW+d6m4fa4n/Ezhwwm7xT9axVhHI=;
 b=ql+ypKqRzFZYanpqbWxGBHKtgxAyvC4rdGb31nDY+Kki84cXgxfmsu9RX/+kkipPwq
 XeVgM5souMBBY37ZemaWAeuHd9LSGviIJ3DLpd9r1kjt8upjteutljsNoGToxRhdFJVO
 KUezl9V9k9nQXDwgqAm8O1TxmwhwqWnahkmT585+434SC9YSizOwrVt2LesVD3gz3Hrt
 mFiIGTTpOV1mi4qbCZM+s/O7YLcmEGGMxCZPM2PiR90EjMN7c1H7qgTxKlH+m8RYs9RY
 un9QLEiSr5lzt4p5TxjCiemBfGZLNEgdeMZdiAUiJxQYZZRaLwIeSe/N6M3+hI+TcSft
 +Exw==
X-Gm-Message-State: AOAM530i0eGmne98EraEDJz5liegEiGiBMCxSlx/Jz18eu6ESnvmYGZ3
 FbaLMldQBQdAP94yVUNyL9NX11Iy1ySo+F/ti6FzVQGULAsURglsBQusRbPcmWcdC+cAL6OmDJF
 8241FLjZXgii8GyME96I59C/+r0ox2HZ9sm6leMQU2Q==
X-Received: by 2002:a05:6000:2c4:b0:203:72c9:ef37 with SMTP id
 o4-20020a05600002c400b0020372c9ef37mr19554490wry.387.1647350921396; 
 Tue, 15 Mar 2022 06:28:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynwrsQrU6Igmjz50LudSk6gmIi09KRWpQylByny5QYQEzWyoMegsicYMO/z5ro86kUgXM4yw==
X-Received: by 2002:a05:6000:2c4:b0:203:72c9:ef37 with SMTP id
 o4-20020a05600002c400b0020372c9ef37mr19554472wry.387.1647350921151; 
 Tue, 15 Mar 2022 06:28:41 -0700 (PDT)
Received: from redhat.com ([2.53.2.35]) by smtp.gmail.com with ESMTPSA id
 s2-20020a1cf202000000b0038977146b28sm2283136wmc.18.2022.03.15.06.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 06:28:40 -0700 (PDT)
Date: Tue, 15 Mar 2022 09:28:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: trix@redhat.com
Subject: Re: [PATCH] vDPA/ifcvf: match pointer check to use
Message-ID: <20220315092656-mutt-send-email-mst@kernel.org>
References: <20220315124130.1710030-1-trix@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220315124130.1710030-1-trix@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: llvm@lists.linux.dev, ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, nathan@kernel.org,
 xieyongji@bytedance.com, lingshan.zhu@intel.com
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

On Tue, Mar 15, 2022 at 05:41:30AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issue
> ifcvf_main.c:49:4: warning: Called function
>   pointer is null (null dereference)
>   vf->vring->cb.callback(vring->cb.private);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The check
>   vring = &vf->vring[i];
>   if (vring->cb.callback)
> 
> Does not match the use.  Change dereference so they match.
> 
> Fixes: 79333575b8bd ("vDPA/ifcvf: implement shared IRQ feature")

Thanks a lot! I squashed this into the offending patch - no point in
breaking bisect. Pushed to linux. However I'm now
having second thoughts about applying that patchset - I'd like
soma analysis explaining how this got through testing.

> Signed-off-by: Tom Rix <trix@redhat.com>

> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 3b48e717e89f7..4366320fb68d3 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -46,7 +46,7 @@ static irqreturn_t ifcvf_vqs_reused_intr_handler(int irq, void *arg)
>  	for (i = 0; i < vf->nr_vring; i++) {
>  		vring = &vf->vring[i];
>  		if (vring->cb.callback)
> -			vf->vring->cb.callback(vring->cb.private);
> +			vring->cb.callback(vring->cb.private);
>  	}
>  
>  	return IRQ_HANDLED;
> -- 
> 2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
