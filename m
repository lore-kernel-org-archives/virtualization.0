Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A752C001B0
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 02:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1330C80BA3;
	Thu, 20 Jul 2023 02:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1330C80BA3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YfIZyF7E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QAoO6p1Tdq9V; Thu, 20 Jul 2023 02:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7D2E681F59;
	Thu, 20 Jul 2023 02:46:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D2E681F59
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53533C0072;
	Thu, 20 Jul 2023 02:46:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D9CFC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61263404AB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:46:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61263404AB
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=YfIZyF7E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z2JjAm4z9dcg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:46:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F337F400D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:46:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F337F400D2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwEMoaudJenTJ5UVsJHjJGof6bxdjpEOGQbzCO8nMAFIOxQOeYSimKykaYkulqQ7dLI1xSxuP3B7frJqt+HNFQUFZK9jOScPLHqOLY8xAyvA8StM6c1XKewrsUA3tu9CozDh7JfQW1Et4vN5D+j/JPc5+S3EFCy5DODWHQOIXDf1x+tlwDW4o6r+JpFaecDTFkHyvsB2HLdr2GqMORvrvScglM0kzCimEOPPsbxyt0mC/VFyKiAp3xqTvo/GzjDueLqrAaYu0AXNrcAEJvfqlgs2zliTlF9ByWsvHLigSa+HcO+s7aUS3m7/s5R+X+VBLq9hSLtv6WDvSh3ewWEyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeW3HFiQYHUy84qtunjfI/wpCmNeHvxvLYOnZRY22jM=;
 b=N+IJLmxCwJs+M3TxHXSx/T5FEhqnlNdi4pcEj9AzkfVE1THNcIj+jU6h5vPUMPbmvLR1xY/MPsfa9FbEf1TbYRpF7DrBR4MNJWE8iEV53+PvHOS9cz8i33l4FzgsVsATw/B7esJP+ug9wX6/GK4JVcx7lbwmF5lvDbUxY0zkNH2TGqYx9EHLf3PDtpD2SpFGxLq6kTZHk+02So2vN9gnqQqBXx9ExbD+2AkbG3c1Ms+VlYXSjt/nHBNaUlEO9jL4L9XeDfS2a7vQpkRGqppdoi/yyL2QgBaTbUk7uDZmYEqxrDCvERGMhk+Yz4h7mlnaBCaRO2Y1QtweC3WgSV/lWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeW3HFiQYHUy84qtunjfI/wpCmNeHvxvLYOnZRY22jM=;
 b=YfIZyF7EwisnUhtS9thBI2/nZrbldGwwhp1Mv9K3xVtebsxwaZ3u94mi2CO1XaPGfCZ12jKkh9VpC+s/WA65jZbn4TF6NsVw9Yyj63Bp45qRd8Kdb9ZtNQx481zVZY/hw1E6+mvwGKRogu+VgnqnJUjhT9e7eq/d7aWE5xiHpt4lSGW8QT2FanQXkr9f5+cD7jw7cabFHSehaqfoTb1hvLNxnvyQrvtqKGao1pKxdwQ/HVPHgXlvur1crnxCBbdl45q6n2J5eKdri2+DatZsEPBMm6HAYt7rHDoSr7nD+UUrlZ5SXLh2KjPW5L/FoLw51hF/JiU6Hlqx/gX196klTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 02:46:21 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 02:46:21 +0000
