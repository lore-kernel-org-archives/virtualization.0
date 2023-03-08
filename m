Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9BCC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E926E40240;
	Wed,  8 Mar 2023 14:08:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E926E40240
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OtzU12sX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tkD0Cz0oIH_A; Wed,  8 Mar 2023 14:08:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 627AB40237;
	Wed,  8 Mar 2023 14:07:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 627AB40237
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A406C0071;
	Wed,  8 Mar 2023 14:07:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77FB4C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C08840C45
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:07:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C08840C45
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=OtzU12sX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2mQND6Lh-gQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:07:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A09E40BFE
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A09E40BFE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIAnJwfFzcZMK8+Ab0ioO2o3eNtAm0SkxJXiiotNQVly3JMA+LYw6eddbXjt7ANx7v4z+oVWmuNL1uEBPFVDed5Wnpu9kSPEipS4Abv2qDOx1w5VPrsJphAOzpLgSmRTIjgdEzV27mX091fCTRoGcB6M8XtQbTcpORJn2KXEsbpDvOY/gxYHQWOsnaHPad2TzRSfNNsLrM0Ans+OXrvJ7ggLNm7Cn4DLOxy2x6gvXCWlsIKDRrHGFocFBcc8FWGQNwDMkNE/3ypqSxb+TcCpcaPFR6xh04n/ddPEtEHV+Jwd2CBrZEbkGI5p9R7Eq4dL/CnsS72gdqN4dCYb0T/6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbehdC+AqlXdgz98eXY+dSd9ag/5/Upu7Qm2BPml1N8=;
 b=ETxJlmRM22cdGsqF8S/O/WcBpyIc/ldEj3YBBbqUjtF4bzOKacEmskVxdbrNMZg9h0QN669stJKef4jD2JXD5DBiY5RRbUqiqsOnlkuGbXX1/F6xQiGQQ0SnP6TychTW726f4zY1U8qpUh5h3gO5otiqaNo8Jam08l7FSBcur5393bvwp5urairSd3uiVxe+0MDXiOntuer9FEev6as31NoN5n9ZSrz3er4qsv17Nzbpds0SdqNgNZr2U3R3MbSYMxcQcRIUPwm6dLHJitBBB0J8ioUjjdP8zhJ4awfX3dR7lb2LUVXiPIyferntXv41w1TGBBDo5ZUfs+FKwOTNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbehdC+AqlXdgz98eXY+dSd9ag/5/Upu7Qm2BPml1N8=;
 b=OtzU12sX4RUYHyPcb3BahNLCCOCZmGNUhz/RqSUg5GDDbPTy3aWUMpaufk4JQeVRVadtV3Hi0ME0MijmJlYdyS9kqQEJfFL9GNO9eLJLkfJWAIfuZ8U/5yBhgCXFeLnnHMQMyOoVd3sIxzbRWNhf21UGXitf4mD/eOO6IDWAbGfHDwN41vOXhGlcEl93j03AjBZ1CEjGWY8OtEbyHT0aKVvyLeAN4NLWN7LXWBzZkjl7hOv/2+m4De1Ox6owGf04caFFM2Z7VtSlOAxMpiFEp7wrnzPUU5VK2hw8U10P7e/6pfmrcQdyAdkJ6dspIsEndhw8Zsrua8OyW/lWWmlgFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 14:07:52 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 14:07:52 +0000
