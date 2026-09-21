Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012023.outbound.protection.outlook.com [52.103.10.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5874A093D
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999173; cv=fail; b=OUKO9jHpAfaNkifXzFDm04lqzw5u6YueSE1vvaQuxfObVQBZaJ/1R9+La4lau8IqBuLfl3NO+ZnLPYUmollEpEHBuGlqNqY9BAgfupQNoagllPR8N5qZh52piYide/AoM8SaVNAywDS7NyaqdUG94W4ltSiaFtrb2VDu/Mill7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999173; c=relaxed/simple;
	bh=7GkY4vP9i+C5sm2dA3sLhX4sdgPKxYV0HcIHRi/JpDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cm9eKKm3vvIkb3vMmAypIomZhrtEJ3eSGusw0nGKAWajp2VMJ9h1zdu+wpi98LqbI/6dOtjLe5QxbAY6hC8wthjqJweg/4cmOaZCpdzPipW57/y0ZT7UeE5ho+fACHgTMVKFLBHRRZx79YnHoxX+5PAZZoR4uzBdtO0qM3k/i/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P4a3vcPZ; arc=fail smtp.client-ip=52.103.10.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P4a3vcPZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee/XE/iHhGOGhF1S1mEUBEw4zrkP8pjL+qSEyr4KgEqjJ0l1kUUEWyCB95tQPNM59rqkiwrr8/pjZLlb6vXMSlIXBzeqJMr4lhhkCjKeS+P0JlBo3SiF5A07ovuGc9fAW4GG/5JOgU+a8hWPmpzkV2ugTP1JV08SHV5TfsUhcaN4C1jr9AamQNCa8paGbBmzE7GhnjZ+thlIq28AwWmAjZXtYjIqUR9H57GDxDnqAFsAN0tq+NbD+06WGwbVcLAD5aNE4mbf13ernkiMEnDuJSs2t34OxF+bna7jBqYeLcb4oTEaP8W8NkOayoQgJ89Knr2+307NIAul/jeC4EpIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL4ZdK8AUnq/CagraVKaEOD57HNhxdY9hysb0mZBhTM=;
 b=t5dWRcAYbhNP73Pu/n+hPuilQQVqVViJJ0OqnwXSi0QOMaP7b9sc/IsTo1a7sDKr0GYjZWPqxwXyfod9J1QHy/3dl8WT349NsPRskyd64K5MB9MvwbtKw54p2QB7QAGpVJj9V6/y4ab4BfYCGpk7xbvwwgod1dCvkJvP7Z2o8dHR8l9wl6xs9qSMw69tPk0wum5EGh58F2OdwzZNUSXobiRpBGI97tzUbwYb1f5xsiXHvgE4LAFRjTg4XyHw4DvvOYbeV9OVSknZdS5E455CjGs73wMh+HVDbP/aJpPjP3l2VkpskRSKX/BWOrlTSOTyjdsrVNZrMzBxPpH6FReA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL4ZdK8AUnq/CagraVKaEOD57HNhxdY9hysb0mZBhTM=;
 b=P4a3vcPZeWjfTd7qGJuFSIPirF73MDiKakVylcDBEV1K7Ks/Yc4Ggy5tpaX2bUWvoIweP8ZdK9ULwkr8O8NBRUrdIgzwuJE7CWsSy0I8Fx9D/wm4tK7fqREuIn9H6JSqmPfaSyBhGgTmIvi5PYRX/v/Sibx51bOfs8DP+u7JAjpC/Ax3Wwe2zMXFnkZzForrznw5e1pbbLKlVDqzvL50SCixooB41yUV8icnMnZ6SxvS1ForOsGSSXsN8hYYCaxHMnd6QzLoqeZ337zp++fAXWyCMIqEkRh7+TRh1DL1OvAFXoFL4cOZcKniNv9lV3vCw7cjJdVe/+jJbs1tr+ylvg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS1PR02MB10419.namprd02.prod.outlook.com (2603:10b6:8:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:59:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 13:59:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Zack Rusin <zack.rusin@broadcom.com>, Borislav Petkov <bp@alien8.de>, Ajay
 Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, "x86@kernel.org" <x86@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Joel Granados <joel.granados@kernel.org>, Baoquan
 He <baoquan.he@linux.dev>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, Dave Young
	<ruirui.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Bo Gan
	<bo.gan@broadcom.com>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v1 1/4] x86/vmware: Add a bounded panic log sender
Thread-Topic: [PATCH v1 1/4] x86/vmware: Add a bounded panic log sender
Thread-Index: AQDzRMZMPXW8diaCGPo9yW1hFxpnOwFlsqbluKHn46A=
Date: Mon, 21 Sep 2026 13:59:25 +0000
Message-ID:
 <SN6PR02MB41574A11D309A0530C63E0FED4842@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <18115e519d85b753c147b45470120721eaf14505.1788414671.git.zack.rusin@broadcom.com>
In-Reply-To:
 <18115e519d85b753c147b45470120721eaf14505.1788414671.git.zack.rusin@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS1PR02MB10419:EE_
x-ms-office365-filtering-correlation-id: 48ecb68a-5d3e-4804-b347-08df17e88bf3
x-ms-exchange-slblob-mailprops:
 YfhX3sd/0TWTq462A1ci1xfPBdi3ebdlDESEEZ3ciwWGdGunGE597jySxvEiJ5WDZKkW7Z50PFsRPjw8UH8Xp8qt3lU4X+89RuEP8ONAqOW/hEvpb5ljuH8h0rHv6G1qOk1nbIAGSUjtBZbxcQaF3OAVkAMoVyuesYDIEUGi2y8J44Rc/Sz7U01FrdeFnLAcnxzpOvhckzVksODHVUI6N9jiWxv8CgOGyZf2HdiDcOMcrgt3QvcHTSk9+3jizkJnlTJZiur0NovJ2qkYCk2TzHQMa+6GPhzUHy1IhVUDzebouu79PL+bkfWT6tAY+2fP/YZiiLRlwde4CnRzAaJfOWDEcNQZMjab9SLkt2NicJgwta37Ej/2x9fytR35d3nLSzFk/5J8rX2FwMKJZUfbYNZFvDXhHYx80xlX6ygolv//DTh9JwNMw1M4oyL4ihmBP6OJ6bToAT36LYNPCDDSaf7wjy68gKzTHWf5r6rw2yKQfODp8/JeCu0PEflY0DuI13yt26iIABMvpNs1Z+bDk/q2Ib/4dKMKyDKfRdLRC/XgE6/NfH/YAYEivkiKUrWxEJJIcULncS/jeWQ8uN6UJV4sCmyp7SXQ/cjYtmKqZUJTwWQOIotDtjwWraQPEg+PJks6A3H8VApxjYTpPcy9jmFixQ6ek4IM2ZBptMZ85BFhF+0JO5VfCbOa6KFozKi4bPgZkkXPNqAv4Fk7Mh33COXOXoniDTEdeboTmTbV5+x1ELmjMBQSrBZMjUYbZVYrTyioUfTshjwlOLV6Ki9Y5TofHV6rD1r1dvKCJ7hczrY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|25010399006|4140399003|31061999003|37011999003|55001999006|24021099003|13091999003|15080799012|52005399003|40105399003|41105399003|12091999003|1602099012|10035399007|2607281247196008|102099032|440099028|3412199025|4302099013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NobZbp/DHWCHMZtwh1YD62OaWAJxrXTAjxNlCVnK1ebuiGF5oz1Cfejcbw4r?=
 =?us-ascii?Q?pMj0+//iOIEiMEeTr3uwiDcccnPKXye1lgEvlNMyX+C9Rab36BdwjFetl6Mw?=
 =?us-ascii?Q?pEeM3iBaO/JdQj9Nl8v45gVdClu06UNocPjL0SgbGGqqafsdI4suAsuAkbxw?=
 =?us-ascii?Q?sTqToVTUZqW2BnYRVqgDQ9RnaOM3SPYxrKzStE1buHlPhtLDdGp/6Ls2d4b5?=
 =?us-ascii?Q?iawG7GalN9AwFMqKN82AUwWK6xhTguqjIEJ1O9FJzvG7B1uuL592BvgI1OnP?=
 =?us-ascii?Q?ZW2mI3RNs6fugsi4xjvylTHFN16XpXxRGslslpUgh10OR8k9JFm6AnROorNl?=
 =?us-ascii?Q?Ggh7VD3YZrBA0s1eEJEiCo7hUkDDAVv/giUOzzGAbw8mKqlhulJPL+NWRG/2?=
 =?us-ascii?Q?FOp5qd/HFacNsSdoOSNZVQKP8xOImOHrx8qNe2ERTERTBvZt2zXEaNAjhn09?=
 =?us-ascii?Q?K+Sfym/3MkPI3YhX2OCHDNba3la/JKfL7rH0GivUe9QwKxWQvlHBnoT29POb?=
 =?us-ascii?Q?xv8pwIL+pUZzr4RxKWxsnMUwzb30YM7azxGgPmT/NQag/20mRnDJvgEnSdx6?=
 =?us-ascii?Q?5HqFx5h+1Dw7jBdIb/7B7vfBK1F6fUugo5HljYtXdCWOb21sed0qjz1yLozh?=
 =?us-ascii?Q?7DGMAMiZBEbiTC6D++RGteaUdNZNWzdCro9mdatn1hR8rZbUOiDyfKAHIdG3?=
 =?us-ascii?Q?Cbr9RH22Er5/Sq85KcS7L3v7H8RZTHYBqKjzJSCSJlOYippBgXetFyfIIL6h?=
 =?us-ascii?Q?8wdJv1q1PB1w/tBOooZI4GUrk3LjDoLUUM6yLKJveQV7pdzTKL8CuhhX9UvM?=
 =?us-ascii?Q?qXJnTAaIqYA0enBYV0V+cEqn5TquufefU3EThOnzMZQg0hS+tIzLFKP3m9vk?=
 =?us-ascii?Q?0v9IrgVJtkDSgPrdstDIrQOEmJtmHcSrG034QUL7e7u7PvyFEXBVAEaDw09e?=
 =?us-ascii?Q?Ln8IQ0H79rWmrToQAVFqBmmyk/VrGRBHjuNHqibRa45VpshAi4ynBKVYfcWs?=
 =?us-ascii?Q?v76Wn2itpQKrgRXW2UkncyT4J3huE6hXvF7gf9rjegfU1+t9yih0a+kmUcdQ?=
 =?us-ascii?Q?8O3a6bQMkC1n/4R4M20ejRNxTKi/l9HalOnTxTqNv0vfpUYD0M2/Pmyoio0Z?=
 =?us-ascii?Q?4uYPNZJGiA88HIkOGWJteoRkkeXdCrxsDA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tz2LNnjhxvG/xaIR+ePFaJ1Ihsvuqlof+Ql4UW0EAF6tF1+NV0RGWV38wEZT?=
 =?us-ascii?Q?1tqKB+R/anZXzvm3oPvN3quztlFzuaLIdS2G5ycxChy3oNsN4YB8GJtUhDvX?=
 =?us-ascii?Q?DuREZPAWa/OGhDBMS4A/ATKrQydjgZ75AV/Z55RqHTddR4JOF8dnEQa8/GxB?=
 =?us-ascii?Q?kPoKvBMrnX4uaddDY0rVtJ2IIDwx6SlGkCrLPqe3FOKGyv4cM58dLV3JFMVr?=
 =?us-ascii?Q?Egj8vonwX1rbnEpImdnX3LRhFR4aCBvtK9T5dZuuNjGDfGJy4MYyhv5nJjCZ?=
 =?us-ascii?Q?JuEwVdQ0YQ6VSA4XCW2ZE/l+KX/ZNND8MRt1syCB+1xECOAOBx4oPG/n6j0g?=
 =?us-ascii?Q?Q6T6ZtGoHa6vVUmSnF52D7VVGrHhEzgU7ovtTdOLt4vav8p6SpCK59b3lgd9?=
 =?us-ascii?Q?0s2uB7CR+DwW7N2ghLqHfEvmDzfDjbCHxhwK1uy1vHW+Vksp4OqdWIziBDbm?=
 =?us-ascii?Q?UAp63s5HaayknGt7/v3HfoAwYHa5kygBZhTY18qN6xfSeQoljrgbF2rcdlWd?=
 =?us-ascii?Q?lB3JvKZxXUAhVHSQbeWRtMfCqgwC1uvyRjJqNQHcNbUgOvZbln5bI+BUpoAJ?=
 =?us-ascii?Q?9uzkQ4vt/KNhcb6jaRyACrqi6WPvHyo8LnsNEirPM411LuKYkdkeRo7TcGiG?=
 =?us-ascii?Q?OHKfKDCd166r8f+G0CBxEP8CLSwb3VsYK+zd3bXDPhnKLMQ6cv/wBD8wW0TL?=
 =?us-ascii?Q?f54voAlY6AoIoV7pHEGAn8sa0G/iMBQTdNVr/MfkASbxrf6+Gmk8y88zZbSe?=
 =?us-ascii?Q?MFVBHy6FpvrxsNOZK5if6zZuQqSkboPHqIzvZrwmASNMpY46ILNqM3jL0Z+G?=
 =?us-ascii?Q?sdoZ68YtfzsoQHN7rBEM2m2sGLch18jvfoiMpYv6Vn8cDTLjCG6dUVLiO9Qr?=
 =?us-ascii?Q?EYRW+44m77xH8gsRHHqgH3JJ31kFemJU/kCdkYOTrF4QC2K9m7lktlg9W+Dz?=
 =?us-ascii?Q?FmhQOl0XDEgPnhCIifLZv0k1Sm9ilNVSWv9Gh3UuJo87Jf79lUU/qLSfD1BF?=
 =?us-ascii?Q?QEIuyYR8qhIo+akGQCN73Vdtnq9IHSQVjOnGI6OAn7EsC3cWHcir0FdfSEV6?=
 =?us-ascii?Q?vSoEacjB7YSipBThzRp6Kv49nr16GTgnCwUTRwK3/c0mBVnCDMRXcLr3zu53?=
 =?us-ascii?Q?t1XzUc4c0I8UfXfSVWy8Rof1Gcv5KbUjA93N+3oDyPq1IaPpvR4fOuKqIVCs?=
 =?us-ascii?Q?q/SIU8EmN4TYYDkXL1hxR1IMTFACYEFeo300kWPh2fC3TjCrKigVj78FAiLX?=
 =?us-ascii?Q?S6Kvpyd3ISWPiY9xiVTIYY1jD8aLc0yspxa1NPQqjh/FFlJa80bJ6jjBasSZ?=
 =?us-ascii?Q?XB31nCO9oNK+arhGAtAOo/UVB7pyMlfJKwfiTu8mYahtFx3o1ZH8pWNLaZBi?=
 =?us-ascii?Q?cOT19KM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ecb68a-5d3e-4804-b347-08df17e88bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 13:59:25.7501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10419

From: Zack Rusin <zack.rusin@broadcom.com> Sent: Tuesday, September 8, 2026=
 11:07 AM
>=20
> A virtual machine may have no guest-local persistent storage or working
> userspace after a panic. Preserve the newest kernel log tail in the host
> vmware.log, which remains available after the VM terminates.
>=20
> Allocate one page during early init and register a panic-only kmsg dumper=
.
> Copy the newest records once, prefix them with "log ", and send one
> explicit-length RPC message over the low-bandwidth register path. The pag=
e
> limit bounds panic-time work and avoids sharing guest memory with the hos=
t.

Hyper-V provides a similar capability to push the newest 4 KiB of the
kmsg log to the host so it is preserved after the VM terminates. I've used
this functionality on many occasions, and it is definitely valuable. The bi=
ggest
problem is that 4 KiB is often not enough bytes to capture the most relevan=
t
part of the stack dump that's created by panic(). If you can expand to 8 Ki=
B,
I think you'll find that works much better. For Hyper-V, we're still stuck
with the 4 KiB limit because negotiating and staging the expansion with the
host hasn't gotten above that team's cut line.

Michael

>=20
> Keep the source immutable for up to three attempts. Retry only checkpoint
> responses, zero-fill a short final word, and close the single RPC channel
> on every exit after open. The panic callback allocates nothing, does not
> sleep, and emits no printk messages.
>=20
> Free the page and leave panic logging disabled if dumper registration
> fails, including when CONFIG_PRINTK=3Dn.
>=20
> Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@=
broadcom.com
> Co-developed-by: Bo Gan <bo.gan@broadcom.com>
> Signed-off-by: Bo Gan <bo.gan@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  arch/x86/include/asm/vmware.h |   1 +
>  arch/x86/kernel/cpu/vmware.c  | 158 ++++++++++++++++++++++++++++++++++
>  2 files changed, 159 insertions(+)
