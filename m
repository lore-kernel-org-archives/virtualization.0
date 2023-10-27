Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1423EC25B47
	for <virtualization@archiver.kernel.org>; Fri, 27 Oct 2023 10:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A201184E23;
	Fri, 27 Oct 2023 10:18:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A201184E23
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S6gDp5uC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mb456auzfsX3; Fri, 27 Oct 2023 10:18:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E00084E4B;
	Fri, 27 Oct 2023 10:18:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E00084E4B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFBAFC0071;
	Fri, 27 Oct 2023 10:18:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BB31C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 10:18:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04EEA84E4B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 10:18:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04EEA84E4B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ewh4qu-LD9y5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 10:18:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58D8E84E22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 10:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58D8E84E22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698401891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZY15p4oIEfxgWyNWClalrKHx1YMgCfc6TjxYt8iXs0=;
 b=S6gDp5uCMmgW5NZHSAi2sWe6lVerJ0ucK7psH/5I02TbJFTQe4QhbcR+CxCfeI6y4M8crd
 48ohPMkM0aNrteLq70hSZefOOcfNirZqQmlqtVskP8GpZiWpii4PjMrGGqqS6/zDr9K1QU
 sDsnoRZe84CFMXpv1b7LiMYaFgQajl4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-X7U7GDdzP_yAR1kBNGI3ZQ-1; Fri, 27 Oct 2023 06:18:09 -0400
X-MC-Unique: X7U7GDdzP_yAR1kBNGI3ZQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778a20a16e3so270261385a.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 03:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698401889; x=1699006689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZY15p4oIEfxgWyNWClalrKHx1YMgCfc6TjxYt8iXs0=;
 b=Y2Gfbcpf1EKFJgt/srcnYO98fdgXag2jZKRFCLijmwInY4GeNFqKTg6bTEDbzA2wzX
 +Nc8HZxuc5oMsUVkS5bXJ+RqSnxOL5UKfrSjxDH9NcQc0oejYGqJu7C9nx7zm04+3Oli
 96QkSeL8ghRs04O7QtcPPyoVqgMSpWcSoPoR9HYUlLpSwV16liVfKBNmyO0nbHR9YWgR
 nKJAiiVwUkmZDgpL/L11o3Fjp781pAh59/zQ5CXt4oTNPZP6ncbqWzFR5J4xtt8wqiZJ
 A1QzrR4nTtwKt6uRB4UAJ3RMGuYICOvaR2gCTP1Z56uo2eIibeEBgh/583I9+mADXeiS
 XIQw==
X-Gm-Message-State: AOJu0YxylimaI6N11BCJBhs4hymmV/1Sf0IUWglPJxEXnlj40QaST9X2
 /Hc12fjdptqnAFMyS1j4V2q0PRF3phKsVGipA3D3Pan5dNwM5oxFtynbuCZ21YNLKaevH3o2y6/
 8kRo3bMaz4iVVMva2qbivD1Z6Ktwf79jiZZEwdk72sw==
X-Received: by 2002:a37:c247:0:b0:774:15ad:f34c with SMTP id
 j7-20020a37c247000000b0077415adf34cmr1906245qkm.70.1698401889179; 
 Fri, 27 Oct 2023 03:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVbi3m4HtBsaAHCYuS1Gm+WqONcRY/f91+9J5q+xtfN+RS9/bPp7pN8qw6/VJVCiFy4pQCMw==
X-Received: by 2002:a37:c247:0:b0:774:15ad:f34c with SMTP id
 j7-20020a37c247000000b0077415adf34cmr1906237qkm.70.1698401888896; 
 Fri, 27 Oct 2023 03:18:08 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 y3-20020a37e303000000b00774830b40d4sm420637qki.47.2023.10.27.03.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 03:18:08 -0700 (PDT)
Date: Fri, 27 Oct 2023 12:18:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Takashi Iwai <tiwai@suse.de>, mst@redhat.com
Subject: Re: [PATCH v4] ALSA: virtio: use ack callback
Message-ID: <jmuevryxo2nlqriqbwz6y2ttwzxwajfsnb5vaez2oqu7etkrd3@lu3pgnfushmr>
References: <ZTjkn1YAFz67yfqx@fedora>
 <87cyx0xvn7.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <87cyx0xvn7.wl-tiwai@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org, mripard@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, perex@perex.cz,
 stefanha@redhat.com, pbonzini@redhat.com,
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

On Fri, Oct 27, 2023 at 11:27:40AM +0200, Takashi Iwai wrote:
>On Wed, 25 Oct 2023 11:49:19 +0200,
>Matias Ezequiel Vara Larsen wrote:
>>
>> This commit uses the ack() callback to determine when a buffer has been
>> updated, then exposes it to guest.
>>
>> The current mechanism splits a dma buffer into descriptors that are
>> exposed to the device. This dma buffer is shared with the user
>> application. When the device consumes a buffer, the driver moves the
>> request from the used ring to available ring.
>>
>> The driver exposes the buffer to the device without knowing if the
>> content has been updated from the user. The section 2.8.21.1 of the
>> virtio spec states that: "The device MAY access the descriptor chains
>> the driver created and the memory they refer to immediately". If the
>> device picks up buffers from the available ring just after it is
>> notified, it happens that the content may be old.
>>
>> When the ack() callback is invoked, the driver exposes only the buffers
>> that have already been updated, i.e., enqueued in the available ring.
>> Thus, the device always picks up a buffer that is updated.
>>
>> For capturing, the driver starts by exposing all the available buffers
>> to device. After device updates the content of a buffer, it enqueues it
>> in the used ring. It is only after the ack() for capturing is issued
>> that the driver re-enqueues the buffer in the available ring.
>>
>> Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>
>Applied now to for-next branch.

Cool, thanks for that!

I just wonder if we should CC stable since we are fixing a virtio
specification violation.

@Michael what do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