Message-ID: <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
Date: Wed, 8 Mar 2023 09:07:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
To: Jason Wang <jasowang@redhat.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
In-Reply-To: <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
X-ClientProxiedBy: SA9PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:806:22::12) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 6deb0deb-e8e9-49c9-d0b8-08db1fde81af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVXdXWye/Y8qusk53fXupspRBZqKt5YSHWq8SXFOWU2VqChA5EyUfeQT7yPN05LOB7J/WJUh32zrbS4Mm19PnfsV2n9idWDQcIrgetSANCtLxtOu4aZjoFwsnSQlQbYmRKrgSuHPaSX9YIu7jzz2pvfrIbFENw0p5OiAic0NWtIHGsDipDYOUxI3/TRyD2AFrXSl0SHQrrvGs8g2mGRJWoZQulISjuefYwG2HpYvQGoVSyAV71XY8LNUS5YkbGcLIHjzax0KBZf07EhTRByYRjmxlnRaGsk0RQjbXSQu3QRd7EQxGHSNMIQxzHyPFxhIh6XoEyWGgOPDeE789CRThiIVIUICKFN/EG6ieR5Lt5yg6w14LH7/+bwGreXuAjs00dSjexWR3q2+avxAFl+4gpvBTNjkCDI2O4c263YsucTiEM3HayEH9SwOFfML2FJRMvgIu1uelGVy1kWa0WIboYy8NteGavqNqJErB1DnH6C6xvfcRtSWIyc55ufpF5h3MF23ZNWJezi+epHuyctPKaF3Y6RzALIF2VjCLgUnN0qwnk38akqAXIPILB0SBityM0kIT7trV8KZj04zff+UXcaVl2bd6YP3x/itQDlBC47uSB+7y1IT8SVfgYCjVvlA8KNxBff8W//yrZfmCga0EPAAhTRcGaddpeghHT0L8wvikuWiV9sIN6ypWmKeuI+hE4NeavZ8oOXoaVLfJKZ50xJSntojDwlKN7BOpWK0r8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(83380400001)(4326008)(6916009)(8676002)(66556008)(66946007)(66476007)(186003)(86362001)(2616005)(31696002)(38100700002)(36756003)(478600001)(107886003)(6666004)(6486002)(53546011)(26005)(6512007)(6506007)(54906003)(316002)(2906002)(8936002)(5660300002)(31686004)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXprbEtpcTQzbFNkWEFuRjhRR3VZU3lobHlPdjZZK3NmT1hrak4vdDlObkNS?=
 =?utf-8?B?M2JyczdkbG80Mno5RG9YU0xneDIxakp1TmM4SmFGMnJyd2w1ckdFZXVRV0xR?=
 =?utf-8?B?N3o2L1REcEthYUxYMDVCTHhoY3JhYk5qaUN0VDVUbVpZZ2k3ZVhTWDlEbUVR?=
 =?utf-8?B?a0hOZDFBbi9ZejIzQnpzNGlWREdFcmhKbG9DK2xiRldsWm5lWmtPSEJ1VVJO?=
 =?utf-8?B?QlEyeTFubUMyWHhwTzBrbXRoaXMzNXU4YjNHdW1DdjFFNHI4cVVaWGVLQWxw?=
 =?utf-8?B?UVRaOXY0cVVTMElLT0MrNFlLdTJUUE9haUFsSlM2YVB6eDdveU0vNUdyRnU4?=
 =?utf-8?B?a2JJZzJKLzNqNjNHN09ybU1VZ3NSNElpV2RueDR6TEVFRy9EZjZtNDFkOVhL?=
 =?utf-8?B?bWpRdHBwTVRjK2kzWTI1cUY5YzBGMkQ3VGtnaFRIZUVSalFnaDR6MHRHYXpB?=
 =?utf-8?B?L3o2N2JORW9ZRllFajBmcVV4QUJuaE82RUxkUlZudlB2ZnZaZ2kvQTMyTStW?=
 =?utf-8?B?SEc2ZFpQTHpCNzlxQkZYZHE0Y1V6Z1VRenp5aXZxSEhwY3d4ZUZYaks4aUdP?=
 =?utf-8?B?alpvQjFqR3d4U0JaT3dJalpXZ0kxZWpDRDJVWDIyZnV5NDk2V0FGT1NuNDdw?=
 =?utf-8?B?U05CUVpYbWExNWVYMG4vYW5WNS80ZlcxUDZ0NkJpcUFURk1CVWh0cG1GYzZJ?=
 =?utf-8?B?Y1BsQXpWaDROQSt4U3RQTlkrZTJOOUZmam5YUGxxRDdyT0F1WXhGZ016SFNE?=
 =?utf-8?B?a1VmRzhIdVJKSlVRTzVGNVVuZGRYOWpPSG92cGJZd243bHZIeUhtbXNWeksy?=
 =?utf-8?B?eCszMUcyNjJaRXhwU2RvM3lCVTE2NFAxV3djSXVpc29UTEJONGJjWEtWdkVK?=
 =?utf-8?B?d3VhMTYvZXlOVlZxOUV0S3BldFdRbGNWR3V6K25MQ0FBdU5QRlR6R2pWc2Fm?=
 =?utf-8?B?SWRXalFQcmhSNjZkY3BnVVRWVmpxWmZkdXoxT3M1dk1QRHRiNGVDV1pTRWFv?=
 =?utf-8?B?RU9tczE5YlMzV0dsUHJxdStWaXcwRXhHT2dLZHNNTFpmNTQyeGF4OHRic1hu?=
 =?utf-8?B?RjZhODdPd1lVTm5SRTZncmFldHlrWWZSMnBjK3c4TDZ3SDd4cVl6UUdFYWRG?=
 =?utf-8?B?MTB2WHYzRFI0czRoSUY5WHg2blROOXgxanlOTTZtTUFENXVDZUtkVkVTRHJr?=
 =?utf-8?B?R21HYmlHdXFCSi9tTUlkeS9xVEdxL0w4a0QzWklrQWNwVVRmazZmWDRrOUxT?=
 =?utf-8?B?bmJ3NFB0cU9zaEVxRUZWMnorTnRGdERrclQzcWd4eVh4MHFoMTRhMkpSLzJq?=
 =?utf-8?B?RzNBcEVRK0srQ1hiR3JnNEMzdkVVNGdyYkptR0tST3FKZ205dGdtckZyWVpu?=
 =?utf-8?B?TXlWRzFkZDlzdDdXUURESXFWQUJpZkNtRkpOZkYwdmJuUjZEcmhKbjd4NXhI?=
 =?utf-8?B?SnNLb2UrcHRNbWpNc3IycWhRNFNIQ00yWHd0M1AxNHVGdEVOVUVqdkFlUmRN?=
 =?utf-8?B?Z0lZN29XNUhQSlV2c1lUc2s1RC9kZ3hpbzBtR3pjMmNnVmtnN21xdkhwSTgy?=
 =?utf-8?B?dUp5NWFMTTVhVmNzUHpyWWtzc204N2x2Rkw2c0dYSk9kS290NE55VjErTzJT?=
 =?utf-8?B?VlBQMDNucU9pL1lpbUFQMEpDVTd3VEtYRy9kVUdGNHRpRlpYcS8rNDlCS1hh?=
 =?utf-8?B?dWxWTU4vZ2Fhbm1mTWhzQ2phQmQ4ODdjMGR4cVlIRStMQXZsVnVubU52Rm5G?=
 =?utf-8?B?dWR2THVJWFRXcEErOGlEU2lVck43TzRNcnZwQWNDQ2lNMElIckR3Zi9OVENO?=
 =?utf-8?B?bUVzbStLY2lvaTBYZnhGQUZsSGxXeWZjeU01ZXBQMmZxM3pSbi9JdUtoRCts?=
 =?utf-8?B?cGRxZzE0UU9VdUhLQnBzbnowaVdpWUpGM0QxUDhTUHcxbVYrd29CeFBkQ1Na?=
 =?utf-8?B?NWo0WmJUYi9zRndWdmkzL1BNK2lVQjhoOHFNZWhWU3phbytmL2FLd3N3ak4r?=
 =?utf-8?B?WGoxZXJqSWIzMTZ4MVZJc0NZZk9nQkdkUldqTFIzY2hETkpWZlUxaTZTZnJr?=
 =?utf-8?B?YUZiVUFZNU1nUG95SzNNOE1CMVpOYUlMY3JHeEovQUFOYUxiTEs2QXpvOWFl?=
 =?utf-8?Q?f+eCkYDSUBSRjxL0CE5WbW8lj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deb0deb-e8e9-49c9-d0b8-08db1fde81af
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:07:52.4228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIUzZtAZkiiZieegx2C1rPe4elwbQN42+Ba9YdKlAUnkfwP7zKthbyPnEwtF/A6wuWuRGpwb9JSB+3hdwVHzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyMDIzLTAzLTA4IGEubS4xMjo1OCwgSmFzb24gV2FuZyB3cm90ZToKPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+IAo+IAo+IE9u
IFR1ZSwgTWFyIDcsIDIwMjMgYXQgMTE6NTfigK9BTSBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4+Cj4+IEFkZCBjb25zdCB0byBtYWtlIHRoZSByZWFkLW9ubHkgcG9pbnRlciBw
YXJhbWV0ZXJzIGNsZWFyLCBzaW1pbGFyIHRvCj4+IG1hbnkgZXhpc3RpbmcgZnVuY3Rpb25zLgo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNvbT4KPj4gUmV2aWV3
ZWQtYnk6IEppcmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IFBhcmF2
IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IEdhdmluIExpIDxnYXZp
bmxAbnZpZGlhLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IEJvZG9uZyBXYW5nIDxib2RvbmdAbnZpZGlh
LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI1ICsrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0KPj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwg
MTIgKysrKysrLS0tLS0tCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAx
OSBkZWxldGlvbnMoLSkKPj4KPiAKPiBbLi4uXQo+IAo+Pgo+PiAtLyoKPj4gLSAqIFRoaXMgc2hv
dWxkIHByZXZlbnQgdGhlIGRldmljZSBmcm9tIGJlaW5nIHVzZWQsIGFsbG93aW5nIGRyaXZlcnMg
dG8KPj4gKy8gVGhpcyBzaG91bGQgcHJldmVudCB0aGUgZGV2aWNlIGZyb20gYmVpbmcgdXNlZCwg
YWxsb3dpbmcgZHJpdmVycyB0bwo+PiAgICAqIHJlY292ZXIuICBZb3UgbWF5IG5lZWQgdG8gZ3Jh
YiBhcHByb3ByaWF0ZSBsb2NrcyB0byBmbHVzaC4KPj4gICAgKi8KPiAKPiBBbnkgcmVhc29uIGZv
ciB0aGlzIGNoYW5nZT8KPiAKSGksIEphc29uClRoZSBvcmlnaW5hbCBjb21tZW50IG9mIHRoZSBj
b2RlIGhhZCBhIHN5bnRheCBwcm9ibGVtIGFuZCBjb3VsZG4ndCAKY29tcGlsZSwgSSBmaXhlZCBp
dCBoZXJlCgo+IFRoYW5rcwo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
