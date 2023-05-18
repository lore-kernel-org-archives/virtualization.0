Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B852EC77B7A
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 00:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5218E4273F;
	Thu, 18 May 2023 00:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5218E4273F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Vn10kXUg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=RUKZB14Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id So7mzp95CWMH; Thu, 18 May 2023 00:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8BAA84271D;
	Thu, 18 May 2023 00:09:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BAA84271D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C845C0036;
	Thu, 18 May 2023 00:09:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F903C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50F94427BA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:09:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50F94427BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uFlo3OVUCm6o
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:09:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B6304272D
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B6304272D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:09:44 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HIGlXJ018104; Thu, 18 May 2023 00:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Ct7b/zq/HcUTjPHa77MRmGjGVuU3b+ksAdBoBa1F72s=;
 b=Vn10kXUgNo4WS5Oa5ZNcb2Bs+rHEjKBrNUYqH2RKeo2ArXECdCKG4rZwtkDC/on+lMoU
 jsVYJ2VFlkj0DQlov4e26VvOGQ4idqfzrIUVH7QnLW6ygM0H+0xpNqXXXdHqA46ssL6O
 b6og3YsAsdE+6AvA9rHPUbAzjSheIMJogDzrVtvgmz2k5/oZ2FgiTSn1VN+ZhuWXvOFT
 BCLYeQediqJrw7Tw+trgkStSnKeBkxA6qNDIKaLsU+PFnE6NWs9Ltsq7lE9XYEEwFU/8
 0AJT0yu3xIh0/ezSgIcuDOTT7fTPqQmNvQUilyQ7oVZfF3pBYIiM655yl+gpxrcS5qxN nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye6r3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 May 2023 00:09:35 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HMnEP8004157; Thu, 18 May 2023 00:09:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10cd36w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 May 2023 00:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idPUmXpQ+mnTsMQoBwMnIW8/Q6H/i9y9yDWAtYTVH8Qmp09vzWHg9eY24rCXmocAvs4pASj8k51v4ZOXgdrrRlefmu3O+PrOR395AeOm6rdFb9HTz9JstPA/1G0QN+8p7jkyrFEn80VZfn5Hx94pRugpEH5YKe9p2knLMDmPh0xsYkZP92MsUD+Ws4C8HRUNetsd9AH+zGEIqzlwCQJxqdUPB2bthLO/l7rfDlSo4GfS/7m6C08VW6tWAhdyXN3MqtIdxvRz2f2AMZIStV58XpMqW6BJxq52V/4Lt4jLW/imNuo5fByEoW4Bfavv0i8zCUIGzrzgJmrLiVjhKPuB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct7b/zq/HcUTjPHa77MRmGjGVuU3b+ksAdBoBa1F72s=;
 b=dCo60hjfiLTV3cbH+oEFtJ1+1eXuOjDmOTfe7Pd2kLmsyIgWgI6BHMSwt55U/rXoA7DzCqpI9BNjWfHul8yLBZlcuACRQyrP6fTqpMzkHNPwE/SPaI5Aon1Up9Vk0Ck2w3ul/Zt5rEKxoYTb0YmSecsC7Kn06eA/v5qlxpdvVyp+s+lxtH3BwRHW293tFaquvxzJZUbzp5n45XYGFcV3TH0EVoAhCLuVviypX5rznAWX7gNpMpzWB6M0U+OqXHRQ/baPQll6loVc4ajBfoATLq91xShXaueJ2uzHAYz663imTdV/AN06ifXy5UIVsNiste0qutpMWP8K3Nbuh3Q5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct7b/zq/HcUTjPHa77MRmGjGVuU3b+ksAdBoBa1F72s=;
 b=RUKZB14Qri5p1/9vPQEQzpRAe08p9RYUQ/GwTEmtYdFP+a+bFpA2D2An1JOVy0IVBPblWpO3OPLvqP8X9P2GWSKtrGfFwhclKqRWVsnZflC+ula0deTibL1BUraILkBMJnLQHXxhpNq0s7Ojy+RJLKq/lKdXw6cvmSkvX25AnIE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:09:32 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:09:32 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
 axboe@kernel.dk, ebiederm@xmission.com, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 brauner@kernel.org
