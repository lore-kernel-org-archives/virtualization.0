Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C145BED
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115692; cv=fail; b=XsQo4EBMv+KtjBngMF+ao4KZrZU8mdo0PGq79g5THDbuIgreRP13mhTyr1eJbyxAetJZseQiu3/e3RiF1aCiB81zh1VjWG0GIE7TbrNACS4fkaiy5P4kthFqAx9t08ro2I3W2uymZNYbphMcOXLnya1TKB5+Bedmz8edhbmvy+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115692; c=relaxed/simple;
	bh=Y1jW9I7KO4EDXiMzkY1qIcU9Q1FSciDNH78ho5O3RSU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RbvkbX8Gu+cKxFHLA6HSeQOoJD64ZXcEX0xcI+d3hUUBx5KThCNxuGDmx5Ak/RxlTs0k70/DrOgKDyNqt0ouhfrN6at39dMj6Povf66x+TBwnC5IgUzzaoWYV/BrK71LWB9nQSK39IUnsKA38N9P52AaAHOvFqb9Qh7YWkVOoWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=LRDjXvRa; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="LRDjXvRa"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4093A82560
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 13:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.001
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7N5yZFCTGiZ5
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 13:54:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2612::701; helo=eur05-am6-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BDC9182531
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDC9182531
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=LRDjXvRa
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::701])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BDC9182531
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 13:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ1F4S+XSCDhlJ1zJgbzwOTaeUq+fRESISVenplJO4yAeA14+p7Pu20rh5PbbfDeVwayQX+Uk12OXDWsi/rKmR6SaShJjkJj1yQ/PeC4U7wOWWz50k7hLYgEpfIGQ28xeicw9oV6AunQdcTq/A15qe3XIgqD+mLnIXIZHsXk+GxdZJv1kpIkTTNVPAJx/X1eBnIpmErhi3zQ3jjvIChHtwSza7EHRrz+WU5G1ec/+s+gwI7lqy8fOrG3bFIamsc5FhgXpUFbvV3lAJ5YdeqGv5F65p+nQtoci5/0OfY7AgOoSWyWOV+rvi612IBdeYG10jt7FSfL5MSK8iGrYSf9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1jW9I7KO4EDXiMzkY1qIcU9Q1FSciDNH78ho5O3RSU=;
 b=OvEfYELWSnEph1oVfOsEyQQuzFTW/Te3KgtfmnRSqJkLh1PrX4ilpfKzWvbhm/OngKQm7R0zXoUFI8ZkcC3b94heAv8dUJ/Pf78To3QC+qDCjDALUmuwGtLhUV6wr6fLEdV46rnJUDEgKnbQP94p/jUpRUID0fOKWp5rTdRF22/AubAINqZ1vVKRzEj8HziFYbzHsUYMrdefg7m8ChBvt4a3sQ4LBwe1rhoiQ6w5NdLwgdzAdwH+YCZPy/GuATzZAtX3UFAwDZ827nWV6G5shcPgLNKmQTidvAXANIWjQ/JPAE0g8Y6hJwkK/sJDig7389QYtGuZFjV4KILJaM5kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1jW9I7KO4EDXiMzkY1qIcU9Q1FSciDNH78ho5O3RSU=;
 b=LRDjXvRaWjiJ0EL59UrOCJH+gyLZZevCFmw1XEwRWkc04G4ksQubnLKmdkqIsypxbNML0UhniQMRbsf5amBs+6veUoOLK9HosnXV1CI2wSM6zF/fRAhBTuBNQUVUkW6Han2+5SwbXmtAIpnvoALVlg7mZN+vZHALndP8ROj18pE=
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17)
 by PR3PR07MB6809.eurprd07.prod.outlook.com (2603:10a6:102:7f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Fri, 22 Mar
 2024 13:54:42 +0000
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::1a84:daa4:7969:dd41]) by AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::1a84:daa4:7969:dd41%5]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 13:54:42 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: Call For Nominations: HPDC 2024 Achievement Award
Thread-Topic: Call For Nominations: HPDC 2024 Achievement Award
Thread-Index: AQHafGB9SPb4C2Qc/EyHMyu5EaBgVw==
Date: Fri, 22 Mar 2024 13:54:42 +0000
Message-ID: <9C8FC14C-0518-4648-943D-EB3AA06F2430@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR07MB8408:EE_|PR3PR07MB6809:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MoKiTz9NvZWiHCMDGr5qxeIKz5i33Obl/EirDNsTute9B5HTM/VEZ9bXIUs/WFjkCkkp4d18ULsjuvIV12n/mkZ0Z/5E9EvXUEnAnz+kmYivRdYbxNrSy4Xn9MYROo9uMNlbcpaX5eqeyTc2/8FrDjhiAqJCwaeqF+ODmA0v2ZzzTB4Mr9BihBkFhSL8RDBteDyOZT6y21r8jFjIY4JFr/f18HgBzqtMYX1rYqNXE/h0cGuY4Eyz2DdV0YJMNfBFFKt+YgKZvBXFQzWgGB0teLLIDFWzXTdmJMKUAiettwgD7+N0oifd11D8vn66dmhbDPpm/fcHRvAOJI3c7Rb0lC8TU0UYrnzK+7GM/zXruXfSSUAQxV3a1XWIS02/ym2pFFdqQ10p71I25NoRpzQQnKwqqD2slNX2TdGbUaP8VUql6LsAAX/3bXsCXP4za4CUN1z0OEPkiKuDgLpp4ur31Ar4YismuUQTAAYjOyeQtA7gF9fcqBiXnCDYluZZMtngNGJFL3b0/+QXzxzCzxX/39ylbwSvWExDOMBoELzuCrI3YX6m34Too0KqvMwRG/RcTClEse7nbIpL2Qs31iODg1ztUdXBt5DCpM5FIgPaUIf2Gq4z/BpSib6vY5d4z9Khft4H+lo7ncA3MPW0N2H6wCL38AxWxSszEHF3/YqLNOw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR07MB8408.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tIag3V+1JTA56pRSFAcX/KdIw0JE2eEYqTW+Fk9egAYGAoazMqXrQO6IxcLy?=
 =?us-ascii?Q?fkl4XIgVAg+AyOWkWEzbZ95R4/vfaeS96ePq65B8Rxo3gbKFKUYk0dILL8SL?=
 =?us-ascii?Q?o1AuSyjQfomr7xPwPeIYd7ABlVSNaJumy7n5rw9JQdhgNR012p/z3ypkHljf?=
 =?us-ascii?Q?ZJmH23Fb8M7vvx76WeJbCpZUSNGUEGYabE/L+FcdrkuE8DXhCwbRG6fPrV2j?=
 =?us-ascii?Q?aaPuik/6pA/v6NZcktKFpXf/urxJuxyT+fpQWdQwYVlvtWCS1RlOZwhVwOHK?=
 =?us-ascii?Q?pzlpDe88pgWEmpMG3Aql53UDCxZXEzDQWRsM1uni/ND6bUh5z5kIK+smjX3X?=
 =?us-ascii?Q?dbzvVP0R92ROUaOm9Gc5vzt6ys2F27KBQ4O9BLAnBavHI3nijwG11iTfDxCZ?=
 =?us-ascii?Q?DyuT44Bjijc9RiKlh4e+Ip++Y3FvBK3F3Oi402BOFZc8ttKs04tfGfUV04bG?=
 =?us-ascii?Q?NJf4rHlvGaNTSGuwYN5jefcgKj3qEy+0ZrQrFg5HtKEod3FFOIkntz0gtLt1?=
 =?us-ascii?Q?JaWh1NrCyh5YB+qJnTCQS/l/ArX+/MfGK293Gx8MrkDCNwG49RYDHz0ilvY2?=
 =?us-ascii?Q?BR58I1aDpuGp1pXrafkH/SZaEMI6r8LcC1DIDwqTy68YELgquGLPhIko2iVu?=
 =?us-ascii?Q?af7UBZEO+cpkt4Fih9HMfrETyCsEVjDkCDv+Fjp1VQ5zl7540XrhPUgtjnO4?=
 =?us-ascii?Q?M5FK74RS2IN3L1Y2YOMYEzpVS2MwIK+layP+nP1dcgvbJfDCEkgQduTjjYAL?=
 =?us-ascii?Q?NxMc396RzqMP0OiEAWc+OYuXuq+2bmX44lvDni8RqxfR+J2Q+UxokXaallA4?=
 =?us-ascii?Q?rF50BNkhdOb/by54AiYX1h5zcg4KYDity0BX/vQ15bgqYn5pmLROzT+yD0bg?=
 =?us-ascii?Q?bv6YNOY1/bAZrM37ic5PVKVnbRSZXNbgPeKugEgm1k36Gy0PQ4zkwUSoLI49?=
 =?us-ascii?Q?lgwYCzF3wRxMrvgVCmU23dJZTq9vtVaM++goojay8ih7ntbI4iGn+9NCX/JN?=
 =?us-ascii?Q?pvm7mFM7Gor1BczEhUbdh9swHBYE5T2E1HCIlGyz4nUNJB+dsijlCQ8Zz+Rp?=
 =?us-ascii?Q?jXgFBl66KTNwDBpMIviICD8DA7G5UPQ5nREosjAOu3tIPznVaEp0cVHVxWQ8?=
 =?us-ascii?Q?uMfkM1bRY3iBUziY+qNJ/rQ/zE4BGx2kbwSugVk2qgFeAYpFsT1l/1e3sTDg?=
 =?us-ascii?Q?5MRZSopGDrWZprpMytZCGDAQXoHYr0k7n/uDd3K4FX9zU18wBRG1OUg6ANsp?=
 =?us-ascii?Q?GNUsbpWAcsv2V5o5A1CJtCNSZ8QTxjekt/Zdt6oERhEPMEszEqXvrmROepEc?=
 =?us-ascii?Q?KJKTxznuYrn0mMxWPGRoPznZABRHwo/XrGsXp2cOKWUOP+Cg9p3XRHna1rfj?=
 =?us-ascii?Q?9z92m7KvjbK9e0mNJrtbGt6HLxslZkmPOZ/Luy8vFfKDjYPvC5OY5TZk+0en?=
 =?us-ascii?Q?FqsaEPLW3eQlNpabJD/54fp413i94frKBotLp+J7yrcl18TfaDWici29L+n5?=
 =?us-ascii?Q?0tUGQZTkLIm3SMnJxR5N7m9qq6OEkPGLv6CPBRwfV4xrLJloD2zZChFniodO?=
 =?us-ascii?Q?Te7dAmqNUIdypTozfJfbzjYIiUa05LPj0EXbatjNZrssygcBPgtdrDo3K5o/?=
 =?us-ascii?Q?vWlDD5e7+uYi1XcDJYW+Ged6RFp3IqqkMh+925nedrrM?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D9F6BB3ED304E4EAED056E248159814@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: phd.unipi.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR07MB8408.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67093ada-2cc0-48cb-8fa7-08dc4a77a006
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 13:54:42.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MO8Xhd0epgMqxhhjr9V3WOVHhVkgpFfi+8zqXzkTmJCtYB9wdvucfnmhHagGrUycOwO/Yo1FTINqS9nt7Jvatcu5YCPZADs37zK2ul1IjIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6809

