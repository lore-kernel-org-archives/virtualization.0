Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8566DC433FE
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 23:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2845D41A26;
	Wed, 20 Apr 2022 23:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6jt5X_QDOClk; Wed, 20 Apr 2022 23:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 55535419B5;
	Wed, 20 Apr 2022 23:08:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ADF1C0033;
	Wed, 20 Apr 2022 23:08:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07DF4C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 23:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBF0A84030
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 23:08:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D10UdjOgxuPK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 23:08:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3168A84025
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 23:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+2AZe3Q+DEUai6az8GesyrGPuExvG8hBTKmX8IJNdJy4MU/3tIHCS9PQYjUx3IXKvmrSwt54nOda1ce0G9ByfOaL+5daxzZVoDcykNR/K6TgKFvYzwdGf0cmNlQbiSReTyYekb6Fz0h88U56g/F6TcDGTVnAc8CbyeBTWTBJTawH1ggtuNTCeeCHgAbAV5sXq/PAOarJf05ZXGb5aP446Q0DJdnndhZfr9DE7rGOotD0r239Pozff5A8buFPWoqKtuzyqtU97QPOWSnFEKArolvki+LzafUu4UVAt2XfP7FNQ01nQTfs6msf9zPkKWAdvBfbXa34W96JIOIBbXsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HMf8ZZLo+OqvIaK4Rak0wOwRhBcGEzaN3upUWNgJWg=;
 b=fag2GuNYK3vRzA0OTh+vVgZ156nBSHZF4XAr0Lb1hmNgROWvfyaxFXD5JGqyuOzK3aiBXne8IpD8//qLLeE3vNaisPDlz6SrWD7ls5Y5Buezv4k7Ibt7EQAtIVEHZkr+5DMWfhDwPU3c3ivaAIfiL42lNUst1WX/coxpARD6wZJKGk5aTMLBN4QUgru+Zjy4kEgeEzBC07wK7oCkdN0SNtFpekmZvGRC2iRz7qXqR72wW83YABzjhy4rlh7Xf5UGknX1yw1nINqvVGoc/BtlHBZQ9DMZe13//f2EOL9RGeOnAPv7MWzdUzGJLiFvQrhQVN14s0ZGhXIZcRm2FThmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HMf8ZZLo+OqvIaK4Rak0wOwRhBcGEzaN3upUWNgJWg=;
 b=F1jNuflHafpAzsTxuMtFg5U0EC8DQKcyQqOAFwfLdLf/ugimC+e785X7yvoZhye4C39gJLoYIT2mBLPNa4csvGZB+6sSKBlnBBC8gWAksUZ5JiC76CQ3hE5pQne+BjZnDxJgItLWNjqIwQzr0mRCDekiY2N53sqpmUvqyqk9fOE=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM5PR21MB0634.namprd21.prod.outlook.com (2603:10b6:3:127::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6; Wed, 20 Apr
 2022 23:08:08 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%5]) with mapi id 15.20.5206.006; Wed, 20 Apr 2022
 23:08:08 +0000
To: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Subject: RE: [PATCH 2/5] hv_sock: Copy packets sent by Hyper-V out of the ring
 buffer
Thread-Topic: [PATCH 2/5] hv_sock: Copy packets sent by Hyper-V out of the
 ring buffer
Thread-Index: AQHYVPJQ2x5AuSKQKUKyCCXjvMGbpaz5bN3w
Date: Wed, 20 Apr 2022 23:08:08 +0000
Message-ID: <PH0PR21MB3025E9E1C77B3EFFA55DBBAAD7F59@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220420200720.434717-1-parri.andrea@gmail.com>
 <20220420200720.434717-3-parri.andrea@gmail.com>
