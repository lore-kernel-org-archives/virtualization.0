Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF548C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 09:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50B3D40500;
	Tue, 12 Apr 2022 09:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sBVJDataY-wt; Tue, 12 Apr 2022 09:47:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 038F7400EF;
	Tue, 12 Apr 2022 09:47:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D03E4C002F;
	Tue, 12 Apr 2022 09:47:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB77EC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 09:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B91FE400EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 09:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LsdGYovgs8TN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 09:47:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C49F40169
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 09:47:20 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id t1so9173415wra.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jEYu5Dc4DrM1CeiFx20rntUZKHdIKyhqBQGEbRb+QEo=;
 b=MSfYzpmK8tn+uXXhR01V+fNirOZU31wliDT7ahVZuBpemgDi/9lLDSAJVDYSpZeTbK
 YQQZ3Vi4EWOxx+dFtFXwenHouaTwLx4s++6Ihuj5g+cZwyxYaYqJwNHwBcWqwNDIABXV
 sOF6eSR1FEjx2RARMY/b+sgg4jvWhwV/ntSyVIY5zJ2sMknGhHuIz38NMCHOzaW5vnug
 tbygB8NQlSK7osT568Zcj0/Y6GhTiRlqhnYZ+hfp3EWdCoS5NmUwBSzyEUxCiZImo9KD
 EVx0gknoyTlaDOb2phm0TpbMkQbbRVWfP0oorSNsd7q3GbydRyQvu3Mn6URcFylPvZH2
 Enaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jEYu5Dc4DrM1CeiFx20rntUZKHdIKyhqBQGEbRb+QEo=;
 b=MTIE8oSXeWdg+/hb9cooqqMBz/0LBgWqgkI4QW0gpqjfWb8gYGejFJI1C3tPxFUv5K
 mUedxP7xOUN+TClbPZODktuygdoAuM76B4cjsTZHC6NJj0r7DZ85CDiiRLir2ikECZWU
 1nrhl6wq6lSGbMgWg9XisXPRusGZJsgYqx9Lq/JzHBz5MVLMrLif5wZVg04+uZiYAFsF
 FXnJWkT2O4znrbyTfyzMalRzYLDdjI224EthfWYvROnLZcjdwWt77oNZJ9A6TzpxmfRB
 tLKyx0lrDzFwAKIp4r9oYwjZ60gR42UmUbpRHfiQcIfWgJ0OBdevKcKeAnwX84F70+T5
 c5pA==
X-Gm-Message-State: AOAM532A6eGH84Zv2FXdpsHj4oYfQSXqrYqq7wB1h29uI+4At00hupbA
 NEBlxTdkLeN3xMk/b7QvwO4=
X-Google-Smtp-Source: ABdhPJxCyWsrTSnfaBIu38O7iMTAsodQWY+yafnQ23aeJwg2qr3DNeFG5SxlCZ0qf1FD8HUV3c+OzA==
X-Received: by 2002:a5d:598a:0:b0:204:6fb:6461 with SMTP id
 n10-20020a5d598a000000b0020406fb6461mr28331617wri.132.1649756839021; 
 Tue, 12 Apr 2022 02:47:19 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.googlemail.com with ESMTPSA id
 o6-20020a05600002c600b00207a389117csm7316817wry.53.2022.04.12.02.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 02:47:18 -0700 (PDT)
Message-ID: <df758c80-ea85-d324-ad05-9bf07bb569e3@redhat.com>
Date: Tue, 12 Apr 2022 11:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/8] Introduce akcipher service for virtio-crypto
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
 berrange@redhat.com, arei.gonglei@huawei.com, Simo Sorce <simo@redhat.com>
References: <20220411104327.197048-1-pizhenwei@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220411104327.197048-1-pizhenwei@bytedance.com>
Cc: helei.sig11@bytedance.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
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


> In our plan, the feature is designed for HTTPS offloading case and
> other applications which use kernel RSA/ecdsa by keyctl syscall.

Hi Zhenwei,

what is the % of time spent doing asymmetric key operations in your
benchmark?  I am not very familiar with crypto acceleration but my
understanding has always been that most time is spent doing either
hashing (for signing) or symmetric key operations (for encryption).

If I understand correctly, without support for acceleration these 
patches are more of a demonstration of virtio-crypto, or usable for 
testing purposes.

Would it be possible to extend virtio-crypto to use keys already in the
host keyctl, or in a PKCS#11 smartcard, so that virtio-crypto could also
provide the functionality of an HSM?  Or does the standard require that
the keys are provided by the guest?

Paolo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
