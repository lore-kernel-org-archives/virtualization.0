Return-Path: <SRS0=mz8r=PR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09EBC4332F
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 15:41:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5200C61184
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 15:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5200C61184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E55134015C;
	Fri, 29 Oct 2021 15:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2WWLyHFRzpz; Fri, 29 Oct 2021 15:41:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 32A3340168;
	Fri, 29 Oct 2021 15:41:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0854EC001E;
	Fri, 29 Oct 2021 15:41:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84F93C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 15:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D52B80EE6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 15:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3CBh27umRAhr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 15:41:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43A1880E6C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 15:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKKYLOVVaWL7rnpf+sRNjjwEl/XIBvJCE72min7yAfwHA1Piu9OXtS7ngbzl/qtAIFjQS4VHAm/NbF/VVHgF/ezZC4bVlfIVWOmsQ6f4vOQwSL6i1DHiRmmynrvjecP8DTOI2P22lwdvt8QufNa6NJ1c9kRpc8V/0ImF9Syy4U0URsJWSPgjPnJDq/DAaATGOiJq0JhXEA34IEmP/ga18jH5aFZQs5t9YrMX3JEAvb9OQFfRWwuua2bdKhB9rA5WCVB+dDPMNuslsdDl26BKiG54cvB5gpjaGUg4vdYM+ZLxB4Y+BL0O7JefzBnC2A3JSFAJmOff1Rc833xByX6UyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kTb1tL0e3SUzAekTPuW5nvZKObrCSa8OnduRk6kZ5s=;
 b=jbT2XGcJbngXgDS5JjZ+3dQR9dCfGsR1tcgWECo+1Niqmx/1WTjn7IG/VfEUqhYrb1iRq1nl+XBcIVLUAUV7NIZk0ZXzVCGsROJ10so2fqC03gN9LNxhGYbPJXtbdbidilHTtMNNX541OqXMwPZn+l4ia1gm/xUJdu0+ikgSeOj1FUbIo+0ciCpsOEhM6ENxc6/yCIjdK3EJLDTpKOZi3HTRSSLWG3Ut0OFnZX5SFADF2b7ReiQKYBxWTD69+TIDd7qk+20cBSXPAw9phW9DF7uf05iUylgzKCsKO2HNcXgpC5b3dbXGcCn/wha8GRHVGvNIaM6olmCNPBwuo1ZzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kTb1tL0e3SUzAekTPuW5nvZKObrCSa8OnduRk6kZ5s=;
 b=SKGJYmAd9JEWfKmzeBh5KHqj+CRNkeRnepu+z1jLwY7A9h81E69VSiKCPRc0DMKjr/Q+a0jUIccPHysehwWEwRb39DnoYA0hvWMB+7pN/cenxmLGydLvAsMPM60NCjpMlAEh/M9ilQiha8fkmfTGoXIF6uG+lD7nClTvlCi88ukUjeDhzRDmpjRDPxFt0MwuQHWhj35BlZJ4IXGR+HQBgBDt9jWFXrMZAYFlnnOXZOnjgkGS9RfHGKh6z5e/6uNLAonwaituq4hYU3OXXmiVjHGFGSi8CJgojd6S83DlzEvRnxJIWYwQCyI1We82g8dclq2fsejkTBRTitRngGn1vw==
Received: from DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) by
 DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Fri, 29 Oct 2021 15:41:23 +0000
Received: from DM8PR12MB5480.namprd12.prod.outlook.com
 ([fe80::49c:bb13:474d:6ef8]) by DM8PR12MB5480.namprd12.prod.outlook.com
 ([fe80::49c:bb13:474d:6ef8%5]) with mapi id 15.20.4649.014; Fri, 29 Oct 2021
 15:41:23 +0000
To: Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: vDPA bus driver selection
Thread-Topic: vDPA bus driver selection
Thread-Index: AQHXyz+5W8bHEdMi9Ue0cOjhXwdA36vm745AgAAN1gCAAAHeEIABKSQAgAAA2yCAARsbAIAAyx8AgAAQBQA=
Date: Fri, 29 Oct 2021 15:41:23 +0000
Message-ID: <DM8PR12MB54801714D2DABF97A7269EB5DC879@DM8PR12MB5480.namprd12.prod.outlook.com>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027154728.qkrtl6jtfoqlbwfu@steredhat>
 <PH0PR12MB548104D8BE92D2C5DC49A7A4DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211028093740.jv7gfqrgrmq7elje@steredhat>
 <PH0PR12MB54813F6CFDF8A1E1F7AE68B8DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt+iwKc=O552rsMUWdmT1MGVpUJrKsjdjv7mv=4uX1uOQ@mail.gmail.com>
 <20211029144100.eybykx7o4tpwmjph@steredhat>
