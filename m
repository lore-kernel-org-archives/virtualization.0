Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AED0C433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 05:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA88381348;
	Wed, 22 Dec 2021 05:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BmHEDr3jeyjs; Wed, 22 Dec 2021 05:06:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4748E8131B;
	Wed, 22 Dec 2021 05:06:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19372C001E;
	Wed, 22 Dec 2021 05:06:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B865C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 05:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D792F60F3B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 05:06:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vE8_-9SPt9Yn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 05:06:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A61B060F13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 05:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7cOs60zgRoGf8LVNxV/VdZxePM73hHl1bAX4ICkYns1YVHKI0KPza4heDzg8msA38ystZDwPSekofdldx8+A6L6n7o04pGnYFJgfhmM6mkzD9/om4oghAfrtWObYo3EJKoV4bNcFkoe8RSEaMIvo8li7v9FiUHbqrXuciPtZQSzj9A+pjfdswOp/SYzcTJDaWhV+4SWCRNrkMF0hvoMh4mTwK+6e+PU32plWAuw2fBzLvHRuFU70Ls1sYlNILs1jnjomFXPQ2y/3Wyqb6LXJINvJo3AdzI19v0xoGSOkzSvgi9Zcwzb/6jXuPaBnbjrwojcytV1cfDwNdoET742rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsOt2w4NpZEwtcel64alsgH/iVG36ZR6KQqExLZNPOU=;
 b=kepc7ibWbwyBgEG54bkjAB0HpdXkPaoc0ZALFVRM50hdi7OWnjfTt+6sU9bNtzKf7S1gy1h9Ujep/5nmRXsjNTIqcZMckaiC5RqCNVB8yOTlskJuVK05eoVs2Q8nao+K6bFVPptD1w4VrqjbzAg9aKOrZph+3JmrXmuq5wHIjcKuOC3G0eZCNvVw+RZ9vKG2/FZTVe2C5QknlAYH7KtaTKBNw3xEDetRkASFa0iJ7siPs4ONL/yOUoaa4brwzdwOVgPxSqWXH8TaJEPCJwzSD9LRlLdspugGV822dS/F5NyN470SFNj9Xff3g1Ljqc6zNXJLzxc7IYZN+op4pGB3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsOt2w4NpZEwtcel64alsgH/iVG36ZR6KQqExLZNPOU=;
 b=uNOXAMZb+rjIVgpKkvNRGdj+14t+F0m+NRPg+bmHAY05nuLzfWVz/EHue6n7kXTSx5QA/ijV9RNH+9sHXSFDZvdtg5LqmAIsX9Vieho2u/gyfnXgGWVMr8J/yXVhlGu6wcvYI6BiAoH7fsdl+IgX+Ose2E/e/eJdnqAFlCb0X/7eXjp9kNbUdGva3XcoPPHayBffiwQHsM4lBITqh6vVb2MaBaMQv6qlXDJDgSMrHd5W0fS3ZAJ8dknbDQF4KN2vhTuf0y8yDHSii4vJg4iJil32BLb7dh6TPrxsgH+v9h+HSGytUxNZhJcOD5YREeILKyrGW6rphz9ySuYcPQ8UBQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Wed, 22 Dec
 2021 05:06:35 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1864:e95:83e:588c]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1864:e95:83e:588c%7]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 05:06:35 +0000
To: Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Thread-Topic: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Thread-Index: AQHX9o8VseAxGPicCkaXTRx3P5owuKw9wk8AgAAygKA=
Date: Wed, 22 Dec 2021 05:06:35 +0000
Message-ID: <PH0PR12MB54816A7E1D045997B797961BDC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-11-elic@nvidia.com>
 <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
