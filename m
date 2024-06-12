Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E217E8F3
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200477; cv=fail; b=Bkmue6XeZnKtqrV9oZ6gsHIk1yzlGlwpXlUrYRMd58l+W2IHQm4eKcBBhrxJNcKmmo/tNxWRQtRuT6Mgxi4L/zGKUNKuLYU7Px4KqVL0CnrA0LD+yqDcdwPLhkevslFiHR9Ufb4n86yPlOLglHbOLApSjpXB/0l5yRTG673gI3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200477; c=relaxed/simple;
	bh=100+TPjQ92lHC3ZBCTRXJk7HY5AiU8eS6PBFbVOfltY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZY/u9jKgJrejSSgGhgIKlDIzxREfcJfauLXwo3VYO5WgvzRrmeFC6n8X31WdzGBKl2ESTnDaN8RkhIpM7mThqxnFRgovgQM/otZXRAfnqXQan5J5fHvtICCXzidtvO3VyCGFedUFsCw8UmTaFYXVagUm0E1WXFLfNWpn9BAXWX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SQlheANc; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SQlheANc"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC49240119
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xplH979kTgyv for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:54:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2412::603; helo=nam10-mw2-obe.outbound.protection.outlook.com; envelope-from=jgg@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8A67140125
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A67140125
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SQlheANc
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f403:2412::603])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8A67140125
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceTYghtj15KIH5PLnjbHp9B0woB2mWS66QRECxXVn1u55sRh+4ICmvgvk5W2JwzYEgcLorGZ8pn8AXzUsF2TuE3apFZu6LCKzUSwlCWiI4nSGpgozE7WOrgMm0cnWWrpKkXs9ck2oQJDhLsD3v7nadtLq65mKNH9wOSiygpWrBqmCqXj3hkm+6YtSgJVHTW0DPMYjtiSL84MvBuOqgfL3XBMgz24IfG2KHs4wM9nui20K88jH1TIn8o3fL5foypub+h+50V6yl9LoV9GwHw9BjXUVdsaYsGRz/PZIXw6LZ+IbdTrql8OT8y5RgPlJMFyVxiHTAn2Z0kEU9D2LCzs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=100+TPjQ92lHC3ZBCTRXJk7HY5AiU8eS6PBFbVOfltY=;
 b=dAIC8GucIJFaYpoVbWv46WyPiMffl5QZ+Q24eFEI6SYZmBHXtpyy/bQAjKLNJ7QMJEW7oeATr91XqIG1ds5qZWCy47nTbGJ0ITSiE/mlJsP1qcTV1TZzuD7H5VWzNcPtj1lN3xsML2zyoiNEdtapI8rIVhyp8tNPaM8AqQigxtG0zZpimZ2UXmJ1Hm64upxeXZdV7K957eqdwgtji/MKszKki0fQ2RKKIFW+ff/9LAJuflnKuIVwhTWVL3Ph70KDmmMDndZikitVMJbqLbOb1+0HE2+Wru9xOft3AnToBR38m+LmqSRgpg9qrKEAVCaq45SSk3rDQrA4s2qEkxW+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=100+TPjQ92lHC3ZBCTRXJk7HY5AiU8eS6PBFbVOfltY=;
 b=SQlheANcZKw/Q3DuucPOPl70lbWEwr2c5BwcAPZl6TOt6yNDyiZizsjgS+OOOjGXqvys/0HtZYfAodPK6zoz6ndNqScLmw2brb7AedANz5flf8XSkLPYzjjeoeiobB63UjticVoMN1z4rP8ZJ1wXpQoTi9cpqO35GKgYhrzReRXFrVVBKO3isYBr/SSdinSxWwZ9bcFXIuXG7lI07LDGw7CkqMiaLTnq19te41I6eWHWXBNOh21tLBW4cvLasr1zv9TFKwungzqOA9c44W3hDuG9vs4VDUjVGRehQOXGfKz0TIZpMRh6HgpRot6+kGcSmd2MShZ0S+bE73JTfZcxFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 13:54:29 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 13:54:29 +0000
