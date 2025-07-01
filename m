Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2B0274658
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373747; cv=none; b=o3hWAVJ+WcAoI24Xh3Rpmh452fuKiYDtV/1B5Q5cNfCTXB1n/wUA78FciFGBclAuSmp6ErvRL7UuQKK3XHo1JI6/mQSaV3FwPxZBYAJLyxSxy3gmc2qQkl49TQTmWmpcdvUslxvJOt7Uzjk4m9Tz+U7NT1AAebsNEJOtISV4/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373747; c=relaxed/simple;
	bh=aibM3CEN4GlDaN5Q5oUKGzqAOrx2WCfZHlJS67dPa24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rgespwRdrAyrKPePsljSFwhXwNsvcPU0SdnIQwTt+0dubs54E0p4xBH7upTSNPj7TiAJ6/uDAu7KlTxwUPRdkvTH51W11tEjShIm4If690OsjP6J5xxdGrICR3j5T0QbRdhvUoTL7sNwVvqmOvhEl8XfHW5212/fliyi7Ec0qbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQ7BIhnh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ7BIhnh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751373745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eb0wjmxKgoQIQfwLxvEHu9pE8U4ib0H+OzhXzeaAk0=;
	b=iQ7BIhnhg3V52nORuCY/hhO54i1Fph1Afz6Vo3WvnPgrcvam5tC1MzhP17OqqRjSw8hRUl
	jhxVbtNDxeJB2+qsmGFTXsXjSJ+UUXus23qcqg9UrRsoym2WjKAQQmC4q131gHpMeeiH4o
	oTx4sW+8VLaSCU2TTNGzMPgwfT9u1lU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-LaCN_sc6PxSLfa4wa0iAQA-1; Tue, 01 Jul 2025 08:42:24 -0400
X-MC-Unique: LaCN_sc6PxSLfa4wa0iAQA-1
X-Mimecast-MFC-AGG-ID: LaCN_sc6PxSLfa4wa0iAQA_1751373743
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d460764849so288406385a.1
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 05:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373743; x=1751978543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eb0wjmxKgoQIQfwLxvEHu9pE8U4ib0H+OzhXzeaAk0=;
        b=PxjRTY1pUBJIGKJO2f69G1FWOVsUay1RT+h1oeozylMjfAiMb59n2SOTlvfSjF85ID
         pv2/I/nAF+9BgN2F+pWsPk/9vOJG3BgT+7V4TgpMgp25kj16IcdWb/oPmRZq1wr1OAIG
         E3Gtyl8IKIxi0vfxgk+O4sbqS8Axtht6kB2YoAi5QB9it0bbE8AH7/PsQcUBZpPf4fzX
         yPrBpR/PgVu1WEhYqzFpplyULbZ4N7Oz/4gd12T3LNBG5wOkyDii4vq4/d3U3gpioR1+
         CmOgjsOYIckH/IrWBUpD1y2MN31tBmQ3+QmgbNr8vYHC+UFH0Ndm7rgH1SH9qoVTII8/
         F8qw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Ccz2pZ488osVOjHMnGAm+y4IMaRnnLYYFfUmJLyjoPs3e6m+34ed/5kuHBBvarGDxUR47FRUA4xjFPypnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYmNVHeSACP1s/HigMtbDnylbaEV6AvAaLen+oMTNFLDuXqTYE
	luLaK/3oCD5vngJupYU/l9+H0C8biGByR2zbYfUJNefOrEKL3FumCMy50vf2BlHCumRLQ2Vv2AT
	GQl6Yjkxc1bzjP+aWy5SeRvbKZgSv90wtJvMaMuVrd7DTiCSLTa8uCW1JoDZi2gtRTkmr
X-Gm-Gg: ASbGnctNb1ogD2+zmYipRubpaJQG+uLEg0vNbYcKSN4wkbrP5FCxH0fpeC8rNxYFtLO
	jBYhDMP9EV+naHAL7utrJYLlJ3/9Vujken6f0FMujKYSeHlKr7VK7N0WcnpBRgmHLO9WAjcmvdJ
	uhmB2Nj9nHeMI/klmajbQzNQgFRUeDbUn4ANpMdYQ27sxxYOGaxpJb4vcxqKMSUBqPi7yEyGkhY
	B0UYSyg0wqtdEbWtiMECyTNmP6XKIiHqs575pIWh6/eouN2+48bDNOr1gyOkyLa9wABgxQtvvb8
	0TRL6GLY3GR9KPaCpVh1cFmyFhTD
