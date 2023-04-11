Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DB0C76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 07:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C249E415B9;
	Tue, 11 Apr 2023 07:21:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C249E415B9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=FxQRbfDx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rPeR63OYsU2l; Tue, 11 Apr 2023 07:21:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 30CE640982;
	Tue, 11 Apr 2023 07:21:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30CE640982
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19855C0036;
	Tue, 11 Apr 2023 07:21:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF11BC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9EE2409CB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9EE2409CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jn6QvsoJ0Gx5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E153240982
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::622])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E153240982
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/1YpoYryL+3iNwguSX1qqlSAyQP4jSXtzdjqYy2s74yAvErgcBl04/3r2u9Fy86HW4WB8Ke7bJqIweYtaL5w+txi/OwkLP/qMsUFpNuK2NCu1ujoSK1Jn4cp8kXiSVEZ245vGO8DdJy3L243BFLCJCUSyjLq7uauVTj7OcLuoUAoPKs/2XED4Rw5AOyPBJg/89u1lZZ5V56xMMqpevUz4KRbfhrBz0MykVYHDA7EP7WT/SdOkcMaiQ1x7ATTr+ur2Ksxfa/Mv2iPIVaTpfL+GEFniG9ExfwhgoTlOVQYZJis9HsZUzWV7xkFg3sPA+q9cU9pT+BesF4UliPcqsCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Cd3EIE7ATWkNkIHkVLzZ4nl7KeikCQtUTWKHEw7j/s=;
 b=L9/2LyQcbNGsQk+Sq8jSf6fj9QBsi8xQHjEwxH7TzCwJtDJA46NhzDa5ER+rX4lbCXx9jAbchCh4uPvfLzTDTerklEHv1x/J71dVi9zISpQEvKx3G29ZaaQ4tkGw6OE/DbupBy+V6EZ/ay8H5e0qwDRtew9os/vDXB2On1uEY5piVB+I1B635YmbDyWAZxFOYOcqvKiIQuaZbWdCoxtWfvCUNmi6adHQ+lbJcbFGnzSQ7IzIPWJN/qodyhfPZMKKDwKCLOamtLFhj8ID64buThmV1g1HJHXvOfWHZU8up+LHurfElNG4M+ZvbZTHpd6R3tRkp3gx+zNijzMaaeDayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cd3EIE7ATWkNkIHkVLzZ4nl7KeikCQtUTWKHEw7j/s=;
 b=FxQRbfDxzuztQb8QpT91VEM7h+jE6X74KIjyP5rd5nuKG7o2LMULtWjZ19r0JmS1gJS3tevQtKKgskya4/Y1PYBoVW6yqcIr6FcU4QuTvSsBpMvqrBsdOAbnkEsV4O5Cpy8tqLr2deaoRoYz1z2s89jIVeO6LixPl41pPs2OIpc=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 07:21:11 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 07:21:11 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v3 2/2] vdpa/snet: support the suspend vDPA callback
Thread-Topic: [PATCH v3 2/2] vdpa/snet: support the suspend vDPA callback
Thread-Index: AQHZa5Oatwsu9+lsk0+89m2JSoC2Aq8lk96AgAAfA7E=
Date: Tue, 11 Apr 2023 07:21:11 +0000
Message-ID: <AM0PR04MB4723C2ADEB78B35B05B86DA4D49A9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230410100237.3499578-1-alvaro.karsz@solid-run.com>
 <20230410100237.3499578-3-alvaro.karsz@solid-run.com>
 <e519afc9-c7de-e579-5df5-34e024e32273@redhat.com>
