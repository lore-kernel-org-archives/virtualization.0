Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04B265606
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786936798; cv=fail; b=PROeL/z/gPLY8c+JmSxdyaIxVIUesQub88OGHwZT/zJS2EDX1CQCibha0veDsz7NEFjqdk/+EWmXuPgbKtLuFMILYqsWxMtaOyCvjanalQ2ctn2K65Dcqtv3P7bjYfusBvs/SEs5saW23sh7GOz+4wf5qWS9jMeTO46bZgWxJBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786936798; c=relaxed/simple;
	bh=m/Sl/WIFmOJyv6DAED6tYbnEhOMRUmFMk8ES/yXuSAc=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=Z3zVUCUjgDClqq2XcyicqfM5L+JwkVS/CJ3UEvGwzNk/TGvZ07SHSNXjQkODXhR1EqV1ho4p6nrmKErfBRgJJlkfgO1p+2TAmPgUcZTpBE8TbCJvieZTda8OzumnjeP8C7SATjJ35zLpUbgWWU2pP2n7gXs0c+tt/1HNy/ulMYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MZ/Na02b; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MZ/Na02b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymtGwdar0egUiw0gN5eU+gQs5RkoO1Znh978z30Htw+FNrAm2Koddmr+T9gKvQBVNYaFqrfVcUCqr6AOesVaPI1DFPfp5a660HQw/1vZmbEAib2LYOoMKknPbNs97Mcw+BLAzAKAlk16cz7JsKuWGhHBtD19Ci+V6kWwbSISOK4NoYQM+JSEsL/w7g2OnSzZq0c8tS23zlDOJza9/LBYj7sphDORtUUX6/VuPDI3zR3ArrsPsE553W2plCGSOEeT8uLt1f17ZvBEI59droyiQmtv8zh1DOf1e9XuNUDC0GDbPbLSEqsB1AR3oWRnXOwa8p0HcNoYekdWhxacj4NMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECuQ5EbxfrTfvi4azIJpb3E4SlIYnRRm0WZNmNa61J4=;
 b=XUxevspsaQEGDsy3I0Dv/8SAXTxbWY4cjXNFIuVscC6avx6NAg0OhBJBRU0JyG3ptr1SvYJGQfWdgdUzU8GeM6dJimn7J8LTCt0j6zIAotKGO7wpntv4sBlpn7e4xk83YnPOGVJIJzZxF0HiLGbxiQjkwG5DU9XFLVP4x3ICOr0tgqKL0kDrkA9wY5v6JtCCApm+/1+nWlzVz22NkskjkcM5MCii/BHUaSJ8qmbOXxF9BXjA2NCIdkBGtHRUFS0g9fz+pAUYX3IpKR/DLqOJSeDBvgLl59qg4p6KLj5hYJITDeX/ushD6olsS+QzF6OCfShbJrbPV5LZjJCEjzefRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECuQ5EbxfrTfvi4azIJpb3E4SlIYnRRm0WZNmNa61J4=;
 b=MZ/Na02b9BtcUPXkzhjTkjSjGS7MdSB3bbJDS3U6CmEn016AX8bjsdbjxKXTgJEiFPJ5tCBgKLm+6b9WnU5Luo9nC84tqwR7b9A7bCRW8q+M184zw6KGhTooxPw//RThY5mHySD8Y7Bz0EdBckwKNsGedfoXhn8VjWpgLbf2dco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CY3PR12MB9632.namprd12.prod.outlook.com (2603:10b6:930:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:19:52 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 03:19:51 +0000
