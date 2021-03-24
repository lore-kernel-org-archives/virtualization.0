Return-Path: <SRS0=wNjl=IW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DFCC433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 13:58:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E7E61A07
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 13:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E7E61A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F3B84011A;
	Wed, 24 Mar 2021 13:58:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yxZm0BSrL6fz; Wed, 24 Mar 2021 13:58:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23447400C0;
	Wed, 24 Mar 2021 13:58:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0611FC000E;
	Wed, 24 Mar 2021 13:58:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5C2EC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 13:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F07D40EA9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 13:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O5Z2m-W7AiNA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 13:58:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4763140E97
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616594311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/C5hrHviblBlz6qOuCjmxQmp+MydE/HY6zib4cOG+CM=;
 b=NSte9H/JVQ6nrbGEtboj/H1/S4CAhc86yP9gSDQUmXevnOb7bb6C6eZ5RTOWo69zUQfQqh
 DL+G5Nn4ZNqJI3Htpuppu39HKr3nBjTpgW6G6QtK6PFx4LQs5aiG15x623BJNiTidjq7ll
 TjUaumovHhki319LBtyOzdinmkYZ2Fk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-4VQDV68mN6SEfpwTYHj7xA-1; Wed, 24 Mar 2021 09:58:28 -0400
X-MC-Unique: 4VQDV68mN6SEfpwTYHj7xA-1
Received: by mail-oo1-f71.google.com with SMTP id k26so1326689oou.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 06:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/C5hrHviblBlz6qOuCjmxQmp+MydE/HY6zib4cOG+CM=;
 b=foL2NawPP1Q06dR2osjviExSEf03S3/vw5uI24gTZ0xJQLmHdZd9vyMwRm0p+2hTyM
 xhUg9et2yXsantfVEMa2tSMUSTjlYq0vj4/jjfM3i0jsyqR11CTFmuljudupdGqeCaCe
 4wJsf3j3eNkQcP/afyKbQ88nZW5hFTzX9ixwJoPjuyS4H9LzCbk5WTjvYYFkmqCvQmdV
 vS/04vqhXp9ZrNkyUe9tWqkJ8iaCWWr2EjxpnAO2Ci/l39fjVmXhz/qmtckCNLpZak4N
 y4PxJI8PlTfB7CdPsJpZ/ZJq0glXsMPGjKGITSLfHPq2b8Ssw1QINyfsoQq7Keiuk2D2
 8eJw==
X-Gm-Message-State: AOAM531hxdYiH1Tc3hUsERr2p9nVr99s3f+13mKz+ShAGbTSJvxuFzcB
 jwzPU7xicti9IR15cU96ptrnX7+HJEXtoZdH35WtN+g5z0sUqHKFWRzBC/UfC809vqvFUbGCAU6
 iZnTWRNIwzLKKtv9ivEXbgzuEbDeDOMHVnzYakcyUwA==
X-Received: by 2002:aca:2418:: with SMTP id n24mr2426475oic.103.1616594308274; 
 Wed, 24 Mar 2021 06:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUzpwRYGx/Gf/SW6R+ymtcIvEm7PSV63CIFAnOYbgbfamQmwZBNs2xw4TBchd0MKmqjjledg==
X-Received: by 2002:aca:2418:: with SMTP id n24mr2426458oic.103.1616594308072; 
 Wed, 24 Mar 2021 06:58:28 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 a6sm400144oiw.44.2021.03.24.06.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Mar 2021 06:58:27 -0700 (PDT)
Subject: Re: [PATCH] fs/fuse/virtio_fs: Fix a potential memory allocation
 failure
To: zhouchuangao <zhouchuangao@vivo.com>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1616589523-32024-1-git-send-email-zhouchuangao@vivo.com>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <7dbe66b5-344b-2008-ca8f-559a271a061f@redhat.com>
Date: Wed, 24 Mar 2021 08:58:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1616589523-32024-1-git-send-email-zhouchuangao@vivo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 3/24/21 7:38 AM, zhouchuangao wrote:
> Allocate memory for struct fuse_conn may fail, we should not jump to
> out_err to kfree(fc).

Why not? If fc's allocation fails then it is NULL and calling kfree() on 
a NULL pointer is a noop[1].

Connor

[1] 
https://www.kernel.org/doc/html/latest/core-api/mm-api.html?highlight=kfree#c.kfree

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