Subject: [RFC PATCH 6/8] vhost-scsi: Add callback to stop and wait on works
Date: Wed, 17 May 2023 19:09:18 -0500
Message-Id: <20230518000920.191583-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518000920.191583-1-michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR14CA0044.namprd14.prod.outlook.com
 (2603:10b6:5:18f::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d04b67-7ec3-4ec6-4f45-08db57342828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNG+XSdzpRdh327VVkAfpZjMkDDy6Ku//BALM78mLZkKaaibBskcRlMNFxfg3GBlgfNpPi5YjRt6sL24Gym17ChaCRbCXMkGGHbdx2AWBMeGvOt4+zP2fQMoAdIYX8V05WhWFZCs9oDoMY25Wq/otM496yd4D1yLUg+HEQjmmOajjn6qWFj9wyDW61Bo9gmwENC8iUHrYt8Ts2LnlQ/firM0FwLSGDjsPPSPJ/WXmdM9bv3aZLUL5tAMv3FcaBV213sIK0NFyAIh5/pPKALGnJ+e9Ge4EvnNoWh46lJqdmWS54GbL1pDA7deVCEaRa5Cycck0d05NM/L+gBrJZI1zcDeIpl0ABq6TbpZqLP/DXeGnw/hCSWOgibxnY9b0jIJjqYPvfzTWhOVzUPpmx6LTWx618tCTBwGniTkE04yQP6ZXnDbnfPcNN/ZqO7XuhSb59+wLiKxtjOs6s4GLCYKE+t0CW3LXI4Je4ekHmf0QYtHDhGGRLwLtdI19Km7iaBl3AOMCyEAqkk2CZ8wF9RVkbvXf0yQi1+8UZm+/IkDIzqHFT1nb9HgPpozSD0HfbBKuXOtImPM3k0r5IorSr08f3i6YELyG4GYbwPT6ckE1sM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(921005)(8936002)(7416002)(38100700002)(5660300002)(86362001)(6512007)(26005)(1076003)(6506007)(186003)(6486002)(6666004)(107886003)(36756003)(316002)(2616005)(83380400001)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AjXJJwR5YSn7llLK5OpnqBJ9nuuVQN9XJbqMSJeFMRfMsdMKXl3c4CMcMZom?=
 =?us-ascii?Q?McHMXw9Q/KuI7HYtwjVtwhbAz7IlrRkKJd092JoH+IDJJyKJVIYHgBP/vLeX?=
 =?us-ascii?Q?pG6wdoD+x4CNysFkiADQ/ANCk3sKgxmuMnW1uuQVreK76034KygHigyPSZ92?=
 =?us-ascii?Q?vmdIurWx0YAYxMRPVfADgotnhSYdQ9+BQT2SGNPdH/AZy9fmJ8SJCyGa/5lM?=
 =?us-ascii?Q?ALLRF8f+ooxubATCdHImUuYmRNsZbCaFMM9WaOysOLQcM744UBAQblcZ1A+P?=
 =?us-ascii?Q?SaW8wF5PryLrIybGOxoyGLuP5oKm+/rdEIdRFFTyng/iVXltp89TGaV+ojeo?=
 =?us-ascii?Q?RBs3hYYezaD2OGk7vNgwFmgfg7N3vo8qokNEAdvdl5gCYmehUtoCcnrDd9SZ?=
 =?us-ascii?Q?bvPanTqiKT32LaTK87RaUDtGuQ5ZohfJjMVqFkToQ9LuqP6hqzzhC/DFftay?=
 =?us-ascii?Q?jnP6S0z4VaSrXqDH9wwNa0Yq+OnwppJ/5pO22Yw9X0uD9dbVHvfaWGEUPFnp?=
 =?us-ascii?Q?7Nvzog/VIbktnq+vQD8KSxuvIy7SV4kTKXpPPGvcngWv8DE5l7VhDrn2nPeT?=
 =?us-ascii?Q?GjiAaWpUrrnZRM1h63SF1Z2XAfa90FjEKvqK/288UqbZeXNUjDCXELwAtJe7?=
 =?us-ascii?Q?krv82619kIgoKz2XvSkiLuzhF68/ScjPo5qH9qAZuFJTcvmCK0Dqmul0uv5c?=
 =?us-ascii?Q?+nNYcJ4tLFSYmATYkzP4BoY4n0Ag5nkSCyOcwU1knv9vHhfw3YIisE918CVz?=
 =?us-ascii?Q?VVYswZ1JaKN3ogDOdkiiFLrqAcB6ZcZtXBxd9RrfKAPBKy9jEkZUfvkw/Oh1?=
 =?us-ascii?Q?t1TzZCG7eLdC+Xu090yAb6WWug2rJeN+de/UqwWELF2NSLLsoXoubw9kM70E?=
 =?us-ascii?Q?IasdV7woPkE3k8r69WtAuTca72euQEp79LjvHEuNJMXxtlHWfe3280kGcezy?=
 =?us-ascii?Q?QO+qYyn2I3sbWsJizWQpyHYU1Pf0cYW3lecBUR5Irb+kte8t/rUjiQ7hn/pe?=
 =?us-ascii?Q?j4sLCQQotaI21Enqe66BjsKqdv9jO1pfTdXW67+M2abZS8ZT/0BViD9f138I?=
 =?us-ascii?Q?JN1sUuMtI9PHDMRdMm/md4SGwTdah+3TjavCAD0gvoYG54CLM25que7thNdL?=
 =?us-ascii?Q?v20Hx9pClzA/JulOxvW6sVIjcfiEEV3ZVgzSKTNRdOFV/lik0mnRQG5q4au1?=
 =?us-ascii?Q?9yssJdxtzrDTp7TLqFXbPkv+OvnLgllUG+LAR+cok8br2LraL6diLzEVuuxR?=
 =?us-ascii?Q?dL+uzXLMJcV1jW6atgxvNDHXpC/tKOZxfbk7k6wFMJDxLC+/7ankWHCc7cAN?=
 =?us-ascii?Q?GunTdonjTzGOHyoMF/WM+Som63fPguM5O3eJHnWZjngMJTL5ehVc954gCVTL?=
 =?us-ascii?Q?K7OznUXw09IQPwhdtvLQGrdgdU27siNA17tkTWjlDEAWS5wip4atoKmC8HQ5?=
 =?us-ascii?Q?Dkyg4ZnmpWUjMXljjZIDh33xMPG2RG0zkz3/sRlbFhwh2P10ZgDbUJ7/nAdT?=
 =?us-ascii?Q?caplGj+LwqaEmJ/vMiEa5/6G9331JddttiN9u3h4VU/1f8jbiadl/uvW2UH0?=
 =?us-ascii?Q?t/ijppTMH7z9DvmaFxmoB9+B1COXWE7NZKMHevD3RfRStHRUNlVn/2h8mthZ?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AthHwYTvZOGLwHXFOrti1sAzlNNLr0fjzH9FOu+Bf16K52z4boP+BSo7Zl5Q?=
 =?us-ascii?Q?aflZKBHnZbTIq3fLyFU9uuhUDZyZaO/jAaan24wU9DBjDGvoECw2rd+e5ThB?=
 =?us-ascii?Q?kn7TM05FE87YbZ8gspM3quEdJEyO/LJGuMCwOc9UosdGXwAX03fFSoOhFhC0?=
 =?us-ascii?Q?dIsUP79Zm1OcKAUD1xySfiWyVrWGL+VfJvQZrj72P0Fc9IB3xqadNVAe647V?=
 =?us-ascii?Q?v7/amh8ro2AvuvAo3eron2utoiB+2lvW3hv77Wl1hLbYxQCohEOfa/Xyrktw?=
 =?us-ascii?Q?T7euD7epMdpyrYPj2qX85epFd5JAiBvUUaVMjOhtSagF2WOKttPvZO0ixSWO?=
 =?us-ascii?Q?btzOaGTpcVBCZ4O1WYRv5oW6wGAHt+fJijjAIv3eYd5KQl3jjVF8Ihdg1hV3?=
 =?us-ascii?Q?K00z+g9A8ZRZFQEFw/sbXtqWvuSWEEknvmuOnn4L2zZSbuCIToF96rnMep5g?=
 =?us-ascii?Q?5ltKvsp9QE7YDnyDwsj6oj3y/GRzpbVGuP86LZCb0W/D35o4RwsUmXXDl64d?=
 =?us-ascii?Q?gToXSLmZeH5MaWy2Kf9hvVG71s28HDFsPsjHb2+mH+CSivr5aqeCZknt6LDN?=
 =?us-ascii?Q?ISB28PpCbj4djDUVrNJIEUUyw352tKoAiZVm/eJq6VXwExFkjfyWWUEYQ7fn?=
 =?us-ascii?Q?nveHcw8xDr2cAhfRwOM0gheHkUfJJ+3YvnUEW1uHMzuXPMzunLtswbD8Qp7j?=
 =?us-ascii?Q?voUzrTNKFyRjLXjVSSNQvlwzJvHNr6lLjyXsLYLBYDUq0sGwahhaKlm1dX4T?=
 =?us-ascii?Q?hqJVJMoH7Oj+Pm/7I4mHUnCkORH8OMZpV5G4mcT9KnInHKAoCsMHSER4pzVR?=
 =?us-ascii?Q?8PR9aVB9TBGBpTGdKWl5BrG9V06nqB/tAq5s0sELtk4O0y1apAYqghZUHLQa?=
 =?us-ascii?Q?MpkyWropvjmcAe8pFbzWku8s1q6TmlCPgjoJ4BbC5wPkE/f/m5R0UdUbHcjZ?=
 =?us-ascii?Q?R5YOm3INr70KhciA2RUK0cVJz97uBCR4tZgmAzl44nviqk4dql5hj1gK9CSt?=
 =?us-ascii?Q?vDbfrIWqXYNHSn2GpVmWgpbb27DaF7yTWY7sHPkiSj4/gRCHiedgOmiuXqMc?=
 =?us-ascii?Q?tdI2FcFu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d04b67-7ec3-4ec6-4f45-08db57342828
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:09:32.7938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeJZLo96B2MosE28lJ2cnaThbdhNjK0mK+KH/XVkc5TXjn6/j/aA1YQTjpns5CCrfiaUC1V1fOf2V4fsCAWRb7feuCvp+1WqNP/QC6+7Ics=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170199
X-Proofpoint-ORIG-GUID: vJG_C5nVu5fsW-Yt6h405gqaWtBrznDP
X-Proofpoint-GUID: vJG_C5nVu5fsW-Yt6h405gqaWtBrznDP
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

This moves the scsi code we use to stop new works from being queued
and wait on running works to a helper which is used by the vhost layer
when the vhost_task is being killed by a SIGKILL.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 40f9135e1a62..a0f2588270f2 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1768,6 +1768,19 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 	return 0;
 }
 