In-Reply-To: <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 690b22dc-8483-4b87-5cf1-08d9c508d3fc
x-ms-traffictypediagnostic: PH0PR12MB5482:EE_
x-microsoft-antispam-prvs: <PH0PR12MB54820C18B732F1AB01E5BC8EDC7D9@PH0PR12MB5482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dRsd7jlBbVsdG9dCOhY0qR1SEOG8dmPc5NwZdxKuwMWmQDTFS5CXN83y0KFB28ImmdqcoxR2nlgHZp57t77AZXQSNufULNrCo32ubr/MRr1jg1KClrwOAd7asaqJR62RcuUTLLveG6DOyvzFqs+MOV8TC93K4TfvpxakNeeGHlen1TvIVJWRkbEEvQWvjboNv+T/nafRR0VkLhPXWFn1eTUuvjJcrwRN//zpvdZuNW0bn27kqfoasb2NpIKafN/cLsz10Nl5KWcxecDZZXgzHYcAVvGwKPnlW3YnCHu37XAlXkX7WRgDdy6wzsveyWLRsKyJ4zqtflat5KWeiSfH6NaGAaM+VTj/FbCgQ//HvpPdJwoZFBy/eIYf6kaVmXplPzHoOCOVObjqU6G35D7eSZ3o9itb6PYUA/zpD0rwLFYuk4PPilthMaVgHsjwWsRsT7JVxVS3SeKqs6txWcj7J4mDIn1KtpmwDJzTP7JD0YIGpap3dS4Na7lYseS7wVvqLGx0ocY/+TSeVYcHdAdFCq1f+V1sTOSDGhkkgnDjUhYzeT/zgAI9VSWX78B2G0moXr4FNgnOm8KtugF18k1R3Ro6+rNgkVkvTNYx9MXtCjpG27BsPnUvtnGwcL1xbggrkrIIWoVzbA2G//K88aa37ZfcS5JMBta9RMmvZ+VEPKuWJiyXkMnAMU3LxlvCDHFS/BDxNja7xWgHNsbhCvCW1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(38070700005)(4326008)(7696005)(9686003)(316002)(76116006)(86362001)(52536014)(110136005)(54906003)(122000001)(66946007)(66476007)(66446008)(64756008)(66556008)(71200400001)(55016003)(38100700002)(33656002)(8936002)(508600001)(5660300002)(8676002)(6506007)(53546011)(186003)(2906002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJxUEJIVnZzNFdiaEU0clRxTHdFMWtnNkNCOTRDV3dQaUFwd3NML2MrTmtB?=
 =?utf-8?B?U3QwakhGNmNOQ3liQWdMaFpSMmw3ckxJMWZhTHlKV2s4MXZXK09STFR0UkxM?=
 =?utf-8?B?NllML2ZrakRzTWVPQXBseHh5amxnTVVzVUJEZmpUVmg5elA3YjdVZlNudTlE?=
 =?utf-8?B?S1ZZTS8rNTBaTWtxOVg1V01NMk1ZanZQYXlXODExbVN3TllYeHNVNnlYRXhK?=
 =?utf-8?B?Yk9tTlNpcjkxTVZKNEErUEs5WFBWUFFNWlJZUGJWV25taU53OVd1TThZd2hS?=
 =?utf-8?B?d00zbDJZbFphemh2aVBDRVNUUkJNQThxVG50NXZyMmtud1lFL3AxR2I5NHRF?=
 =?utf-8?B?WEMyOWRGM3gxTVg4M253TU0xMDZhUmpKSDRjNWVaYUtFTnFKUzhnL1lRRm9X?=
 =?utf-8?B?K21YVXBoeEVrUkU5Q0tNRGptWXNuSVNhZDVibzBSVlBSaGRwYW9IazFsRllI?=
 =?utf-8?B?ZmxoUVpMU1BrZmI5OUhvNnJRdWhxV3dRZkhhYTNZUjVaRkxtN2VQbzhidHov?=
 =?utf-8?B?RVlTdlNIUHFnVDFsaElScWxlS3M2STNHL3cwS0ZBUnRjVHZTdk9FWmNIWkxX?=
 =?utf-8?B?c3Y4UDBYVkxkc0tFTkNCWHNmdnRnclcxd3ZkRjY0NWFITHJwclF0eHUxVnhG?=
 =?utf-8?B?aDdqV3FzUmNYM2FIR2ViZVUzUFgwV1ZVcWpqTE9rZUUyeUZHL3MxZGIzcmdx?=
 =?utf-8?B?bDh2QzlMbEJYSnFnV25BRWhZMzI1cTBUV1pQNXgvZ244WmRsL2lHMjlaOHBk?=
 =?utf-8?B?cFRZYjY3T1lTZDdtb0Z3OGpSZHhyNmcrZnI0N3ZTRXgwTHF4REw3YmREdkZJ?=
 =?utf-8?B?Tk5zdnB5UExud1hMWHRXL1Jwa1F6QklDU3hjdFQzV1ZYdHYwWUxFY3pPUDF1?=
 =?utf-8?B?VG1uOEJJSmtQV3FaMGR6MjBuT1FTRW05dkNaMkJjdW1qSFJoamFESlhJdDh4?=
 =?utf-8?B?bWZsbXBranRsNXJnbVVqNnFSdGdsMXpFOWRrU051VEt6M0c0dlVXeTV5MUow?=
 =?utf-8?B?YzRHd0dHeXByOGtsdnd4YzZnS3h4UVRIeEd1NVNJK0VxOVRkamIzd2dUcUJP?=
 =?utf-8?B?VTdSdTZuek1XLzJXMmU5b2lZNVFrL3hSY3FVdjNXd1ZyYmdDQlBSSWY1TWlE?=
 =?utf-8?B?YjdhMXFvMTNCamp1Z2tib3hXTHIrdTZBSVExeTRVQ2tSTnplWUpJUXlEcXVC?=
 =?utf-8?B?UTlVQ3hEcFZNbS9RWmZZMzhBeVN4cExoOTJvOVNUcno1M01leEw4Z202ZEk5?=
 =?utf-8?B?cElUanh4aUswVFV0czE2eFU5UkdmWVhmOXo3b21hN3hwOGhEdzBFd1JWNkhm?=
 =?utf-8?B?eVlYdkgyd1pGTG9nZVlOQ3JWQUpjMGJwaEpaUllNeG1sMmpsdzV2QktQaUty?=
 =?utf-8?B?WmVFaDFWRXNodDZiSGdUSlpBTGp1eHQ3NFBLOGxZa0tYTlNISEczNDRIMHRN?=
 =?utf-8?B?d0VFVTV1WFdTQTFwQ041KzQyR3VrSUJCelY4VHBsQWVJTGYyVjdVZkkwSlgz?=
 =?utf-8?B?TEFCb2hVNyt1S25nYWtKenhDRTI0YXhhQjR4VE9RYnl0aThzM2dJN01rZU12?=
 =?utf-8?B?MkRJMHNZM3o4T3BnVjErQTlIelZOcnc0R0JBYUh5c3JHNW1FV2NqQ0lTK1R5?=
 =?utf-8?B?Y2EyeXBaWk9raGwzUm9HZ1QrNm5DWEF0NTJPZXpxMmg4dHVMQ0lKQ0Q1cWtW?=
 =?utf-8?B?M3dQblR0Rm1ETUpmU1BWY1dxQ290eUwyZmQzdkhlbEVNYkEwSnF5RTN3NW1u?=
 =?utf-8?B?TVhLVUV3YnVIVlVhbGdZTEw2c1N3QWF6VEgzeWloVDliSGNHbDlkQyt0dE0w?=
 =?utf-8?B?a3QybWJrcDRkdGJYeWNpczJzaXZ5UllIdmxGMkw2YzZobTZjNnBYZWdLRzlY?=
 =?utf-8?B?THpvbEExTUREMHo1QnFOTkRPdVhDZ3JEWUI1b3lyaFdiY3JkWkY0akhlTlpu?=
 =?utf-8?B?YUxyVXdDMVRKOEhvV0hjdmk3R0tNZ0owbjNnZ2RPdVJ3bUZNMEppOFpMZEpB?=
 =?utf-8?B?OWZNbXR6a0JYWHd2N1V0RS95OEdYR3ZBMC9FUHhiMzF5L0xVZ1RaZnUvZ1NG?=
 =?utf-8?B?TDM3K3lLTDZOYUU5WUk5enA2bno3bm9rSUduMDhpM1FIMU5QMHJtVEVzMlZ2?=
 =?utf-8?B?d1VhNUJXUzlqa3dhOG5jaVZCeUpmRUs4S2NnY1VNdWd3b1Z6ZmRVa0xJM2VU?=
 =?utf-8?B?OWc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690b22dc-8483-4b87-5cf1-08d9c508d3fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 05:06:35.5640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfdJGqOoDM05XQwBdpsJlFMPsMeokfoDh415L9ya7oU115TcBB4k2h+8FQ3VnQGYaEeCjyLtfHLz9/ABZ55siw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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