In-Reply-To: <20220420200720.434717-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c32350d6-17a6-412c-9d4c-e2eb1c47fa88;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-20T23:07:17Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5990577b-c182-499a-3062-08da2322a24c
x-ms-traffictypediagnostic: DM5PR21MB0634:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB06344673B633B9DA443F58A3D7F59@DM5PR21MB0634.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lf1wpUK2R6NDOR3PDsVbPIVh/9ta5HAV8LVGDenoqLLA0IZ04c2cAfyQmSp4QdxObotFW3snSuUfLITkJBQFm8jdqb1pviAY3CzAkh+DN8a0FXQ9FJ0R66jYFuWwaHVsK1md2QEBGqJYo056sqszHRBMjzTOq6KULIGNaOgAKeYrRwpIjBJRt1c9/KgQVkrew8hYgfMJ7m9elP6pthuwbKsGlNPAO+O6Nx7L1NsgVQuwnK2/eTbfcOgSKPiR5G8ImdKoC7ESFtWolT3w4y0/Y4pU2kQwGTtD2/NSHFN5jCS+pHm5GvbIanhAiwzWWCHky8bNQ1rTteauYNpozXbmeapjQOsFMGqI4s5yfsNMa5YUh1xqg8eRCr8l77z/suCBHll2kVal2yUFO1KDVBUHKrIa75CDABMoVHtfZ/39MPHvhtXTabC+O6PjleG+/kkSbpPdB1ib28yc3aTpVUDosJpAdS0TMzkX77/y5d/ADVWKzP1KW+fOQOliYx9ZB+U47wcGtK1Go020dD7emmp7IQrz3eJFVlkzA5uMFITM7ghShXWEEScRilI8bGVOJwbrB5brMgj2p4vNkbRZXCY5U2HkxUVAuNd20afJEkoBrwWnLOcZTaIBh3dMAmO09jU5dsskwS3gGQZK4FbCQwh8FXaHy0O67KN/KxSFq1myhByeGoIrhDSWgQA68eIaonIb50IHNUikpTJYdUMuVuekE0iAoOcTY19kebtjh787WPPaG6pJ7/LYL4BVpJyAmf06smDZ6v2Ekce4FmeTr9FRTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB3025.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(26005)(8990500004)(6506007)(86362001)(2906002)(9686003)(186003)(110136005)(66946007)(7696005)(4326008)(54906003)(316002)(8676002)(64756008)(66446008)(76116006)(10290500003)(66476007)(66556008)(38100700002)(83380400001)(38070700005)(122000001)(55016003)(508600001)(5660300002)(7416002)(71200400001)(82950400001)(8936002)(52536014)(33656002)(82960400001)(921005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3eBSCHLZ2/oYV/x7tGqf+JS/BSDrlOOoYG43+62KMuOpbqiQjr7hM74X8A7i?=
 =?us-ascii?Q?+GBHEZSBZ1t+zSniihOmkM/TLnyRkxsMUvLggFofRzbLUO68c8GvtNZaM2Ar?=
 =?us-ascii?Q?/Oostnn0p7ME3tjkMr4QRu11bcHjV3NTSR9jEMUTZnL6e2AlfdaGB0gQU7my?=
 =?us-ascii?Q?+WwQsd3Va0qhv4Phtv6RAQKa/KiQw2D5tmEGE2hxKsX6OhoXo6okfUjVFol2?=
 =?us-ascii?Q?tu2XU4kx9xEbkH8Eoq4s7uul2ouys/txS8sVoZroR7YW23pYv94SHZhkh2T7?=
 =?us-ascii?Q?QD1zw6tnmpirQpg3ZWG00/xoXknl2EVymkZpDqzRTj90T2AMWtNH1TquthYy?=
 =?us-ascii?Q?jUOETkUAEMvBw5BQpTpZ00TO9QXACKTWSwA4U1md+Mo+VQzSXBXGb0XBn9uD?=
 =?us-ascii?Q?z5d+n3+fQ3Ye30qKZNjUUmfazlqZVYxE2NI73jVSkRkOyfVGCFJLjR13NkiJ?=
 =?us-ascii?Q?Z3nCHagZ2oATiGwfDxJ3YSCtH+XOZi+zcHPn6nB6+fD1joh+b3WIuTmX8wxL?=
 =?us-ascii?Q?MnpvmWfyETBO8+nX8yOw9z4XBILh35GQ1zIVNtiUoCt5PfJ2C9CnZH973824?=
 =?us-ascii?Q?j2WudKgLxmfhuBBZKelCVDhOZCIQQQrfuMmpg9SWI+zXqVBNmpria7w4ADfc?=
 =?us-ascii?Q?3buedkG7h/qJcXQTpbZoDjB6xJh6KjhszMOuU7gMdTIA7wKBeXENDiVjxbiP?=
 =?us-ascii?Q?XaG22YuHIyOcivtJ4E1gtkbhv7ClJli86r73h4QNSCCc3o7SzxA+9ApheUQj?=
 =?us-ascii?Q?RJh7G/roe9EDx7V11u8RiQGS1hYll23+hDMCOEw5yfZzeBgM1Poob7a7lr6U?=
 =?us-ascii?Q?qqedL/pchVsOgGQ0n72wRe3FkmAgC4V+MAEELI4cHLCQXglE4zJ+GwlTtiQ/?=
 =?us-ascii?Q?YVrkKi2LuIXY4z76tG0JiV/oqSafIjIiH0E+v9a+RwQugCq1pVaV34fncCTd?=
 =?us-ascii?Q?1vCy+ilfXEnjL1clZddhP0+S1MjdTwbpjETd9Hd7rftn4qead+RHqAIHcqla?=
 =?us-ascii?Q?Iz3R6as3O7BD6NBCvFAWvn0kaHuP6rL6+oBrS2AtXKRvTlZqOsaeu27y1fos?=
 =?us-ascii?Q?iMXUyqThkIJtEUScStjrvEnXiktCzFQ1AOnMicijoV0lVMtpZCONpPE+F1cf?=
 =?us-ascii?Q?RsC2DrT5PxlJ+xFPu1cFnTvJ8dMooUXHkjLvikI8QOJv3cj1ycOTLOQMSpYU?=
 =?us-ascii?Q?d+PssGU+zbZNW7OJ8W6oIpm3kC2knFNMPyqmPP964Y25Vz/ZotYwO90gVt44?=
 =?us-ascii?Q?h3JN3GEv1dGozeSz8V4Tw58B8yHEr7aIEGu/Pv3qH77Neokp7DgijQidEdMC?=
 =?us-ascii?Q?qJhRnzaH24RHLI3HjuyXmLX+HARpuQo49TgylbwgKGdk3SLWZ6m6depBSfoY?=
 =?us-ascii?Q?5q68jM76/nF4WNUaxa1o0mJ9ekQyfjtN9wzrA+oLxYv7PckjFpCAetg4eQ39?=
 =?us-ascii?Q?TdZ0cPh/4C7WdfiowfBGS6Aby/oaV8nb6x64Yx76lIxW4YQXQY798hf0GSIl?=
 =?us-ascii?Q?u8GBXxOAItwWeETFl7X+SPJIlbVHU0LNQ3v9vtD76i8fk0/Brvo7p5wXod0h?=
 =?us-ascii?Q?x5CC4Y3LVW+CY1c+ZiZUmksz6umjWmBlI/HvJpp2moggT+uNwAUICMKbYsyT?=
 =?us-ascii?Q?jpL56IzCW2dAEXPwvAanmUcBOJgsnqdLIOb+RwDKnEXoRzOx99KYe/vilqvI?=
 =?us-ascii?Q?fsZK5ohX/fydY7qYJM/JMtNv/QM92nSkXsuFiAWBdDOLxpLI742/oSCnsx1B?=
 =?us-ascii?Q?e1OIfPQld6DyemEOmwNHHpXH7u70LCg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5990577b-c182-499a-3062-08da2322a24c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 23:08:08.4908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpB9QM53TqPM4i3000+8QAgG2pNX0AFeUn4L/1mHX0e1vqP5irZqzSMOIenSBJxMc0YjkB9VJLsBi9jpbYIUv95K6SnraGV6ZSV62U9anJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0634
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
From: "Michael Kelley \(LINUX\) via Virtualization"
 <virtualization@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, April 20, 2022 1:07 PM
> 
> Pointers to VMbus packets sent by Hyper-V are used by the hv_sock driver
> within the guest VM.  Hyper-V can send packets with erroneous values or
> modify packet fields after they are processed by the guest.  To defend
> against these scenarios, copy the incoming packet after validating its
> length and offset fields using hv_pkt_iter_{first,next}().  In this way,
> the packet can no longer be modified by the host.
> 
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  net/vmw_vsock/hyperv_transport.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 943352530936e..8c37d07017fc4 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -78,6 +78,9 @@ struct hvs_send_buf {
>  					 ALIGN((payload_len), 8) + \
>  					 VMBUS_PKT_TRAILER_SIZE)
> 
> +/* Upper bound on the size of a VMbus packet for hv_sock */
> +#define HVS_MAX_PKT_SIZE	HVS_PKT_LEN(HVS_MTU_SIZE)
> +
>  union hvs_service_id {
>  	guid_t	srv_id;
> 
> @@ -378,6 +381,8 @@ static void hvs_open_connection(struct vmbus_channel *chan)
>  		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
>  	}
> 
> +	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
> +
>  	ret = vmbus_open(chan, sndbuf, rcvbuf, NULL, 0, hvs_channel_cb,
>  			 conn_from_host ? new : sk);
>  	if (ret != 0) {
> @@ -602,7 +607,7 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk,
> struct msghdr *msg,
>  		return -EOPNOTSUPP;
> 
>  	if (need_refill) {
> -		hvs->recv_desc = hv_pkt_iter_first_raw(hvs->chan);
> +		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
>  		if (!hvs->recv_desc)
>  			return -ENOBUFS;
>  		ret = hvs_update_recv_data(hvs);
> @@ -618,7 +623,7 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk,
> struct msghdr *msg,
> 
>  	hvs->recv_data_len -= to_read;
>  	if (hvs->recv_data_len == 0) {
> -		hvs->recv_desc = hv_pkt_iter_next_raw(hvs->chan, hvs->recv_desc);
> +		hvs->recv_desc = hv_pkt_iter_next(hvs->chan, hvs->recv_desc);
>  		if (hvs->recv_desc) {
>  			ret = hvs_update_recv_data(hvs);
>  			if (ret)
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
