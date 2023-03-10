Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3CCC6FA99
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 15:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 501CF410B8;
	Fri, 10 Mar 2023 15:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 501CF410B8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=anWX3A4U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OYQgZ7lp_K6G; Fri, 10 Mar 2023 15:23:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BBA74098D;
	Fri, 10 Mar 2023 15:23:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BBA74098D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 674FBC0035;
	Fri, 10 Mar 2023 15:23:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7080EC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 15:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43A9F613F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 15:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43A9F613F3
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=anWX3A4U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fODmsYpvD-HF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 15:23:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B5DC60BD9
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B5DC60BD9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 15:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Erqay8VcCFYICV8ydZmleq4NN9DOTAnwy24uTFlwg7N/MJ5lgTG8u9PJRYTjj6rMBm+mDBSGwrWBNPiHo6+sB5XMAT2n9hkzuQSiWnBa+w0MwYsXTCAXcfSIsQh0uHv2Yw8/H8ki0rNEFN3ehs7ga2Y3xH6uiQ9PJ2F/EU0t1C3NQu+JxLTAXScgeBikzPLDbR3nxKTOTu1Sd5xcSzU47lxUxSrmliq1LMPSxnLPgfah1Uzq2kXtZqAn/rbusHrYqnL5SqsAftrDpAvuw3nuVV0gk0WAC8vepIBSOIraQwk1Zc0J0cKQUo3xrPcovZKCdyKM7Qgnm8vVmDrPTwvimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOHnqcCD5mSTFjTxOnz+s/MGaSkXIlbJHO6eSbf/6/s=;
 b=SWolDZ0geTYhW1qVcCQ6CsVlmYtbenITe+T2d2VHid8sihzzlo89y01qXwLEb6Ql92c8hSk+5Kc+TVsTmkZ6Myl/jLfkYZeNuToyokS9w1vRLprcba6GttQrreYv0BKsvkvZNfjCwjae+D9KATyeUXxWGE9X6HFbctw99yHya2ogvXIWNrGDZSLtG0DP1POJnqAFnFgHb5oi8H3KqUCjoyQqk3qHpWK1t5934DiRQnjlCbzXMdWH9QCjdUe1iuAM9JngWj/r9PYsa4nOwhZVKGV42cLT+/OI14z5zSQpf+qM7+YAeY+tMjujsTVEt1zISCzOA3aENDdj/3ISlsChjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOHnqcCD5mSTFjTxOnz+s/MGaSkXIlbJHO6eSbf/6/s=;
 b=anWX3A4UpcYZVgNCPl3YJE2kXVU5lCD+fCDhXb1Xey9mRHKKFIxRDORzSw2apP9bvXdNMnJi0IALoy5VtNJonFJPjrASt4pMrcSyAxmX2SBmMqa/vlt/p4RpHN7QBxaJ+r7gRCfVTOgl+qIEjVkAh+LfBVhWBXuvVttEbYJ+UJnbnIeODDTNTRbrFHzyOi/cZ5x+WX5IbjikEWtlhWmCYIydRwFcNsMRlCqofOjUR6uEDX81wLEikcg3Ddfno7kkNwaBmLr2fwEM/YVJTTpkDGBhCAbDU8I/iWkLS0UZOtO38tmO/PHtZ5SpAAWcyjoW9iJyJ5joi/veUypS9iKdjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 15:23:20 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 15:23:20 +0000
