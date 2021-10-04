Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69443C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 20:29:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114B561452
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 20:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 114B561452
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDA8B60727;
	Mon,  4 Oct 2021 20:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b-T4NmJUKnqo; Mon,  4 Oct 2021 20:29:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8571E60668;
	Mon,  4 Oct 2021 20:29:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57758C000F;
	Mon,  4 Oct 2021 20:29:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4545CC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1628B400ED
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:29:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UyGak9mtWl2J
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:29:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51B3440017
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:29:20 +0000 (UTC)
Received: by mail-io1-xd2b.google.com with SMTP id y197so21814393iof.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=fqt0R3ab4RICuxa4ODPGwNmcIJm7UomeSBzbdkfrJwQ=;
 b=zGFiLbF13Wvr0ZYPxyHjKy+b00mZ+1tdRCHD3MzZZFiWdxPpAFGyeXMZf0XGXDSOCh
 PNVYItKbd1WgDb3DvcqFO/P+EtcQ/unAPiQUQl+V3x0F/pbXSaCKf3kpCzYIYq/fkbw6
 v3uKPvJsTxc7cHMFUFQrKrebIzkMNnuOuFsusb2z+y06rPu+vH4FZtvz5FUZuzM6bqyU
 OaklmW7hNerGBvQXEBD2yF7oonWu0s5XcU330Qio6DL5iwr39xIhUFKKXAdr1o9ZYdZf
 W7bA1oBclcf68z72CejKFI2yA6Ov06HNG1/NhEeOUeo87miimfg4Ng3WiLa19kDlkhE6
 0lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fqt0R3ab4RICuxa4ODPGwNmcIJm7UomeSBzbdkfrJwQ=;
 b=gLK9nC831kgzZV8oion8PJveWnkwBrpEsblp6Qfn3LIeOK0YO1gEnWKOcNc4jl5ety
 3Stg0VtJpBXTqa2L/J/gRV7PuwkJB0Zr7Owl7hK4F5+qKJObbC/baVuthaHUt5vbO2LP
 mISnNt/3HN30b3nHgNcySntgsp3CAdHu2aYx3PUXXINLWOUmgPZiZaiyNKDIX8sXB38p
 JQRrFMdV+uM9OUFa41DzW/eufqMR2yBMtdBHT4lZKW6A2P6ZH23PDZxcj2XcQ+Qw29F5
 K1VCKtMWGfmAQXBz1MOhscd75Su5KEBVrhSjEvVQZvLhaRAJJYQKFvMoZZWw/e8JWxNa
 irnA==
X-Gm-Message-State: AOAM533tzn/1N9VOvdfyeXeP0bt0EgoNyoyagNP9oUEwvQiGwt6K0fpH
 2+uV0rUB6ts+bDXimNCcuqN/zQ==
X-Google-Smtp-Source: ABdhPJyPTjmI//dciledyOBW48hvMFJtaRjG1c+eLQlQ5CKMxoOJMZgJlVNxWwiXIph/uB3ee7rIqw==
X-Received: by 2002:a02:c6d6:: with SMTP id r22mr12598230jan.120.1633379359274; 
 Mon, 04 Oct 2021 13:29:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id a3sm6958600ilr.29.2021.10.04.13.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Oct 2021 13:29:18 -0700 (PDT)
Subject: Re: [PATCH V3 5/9] fork: add helper to clone a process
To: Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
 vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
References: <20211004192128.381453-1-michael.christie@oracle.com>
 <20211004192128.381453-6-michael.christie@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c7b09a03-a438-c75f-4332-d0ea744aa68f@kernel.dk>
Date: Mon, 4 Oct 2021 14:29:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211004192128.381453-6-michael.christie@oracle.com>
Content-Language: en-US
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

On 10/4/21 1:21 PM, Mike Christie wrote:
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index e165cc67fd3c..ba0499b6627c 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -87,7 +87,11 @@ extern void exit_files(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
>  
>  extern pid_t kernel_clone(struct kernel_clone_args *kargs);
> -struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
> +struct task_struct *create_io_thread(int (*fn)(void *i), void *arg, int node);

Looks like an extra 'i' snuck in here, causing unrelated changes.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
