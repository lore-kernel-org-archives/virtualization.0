Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B7C77B7A
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 03:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52FC481AC4;
	Tue, 16 May 2023 03:53:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52FC481AC4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=0Ii0lMHv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=JpFtSh7l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0loyfeNC0VRK; Tue, 16 May 2023 03:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4D6C81CD0;
	Tue, 16 May 2023 03:53:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4D6C81CD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 721B4C0036;
	Tue, 16 May 2023 03:53:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 553F9C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28D8681CD0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:53:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28D8681CD0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dEX5KVKis9h6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:53:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C028B81AC4
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C028B81AC4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:53:39 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FJsVSn010018; Tue, 16 May 2023 03:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WQZ8QkL7ApO8QSX/9yaKpjSB6WSp2o/f2WMpizH+KFY=;
 b=0Ii0lMHv8VrmA2RD92h8d6MyA54TQIF3CzhrVmw2NjEoM8HK9PQlJERbRCA6IsYgVi5m
 Yr7EPMWT3iijBHMiNG0Ja7fT7nPPNDDR2Ju6epjchbAGiEukUP3dinpUiXQwpwfGPNtI
 zXTTli2pu2xEBf++nU8fbJSYdRRbgYS8ra1rTVKHqEfKQTWu9hVrgW4Z+T2kQra/YfKO
 UpjlZ0iNbcioid+YDMFEJYNIUmuVXWsHz7fP2yH1Mt/hQKZ7qsNMi1DAGJsArfjC25O/
 XDhxA1PcqDYLZl2CEfiP8uLn/opRXaTaoLp+ANnSEoROqCLFW9DX2NTrKl8mSC1Mzk2X vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb1ek3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 03:53:22 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34G1amMf038917; Tue, 16 May 2023 03:53:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj109gb4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 03:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKpdjXvEwab0SL9SIc0xo9H0WSINBnHa/cTlB/Iww36HtpPuZMlvFGO0CMF8wx2PcOd7AYHeZopCmdk1et8QhljP89Hk2/X3wFOYz+BSCCYeNJXZViOefdwpZ5rGgwLti6cRwc6V0yfB0tr5A2KcS+QAs8vJ8lPhlQBCcB9hMAZHXlxG1gJfyiiR53WbPzuJBeIhyZFwhpeo1Evtj9eYFzcKD994QLQAksio2MW3Re7R0vfjy341WYqTRDFHLqWGYNlf01a5FFUlqhClkCbmrIJRoYspGqx5Bkkj3cJxQSKMoZkxvleHa2MmtOqlhdeqhWPo3nvjm9dWLVSzdut/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQZ8QkL7ApO8QSX/9yaKpjSB6WSp2o/f2WMpizH+KFY=;
 b=jg4T2O1XMhe96dbgooNQB68+ulLE1VUTOfr/mRWepX+djG6Xpg+J+jgkOhBkzRNT6j5ZzP69WCXCzWzKMj3oUekbD6drgPCSW7nLurIquC9PoESHwvc9XgeCW4hwq28k2VIeDw3S/GgpaIS7DQ8mFR56l7YAmogilzJPYPQIcj7r3mPspDdKsJH1Jym3BN/9Cq7QDDqt/wj9xLNpCVVuaOec31xgKANU+jFHXv9KpyHVAPgdt019IrGXnwK15RoSNnIuY6MAH8MXTDsJuvaKukJf5ldUIIywdufCLj5mH5z9qkKhtIbC7o3Smcb9b6/JqouLtPV19CZb4qVU+YYFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQZ8QkL7ApO8QSX/9yaKpjSB6WSp2o/f2WMpizH+KFY=;
 b=JpFtSh7l6QRKF1PD1BrV2yikDaRjnKlZlSNRJfn4R5OSMSBcdZVHt5UZ7BlyNIqn+PJIxyuEsat148k4uvOKhZeuEKxyIGjC+f24cjLC+C3byW45FsJvQq46liReHbA1X0uiCUb7s7L9pCbEWeIO0vsTaFh4ZSO3isrFkIAlsA8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 03:53:18 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 03:53:17 +0000
