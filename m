Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A863C6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 23:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBFFA60EE1;
	Tue,  4 Apr 2023 23:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBFFA60EE1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=FxJxZfsn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=tHQyyZ2S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E13ZQ83Vq2vD; Tue,  4 Apr 2023 23:15:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7609060D73;
	Tue,  4 Apr 2023 23:15:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7609060D73
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 481F9C0036;
	Tue,  4 Apr 2023 23:15:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A139C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 23:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DE8660D80
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 23:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DE8660D80
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YHd6tyc1BrjJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 23:15:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5389960D73
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5389960D73
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 23:15:07 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 334KosIL032011; Tue, 4 Apr 2023 23:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1rqfBZuIDjh+I4raxpsLuj7yGFTY0/b8ZhmkOF2+OwQ=;
 b=FxJxZfsnPnwgqQOIPrSbMpP7EDNt5ub4qCpLUkN3cnVtpoXQTfeIIJ9ApkmFhGWof+fd
 hi0keZv+lve+DUA2PTF7ZZEXMepBNxrC9THY6Ozuli888KKcSTXJhuanpPoB2iw0PWOl
 Tg/L/4AuTAtSkCDnmPkfhjn3mRT2T9Iu4qVOpUXJedIarvPUO5/3VQFo3Rs5PeN+PHc8
 eXwjOeCkC6vG0J6KObSgmVqqfF20w8f0zzvrHEJVKkFD/f/6XmOoK7E3NHfXXc3mgAsm
 uhTftwwGslsVSABpgZwphvrI2D86dDtBGRcUw3eZowxTmeqbjnzj/sdymwhwgYSyT1+h YA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbhby5cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Apr 2023 23:15:07 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 334LVSm8013491; Tue, 4 Apr 2023 23:15:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ppt3gjerv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Apr 2023 23:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNAdHn7QCGUwZmbPFBuItRyUEBUjzkouissNxo1L0Vry2SM9D0rk9LqecnWB/bCUOXTCC0xPiQsGLLnzI9jShpTiY7FL11iPgUCyjcnX9yUHzZig06/HbT15tM/DepvnDlemnBs4e4E3Xxhu1JWfPU4AnENA8RbS4azC9AvmqoRrAG2TWyo2ZPB/mc3uL5G7cSB17JK7JCGTo4pfuJa+WiJ0h4J2pApYhPAGj87C+dakK92mSNKW2uAPL76ZcNoK04AsVT/nLmD5WgG/X3IpA0PH9HyvReuNdbAPVX4S5vHUXFiC07MdudADW4VNylOjrYBTQ8BpCjtOcEf0x8YLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rqfBZuIDjh+I4raxpsLuj7yGFTY0/b8ZhmkOF2+OwQ=;
 b=OKKCg1vFesv2KAanqsmvBvP6zVsPkxHPEbZSy4iI0SLa847ze9oTVPZAf5CkGZRmA462UiGscAn1F1vZ9A29iukdWvKA1J0rgAceaNY4+EMaqGQgI8rxdJOGQ+Tv46p9t6rD6LHKcvz4e8+W5ggprtnSwKfL2VUi8Wr052dr8cbiPoE9fHE1twcH/U+OerZSpwqOqVvSthE5xgx7IJGdnIVNBhJZ3EgdBKaDPXtopiKBNbiegiejH2L8gvG8U13naLXoDIPO/f3FyHYCGCXr0zIM6sh4Xh7JydQDl0rEgicFLbuqzq+TPP3KLf0i25CuEBkGs3MmiuMeHJyAcJJ2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rqfBZuIDjh+I4raxpsLuj7yGFTY0/b8ZhmkOF2+OwQ=;
 b=tHQyyZ2SxY2a+fpD821Fjf+QWZ+P573E+jp8O/1hNH6gZyAjRXXZ+QECRjaCes4/v+FbcuAO48PSL5ceJKeeN+ctNU31cYdiXFL21neETLPvjZBQXDQzEJmE0gcQADeJ0KrTJxJj6X0NWXFuuQTf7OYCB6k81qjIFEqxVI6uV/Q=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Tue, 4 Apr 2023 23:15:04 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3%10]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 23:15:04 +0000
