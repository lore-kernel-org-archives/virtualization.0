Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90938C433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 18:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2AF27409ED;
	Wed, 16 Feb 2022 18:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7HyA0ObnGCvl; Wed, 16 Feb 2022 18:20:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6D78C409F3;
	Wed, 16 Feb 2022 18:20:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21964C002D;
	Wed, 16 Feb 2022 18:20:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2AB0C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 18:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A1E3409F2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 18:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CeQyrMCD_z9G
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 18:20:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C9103409ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 18:20:00 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GHiAjr010825; 
 Wed, 16 Feb 2022 18:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oVYBvUKHS8ER0kktdMe+SA5uIJi1OkGdgn4KqmJpJKg=;
 b=zvs32oH912ZCYcycMponLtnlvvWtRAe7tHZhVBfLW+39V1OywtYDkmpqphRChtbfozuk
 VnMcyDQapSLR9dUcqG4i4hTSbFQYAnB417/lm/mHh2JykJ3pT5i4K2o+OMYdeIRDrX9e
 ue5ge4wWtr2XCisByIyDbEcGtakz9VKJmjsUuSF9Sszd63hf+M/oaART/ScGrWeg0qB6
 rvPmVVgfXcCjczOfqUfyi+DVX8Zdighyu1oa7+/no4T0xvCgWc/EV8oHgNt+JtuSY8AP
 rbjGmBqfr4khl0N5ot78j9asjWlrJhpfwpo/zrVZKGwZzzfbcYF0CiCHbmBOmKtiL06i HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3e8nkdk1ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Feb 2022 18:19:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21GIFJPx118185;
 Wed, 16 Feb 2022 18:19:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by userp3030.oracle.com with ESMTP id 3e8nkyc1ty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Feb 2022 18:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOYDAw5PTk5gA/WBUrLpVeRcsntfXdHv2+U2o2bL6PBuGznb2SUuCO1/E1tZ+Qfj15asNWOm1ZaBYqmoB4GEAv4dDOwtrKvFHZ28hQUFJDZSVzl1Had2Zz5PptScOAEgGTjYMQv4V19xHBODwCekkFSy6qfGIIAS8OegrHJV2A0jalsKayGsEkRI/kOWI38AQE3RKOKRp0yWtV7xMhOKmezGYKYaTkc3OvSsgBey6GMCctDZrh5N4K5Ga7h5GembIEPpUqwO0L0/FBdlC8ygrcgj52BK4J9aKAgHq4RAP7qDnfq5SKBLsXxfcCXfwY8Obmfv0ZuRJ4GU18iGCgTKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVYBvUKHS8ER0kktdMe+SA5uIJi1OkGdgn4KqmJpJKg=;
 b=PBwo2xCgRmGGq9dHJy41+iAJiBd8wuEWP98rPwwxjFrCpVz2pRKdCP7XfpJ0sFL9jzVtyb8AxPbftrE4oqn1q8I9zNFHIt+Sw6FMri4pwbDZCQEGliCOShmV6UG7zyA06jBaq91WPLOP9WICC71IuaLis3ZdVV0DjJfW8ofqG4wHDngr3xTOYzmczOofS3RHQl2QwGVZgu1VLESOj9lcJtRzDvG2uwr4Ugw7lEbrK2CLfxDgNdYV4A6229oXbBw5SviUptfDBygJHYkKWixkIyLC7YH8ErfcgblBEmniQMvBssmpGtcZ39jbDQUIJ75HjPdV1Kk3TNq5+z+fknnVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVYBvUKHS8ER0kktdMe+SA5uIJi1OkGdgn4KqmJpJKg=;
 b=GmOt7KEzY6sxcGA9VF8BwS46/jlRv4WCRoipuXTWb3ApeGkh9J8MUjtyIqgC508oTJ8+zvlblYrOQSkH3ahsRDEODWIYIZl0D89L7V0FKGiBl7Wv1VGBt+3ON/IVOPBTw7URdOyYXAiBnSMF8RAbbZ61lE2memr0kp17Yd3/7qs=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BLAPR10MB5362.namprd10.prod.outlook.com (2603:10b6:208:333::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 16 Feb
 2022 18:19:55 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::54c5:b7e1:92a:60dd]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::54c5:b7e1:92a:60dd%6]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 18:19:55 +0000