Message-ID: <056393df-2ce5-f636-4d84-50b2c64b10d5@nvidia.com>
Date: Wed, 19 Jul 2023 22:46:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To: Jason Wang <jasowang@redhat.com>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
In-Reply-To: <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
X-ClientProxiedBy: SA9PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:806:23::33) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f22c74-56b5-45ba-2d11-08db88cb7fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BNBa6g+Ji1G12YcvWp7l5DNr/TQ6MnMLNF1sO4wUf3qTaMqE4RESj2xcA24AOvw2YcfhksQKW+mPPHaQspwqzFp1knT89ikCW2/2ZMkscfO5q17mKbsUzQRKbKM8d052pnXhgp321jB6ljx038ldM2v8xkCma2Mic1cqNvyPGc9B/VyEMAQ/O7fpUF8mcEbQEiuGLAPUms9FK/PDbYSBRoKemDcUZ9o7J+OUVaNqCeGH8764tBalyVKVW5XDg/uU1yEfHDRCPFDqueP7e5qEkMkDQYwPDt6WtzuKGmRmknLYVeHIhCtM0pcpvNXLEfKBg6TyrZKnlMZv45hjULEeF1pmr5n8niKNSeBXa0tMeXvbooLzYaVsWXn3bA91BsEC8g7ZEw16FfjewcZxVOCKyKCZvxbjLA3JTTXJokp3Le8Cmga3fcq6HQFlTyct9ssg684ibID46A7/kDTLiFDEaC7MLYWUP7QoK0zzc7WEKPg3IM+I/yqQQ8UEsiEePDqsL/S4SlCFIA9zNmvwQ9C1BOHD4mhJWiHoymdwRD4oruyzot8FikaDtXwaT4wGtE88FMRTUTT/OmLRhyqdGs/I+tb+JRYOjHwXhm+JdJe8kKQkzRJgL2wLIpccdmz9jIkBYx0+FR4Aefbpyi0pkkBKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(66556008)(54906003)(478600001)(6666004)(6486002)(107886003)(36756003)(186003)(316002)(6512007)(2616005)(2906002)(6506007)(5660300002)(38100700002)(66946007)(8936002)(66476007)(4326008)(41300700001)(8676002)(6916009)(26005)(31696002)(83380400001)(86362001)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdxRzRpcWZhMnllTkFQZEh2ejQ3MU91OWpEb1E0NG9sVDRuQnNVK0lseXBt?=
 =?utf-8?B?bTM0WCtQeGxNQ0V3ZmNmNWY5MGgxUWJRQS9BM0FCdEU3VEUvaDYvSUxXaE1y?=
 =?utf-8?B?azNHTU1xK0lzTFVHUVhLR2kvMlRCdHNlRUlCYWFIa09vMW1OQVV3SHZmclVH?=
 =?utf-8?B?bHI5SVJ6UGNybUhBazF1R0FRV2orTnpDc0NtUS85VldhbHlzNDQyVEtNSVZh?=
 =?utf-8?B?UWI1VmdnQWl2U0JzYUVsN2lCQ2wwcWhITXB6T0VNSUZqZ3RaOUNCZkx4MmNx?=
 =?utf-8?B?SU4vdlA2RnQvK3ErT0Njbk1RT1FmQzRJZ3hyVTY4VG40WGVnMUxQWG5SYWFN?=
 =?utf-8?B?OS94QWkwTGQ3RXBXSFRxQk9JcEhmYkJBc2hCb3kzclNwQ3EzQTBOZDVFQVV3?=
 =?utf-8?B?akV3S0ZrWU1LMTRFbjZNblg2cVlDVnNyZ2U5WGN5cHFqYXlucVE2T0VFc2pV?=
 =?utf-8?B?OFBRWkhuOC9OR0dFRHlDcmFEUUVKQWsrUjBkT2dEbnBLRW81MFpCRnRiRUx5?=
 =?utf-8?B?Ym1hbHhCakVadThEYkVXNmdoV2k4OGx5ODFxRmg2clQwa096b29FNGVjNlh3?=
 =?utf-8?B?OCtoRStEbFYwVCtqRVJTNDd6dU0vRHpuZlZaaG93dUxPVFl4dzRDTUJwazYw?=
 =?utf-8?B?bnk1TldySEdxNzh1dmRnWkRLUnpMN291MHdrN2VUOGw3QkJ1Z3Z3aVllaTFs?=
 =?utf-8?B?UFozNTJsZlRYcTZMS0pxRWZkVWVldVkyb1o0M2NYM0FrVERBTGhIaElLTTll?=
 =?utf-8?B?c2FHcG5aN3VFaXp4UVhORnJYN3hmUDZRQ0x6TkZHdDllNnBERllnMDBKTzBL?=
 =?utf-8?B?OUM3ckt1aG9MeGpGV0JlVlNLV2VLUGZEbDYxeVR0bTg2MStYTHB2c3Y4NE5U?=
 =?utf-8?B?QTI4RThDOGhOUHZRK1VGK1oweXV1Um0wekY2VlYxYUwxbGZYdE16VFpPTUFq?=
 =?utf-8?B?aHFSVzlHMTVNMENlV0RhOXpyWFlFeXZCRTJuU0NWNVMrWmplU0oxY2Z3SDBk?=
 =?utf-8?B?Zm9LTm5HdlVUTnFlS1U3ZjFNQnhBUDRkMjM5Sys1b0E0SUR1UHZTcTh2YXNJ?=
 =?utf-8?B?aTJtN3pLV1pwT3ZIVGJ0ZzhzSEYrWEtIV0hjc250SEl4Q3RZVTI3WUx6d3J2?=
 =?utf-8?B?ZDdwNEo4b01zMi9uY2cwbU9uQjFxcTNjQnFsMzVBaEN5azd0algyMVpmdWRQ?=
 =?utf-8?B?SWgxUmlITXNXOTYzS20rRkh3VEVTY2g2UERRekM0NWd2N0hJRVg5OWZMdzVP?=
 =?utf-8?B?RzZsMnZOR1N1cmh4b2J2SVJiekIzRFRzMU0vRjBiRmc4TzRYak16SldQK1Rm?=
 =?utf-8?B?VkxDYjRKNXRSRWRPZWc1K2dzRDdMRXhoa3V3TmdyUDViNys1OW5yY0xkSEc1?=
 =?utf-8?B?ODBFb2taK2VodmRzWkpEc1h4NjV4UzNRSnRJMFVXcWk2eW9TeVJKZ2RxMDNP?=
 =?utf-8?B?VkZqemNRYW0yQXZIVUN2OEN4aHBaaGNYamZuV2d3Y0tZRE5pMTNnZG0yMm5T?=
 =?utf-8?B?RVI0eW4wR3BFdXpmSzdXSE5kTG9WaGxaeldPK05JYmlZNEVZTUdZSEhHVC9F?=
 =?utf-8?B?eXQwU1JzaTVIS016a1BPRSttcU4vbE83QzlOZ2hBdGlRN0ZDcVpleDl5SHQx?=
 =?utf-8?B?NSszNzczN2JXaXE4dG1IaWEzZ0ZZQjEwQUxKVTMzUDl5Yk1SMnI2cXBsT0xo?=
 =?utf-8?B?SEwvTktBaU12Q21LVE5hTG4vWG05OHFaa2xndnlLYjNkNEVvWCtGZjRQM1U3?=
 =?utf-8?B?Y2ozNzR4anh2UnJVWnRqRnhBNC9pdDZQZmNabFpyV1U0QkZ2Y0pUZk44UE5Y?=
 =?utf-8?B?cXVSZExFS3JkYiswUE9kbFJmNi9pU0s2ajNuRERpZTNlVjE5bVl2eXl6eHFR?=
 =?utf-8?B?OHU1Q1AzQlBQZlg4SG56YzV2YkJYYzFHTWxWK09Yd1pXM1F5KzE0RS9Ma3o2?=
 =?utf-8?B?TXVEKzJvT1V0RXUwSERCdFB4UldRZm5ralEwZVUzeW9McUJ1dkN3TGxIOHNB?=
 =?utf-8?B?dGJqN0dRRUc3KzJ0dzY4aDlreTVYOXIvZklLZCt2Q2pBajRJOVI5VFhvaVZZ?=
 =?utf-8?B?OVRSclZtSjlhWDY4Mk1hRldFeUZDSHZ1cEZCaU1KdWtXMGhtbjAwanpGTHdn?=
 =?utf-8?Q?IvZSbq9Xvxj6MKC1kxQ6JL/u/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f22c74-56b5-45ba-2d11-08db88cb7fc4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 02:46:20.7749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ybdd9m0C0cbs+CvM++zX+S8Y555gsz+ODQ1pFbNOD2IF2I08aDxmplWzrw6f/xQObWzk+Ku9ukyvhxduPPCYzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>
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