In-Reply-To: <e519afc9-c7de-e579-5df5-34e024e32273@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|VE1PR04MB7261:EE_
x-ms-office365-filtering-correlation-id: facd8dff-7a51-4d18-7e82-08db3a5d539d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4nHLXk6lO5c7l83F88eua1uhVOn4tul2sztiSdTBnH9MmfSYq7+2sOE7oRq35jbNEsIbR0z47EtYFEmAoDUmmMWsHrZlSstY1JZdLyeIXkxrC7ggSgeN6qzjYQDQ57tXL7ZqoTOOdfANiRrZ1ffwt+Li/PDU8F/W70hFaK1bOKvw8HAftS8vw7CPOvFFsEiCz1cDanVcyKXquiw/NSDPkGYbHwxLHNxV/8TrFh7bH9NCh/Y+TB60nKRNUZzdLioU66ECGqZ7lXWwu1pxDyQIDfn/wK7CizJHJeEZdY9ZrVrHNywRARenLWs/+zczsslXmSBir5+9Vm+PbeFmtwAn/iXt3XHrmtSwkqwqKOaLKWuuCS7clq9GSudvRNmiEWCHgf5m75RDi3TFdd32ZIvSRFNbw9b1PXPuvTuYL0rLcFFe6H7kE4RZ97axSnu47OASHLIzVcHKau0yapvmCZf77bJLqGIDfhHQHCSMkckuV7VYSl06T60vFzgjLPaxeFbpWuhx41BR5jErxFqmHyGRA6oXclMxNdkAlghm/tjyQAXU/3jBYKX/oSTRiR5sIbwctvy27XpbiUrOP8YLm3whjc+U0AcxG1x3vbLHt6Fa2lcqMGXV20hfyHfkigsKrvH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(376002)(39830400003)(366004)(136003)(451199021)(71200400001)(7696005)(478600001)(316002)(110136005)(9686003)(44832011)(6506007)(186003)(91956017)(2906002)(4744005)(15650500001)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(66476007)(64756008)(52536014)(8936002)(66556008)(38100700002)(38070700005)(122000001)(55016003)(86362001)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6t7sAx3ld3v/ZHxJOk7nOTN8pUs8vpHdtS0GshupGGotHjMrn9or9kHjTE?=
 =?iso-8859-1?Q?Hpzdoy2mq8K8FIKTCUOaTSTAULviFtEpNGjBOAYAJ3OVLYtkXFJEe1hvnj?=
 =?iso-8859-1?Q?VpXCR/eTGhAHGbCjQbmE89OT9laJOQaO5LEIyo0k7QNa/37+IQG8NyNJgV?=
 =?iso-8859-1?Q?+dnNdUi0zarCYK7Gt7IfujstHAPwO4yl0hK/6mJ7R/NZJB5Zs73pJhyYMA?=
 =?iso-8859-1?Q?QX7SsAbKFQtNWzTD+nV26PmSMcB+JpiAeSkeFnrmMqn6HAjA6dSKn4Vt1w?=
 =?iso-8859-1?Q?HQjKMyJCkvav//VmXGB1Z4/A1yp9ScfYI9IVtHDVS4IIIan9b1mC51zLM4?=
 =?iso-8859-1?Q?gAoe4rGA3y8GKUd4CUbDph3YC3mJki0EdOIUzCOeevG0gBKlFd8w750/jh?=
 =?iso-8859-1?Q?Em+idFmt2pmOeqwX70+JHDJ5jb59JjHAZDe3kl1MxWLDulYug41Clx1Lhi?=
 =?iso-8859-1?Q?rPAzoYJGGYHFfdsLwST5Lvo+CyMm+itVhz28w0WMUMdqDQ7wQe2iVAa1RI?=
 =?iso-8859-1?Q?rCg8UirlRr08HffSZ5oel3Q84szlDGZp3bJqYaHHOzzfsQRmswmOqyW6sI?=
 =?iso-8859-1?Q?zKFjCXGRs9TVY3XZEVlguJrW17yKb0xAJEuXqyn/BNnbIfuHrX5JQjZeZM?=
 =?iso-8859-1?Q?fxYj66Oi5ClUuq70/CudX/5YsGOEV5oxqU5h3Nc7v1JtbpBZgOPHgGg6WF?=
 =?iso-8859-1?Q?XWJJ5w8VrmAF40uI4XhQqBfBv3eIDBf/uRjBSrGr5VwCLNo0NN2s4/h0a4?=
 =?iso-8859-1?Q?Ga5Rw9EUmQQWQ81mgtnwo2ZrQqDMpbEr2myek2IgR5r/eLb5cXx8ayr3KR?=
 =?iso-8859-1?Q?APvl/LDWovSgnaMrLxj0ghBQ1tXqkvJ1kB23OM8HDLpZzFL6lvfg4xfF0n?=
 =?iso-8859-1?Q?wp8XHU4Ngtp3ctyMuGEjq5p0stDxtB4Hzzl8rgVDJ4BPEWNQW2Fy+9Qlmi?=
 =?iso-8859-1?Q?nZvClwijEuteeE+A1sEBSaK3enNp1icLhvbsfzOlJUnKT6yjF0lX+jej5j?=
 =?iso-8859-1?Q?N4GIX+HvyF1S68bO4NjhYcAwbdLj4sxCls75T+jpAyOpmHUTkF4arcnkmw?=
 =?iso-8859-1?Q?d8iID2WCSW4zodFOfEQX2rEg/00wCgHyD3r7w9Z5M2+SXlmFEZozrMxARE?=
 =?iso-8859-1?Q?q/eYK+eqWAL7l0BZXiihlMUJepg3tF0R+FGsHu+1MQSqlO4vgoztSwPFY7?=
 =?iso-8859-1?Q?DV17k8sUpsF+ZNdAqKPGuN+ztevFeoEjeZD0MUQv2Wq2IRvgQOSkxjSBic?=
 =?iso-8859-1?Q?RRVHriVwUnIosjglh+oGH8FDEP2e/FW7urWxeWLQriWcBbLMFHf0u5aN2i?=
 =?iso-8859-1?Q?jpvfPqr6wTF2v+0whfoLp+gQoVzICVhsXeVSFyx6/Dmxb3RSpiASyRKy+H?=
 =?iso-8859-1?Q?f5Yy2LxNMyuvwuH6Td4nWA40bTiXFpZhLBFNJdGp3pBvd4pbyx2t4g6nXG?=
 =?iso-8859-1?Q?d4yUYQx5Kxs5WsCZlx2V0R4Jg5kMXP37W+ybUlPRyBneojCC8cpec1E/4W?=
 =?iso-8859-1?Q?Vey0xBnkvY4gaq73O7SLR5RTh7zSjSZBaQWVe9nrkzNVch6Uw1TOR8YgAL?=
 =?iso-8859-1?Q?ZqCydnlDdybZ/orRugunoIAhZ8rM9tSfvDmxvHIj0gcLbTB10TRfzommyK?=
 =?iso-8859-1?Q?OY3j3+KfDa48hSoIkTD3FFO+TMc5h/ut7pzl4UImAXDD8KlSIauz1WfIxR?=
 =?iso-8859-1?Q?OQ19D+rxPEeGyZXQeguq3DsIyQ1y3zqDLP0nUBmI?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facd8dff-7a51-4d18-7e82-08db3a5d539d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:21:11.1867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RUWi6T38fW1JsNpk7AoxVrOVrjcvR45yXZpcRy1X7sAU7lTGDo0en6s3aRECH9IE71zFYioX+QofblfJutgEmFMxG0vebru/Yjb+T7pGv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261
Cc: "virtualization@lists.linux-foundation.org"
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

> While at this, how about implement resume as well?

I do intend to implement resume, but I'm not sure it will happen soon enough.

I could in the mean time add the vDPA part, which is identical to suspend, but with a different opcode.
The DPU will return not supported error in the mean time.
But I prefer to send a resume patch once the DPU side is ready.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
