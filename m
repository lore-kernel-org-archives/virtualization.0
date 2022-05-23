Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872E9C433EF
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 10:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FD5A83FB6;
	Mon, 23 May 2022 10:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CpG6Pr2ug2JS; Mon, 23 May 2022 10:33:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D5FBC83FB4;
	Mon, 23 May 2022 10:33:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9615FC0039;
	Mon, 23 May 2022 10:33:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38230C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14C0783FB6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cXm0V4AqhReS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:33:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C76383FB4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653302034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78ac/DMFK1OOmwHWGMBq2QKTWVFTkeD18ihAxO0CrpU=;
 b=SlxOBM61onEZ3pptYfoSnJD7EHTTNpAMrINKtYIDKj3K0Euhnn1YMxt0IWJCTn6K7qkPoO
 mdgu84825dI7GnodIEGgqDl3N9OgxaKUriE5qnegMLJrNMkQwWUK1MY47hoN9qmtLuYRoQ
 t+tYJ/AW2hExFBM213VbsJXFxwOu8hg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-37XTFVTxOWmQIqHXcNYUTg-1; Mon, 23 May 2022 06:33:53 -0400
X-MC-Unique: 37XTFVTxOWmQIqHXcNYUTg-1
Received: by mail-qt1-f198.google.com with SMTP id
 w21-20020a05622a135500b002f3b801f51eso11199282qtk.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=78ac/DMFK1OOmwHWGMBq2QKTWVFTkeD18ihAxO0CrpU=;
 b=aXpu0Jdq7k8WI0JsaT+khAzeWjT9HlM77tUSXCDr+Zo1tiglLqNic6bhDWEqIsPSye
 con3cELFSbMUlDScHXZkBVDC/hvlKpCSAKyw3QUuDcM+oGW963wXqiISP+mQORPK/t1Y
 maKox0LR1eP+sXLx3ZQcPxxKKbWC0bECwFSuCcJFDalp2M4GS5eqh4GSgiyZ6OEywrSQ
 34W+4CjDDCXp7cHFPzhiXr07wcR8kc7KSjznWDx1p6mMHieU9hQe8IiwR9S299ODz75t
 /Pvw+6866rlqZbzBMnVXIBJ6qY92ucEtB2T02ooqOgbpZqN63CsatlutIj0uTVCycWWP
 X1NA==
X-Gm-Message-State: AOAM5335EwZmUhi8RrbZ1g3kZojED0z56bdyAbRGBdR24GFOYjO+duAs
 Vt/QTP5gX2ySvOzCPo+TZXI3Fc43C0+JhLP55SgdrXpMyB739tdCOdO7wlEgEaetoPO/jRfZBfP
 /VQ7VqVzTUAWgQwTNlH9b9dDW4Un/O+Qp818V+6F3lg==
X-Received: by 2002:a05:6214:d03:b0:462:344c:554a with SMTP id
 3-20020a0562140d0300b00462344c554amr4410755qvh.104.1653302032784; 
 Mon, 23 May 2022 03:33:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOhcME+iqnGQ+8oMBw4rB9qB1dqWoT+TKPGVVrDkWiFqKYa95gJvT8iPBruG4tBG4TJqmtkQ==
X-Received: by 2002:a05:6214:d03:b0:462:344c:554a with SMTP id
 3-20020a0562140d0300b00462344c554amr4410748qvh.104.1653302032604; 
 Mon, 23 May 2022 03:33:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 k14-20020a37a10e000000b0069fc13ce1f7sm4263939qke.40.2022.05.23.03.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 May 2022 03:33:51 -0700 (PDT)
Date: Mon, 23 May 2022 12:33:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: Fix some error handling path in
 vhost_vdpa_process_iotlb_msg()
Message-ID: <20220523103345.6jf3r5e3ox5uvmk4@sgarzare-redhat>
References: <89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr>
 <CACGkMEtvgL+MxBmhWZ-Hn-QjfS-MBm7gvLoQHhazOiwrLxxUJA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtvgL+MxBmhWZ-Hn-QjfS-MBm7gvLoQHhazOiwrLxxUJA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Gautam Dawar <gautam.dawar@xilinx.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Mon, May 23, 2022 at 12:41:03PM +0800, Jason Wang wrote:
>On Sun, May 22, 2022 at 9:59 PM Christophe JAILLET
><christophe.jaillet@wanadoo.fr> wrote:
>>
>> In the error paths introduced by the commit in the Fixes tag, a mutex may
>> be left locked.
>> Add the correct goto instead of a direct return.
>>
>> Fixes: a1468175bb17 ("vhost-vdpa: support ASID based IOTLB API")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> WARNING: This patch only fixes the goto vs return mix-up in this function.
>> However, the 2nd hunk looks really spurious to me. I think that the:
>> -               return -EINVAL;
>> +               r = -EINVAL;
>> +               goto unlock;
>> should be done only in the 'if (!iotlb)' block.
>
>It should be fine, the error happen if
>
>1) the batched ASID based request is not equal (the first if)
>2) there's no IOTLB for this ASID (the second if)
>
>But I agree the code could be tweaked to use two different if instead
>of using a or condition here.

Yeah, I think so!

Anyway, this patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
