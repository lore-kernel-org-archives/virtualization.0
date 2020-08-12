Return-Path: <SRS0=QAK1=BW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC3C433DF
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 07:39:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B482065C
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 07:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IutmjDL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B482065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BA0678823B;
	Wed, 12 Aug 2020 07:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clh14C7DBc8Z; Wed, 12 Aug 2020 07:39:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 028DB8818D;
	Wed, 12 Aug 2020 07:39:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D59A4C013C;
	Wed, 12 Aug 2020 07:39:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4163C004D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 07:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 915CD22001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 07:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LnoC0uAR9JKP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 07:39:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id DC4882157D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597217966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OHEoD0OL9TMKDoEtwEodFChTT/XNznBR9noWaAASTjY=;
 b=IutmjDL7nXz8glH5dQtErUcd5c6OadyBz6IXXn/zG7pT1lZMVVKcHSCSPyz/TTKHN1CFwQ
 n8KnPDxjZmqJ0u37AZDiwVGYNV0tfB7m7rDi8mhQlemipol1LRI9+zI02AAonNeF1oNbMM
 d1MQ21IzMsNQZVs05DV/nxTlaHWXz9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-eDlGBmfsMUmbX0Rua8QoeA-1; Wed, 12 Aug 2020 03:39:24 -0400
X-MC-Unique: eDlGBmfsMUmbX0Rua8QoeA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BDE280183C;
 Wed, 12 Aug 2020 07:39:23 +0000 (UTC)
Received: from [10.36.110.45] (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C8C38BB13;
 Wed, 12 Aug 2020 07:39:19 +0000 (UTC)
Subject: Re: [PATCH 1/2] vdpa: ifcvf: return err when fail to request config
 irq
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200723091254.20617-1-jasowang@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
Message-ID: <b65b8a30-c629-e1d8-184e-7f9996b75614@redhat.com>
Date: Wed, 12 Aug 2020 09:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723091254.20617-1-jasowang@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Zhu Lingshan <lingshan.zhu@intel.com>
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

Hi,

On 7/23/20 11:12 AM, Jason Wang wrote:
> We ignore the err of requesting config interrupt, fix this.
> 
> Fixes: e7991f376a4d ("ifcvf: implement config interrupt in IFCVF")
> Cc: Zhu Lingshan <lingshan.zhu@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f5a60c14b979..ae7110955a44 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -76,6 +76,10 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
>  	ret = devm_request_irq(&pdev->dev, irq,
>  			       ifcvf_config_changed, 0,
>  			       vf->config_msix_name, vf);
> +	if (ret) {
> +		IFCVF_ERR(pdev, "Failed to request config irq\n");
> +		return ret;
> +	}
>  
>  	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++) {
>  		snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n",
> 

This series fixes below Kernel BUG I faced while doing some experiments:

[ 1398.695362] kernel BUG at drivers/pci/msi.c:375!
[ 1398.700561] invalid opcode: 0000 [#1] SMP PTI
[ 1398.705423] CPU: 0 PID: 25110 Comm: dpdk-testpmd Not tainted
5.8.0-amorenoz-vdpa+ #2
[ 1398.714063] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS
2.4.3 01/17/2017
[ 1398.722415] RIP: 0010:free_msi_irqs+0x189/0x1c0
[ 1398.727470] Code: 14 85 c0 0f 84 cc fe ff ff 31 ed eb 0f 83 c5 01 39
6b 14 0f 86 bc fe ff ff 8b 7b 10 01 ef e8 7e 94 b9 ff 48 83 78 70 00d
[ 1398.748426] RSP: 0018:ffffb48ac5dd3db8 EFLAGS: 00010286
[ 1398.754257] RAX: ffff9ab298b85400 RBX: ffff9ab285d97100 RCX:
0000000000000000
[ 1398.762219] RDX: 0000000000000000 RSI: 0000000000000073 RDI:
ffffffffac65e8a0
[ 1398.770182] RBP: 0000000000000000 R08: ffff9ab298b85400 R09:
ffff9ab74a8c3d98
[ 1398.778145] R10: ffff9ab74a8c3f58 R11: 0000000000000000 R12:
ffff9ab719fd82e0
[ 1398.786107] R13: ffff9ab719fd8000 R14: ffff9ab719fd8000 R15:
ffff9ab719fd80b0
[ 1398.794069] FS:  00007efc5dea9000(0000) GS:ffff9ab75fc00000(0000)
knlGS:0000000000000000
[ 1398.803099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1398.809508] CR2: 000000c000079ff8 CR3: 000000038283e005 CR4:
00000000003606f0
[ 1398.817471] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1398.825434] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 1398.833394] Call Trace:
[ 1398.836127]  pci_disable_msix+0xf7/0x120
[ 1398.840504]  pci_free_irq_vectors+0xe/0x20
[ 1398.845074]  ifcvf_vdpa_set_status+0xda/0x301
[ 1398.849938]  vhost_vdpa_unlocked_ioctl+0x61d/0x790
[ 1398.855277]  ? vhost_vdpa_process_iotlb_msg+0x2f0/0x2f0
[ 1398.861109]  ksys_ioctl+0x87/0xc0
[ 1398.864808]  __x64_sys_ioctl+0x16/0x20
[ 1398.868992]  do_syscall_64+0x52/0x90
[ 1398.872982]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1398.878610] RIP: 0033:0x7efc5df9ff9b
[ 1398.882598] Code: 0f 1e fa 48 8b 05 ed ce 0c 00 64 c7 00 26 00 00 00
48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 008
[ 1398.903551] RSP: 002b:00007ffd0948e378 EFLAGS: 00000283 ORIG_RAX:
0000000000000010
[ 1398.911998] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007efc5df9ff9b
[ 1398.919960] RDX: 00007ffd0948e3d4 RSI: 000000004001af72 RDI:
000000000000002c
[ 1398.927921] RBP: 00007ffd0948e3c0 R08: 0000000002651bf8 R09:
0000000000000000
[ 1398.935883] R10: 00007ffd0948e417 R11: 0000000000000283 R12:
0000000000408950
[ 1398.943845] R13: 00007ffd0948e6a0 R14: 0000000000000000 R15:
0000000000000000
[ 1398.951809] Modules linked in: vxlan ip6_udp_tunnel udp_tunnel
ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs xt_comment xt_mark nf_tables xt_nat vetht
[ 1398.951847]  ghash_clmulni_intel iTCO_vendor_support mlx5_core dcdbas
rapl intel_cstate intel_uncore ipmi_ssif pcspkr mxm_wmi mlxfw virtii

Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
