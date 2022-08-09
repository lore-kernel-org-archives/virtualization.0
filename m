Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9F1C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A4CB8133C;
	Tue,  9 Aug 2022 19:09:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A4CB8133C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=2Quq4RH2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=SkEqUgkL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6HuWe1Q_vAO6; Tue,  9 Aug 2022 19:09:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF9A081344;
	Tue,  9 Aug 2022 19:09:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF9A081344
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1AE4C0033;
	Tue,  9 Aug 2022 19:09:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1649EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6BCA60ACD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:09:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6BCA60ACD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=2Quq4RH2; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=SkEqUgkL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YEqf-ulF5zUW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:09:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0F5260A9C
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0F5260A9C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:09:08 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279GdtpP008715;
 Tue, 9 Aug 2022 19:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=o9n3vetzsGOwWYKtO+T2lsX2E/lyLKKRbL2Gr+xqwTc=;
 b=2Quq4RH2muIOU388IsW6P2z1xfVcjfSMwWHAb8HsDuXSrBsJaqMd9jL2Z9fKIcspOtDJ
 2+nxYgmIKlKj8pGkZSoDdp0YVaPGgA0UCRLQHUxQxDY9mzdQWyiiCeqohGTvW3l7HgAv
 1WgmBd1kon+AkNj4mS7UqXvWmCHJytRfAsgKF9SgGzgVHeRHc69lpib+umkqLim7NtY2
 g9In6m/e5BOEXPA5ZuIyWM4UCMwRyF2rZZWfO77BJISttjE9f9b0L4aVP3wQwHcQSoQa
 cslHS3/K4wi/SW1B/QLVfeCGgqp8xeVrOqeMEYGVHeavvyRCDl1u3dUDszzWIgtXz6f8 GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsew17h6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 19:09:03 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 279Iib37038048; Tue, 9 Aug 2022 19:09:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hu0n3u4yy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 19:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZnpYMNpFU1q2oGNVitBHCZWQex6+oT5faaShrczGOrD9a/oe0DwzOQJmanFruggkjNX1tfYnnSJ+exIPotTQ4Z73hb9Yex9WO+9bdhN8sDRVteh1YTnyE5SZHP9v+UFx2g9dmWgAo9cPys3Ou1gk/f5Ugt1y3ebIzbSkQPVMR/R9bvZj1XtY1eUz2dxZ6VubJFLciJvNdReFuvC4ApUK09hfQhQH39Bgf0XCp9HtjEZwJ/VMvvxm+tE90x256x1R4jYsndjFqtg+15i90er65liEl5GgKbK0Hm9yDCPfbM9Nma7oD+TGAYv6jt5CL77duZmZ1rTmU2+D6Kf8632fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9n3vetzsGOwWYKtO+T2lsX2E/lyLKKRbL2Gr+xqwTc=;
 b=e2NE9pbq1RR9jS5bYF72GXejiCWDdFGInq7PJ1tsA7a/kRDvvhqD6a9GlySWkhqjXrxdSeQBvz/ppDGTJ7tC+ruLQtsaxyW+kxfr+BhUyKT/Qt/puSGtt7Qrsrl+/hxGOx3pCojbtNyIMlwsrBpFHsiGsDIwvVoeYErLK7zuNPF0B1GrostcjP4Bx04VqEj9OAGXjZkkt0sktKm4xgIBawfr45KfmOm6lJQ4TUXNckkg5ZXw1rTzz9lL87/Jq70mmpdWNRvp+gZApLvr5Qvpa3+WIwT2F6qOvkE+nQc9+YeemzGUG1gVVH+5Bw20X+5VFEW4wUaMtjG7hPEhwl+/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9n3vetzsGOwWYKtO+T2lsX2E/lyLKKRbL2Gr+xqwTc=;
 b=SkEqUgkLpkgxKpGCs5JuArs0FM/esaQlq909yphnud2OnWkrufJ+tvhFkf7g7Y9siUE8Ko0m+iRtramRHPNNgO8B+yaHJ0uLeA3ud0WYfwGlNBzdUSmCfWwARzkQhFfkt1hcpp4nc+NXn9eoaF1I+4+0Jg9srdL1ipVdeYziUFs=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CH0PR10MB5145.namprd10.prod.outlook.com (2603:10b6:610:db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 19:09:00 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 19:09:00 +0000
Message-ID: <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
Date: Tue, 9 Aug 2022 12:08:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Gavin Li <gavinl@nvidia.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: DM6PR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:5:54::45) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59faf4b4-081f-4d8c-522b-08da7a3a9da9
X-MS-TrafficTypeDiagnostic: CH0PR10MB5145:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1J/qaJQ015cNTIp4XWZwf3vdMZopq7t4mz4OConIQvkSzQdf4t06umx6mLamhhFq3beUY5PWl+J5o0CHKsw3R0UM61KIm9Y0WLgwMJVStbXTW6Pw+1URPTuq5FoiBQAEV8uhH97JR1SzIBzVYhgSa1N9yU5DmyccLKcB/CPJpPsKxuQ/neaDl+l6LKop5v6MLgRWfYD9HZMSmMhd4wKnLPw3WYvfekqcZtKIFFi2NT4FozCY7POgd2wiD/kS8u3EA4G85G2nWsiO6/ymWkexMEagP23qV8V6Tct+tk5eGb5v6GZVQ2NQCV/uvweF3WKLE/jhuO4EmJVWiPGmGuK/JRQVjeyfLTQgazyDokm9AejAn7zMmjaui0ELSrwa834FewqgP2VxyagL/WjT+CtmQBFXN+n5W/BhZxCIlD81LrGAMkUCtZzmS4Z/Elt28+htsj58RKumzI++d/cLtEBUDXJR8IKKo1vhxfTv0HgUM/YUlWofCnE82GdB6ALzOkL+A25DGwQz+jH4SjCHqDFHJ9J84QIJSx1HD5f62U7lTRgfwSh5zRg0fsvKzs0iwo9VakCbOYydIcSv8pi/Tu/CTkwxEJZXxCN4LKaPid62yTtHnnwcF8fOFojdHvHW9gv1i5aTmhsM2AgyKtv2UmEeypCh6V1FSMwXP/ehEwbOEO+0366Xh/ZHr0wGrWaSnQm0SJY+Xf/oiT5XvzC7z99YVbVKFH2GotT5l0yLQ6h4qsA5YZGOXy8xhuVK4crmF0R8AE0ayUQm3MJo1Nbba4dIX5sv6QxqN2rvmK5XX4aHKhD8UVl3fyXLSGkM2L4C05E4IZtNRiQlqeeMx4oWq6lQ+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(366004)(396003)(39860400002)(136003)(376002)(53546011)(38100700002)(41300700001)(54906003)(6506007)(110136005)(6666004)(6486002)(36916002)(66946007)(66556008)(31696002)(86362001)(4326008)(316002)(66476007)(8676002)(478600001)(7416002)(26005)(6512007)(2616005)(36756003)(2906002)(5660300002)(186003)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRZZDJFZkV6QlFHZWtSUStaVk0rWUVNWkJHbkZLYXF1Qm5tOCtrWkdtZUwz?=
 =?utf-8?B?RGJzRjhaUmwwUzBIOTZhcE42VG4rSm5ONUx2c09lY3liT0tVNzFIcklBSU9K?=
 =?utf-8?B?RDFFTEpleEpESWZOY2NxUktVZEtmemlaTzNGUkNsTGUyTVlDb0pLR0tad0Rq?=
 =?utf-8?B?dUdiK2FRNnpieWVKU3c0UWNoWkhlVVMzUndpUS96U0daM2NtWWxXZ3FFMDdk?=
 =?utf-8?B?MWNCTDVQd0NxYU8wblkwMjltTzUzNmRqbUUvRnRLQzduUUwxTXNSYm1JODV4?=
 =?utf-8?B?bjQwNTB0K3NBQW9vemdzMDlwM0gvRlRqT0pwb1FwTVRsL1l4dmVCYWtmZEs5?=
 =?utf-8?B?ZFFzc2oxVzcreXFFRlg2WW0ydC8zWWJWY2NGa3NHVFljUytDTXp1Znp0MzRC?=
 =?utf-8?B?LzcwanVaeHdFa2hvempBbEFvUDZ0cTU2RnhWaXhDM2hIVHJnWE0xaGl1U0J2?=
 =?utf-8?B?OWVYUXc0SDE0YmxqVHBvWTF5RlRnaU1OZlJpTWxSSDdyLzdkdnhTclhQNlNL?=
 =?utf-8?B?eTNLKzlQVkVmcEhBRmhTUmVmSytFMGhCYWIwejZRWEl2enR2SFdHM1dqVW9T?=
 =?utf-8?B?ZDMxa08yQTVhZmZXbkVzWjdHLzlYN0Zra01CbUc5UkoxU2Q0ZDlxazBhMmhX?=
 =?utf-8?B?RVNRMi9yKzU1L2U0VEhzTTlTQUowVUk4bDdMMTRmcGdneW5MdzVEbjdJU2dG?=
 =?utf-8?B?OTBpRVBuWjNxa3loYW54U3p2NmErWmovaW1wZ1RSKzk4cGdXWVd1UWxhdG9J?=
 =?utf-8?B?QXpHNElSV0xTdVR3N1l6Q3FwejlOUGJpSElqQ21GbmgzcWZ5OFJobWdHM2Ny?=
 =?utf-8?B?a1I0bUNpb1pwckFCZTdlajVjRjdQcXlkKzA0UzRBRk1UNmh6UnZIcEFaRC8v?=
 =?utf-8?B?UCtBOEx6Zyt2MWExVTRROVlLWkNvaVhJYlZXd1d2Yk1pSUxiaUx1V1NFY1BR?=
 =?utf-8?B?czZkbnU0MEI2dGdRSTNuOTBBcU81MGNPRmZBV2ptbXpab0pZRzB4RVJWQ2R2?=
 =?utf-8?B?WE4wMEFNdkJuNGdxRGVGRVQzSzc5M2RXaytaRlVRSXdRa01xa1I3ejkzZUdk?=
 =?utf-8?B?ajB1ZTM2R24zOEFEL29KMldEZklTaGpVbTAzWU5WbmNxRWxpYWdHYm9UWitM?=
 =?utf-8?B?WlBxT0FKakpCNVdmbXdQS3NISG1WQmFCYmExaHZITzhOMWY4NjdDVGR5OU5M?=
 =?utf-8?B?LzRTenNUcy9ZSXJYcU9aeW1qQUhzUDN6MWJLZ0hxMFdleHgzRUFrQjM2Y1hR?=
 =?utf-8?B?alhMUTZ1ZjZUVmFjNzIyVGFmZmF5bG93aiszcXR6Y2pEVVBKNUtTRGVuL3Bw?=
 =?utf-8?B?Vm1ia1JPS1NVVGF6VkF2QTJiZm5VT08yNi9JaklIRFY3YllES2dEa29PV0FK?=
 =?utf-8?B?VUU3SnJsK3ZnOUFrRmE5VTlNa29uRTZGZXpYWHMxajFIZVlCdU1yOWNZZFN3?=
 =?utf-8?B?VWhiSFl4eXgrWm5TeENVTDZ2QXlha3EzanNneFM3dFBkRmFKN05KUGlsdEl2?=
 =?utf-8?B?ZW4vRDR5cDJ5eFZaZ2VkVXdwQ1dERVNkdUg3ZDRFL2dDUmVyd29rc3A4TjY4?=
 =?utf-8?B?VWF4SGpKQysrMkVxTjlFVVYzUVRFa056ZGg0eURvd2FZekdrUGtpa3IwQlNQ?=
 =?utf-8?B?T3FmaVFXZ0I1QlNtRW1ER2VLdDZKclZXTVhTZmpCSERrU2tIT3VqcTRJK3Er?=
 =?utf-8?B?Q2RnZFpJUHcvWVZVZzFHdDE3MElLSjV0cmtESjNETlhlUStYRVpncmR3ek42?=
 =?utf-8?B?ZzBBMEliUUlrR1d3UFl0UlQ1bmFWMXIvbHpzK1daeVBWMVJNZVVtODhoWlNC?=
 =?utf-8?B?cjl3VjRheEp0VktnNmNibWF4c1FyQWxJWENvUFNMQko3UDR1K0dLOWp2cU4y?=
 =?utf-8?B?VVdWcUdXWUVDeFV5QURucTRqeWd3TWRvRmIvbFZLeE50b1VyYWpxSHdhd1Jl?=
 =?utf-8?B?S0tGS0NIZ29JWnR2VU9veVNnZ0gxRzJFTHNVNzB0TkJWZGhwSnd6Nzh1anNB?=
 =?utf-8?B?L0FoWm12T25ZN0RFRWVjVUMyT0hJaWMza0hnSWNFRnpPWmRXdlhVS0FidzRI?=
 =?utf-8?B?SXFodWhEbGZaY3Rib2V6cWNNVDZyWFRCQnpac29pTGx2NHNwL0VsaEFnKzBC?=
 =?utf-8?Q?NocZdsbkjf6ig7w5Z1OcdM4Ij?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59faf4b4-081f-4d8c-522b-08da7a3a9da9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 19:09:00.0813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxMlsyoR4ypOroYkc19SlyHENXK9X7uzil+Mt/Fzs0ma/rlazSwMIYMfMJ6COSVhkRfqG0w2T+XKqZ1nBTEy9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090072
X-Proofpoint-ORIG-GUID: hDjETogmOqTJAKP2XPtL081a2VUI501g
X-Proofpoint-GUID: hDjETogmOqTJAKP2XPtL081a2VUI501g
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>
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



On 8/9/2022 11:42 AM, Parav Pandit wrote:
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Tuesday, August 9, 2022 2:39 PM
>> Currently it is not. Not a single patch nor this patch, but the context for the
>> eventual goal is to allow XDP on a MTU=9000 link when guest users
>> intentionally lower down MTU to 1500.
> Which application benefit by having asymmetry by lowering mtu to 1500 to send packets but want to receive 9K packets?
I think virtio-net driver doesn't differentiate MTU and MRU, in which 
case the receive buffer will be reduced to fit the 1500B payload size 
when mtu is lowered down to 1500 from 9000. What I actually tried to say 
is that as our current use case (software virtio) supports XDP 
applications with 1500 guest mtu and mergeable buffer enabled on a 9000 
MTU link, technically it's a legitimate use case regardless of mergeable 
buffer capability. Otherwise it's considered to be a usability 
regression in driver software side when migrating (not live migrating) 
existing user to vdpa, due to lack of hardware implementation of certain 
relevant feature.

Thanks,
-Siwei
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