Call For Nominations: HPDC 2024 Achievement Award
-------------------------------------------------

In 2012, HPDC established an annual achievement award, which is presented t=
o an individual who has made long-lasting, influential contributions to the=
 foundations or practice of the field of high-performance parallel and dist=
ributed computing (HPDC). These contributions may include one or more of th=
e following:

- Conceptual advances that have influenced the design or operation of HPDC =
systems or applications;
- Innovative techniques or tools for the design or analysis of HPDC systems=
 or applications;
- Design, implementation, and deployment of innovative (components of) HPDC=
 systems or applications;
- Analysis of innovative (components of) HPDC systems or applications.

In selecting the achievement award recipient, the Award Selection Committee=
 will place particular emphasis on seminal contributions and a sustained re=
cord of high-impact in the field.

Past Winners
------------

- 2023: Manish Parashar for pioneering contributions in high performance pa=
rallel and distributed computational methods, data management, in-situ comp=
uting, and international leadership in cyberinfrastructure and translationa=
l computer science.
- 2022: Franck Cappello for his pioneering contributions in methods, tools,=
 and testbeds for resilient high performance parallel and distributed compu=
ting.
- 2021: Rosa Badia, for her innovations in parallel task-based programming =
models, workflow applications and systems, and leadership in the high perfo=
rmance computing research community.
- 2019: Geoffrey Fox, for his foundational contributions to parallel comput=
ing, high-performance software, the interface between applications and syst=
ems, contributions to education, and outreach to underrepresented communiti=
es.
- 2018: Satoshi Matsuoka, for his pioneering research in the design, implem=
entation, and application of high performance systems and software tools fo=
r parallel and distributed systems.
- 2017: David Abramson, for his pioneering research in the design, implemen=
tation, and application of high performance systems and software tools for =
parallel and distributed systems.
- 2016: Jack Dongarra, for his long-standing and far-reaching contributions=
 in high performance linear algebra and large-scale parallel and distribute=
