Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508CC433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:22:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6F864F4A
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6F864F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0E6DC868D7;
	Wed,  3 Feb 2021 14:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GTTJnwzKoBXo; Wed,  3 Feb 2021 14:22:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C965B86018;
	Wed,  3 Feb 2021 14:22:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACE6BC0FA7;
	Wed,  3 Feb 2021 14:22:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC820C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AB27985F8B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qJ7-5gB5Kvzp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:22:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F2F4D85F8A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612362172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3xWLX20KnSq7G5ofmlPC/VwP2FA7d4Kic/EX2+ofCBw=;
 b=AOjdZwmGDebJeLrviHUKHrBT4QappkOKkKcB81wl9hh0N9zR8CbTnPka6imHv4YXKtA53v
 9dFef45KdKURiGNL8us/wkKWLR/CvdMGgkwDQiD4M26mJLE6a4DH/8tDRKS/r2Hz5LkztV
 6KEbZg6Ul4pzZv3U1N1NdpnHQTRR+hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-XA9H55P5NW2AW_YuhKhu5g-1; Wed, 03 Feb 2021 09:22:49 -0500
X-MC-Unique: XA9H55P5NW2AW_YuhKhu5g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E784107ACE8;
 Wed,  3 Feb 2021 14:22:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-27.ams2.redhat.com
 [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 436F61002391;
 Wed,  3 Feb 2021 14:22:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0EAA01800853; Wed,  3 Feb 2021 15:22:39 +0100 (CET)
Date: Wed, 3 Feb 2021 15:22:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Subject: Re: [PATCH RESEND v3] virtio-input: add multi-touch support
Message-ID: <20210203142239.7lknkkg4zx5kuaf2@sirius.home.kraxel.org>
References: <20210115002623.8576-1-vasyl.vavrychuk@opensynergy.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115002623.8576-1-vasyl.vavrychuk@opensynergy.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Mathias Crombez <mathias.crombez@faurecia.com>, linux-input@vger.kernel.org
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

On Fri, Jan 15, 2021 at 02:26:23AM +0200, Vasyl Vavrychuk wrote:
> From: Mathias Crombez <mathias.crombez@faurecia.com>
> 
> Without multi-touch slots allocated, ABS_MT_SLOT events will be lost by
> input_handle_abs_event.
> 
> Implementation is based on uinput_create_device.
> 
> Signed-off-by: Mathias Crombez <mathias.crombez@faurecia.com>
> Co-developed-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
> Signed-off-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
> ---
> v2: fix patch corrupted by corporate email server
> v3: use number of slots from the host
> 
> Resend since to feedback.
> 
>  drivers/virtio/virtio_input.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Have no test hardware, the logic looks sane though.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