Message-ID: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
Date: Mon, 17 Aug 2026 11:19:44 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>
From: "Huang, Honglei" <honghuan@amd.com>
Subject: About new backend for GPU compute ROCm in qemu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0006.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::6)
 To CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CY3PR12MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b9299a-f382-4203-2406-08defc0e66b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	qrtkCuuwrFKjoEisXqy0tViiOgwlX9/6h6Yr4DDZ4BF+DwYOYtbZCFCxs9UllFPfikeQOQJ1aaTyumFt2OXyG2kHL6wuskuTbc7/Fu5WUSZCOSVSsDEVK0zu86EgvBh/WNj3YbZj+knvJvgZBNmJYz5U0R2Rb2+DrI5PMIZI8BSHNch2z19Y2TQp/5PBm9vouUo1RroOB6UffYJW2qlfC5XxcGraDsXUVGVfsvYQQyewsBh70LhmOWYCiM9YTjolgSM8byc4xtLYtIu5urPo8aKji/O6Q2oXq+1b6erm6/mxuGQcGRRS7Ghn82/8qFwTSwQAaeIHRs9Tp5lDj6g/YuE7X3q0LX94XyiNtP5Oycnc1mbOUY+kU0XcfqXvHS8yMhzGpuUMuXpKF8p0DkIO/+IAIcC3e0kjnbqe9DnX8vUMiSHqGr4KfhXcfLjghGAySXUdKQkszM5CLfzBuydLSwPQJlEujSbN+eE0QKJUxYqkL+nnD7xCeji1oG4/2fpfqp4W8nMjARZfYAIg8wk5y0I9+ApNUmFAUWiRq2bXRae4dJD2dl8fw8NZ3/PCL9l26OKF/qDYaBU8pZPF0an9H+BY2r/vx9IDt9FRmUy4OL26ZQw7j4XC0rj/ApUDnU4Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTZhL1drSlFwLzR2MFZ1bnhDZmhuLzBaVVNJSG5VSHVEcE8wQThZNzVWeEk5?=
 =?utf-8?B?WEk2OHgvZHEwZGF1T2Nnb1puVWdPYXhoY1lYU2F0UWdOb3pKRUNPRkJXZHJU?=
 =?utf-8?B?OXM3dDdFSm42U3FiUkRJOVBSdXRSY2J4TzkyUmc5U3YyaERPd0VrUEtOMkta?=
 =?utf-8?B?Rlh3VDFCN05jZ2taSVpWN1cvRUpFZTVBVThFbHJBODBTYTNCNHYwZzR3Smd4?=
 =?utf-8?B?ZStFNTYrdDk4UExWb3Rpbk1sbjlMUy9iaGdlanBoTW0yZjlnQXhWQnNQek9o?=
 =?utf-8?B?WWZYcWhtZDFtM2wrQjB5WFBnd0Y4cXhMd2JBd1REY0Z2eXlCdTBVVmVQUlNR?=
 =?utf-8?B?SkpRV2huQ0REaDBvTzFKa1BKZXY0S2l3aE1HdlhGTi9vZVZwTXMzeTA3SU5s?=
 =?utf-8?B?MEpURjB4aTRjelJRdXZhdlBLSUY2THBFT2dMVC9VcUtzSXIyNEd1SCtFT3V1?=
 =?utf-8?B?SUhSYWxBQUNRR2kzQXlpUnB1NzdRbGQyQzFCR2tCYndvdG5FMTI4OUtaVjVn?=
 =?utf-8?B?S3FXYVl1cTYrZzd5dkczMFlmYjF3RzZhNXlhdjVSUnlsM29icHNrRXhPRmIx?=
 =?utf-8?B?WkJZcC9ncnhjUjdLNlBPdGhlNzYwaGtEVDVlbjVSdFVud1Y5KzBxempKOG4z?=
 =?utf-8?B?MXZqSVpTeDBjZFVuTE91TnFlTDJDMzM1YjVYTFZ2eUtYUmc2bDdpOFRDdlNi?=
 =?utf-8?B?MC9peTRpakhTYzZIK3JYQ0tUZGUzV2w3UXFaU0JlV1FEWlgyb3FIQUxkNlpN?=
 =?utf-8?B?OGpIeEJnWTVCZ1Y5SEhFTkVpaEt5bTZvV3Z5a2VqcjBBeCtwNmJHZUpuQW5G?=
 =?utf-8?B?QmV1cDR1aVdsUW85VE1TMmkzblNLemlRNTUrU2tBbE5HSkl1dU0wZStMMWMw?=
 =?utf-8?B?emZ0ZEcvLysyN05jTjVRVVNGZnFTU0xEelhISDIvNFBiaWJxV2I3N1psL0Fp?=
 =?utf-8?B?UEZBbXJqZHE5b3JHb3pHK2JJd2t4b2N5Z3hUcVEyVjVuSkRKZXNpUHRBNExq?=
 =?utf-8?B?eUl4a0VBdTNBQmRXMU9EaVdlaVNBN05pS3oyempCMXNtR1lMUThuMHlTeXls?=
 =?utf-8?B?cm13R00zQzh5bWJUdnNHOFdrMUxWck5rMGgyVTNWaUFvK00zNi9XOXVScm9w?=
 =?utf-8?B?QmttTUM5Tmt2V1VvUUtONEQxcVVFVGt0RlhuMjhLU2h2akdwQmpzSmwvTENR?=
 =?utf-8?B?UVJJcGc3aUNNZlltWk95S2N6QVM2Z2w2WkxTT1NKY2doV3JmYm9Fay9ZUXkw?=
 =?utf-8?B?ZDArRWQrcWtET0JsNEt3RFp1a2lQRENsTHY2ejBCb1d1amRqWmxUK0FuQW03?=
 =?utf-8?B?RXBZd3VmQ2d4Mm9BOTY2ZjhVYmgza1dPakgyY3FMQmZsN2ZHdEhhWFVlRTZn?=
 =?utf-8?B?R3JPdVVWam4wTCtEMnNCc211VHh5b0tUUnJMdFlzRElUaVlxanlpemxmVzVQ?=
 =?utf-8?B?MXJHcEQ2UEgrL3BYOUpZOGhGSWxZM21PaFpxUkJqTy9DWkVHM0ZENEN1WitM?=
 =?utf-8?B?Ny8yeWlWUXBRenUxMFZsVVd1Yk9BTWpLcW9EeGgyNk5YbVUvRkM1UkN1Y2lh?=
 =?utf-8?B?NWttZzF4TTZXTFBFWGRYNXoybDJUYUR1NXNZWkFoQ3RzWXRVRDU0QWo4bkZT?=
 =?utf-8?B?SGRzY0pJRUVXSmFsTHB4eFp2dTkzK3VlUUtXY2p3cDdlZklvR1ZwWUtFdXAz?=
 =?utf-8?B?MUt6U0lJM1dTejU0Y2IwczJ2blNsb0RZNGc0bVBzSlZQcTg2WkVFMVU4UU03?=
 =?utf-8?B?Y09QQklWWW1pWG4wY3dDVG1ZekxEekpSbnF4MXVGVlUwQWNsM0hRY2U5MURH?=
 =?utf-8?B?TEVaS051dllLWC9ORlhXV3h4Vlp4bmxrMmJBUG9rM1M1d20xWnBQRGwrTlFr?=
 =?utf-8?B?enVRVmVGU1lHcjNiSENNTFJPc2lJNGdqSy9kRi9uSytsR2g0YVZUeFNDWXB6?=
 =?utf-8?B?U1VPYTMwRUtjYVI5TG1ZRVkxdVM2TTRpRHFDY05SNHJBVUF3c1FocFNYRWF3?=
 =?utf-8?B?T1F2dU43ZXQ4bmI4VnE5a0ZJTUc0Z1NlVEZ0UEdzWnlVOWFtbUNHaFZtc1FY?=
 =?utf-8?B?R3UrSnNIRnFoYmlzQUZwSnFieU5aM25zVXE4UXhZcG1TMzN0SGFwK1lyNW5S?=
 =?utf-8?B?TVp3dU5Sd0NpeTFTTVFLcTVQMkd5K1RkOXFGMEwrOGNOUmdSd1FOeldqY255?=
 =?utf-8?B?WWJUL0FEZUNsaEZiakM5c0ZkUmNQRHRlcmpSOVF4QkNvSllSYzlCTXlkZnVP?=
 =?utf-8?B?N2pjeUdaQ2VTb0c2bjU2K0tlNEhXem4wcnpDVzl6NVAyRU1uU1hlbll0L3pv?=
 =?utf-8?B?YjBxWkVZVTYwaDlLWnpzU1dTT3RGZjZobHZ6SW9QdVhKMGtSMHE2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b9299a-f382-4203-2406-08defc0e66b7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 03:19:51.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKk/zMzNY/eK2KlUToB3JtP1O292bc0sE5Ca0uSaOBZga1LGlrvDpjq2Lmt8MonYgWgJeW9iGY7aslFk0KVWTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9632


