Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914CFC433F5
	for <virtualization@archiver.kernel.org>; Mon, 20 Dec 2021 21:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18E4E4027C;
	Mon, 20 Dec 2021 21:11:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F47vyIoXf2Eo; Mon, 20 Dec 2021 21:11:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 23D5340278;
	Mon, 20 Dec 2021 21:11:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C03CCC001E;
	Mon, 20 Dec 2021 21:11:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5617FC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 21:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F4244016B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 21:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gSyUoAPfV8_L
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 21:11:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19F3C401C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 21:11:46 +0000 (UTC)
Received: by mail-il1-x134.google.com with SMTP id x15so8609865ilc.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 13:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=V2JPrxTFm1Ac8AEfiOM1A2yxvZGoV8JL5X2KYXtDaVk=;
 b=q4GRtI+EVzO99+VvV8lz+ypDcQ5nEuD/9K8QFuzmm50n1iRFQSgKGOMSrJaM05N0yB
 ccWBLtwHhmp0DLdG7bhS3H2ItXnvCxBQ6IkiH1dgwCIJP4H0e+1TnFZ99y1SPOdWgebM
 NKhUntBnUNKBquZr/tWnZ8+yblP0E7/u78c5sQGqG3N1rcb9YslBk1cHcbgmUvBiQx9x
 Pfuu31iBEhl+YgpKluR+1vjBvH/fXUGxO2GhcZaNN/PPA9JFgw4Yo2bIDG40R429/8SB
 v7VY3p1FNZMdLUXkNHI/qgorlH+f4AXdJnEeciRkvHeXrEn75tcb/2VTFLHKf8WUHbjB
 rQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=V2JPrxTFm1Ac8AEfiOM1A2yxvZGoV8JL5X2KYXtDaVk=;
 b=gQ1YBykZdtYy+TsnFsYPb193HUulJfhbb830lLeY67j6YMgqMv5sB5g5SldrN9eTrL
 xdRwRtBDxwrYjzbboRFZMs3UfRNzzSAatlHKZB1nGqcXwxPA8T0pNK3WmEFEnuywIz2g
 5ORQW22YACsFB6TiG8vXlIUrdVNgDN6Gt7KeorJIqkCSrGTtAqEgxZETd2RFEWJelYHI
 SmP3u7yi2HM2GoIezKcPW85d1mgAdnwXYFRFtJBWlDxGfeXwZLpRZiFm7MWKxycYC4YU
 BxKHgBPK2zn0R8gok6OMY6W3S/tVf9sdSoHO5O5JrSMu6Q6FjTzUHzPpAZtZBNrao4uo
 SQRg==
X-Gm-Message-State: AOAM530EbVvag1fASBEykHKr9Bww3V/4YyVnZ3/PzW0qEkQteDEb2wOP
 WnRMgTgujswPDWjriLSc7hU=
X-Google-Smtp-Source: ABdhPJyP5mJDEPlaGMx9eUREs+0Ne/15Maq69bzKchrZ8Ms2ADQyGpcLYpeMqbGFlJ1yHNmyKCc7pQ==
X-Received: by 2002:a05:6e02:1988:: with SMTP id
 g8mr9573466ilf.184.1640034705231; 
 Mon, 20 Dec 2021 13:11:45 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
 by smtp.googlemail.com with ESMTPSA id c22sm9273811ioz.15.2021.12.20.13.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Dec 2021 13:11:44 -0800 (PST)
Message-ID: <8df990f1-7067-b336-f97a-85fe98882fb9@gmail.com>
Date: Mon, 20 Dec 2021 14:11:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [iproute2-next v2 4/4] vdpa: Enable user to set mtu of the vdpa
 device
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20211217080827.266799-1-parav@nvidia.com>
 <20211217080827.266799-5-parav@nvidia.com>
 <a38a9877-4b01-22b3-ac62-768265db0d5a@gmail.com>
 <20211218170602-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548189EBA8346A960A0A409FDC7B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211220070136-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E1BA270A1992AC0E52A8DC7B9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <PH0PR12MB5481E1BA270A1992AC0E52A8DC7B9@PH0PR12MB5481.namprd12.prod.outlook.com>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On 12/20/21 12:11 PM, Parav Pandit wrote:
>> After consideration, this future proofing seems like a good thing to have.
> Ok. I will first get kernel change merged, after which will send v3 for iproute2.

this set has been committed; not sure what happened to the notification
from patchworks bot.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