CgpPbiAyMDIzLTA3LTE5IHAubS4xMDoyNywgSmFzb24gV2FuZyB3cm90ZToKPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+IAo+IAo+IE9u
IFdlZCwgSnVsIDE5LCAyMDIzIGF0IDExOjQ24oCvUE0gRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5j
b20+IHdyb3RlOgo+Pgo+PiBUaGUgJ2lzX2xlZ2FjeScgZmxhZyBpcyB1c2VkIHRvIGRpZmZlcmVu
dGlhdGUgYmV0d2VlbiBsZWdhY3kgdnMgbW9kZXJuCj4+IGRldmljZS4gQ3VycmVudGx5LCBpdCBp
cyBiYXNlZCBvbiB0aGUgdmFsdWUgb2YgdnBfZGV2LT5sZGV2LmlvYWRkci4KPj4gSG93ZXZlciwg
ZHVlIHRvIHRoZSBzaGFyZWQgbWVtb3J5IG9mIHRoZSB1bmlvbiBiZXR3ZWVuIHN0cnVjdAo+PiB2
aXJ0aW9fcGNpX2xlZ2FjeV9kZXZpY2UgYW5kIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZp
Y2UsIHdoZW4KPj4gdmlydGlvX3BjaV9tb2Rlcm5fcHJvYmUgbW9kaWZpZXMgdGhlIGNvbnRlbnQg
b2Ygc3RydWN0Cj4+IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSwgaXQgYWZmZWN0cyB0aGUgY29u
dGVudCBvZiBzdHJ1Y3QKPj4gdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNlLCBhbmQgbGRldi5pb2Fk
ZHIgaXMgbm8gbG9uZ2VyIHplcm8sIGNhdXNpbmcKPj4gdGhlICdpc19sZWdhY3knIGZsYWcgdG8g
YmUgc2V0IGFzIHRydWUuIFRvIHJlc29sdmUgaXNzdWUsIHdoZW4gbGVnYWN5Cj4+IGRldmljZSBp
cyBwcm9iZWQsIG1hcmsgJ2lzX2xlZ2FjeScgYXMgdHJ1ZSwgd2hlbiBtb2Rlcm4gZGV2aWNlIGlz
Cj4+IHByb2JlZCwga2VlcCAnaXNfbGVnYWN5JyBhcyBmYWxzZS4KPj4KPj4gRml4ZXM6IDRmMGZj
MjI1MzRlMyAoInZpcnRpb19wY2k6IE9wdGltaXplIHZpcnRpb19wY2lfZGV2aWNlIHN0cnVjdHVy
ZSBzaXplIikKPj4gU2lnbmVkLW9mZi1ieTogRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+Cj4+
IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4+IFJldmlld2Vk
LWJ5OiBKaXJpIFBpcmtvIDxqaXJpQG52aWRpYS5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCAyIC0tCj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9sZWdhY3kuYyB8IDEgKwo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2NvbW1vbi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+PiBpbmRl
eCBhNmM4NmY5MTZkYmQuLmMyNTI0YTcyMDdjZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9jb21tb24uYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X2NvbW1vbi5jCj4+IEBAIC01NTcsOCArNTU3LDYgQEAgc3RhdGljIGludCB2aXJ0aW9fcGNpX3By
b2JlKHN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2LAo+Pgo+PiAgICAgICAgICBwY2lfc2V0X21hc3Rl
cihwY2lfZGV2KTsKPj4KPj4gLSAgICAgICB2cF9kZXYtPmlzX2xlZ2FjeSA9IHZwX2Rldi0+bGRl
di5pb2FkZHIgPyB0cnVlIDogZmFsc2U7Cj4+IC0KPj4gICAgICAgICAgcmMgPSByZWdpc3Rlcl92
aXJ0aW9fZGV2aWNlKCZ2cF9kZXYtPnZkZXYpOwo+PiAgICAgICAgICByZWdfZGV2ID0gdnBfZGV2
Owo+PiAgICAgICAgICBpZiAocmMpCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2xlZ2FjeS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+PiBp
bmRleCAyMjU3ZjFiM2Q4YWUuLmQ5Y2JiMDJiMzVhMSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2xlZ2FjeS5jCj4+IEBAIC0yMjMsNiArMjIzLDcgQEAgaW50IHZpcnRpb19wY2lfbGVnYWN5
X3Byb2JlKHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2KQo+PiAgICAgICAgICB2cF9k
ZXYtPmNvbmZpZ192ZWN0b3IgPSB2cF9jb25maWdfdmVjdG9yOwo+PiAgICAgICAgICB2cF9kZXYt
PnNldHVwX3ZxID0gc2V0dXBfdnE7Cj4+ICAgICAgICAgIHZwX2Rldi0+ZGVsX3ZxID0gZGVsX3Zx
Owo+PiArICAgICAgIHZwX2Rldi0+aXNfbGVnYWN5ID0gdHJ1ZTsKPiAKPiBUaGlzIHNlZW1zIGJy
ZWFrIGZvcmNlX2xlZ2FjeSBmb3IgbW9kZXJuIGRldmljZToKPiAKPiAgICAgICAgICBpZiAoZm9y
Y2VfbGVnYWN5KSB7Cj4gICAgICAgICAgICAgICAgICByYyA9IHZpcnRpb19wY2lfbGVnYWN5X3By
b2JlKHZwX2Rldik7Cj4gICAgICAgICAgICAgICAgICAvKiBBbHNvIHRyeSBtb2Rlcm4gbW9kZSBp
ZiB3ZSBjYW4ndCBtYXAgQkFSMCAobm8gSU8gc3BhY2UpLiAqLwo+ICAgICAgICAgICAgICAgICAg
aWYgKHJjID09IC1FTk9ERVYgfHwgcmMgPT0gLUVOT01FTSkKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmMgPSB2aXJ0aW9fcGNpX21vZGVybl9wcm9iZSh2cF9kZXYpOwo+IAo+IFRoYW5rcwo+
IApXaWxsIGRvLCB0aGFua3MKCj4+Cj4+ICAgICAgICAgIHJldHVybiAwOwo+PiAgIH0KPj4gLS0K
Pj4gMi4zNy4xIChBcHBsZSBHaXQtMTM3LjEpCj4+Cj4gCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
