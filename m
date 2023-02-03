Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF01EC636CC
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 10:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B97641D32;
	Fri,  3 Feb 2023 10:16:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B97641D32
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQq9ZWPg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6UMLQ4Xq9tOh; Fri,  3 Feb 2023 10:16:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D3B241817;
	Fri,  3 Feb 2023 10:16:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D3B241817
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA2AC0032;
	Fri,  3 Feb 2023 10:16:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5124EC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:16:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B9D941D32
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:16:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B9D941D32
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kReZAbCwdofQ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:16:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 861C441817
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 861C441817
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675419412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ousZpEK5jfyQ8iRq6Lou/eQvak4AKWvj409ge5GqF4=;
 b=iQq9ZWPgaeoZ1fPxVagJFnrW4vuOXi188J8nplsuPwA2Y7Hg4tp8UQWkHzjUKx/DyOA9kn
 4pR3jzTfMvNK1UW5SMwQmdFVYY9k1G0EcV+Po4kAxQ49y6v6ybjpIf2E8ay+IPv/70gZRe
 d9nOoiRSlpBRRbPf3l88yyN2tOx8FCM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-vQxi65R9Mi2e-M9eC84gpw-1; Fri, 03 Feb 2023 05:16:51 -0500
X-MC-Unique: vQxi65R9Mi2e-M9eC84gpw-1
Received: by mail-ed1-f72.google.com with SMTP id
 w16-20020a056402129000b004a1f1a2e79dso3283445edv.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 02:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ousZpEK5jfyQ8iRq6Lou/eQvak4AKWvj409ge5GqF4=;
 b=T/2v1kMh6jIHFw3jaj5gF2YXPdMgJA/a6PZn0VIzQCrX0doy8cB0eQ9IZu2IfWvkRh
 sNku62iDf2H2jc5guJ0Na2vI7RBEpe6VjIuxch7H28tYZuzwqC0atXiQfForuV8IOKPT
 cHo9O5jt9VdNyQzDefg7bGn1UVA0MsgcaJueAt8C9x/69C5YxrzZW3pReMNde7QFUlk5
 ECyIE8MixVzmBtg4StWCNqtDSmBR36h9FQJYXveARknQrqU9VCY5Sfgvf16vMP4E5BoF
 l+nSCJ0qV1wXiisNJEaa/rB/7iLJx9MAJ9KQYRAAYuAYbD3U2HZJe6qNH2mSX+zeLQlv
 imbw==
X-Gm-Message-State: AO0yUKXYl4yh7UjQQ0Tt9ZnK9EUsPRyELEXyNpHQoA9SRvc8EaMgQI2F
 iMP7gGFQwXXRmkk4ONsDRV+C7xNSVBD1TjV8137LkBGYlt6wlwkv83j1NwOeSPgY20pmHqbYnGK
 EfU+TkEFlESO6GZOGSnKkjeUtwR3eafnEoHvUqCJSoA==
X-Received: by 2002:a17:907:6d17:b0:88d:ba89:1843 with SMTP id
 sa23-20020a1709076d1700b0088dba891843mr5270788ejc.20.1675419410282; 
 Fri, 03 Feb 2023 02:16:50 -0800 (PST)
X-Google-Smtp-Source: AK7set/pKRk6MAe68cqpo58de4wljRgyqSUUvcGRqEx82KpgViv3orGBmWcoaFTcA1tHf3+p9hR8NQ==
X-Received: by 2002:a17:907:6d17:b0:88d:ba89:1843 with SMTP id
 sa23-20020a1709076d1700b0088dba891843mr5270773ejc.20.1675419410082; 
 Fri, 03 Feb 2023 02:16:50 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 cw20-20020a170906c79400b008787c8427c1sm1139542ejb.214.2023.02.03.02.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 02:16:49 -0800 (PST)
Date: Fri, 3 Feb 2023 05:16:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH 1/4] virtio_pci: add a definition of queue flag in ISR
Message-ID: <20230203051445-mutt-send-email-mst@kernel.org>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230203100418.2981144-2-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20230203100418.2981144-2-mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>
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

On Fri, Feb 03, 2023 at 07:04:15PM +0900, Shunsuke Mie wrote:
> Already it has beed defined a config changed flag of ISR, but not the queue
> flag. Add a macro for it.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> Signed-off-by: Takanari Hayama <taki@igel.co.jp>
> ---
>  include/uapi/linux/virtio_pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f703afc7ad31..fa82afd6171a 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -94,6 +94,8 @@
>  
>  #endif /* VIRTIO_PCI_NO_LEGACY */
>  
> +/* Ths bit of the ISR which indicates a queue entry update */

typo

Something to add here:
	Note: only when MSI-X is disabled



> +#define VIRTIO_PCI_ISR_QUEUE		0x1
>  /* The bit of the ISR which indicates a device configuration change. */
>  #define VIRTIO_PCI_ISR_CONFIG		0x2
>  /* Vector value used to disable MSI for queue */
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
