Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C219ABC2
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755217; cv=none; b=Xlwu/RA2EiwYqH64zGm/6TBoGuEts2QuEBhMSv5mLcd0JYNiKjyyiMCROi7Ad+O4a9eHlyFFfX3gojnVlyKW/aLNIFzjLG5aX3p4HJykt6yaYMwgq2185PDHn9WHwb0MaVengnTwY+z4nr01QmLAgqPim/TsVcpExCGUOBncyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755217; c=relaxed/simple;
	bh=mxOPmaHNNmijVfz1CVwVMXGKnvkZakTcfnOKolxNCzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XQWwaWd5qt35uXNW5cJv83E506nRe4wyQP6c9QAbL0nxJ/I/+bqTgIW2KwN5XTmEF4nJN6ONpxKKraeo2RZ3974zTsUd9XQE7La0Fnbz2cGdEz2D/FVQLmTYoREUFcwO+27etfzhQVgpYh4qjOxvVeQSQmimohrqgib3kjAXq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4YCu0hY; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4YCu0hY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BA3761196
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 08:26:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5chxQcWfuBa0 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Apr 2025 08:26:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2476B60809
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2476B60809
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c4YCu0hY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2476B60809
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 08:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743755213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3R/FwwTm36lOogPDfsrJ2NATa0Y/PG/vq80IpIZYTw=;
	b=c4YCu0hYnD9xUqnh5tftpC3Ofu8TNDi0orPokUknLxyHQ2G0v72AegjEm4Utep8FpyVuA7
	sXfRrENfdv/v8aJTUJERu7TcAV33zhXq4Co/RhJaMEN961DSY38QluzI5XLITxoeyh8rX2
	B+Vji7yLXvgdxWP/8oJ7KqpNV+NqxB8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-YSP_09q9MPunzJOLmU0e0Q-1; Fri, 04 Apr 2025 04:26:50 -0400
X-MC-Unique: YSP_09q9MPunzJOLmU0e0Q-1
X-Mimecast-MFC-AGG-ID: YSP_09q9MPunzJOLmU0e0Q_1743755209
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39979ad285bso1063879f8f.2
        for <virtualization@lists.linux-foundation.org>; Fri, 04 Apr 2025 01:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755209; x=1744360009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3R/FwwTm36lOogPDfsrJ2NATa0Y/PG/vq80IpIZYTw=;
        b=wJ3xlr41DE3FRvPDs1LAMux1Fkp3D+OlyiqV6Z+R/GroWblWM54eZDFP4dJNFWOAhl
         OrMcnyfmcel/TN6WjT2MSUDi1mErkHoyvTCTj/YamZld0Z6kVTdhVEmNDiSCSugz0fBk
         2wbM+F2OP9FdeVKItUJ+ODzHcALMLyi5X5mzN7Sd7P7H+eYt8JxR0NKjB86RU3apoBTM
         s5+wRKp+qwaZjYH9r1gIgOGplp723itBYDFEH93ie/1lIGmrHjexc+87vWasDDg9Tdms
         lb7lcnNMdFgB4Fcv5Uh5EXN3HDKH7GBGvI1oPwpru/iownxs8ZO3qFx0kNAjmWRieUCr
         7Apg==
X-Gm-Message-State: AOJu0YxrwU5gIXvYYNdFZ5lkRyVwuhJ66/iwcWgjqMmV9GVMMXRP8EUF
	ptNpw0GMI7VEbmNp4h//N5AINZoxarc64oDpdiCNSZz9/t8BzNbFdnpGEd5bPAYlyAk09+eozCa
	axF/f8k0QCrTqSSKrelZDCa7f+QAkcvc7nX+/Qjs6wnDYB8uhCFVC+8mYP9KQuUWeo9ojLaJGnx
	bA5nQ=
