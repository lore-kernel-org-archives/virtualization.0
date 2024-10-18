Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765FC1EE026
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259632; cv=fail; b=cs2qfQepf3LjmWvAs55aMaWjg7nNQM5LUZQSc47XkSRR6rnktOnADMt525F9XCbsV9MW1l+uC/EetsFcGtxEM90fS+X3KYGUkRqFiHKrNNrYpy72/v0UOjViXzLDQQZdurtWgWaFJyKfPiXrHJ7/H73f2TKwWES8d90ZI7fLugo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259632; c=relaxed/simple;
	bh=Sj3xeWHcj+6WlElndLtvBptc3OlmnggshWqC5UA/7Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sE3x+br988FmfualJgzsMglq11jYibYojuK1knlrHHq8BV0LOFGisEDyT42a4JTUeC+71aojy8aXNhh1AjVX44TUM7Y6jHINmuMAKSIJVeA8HUVg6kDt/XWDdzC1zbS/5G4Aw32r5zGRqod0Ou3BQwJtYhSG5qHDUicV7ZnbR48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j2tazT2w; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j2tazT2w"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1211C60B14
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 13:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9VEIhKi_LuWz for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Oct 2024 13:53:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2417::625; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=jgg@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D53936077B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D53936077B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j2tazT2w
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20625.outbound.protection.outlook.com [IPv6:2a01:111:f403:2417::625])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D53936077B
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 13:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkmD9LqBuJElMGonCux/kPMtHiRSjed48wnx1oAfigcqkYxUNSsxwtj7vJ9Q7WAxy3s6zuZyt8rFVms8+9XwBJNI5lTeC70FlYSj75quWBeD9S1TwEj4ZVMXUmVHLDHfyKh+3uUqKpTpvtZvwas2rEyLlrVAC79oG5401hPaypImHhmFkoRHmIrZbq6bDDNYzI8F+dtapvkz1QWhw62h0mdZWypHq/PVjv8y0nckVi5xE58toAGMUW6PNm3zPAq2EOWEu/rsc5YVMNyJc3FqV1LI8j5udXqDQhxpeMPgpsY7+0zWtQ5pk+ZqHDLcOnyGQL+QhnWBu7cyonqRD7LBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7IydsLF+BEVM2RMNwSplLttAOK0KAENbuiEdaKIwWY=;
 b=aFLkkPr074d46v1Dft3YjrLC5m+vutg12lhZmGMIu087v8pOyJgkrAqN3aY2R2gGZNxjYXk8gNqTeey6/fk6OqdRjivfVcxTqTPgeYz7XovwuWAzwosStw7NiG/Iy6ON1taypIPmkzGGkW5J0xvNQmshj/Sb/UBBwdnVys3S1Xr0idZGXdL0txg7D84RNO1cFReHo19HJnh0rVH1ciMKHq7kMBEaNItkKhWxfczu+R5p7yDb3u6rn9jXdKLPxjv2jV5Wkt4yipOLbhRr9laD1jDJzmW3mvf+QBarVVXoTdQNqLYK7G+vBJTdBzYnGvMaDD1lU8ENIW3qSOxACM/ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7IydsLF+BEVM2RMNwSplLttAOK0KAENbuiEdaKIwWY=;
 b=j2tazT2wH82Ppny0syaMT+pSoaxxwvSNghTcSXEH7enxiwoCie2qVs1jUtuJfVShVUapiIdsq5WmhKBk0R776ta/Uv270UIrQ0YVqVVKTbWYUFK1cKMd4X92snOBHk4DgRF8W7xHf/nQGwsyitu8Z2owHytrzKuKpCoBBt4ssWHrgFnnIWa+2Bt1gYVTHZHMzRXJn2xiwZUqtDwp4d2vm0uLBRQkymJswEZ6Y0Os6pn7mZDHE2v9b90WFu6GlINKU/NVTO+g+QaglPw36NUkQvsCLuqeg9TK8utBV9iOIrlz2GhR30D5AfrF4EuK0VeUsVuy0ahXJUm7JCwHIgRxBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 13:53:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:53:45 +0000
