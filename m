Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A2EC7EE2C
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 01:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6161041800;
	Mon,  5 Jun 2023 01:51:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6161041800
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=vLTLo9Hg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LIfetmrDOFKI; Mon,  5 Jun 2023 01:51:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 97325417C3;
	Mon,  5 Jun 2023 01:51:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97325417C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E8F6C0037;
	Mon,  5 Jun 2023 01:51:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A082C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 01:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00E0F8232C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 01:51:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00E0F8232C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=vLTLo9Hg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zf1ohBbmotwh
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 01:51:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EA448232A
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EA448232A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 01:51:39 +0000 (UTC)
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-33b9a56e261so16429595ab.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jun 2023 18:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1685929898; x=1688521898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nn/2raZaCEyxkUMRUrTbO96sBipL80hG5ePyrz6qFx0=;
 b=vLTLo9Hga0Ar/isQv1thQ6LMwe4TSJJTmb7rjkogfP78xWUerUFwJaFlInNN9Rsbzl
 dV3v3LxF/3LdvZNssfF5mechwpN6sod6eFwCoqa7HtKcHPuPRa7K45x+vrJl8H7NSh7J
 SKxSlhKhnaKyUjqxey0rcUj2iDvQ4aqXRWBlGgBtJemIoMoJdEJhtkzT/XbQDP0vyvWO
 UzKUdFE+vNvkmZQlYZF0/l/ScJmT7Axe37yNY59/I/EzH1+1zDSZx78qAuTda7bY1vuH
 G+oPjEz37oRdwRPJZL7qx321ELEIQWoAeqUm5KJBPrMQAUQkpq3YuWiKkabMXOAjRaI5
 BqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685929898; x=1688521898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nn/2raZaCEyxkUMRUrTbO96sBipL80hG5ePyrz6qFx0=;
 b=NPkFajyjgemHj+naEFZ1cZr5Vb9/FFHq9qa3wVKhn8rDu8GAx1QN5IEI2cH2m2x4gH
 GEOyhd9mUzVqAZy2x3XRz8/fXIalp9cOvW9k8GGBOhBdYc8WVyDnJ18MmwXPuAFzIjZw
 ygtD2/6zQYEN1Hwv+Zy72rsPUcDQ4sCSwkz1kHE080U7yc1UKmecPHIt/gUHN5/GHEIT
 cgYk+ovGRJRu5eK8RVw/x5ljaYZm9pHFuKfnCc3qkMKAPQ5TwRDdo9/OwI99JMRIobVn
 tmVWhz1RfEqOWeARCna7J8HNSEp2fdmFuQeSMIt/vCPoq8YTsLU8fW22+LQdA2vgI4qy
 MPOQ==
X-Gm-Message-State: AC+VfDwlC6CXR/fKb0TKqoBDVgX4VC/RmBd/i6L4SME+zntSKirNhjde
 6+K+xRFqA5Xzp+mEF46TIyPLAw==
X-Google-Smtp-Source: ACHHUZ6j59fPcF9quNXpef0zZealPMWzACLlBgD6zknXufz/5SoUGHY373Tr8l3QoY7c6Dv6Vp7NDg==
X-Received: by 2002:a92:d20d:0:b0:33d:ab70:3447 with SMTP id
 y13-20020a92d20d000000b0033dab703447mr3111921ily.19.1685929898002; 
 Sun, 04 Jun 2023 18:51:38 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 4-20020aa79244000000b0065d2f009f9esm56628pfp.115.2023.06.04.18.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 18:51:37 -0700 (PDT)
Message-ID: <78f77d87-5499-b68c-298d-d49e740a2cc1@igel.co.jp>
Date: Mon, 5 Jun 2023 10:51:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/1] vringh: IOMEM support
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
References: <20230602055211.309960-1-mie@igel.co.jp>
 <20230602055211.309960-2-mie@igel.co.jp> <ZHtQybyy3qg+xw10@corigine.com>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <ZHtQybyy3qg+xw10@corigine.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Hi Simon-san,

On 2023/06/03 23:40, Simon Horman wrote:
> On Fri, Jun 02, 2023 at 02:52:11PM +0900, Shunsuke Mie wrote:
>> Introduce a new memory accessor for vringh. It is able to use vringh to
>> virtio rings located on io-memory region.
>>
>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ...
>
>> +/**
>> + * vringh_iov_pull_iomem - copy bytes from vring_iov.
> Hi Mie-san,
>
> as it looks like there will be a v2,
> please consider documenting the vrh parameter here.
It was missing an explanation. I will address that and review this patch.
Thank you.
>
>> + * @riov: the riov as passed to vringh_getdesc_iomem() (updated as we consume)
>> + * @dst: the place to copy.
>> + * @len: the maximum length to copy.
>> + *
>> + * Returns the bytes copied <= len or a negative errno.
>> + */
>> +ssize_t vringh_iov_pull_iomem(struct vringh *vrh, struct vringh_kiov *riov,
>> +			      void *dst, size_t len)
>> +{
>> +	return vringh_iov_xfer(vrh, riov, dst, len, xfer_from_iomem);
>> +}
>> +EXPORT_SYMBOL(vringh_iov_pull_iomem);
>> +
>> +/**
>> + * vringh_iov_push_iomem - copy bytes into vring_iov.
> And here.
I do the same.
>> + * @wiov: the wiov as passed to vringh_getdesc_iomem() (updated as we consume)
>> + * @src: the place to copy from.
>> + * @len: the maximum length to copy.
>> + *
>> + * Returns the bytes copied <= len or a negative errno.
>> + */
>> +ssize_t vringh_iov_push_iomem(struct vringh *vrh, struct vringh_kiov *wiov,
>> +			      const void *src, size_t len)
>> +{
>> +	return vringh_iov_xfer(vrh, wiov, (void *)src, len, xfer_to_iomem);
>> +}
>> +EXPORT_SYMBOL(vringh_iov_push_iomem);
> ...

Best regards,

Shunsuke

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
