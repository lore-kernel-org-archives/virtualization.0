Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB2DC433DB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 15:40:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962E223133
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 15:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962E223133
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3EDC084C93;
	Tue, 19 Jan 2021 15:40:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9fAyvbEiU51; Tue, 19 Jan 2021 15:40:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C438F8464C;
	Tue, 19 Jan 2021 15:40:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACA50C088B;
	Tue, 19 Jan 2021 15:40:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2687C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 15:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D0BCF8464C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 15:40:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JQ-6kiuiSdYy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 15:40:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E83E084589
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611070801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKLVjxLLLvnEAYy6NJeFg7DvONWq/cAqSB6JBXD96EQ=;
 b=XXot5jVe7WDLzMjFHLAUYEwgyI5aUGqwU1/ANhzY/vOzWvmdwo84e4wwuucJjphwNDGX05
 MNGeY9w4LpNuw6Ng2T8LZPeJ/vBLW2I0q7HM6AnHZDCo0uqJnM8YKNTN1mNLat/t9qbNVM
 SyfKHjvTtGeMeNZWDfBojuyUBm5SN68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-28rLX3CyOti2O2zJiaaXcQ-1; Tue, 19 Jan 2021 10:39:58 -0500
X-MC-Unique: 28rLX3CyOti2O2zJiaaXcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B18210054FF;
 Tue, 19 Jan 2021 15:39:56 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C07D100AE2F;
 Tue, 19 Jan 2021 15:39:55 +0000 (UTC)
Date: Tue, 19 Jan 2021 08:39:55 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
Message-ID: <20210119083955.1cc9eae3@omen.home.shazbot.org>
In-Reply-To: <20210119082812.822291-4-vivek.kasireddy@intel.com>
References: <20210119082812.822291-1-vivek.kasireddy@intel.com>
 <20210119082812.822291-4-vivek.kasireddy@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: dongwon.kim@intel.com, virtualization@lists.linux-foundation.org
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

On Tue, 19 Jan 2021 00:28:12 -0800
Vivek Kasireddy <vivek.kasireddy@intel.com> wrote:

> Getting a copy of the KVM instance is necessary for mapping Guest
> pages in the Host.
> 
> TODO: Instead of invoking the symbol directly, there needs to be a
> better way of getting a copy of the KVM instance probably by using
> other notifiers. However, currently, KVM shares its instance only
> with VFIO and therefore we are compelled to bind the passthrough'd
> device to vfio-pci.

Yeah, this is a bad solution, sorry, vfio is not going to gratuitously
call out to vhost to share a kvm pointer.  I'd prefer to get rid of
vfio having any knowledge or visibility of the kvm pointer.  Thanks,

Alex
 
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  drivers/vfio/vfio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 4ad8a35667a7..9fb11b1ad3cd 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -2213,11 +2213,20 @@ static int vfio_unregister_iommu_notifier(struct vfio_group *group,
>  	return ret;
>  }
>  
> +extern void vhost_vdmabuf_get_kvm(unsigned long action, void *data);
>  void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
>  {
> +	void (*fn)(unsigned long, void *);
> +
>  	group->kvm = kvm;
>  	blocking_notifier_call_chain(&group->notifier,
>  				VFIO_GROUP_NOTIFY_SET_KVM, kvm);
> +
> +	fn = symbol_get(vhost_vdmabuf_get_kvm);
> +	if (fn) {
> +		fn(VFIO_GROUP_NOTIFY_SET_KVM, kvm);
> +		symbol_put(vhost_vdmabuf_get_kvm);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(vfio_group_set_kvm);
>  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