Date: Fri, 18 Oct 2024 10:53:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241018135343.GA1914429@nvidia.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016152503.GB4020792@ziepe.ca>
X-ClientProxiedBy: BN9PR03CA0899.namprd03.prod.outlook.com
 (2603:10b6:408:13c::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 929f9f81-55d1-4275-064d-08dcef7c4869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+QJLR8zKlItyvlsbueNQd3eCAnueIbeiFDFiFOdyg7Ixl3pG3Mg5Xth8zlq?=
 =?us-ascii?Q?jDXeouUNJHw3rIwXGlP/kmCNp5up5eeB6/KtkbzzMQiEdweZT7gxuAqu+75k?=
 =?us-ascii?Q?/C599dTxaEB6+uPq3mQecIdX9ALhhFnfJI544bJC2UsYfDoCoU3GUPlj/X0R?=
 =?us-ascii?Q?L1Vgs6xI60l9lwqtJjn83aZCrNOXnZuUjFBBUyMEljLbWhg6aDGyxej6ao9K?=
 =?us-ascii?Q?+5GwXt6lrs1N5KjV7vvVvj3Q/00l6ls3QyVCYsi+g1TLdygkIaETCNhCwXhH?=
 =?us-ascii?Q?U1E58zGvtRzkQzeByz1L0uO7Wd8vr/wHYeEmEQm6DvA+mz5u3TuGPiZ5vjnl?=
 =?us-ascii?Q?ig4kPBfVjAz4dkl3QtdeWM3RvmGf+fEEvNiZgXMJ/Z/wRVWM2l87Sk9NUK3z?=
 =?us-ascii?Q?R9q9OT7m4CIq5EXMU+ogXqlBAiq+uKAFB4XuadUp6w7jfTVBT5j5IFmcQ1t5?=
 =?us-ascii?Q?SsvVhyPFwLiBmc5/XuqKI99Xx22lT1q7I51lxfOlQvn6fnd5RJd1cpanpXP2?=
 =?us-ascii?Q?AcKWFfPHNdWsWlhVWskGJHPM/YsAL+LmLCWDd3A6R2MRjwWvok3Tn+L59LzM?=
 =?us-ascii?Q?60mjk77nBswuxd5BskmZZbSO4TCzw8I9IJmz1j/hqdPn/nZ6Kb6q9gCyYcGv?=
 =?us-ascii?Q?uy9n1GES1ymNzosQF3aXtH8LEixtnO3OXt/pBBskwaN8C+DvrzP/v8aWIblU?=
 =?us-ascii?Q?lOJQE3g8tvCiycVGXkeGy/W1jeDPG43ocUSH3YciA579DBqHKmEdYL6+fvEZ?=
 =?us-ascii?Q?9Ax/sVZ1UuUaoL2D5YjbzNkrwPnl3JX4KkfwaAVQ9zcK6DLxQFnEiYe1sT6e?=
 =?us-ascii?Q?OlTehIO5DcyQZUV+tvJCCdaUBQ0bZqKOrp+f/rBlBl9EVXST6/YunY3YRkJB?=
 =?us-ascii?Q?Hrv8az582AginZT0DyzvJoAJDgxEjYeUXB45doHZjtrQMgkRivA136wYHhY5?=
 =?us-ascii?Q?JzVcKkZ7Jukkmv5j5aLxk+mXW7fnBFYWzSud2ekLKaHZGVYTKwbZMYTYbP8m?=
 =?us-ascii?Q?QW1p+CDc2x/GAdlT3dHbGCtOOObCdUwOwm+mtJL/lHPt2tAHG6ijAFRQtij4?=
 =?us-ascii?Q?+mpQ88IgMD+MLqAwfJlFKGeopLCPflv375kcUtefemNKw3dKoYwYnN4us3nl?=
 =?us-ascii?Q?3o6WjdMcnnU4pTLheDwCrApibPtfSj1TGPO+HvDth6gOkitBcjObCjHA0Anu?=
 =?us-ascii?Q?dF3IoXydkmfMT/hDD1mpCuD00NnGdEew1BVzc7qOJc/Tc58D3kqykEyMW+d5?=
 =?us-ascii?Q?SNQhIwrpAhkUUyLUXqe7cjzdeesaVVD9PggjoywD04CPdCUonYxb64L2VFqr?=
 =?us-ascii?Q?07iTpIDKQk5PZaPlMfA6Az8e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HtnHJzGOVCLkvxtE7serZq6/IkFu5UbZyI1oAoP+DZbn4pdHFApDJPsGgy8a?=
 =?us-ascii?Q?gBZjlpeXf39/nREtMZvMth8Qqhn0ohw2R5uDpTytNcHQhr7CD67yX1BXeFTu?=
 =?us-ascii?Q?cYvn5SnL/z3fanGf4NADLBoun097fitM8oBIAowWTw0bjqLqMVzo8eB5M7nq?=
 =?us-ascii?Q?O1bQbZYNwuCkcOyTB8wO5cKRio6vQ9QrYzMAezuLujb58hbqFBOl2auRLKXb?=
 =?us-ascii?Q?jALlxvWLEpX1p8batNXDheoiUFWDHulICwzzkhtqpn1al/9ZCoT9E1R2Dqlv?=
 =?us-ascii?Q?l2az8cBNUsd1O1RMj5oxeTk3XDYntTIT2irR3kFxbZUspzjgP8SpseDgIO8r?=
 =?us-ascii?Q?dh5jwxi/EvJy/owunm1a9RX69yWWnz/ZETkCQ3j9+4rrHR4OvTbWi7A7xv+v?=
 =?us-ascii?Q?ExTcPnKdh1dktw4g7yz3xmBZO9A0FmxbWAYfF6x6u/EW11PyhoP8LxC9sXjg?=
 =?us-ascii?Q?uXoUOmCkg7v6t1NKVfwubVjUAhing+utwBEHNnEUWsIgj9H5r77GUGCl8Sm1?=
 =?us-ascii?Q?VKD4FPYZtnon4hRVc87gXsomFZ7guf/Drf6l970523OdAAcjH+Nj2PrGPeEB?=
 =?us-ascii?Q?ijF1+ycPTRafGWxJNxINppUfe6KIwQ794iuQZ/sD4/tMQHXVuY6rK5j0rCEg?=
 =?us-ascii?Q?iShDRNqI8a38SVvREXDKKTPAg/okPbbIrBVWdQnTjg74HWYgX2OkquCrXCIf?=
 =?us-ascii?Q?e0GcDTpxTkn9vE/4amcFdsIfWYhNeVKzDJjMVXK6Hh5IhFa5YISdFpE5KNQ/?=
 =?us-ascii?Q?6jV5QkKDcWBhUkS8rlMEyVqgSPYtN/RoJRfYKKeAocEHUolOtkWzVKdvZofY?=
 =?us-ascii?Q?nJzdcl7/GMRrYc+qXwUA5CuZQUWmxBRtx6qHHoyjsB1AN0yGWSqaJSBt1Zl4?=
 =?us-ascii?Q?odi1IuQak8dw+rn/XyNjWL4NI+Z8mman5gEgWVzUGhYBpqvVuJnRh2bdLs5e?=
 =?us-ascii?Q?oaIF1XaS2pVRK9sOl+CLPY5/Un5wclOLBvJ960K4A4z4Y/w/5vniPZYl9Ixq?=
 =?us-ascii?Q?y4vZi9gOQo8OijzEiBxZ1tXFdlHTgJpov1fjcWBq/rKk/3jqYipmzc6rlEyK?=
 =?us-ascii?Q?bF1IPWSnNiF060HazSJX64bfDIto5zQYmBDumPOcGMDQXWQ2jQUdPy/0ZKD0?=
 =?us-ascii?Q?+fdNh1/EAcWaS7raEyOimBKYpvDxVND4ZP/vUgRckPrq60vsSlfWXZABq9P1?=
 =?us-ascii?Q?opO/9GXyjl8ysSh8Fjy43H3GMB5s3oVrCMv9KsvtgBE/GfmRewlkRvhyPATo?=
 =?us-ascii?Q?DUCVgy1tAzvFKpzIH5FUwihWG28F1+EXou47vfezImI4KVte8e7W5UzvYBJf?=
 =?us-ascii?Q?Ro2JBcY3Tnx4dKB5RcBr+5UiOcWgD0YEWh3gpQi9GINmJuUIxtOrv1R8mzNQ?=
 =?us-ascii?Q?STYumAcl6GEVLS9lTCu7SaeJKfOLtemK8rcZxJqVK7Wn4y9PAvc7JoZfGWZe?=
 =?us-ascii?Q?+IJvdca729hvGK9HjKqEQa9PgUHRYLNSA3egjHir8HjsUSVedgpU4sgh1FZq?=
 =?us-ascii?Q?zV9R4kI6mr7KnygzzLcibYmWRygJzhGHzGkD7x+bWKFOK0xYljRjenCu+yd4?=
 =?us-ascii?Q?IOLpnCUO40rfA317W4k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929f9f81-55d1-4275-064d-08dcef7c4869
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:53:45.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jw7kfxlewsXL9+Jw7cC9lOVsvYM7ZAzQy7MROL9+w3xJjhup0DOOCn46kWdpjur8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798

On Wed, Oct 16, 2024 at 12:25:03PM -0300, Jason Gunthorpe wrote:
> > > smmu-v3 needs some more fixing to move that
> > > arm_smmu_master_enable_sva() logic into domain attachment.
> > 
> > Will think about this, Thanks Jason
> 
> Can you test it if a patch is made?

Here it is:

https://github.com/jgunthorpe/linux/commits/smmuv3_nesting/

fa1528253d2210 iommu: Remove IOMMU_DEV_FEAT_SVA
5675560a272cf5 iommu/vt-d: Check if SVA is supported when attaching the SVA domain
94bc2b9525b508 iommu/arm-smmu-v3: Put iopf enablement in the domain attach path

Let me know..

Jason
