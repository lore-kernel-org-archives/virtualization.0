Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37E7C19F2D
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 636C240951;
	Thu, 11 Aug 2022 08:11:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 636C240951
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBoekunN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D6ZHacN03KGv; Thu, 11 Aug 2022 08:11:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D1D1D415C9;
	Thu, 11 Aug 2022 08:11:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1D1D415C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91102C0033;
	Thu, 11 Aug 2022 08:11:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 990DAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FE5560E64
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FE5560E64
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBoekunN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oa1rFT529tpS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:11:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A03C560D58
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A03C560D58
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660205490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=88brHzPZ6c8Q6vxkn2ZMmOq0N/l0h2/0PF0qkGV+51Y=;
 b=HBoekunNh6JxV+RO7F7SoMMa01HCG1VQv3lWI+uO5eES07xTDSVcRPA88rIYCy6VTr9yfK
 1WXFc+bG3WmGp2UsP83epEoaVjk2pvHFHXc0OAIncAfGduJffCZVDod3Oi/YZmGYm4q6e2
 dbLGQeIe6iSfn+W635MYzDfd3q89z6E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-XVot4-KYM2-IDjelZdrOaQ-1; Thu, 11 Aug 2022 04:11:28 -0400
X-MC-Unique: XVot4-KYM2-IDjelZdrOaQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 c189-20020a1c35c6000000b003a4bfb16d86so8398819wma.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=88brHzPZ6c8Q6vxkn2ZMmOq0N/l0h2/0PF0qkGV+51Y=;
 b=l7Et0Bs5BAl+UD7SWihSHv5wCdxyuEOneikpwKUIVEahav5nbRQBCNl5dvdLcaFIy6
 3KtwQ1YLl8dmlAY94SarZk4vwukn+Z0BOSLyLqaEBGRnOte5YYWZNfynXEHpYT59Ibdg
 cvb1xIrdIDGD8mdiJgzK6gIThiNEvfvekeNBUu8+wzeb0N/Kd+7fL+AEbCGE1Tko6aac
 tyAVYOSUFGtU+4zX7JHH4wT9SvMu3PrR4BHEVcfrIioR2dF7FP+j0bO8Wep2jxWtihsr
 jjqZC1hKPwzqLlo1SeJMHCjv2JKwP8lvEKBPX/pSdMpwpGHHSH6ymXtUTMEy/jSxWjrN
 2RcQ==
X-Gm-Message-State: ACgBeo2FvzpgAJNZNFs1RnSNbFiWsPt1BclY435R8tSiq7dCSwafSZ7j
 Q36CSE0jXAKXQEa3BFzEdOytTk9BE/FdzPgq6kIcdwY63+gk/4ObGUrCUJDP/wWelc2+mhUdHLD
 gyXBXDqL/qsmwtp2evXBheO299jZFrtXmcCxVZC72Wg==
X-Received: by 2002:a5d:684a:0:b0:220:7b23:a980 with SMTP id
 o10-20020a5d684a000000b002207b23a980mr20077590wrw.597.1660205487399; 
 Thu, 11 Aug 2022 01:11:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xc/42oHie17kmauy1EJXfhqEj0LSLA+uazBJPCNi2fmb0OwQ0ToWaIHHZc2CplPLpkPQTRw==
X-Received: by 2002:a5d:684a:0:b0:220:7b23:a980 with SMTP id
 o10-20020a5d684a000000b002207b23a980mr20077579wrw.597.1660205487181; 
 Thu, 11 Aug 2022 01:11:27 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 t19-20020a05600c199300b003a31c4f6f74sm5513744wmq.32.2022.08.11.01.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:11:26 -0700 (PDT)
Date: Thu, 11 Aug 2022 04:11:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 0/2] virtio_net: fix for stuck when change ring
 size with dev down
Message-ID: <20220811041041-mutt-send-email-mst@kernel.org>
References: <20220811080258.79398-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220811080258.79398-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Aug 11, 2022 at 04:02:56PM +0800, Xuan Zhuo wrote:
> When dev is set to DOWN state, napi has been disabled, if we modify the
> ring size at this time, we should not call napi_disable() again, which
> will cause stuck.
> 
> And all operations are under the protection of rtnl_lock, so there is no
> need to consider concurrency issues.
> 
> PS.
> Hi Michael, I don't know which way is more convenient for you, so I split the
> commit into two commits, so you can fixup to my previous commit:
> 
>     virtio_net: support tx queue resize
> 	virtio_net: support rx queue resize
> 
> Xuan Zhuo (2):
>   virtio_net: fix for stuck when change rx ring size with dev down
>   virtio_net: fix for stuck when change tx ring size with dev down
> 
>  drivers/net/virtio_net.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)


Which patches does this fix?
Maybe I should squash.

> --
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
