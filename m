Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D02C001DB
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 09:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF2E64091F;
	Tue,  8 Aug 2023 09:13:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF2E64091F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UdITXN02
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BBzmEFGeyU8D; Tue,  8 Aug 2023 09:13:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D13334092D;
	Tue,  8 Aug 2023 09:13:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D13334092D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96C06C0071;
	Tue,  8 Aug 2023 09:13:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2485C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 09:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD56C4038B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 09:13:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD56C4038B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UdITXN02
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q10RSgwFnsy7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 09:13:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01D2640160
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 09:13:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01D2640160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691486019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1G+UFT5WUV3++eACnsbOojH7Ps5z7GYiHoNSMdDXlHM=;
 b=UdITXN02Nuba8gDevByMZgifYGm7IfHejCYYn0YX75I7K74x4RBXRe1ss70EJsEZ7gOmU1
 tCLSuvmyoTFhVgqaIQTWDaX7erb6qPCWR3CwWV9WKe5XmfL6NJ374yPHKsV4PFqaH76SC3
 MlwmBRb5AUjrIN5cmwC1CWT+EBfwSNo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-tMWFKcZ2Ml-zck-C58A0JQ-1; Tue, 08 Aug 2023 05:13:37 -0400
X-MC-Unique: tMWFKcZ2Ml-zck-C58A0JQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-521a38098faso3666504a12.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Aug 2023 02:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691486016; x=1692090816;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1G+UFT5WUV3++eACnsbOojH7Ps5z7GYiHoNSMdDXlHM=;
 b=hnyUUh38pzfYCL7V7coTYwX+LjLjxkbfnoFKE60pl4KU+tXqeg7VOnxVeKRLuvB8gQ
 7HTLArb0PQKdt6N8mKH24nAXYtqZ5Dmb88GbA1LDlvPMMW3ceIgfjS8Udxl1xGjp6WFU
 KDnXwDhQ+CSTd2+sM87ys4X+d4qMDAz9n2mEY9PIYhFiHFP7a5S+DLMDoD7+n2qY5nV0
 +qLOdRiIQeCg0BvZaFp2ZTvYoUr6pjZ2x1vlk+HIBs8T2835Kb4QqYCAMnhF1TrVcbI3
 KlN7gmMIGYLiUtSyJptPVuj4CMdOSBRD36kgEIYO7E52Ks4kOeeDfHvpaC9SNaPPDNaC
 i1Og==
X-Gm-Message-State: AOJu0YyMiye21CrRg89pldQrulPTBdR0mnSZwS01SVc6xLhTSQK/KQOt
 hRX368EUNYRJsEa1GjO37aUGYwZrIKH1DlfsZQZ+tPqN/WlSBra0IzulVoICqHoeROKaOn30C86
 j8hOpUR/Bkqs/eyQxDUzcsQ3hRCZAtsyDOHui2mzWLw==
X-Received: by 2002:a05:6402:1646:b0:523:4025:49f0 with SMTP id
 s6-20020a056402164600b00523402549f0mr1960938edx.26.1691486016583; 
 Tue, 08 Aug 2023 02:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZ8yuMEFfPguOg8HjGVkFo31GvBbO4Td4uMFZbTfoUpq6uZFQFMLz4TWQNdMsMhExnizdSA==
X-Received: by 2002:a05:6402:1646:b0:523:4025:49f0 with SMTP id
 s6-20020a056402164600b00523402549f0mr1960921edx.26.1691486016302; 
 Tue, 08 Aug 2023 02:13:36 -0700 (PDT)
Received: from redhat.com ([2.52.159.103]) by smtp.gmail.com with ESMTPSA id
 d14-20020aa7d5ce000000b00522b7c5d53esm6375959eds.54.2023.08.08.02.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 02:13:35 -0700 (PDT)
Date: Tue, 8 Aug 2023 05:13:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuan Yao <yuanyaogoog@chromium.org>
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
Message-ID: <20230808051304-mutt-send-email-mst@kernel.org>
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
 <CAOJyEHaXqmHStJnHrT0H4QsTJBxjBxVe+33EuWm9H3wApPKtxQ@mail.gmail.com>
 <CACGkMEuiVnLFRRDHaTH3Jnpr+znU9L33gLyRynbBabVqumN2ug@mail.gmail.com>
 <CAOJyEHaR1Y3VsKNpLqxf-ewAEf8JJDChjmnFM_0mv=hOg+X-vA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOJyEHaR1Y3VsKNpLqxf-ewAEf8JJDChjmnFM_0mv=hOg+X-vA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tiwei Bie <tiwei.bie@intel.com>, Junichi Uekawa <uekawa@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Takaya Saeki <takayas@chromium.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Aug 08, 2023 at 05:37:29PM +0900, Yuan Yao wrote:
> Thank you for reviewing, sent a patch with your ack.

Don't do this pls. And don't top post please.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