X-Received: by 2002:a05:620a:2b8a:b0:7d4:61a4:dea with SMTP id af79cd13be357-7d466d304bfmr486922485a.7.1751373743358;
        Tue, 01 Jul 2025 05:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvA9cqKiGyYmMspm7UQcXD+JNKsXtSkygKVN8QiyRw0x71aIOnzq9VTSOJAu5f4SJwOywqbA==
X-Received: by 2002:a05:620a:2b8a:b0:7d4:61a4:dea with SMTP id af79cd13be357-7d466d304bfmr486915985a.7.1751373742656;
        Tue, 01 Jul 2025 05:42:22 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44313689fsm766012285a.16.2025.07.01.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:42:22 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:42:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock/vmci: Clear the vmci transport packet properly
 when initializing it
Message-ID: <37t6cnaqt2g7dyl6lauf7tccm5yzpv3dvxbngv7f7omiah35rr@nl35itdnhuda>
References: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LsyCHJ64Ab8n-R6dDN-fHTVkI2sJsteMouxm7NzWyks_1751373743
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 01, 2025 at 02:22:54PM +0200, Greg Kroah-Hartman wrote:
>From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>
>In vmci_transport_packet_init memset the vmci_transport_packet before
>populating the fields to avoid any uninitialised data being left in the
>structure.

Usually I would suggest inserting a Fixes tag, but if you didn't put it, 
there's probably a reason :-)

If we are going to add it, I think it should be:

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

>
>Cc: Bryan Tan <bryan-bt.tan@broadcom.com>
>Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>
>Cc: Broadcom internal kernel review list
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: virtualization@lists.linux.dev
>Cc: netdev@vger.kernel.org
>Cc: stable <stable@kernel.org>
>Signed-off-by: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
>Tweaked from original version by rewording the text and adding a blank
>line and correctly sending it to the proper people for inclusion in net.
>
> net/vmw_vsock/vmci_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index b370070194fa..7eccd6708d66 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -119,6 +119,8 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
> 			   u16 proto,
> 			   struct vmci_handle handle)
> {
>+	memset(pkt, 0, sizeof(*pkt));
>+
> 	/* We register the stream control handler as an any cid handle so we
> 	 * must always send from a source address of VMADDR_CID_ANY
> 	 */
>@@ -131,8 +133,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
> 	pkt->type = type;
> 	pkt->src_port = src->svm_port;
> 	pkt->dst_port = dst->svm_port;
>-	memset(&pkt->proto, 0, sizeof(pkt->proto));
>-	memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));

Should we also remove some `case`s in the following switch?
I mean something like this:

diff --git a/net/vmw_vsock/vmci_transport.c 
b/net/vmw_vsock/vmci_transport.c
index b370070194fa..d821ddcc62d8 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -135,10 +135,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
         memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));

         switch (pkt->type) {
-       case VMCI_TRANSPORT_PACKET_TYPE_INVALID:
-               pkt->u.size = 0;
-               break;
-
         case VMCI_TRANSPORT_PACKET_TYPE_REQUEST:
         case VMCI_TRANSPORT_PACKET_TYPE_NEGOTIATE:
                 pkt->u.size = size;
@@ -149,12 +145,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
                 pkt->u.handle = handle;
                 break;

-       case VMCI_TRANSPORT_PACKET_TYPE_WROTE:
-       case VMCI_TRANSPORT_PACKET_TYPE_READ:
-       case VMCI_TRANSPORT_PACKET_TYPE_RST:
-               pkt->u.size = 0;
-               break;
-
         case VMCI_TRANSPORT_PACKET_TYPE_SHUTDOWN:
                 pkt->u.mode = mode;
                 break;

Thanks,
Stefano

>
> 	switch (pkt->type) {
> 	case VMCI_TRANSPORT_PACKET_TYPE_INVALID:
>-- 
>2.50.0
>

