Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35658ECAAD8
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 08:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C283160E09;
	Tue, 20 Sep 2022 08:18:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C283160E09
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UYQL6cEZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1srnOPtHoCe8; Tue, 20 Sep 2022 08:18:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42FF7605B7;
	Tue, 20 Sep 2022 08:18:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42FF7605B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C3A2C0033;
	Tue, 20 Sep 2022 08:18:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1261AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 08:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5112605BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 08:18:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5112605BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Bbiy6TnT7Cf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 08:18:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4187605B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4187605B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663661912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYBXnM221OKkMmYnX56agU4HA29O1+0qE07dmbgFr1Y=;
 b=UYQL6cEZya3EUjGuAX728tyovitTPhL9jkC0WN7/7QCtsPIrwcJ+AxME126OXPejI6Jpo0
 OR4D/2h/lpa8hU9NR/KxM7EYRApNN4J2C204Zt5ulVc5l7W8qmtPlfWQpjFjQXVjYD7FR1
 X/o3F4atgzIWhZLcyjuwVDMW4/R8vC4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-H8-LnqzcPwybFVb2q7baYA-1; Tue, 20 Sep 2022 04:18:31 -0400
X-MC-Unique: H8-LnqzcPwybFVb2q7baYA-1
Received: by mail-wm1-f70.google.com with SMTP id
 g8-20020a05600c4ec800b003b4bcbdb63cso807793wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 01:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=nYBXnM221OKkMmYnX56agU4HA29O1+0qE07dmbgFr1Y=;
 b=P0O+ogaSA/M/WxfdjIHNl5/1J8RxHrzuXZ8IFEfPI6vkUR7d6mSsEMv2zksTDnFgSj
 pt1eIaLtIjk4kDR/PoHAFVKqnoCANH9B+nBjQttXNkscFGJh63XMqSJV5vLkXaRMWny9
 fEmp8Flr48ZPwK0ETN2uhzmyZeBRuFz7qpeWsW0f+uhGlOOWe6/NDpKPXu2WSnuOkksh
 F84F/9CijZYyYdhOXoefOlRXvLVRWKt3tECZkDOOuXTeL4eVk0s5cPtIvpVi3qDHEWDZ
 NfXwIyMw3FzIBOoxyeNXqSEKjwjrHS6hqlaLH6/fNRLHVuqlsqNYliSGu1mlBgspcwel
 KhJQ==
X-Gm-Message-State: ACrzQf2OwNYgpwJkuKPO3tzFXWxt7DbiIWac3aj4gkSB3+JQg8YfbZUz
 zXfqxAQmiUPU6+39Zcnwk9hmm/cDAQDs1dp90fsNk6jkCLFf73q0eNYdCzt/hJKhLdXpdOlxynw
 batKkwqzcoqu59BN+ULfwn7MkINlFoguXf85M4mb+Xw==
X-Received: by 2002:a5d:4ec5:0:b0:228:6707:8472 with SMTP id
 s5-20020a5d4ec5000000b0022867078472mr13700970wrv.12.1663661910616; 
 Tue, 20 Sep 2022 01:18:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Gc746EtqOMp12PC/ZhI3qlffavJ9O8HKgnaDgO6702xNdn3VPX99CEZYZBDDZBLY3QzW+vw==
X-Received: by 2002:a5d:4ec5:0:b0:228:6707:8472 with SMTP id
 s5-20020a5d4ec5000000b0022867078472mr13700953wrv.12.1663661910369; 
 Tue, 20 Sep 2022 01:18:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it.
 [87.11.6.69]) by smtp.gmail.com with ESMTPSA id
 z22-20020a05600c0a1600b003b4868eb6bbsm1749112wmp.23.2022.09.20.01.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Sep 2022 01:18:29 -0700 (PDT)
Date: Tue, 20 Sep 2022 10:18:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 0/3] MAINTAINERS: Update entries for some VMware drivers
Message-ID: <20220920081824.vshwiv3lt5crlxdj@sgarzare-redhat>
References: <20220906172722.19862-1-vdasa@vmware.com>
 <20220919104147.1373eac1@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220919104147.1373eac1@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: vdasa@vmware.com, pv-drivers@vmware.com, doshir@vmware.com,
 linux-scsi@vger.kernel.org, vbhakta@vmware.com, gregkh@linuxfoundation.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, bryantan@vmware.com,
 linux-graphics-maintainer@vmware.com, netdev@vger.kernel.org, joe@perches.com,
 namit@vmware.com, davem@davemloft.net, zackr@vmware.com,
 linux-rdma@vger.kernel.org
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

On Mon, Sep 19, 2022 at 10:41:47AM -0700, Jakub Kicinski wrote:
>On Tue,  6 Sep 2022 10:27:19 -0700 vdasa@vmware.com wrote:
>> From: Vishnu Dasa <vdasa@vmware.com>
>>
>> This series updates a few existing maintainer entries for VMware
>> supported drivers and adds a new entry for vsock vmci transport
>> driver.
>
>Just to be sure - who are you expecting to take these in?
>

FYI Greg already queued this series in his char-misc-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/log/?h=char-misc-next

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
