Return-Path: <SRS0=L1Zq=IV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C13C433C1
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 14:34:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A287619BB
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 14:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A287619BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 172C5402B6;
	Tue, 23 Mar 2021 14:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zF_IMxkDPTop; Tue, 23 Mar 2021 14:33:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D0DB4024E;
	Tue, 23 Mar 2021 14:33:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1462EC000B;
	Tue, 23 Mar 2021 14:33:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35AF0C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 14:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3201E83D83
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 14:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwgn6KtqXM8A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 14:33:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D29283CE1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616510035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Jq/F710yph7giIFuOon0hHnQr6Etp9FxSOgX4AsDyE=;
 b=TpFGfJrmiIKGvFPr4r59aNukDHcLai0gD7pWqF1aMTdxnkPsCcg8ZI59QSPMhQ01gzNzy2
 STNzyyqRGzqi9MMCE3i6Q2vb6lVxIlyxHrKnQZWE3h3u0LXdaYDcWF9xRKsvx362cHy7VR
 5I5rx0rM9t34Vld73Vk/+3eqt3mhPeQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-LcG-ChCbObKsPRMtpktj5w-1; Tue, 23 Mar 2021 10:33:51 -0400
X-MC-Unique: LcG-ChCbObKsPRMtpktj5w-1
Received: by mail-ot1-f72.google.com with SMTP id e2so1208178otk.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 07:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Jq/F710yph7giIFuOon0hHnQr6Etp9FxSOgX4AsDyE=;
 b=PPIBWEl8pUgkuEclv7yM36NXmoC/uFXUioLenxLNIcAR0WbMKEas+TXSommIFM6UfH
 sgn9QWJNsuGMntOHu/TurfasZjEszjNF0kxvoldwYwz9Sk5PdAtplzNVxF2xN9wo+WrV
 b6mFy3NZ+PcpXSDK14GU2rDzm3Dmpu3fHW/RAibj7+06j/mC/Lvj/tZ4PphmhCa1muhN
 GLLV7KdHEBRY6lZExIv/P8JWEKgLzm/JZlTQf2wlNUH+WNWTaxmRq7HVpAS4H+8DxKiC
 JhBJEhQb78u9WmtAp1diL2PkHiBeq8UbRaJpp/cHeKdKgJg+af7WNm/RIvf+Yl5oFTfO
 YMUg==
X-Gm-Message-State: AOAM531fm9+hwmbD1PQvD1tQlXIEYhWoeMnPMouw+AfNmM6XCrBubor3
 qXnSvFHdLb5iQpZexdpFmD/ntVtCGLEBVVv/ecpFX+acT48rS/LJaH0mbjFlL2lOXf4fP7YDyY9
 VX+aLNEGckjydlu9t8jrYJCjybN8YIuA6mOY6KCsF9Q==
X-Received: by 2002:aca:4a95:: with SMTP id x143mr3509560oia.59.1616510031184; 
 Tue, 23 Mar 2021 07:33:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxok3f6ziJ9zKDi8trmoswuyjnL5pOr/KQa4kLV4auhi+XJnxMJJpMV5++pTTR3OV7D20fw4A==
X-Received: by 2002:aca:4a95:: with SMTP id x143mr3509539oia.59.1616510030878; 
 Tue, 23 Mar 2021 07:33:50 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 a13sm3696881ooj.14.2021.03.23.07.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Mar 2021 07:33:50 -0700 (PDT)
Subject: Re: [PATCH] fuse: Fix a potential double free in virtio_fs_get_tree
To: Lv Yunlong <lyl2019@mail.ustc.edu.cn>, vgoyal@redhat.com,
 stefanha@redhat.com, miklos@szeredi.hu
References: <20210323051831.13575-1-lyl2019@mail.ustc.edu.cn>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <db475406-76d1-dffd-f492-3e5bb955f08e@redhat.com>
Date: Tue, 23 Mar 2021 09:33:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323051831.13575-1-lyl2019@mail.ustc.edu.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 3/23/21 12:18 AM, Lv Yunlong wrote:
> In virtio_fs_get_tree, fm is allocated by kzalloc() and
> assigned to fsc->s_fs_info by fsc->s_fs_info=fm statement.
> If the kzalloc() failed, it will goto err directly, so that

Right, I follow this so far.

> fsc->s_fs_info must be non-NULL and fm will be freed.

But this I don't follow in the context of the stuff that happens in out_err.

> But later fm is freed again when virtio_fs_fill_super() fialed.
> I think the statement if (fsc->s_fs_info) {kfree(fm);} is
> misplaced.

I'm not sure this can double free, because:

* If fm = kzalloc[..] fails, the function bails early.

* If sget_fc() fails, the function cleans up fm and fc and bails early.

* If sget_fc() succeeds and allocated a new superblock, fc->s_fs_info 
pointer is moved to sb->s_fs_info and fc->s_fs_info is set to NULL, so 
the first free hasn't happened yet.

* If sget_fc() succeeds and somehow returns an existing superblock 
(which I think is tested by checking if fc->s_fs_info is not NULL, since 
otherwise it'd have been moved to the superblock and set to NULL in 
sget_fc), I think sb->s_root would not be NULL, therefore the flow of 
control wouldn't enter the if-block where virtio_fs_fill_super could 
fail which means the code won't reach the double free.

That's just my reading of it though, and I'm wondering if that makes 
sense to others :-)

One last comment inline:

> My patch puts this statement in the correct palce to avoid
> double free.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>   fs/fuse/virtio_fs.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8868ac31a3c0..727cf436828f 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1437,10 +1437,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>   
>   	fsc->s_fs_info = fm;
>   	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
> -	if (fsc->s_fs_info) {
> -		fuse_conn_put(fc);
> -		kfree(fm);
> -	}
> +
>   	if (IS_ERR(sb))
>   		return PTR_ERR(sb);

By removing the check from here, it now looks like if sget_fc() fails, 
then this early return will leak fm's memory and fc's reference.

Connor

>   
> @@ -1457,6 +1454,11 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>   		sb->s_flags |= SB_ACTIVE;
>   	}
>   
> +	if (fsc->s_fs_info) {
> +		fuse_conn_put(fc);
> +		kfree(fm);
> +	}
> +
>   	WARN_ON(fsc->root);
>   	fsc->root = dget(sb->s_root);
>   	return 0;
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