Hi Michael, Alex, Dmitry, Akihiko,

I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm over 
virtio
implementation to virglrenderer nine months ago (MR !1568 [1]). The ROCm 
side has
been supportted by ROCm offical.

Current implementation is a virtio gpu context type capset handled inside
virglrenderer, sharing the display path. That's an awkward fit, many
compute GPUs have no display engine at all.

Beyond that, sharing the display path is increasingly painful:

   - Compute hammers the queues more than graphics, so sharing
     virtio gpu's single control queue with display/virgl causes contention
     and display stutter.
   - Compute contexts need far more blob / shared memory than a display one.
   - Maybe needs a wider ROCm / compute stack, cause the render model 
fits poorly:
     rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth streams)
     and ROCgdb (wave control, address watch, async exceptions an
     out of band channel that must not block display).
   - Events, faults and GPU reset/SMI are async and don't map onto fences.
   - All of this is hard to extend cleanly inside a display capset.

On the QEMU/host side, would something like this be OK? One step, two parts:

   - a dedicated headless virtio gpu instance for compute.
   - that instance served by a separate ROCm backend library loaded
     in-process by QEMU.

That reuses the existing pluggable backend model, a second virtio gpu + a
backend library. It doesn't add dedicated queues for debug/profiling 
currently.

Waiting for reply and  happy to share more detail. Thanks!

[1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1568

Regards,
Honglei