Message-ID: <9d48a945-612c-2fb5-d0d4-3752fead7f78@oracle.com>
Date: Wed, 16 Feb 2022 10:19:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] net/mlx5: Add support for configuring max device MTU
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 amorenoz@redhat.com, lvivier@redhat.com, sgarzare@redhat.com,
 parav@nvidia.com
References: <20220216113318.74218-1-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220216113318.74218-1-elic@nvidia.com>
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 252478e1-bc5c-4206-aafb-08d9f178ee9a
X-MS-TrafficTypeDiagnostic: BLAPR10MB5362:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5362F645A812C188578D533FB1359@BLAPR10MB5362.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUqU6hhgi7TW5TLBb1mWrGhbpyTKYe6FLo7Jya7yU0dnAmJdjC4JTieQsjik7RtrmMPtLl16uNN9lRrhNT4Tc8qyas/QwZTO2qlCVlcp987PaZ4X0GXCxfKPK9mEFuODFhHAinwRkW0/5syk2kAauZ3wTry9M+loPHGI85ynLbRDxHWt6RvW917Enp0YCo2GDXev5SmgIKr/LzDApNzU2qxhSxbefqVhi8skZYmOoTD6fHpbORzSacGHWmD/+7YaqIvlJLscPjfq2u5P3n8db4aACDUXTd47+AbA8IIExX7W6fRe1Mm4t8AcrM6p3qpUBa/6cN0aLmNBzmFivqXpwiXkm29YwnxHve+bxMEMqhaGH1qTZZQ1OWJtHloAd5p1F0UVidVMZG+9HVAE8KIjAoQ7aK7Hn4IGzdhnk59t1hpJ4ye6jn/u8epVc7wiIIt2xi8dbb4rQ7zpH/xeKbhP343KBdalbQ1o6R9xKeuq448Ul/MCrFcoqeLtWRqiYAVz4SfCBCvkRGWXCWywPXjzQyvxj3lw42PSfh45nMBeecFedfORJtGxBhCpFLgjOtp6GVsf8CY3Q5WnxuGnJJh5Wr4FY4JtfEKh1LC/efjrb5+a5JGva3eez7U6ual/htNZzs0FkiPuZ6k74fjwRlN6gIFx6U6wIhZTK+o53U0ECMWq2NB9twfRkETDD0tqrRRhVbnFsvkuoOdKeHHgRctRpzCISj4HlpPZLeHcgDiFSgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(36916002)(186003)(6512007)(6506007)(53546011)(66946007)(26005)(66556008)(2906002)(31686004)(36756003)(8936002)(2616005)(38100700002)(66476007)(5660300002)(8676002)(6666004)(83380400001)(6486002)(316002)(31696002)(508600001)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkQzTDdMdkIycVZIQllhVlE3RXZzaDZ6ajJzTHRFcmxiTVp0RDg2SFhKbCsy?=
 =?utf-8?B?QXBtKytQR2tkbGNpT3hKS01TVHlLa2RkU1dJQ3lOSEphTVJhZXZBT2tGd21V?=
 =?utf-8?B?NHA4TDgramtkR1JJcmc5eHh6OXVyS2t6YTdubjZLR2dwTWhnYnc1T1ltdUhO?=
 =?utf-8?B?N1dHS2dHNmpBVGtjQk5RRmxBMFlGOGFoa3JtQkFTMnQyTGpiMHFCb2RLZFlK?=
 =?utf-8?B?bGRMeGV3ajdYb0pGQzRKVXlRbTNsT0w3Y2NrSi9RNFUxNlBNOHNDeDZJVUpF?=
 =?utf-8?B?UWppbzlPeXNvYjkrWkpkOFdJallDNUR4dER5emJ6NHJNLzFaMnpERjVlN1ow?=
 =?utf-8?B?c3hGZGNZREpFOTgvRUE3SjZSZzRGWEhmTUswS2ZFV3dZVUs0RG13YW42Qyt6?=
 =?utf-8?B?WHJEMUJIazdNbjJMR0FUSFdsMnZGOWducW5XcUlJc3ZmNUxCdDN4WllseFgw?=
 =?utf-8?B?VWlOZDFoeDVlNFp0TXoveTN1QzFLSytqVE5kNGFMcVlSL2xrV0t4WWo3Vnls?=
 =?utf-8?B?cVN3U3N0WmtFbzVSdDl2KzdNTWR2cDQ1UysveDI4Q0RwZ1pXdVcwWHhSVGxo?=
 =?utf-8?B?Z0hPU2RRbVdGaGtBbW9VTDd5aExPcmdHSk5vdk8zLzBhbnlMRTlWN2h2UVZE?=
 =?utf-8?B?L1hGOUdzeHJFQkNUaVEyWURIVlU1ME1IUFJtcWxRTG9vK1lIMHlUUlZnRFNX?=
 =?utf-8?B?bDBBckRVc054blc3ZmZWYktuS1pDMkVzQk1MMnVMSENOWWtBNnppeEowTVpT?=
 =?utf-8?B?dFd2YU5Cbm9HZ09sSGxqTXZ0Um5BV3hXK0UzcDRqZ2U1a1hEaXhmTEJWMk5w?=
 =?utf-8?B?YVZtZ3VRVWJxTm1HdHB0K2g2SjhMVXl5MWFCaDBZUnlwMkE4M3M4ZUpSSStL?=
 =?utf-8?B?bTlpa09IYlMySzN0d1JOY2ZmSnk0cHVJUmpTMUdNNjB0OXdKY2VoMGpzUTBQ?=
 =?utf-8?B?VHkxMW85VTBta1E2VkFWUjN1bnVVU1JmQ0Ztc2NPeWE1STI3ZVZrL093cy8y?=
 =?utf-8?B?RUltN3FtSFJCWlVaVUtXQWZIV3Qyd3VOc1pTeGpmb3ZkZmVkYkl0Ym9xOVdj?=
 =?utf-8?B?c3NBbkc5Rm4rR2pZOTBnQThXb1dGYzRrZHdiTllWclBBY1YvaFNRbGkyZWhk?=
 =?utf-8?B?cWREWVVMaWl6Wk5VRjJnZyt0OG1jSnRqbTZ1OVNxY0lkUE9pazdzOXV4Q0lu?=
 =?utf-8?B?OHhndGFVaWNZcHBldDYvYmN2ZVVtYk10dmh0ZnI5cXA0VExhNmszcWNBSXl3?=
 =?utf-8?B?NWVYVmZIcWs4bXBXRTdVelJZeTkwa2IrWWlLSVE3V1UzaVVvWGlmdUc3aHBP?=
 =?utf-8?B?elJ5R1RzSERoZXVkTm94L0Zvb2loZ2RsWEt0UVdyemgyajRXL1Uxd1NWbXJZ?=
 =?utf-8?B?Mndma2xpRjROa2ZKd3RwK2NtQ0lZUWJKMHlQQlFTTWpFYzdFbi9SSEhXK2hW?=
 =?utf-8?B?SjdJZ2RJc0JBa0hOS09vYnNGMFhIVWNMVjdiWEUvY3dGM3NFS0ZhUlJES2xY?=
 =?utf-8?B?OHFFWWxLVVBBRW1QdCtLelZkZTlXa2JnelNiSTJ3bys3NjNwMzNJVUJIbTNS?=
 =?utf-8?B?Q01pSFQwOVhhamViZTlkZCtVa0xLUWdHZ1BZVllNaUI4YmEwdGhEbHlvU3Bm?=
 =?utf-8?B?VURDcW5pQmthSW12QmNkZ2F1YnNGL3FSK3NHTTZreEhWbjM3Vm55NWErY0pR?=
 =?utf-8?B?YUNsWVVGaUhPa0pmTXVEeHNheENKQUxPNlFETVV1Z3lIdnRmbjJ2U2o3ZEd1?=
 =?utf-8?B?TTVPVTFjdGEyWGQ0NEk4akVOakZJNVBFR3FsY1cvWEJid1gycUJRY0dpaEVW?=
 =?utf-8?B?ejg2VUU1dXZVU2t0blVOSHdvZ2lyMmFTcFFFYThkNHhsOXRLYU56ZU5rcitM?=
 =?utf-8?B?ang4bUNpMFpubTBJL2VXclFua3BmYVVRL2I3dCtBeFZrZnhjQ3ZBczRNaFgw?=
 =?utf-8?B?M2tvTVI3Tk9zcHh1b0dlQ2o5VkdvNHp2WStOZXBpTXRlZ2FjMEd2QUc3K1Mx?=
 =?utf-8?B?NkJUOW54TW1zdFE4N09lL1h3YXVBUTZ6QVZBbFVxQXFpWm80YzhVdFZHeUxT?=
 =?utf-8?B?VHhtb1F6bEYwRWVESE83ZndqY09tZXY4T3RvNVE4RkhUWGFzZ1BMR0I4VUVK?=
 =?utf-8?B?SHE3VWpTMFNvWStVR055K045MHpJcHdHMTlXelNZakozWEJMZEM4eTAwaW4v?=
 =?utf-8?Q?GP0N3Gn+m3JN1RZ/VCDYIHc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252478e1-bc5c-4206-aafb-08d9f178ee9a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 18:19:55.3150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Nu/BDdFm3TDtmcUEPN0TJIsyYnkh9I02aoqP2XzE5viQ0LTya1sc1XPcJFrsUjm87mJod9MOkSWT8C5jmv98w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5362
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260
 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160102