X-Gm-Gg: ASbGncszUAJYaFMUWu5oiqRRw1YLLrdUnNmgKW+8XsLgJnOIT4XjtAHEI6vLOb5ohIS
	y8ZYawheZycl8cC4Biftm5BBUC9y4UnwnEMJ/NZOlR1JAcyl+zxpsYHqSS24ydVe1S3ocib9cwL
	jHqy34ZhsdrJNcBSa5Gclz2xp7CIN20Dp5Fj8qwKpKFRxCGUnuBBGMJscED3XLWvhKcOO1YCL97
	ltlhOGWCrK0VO6vSo3Upev3zZ4U9Z04+aEOmy248qZ189MeKdFEwuaravJ/0a14D0cJSaBgjdtr
	bxOccEL95g==
X-Received: by 2002:a05:6000:1845:b0:391:3cb0:3d8d with SMTP id ffacd0b85a97d-39d0de179e8mr1425007f8f.19.1743755209061;
        Fri, 04 Apr 2025 01:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFry/je4DWnZKjNa0BdbFTTJdiIP/YGNaOLTb1x67wtVqnOvUq7clsozKVFoIyWoDydiJxwVQ==
X-Received: by 2002:a05:6000:1845:b0:391:3cb0:3d8d with SMTP id ffacd0b85a97d-39d0de179e8mr1424982f8f.19.1743755208677;
        Fri, 04 Apr 2025 01:26:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b8ad6sm3848446f8f.56.2025.04.04.01.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:26:48 -0700 (PDT)
Date: Fri, 4 Apr 2025 04:26:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Torsten Krah <krah.tm@gmail.com>
Cc: virtualization@lists.linux-foundation.org,
	Markus Fohrer <markus.fohrer@webked.de>, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250404041708-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <4d0c0cb9e9d513bf9ba81346ea72c9e58359ff93.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4d0c0cb9e9d513bf9ba81346ea72c9e58359ff93.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pp9b-4w_enmG665Dm6eRdDTT5XtTKHFT9kpoqQbv-s4_1743755209
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Apr 04, 2025 at 09:59:19AM +0200, Torsten Krah wrote:
> Am Mittwoch, dem 02.04.2025 um 23:12 +0200 schrieb Markus Fohrer:
> > When running on a host system equipped with a Broadcom NetXtreme-E
> > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the guest
> > drops to 100–200 KB/s. The same guest configuration performs normally
> > (~100 MB/s) when using kernel 6.8.0 or when the VM is moved to a host
> > with Intel NICs.
> 
> Hi,
> 
> as I am affected too, here is the link to the Ubuntu issue, just in
> case someone wants to have a look:
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2098961
> 
> We're seeing lots of those in dmesg output:
> 
> [  561.505323] net_ratelimit: 1396 callbacks suppressed
> [  561.505339] ens18: bad gso: type: 4, size: 1448
> [  561.505343] ens18: bad gso: type: 4, size: 1448
> [  561.507270] ens18: bad gso: type: 4, size: 1448
> [  561.508257] ens18: bad gso: type: 4, size: 1448
> [  561.511432] ens18: bad gso: type: 4, size: 1448
> [  561.511452] ens18: bad gso: type: 4, size: 1448
> [  561.514719] ens18: bad gso: type: 4, size: 1448
> [  561.514966] ens18: bad gso: type: 4, size: 1448
> [  561.518553] ens18: bad gso: type: 4, size: 1448
> [  561.518781] ens18: bad gso: type: 4, size: 1448
> [  566.506044] net_ratelimit: 1363 callbacks suppressed
> 
> 
> And another interesting thing we observed - at least in our environment
> - that we can trigger that regression only with IPv4 traffic (bad
> performance and lots of bad gso messages) - if we only use IPv6, it
> does work (good performance and not one bad gso message).
> 
> kind regards
> 
> Torsten


I suspect it's something weird on the ubuntu hypervisor side,
supplying wrong checksum offsets.

Can you stick a printk here:
                if (skb_transport_offset(skb) < nh_min_len)
                        return -EINVAL;

printing, on error, all of: start, off, needed, nh_min_len.


Also, what kind of device is this? QEMU? vhost-user? vhost-net?
Thanks!

-- 
MST

