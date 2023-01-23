Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F48C38142
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 09:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DA5281F04;
	Mon, 23 Jan 2023 09:25:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DA5281F04
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYlase41
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mXG48pQYTpK; Mon, 23 Jan 2023 09:25:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A097F81F00;
	Mon, 23 Jan 2023 09:25:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A097F81F00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80C20C0033;
	Mon, 23 Jan 2023 09:25:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7D54C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1DB160BDE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:25:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1DB160BDE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYlase41
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yBzZjx-58VLR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:25:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BEA260BDD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BEA260BDD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674465950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMTy6Tq8SNpkRFs2YVhPz9j6sx3/BmqHI5EE4rEjczI=;
 b=WYlase41I5o1Ru2ApBik6cacV4ezdB9dYjl0tmRyfZFXczKrx2rYcQFv90DJNDnldOISSg
 bQdBis8Z9edK2gQHXotxnsP8p0/iGPZKoDkhngFy+oxzdkgFkRmFZBscUYx3QBxJmFnl1N
 tlfGMMvFW/WRuZcwIBgI/54Y+YTZGks=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-SHfaxsaWN5yx7fx1IG612Q-1; Mon, 23 Jan 2023 04:25:49 -0500
X-MC-Unique: SHfaxsaWN5yx7fx1IG612Q-1
Received: by mail-qk1-f198.google.com with SMTP id
 ay34-20020a05620a17a200b00704bd9922c4so8450355qkb.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 01:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMTy6Tq8SNpkRFs2YVhPz9j6sx3/BmqHI5EE4rEjczI=;
 b=PJAAGEiUMuWr1kG2KfjYaxsZdjihgeHzQWPz0ZZJsMyW3fPh5Gq0LAczFDSFf9X6fi
 dQ7SO1LtI/k4CzEiFDw8bYH5jskxgqDpCI6Pv+ZzHWUmlD44Apk7vtUbDsO9p4112p0z
 1/sZauQkBMKSq1E9Ocd5uL3m1SZI777q9xCH7CtmAjNZ6lhwEVe1YcIqKzZfTV9Jf5yW
 CnBcrumi/yZfx/989qU/QRwnmkzv4ehQ4rk7cESQAMUrgHuYYGyihWckORcrzEIkSsNO
 IDfwU4jowfEiuavj+ERB9OhTh/pnEncpo2Xa6wJy+MJSWOsmEGrwuAAJIS4ue5dbi1D2
 aySQ==
X-Gm-Message-State: AFqh2kpPWjcnxzRfd/mmCRXjAMkJyb4TkQl7exVScYkL/7/neR0diMIJ
 0AVZIgSnheIO5fT0lc3kqR5WoSUSdCBN9SkFEdUc7dE9cdpoJEUeLq4FaeObp9BvoGSIFiVlLG9
 H3+kCZcwrzShaV42GxFCT764qDmibH4giTtJg44oMlw==
X-Received: by 2002:ad4:5301:0:b0:535:5ff1:ccb2 with SMTP id
 y1-20020ad45301000000b005355ff1ccb2mr16731355qvr.4.1674465948714; 
 Mon, 23 Jan 2023 01:25:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtM8WdUzTuf3AICpDNA4CQh1qPmCAD0+RWVCzbet2oH+5JRFCvNifkrbn4tS6j0Ar1yAi0SvQ==
X-Received: by 2002:ad4:5301:0:b0:535:5ff1:ccb2 with SMTP id
 y1-20020ad45301000000b005355ff1ccb2mr16731343qvr.4.1674465948492; 
 Mon, 23 Jan 2023 01:25:48 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a05620a16aa00b006cfc9846594sm21718471qkj.93.2023.01.23.01.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jan 2023 01:25:47 -0800 (PST)
Message-ID: <aa07f74e-ad9e-bc94-9ace-257db0aa5b4d@redhat.com>
Date: Mon, 23 Jan 2023 10:25:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/4] virtio_net: vdpa: update MAC address when it is
 generated by virtio-net
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230122100526.2302556-1-lvivier@redhat.com>
 <20230122052211-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20230122052211-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Cindy Lu <lulu@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Gautam Dawar <gautam.dawar@xilinx.com>
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

On 1/22/23 11:23, Michael S. Tsirkin wrote:
> On Sun, Jan 22, 2023 at 11:05:22AM +0100, Laurent Vivier wrote:
>> When the MAC address is not provided by the vdpa device virtio_net
>> driver assigns a random one without notifying the device.
>> The consequence, in the case of mlx5_vdpa, is the internal routing
>> tables of the device are not updated and this can block the
>> communication between two namespaces.
>>
>> To fix this problem, use virtnet_send_command(VIRTIO_NET_CTRL_MAC)
>> to set the address from virtnet_probe() when the MAC address is
>> randomly assigned from virtio_net.
>>
>> While I was testing this change I found 3 other bugs in vdpa_sim_net:
>>
>> - vdpa_sim_net sets the VIRTIO_NET_F_MAC even if no MAC address is
>>    provided. So virtio_net doesn't generate a random MAC address and
>>    the MAC address appears to be 00:00:00:00:00:00
>>
>> - vdpa_sim_net never processes the command and virtnet_send_command()
>>    hangs in an infinite loop. To avoid a kernel crash add a timeout
>>    in the loop.
>>
>> - To allow vdpa_sim_net to process the command, replace the cpu_relax()
>>    in the loop by a schedule(). vdpa_sim_net uses a workqueue to process
>>    the queue, and if we don't allow the kernel to schedule, the queue
>>    is not processed and the loop is infinite.
> 
> I'd split these things out as opposed to a series unless there's
> a dependency I missed.

We needed to fix virtio_net before fixing vdpa_sim_net otherwise the 
virtnet_send_command() hangs when we define the vdpa device with "vdpa dev" but without a 
MAC address.

> All this reminds me of
> https://lore.kernel.org/r/20221226074908.8154-5-jasowang%40redhat.com
> 
> how is this patch different/better?
> Pls also CC people involved in that original discussion.

I was not aware of the Jason's series.

It seems to address better the problem, except it triggers the ASSERT_RTNL() in 
virtnet_send_command() when it is called from virtnet_probe().

I will remove patches 2 and 4 from my series.
PATCH 3 can be sent on independently too.

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