X-Proofpoint-ORIG-GUID: WHHhU-bKAygw_4M-88chuC2Ub9QLl_dv
X-Proofpoint-GUID: WHHhU-bKAygw_4M-88chuC2Ub9QLl_dv
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



On 2/16/2022 3:33 AM, Eli Cohen wrote:
> Allow an admin creating a vdpa device to specify the max MTU for the
> net device.
>
> For example, to create a device with max MTU of 1000, the following
> command can be used:
>
> $ vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 mtu 1000
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 32 ++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6156cf6e9377..be095dc1134e 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2689,6 +2689,28 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>   	return ret;
>   }
>   
> +static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
> +{
> +	int inlen = MLX5_ST_SZ_BYTES(modify_nic_vport_context_in);
> +	void *in;
> +	int err;
> +
> +	in = kvzalloc(inlen, GFP_KERNEL);
> +	if (!in)
> +		return -ENOMEM;
> +
> +	MLX5_SET(modify_nic_vport_context_in, in, field_select.mtu, 1);
> +	MLX5_SET(modify_nic_vport_context_in, in, nic_vport_context.mtu,
> +		 mtu + MLX5V_ETH_HARD_MTU);
> +	MLX5_SET(modify_nic_vport_context_in, in, opcode,
> +		 MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT);
> +
> +	err = mlx5_cmd_exec_in(mdev, modify_nic_vport_context, in);
> +
> +	kvfree(in);
> +	return err;
> +}
> +
>   static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   			     const struct vdpa_dev_set_config *add_config)
>   {
> @@ -2749,6 +2771,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	mutex_init(&ndev->reslock);
>   	mutex_init(&ndev->numq_lock);
>   	config = &ndev->config;
> +
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
> +		err = config_func_mtu(mdev, add_config->net.mtu);
> +		if (err)
> +			goto err_mtu;
> +	}
> +

The code change here looks fine. Maybe not this patch, does this vDPA 
MTU option assume the exclusive use of parent SF device? I wonder if 
worth restoring the MTU upon any subsequent failure in this function, 
could the updated MTU value affect other SF children (e.g. Ethernet 
netdev, rdma), as vport's context has changed but the MTU change is not 
notified to other sibling drivers?

-Siwei

>   	err = query_mtu(mdev, &mtu);
>   	if (err)
>   		goto err_mtu;
> @@ -2867,7 +2896,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.device = mdev->device;
>   	mgtdev->mgtdev.id_table = id_table;
>   	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> -					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP) |
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
>   	mgtdev->mgtdev.max_supported_vqs =
>   		MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
>   	mgtdev->mgtdev.supported_features = get_supported_features(mdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
