Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0BFC25B07
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 18:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 182F481356;
	Tue,  9 Aug 2022 18:06:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 182F481356
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=V6Vf6X+/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=EgKwvMzz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fStWZvt74zGJ; Tue,  9 Aug 2022 18:06:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC32481366;
	Tue,  9 Aug 2022 18:06:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC32481366
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C21E1C0033;
	Tue,  9 Aug 2022 18:06:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B737C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:06:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D917960B4E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:06:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D917960B4E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=V6Vf6X+/; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=EgKwvMzz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TwRnk_IGsMiN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:06:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DAC1360648
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DAC1360648
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:06:43 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279GdtWN008715;
 Tue, 9 Aug 2022 18:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tA2/2Mio39tF9ErN0K9kfouUCTtXB6fL8ndApXZjNj8=;
 b=V6Vf6X+/TPu1QBvQ7p1g3GpmPJz9TZNupOMi2e+S6/FDuV5eSwBNhaHmz0Qze7OSTi5g
 /Dra3hDbcEJq755Ws/SsLCK4KRiV2VmlmNrkXiMn7z0ZjG0ewU5w4Ub9ThhCTq84xt30
 1IMvFzNO4d/GgIUi/CpeEuhX+qhHgGC5xm7h49UYb/pWPe+1l4gDeq7iPcLd4x9/sso3
 e2HLAEihJK7NDqoxF3c73w7ZTpvrB0FAGQg2FvWaNc8HbQgNMtPfjIWI0dkX6v0tTS9Y
 XcRE1OOqqIrJgYGFeeB9dCpnEPijpTntAtxNevU6qSc13LRt3vkYrOvFjx7qP26RuE5g 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsew17cfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 18:06:38 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 279Hsqlm013046; Tue, 9 Aug 2022 18:06:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hu0q32pc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 18:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPnKI0OzE1Hg7uSFJIl7B31jTgPogIm/LAHROXf381dwrJk6eQGtUIDQ5bIMuqtEj0vQfoqbwEfTsee28BnFSQVm3S60Y3tAen6IZWR+3R2M87Dkf2HpcRGAXWYTNRS3JrSzKOAegbUVLa335M64sXmFije9IUhhtARp6LWrxRRcGIdwVBF/Ai/1JA6bNPzwalttHTNIH0Uas46iXSXTrl+rth1LpQsmfrfTvPZmgl9MXXohiXcGVizmttFCGdvaDvLNfMx0tu30nWpZuZfTrNq9FzvfUQu65G+zsWfSyD3hhF/Ur8mcQJ9+thPlSUHliCZTjV6wmqCh/xzdZV7e6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA2/2Mio39tF9ErN0K9kfouUCTtXB6fL8ndApXZjNj8=;
 b=aJCYZyu+ozdJsZ/irwZirsyQESIK9VXGjrzLlLJbNwkqp4MUQNDNF0QW/oD9cXvpdOYW9hnRUui5CRr3sM2PHtgM+vBXMXuTP3Cz9PDHtqKAZ2+4Re+pDSncydazJyanw0aHOd6Jjod4qwLjhosYCpbUPdPd7vvTc7JHUF5+l5hOvgv40xoQputVeRiDlwlsEFo2PPhVcnpGWp7UYWXvi66hG7+a2V3n/Kp0mLvs5tDUi42kAH4VdLddlua6AatUKg59SV2yD6m4vxGdPvxHf+rPBGTMU7lTLGO2M91L5x/98haAPPivI/4tNrpfxTCcJeH2lQeyU5KWauplmPjzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA2/2Mio39tF9ErN0K9kfouUCTtXB6fL8ndApXZjNj8=;
 b=EgKwvMzzUEanCQpEFBu4imuMKMiNv7ICPi8b3re+97d3beiXQ5QWp7+knY/cKnodESLiNdHdP5xZOhTwwRsvizVmjnWZvB05ftkh8J9MN7/+ew+hNc3rIvpolOXf7yCtMMQFU6nDCs6kupMSteMvZXtO9arT9/S5jFrdF7rISKE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN8PR10MB3490.namprd10.prod.outlook.com (2603:10b6:408:b6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 18:06:32 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 18:06:32 +0000
Message-ID: <65d518e8-387a-64be-0408-de6804313284@oracle.com>
Date: Tue, 9 Aug 2022 11:06:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, stephen@networkplumber.org, 
 davem@davemloft.net, virtualization@lists.linux-foundation.org,
 virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com,
 alexander.h.duyck@intel.com, kubakici@wp.pl,
 sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d27c10da-2b36-4fcd-56d9-08da7a31e3e3
X-MS-TrafficTypeDiagnostic: BN8PR10MB3490:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sj2cwJPBdirG/Y7pY4Tz7F7DWk2gPaJHVnktbhEnnS5A4kEPzbNhrpdXHfHNJ0zb53z9uhS70FaGuR/eA6uevsSJMXD6czfCqfiirBMByDIQdGBME1LIb5woVU7c2sSVZx6VHfzfSzR6KONqi0IkcbA9V0TmPD7UHadVzbz2UfjIdWiEkDmxoTyCPehvNhUK3XFji01wxGnCpsIg5qON4oCuQ/hEgV87BDOBQJ1h13C1RcKECvCJdThYlpGloZ9vJzPNK12YWzawLxOfv4M/ifxzs6LtDNswsgJ70mqBvjpn3HfibUZIR78M2hS9QpVf55pMPMhbCAEjnLiyctDDI55Tk05zwwNj9tgRpWIrRkeaRVO4mWnz4luzmEm5rCAcZzZbwK5IhHImbTQMgDTTU97IbwbpOBmTX9DCOTRyAA6iTbiWgLiQBQU/Zs5nYVNQS2WyFBGB4jLmxzTuX8l/cPgd6rTBHlsn1UX6p4czHUMgRsXlkx8fuu2pTm0kN+u6D3OqwikWpXh3X0c6BKg0Qk87L4wn5YQZr0VUTpI/HVpF5Q4PelMG+5dtOWNOchapqLXiwoCmp3tdYBMIfAsThkfGanpRvAr7QrUP0TUwOWPrBheUBljtZYUxlh9IZ0tKoNKwtOMHrz06i88PKGrkReMyV3tj2GPoWPw8ny9f3apTvMo35ErS5uxowvHbjeUPO41patnTYCDMqJNCc6D096HGOoENk3LC7usraouXMPcs/Vd7sGnRd6KHy4lJOH2aAuEij4ZVU9Da8TJk7K4vD43oiyt6fQwy68LJL+hQeQ+OmWFoxrXdtXmf/L+d5Y41s+9CQkm6oB1JXXlPC10+cF6z5Pn66AA/u9R2x7ywDDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(376002)(396003)(346002)(366004)(39860400002)(921005)(38100700002)(36916002)(53546011)(33964004)(6506007)(6666004)(41300700001)(6512007)(86362001)(26005)(31696002)(8936002)(2616005)(83380400001)(186003)(31686004)(30864003)(5660300002)(7416002)(66556008)(66476007)(4326008)(8676002)(66946007)(36756003)(2906002)(478600001)(6486002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFE5WmY4KzJCbDN4ck1FSFc4a2w0SkQ2a2o4ZHRJaVpqRDdURmJ4dFlIMzJQ?=
 =?utf-8?B?cHFuMGxmSWc1aXZ0cktiWVZ6aER5K093aWxrTUZTUUI1dytyUVZRa0NsZlRs?=
 =?utf-8?B?MzhRQkJkandINHhyWTdSbTA5QkxHRXNBakRqSGs3OGk3ekNydkg5UVRKdm1t?=
 =?utf-8?B?WmpTY3ljcU1HcFd0Um94ZVk5Q1VreXZ2OUJoUVc0TElDMlVCSUhqOVhTWVVU?=
 =?utf-8?B?STkxdnlwQmZnVlhTMTJDd1JuRzlFdFpYdWNvM2NNQVJJcnhOYVNrclhJKzJN?=
 =?utf-8?B?Tmo5U0Erc0lYL1dodkcrSFRRVm91TWxhb1BreVNpcDNrTzFGMk5DVFV2c2Jz?=
 =?utf-8?B?aExsWHN2QTJ1ZlRuOXkzZVp4eG5TVjBhMnJiYXVYUVhQR0x2SkhEY1hYMnRI?=
 =?utf-8?B?blZNb0Evd0FUNHpxRkxmYkRLd3pxZDNweXNWbTh2eFAyNC9tMkJBRHdCYURp?=
 =?utf-8?B?Ry9xNFUveU1YMXNMR2RvSWVkd1VPWG1aaGMvVko1MUFyNGloeUtrQWNJTUsy?=
 =?utf-8?B?cWZSaEgwTG5hYkJJNmJUMjc4QXI2bFNOaGpiUXYrb3oxK1lSbEZ6UURpTmor?=
 =?utf-8?B?dEx5SjMvVThMY1B6N21PRmNmOEdaV1hzdHhkM2lSdHBCTGtxdW1iQ1JmalFX?=
 =?utf-8?B?RkNOUjcyeWU1ZFU3aVZsVldxZ3BaZG5EVlpaaTlXN3VIdVduU3hNbTRsd0gw?=
 =?utf-8?B?TXgrSE1qcXlyR1ZOZGR1TW50akc2TlIzQWdZc3F2THpOaWdlVGxoVHF0NktB?=
 =?utf-8?B?ZDhwOWRBcFFJaWdNSUFXZVRjc1Yza2pqcENHSW10VHNwRkhSY3J6YjZSSjJo?=
 =?utf-8?B?ZThGZXQyN1d3eGcwdm5LbUI4eGsvdlBqblR0aDNWbzc0Z3pIdldkUWpCTytj?=
 =?utf-8?B?ZzRabEpVNlVmZEd1WHNYWnp4ZnRadThwd1F2ZncrMEplZlk1S3o5VWIvV0Q5?=
 =?utf-8?B?Uzd3NHpyVDNkTkJKV21QdmlMa1UzSmNOemVNM1JscEZHSzJRVnNqbGN4YWFk?=
 =?utf-8?B?dkQvRTRIMFFjZDhwbGJvakdaMjNwTFBrSlVSMUkyamtpUjYrc2FnNFkyclNI?=
 =?utf-8?B?aGF2RUdTM0hnVmZCMnRrcHA3YmpQWGlscWQ3M2U3dDVmVEZBeHRZbUNWdHc2?=
 =?utf-8?B?emcrbFNqWENYSnI0amR4Ly9wUEZVMG9CRW1Hb2lMUjBwMjIxTXBSa2s3RGxX?=
 =?utf-8?B?cWdnWWdSZUNsWWpBNTN2Q0tldC8yWXg0YnpoVXhTSXJDd1RHUnIwU1h3ZUN0?=
 =?utf-8?B?d2VPRVZzdjNPQVFWdS9TWmoxY3NHY1RURkRxdTZ3NkJYN2dWMXUzM1ZveEVT?=
 =?utf-8?B?R0N3K1lyNlBoa0JQdVErQzZIa0JTeHdDNmdQQTYxRXlpK1pXSWY4ZnlNQmMv?=
 =?utf-8?B?WlRKcWlFL1hBWW04YXpvSlRVTk5iWTNjL1ZPR21sMHJxVmNybFk3enRlcVoz?=
 =?utf-8?B?OGJkalUxUTRwMVNabS9GQUVsVFZiYXMyc3RseGRyQ1VMd0tlMVZiYjRERG5o?=
 =?utf-8?B?T2lWQ0Y0TmVoZ0pWWmFkNk1FeXF1Q21BSlJNQ1gxTmRHWGJRSnE2MDdCL0lZ?=
 =?utf-8?B?Y1d4NjZIaTdXbndOVCt6dE1XcFRTczhKMHV4TGVVcjhPZFZQZXhoTWQwNU1O?=
 =?utf-8?B?ZjZ1a0ZsSVlTb016MEZ6VVY1dGVGTjJCOERNNURNNVF2bnBpeDZMdDY4UVo2?=
 =?utf-8?B?elBNVTdTd2xNWGFER2l2b01IOVZtaFpFek9nTG5lVEx0Y3RTWmh4WGp2d296?=
 =?utf-8?B?bWpkTDVvdmNCNGxBWUp2czd5WmxGWnBtOXBEOTNJZ0wwVncrNFE3Nk1OKzdP?=
 =?utf-8?B?ZGg3WUZqcHVUN2trSm9ZbTlDQ0RPZkN3Y2JQMzRhd0xqQS9Xd0phTTdMODRx?=
 =?utf-8?B?dVdrbktueVQ2cGI0ZFRGNXJvcndHVjREeUNacTFjNG1ROXh4ajFKWEZCeUVK?=
 =?utf-8?B?WERtVHJudE9uUnVlQTlWb1hCbjRIN1ZWRFJ0WDlYUHhicmZOZ3dsRVdyVnVm?=
 =?utf-8?B?SURCeSsrNkhkbVlZaEtXTEJJTzZhYWFsS3F6QzBYZWl1MXdjVUYxQmhRTnFt?=
 =?utf-8?B?Y2ZXSTg3aGFpMzZTSFlEWVJHaUhQYm96THlkUlBRL1NwN2dJOGtjWGpZR2hG?=
 =?utf-8?Q?iyj4IxevbS7QmuiLmpMZSRaUI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27c10da-2b36-4fcd-56d9-08da7a31e3e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 18:06:32.3065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RpXACo+MEeGvBMymYAZWso+F3Oz9N1rnus74OUusMVO5H4dTjXvwreAJwxwp+7V68Mf0LDrg+luW4yI1LOX6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208090070
X-Proofpoint-ORIG-GUID: 9VRVfsAVv0FX24u3RzW7llliFY--fzmW
X-Proofpoint-GUID: 9VRVfsAVv0FX24u3RzW7llliFY--fzmW
Cc: gavi@nvidia.com
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
Content-Type: multipart/mixed; boundary="===============0575661623759937062=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0575661623759937062==
Content-Type: multipart/alternative;
 boundary="------------qzVStYBRiJOLs31OZvug4027"
Content-Language: en-US

--------------qzVStYBRiJOLs31OZvug4027
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/9/2022 12:06 AM, Gavin Li wrote:
>
>
> On 8/9/2022 7:56 AM, Si-Wei Liu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 8/8/2022 12:31 AM, Gavin Li wrote:
>>>
>>> On 8/6/2022 6:11 AM, Si-Wei Liu wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 8/1/2022 9:45 PM, Gavin Li wrote:
>>>>> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
>>>>> packets even when GUEST_* offloads are not present on the device.
>>>>> However, if GSO is not supported,
>>>> GUEST GSO (virtio term), or GRO HW (netdev core term) it should have
>>>> been be called.
>>> ACK
>>>>
>>>>>   it would be sufficient to allocate
>>>>> segments to cover just up the MTU size and no further. Allocating the
>>>>> maximum amount of segments results in a large waste of buffer 
>>>>> space in
>>>>> the queue, which limits the number of packets that can be buffered 
>>>>> and
>>>>> can result in reduced performance.
>>>>>
>>>>> Therefore, if GSO is not supported,
>>>> Ditto.
>>> ACK
>>>>
>>>>> use the MTU to calculate the
>>>>> optimal amount of segments required.
>>>>>
>>>>> Below is the iperf TCP test results over a Mellanox NIC, using 
>>>>> vDPA for
>>>>> 1 VQ, queue size 1024, before and after the change, with the iperf
>>>>> server running over the virtio-net interface.
>>>>>
>>>>> MTU(Bytes)/Bandwidth (Gbit/s)
>>>>>               Before   After
>>>>>    1500        22.5     22.4
>>>>>    9000        12.8     25.9
>>>>>
>>>>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>>>>> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
>>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>>> ---
>>>>>   drivers/net/virtio_net.c | 20 ++++++++++++++++----
>>>>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>> index ec8e1b3108c3..d36918c1809d 100644
>>>>> --- a/drivers/net/virtio_net.c
>>>>> +++ b/drivers/net/virtio_net.c
>>>>> @@ -222,6 +222,9 @@ struct virtnet_info {
>>>>>       /* I like... big packets and I cannot lie! */
>>>>>       bool big_packets;
>>>>>
>>>>> +     /* Indicates GSO support */
>>>>> +     bool gso_is_supported;
>>>>> +
>>>>>       /* Host will merge rx buffers for big packets (shake it! shake
>>>>> it!) */
>>>>>       bool mergeable_rx_bufs;
>>>>>
>>>>> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct
>>>>> virtnet_info *vi, struct receive_queue *rq,
>>>>>   static int add_recvbuf_big(struct virtnet_info *vi, struct
>>>>> receive_queue *rq,
>>>>>                          gfp_t gfp)
>>>>>   {
>>>>> +     unsigned int sg_num = MAX_SKB_FRAGS;
>>>>>       struct page *first, *list = NULL;
>>>>>       char *p;
>>>>>       int i, err, offset;
>>>>>
>>>>> -     sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
>>>>> +     if (!vi->gso_is_supported) {
>>>>> +             unsigned int mtu = vi->dev->mtu;
>>>>> +
>>>>> +             sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu
>>>>> / PAGE_SIZE;
>>>> DIV_ROUND_UP() can be used?
>>> ACK
>>>>
>>>> Since this branch slightly adds up cost to the datapath, I wonder if
>>>> this sg_num can be saved and set only once (generally in virtnet_probe
>>>> time) in struct virtnet_info?
>>> Not sure how to do it and align it with align with new mtu during
>>> .ndo_change_mtu()---as you mentioned in the following mail. Any idea?
>>> ndo_change_mtu might be in vendor specific code and unmanageable. In
>>> my case, the mtu can only be changed in the xml of the guest vm.
>> Nope, for e.g. "ip link dev eth0 set mtu 1500" can be done from guest 
>> on a virtio-net device with 9000 MTU (as defined in guest xml). 
>> Basically
>> guest user can set MTU to any valid value lower than the original
>> HOST_MTU. In the vendor defined .ndo_change_mtu() op, dev_validate_mtu()
>> should have validated the MTU value before coming down to it. And I
>> suspect you might want to do virtnet_close() and virtnet_open()
>> before/after changing the buffer size on the fly (the netif_running()
>> case), implementing .ndo_change_mtu() will be needed anyway.
> a guest VM driver changing mtu to smaller one is valid use case. 
> However, current optimization suggested in the patch doesn't degrade 
> any performance. Performing close() and open() sequence is good idea, 
> that I would like to take up next after this patch as its going to be 
> more than one patch to achieve it.
Sure, it's fine to separate it out into another patch and optimize on 
top later on. Though the previous comment of avoiding repeatedly 
computing sg_num in datapath still holds: set sg_num only once in 
probe() time then, in which case the sg_num needed can be simply 
inferred from dev->max_mtu rather than dev->mtu.

-Siwei

>>
>>>>> +     }
>>>>> +
>>>>> +     sg_init_table(rq->sg, sg_num + 2);
>>>>>
>>>>>       /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
>>>> Comment doesn't match code.
>>> ACK
>>>>> -     for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
>>>>> +     for (i = sg_num + 1; i > 1; --i) {
>>>>>               first = get_a_page(rq, gfp);
>>>>>               if (!first) {
>>>>>                       if (list)
>>>>> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info
>>>>> *vi, struct receive_queue *rq,
>>>>>
>>>>>       /* chain first in list head */
>>>>>       first->private = (unsigned long)list;
>>>>> -     err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
>>>>> +     err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
>>>>>                                 first, gfp);
>>>>>       if (err < 0)
>>>>>               give_pages(rq, first);
>>>>> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
>>>>> *vdev)
>>>>>       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>>>>>           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>>>>>           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
>>>>> -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
>>>>> +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
>>>>>               vi->big_packets = true;
>>>>> +             vi->gso_is_supported = true;
>>>> Please do the same for virtnet_clear_guest_offloads(), and
>>>> correspondingly virtnet_restore_guest_offloads() as well. Not sure why
>>>> virtnet_clear_guest_offloads() or the caller doesn't unset 
>>>> big_packet on
>>>> successful return, seems like a bug to me.
>>> ACK. The two calls virtnet_set_guest_offloads and
>>> virtnet_set_guest_offloads is also called by virtnet_set_features. Do
>>> you think if I can do this in virtnet_set_guest_offloads?
>> I think that it should be fine, though you may want to deal with the XDP
>> path not to regress it.
>>
>> -Siwei
>>
>>>>
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>> +     }
>>>>>
>>>>>       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>>>>>               vi->mergeable_rx_bufs = true;
>>>>
>>

--------------qzVStYBRiJOLs31OZvug4027
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 8/9/2022 12:06 AM, Gavin Li wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 8/9/2022 7:56 AM, Si-Wei Liu
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com">External
        email: Use caution opening links or attachments <br>
        <br>
        <br>
        On 8/8/2022 12:31 AM, Gavin Li wrote: <br>
        <blockquote type="cite"> <br>
          On 8/6/2022 6:11 AM, Si-Wei Liu wrote: <br>
          <blockquote type="cite">External email: Use caution opening
            links or attachments <br>
            <br>
            <br>
            On 8/1/2022 9:45 PM, Gavin Li wrote: <br>
            <blockquote type="cite">Currently add_recvbuf_big()
              allocates MAX_SKB_FRAGS segments for big <br>
              packets even when GUEST_* offloads are not present on the
              device. <br>
              However, if GSO is not supported, <br>
            </blockquote>
            GUEST GSO (virtio term), or GRO HW (netdev core term) it
            should have <br>
            been be called. <br>
          </blockquote>
          ACK <br>
          <blockquote type="cite"> <br>
            <blockquote type="cite">&nbsp; it would be sufficient to allocate
              <br>
              segments to cover just up the MTU size and no further.
              Allocating the <br>
              maximum amount of segments results in a large waste of
              buffer space in <br>
              the queue, which limits the number of packets that can be
              buffered and <br>
              can result in reduced performance. <br>
              <br>
              Therefore, if GSO is not supported, <br>
            </blockquote>
            Ditto. <br>
          </blockquote>
          ACK <br>
          <blockquote type="cite"> <br>
            <blockquote type="cite">use the MTU to calculate the <br>
              optimal amount of segments required. <br>
              <br>
              Below is the iperf TCP test results over a Mellanox NIC,
              using vDPA for <br>
              1 VQ, queue size 1024, before and after the change, with
              the iperf <br>
              server running over the virtio-net interface. <br>
              <br>
              MTU(Bytes)/Bandwidth (Gbit/s) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Before&nbsp;&nbsp; After <br>
              &nbsp;&nbsp; 1500&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22.5&nbsp;&nbsp;&nbsp;&nbsp; 22.4 <br>
              &nbsp;&nbsp; 9000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.8&nbsp;&nbsp;&nbsp;&nbsp; 25.9 <br>
              <br>
              Signed-off-by: Gavin Li <a class="moz-txt-link-rfc2396E" href="mailto:gavinl@nvidia.com" moz-do-not-send="true">&lt;gavinl@nvidia.com&gt;</a>
              <br>
              Reviewed-by: Gavi Teitz <a class="moz-txt-link-rfc2396E" href="mailto:gavi@nvidia.com" moz-do-not-send="true">&lt;gavi@nvidia.com&gt;</a>
              <br>
              Reviewed-by: Parav Pandit <a class="moz-txt-link-rfc2396E" href="mailto:parav@nvidia.com" moz-do-not-send="true">&lt;parav@nvidia.com&gt;</a>
              <br>
              --- <br>
              &nbsp; drivers/net/virtio_net.c | 20 ++++++++++++++++---- <br>
              &nbsp; 1 file changed, 16 insertions(+), 4 deletions(-) <br>
              <br>
              diff --git a/drivers/net/virtio_net.c
              b/drivers/net/virtio_net.c <br>
              index ec8e1b3108c3..d36918c1809d 100644 <br>
              --- a/drivers/net/virtio_net.c <br>
              +++ b/drivers/net/virtio_net.c <br>
              @@ -222,6 +222,9 @@ struct virtnet_info { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* I like... big packets and I cannot lie! */ <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool big_packets; <br>
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; /* Indicates GSO support */ <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; bool gso_is_supported; <br>
              + <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Host will merge rx buffers for big packets (shake
              it! shake <br>
              it!) */ <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mergeable_rx_bufs; <br>
              <br>
              @@ -1312,14 +1315,21 @@ static int
              add_recvbuf_small(struct <br>
              virtnet_info *vi, struct receive_queue *rq, <br>
              &nbsp; static int add_recvbuf_big(struct virtnet_info *vi,
              struct <br>
              receive_queue *rq, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfp_t gfp) <br>
              &nbsp; { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; unsigned int sg_num = MAX_SKB_FRAGS; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *first, *list = NULL; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *p; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, err, offset; <br>
              <br>
              -&nbsp;&nbsp;&nbsp;&nbsp; sg_init_table(rq-&gt;sg, MAX_SKB_FRAGS + 2); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; if (!vi-&gt;gso_is_supported) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int mtu = vi-&gt;dev-&gt;mtu; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE
              + 1 : mtu <br>
              / PAGE_SIZE; <br>
            </blockquote>
            DIV_ROUND_UP() can be used? <br>
          </blockquote>
          ACK <br>
          <blockquote type="cite"> <br>
            Since this branch slightly adds up cost to the datapath, I
            wonder if <br>
            this sg_num can be saved and set only once (generally in
            virtnet_probe <br>
            time) in struct virtnet_info? <br>
          </blockquote>
          Not sure how to do it and align it with align with new mtu
          during <br>
          .ndo_change_mtu()---as you mentioned in the following mail.
          Any idea? <br>
          ndo_change_mtu might be in vendor specific code and
          unmanageable. In <br>
          my case, the mtu can only be changed in the xml of the guest
          vm. <br>
        </blockquote>
        Nope, for e.g. &quot;ip link dev eth0 set mtu 1500&quot; can be done from
        guest on a virtio-net device with 9000 MTU (as defined in guest
        xml). Basically <br>
        guest user can set MTU to any valid value lower than the
        original <br>
        HOST_MTU. In the vendor defined .ndo_change_mtu() op,
        dev_validate_mtu() <br>
        should have validated the MTU value before coming down to it.
        And I <br>
        suspect you might want to do virtnet_close() and virtnet_open()
        <br>
        before/after changing the buffer size on the fly (the
        netif_running() <br>
        case), implementing .ndo_change_mtu() will be needed anyway. <br>
      </blockquote>
      <span style="color: rgb(255, 255, 255); font-family:
        -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;,
        system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
        Emoji&quot;, &quot;Segoe UI Web&quot;, sans-serif; font-size:
        14px; font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(41, 41, 41); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">a guest VM driver changing mtu to
        smaller one is valid use case. However, current optimization
        suggested in the patch doesn't degrade any performance.
        Performing close() and open() sequence is good idea, that I
        would like to take up next after this patch as its going to be
        more than one patch to achieve it.</span></blockquote>
    Sure, it's fine to separate it out into another patch and optimize
    on top later on. Though the previous comment of avoiding repeatedly
    computing sg_num in datapath still holds: set sg_num only once in
    probe() time then, in which case the sg_num needed can be simply
    inferred from dev-&gt;max_mtu rather than dev-&gt;mtu.<br>
    <br>
    -Siwei<br>
    <br>
    <blockquote type="cite" cite="mid:465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com">
      <blockquote type="cite" cite="mid:c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com"> <br>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; sg_init_table(rq-&gt;sg, sg_num + 2); <br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* page in rq-&gt;sg[MAX_SKB_FRAGS + 1] is list tail
              */ <br>
            </blockquote>
            Comment doesn't match code. <br>
          </blockquote>
          ACK <br>
          <blockquote type="cite">
            <blockquote type="cite">-&nbsp;&nbsp;&nbsp;&nbsp; for (i = MAX_SKB_FRAGS + 1; i
              &gt; 1; --i) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; for (i = sg_num + 1; i &gt; 1; --i) { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first = get_a_page(rq, gfp); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!first) { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list) <br>
              @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct
              virtnet_info <br>
              *vi, struct receive_queue *rq, <br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* chain first in list head */ <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first-&gt;private = (unsigned long)list; <br>
              -&nbsp;&nbsp;&nbsp;&nbsp; err = virtqueue_add_inbuf(rq-&gt;vq, rq-&gt;sg,
              MAX_SKB_FRAGS + 2, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp; err = virtqueue_add_inbuf(rq-&gt;vq, rq-&gt;sg,
              sg_num + 2, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first, gfp); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; give_pages(rq, first); <br>
              @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct
              virtio_device <br>
              *vdev) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (virtio_has_feature(vdev,
              VIRTIO_NET_F_GUEST_TSO4) || <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio_has_feature(vdev,
              VIRTIO_NET_F_GUEST_TSO6) || <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN)
              || <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio_has_feature(vdev,
              VIRTIO_NET_F_GUEST_UFO)) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio_has_feature(vdev,
              VIRTIO_NET_F_GUEST_UFO)) { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi-&gt;big_packets = true; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi-&gt;gso_is_supported = true; <br>
            </blockquote>
            Please do the same for virtnet_clear_guest_offloads(), and <br>
            correspondingly virtnet_restore_guest_offloads() as well.
            Not sure why <br>
            virtnet_clear_guest_offloads() or the caller doesn't unset
            big_packet on <br>
            successful return, seems like a bug to me. <br>
          </blockquote>
          ACK. The two calls virtnet_set_guest_offloads and <br>
          virtnet_set_guest_offloads is also called by
          virtnet_set_features. Do <br>
          you think if I can do this in virtnet_set_guest_offloads? <br>
        </blockquote>
        I think that it should be fine, though you may want to deal with
        the XDP <br>
        path not to regress it. <br>
        <br>
        -Siwei <br>
        <br>
        <blockquote type="cite">
          <blockquote type="cite"> <br>
            <br>
            Thanks, <br>
            -Siwei <br>
            <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (virtio_has_feature(vdev,
              VIRTIO_NET_F_MRG_RXBUF)) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi-&gt;mergeable_rx_bufs = true; <br>
            </blockquote>
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------qzVStYBRiJOLs31OZvug4027--

--===============0575661623759937062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0575661623759937062==--