Message-ID: <8b10922c-201b-b5a7-4555-ccf8c71fd671@oracle.com>
Date: Tue, 4 Apr 2023 18:15:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 01/11] vhost: add vhost_worker pointer to
 vhost_virtqueue
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230404143713-mutt-send-email-mst@kernel.org>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230404143713-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: DM6PR06CA0080.namprd06.prod.outlook.com
 (2603:10b6:5:336::13) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bc8f18-366e-4f2a-a114-08db35626c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaovnGoqzdMNNBrBDTHwcCrdy/n4imkbxBIaDMWiKHljXvvBcNphh49GVpOnLxyaycT0bm+vJ7Jfcy1b+2E9Uadq+8NFlzlzo0ANVt2lxxFqSc8EutfDz5QXHxf6ZBflabqLwgCZTPuwmtQ/Dnzt/J+lL32yiaYLDNZzzDnjnRLVNz26a6/n+KRy5272FuEW0W081tXEN4LFFLtIenZq0K3YcpWRC0Kq7mjSbwXsSY+bMy8QRgLYYuYQR6GS/71eW9mK4KsOXYiaI5MoDlEIKdarPesqM+qTvtX8C/ptHNltKp3DHsMM/hwp7O7ik0+A1WP2DoE5x5AXE81xxz2ZHEs24xcIdD2eKHm3KucZvjS7O/+BY83OoiYm/+SaWFWdd9oGKpatoKXYX6Ai+eGKy6zAGUG10itTeTemArqEwogftxnF8n6EcGrtj+zgzIHz8pF935sotILpYPIuATvEi7ESXmjbXIhsR4q8cePdsNeSbtfsvbSY/N1dtVUyHIMuR50YY3OYUxpZuOmJiFMJvLJQbgeMkiVob4/JEWds5Lc6yOxAaW3M/fsf69LVywp2wENiL/E26CAnko75ReoDLIp6xI6JTx1YgO0fp8T+zdDGWaj1DfbwYY4+g/jFEv6KRfneoOxr3kYmdqQ+XzgPOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(31686004)(66476007)(4326008)(6486002)(6916009)(478600001)(66556008)(66946007)(316002)(41300700001)(31696002)(86362001)(26005)(8936002)(2616005)(36756003)(6506007)(2906002)(4744005)(5660300002)(53546011)(6512007)(186003)(8676002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUIzU3pLL2VKNFAzL3d3ZVo1Zm5SNk5RNEtTdUJTUG9oZlVRVkhKWkpxbW1C?=
 =?utf-8?B?eFFkUmZKcWQvWUtBenI5M2xpdllKZjI1MStPQWVzb0kzYmJ5d3ZycVdCb3VF?=
 =?utf-8?B?Qm14UTQ1K2g0ekNxeTJuY21OcmVqdVloK0hTa1BWMWNTU2hVVVQ1ZmlMRG5a?=
 =?utf-8?B?WEFXZTFueTZuYWpPRHl6R0xGVDFObkxXcmp4SkdiZWtGWmdLK3g0RU1wY2xR?=
 =?utf-8?B?aE55YkpOdFZCTW9xdndhbE8vbUdxWGl5RjFGN3pXNmkvZEd4ejJtWmlFZisr?=
 =?utf-8?B?b0FNV00xdlVObWVLbFdYQ29QYXdIbmQrY05GdHo1eGUvZ2JwKzI2anovUUVP?=
 =?utf-8?B?N0ViMkc2YXVyd1RnR01za0tVaEJySk1TNmdsSjBHL0p5MWQ0YzdjNU1aTXAx?=
 =?utf-8?B?QUZMWEhEWXBCK1RZdERFNWZsLzZZN1dRYUY4ZnR4dllsR1BSbFZrZlIySzdl?=
 =?utf-8?B?cXVHb09xb3ptWC9manhybThWVUJUb2V1WlJNWllxd2tmdEMwajQ4bGFlYkxO?=
 =?utf-8?B?WDFmL04relNiak5ndGRIT2k5YWlFTUhCVXFvUGFPTWxLNFUzOXdXVzVmSGFQ?=
 =?utf-8?B?RlplMHRWL2hieFJKOS9HaVFOZ1MzNWhsNFdHYVdxMnRKeFM5a21KNDI2bWU4?=
 =?utf-8?B?TWkwaDUvWjlYOVRzQXRkak9JVktrditNU2VhdE9QV3V4cU5DTlY4TkFPdGo2?=
 =?utf-8?B?dW1MV1ZNbHlKZGF5ZlZ3V1pjSVZ1L1JLTmJyaXRpN1l3dDVhd3k4WlhpeVFH?=
 =?utf-8?B?VDM5ZlpOTENhVElkcUhZUnJOY05lemdReEt6WGtDSklUL1RKQ3orMVpZTlJL?=
 =?utf-8?B?d0tubW1zbWN6eWpiUHBwL2VlV1BBMDYwaG5LOGZwdjdGL1BDYlMzRkh5c3lx?=
 =?utf-8?B?YnhZUDVzaFBWaXN3SGFLQUlZNlZzOXBodXB2S1p1UHZvMnNsUEJ2ZDVpV3pj?=
 =?utf-8?B?dVRVa29kb2htQkdRaFdhZmE5YnF6ZUNIcXlQT0ZtVEQvVDM5VEdZSWswV0hI?=
 =?utf-8?B?WWxvTE1YS0xDZFNTUEdCSDBDV0FIakd4MExQNDM5bkpQS3FHM1pMNi84cGZy?=
 =?utf-8?B?L2R5dzhmKy9BdEVUbWZGVGcvVmkva0hXNzNHQ254VDhrb1pIaWFRQXZPeDUr?=
 =?utf-8?B?TDUwRnJGSCtoNHhiL3VKeDN6dDRzNkRCb0JmRzA4UHJ6YWR5RnZzSkpkU1JI?=
 =?utf-8?B?Vy9BRWNubHZhOVg4Q3A4KzVjelhJaHpuTVErK1hlQk04VnJqbFlaT0RmMVU0?=
 =?utf-8?B?aEExZnRUc0MxSit4Y3R2L0RGMXgrTEd0NjE4S2lubGVxSC8wT2NJNEMrMTIz?=
 =?utf-8?B?cDNPbEc5dTZCV3VITG9kUThpQ20vOWxLQ2pucFU3R2FTZDBWcmI0anp6Lzcy?=
 =?utf-8?B?OXVJUU43Wi9OVWV4blZkZEtZOEpRUGtON0w4TFN3K3R2OHkyeiszNWhRUEUw?=
 =?utf-8?B?SWNmMDVkdk5UMUUzN040cXQ1akJtV2lzcjBKaTlXS00wd3lBWGFQc1lkd1cx?=
 =?utf-8?B?SGJGVkZSTW1KaHhURm1mZUdBWXNrT3V5VU1XT2UrRXB4bFJ1ZSs2V1U2c3hV?=
 =?utf-8?B?dGFWdk16Vko5S2hUQmw3dytZMlNFeFZNNVBWamxUM3pnckVkbFJlT3ZzZXkx?=
 =?utf-8?B?eHlSMTNqdnRrQWx5dFZkRjdnOTdBUlhWaXZ2RmhaVkVNand3bXBMTWI2YTBV?=
 =?utf-8?B?ZG4xdDhxaGlZSlE3dWNqRXB0bGk2ZDBNOTNYbVFuaUpIWStWR055U1J6d0V6?=
 =?utf-8?B?TDJqUStodTQxdy9lQ3Y3dDF1dTk0RnlsZ2w5NFlONk5yTlhOQndNRklrU0Zh?=
 =?utf-8?B?dDUrUE1GUlMzRzhiTWlOalNXbVdGN01tenRSTTkxZDNkRHZCdHpDNUtrNHNn?=
 =?utf-8?B?MC9WSDhUSlRJV1p6TmJpM3NlSHNRdUE3aklzZWFPWHRlZlBoV2MyRkJxOWdk?=
 =?utf-8?B?WnhhWGo4S3pjUlk3emZWWXNXTVVnVnBXMUhhWGNXeUpXSUhUbHY0SVBNTFVR?=
 =?utf-8?B?bC9pcGNZRXRMeFNSZWR6TkpWR1Jpci9IYitXcjNOOU9uNlgxVEV2cGRockd5?=
 =?utf-8?B?YTZWNFNxQXFXejN1ZHJ0VjRDZGFOeEh2RDRSNmZYRTFBMDFDTE95aTFickpt?=
 =?utf-8?B?SkFsVGJKQzM3S3dMZ0dneUJYamJ3dVkramR4bzdYaExGK2RNS1BDYzlxM0tY?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /QdLUqc0VdikcLCdJnICf/cZe2et83azfCWzsK9eiWuNeWjq4iyBuJe+H9Sj6TC20KaGGDcktyLfmtG74wb6zIVAbofJO1GsJmYkV+O+ybz1I+3dOEm+Q//bdImyTyeludqlqnYiiQA7kOCz/FVDm5Z6cz4wDU2lSWPqwvFHlU9pvVQYQU3MXJiY3bVfFchYcbtwiguNtyKlQVNFGZTVJmiKnf+mIVMsDzSNewV6AwtzufGntKHtLYJnd/7C4S17vSEfQVLiVIhlMk5QCYSb109IVi3Ya3xrzut49yyEE9ygJBDG18ECzX3BOl1h9794GgSeQBC7ip/0g98rZoXZQRhdEDUUShm78NjX7Ffcxe5kI8NdqFMQ3GdUlCtV+EJWvGcJPYUnijAxKn5+8HifrStclRNwkY9BWTdjV7bb8R3vbUl440vucLp+gQSMCE+IjcW+1/3MhstzOXyvLG8zX06RlNlPvETRH0duzpb1Ucvh9fURaUDIIBoflFS/aDq8Dn77UYngFfg9QAPK22rwKU+QYKg8B4qWIuh+KWW0V7hR6md4i7GjvP/KFb0md4R0G/3FFx1mfrrIfRuZkHR22LWg/q8hAxMMhALSwRjOnHeaBzDVjUlNCFMBI8EVEB86L0RQ/ViHxAGNvuxNXo3vGK6bLhNCUVHCEoq1vLFsp2x5/UJjD7++YhoO5wqj0CuOA+bc/NDjeu9FQ51oWY3gYm2H1/BJm3nOf/xyoHxMgz5/7X5Gu3R+PGsaV8jL/VSEetx0ExKIGpkoKnGnKmq4cfKhI7k4nD5p8AONJ7Rv7PpVsL7xtgJC5iwznC1o02mO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bc8f18-366e-4f2a-a114-08db35626c4e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 23:15:04.5046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZmkYQ6Ho0MKxlDOsh2y+rw83s3C1uZyOk0cjSL14bJ0K96r+lKZv5gtS77DYTYKryYYtNtuF0pKse0QVLHovFJEjnccTpiI3MIbWz53fEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040211
X-Proofpoint-GUID: XpPU-gPaZ5q5cFcAWPU-tw-xQ1uurL0b
X-Proofpoint-ORIG-GUID: XpPU-gPaZ5q5cFcAWPU-tw-xQ1uurL0b
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On 4/4/23 1:38 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 27, 2023 at 09:17:07PM -0500, Mike Christie wrote:
>> This patchset allows userspace to map vqs to different workers. This
>> patch adds a worker pointer to the vq so we can store that info.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Thanks! Conflicts with a bunch of refactorings upstream:
> could you rebase this on my tree and repost?

I will.

> I need to queue this soon so it gets time in -next.
Are you shooting for 6.4?

I think it's ok to do this for 6.5. We are already at rc5 and to
handle Jason's issue I will need to do redo testing and that will
take me some time.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