Message-ID: <8bfb7d1d-f7d0-94ca-4777-e31a2003027a@oracle.com>
Date: Mon, 15 May 2023 22:53:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
X-ClientProxiedBy: DS7PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:8:2a::12) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9812c7-7acc-4c89-75ae-08db55c11526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaF59JlLR9lcUvWwbEOAcdjLnJ4xaDckZCxr3jWEYs++pCfVMfM9S49yuGj8zyURpJDNxoApRlr+FtRcfI2b/S/z/WR8582FD2DSZ5uKAuSIuKRm9vKVcdHjqQEWXiAR0hI8SP4QlH5smKEo25G5k6JhvpsC55HgoTy4mdbk9vrhvFTPIvOT8uC4BjSZaRr4/4Uk+UF94d5IJz+cMgDzXF60FPjllzVfYA0fMjTmYUgB3JMIqY+GHfd7AAkG4T3DC19uMhbBX7UNJQmJBzL7JIY5nLnTRdZHertswP9B/wdEYf/8oEt+Om8ubIetRF+qfhuuSkJyTfnNQzsqsDtsLQ1ieGi3KbnPWaTzajEgG3kj/0truDg1ZNC5jKWwOx1QmGmbrb/ypyJcPt0QcxFsYSh1ktD5DP3M0bYZptHN4xJYI3HYYerqn/Z3EEm3JkBoQ3di+vzy3GBBAWl4zt4cBhH8cNULoGaHP9fWP2r4ipOIfI4vAjVWrYGYLcmrOBHmEklY9KJiglOv/S9YVgRMp65q1eQSNMQPd8BJkIqCw+y2kedctjLGV0TkBysyqmgs8C3AjhiSOtyQMxKG9+BuRrP+cg+So9hvOgv2qh/lDd6RKNT33eep0PUiMzKA3zzJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(41300700001)(31696002)(5660300002)(31686004)(86362001)(8936002)(7416002)(8676002)(66556008)(316002)(4326008)(66476007)(66946007)(38100700002)(2906002)(83380400001)(2616005)(36756003)(478600001)(110136005)(53546011)(54906003)(186003)(26005)(6486002)(966005)(6512007)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBmUlRqdEloRmpNci9Gck9YenpHY0FSb2FsczRMSUZsK01vSHVkeHh5NjNM?=
 =?utf-8?B?ZXNodCtxUTRZbUpoZGoxcHZkVURXQ1ZoNXM3VGxvRHRYSVdrTENyak1PRVlB?=
 =?utf-8?B?L1hpcnlsUWRETXR3bDRWQitDN0ZpYWswWStRZGpNYlE5SmVSamtIc3VKZ3dm?=
 =?utf-8?B?NkNWWU8rYTR4di9VWERNOVd0bFV2RE14bmlxR0UvT0o3NkR2Z0ZOaUVRdFdC?=
 =?utf-8?B?dm5CZW51Yk5ySkIrSXEzWUpzQ291aHh4elRkaDJtZXUzVElxV2RjSWdpMTRt?=
 =?utf-8?B?Si9STmthQmJZQml5YUdiWExUd3lja2JlQ3hEVC92bFRYc0pQdDNDcDdUSUkr?=
 =?utf-8?B?d21pd0p2WTViTmV6N2xwVE1QOGZUMi9mWXQzcXlSdVlnZFpaZmNQRkR2YTQ5?=
 =?utf-8?B?ekFiQlVrd1ZBRmNOZTlHaGh6Yy9YMHF1cksremNXbUZaTnA0R2cvN3V3ZW9N?=
 =?utf-8?B?NzJyNks2SGEwbDYyckoxeFNzZWF0UHlpUi85WnZabUIzMmhMQUtjeG5sYitr?=
 =?utf-8?B?R080ZnpTa2s3YXUycnVwbW9XK0tlbHdLUXV5MERYMndkMm5HRU5JOVpFR0RJ?=
 =?utf-8?B?ZE1pcGo4aU1EdjZvRlFMbVowSGFaVEhRd21LK2xzQVNhQ2JiVm90V1V6SzJS?=
 =?utf-8?B?SFZ1cXdsUEdZMmM2LzYwN0lock9hdXJZS0RhRldKN1pSejBzTUdNcUhQMlNT?=
 =?utf-8?B?dkNLZEZYWGUwdVQvNk12ZmROS0xzVXhQZmVtUzVHUS8wb1B3WERJMVpMWXk1?=
 =?utf-8?B?aXYzaEpIUFN0TUdPWS9FUWM4Q3BTWHd2ZnpBUDA5Q2pZWWJtUGdVbHg0N3VH?=
 =?utf-8?B?WWRqRTRHdWNIdU9zKytxT1ZUbXRUbU9RMGxFQk40bm5jbnJub21oZ25UdFpn?=
 =?utf-8?B?QW1OSGpTK0haaW9ESi9yOVA0aXMrWlRrM3ZjdHNMNHJKVGk0VHFiL29TQ3lu?=
 =?utf-8?B?SnFOMnpDQ1o2TDJqUVlPTmVHZTVSelNUQms1SW9HMnZYK3VrSmFDRjlqeS85?=
 =?utf-8?B?eTJDTnVlMVNQRzRhenpFNTRxOGdyZk04dWJsTmdvM00yZzgxTlBNMmdKZkdv?=
 =?utf-8?B?RWdmNjdBTXl1aUU0YktaWXB3MGYvWmxTbnA3K01nUHBQN25qNlJWdXpnOXhQ?=
 =?utf-8?B?MHFsK3NKL0YwcEFRZXdhYzNWVnhoZEU5QmpacG81bVdEcTJjR3VCeDI4N2JL?=
 =?utf-8?B?MjkrYStDTWk1S1hYakNNaForWXpQQVlMNFFUM0FTbWJFbTMyMHpDTjJmZjdX?=
 =?utf-8?B?dHRHUW01bUQvNk9KN0prbk0xVmorYVBQSWxJYnREUUFzZDNGaE5PYzUvK0dW?=
 =?utf-8?B?djJXRkNZTU13RDJJZE9SSWM3c0tCQlhDUUs3akN1ZkZlc1hwakg5SEZxSy9S?=
 =?utf-8?B?UlhkblVHK2hWbThWSHI1anFSbFk0cXdCMXdqNWtQN09GR2Q3NlpLUFdCVTVI?=
 =?utf-8?B?NE0zZ1VNYjlOQ01yZ1lMY3hqQ1o3U3JhVzhrTWprWVpQa2UvSGtUK3BkQlp3?=
 =?utf-8?B?cldGR01jbk9ibVhId0o3TlBEN29sN1l1S2lDT3c5ZjZTUHRZZWQyZXltc092?=
 =?utf-8?B?M3Ixc0ZacjBwejlaVkFmczRxa2JDcXluNzJyQmZ6YVNaYlZIVXpkbGxZQW5J?=
 =?utf-8?B?YUFtb1BEbWNrMkFQQWM1RVRmSCs2cTRSSUF0M3RHZ2QyMi9neDJYZU1ZRWVv?=
 =?utf-8?B?SlM5di9FajFMRjgzTVRnMXprUG5OakRIRkFQSFFFNlNLWkFGTDBPMFY0NmJL?=
 =?utf-8?B?bWczY24wNE9qUDJtZ1doY3YwOW5aN21QclgxUDY4Zzg2ZkprakFjSzJxd1Fn?=
 =?utf-8?B?Uy9JUHQybVNXM3VCbGgzWDF2czZ5SE5mZkR0RmdMY1BqbUd4WkxQZDI3cThC?=
 =?utf-8?B?Tkxzdld4OXNZbEdXa0NnVG5CVHhlaTVvOFlmWGZzUmxmYjdRVjNzakFMV3hN?=
 =?utf-8?B?VTZvVHViK2p3TTZ4UlNKTGpUMUNnOVVoZ0J3QU9Fa3A5a2g0Vi9jODZ5ZWZ4?=
 =?utf-8?B?UHkvTjNzRmJUTzFWcnhlSmlvYUtUd2F1K0xEaDljNWNrZ2NyVkJQejVEdndk?=
 =?utf-8?B?SXR1aXFBaUlOdjJoNVpUa1Z6K29tV0tFL1J0YjJFcmRHKzA4VXJLZnVjbDlC?=
 =?utf-8?B?cWFLM0VMK2V6aGwvOUNENklzY0tteCtXSVVxbm13bnVMWkFwSFgrSkVtRGVJ?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QUZ1WVR3SDNnNHZkb0tsL2sxOFlqVWxod01BZjFCS0hwRkVZZGZ6T3YrVHdC?=
 =?utf-8?B?MmRkb0FxdXEyUlB3TWtrOUV4OG9XRHAyQm1IdEFubXlOcDhmdWw1b3p2dThO?=
 =?utf-8?B?REphU2JBWlBTSFEwaU5welVpd3Z0aXVZUDhoTHBqTi9JQk5DWUR3NGR0QWZ0?=
 =?utf-8?B?REhkUVl6b0pzejkrRmNnTWw4WHN3SmpQN2JIdDA1N3VRcHBaVnpEYjAxMXRq?=
 =?utf-8?B?VHNKbUlSZHRSZkVwOHl5aXozZjMyQ1VjRy9LTUQzeXgzSVA2N0FGY2hoTlJi?=
 =?utf-8?B?WmJaaHlka052ajVycE9jR0JVOGZSQXpiTTRDbC94czNqUDZ5T1c2QXB2Rnph?=
 =?utf-8?B?bEx2b3pSMDhPcmZGbk55V09OR3pNb2xrWlgvQ1EvQVA1eWpIeVE2Uzc3R3d1?=
 =?utf-8?B?ZjlrSWdSZG1nK0hNdHVWb3lSSSt5b3dzY2FCdnFmclRGOVp3N0dwQlBNcEls?=
 =?utf-8?B?QnlZTjZpVnFlNXNvNTVmRGU2VFNjTk56eUtGN0QwL3VHUXhEam5mQUhxQUh2?=
 =?utf-8?B?UEZUYnljZnlwMStDd3pJdGVTWVVEQUJrbnRtdTBQNWtWSVEzeEV1Wk11RDVJ?=
 =?utf-8?B?c2czZHVJdzNxVTNQbUZoUmFLTlVZVktQRXFHQ20zek1OMW9QWWFVcGRwMEFK?=
 =?utf-8?B?eGwva0FLazMrNjMyZzh1VUVzdjgyUGpGNEZtd1dDQWVxSmpVRytaaU9ROVJO?=
 =?utf-8?B?RnVUU2VpK0tCMUJDci9ja2pmUTA2Sk9pSkdUR0svOU5UZFZYc3VkVVV5VDJC?=
 =?utf-8?B?SmYyL05ldnVjS0N4cEkrajJVd2JtYlkvQXZSNWRtZnN3ZjlJRFhqUitoczhZ?=
 =?utf-8?B?b2dDYVUzcUZFbEZhSWhxVzhVY0hONDdZdDJTb1hjVWdVWlIvMmJVQzlKYUdC?=
 =?utf-8?B?S3ZRSHNnL2haZHhUNjEwOU9CaDdpV1VnSngwZkxyd2FyQ3ZXTFRpQXVxcVhV?=
 =?utf-8?B?UExUakJ4NWlleWRBcTRRaXRvN2ZTbjdLSVpOeTlaN2lrVzl3d0EzN0duSTNU?=
 =?utf-8?B?eHZSVFFYTnRFUGl4eFY0SGttS1psanRsOHVDS1lvR3NLczBlUk5PSEdPNUdD?=
 =?utf-8?B?akl2YlFHV3N4OGEyVWpkR2Fvd3dwMzBMcE9YaTNoTHBsc01CU2cxV29XQUlQ?=
 =?utf-8?B?U2h0M0ErZnYyTW82cEJyUFZlQzQzRjFmRW9iMTNobVhRSW44NFhFYUlDelVw?=
 =?utf-8?B?ZGY4aDhSR2YvZy9aaE1kYmdTOG1xV3p2Z0RKUXdxWFBuVmZtNHc0TkNCSlNn?=
 =?utf-8?B?cDdoZHFRb3YvWjcvVU9FckRNUDN5NWlnUW8vdWV5em5DOUc1c01nVi9nR1Qx?=
 =?utf-8?B?SmNtM1NjOVdpamRvVUxMWUxkUHV6bVJieEd0QnU5dk5sSzQ3aktzQWVYdDU4?=
 =?utf-8?B?UVQyVnlEMjlOeG10YnpqUHEva09aREpTbUJucTgvYW9ST1EvRXJNaUFUL25Y?=
 =?utf-8?B?cDdCbE9ONVg2L0tZakFMeW9IaTNuYnZYK0Jzb3V5d3I3bkVBSXF5MWxlTlZw?=
 =?utf-8?B?L3l0SHBMT3NQbUZPQklFREh0MGFpWHJOcWhSaTdGell5cDB4Yk5EdElqN3VW?=
 =?utf-8?B?ZWdVZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9812c7-7acc-4c89-75ae-08db55c11526
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 03:53:17.7114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtyrpkobE8J5mU41VDsfoeHoDUwNHBF0YZafa+w/ShL5VWKWNQSp963U6er/3d4CHITqjnx0J5IU2RGnxqtdhN4VqK2dkI/3vMMXr0U5Htc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160032
X-Proofpoint-GUID: 5Mu5Xdfnq6jX86qOkX_sykFh21fcfERp
X-Proofpoint-ORIG-GUID: 5Mu5Xdfnq6jX86qOkX_sykFh21fcfERp
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNS8xNS8yMyA1OjU0IFBNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToKPiBPbiBNb24sIE1heSAx
NSwgMjAyMyBhdCAzOjIz4oCvUE0gTWlrZSBDaHJpc3RpZQo+IDxtaWNoYWVsLmNocmlzdGllQG9y
YWNsZS5jb20+IHdyb3RlOgo+Pgo+PiBUaGUgdmhvc3QgbGF5ZXIgcmVhbGx5IGRvZXNuJ3Qgd2Fu
dCBhbnkgc2lnbmFscyBhbmQgd2FudHMgdG8gd29yayBsaWtlIGt0aHJlYWRzCj4+IGZvciB0aGF0
IGNhc2UuIFRvIG1ha2UgaXQgcmVhbGx5IHNpbXBsZSBjYW4gd2UgZG8gc29tZXRoaW5nIGxpa2Ug
dGhpcyB3aGVyZSBpdAo+PiBzZXBhcmF0ZXMgdXNlciBhbmQgaW8gd29ya2VyIGJlaGF2aW9yIHdo
ZXJlIHRoZSBtYWpvciBkaWZmIGlzIGhvdyB0aGV5IGhhbmRsZQo+PiBzaWduYWxzIGFuZCBleGl0
LiBJIGFsc28gaW5jbHVkZWQgYSBmaXggZm9yIHRoZSBmcmVlemUgY2FzZToKPiAKPiBJIGRvbid0
IGxvdmUgdGhlIFNJR0tJTEwgc3BlY2lhbCBjYXNlLCBidXQgSSBhbHNvIGRvbid0IGZpbmQgdGhp
cwo+IGRlZXBseSBvZmZlbnNpdmUuIFNvIGlmIHRoaXMgaXMgd2hhdCBpdCB0YWtlcywgSSdtIG9r
IHdpdGggaXQuCj4gCj4gSSB3b25kZXIgaWYgd2UgY291bGQgbWFrZSB0aGF0IHNwZWNpYWwgY2Fz
ZSBzaW1wbHkgY2hlY2sgZm9yICJpcwo+IFNJR0tJTEwgYmxvY2tlZCIgaW5zdGVhZD8gTm8gbm9y
bWFsIGNhc2Ugd2lsbCBjYXVzZSB0aGF0LCBhbmQgaXQgbWVhbnMKClllYWgsIGl0J3MgZG9hYmxl
LiBVcGRhdGVkIGJlbG93LgoKPiB0aGF0IGEgUEZfVVNFUl9XT1JLRVIgdGhyZWFkIGNvdWxkIGRl
Y2lkZSBwZXItdGhyZWFkIHdoYXQgaXQgd2FudHMgdG8KPiBkbyB3cnQgU0lHS0lMTC4KPiAKPiBD
aHJpc3RpYW4/IEFuZCBJIGd1ZXNzIHdlIHNob3VsZCBDYzogT2xlZyB0b28sIHNpbmNlIHRoZSBz
aWduYWwgcGFydHMKPiBhcmUgYW4gYXJlYSBoZSdzIGZhbWlsaWFyIHdpdGggYW5kIGhhcyB3b3Jr
ZWQgb24uLiBFcmljIEJpZWRlcm1hbiBoYXMKPiBhbHJlYWR5IGJlZW4gb24gdGhlIGxpc3QgYW5k
IGhhcyBhbHNvIGJlZW4gaW52b2x2ZWQKPiAKPiBPbGVnOiBzZWUKPiAKPiAgIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMTIyYjU5N2UtYTVmYS1kYWY3LTI3YmItNmYwNGZhOThkNDk2QG9y
YWNsZS5jb20vCj4gCj4gZm9yIHRoZSBjb250ZXh0IGhlcmUuCgpPbGVnIGFuZCBDaHJpc3RpYW4s
CgoKQmVsb3cgaXMgYW4gdXBkYXRlZCBwYXRjaCB0aGF0IGRvZXNuJ3QgY2hlY2sgZm9yIFBGX1VT
RVJfV09SS0VSIGluIHRoZQpzaWduYWwuYyBjb2RlIGFuZCBpbnN0ZWFkIHdpbGwgY2hlY2sgZm9y
IGlmIHdlIGhhdmUgYmxvY2tlZCB0aGUgc2lnbmFsLgoKCgoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvc2NoZWQvdGFzay5oIGIvaW5jbHVkZS9saW51eC9zY2hlZC90YXNrLmgKaW5kZXggNTM3
Y2JmOWEyYWRlLi5lMGY1YWM5MGEyMjggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2NoZWQv
dGFzay5oCisrKyBiL2luY2x1ZGUvbGludXgvc2NoZWQvdGFzay5oCkBAIC0yOSw3ICsyOSw2IEBA
IHN0cnVjdCBrZXJuZWxfY2xvbmVfYXJncyB7CiAJdTMyIGlvX3RocmVhZDoxOwogCXUzMiB1c2Vy
X3dvcmtlcjoxOwogCXUzMiBub19maWxlczoxOwotCXUzMiBpZ25vcmVfc2lnbmFsczoxOwogCXVu
c2lnbmVkIGxvbmcgc3RhY2s7CiAJdW5zaWduZWQgbG9uZyBzdGFja19zaXplOwogCXVuc2lnbmVk
IGxvbmcgdGxzOwpkaWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMKaW5k
ZXggZWQ0ZTAxZGFjY2FhLi5mZDI5NzBiNTk4YjIgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9mb3JrLmMK
KysrIGIva2VybmVsL2ZvcmsuYwpAQCAtMjMzNiw4ICsyMzM2LDE1IEBAIF9fbGF0ZW50X2VudHJv
cHkgc3RydWN0IHRhc2tfc3RydWN0ICpjb3B5X3Byb2Nlc3MoCiAJcC0+ZmxhZ3MgJj0gflBGX0tU
SFJFQUQ7CiAJaWYgKGFyZ3MtPmt0aHJlYWQpCiAJCXAtPmZsYWdzIHw9IFBGX0tUSFJFQUQ7Ci0J
aWYgKGFyZ3MtPnVzZXJfd29ya2VyKQorCWlmIChhcmdzLT51c2VyX3dvcmtlcikgeworCQkvKgor
CQkgKiBVc2VyIHdvcmtlciBhcmUgc2ltaWxhciB0byBpb190aHJlYWRzIGJ1dCB0aGV5IGRvIG5v
dAorCQkgKiBzdXBwb3J0IHNpZ25hbHMgYW5kIGNsZWFudXAgaXMgZHJpdmVuIHZpYSBhbm90aGVy
IGtlcm5lbAorCQkgKiBpbnRlcmZhY2Ugc28gZXZlbiBTSUdLSUxMIGlzIGJsb2NrZWQuCisJCSAq
LwogCQlwLT5mbGFncyB8PSBQRl9VU0VSX1dPUktFUjsKKwkJc2lnaW5pdHNldGludigmcC0+Ymxv
Y2tlZCwgMCk7CisJfQogCWlmIChhcmdzLT5pb190aHJlYWQpIHsKIAkJLyoKIAkJICogTWFyayB1
cyBhbiBJTyB3b3JrZXIsIGFuZCBibG9jayBhbnkgc2lnbmFsIHRoYXQgaXNuJ3QKQEAgLTI1MTcs
OCArMjUyNCw4IEBAIF9fbGF0ZW50X2VudHJvcHkgc3RydWN0IHRhc2tfc3RydWN0ICpjb3B5X3By
b2Nlc3MoCiAJaWYgKHJldHZhbCkKIAkJZ290byBiYWRfZm9ya19jbGVhbnVwX2lvOwogCi0JaWYg
KGFyZ3MtPmlnbm9yZV9zaWduYWxzKQotCQlpZ25vcmVfc2lnbmFscyhwKTsKKwlpZiAoYXJncy0+
dXNlcl93b3JrZXIpCisJCXAtPmZsYWdzIHw9IFBGX05PRlJFRVpFOwogCiAJc3RhY2tsZWFrX3Rh
c2tfaW5pdChwKTsKIApAQCAtMjg2MCw3ICsyODY3LDYgQEAgc3RydWN0IHRhc2tfc3RydWN0ICpj
cmVhdGVfaW9fdGhyZWFkKGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcsIGludCBub2RlKQog
CQkuZm4JCT0gZm4sCiAJCS5mbl9hcmcJCT0gYXJnLAogCQkuaW9fdGhyZWFkCT0gMSwKLQkJLnVz
ZXJfd29ya2VyCT0gMSwKIAl9OwogCiAJcmV0dXJuIGNvcHlfcHJvY2VzcyhOVUxMLCAwLCBub2Rl
LCAmYXJncyk7CmRpZmYgLS1naXQgYS9rZXJuZWwvc2lnbmFsLmMgYi9rZXJuZWwvc2lnbmFsLmMK
aW5kZXggOGY2MzMwZjBlOWNhLi5iYzdlMjYwNzI0MzcgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zaWdu
YWwuYworKysgYi9rZXJuZWwvc2lnbmFsLmMKQEAgLTk5NSw2ICs5OTUsMTkgQEAgc3RhdGljIGlu
bGluZSBib29sIHdhbnRzX3NpZ25hbChpbnQgc2lnLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApCiAJ
cmV0dXJuIHRhc2tfY3VycihwKSB8fCAhdGFza19zaWdwZW5kaW5nKHApOwogfQogCitzdGF0aWMg
dm9pZCB0cnlfc2V0X3BlbmRpbmdfc2lna2lsbChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQpCit7CisJ
LyoKKwkgKiBVc2VyIHdvcmtlcnMgZG9uJ3Qgc3VwcG9ydCBzaWduYWxzIGFuZCB0aGVpciBleGl0
IGlzIGRyaXZlbiB0aHJvdWdoCisJICogdGhlaXIga2VybmVsIGxheWVyLCBzbyBieSBkZWZhdWx0
IGJsb2NrIGV2ZW4gU0lHS0lMTC4KKwkgKi8KKwlpZiAoc2lnaXNtZW1iZXIoJnQtPmJsb2NrZWQs
IFNJR0tJTEwpKQorCQlyZXR1cm47CisKKwlzaWdhZGRzZXQoJnQtPnBlbmRpbmcuc2lnbmFsLCBT
SUdLSUxMKTsKKwlzaWduYWxfd2FrZV91cCh0LCAxKTsKK30KKwogc3RhdGljIHZvaWQgY29tcGxl
dGVfc2lnbmFsKGludCBzaWcsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgZW51bSBwaWRfdHlwZSB0
eXBlKQogewogCXN0cnVjdCBzaWduYWxfc3RydWN0ICpzaWduYWwgPSBwLT5zaWduYWw7CkBAIC0x
MDU1LDggKzEwNjgsNyBAQCBzdGF0aWMgdm9pZCBjb21wbGV0ZV9zaWduYWwoaW50IHNpZywgc3Ry
dWN0IHRhc2tfc3RydWN0ICpwLCBlbnVtIHBpZF90eXBlIHR5cGUpCiAJCQl0ID0gcDsKIAkJCWRv
IHsKIAkJCQl0YXNrX2NsZWFyX2pvYmN0bF9wZW5kaW5nKHQsIEpPQkNUTF9QRU5ESU5HX01BU0sp
OwotCQkJCXNpZ2FkZHNldCgmdC0+cGVuZGluZy5zaWduYWwsIFNJR0tJTEwpOwotCQkJCXNpZ25h
bF93YWtlX3VwKHQsIDEpOworCQkJCXRyeV9zZXRfcGVuZGluZ19zaWdraWxsKHQpOwogCQkJfSB3
aGlsZV9lYWNoX3RocmVhZChwLCB0KTsKIAkJCXJldHVybjsKIAkJfQpAQCAtMTM3Myw4ICsxMzg1
LDcgQEAgaW50IHphcF9vdGhlcl90aHJlYWRzKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkKIAkJLyog
RG9uJ3QgYm90aGVyIHdpdGggYWxyZWFkeSBkZWFkIHRocmVhZHMgKi8KIAkJaWYgKHQtPmV4aXRf
c3RhdGUpCiAJCQljb250aW51ZTsKLQkJc2lnYWRkc2V0KCZ0LT5wZW5kaW5nLnNpZ25hbCwgU0lH
S0lMTCk7Ci0JCXNpZ25hbF93YWtlX3VwKHQsIDEpOworCQl0cnlfc2V0X3BlbmRpbmdfc2lna2ls
bCh0KTsKIAl9CiAKIAlyZXR1cm4gY291bnQ7CmRpZmYgLS1naXQgYS9rZXJuZWwvdmhvc3RfdGFz
ay5jIGIva2VybmVsL3Zob3N0X3Rhc2suYwppbmRleCBiN2NiZDY2Zjg4OWUuLjJkOGQzZWJhZWM0
ZCAxMDA2NDQKLS0tIGEva2VybmVsL3Zob3N0X3Rhc2suYworKysgYi9rZXJuZWwvdmhvc3RfdGFz
ay5jCkBAIC03NSwxMyArNzUsMTMgQEAgc3RydWN0IHZob3N0X3Rhc2sgKnZob3N0X3Rhc2tfY3Jl
YXRlKGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcsCiAJCQkJICAgICBjb25zdCBjaGFyICpu
YW1lKQogewogCXN0cnVjdCBrZXJuZWxfY2xvbmVfYXJncyBhcmdzID0gewotCQkuZmxhZ3MJCT0g
Q0xPTkVfRlMgfCBDTE9ORV9VTlRSQUNFRCB8IENMT05FX1ZNLAorCQkuZmxhZ3MJCT0gQ0xPTkVf
RlMgfCBDTE9ORV9VTlRSQUNFRCB8IENMT05FX1ZNIHwKKwkJCQkgIENMT05FX1RIUkVBRCB8IENM
T05FX1NJR0hBTkQsCiAJCS5leGl0X3NpZ25hbAk9IDAsCiAJCS5mbgkJPSB2aG9zdF90YXNrX2Zu
LAogCQkubmFtZQkJPSBuYW1lLAogCQkudXNlcl93b3JrZXIJPSAxLAogCQkubm9fZmlsZXMJPSAx
LAotCQkuaWdub3JlX3NpZ25hbHMJPSAxLAogCX07CiAJc3RydWN0IHZob3N0X3Rhc2sgKnZ0c2s7
CiAJc3RydWN0IHRhc2tfc3RydWN0ICp0c2s7CmRpZmYgLS1naXQgYS9tbS92bXNjYW4uYyBiL21t
L3Ztc2Nhbi5jCmluZGV4IGQyNTc5MTZmMzllNS4uMjU1YTIxNDdlNWMxIDEwMDY0NAotLS0gYS9t
bS92bXNjYW4uYworKysgYi9tbS92bXNjYW4uYwpAQCAtMTIwNywxMiArMTIwNywxMiBAQCB2b2lk
IHJlY2xhaW1fdGhyb3R0bGUocGdfZGF0YV90ICpwZ2RhdCwgZW51bSB2bXNjYW5fdGhyb3R0bGVf
c3RhdGUgcmVhc29uKQogCURFRklORV9XQUlUKHdhaXQpOwogCiAJLyoKLQkgKiBEbyBub3QgdGhy
b3R0bGUgdXNlciB3b3JrZXJzLCBrdGhyZWFkcyBvdGhlciB0aGFuIGtzd2FwZCBvcgorCSAqIERv
IG5vdCB0aHJvdHRsZSBJTy91c2VyIHdvcmtlcnMsIGt0aHJlYWRzIG90aGVyIHRoYW4ga3N3YXBk
IG9yCiAJICogd29ya3F1ZXVlcy4gVGhleSBtYXkgYmUgcmVxdWlyZWQgZm9yIHJlY2xhaW0gdG8g
bWFrZQogCSAqIGZvcndhcmQgcHJvZ3Jlc3MgKGUuZy4gam91cm5hbGxpbmcgd29ya3F1ZXVlcyBv
ciBrdGhyZWFkcykuCiAJICovCiAJaWYgKCFjdXJyZW50X2lzX2tzd2FwZCgpICYmCi0JICAgIGN1
cnJlbnQtPmZsYWdzICYgKFBGX1VTRVJfV09SS0VSfFBGX0tUSFJFQUQpKSB7CisJICAgIGN1cnJl
bnQtPmZsYWdzICYgKFBGX1VTRVJfV09SS0VSfFBGX0lPX1dPUktFUnxQRl9LVEhSRUFEKSkgewog
CQljb25kX3Jlc2NoZWQoKTsKIAkJcmV0dXJuOwogCX0KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
