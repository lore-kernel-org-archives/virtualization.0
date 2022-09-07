Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701C8ECAAD3
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 07:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 002194039D;
	Wed,  7 Sep 2022 07:46:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 002194039D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FH8JJ1jX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PK-_7HNlOFvn; Wed,  7 Sep 2022 07:46:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 74844402E5;
	Wed,  7 Sep 2022 07:46:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74844402E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C60FC0032;
	Wed,  7 Sep 2022 07:46:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 234B9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA8EB4030D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:46:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA8EB4030D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FH8JJ1jX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ebpbkePlbh_m
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:46:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F75540305
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F75540305
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662536771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3eQegbyNUNUZfQN4Vuu2Y+4sgIIke5mBIO94daHPAk=;
 b=FH8JJ1jXsEyZ935BfXuOghYkFtoF/0Hm1Cn/TAae13pLxR4tRvEk9k+SIAkZTQf6wHPw33
 mSDWZdIoRkaxbwCbSLC4NqxBVlBoMdtgGfRNdj6qggeMfN9XJuCe5VQhZM6EBsl7RKXKQy
 vDy99W7oqeKE5g0rdntK8MDXyMBt5HY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-281-QPzbPm21N-OIy0Y3TF_csQ-1; Wed, 07 Sep 2022 03:46:10 -0400
X-MC-Unique: QPzbPm21N-OIy0Y3TF_csQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 p3-20020a7bcc83000000b003b2973dab4bso73036wma.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 00:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=q3eQegbyNUNUZfQN4Vuu2Y+4sgIIke5mBIO94daHPAk=;
 b=u0LAHFvYkADP+LrgiX1VQYxUjFFOuy//V9kfgtfSNnnqwUSgoMoqY1aGwdn6Djyoow
 XMWZPCKtCJjHcaqQUbfsayG4SwmnBxznMkM2fdjCADBI15pKRBm/sT5ZofJJYZ29n2aa
 Qz3V0/prgTqWwOovXNGx8xchOjegjTDAS9TyC6i56VHOVCSgIHuqT9ZnlsPR+YQJDsqY
 JZFCRKTVL6ZRI4IEO+AbvVHZP0LiVMsj+iMQf1J9aRZZiWZREoq/DMUq3iyQkMLNH+j+
 0txtD3t1CZWDNcErgeXkKIfj2zq01/XFaVoYKf3fg+4LEd08OBDiqOO19cTPMmo9Jgnz
 UNOg==
X-Gm-Message-State: ACgBeo2FZZ71YIm7gHh3pXSg+bOEhdFj+dEMtlUqU+wFlDYWSQf6o//3
 UnN4u9xMLP39zHXGV+M4zBAc3aIEqok67HcTdZqWcLvu3AWPah95CluZD29QJpG/w+rWGoxh4Bo
 7ssvspFNhvkqB1uxQsjeDzD9Bel6N6zn8kqEMpF5/TQ==
X-Received: by 2002:adf:ed81:0:b0:226:a509:14b6 with SMTP id
 c1-20020adfed81000000b00226a50914b6mr1211076wro.150.1662536769193; 
 Wed, 07 Sep 2022 00:46:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR44JqlJBu3NM8POTUmZPOMnuC7An3N2YQMeTdJEE/AQ3Rtm8kSGa0vZZHfwxjXMROy9TOM4iQ==
X-Received: by 2002:adf:ed81:0:b0:226:a509:14b6 with SMTP id
 c1-20020adfed81000000b00226a50914b6mr1211058wro.150.1662536768934; 
 Wed, 07 Sep 2022 00:46:08 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it.
 [87.11.6.69]) by smtp.gmail.com with ESMTPSA id
 e3-20020a5d5303000000b0022584e771adsm16009397wrv.113.2022.09.07.00.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 00:46:08 -0700 (PDT)
Date: Wed, 7 Sep 2022 09:45:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: vdasa@vmware.com
Subject: Re: [PATCH 3/3] MAINTAINERS: Add a new entry for VMWARE VSOCK VMCI
 TRANSPORT DRIVER
Message-ID: <20220907074558.75v3ucll6eo66zky@sgarzare-redhat>
References: <20220906172722.19862-1-vdasa@vmware.com>
 <20220906172722.19862-4-vdasa@vmware.com>
MIME-Version: 1.0
In-Reply-To: <20220906172722.19862-4-vdasa@vmware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: pv-drivers@vmware.com, doshir@vmware.com, linux-scsi@vger.kernel.org,
 vbhakta@vmware.com, gregkh@linuxfoundation.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bryantan@vmware.com, linux-graphics-maintainer@vmware.com,
 netdev@vger.kernel.org, joe@perches.com, namit@vmware.com, davem@davemloft.net,
 zackr@vmware.com, linux-rdma@vger.kernel.org
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

On Tue, Sep 06, 2022 at 10:27:22AM -0700, vdasa@vmware.com wrote:
>From: Vishnu Dasa <vdasa@vmware.com>
>
>Add a new entry for VMWARE VSOCK VMCI TRANSPORT DRIVER in the
>MAINTAINERS file.
>
>Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
>---
> MAINTAINERS | 8 ++++++++
> 1 file changed, 8 insertions(+)

Thanks for adding this entry!
Will be very useful to review vsock patches for vmci transport.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