Date: Wed, 12 Jun 2024 10:54:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/10] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20240612135426.GA2151677@nvidia.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:208:23c::20) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 317af23a-7b58-492f-0358-08dc8ae72d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|1800799016|7416006|366008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wdhb4rntOohiIvlASN4symHdEARYDxnR1QeXHbr5k0VG9GKEOERj29okSf0J?=
 =?us-ascii?Q?GXDKrI85LEyz1nhs3z+a0CnH9hZNb+qg1AdYye7nKSdl2ZqhYZPcwDpawwbA?=
 =?us-ascii?Q?qil18UFFucmFgi87v7TF97u8Eu6bbwBed3ValK6vefWcg94E43hlZ7LmSm+s?=
 =?us-ascii?Q?mjeRSHknXT1wrJIPfsOsrNfEVuJFzkKTezns8Krz6FcEiDQljJicqWqNNjUq?=
 =?us-ascii?Q?RXcGHc3Xi1yTJb/Ah5deAYQCElOlv+zkOf5aBRMu4zZYpoK5RKFxf/t2arIo?=
 =?us-ascii?Q?TTQmvdHWXXfb62MbSrp4SSbLO0Bkgqw35oZEEFHoiZwVGcsOdDcirKe2N6nY?=
 =?us-ascii?Q?5ypQPF8bx8LXoKLXbFNuHq9JZUKRCI+/OeToAmUxPuooQycIKDkOWzmwoTLQ?=
 =?us-ascii?Q?Kr0qROWTJAx3Oqwinpv3qaTFJUT441X//pLc9f1mSBW6l4M1r/mp3/i34nTm?=
 =?us-ascii?Q?ZB73dlj9rsP41F3xBMdCQ+1kWwjjHeJngiWl8hGr5y6Kop04xaxZIl2jZALc?=
 =?us-ascii?Q?Vdr9pFJhKL6fsCifXevlbNISoUdbF4O/WfdExRqvoFLqUFQyiQceIrvf1lvg?=
 =?us-ascii?Q?c7rs7SiHEDew0KCkpBOvcbuoBld3xQnIDPhpgiYVBxNO78WZ0fvQj1k/6rR4?=
 =?us-ascii?Q?UjFWsFqY9mLei8z1YOb1ufQn94xtOSNslwQofqxTgMVa/6t1z6wlT1OahVN8?=
 =?us-ascii?Q?FT0fCCF7nuyijOly+BRJIwiKHjQhKD1tuO/daEEAEIGMO1wJJTEF/AfGHfD9?=
 =?us-ascii?Q?XMyK1k2nxlYxeZb6XjCRrDKUEAyzUnwdKDvAO2SiIOhnDYo4ap64Mrb9n8Om?=
 =?us-ascii?Q?idqn2TIOlRsdVlE+2PaMt1EAcw7AgJ3I/TPTpyWwVPCc0wP7Q79n/XxIWmmx?=
 =?us-ascii?Q?4R39SM5cHv1ybeUyfbQozIgfZ95pk4+cYSie8eGDT8vdYy77tYaTbrRXEgMy?=
 =?us-ascii?Q?dlr5x+iLj8bM/Wvu2sazLms2Z2WMs9YjxwNyyCtHKWks202QMYC+r7tcWQiO?=
 =?us-ascii?Q?8ujy4nLRTCsHLF+GggfjXsEenJYqOoKlGFg8Y38SOFi1Z3LuKowVkyT/hwwF?=
 =?us-ascii?Q?b2eFVyAtx2zteF8GQdkWcwlG6zS/PFyMpPrL/UEIxfmFG+3KY142Cyuz0Nmq?=
 =?us-ascii?Q?FuqxRHCpg6zXbe2BxPCkeuzLqi2beTz6QvCH5cE3uHHckl+ZEGsdt7xsq/TH?=
 =?us-ascii?Q?lYpt4xoT+Cnj89b6jNUrAYFMdSez+igXfgT3gV0qRcFfyAaNiLFh9ZvB43nA?=
 =?us-ascii?Q?K6bMUCG/OxevI+X2cQ3QzjxcgB5YtNSZux6UTBbAIk5ob9Cjuv6BSfkG7lbM?=
 =?us-ascii?Q?mhwo73fi3hVKGxLUXurbZ4bn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(1800799016)(7416006)(366008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nuFzw/YjqajmHWW1E90iS/ZPXPyFfyq1o45fBzfRQp76ebEi44J3cPRaP6fd?=
 =?us-ascii?Q?pxtA1WRHOvIpB1lXJS59b/wE9MFNJbcn0hoRzgL+qqp+2kAZhTLW42sjMeS8?=
 =?us-ascii?Q?Gn1vsLjclcqwg5fLfZ4sLhu6ykUIVBJm1iUQxn8p3izlGXBta/ylCx7yucjH?=
 =?us-ascii?Q?jk9Q9Bwx5I9cFbqAUTLXaNW89VdbdJGSQGYLo27syoTEcvR9WIu/p8Ar61QD?=
 =?us-ascii?Q?Hg1ibzLONW1tbGwbJJ88XgJqfhS5bPKQ0btzSu3WrFVXiIZUt/M93EiNcVBQ?=
 =?us-ascii?Q?wtQvq5YJktnMIpwU1CPnwjlUoOfSZIIqdgjJsUBYXu96gdzBmJ2dvsa68UYv?=
 =?us-ascii?Q?8cFohpYTR33NITwm/eibUPvP33klCzyQ6YQf8lp0hYKDJ6Y7UehWYIb+zwXo?=
 =?us-ascii?Q?Z8fCDx4KKdO4XWXbK+cy0BPrOd5DNoItQujISvx0tHZinIasTzHjq1I+dHTe?=
 =?us-ascii?Q?MZJmDX55qWZ4EsHvKNRnnt5h+zGG85DVkNU2AgvQZx7jqt3fBycpnXu9Zs4l?=
 =?us-ascii?Q?mBPxAGZ3xALs8wyhKwRRXMBWU1P3OH+LfU8jHheXX1ebnahtfHFoE2IuhyqG?=
 =?us-ascii?Q?+EFJL33pIqpdn7tyaYFcbw333XetxeV+sUqhI5daGeuoD9hoTc9w9NoTNYK6?=
 =?us-ascii?Q?tfNH3xDpzSO0aVoL1qJJr3QgeqeCA79KjZE81f85eB0Ui9QgRE/7YGH/z0+D?=
 =?us-ascii?Q?GHMi8SXaiKXIqyhFBS1liA0f12Zzd6BDS/cjZVDmLKtmgnCMhSQhfEZc9SQW?=
 =?us-ascii?Q?bD0GG67DBausme3kSrkDA4h0yGJa0w41Boeo+bZr8cBNoh2xaPwLu+GjSZn0?=
 =?us-ascii?Q?hdLfKukIVX9b2CHDNdWweLpwEiEWWAuzBvsuXsnW6BuwPWmVAiCmg/ny80y8?=
 =?us-ascii?Q?Sjp2Y/xYWWwlt5AZ/FRoSs+4+7obEfqBTOVdzZdabCcm81AGb2w14tYZfohl?=
 =?us-ascii?Q?z/G82/O5V5WKDaERmRDwkhOUYbOiv8S++0zMER7kkL6vvA9cK7qZEyEKwxuc?=
 =?us-ascii?Q?y2M5k7jOlBAbNahfIqPBxlzp+qt6a6x3Y+Uhst24riOqTTCZ3LhWPOD2XfBX?=
 =?us-ascii?Q?/Ve5esYGzGg275yOp0xL+0e+KaB4wYJ2w0RH3Y1TXgDVy7jgzn9UVYmJqiHg?=
 =?us-ascii?Q?TQWrRresBc/7KlEq0hAl+OGZe/di/JLOiG/RgoHY0JwwCsl8sMJnRK1It9NY?=
 =?us-ascii?Q?kyQtC+S3r20r62wRJ2B+h7z2zGBhOdbR8ZCFHzZFRTEZwUTkMHAhdXD5Ud7o?=
 =?us-ascii?Q?KaOw572PAW6nYTChuTvMRBSOEv6nQbnNyaBn/2FWVAUYjCFHDZjbwIh9Knn0?=
 =?us-ascii?Q?gpOM68hDqN8Ebeo1tu19dyQkiJFWO5urmInX8pj3/5SMItNsJi6XXacAz+LI?=
 =?us-ascii?Q?ZNd62FInPrVETTFEW4gI6f/M/3yQsLXN2rl6Joq596igmdi/nvr7AKY+G6e2?=
 =?us-ascii?Q?iar0zSYcHFdKRTu+xDAFeyw5ERlzu9h1TPLA3c8bv6u+tEAsFJxCUXbxw3hs?=
 =?us-ascii?Q?el7kXIshki4E0ZBL7WnHcd+EA0QoXym6sG0pPypt3AIJY8nU6Lo910snE9Wn?=
 =?us-ascii?Q?fd1qMXrsTcZusD0UUdeqXuM7sZv7ELnKbDGD3cXb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317af23a-7b58-492f-0358-08dc8ae72d92
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 13:54:29.4093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDl9ZOThMbu/pvo0KeoCM9N0H3+AM/1m5Yawczw08b/KbnQj3Xeyyalp7d+v/dPW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246

On Mon, May 27, 2024 at 12:05:07PM +0800, Lu Baolu wrote:
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework. One feasible use case is the
> nested translation. Nested translation is a hardware feature that
> supports two-stage translation tables for IOMMU. The second-stage
> translation table is managed by the host VMM, while the first-stage
> translation table is owned by user space. This allows user space to
> control the IOMMU mappings for its devices.

This looks pretty close, will you post a v7 with the minor changes?

Thanks,
Jasno
