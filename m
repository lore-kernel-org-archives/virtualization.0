Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D99C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 14:17:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CABA2335A
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 14:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CABA2335A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 643E78729C;
	Wed, 16 Dec 2020 14:17:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LGpQMEDxNik2; Wed, 16 Dec 2020 14:17:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA07D8728B;
	Wed, 16 Dec 2020 14:17:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8202C088E;
	Wed, 16 Dec 2020 14:17:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33AFDC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 14:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2F62E86824
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 14:17:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RD1qoYmgrC3n
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 14:17:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 85E6586778
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 14:17:49 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id f29so7987062uab.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zGuef7QNpJoBs103ZROpg9hVYX5SQUrY21cb6QdJWDw=;
 b=aDPdyVQ+7eXwLiwV6X5UQ12qtcecCJrIwoN7K7aVIE15V7T3h2CVGORyogQB/f7z0T
 M6A/budE2CuCKQrp2c04fkfAQ4I25KvTW8HkSfezHy7ln4jtn7p/xV87QOS7i4jKcX7r
 wc6gn9q5C1ptXd0MQauwox1Roy9VVT0EFAtJNfa4lESi3sYsajzTYcK/lzrAdzkDL1Rr
 a9mfMX1IRWQVBTNsE5kHMwVgYzgS9ZKRR6Z1HhgI/r/ynepb4sVZSlOtVhxYut5hoYWG
 no2aZugFFo8HwNEffF3CZSLohYTvXfUGopPLMLHN7yOxoCjcoHdfsjSyihtvLHH/TpuG
 WmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zGuef7QNpJoBs103ZROpg9hVYX5SQUrY21cb6QdJWDw=;
 b=iWB5He44px8jSccr/nVKwQ0x9PuiNFbjyslJloht7yAJWeoCTZLH7fAUOSX8J6EXND
 kux1gOjqevKoyOt3nnKJEuptJ1nyiYdJoYfTCJj+eZQ/20N49VzzaF5NIzXk32u6luj2
 US4Z+oj0Ipv4zIwIXO3VyUB1axs4nkblOcPJdYbKJvMvyOVxxQLmfm1VRtNyXDMlpSyN
 kvjMJBiwK8cibI/Hbvg03ADhHfRAWLxJsc1TdhkErWRMPhS00TkkrA9qZK+SjtX4Q8Fe
 hBRUZY5fa6iz2rJ8eeXEyr+9tys0BHZo1dAGKOA4YAZzqLn6Ad4m+/WGFWUPIxBgS2Vh
 ro/A==
X-Gm-Message-State: AOAM531xfn+2YHcxpS7dpBgUpyE/NtGg2ItoKGzxcp2FRymjdf0OPz99
 CNWE6owh7hO3o8cJ8MsRNePJZzWefFI=
X-Google-Smtp-Source: ABdhPJxtLqdv99PJfsLfJEq5xl7SAYHBmoK0TlDfQEcGGuUPbM9a9tSd11VtVqwBMUnCamOtEeJQeQ==
X-Received: by 2002:ab0:1d17:: with SMTP id j23mr31377745uak.88.1608128268389; 
 Wed, 16 Dec 2020 06:17:48 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com.
 [209.85.217.52])
 by smtp.gmail.com with ESMTPSA id y2sm295664vkg.47.2020.12.16.06.17.45
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Dec 2020 06:17:46 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id b23so12986879vsp.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:17:45 -0800 (PST)
X-Received: by 2002:a67:30c1:: with SMTP id w184mr32661876vsw.13.1608128264592; 
 Wed, 16 Dec 2020 06:17:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608065644.git.wangyunjian@huawei.com>
 <62db7d3d2af50f379ec28452921b3261af33db0b.1608065644.git.wangyunjian@huawei.com>
In-Reply-To: <62db7d3d2af50f379ec28452921b3261af33db0b.1608065644.git.wangyunjian@huawei.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 16 Dec 2020 09:17:08 -0500
X-Gmail-Original-Message-ID: <CA+FuTSctg7y-s-bkfGf5kEj_LR1ht+LGAA5u36sKvutOVXSHaA@mail.gmail.com>
Message-ID: <CA+FuTSctg7y-s-bkfGf5kEj_LR1ht+LGAA5u36sKvutOVXSHaA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] vhost_net: fix ubuf refcount incorrectly when
 sendmsg fails
To: wangyunjian <wangyunjian@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 virtualization@lists.linux-foundation.org, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

On Wed, Dec 16, 2020 at 3:26 AM wangyunjian <wangyunjian@huawei.com> wrote:
>
> From: Yunjian Wang <wangyunjian@huawei.com>
>
> Currently the vhost_zerocopy_callback() maybe be called to decrease
> the refcount when sendmsg fails in tun. The error handling in vhost
> handle_tx_zerocopy() will try to decrease the same refcount again.
> This is wrong. To fix this issue, we only call vhost_net_ubuf_put()
> when vq->heads[nvq->desc].len == VHOST_DMA_IN_PROGRESS.
>
> Fixes: 0690899b4d45 ("tun: experimental zero copy tx support")
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Willem de Bruijn <willemb@google.com>

for next time: it's not customary to have an empty line between Fixes
and Signed-off-by
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
