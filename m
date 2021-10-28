Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA489C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 09:35:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C4860D43
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 09:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58C4860D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CDD2405DE;
	Thu, 28 Oct 2021 09:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DgCI-iwRbrCq; Thu, 28 Oct 2021 09:35:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D1E3140540;
	Thu, 28 Oct 2021 09:35:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0160C0019;
	Thu, 28 Oct 2021 09:35:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8521FC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B411405D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nbb3jSHppDNS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:35:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E661840540
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635413701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZ3+dxwtSd9cGZVljUAFZH9J8qIJeNjfIGAM6Y3t+mY=;
 b=AzrBATWritOJgRRz4INtCQxjwhE+OlBpI/x3RRdfY8ssDP0XyIEkY73zNjG2VQVhV4NsZp
 /iC+5GjIYOK4BOoS0a7d+mieKCd7pCsmbPsATn6sGcQ70MVhqOLp7Y1CbI4FIun/Ys9nmg
 HDVuZe+BHay/yyLXIgaGRRsqmg9VGXI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-JAIvHz9FOQ6OVsYZjXivbg-1; Thu, 28 Oct 2021 05:35:00 -0400
X-MC-Unique: JAIvHz9FOQ6OVsYZjXivbg-1
Received: by mail-ed1-f72.google.com with SMTP id
 d11-20020a50cd4b000000b003da63711a8aso4972082edj.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uZ3+dxwtSd9cGZVljUAFZH9J8qIJeNjfIGAM6Y3t+mY=;
 b=7wIZxSWViPo/wUdsA8f69QEaJTV/K2ea8zBR/hXuHEicjv2yPhB07R/bvLZjJz8lbB
 fRVKduYgLrTUuNtcVq3cMQgbw1bUzpA8Vw6aO8jlTZ/1+mrDIbxpDMyNkCofhV84nM8f
 NQgUPi/fnILAcBmB8hQIIuM6jODuxkpSPfGS2IU/AlmkVrry8a18UZvj3h2xl6O0dee6
 //Zc7JF3uaug7Hh+zOp/RxH7y7SBDibfkFbKlUzeZm+0DIrw7xcroXnDfEOfW/onklKL
 NEp7mZ/sEZpiE6vv54b1f9iid6/ZUwqshGpuulKq84ySUPaDSdLaaorf2j4+mjMqlYuz
 tvbA==
X-Gm-Message-State: AOAM531qdBoqQhADResdg+uVvZJERqGYTlF5wmhL3EKrwv766XBNT4uI
 ld7alKVEu1zW9R4bO6vYrtBDRJux8a5aDtTuXgElokr3179mQHF2UHf6KwM+YliJb/+7ePg42ab
 ynhSpNkqtVu21HIIcn+uuLLh+T/fZ9SpsDjVMw6J7mQ==
X-Received: by 2002:a17:907:7e9d:: with SMTP id
 qb29mr3987541ejc.469.1635413699099; 
 Thu, 28 Oct 2021 02:34:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbIQl4Don6iIxbD6tjdXD1/53f4UKFzjoMtazIr/TqTKGZIsxJACpFDCS2Ztk9cEhXcVp6jg==
X-Received: by 2002:a17:907:7e9d:: with SMTP id
 qb29mr3987513ejc.469.1635413698880; 
 Thu, 28 Oct 2021 02:34:58 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id hc15sm1054742ejc.73.2021.10.28.02.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Oct 2021 02:34:58 -0700 (PDT)
Date: Thu, 28 Oct 2021 11:34:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vDPA bus driver selection
Message-ID: <20211028093456.4vqurdmb2vw2kdhq@steredhat>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <20211027144048-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211027144048-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Oct 27, 2021 at 02:45:15PM -0400, Michael S. Tsirkin wrote:
>On Wed, Oct 27, 2021 at 04:33:50PM +0200, Stefano Garzarella wrote:
>> Hi folks,
>> I was trying to understand if we have a way to specify which vDPA bus
>> driver (e.g. vhost-vdpa, virtio-vdpa) a device should use.
>> IIUC we don't have it, and the first registered driver is used when a
>> new device is registered.
>>
>> I was thinking if it makes sense to extend the management API to
>> specify which bus driver to use for a device. A use case could be for
>> example a single host handling VMs and bare-metal containers, so we
>> would have both virtio-vdpa and vhost-vdpa loaded and we want to
>> attach some devices to VMs through vhost-vdpa and others to containers
>> through virtio-vdpa.
>>
>> What do you think?
>>
>> I can prepare an RFC with some code, the idea is to use the .match
>> callback of "struct bus_type" to use a driver instead of the other,
>> and extend netlink API to specify the vDPA bus driver name to use.
>>
>> Thanks,
>> Stefano
>
>So I think that doing this at create time is somewhat limited.
>For example a great way to do migration could be to unbind
>device from VM then bind virtio on the host to it, then
>bind macvtap to that.

Yep, make sense!

>
>Ideas on how to allow that?

Maybe we can split the device creation and the attach (probe) in two 
APIs, then we can add a detach API to allow changing bus.

Anyway I need to check the code better, but I think it's doable.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