> From: Si-Wei Liu <si-wei.liu@oracle.com>
> Sent: Wednesday, December 22, 2021 7:31 AM
> 
> On 12/21/2021 9:20 AM, Eli Cohen wrote:
> > Add max_supported_vqs field to struct vdpa_mgmt_dev. Upstream drivers
> > need to feel this value according to the device capabilities.
> >
> > This value is reported back in a netlink message when showing
> > management devices.
> >
> > Example:
> >
> > $ vdpa dev show
> s/dev/mgmtdev/
> 
> and,
> > vdpa mgmtdev show
> remove this line.
> > auxiliary/mlx5_core.sf.1:
> >    supported_classes net
> >    max_supported_vqs 256
It should be in same line.
Also please show the JSON output.

> Not consistent with the example in patch #11 in the series.
> >
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/vdpa.c       | 3 +++
> >   include/linux/vdpa.h      | 1 +
> >   include/uapi/linux/vdpa.h | 1 +
> >   3 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > eb223bec5209..4b649125a038 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -507,6 +507,9 @@ static int vdpa_mgmtdev_fill(const struct
> vdpa_mgmt_dev *mdev, struct sk_buff *m
> >   		err = -EMSGSIZE;
> >   		goto msg_err;
> >   	}
> > +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
> > +			mdev->max_supported_vqs))
> It still needs a default value when the field is not explicitly filled in by the
> driver.
> 
Unlikely. This can be optional field to help user decide device max limit.
When max_supported_vqs is set to zero. Vdpa should omit exposing it to user space.

> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -447,6 +447,7 @@ struct vdpa_mgmt_dev {
> >   	const struct vdpa_mgmtdev_ops *ops;
> >   	const struct virtio_device_id *id_table;
> >   	u64 config_attr_mask;
> > +	u16 max_supported_vqs;
This breaks the natural alignment and create holes in the struct.
Please move it at the last entry in the struct after list.

There has been some talk/patches of rdma virtio device.
I anticipate such device to support more than 64K queues by nature of rdma.
It is better to keep max_supported_vqs as u32.

> >   	struct list_head list;
> >   };
> >
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index db3738ef3beb..995257c6bf2a 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -44,6 +44,7 @@ enum vdpa_attr {
> >   	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> >
> >   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
> > +	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u16 */
> >   	/* new attributes must be added above here */
> >   	VDPA_ATTR_MAX,
> >   };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