Message-ID: <bd763bf7-0b8e-ba9e-cbd2-a0302e820cc6@nvidia.com>
Date: Fri, 10 Mar 2023 10:23:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] virtio_pci_modern: Allow non power of 2 sizes for
 virtqueues
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Wang
 <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310053428.3376-2-feliu@nvidia.com>
 <PH0PR12MB5481188C606714C32353ED88DCBA9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481188C606714C32353ED88DCBA9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: DM6PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:5:334::23) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7e8798-898b-4808-df5d-08db217b616b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hotomVpKD2uNP6tqjHbL0Bfv5DDI4tmTP7PD9obz76yaKr9J3SSpLQhOQPtFb86FQIuce0YlUpUkfiApwkTFni5Ena4V8Tgm04SJhNtdnozHxsxYgNROOjDoTMjxTfZ9Cz72Wd+mZ/WOltBLdGfb4CZlwZexbqdYdnlKAdzzrtQL3nB53nQoYqs/6j0RvYRIs4igYip3ssdAbBGQPd7OQWpOTWpwd6zr72d5AgyCuYNO/HXGFsGs/wEHjvosdq8e47E1CeT6U5qwJyECx+HA3EMvBjQ/oo9EhbIqaXBOoNQDGJqh6wnNneEdEPVFWAC6rMpTNGmnxSDP575NrzXSd7A9iV3F1pRmUpKr+0Mzm7tTqJnWTfSl2e1LRTjI0elFspQpgNVbSLsA/aOgvr+F3S3GsnpDpCIph6GOru8cbSnephFFKkmkXlfTrnKEAwZ3A5Sh6WEDoRJasaUNGWHypKqA+BeAI1hA8BA9ug2f6VgcVnMibLCD1AxoMQbN78QL/hC77MGxvLkrRUp4Z9FKmG28IxappTPWgUXd1ua/H3uVROeq3qZYKcpQAaOuSuF6G4/ljJLR5FCvHf3rZh3DjXRW0SGnwsGPPtO0SaF1CMscbBxaI8sziC4YwtcK6xCgxwVepFcJ/NC5W0V45pcE+oHqp5KUgNJU0U58djcHiXr3GPRFNpSlHs0N9GsmmANMc0qLWBvbchgy4GqV+vsba5ArhgsbI06mAqD0VVIJ3iQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199018)(8936002)(36756003)(6506007)(5660300002)(26005)(6512007)(38100700002)(6666004)(83380400001)(186003)(2616005)(86362001)(54906003)(66556008)(110136005)(31696002)(41300700001)(66946007)(316002)(8676002)(4326008)(66476007)(6486002)(478600001)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFM2TjE3bUVEaVZHM2VUUitpYllEcVcrRlk3QURab05ka3RyeWZraTA3SjBo?=
 =?utf-8?B?WGszUzlOOEEyTXNSL2tDcEg4RXNXOXR5Q2N2M2VGTXhCRWJySzIvWWt0MVlP?=
 =?utf-8?B?dXlaL0p3RktrdHNBb1dLYklqcVovajhrRE16T2xFMUVtUk43VVZ6eUlWZlZC?=
 =?utf-8?B?NHpkMWZOVkg1Zm9zbWwyNkdDOWNRTC9yNlA5TVlWRFhRZ0t0QUNtYmsxVHc1?=
 =?utf-8?B?bU43OHRPN0VUb241TUpuYkdFazhGVGJtc01HLzdNanFxeDdYc1N2M29mSDdt?=
 =?utf-8?B?VGk1Y1dOWHFpVlg3enpoMkY4T2tqUkY3ZmxnMVRmVkFFRGptTkh4QkxmcGl1?=
 =?utf-8?B?MUJYL3FCeFFqaEpFT1F0LzhvaEUrZEduTFBMNDZUZlRUY1hwdElCZlZ4RG50?=
 =?utf-8?B?QTRZYlU3aWRTc1B2S0FHdzZXakVzZ3lHaXBoOHJ5UUVabTc5L0t4Wm9aQUk3?=
 =?utf-8?B?YWNPSnUzWXZBT1RQNVhMdlAzK2FCa2l2ZGRHVkZySTcvbE9Qd2xmV05RMkxN?=
 =?utf-8?B?VjZBejR6dFZpSHhCSHpTa3hnMktJSi9iZmRUUDlsTHI2Y1ExbDM4dXpPd0tv?=
 =?utf-8?B?VjdKbVlTOEdoSEVmWGZTb3VMRW9jUzZLNzJLVTgwenhUNU5YVjlIa01HNjh0?=
 =?utf-8?B?MStEcGtwd1gzYkx3aThYTjczdDlhQnlFdm5BcEtKQ29rc0tzZCtaajJYb3B5?=
 =?utf-8?B?MVBFSTVBbGlmQitaZHdSRW9HNStpVmY5ZjU2TGJMZDhDb1BrN0Z5ZnFsR3BM?=
 =?utf-8?B?Tjl3M3hYNytRQzFsWTYyZ0RPbnFpcnJ3SmpFRWx2V1l1QzB2czZMOU9nNWRU?=
 =?utf-8?B?U2hqMk9RZHVER1lrempxT3hiNkU5aWhVTEk5eS9LZldVc2g4N0M4QiswSWRt?=
 =?utf-8?B?dUVrT29sbGJIQkhYQzMzODZObWtpSlZucWZmazdwdForaEdjN2l1ZXpldzJM?=
 =?utf-8?B?dmxrVW13TThaSUV0UGpVc3VtZGg2ejRnOWNyL2Y3c0RjL2xXWXNuUU15MVFK?=
 =?utf-8?B?Rk1oZG5vdkY2alRyWHNnaGl2TjB4YlNUSnErbHQwRURqTEF5R1FNSTR4Vkpl?=
 =?utf-8?B?Zmx3cnY2YS9NVVZUUTM0OUdPTDRHSDJmcWh4OFd4OEh6NXhxd0x3dFZIOFky?=
 =?utf-8?B?S2JYOEZvTHFVL0tiRVRjNldiSDk5M2Z4ZGwvdUVnNTAxSVdEQ3RsU1djNm1T?=
 =?utf-8?B?LytVQTRRM0dKbmpGZGRtVmRjYVNTZWVXQ2VZMWM5a21NQTZhZjQwTTUzcTFy?=
 =?utf-8?B?b0dmbHdsMU1JaG9Db0JPdUttaFQrSVFiOVFBc3gyUnQxWHJzbzZQQ0hUUW9t?=
 =?utf-8?B?TytWM2tKSW5TWnBoUk03YU0vRDQ4ZlRIZFoxRzZEaWthd05YNklLWGFqOVNG?=
 =?utf-8?B?M2dmcW02WHM2VG1EeEFRbjNRUU83NEV6WW5ZeG1KSDB1MXB3Nm1VeUtWT2NW?=
 =?utf-8?B?VlpLbVRDNGNtd29UK01BRzd2dXBLSWhsNnVjT3d5TVBqb0t2c1poN3VBWjhP?=
 =?utf-8?B?SDVwYURnWUlUV24vOEtKN0NmdE1DVUladCtFNmk0U0oxK0JFd09kcWRSQkFJ?=
 =?utf-8?B?TkJrTWxpMzkzVXcxOVIwZmJnOUlkeHZPRTFmZktMTk1FRTQvSDlwL2hKYjVM?=
 =?utf-8?B?elFzUmNJaElrdDByTkRNZUlKa0ozOCtRbTRJWFo3YUhoRitXZ2xTTE9uMGlz?=
 =?utf-8?B?amYwR0JqbFR4SHVHUXRydWpzYlZ5cysvV0g2clIwR0MrVWlQNFBKM2t3K1FJ?=
 =?utf-8?B?TmY4NDl3ZlZYTWYyQkprT3dwWTBsSHBSb1lKRG5WQ2t3ZW9xdURFeEZFMHNF?=
 =?utf-8?B?TXNqdEVlNU9Gd3VFOEUyV0J0YmhPVmppTkVIYkpMNjlyTGtpd3FtVVUzTWdV?=
 =?utf-8?B?VHY4SmMxa3dYYTdOZXI0NHRBL05ReVJvVVZ6ZHlZYk1vQWRQZE5Rc3dTbGx1?=
 =?utf-8?B?OHlPbG9nNEV1Rk1Od05tVytHTThvZnpMaXU3SWlwMy9EY3hEVnpUMDNJK1VW?=
 =?utf-8?B?TzlVR1AvdHVrZDVtSlFaRitDS3hSdk5JOWxhUW0rUTRtRnNOcTFQWURVS0cv?=
 =?utf-8?B?bHFDM1k1ejl0cFdIdDliMDVjVENaVVU0ZTVZWExIaDdIdTg3aG45YVQ4ajhH?=
 =?utf-8?Q?FHcbYZHGNB1paNw3nN9cNpYmP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7e8798-898b-4808-df5d-08db217b616b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:23:20.3616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjQm1d7gR80/Pbeb9uFGRz4WQ3hBvUzH47mtsHTgFTh+fgJ7K01OLCXMKgI+kUpH9PuK9IIwGe0YwFE8790UZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379
Cc: Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 2023-03-10 a.m.8:36, Parav Pandit wrote:
> 
> 
>> From: Feng Liu <feliu@nvidia.com>
>> Sent: Friday, March 10, 2023 12:34 AM
> 
>>
>> -	if (!is_power_of_2(num)) {
>> -		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u",
>> num);
>> -		return ERR_PTR(-EINVAL);
>> -	}
>> -
> 
> The check is still valid for split q.
> Maybe the right place for such a check is not the pci transport driver.
> But layer below where split vs packed q knowledge resides and hence, power of 2 check can be omitted for packed vq.

Hi, Parav
     I think you are right, I checked the virtio spec, only packed 
virtqueue can use queue size which is not power_of_2; so, I think the 
check can be reserved only for split queue here, something like

struct virtio_device *vdev = &vp_dev->vdev;
if (!virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)
  && !is_power_of_2(num)){
     dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
     return ERR_PTR(-EINVAL);
}

I will fix it in next version

Hi, Michael and Jason
Do you have any comments on this?




_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