In-Reply-To: <20211029144100.eybykx7o4tpwmjph@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f765a839-616a-482f-45ae-08d99af28fb0
x-ms-traffictypediagnostic: DM4PR12MB5038:
x-microsoft-antispam-prvs: <DM4PR12MB5038D551E6B80F97027EBC01DC879@DM4PR12MB5038.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ac50/nWw1ZV3DRkhMOnPTjkdGwG/7IqUtAGFhXPpBrJ7tUZ3ut0hBWlhuDL9yXd7HXrnD0Aop3k25CG3VrzboQwepiA42AvvaMewt4wOdfCxfh6RgDfjvrozLxMxcgZK7t70XShNOUBtqjcpAuWInhDuji/rklacQ5RVlkdso/Ujsp7OpG8BHyxljiBaGI8cPgLBA7fXyg+6Bh7CXVznlujMdMz66g6i1tR9IOQQ1iRq5cJCqBo+SkI3GVG8RVNBeDTfX2EVAeag8WCX1FwNR2KlGxXagM8I4BV3+fM3KvGEzsuJIWrcgdQF9Fr3jxKjIoFInAFTedVPIqRiK148vwgF9XBLVEXQxjjJBCU6Ew/vT9OWf8J0Zp4EE5QmRxPgLJmHWEVwSaHJPS+uNa5bRKHO1HtR5YKC4bEm8FKukz9zvmQyXnvIS4HpO/YXqBSrialaDyrvffGpSBBRSWas25fzaoDOR70p3FlFaryHZLPpyTMDxl/vQFHapE/yFQe/WpbCRk7uDqMGXeoJZj5aSoB7MMnYu6fJLA5rVfPwSZx1loLNJYYGr6c6G0hdSY7XIBbI1ZAyGNpVb9gb6kKPclsty1TzdyO1PNBxmWiUdyAXqIDzHWxMV3Y0UsmDPoi4u3GuTiehYJoYi/wTOaTSSvmvdFscuOaFUes3v/4kEdsI4bI5OB5HRshu9jrXryHIktgYrArjlFSrbnb2nbcwOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5480.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(8936002)(52536014)(8676002)(5660300002)(33656002)(38100700002)(4326008)(71200400001)(107886003)(508600001)(4744005)(9686003)(55016002)(86362001)(66556008)(64756008)(66446008)(3480700007)(316002)(7696005)(186003)(66476007)(26005)(2906002)(38070700005)(110136005)(6506007)(54906003)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cS8Nl+YJoxwf2rECEQuJjqhNmITlPJKiTlK58teAGBix1xg7nqyr+I05itue?=
 =?us-ascii?Q?c7AttE6ab5LyXIuPyUpBvX8SpSGZOjKBTZZ/SCCUfhqcgE4xWLiKot3vJNmQ?=
 =?us-ascii?Q?QlCj0oJUtgEa4x20pq1vZdMx6YHideiJ3R2rzORJt/yj6MYw/p0GVCyQTI3W?=
 =?us-ascii?Q?GjHdpFz4jwYgsaaUPj5QHRVWj4HwIC0utOP0+N7kcQY4qaOrtAtFvZD2+BWi?=
 =?us-ascii?Q?1scWh9yRQAy7mOl42NqK0PzuG7WuOIpsReagDAwzgPYRbK58fs/N0FQn0CD+?=
 =?us-ascii?Q?07Xjk3zn1aTgIDkDbIynNM7iZKoBMUl7tShmJB9pgGf9oqk6t24hUwX9Fv8b?=
 =?us-ascii?Q?rEPu+WMPZAr8prIXPM7opbG6/z/m49oHf5PBM4rM8aMC7YVhW6ncex7JNMHU?=
 =?us-ascii?Q?KahSf4y2Z6X/wdsuHlzZRfBQdl6XC5AlnF4TnKd87f9u9nubhdu2eoO70q10?=
 =?us-ascii?Q?csCHF/usxUZmSEttvjCQQx4LlFXizv3i99NMYVcjOwl9H7Wt2tW3WQX/nSnC?=
 =?us-ascii?Q?yF2Xe6JUtIEJl389LLits+o3aL+2MWUXNbT9ND7csOlnyLrgpZdkH+uPmv0S?=
 =?us-ascii?Q?rnAWPd+o9FDlB4iVrV0vx/6PAK4L5RAohG4k5y4qGGzxHHrdoDe69Puj39aq?=
 =?us-ascii?Q?NxTgpq1Kpxo4lPJWprc8LtHTSTADSebWw9O6v2yDSgds9KnUuXJtSa/pAwsk?=
 =?us-ascii?Q?Ga8IdLTuUFn+VQY1NNKkCGGxqX0PBRyWgOhT64m/GJeKO4Bo1MH+odYFE81C?=
 =?us-ascii?Q?j5/B7R+pvcMcNP1Of4kDCQ4WsqRTyNCRF8G2F4DmnyX/WQbBKi3gYWIL3was?=
 =?us-ascii?Q?QeAjI7iwWbgyWIqdSy1gd0T1Pv6WBrXhu3SfN/CSSBYWhu6ijhNpQdq5G3Hq?=
 =?us-ascii?Q?8cJ4iGfM0qS4lItkoZwzcUx1NmPChvxN4p2k+hL9LEUCGXjTXD7Vcssl2vNE?=
 =?us-ascii?Q?6FtDxZwbEIqF3B4gf/nGs0b35hOpDyDV5AIiNdQlfXYd/BfDXC9aH60eqisu?=
 =?us-ascii?Q?h8G6XBUqBbxuXWFK6S/pnRTlG9pJb2Qf34+htmpD/+5iEqOTTJTHIPoL0e3I?=
 =?us-ascii?Q?imOCgcsI6//rU9tQGqsZ0yVwf9GJ1ENMT4ere7uf0ADyZ0IvTQdNUF2Merd4?=
 =?us-ascii?Q?D5Zm3MpF4GTX/5jeWDfNlwQ15REUvek2pm08wc9wC8Yv/tJh3GpC6cfpgaSV?=
 =?us-ascii?Q?jgHmn6xcBgSrnb9KwEzCcxwTYm6X5i/pcr1UH93aaYFR8UwvJzSSksXVkcRk?=
 =?us-ascii?Q?b+wN0QTiHHZuZl0ORlljIt1ROxXubNzOGwIZ1dxrBxm658V07zLb45nfNMbF?=
 =?us-ascii?Q?jjNRuN7/AhjwhzFOK9R948fae4Zb4yLxGhdosp4TjpU5Z7WWnfnzsW5oLreo?=
 =?us-ascii?Q?P1s8VWdgYP+UVj0A+A21mg6M/GKpdExRZ+Fcy2Xa0ZBMtgMiKceRrYJZEc10?=
 =?us-ascii?Q?MB5u+7AznrqZ32CJ94aGd56RMwxtYwol7z8cJh7EbCO6d2ukZj/VGTCc+1xO?=
 =?us-ascii?Q?F1J6jlUjmno5yGuR0bG+W1Jhk9PGRPb+Io7+vnaIbKgowiCasXnodjQ8dw64?=
 =?us-ascii?Q?Din0ndoKqD3OK4pn8daEHUgIH/MM1Ib8f6VGOnyTWkvtxOSJrbk0qZb7KBsH?=
 =?us-ascii?Q?hrIP8RLqSg3LnbyKA6C27Lc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f765a839-616a-482f-45ae-08d99af28fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 15:41:23.2774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3jABZZFAytyCIUpfCSSHpiW7vxSTYrM8C3ESUS+GkjWLlBXqzvvLiuQ4Rgzi+3pgA2LRC6CFGsY4py3D7cxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
Cc: Eli Cohen <elic@nvidia.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Michael Tsirkin <mst@redhat.com>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Stefano,

> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Friday, October 29, 2021 8:11 PM
> 
> Maybe the only missing point is a way to specify the default bus driver to use
> for a device. Of course the workaround is to unbind it and bind to the desired
> one.
> 
Unbind bind can be done but it is slower for deployment at scale.

echo 0 > /sys/bus/vdpa/drivers_autoprobe
above command disables binding vdpa device to the driver.
So user can choose it explicitly without affecting performance.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