d computing.
- 2015: Ewa Deelman, for her significant influence, contributions, and dist=
inguished use of workflow systems in high-performance computing.
- 2014: Rich Wolski, for pioneering and high-impact contributions to grid, =
cloud, and parallel computing.
- 2013: Miron Livny, for his significant contribution and high impact in th=
e area of high-throughput computing.
- 2012: Ian Foster, for his initiative in the creation and development of g=
rid computing and his significant contributions to high-performance distrib=
uted computing in support of the sciences.

Achievement Award Talk
----------------------

The award will be presented at the 33nd International Symposium on High-Per=
formance Parallel and Distributed Computing in Pisa, Italy, June 3 - June 7=
, 2024. The winner should be available to receive the award and present an =
achievement award talk at the conference.

Nomination for the 2024 Award
-----------------------------

Candidates may nominate a colleague by sending a letter in PDF form to dtha=
in@nd.edu. Each nomination received will be retained and considered by the =
committee for three consecutive years. The letter of nomination should be a=
bout one page and contain:
The nominee's current professional affiliation(s).
A brief citation (thirty words or less) precisely stating the most salient =
reason(s) why the nominee is qualified for the award.
A description of the technical contributions of the nominee and their signi=
ficance and impact.

Important Dates
---------------
Nomination deadline: Monday, April 8, 2024

2024 Award Selection Committee
------------------------------

- Rosa M Badia
- Patrizio Dazzi
- Gabriele Mencagli
- Manish Parashar
- Douglas Thain

The award selection committee is chaired by a member of the HPDC steering c=
ommittee and includes the General Chair(s) and the Program Committee Chair(=
s) of the current HPDC conference, and the previous year's award winner. An=
 award committee member cannot be a nominator or be selected as the winner.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Alberto Ottimo
PhD Student
Department of Computer Science
University of Pisa, Italy
E-mail: alberto.ottimo@phd.unipi.it
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