+static void vhost_scsi_stop_dev_work(struct vhost_dev *dev)
+{
+	struct vhost_scsi *vs = container_of(dev, struct vhost_scsi, dev);
+	struct vhost_scsi_target t;
+
+	mutex_lock(&vs->dev.mutex);
+	memcpy(t.vhost_wwpn, vs->vs_vhost_wwpn, sizeof(t.vhost_wwpn));
+	mutex_unlock(&vs->dev.mutex);
+	vhost_scsi_clear_endpoint(vs, &t);
+	vhost_dev_stop(&vs->dev);
+	vhost_dev_cleanup(&vs->dev);
+}
+
 static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
 	struct vhost_scsi *vs;
@@ -1821,7 +1834,7 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
 	}
 	vhost_dev_init(&vs->dev, vqs, nvqs, UIO_MAXIOV, VHOST_SCSI_WEIGHT, 0,
-		       true, NULL, NULL);
+		       true, NULL, vhost_scsi_stop_dev_work);
 
 	vhost_scsi_init_inflight(vs, NULL);
 
@@ -1843,14 +1856,8 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 static int vhost_scsi_release(struct inode *inode, struct file *f)
 {
 	struct vhost_scsi *vs = f->private_data;
-	struct vhost_scsi_target t;
 
-	mutex_lock(&vs->dev.mutex);
-	memcpy(t.vhost_wwpn, vs->vs_vhost_wwpn, sizeof(t.vhost_wwpn));
-	mutex_unlock(&vs->dev.mutex);
-	vhost_scsi_clear_endpoint(vs, &t);
-	vhost_dev_stop(&vs->dev);
-	vhost_dev_cleanup(&vs->dev);
+	vhost_dev_stop_work(&vs->dev);
 	kfree(vs->dev.vqs);
 	kfree(vs->vqs);
 	kfree(vs->old_inflight);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
