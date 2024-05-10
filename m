Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467B208B6
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365220; cv=fail; b=NZy7hg7Gcuo+ORjtmrLw+86o/tBe9EVUURylFvQvHINStsoWfc+kTtS0AZ4Q1h7f7Yb3j4eNVi3Ajcdq4kV1J09J30SkcvwgxtOFaq9BGl11So2kh2bhRxlIHhz8RqV9MjWfFxwEJlW5Fq7w2yCxS+3tumW1/1CxDjsoh0uch7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365220; c=relaxed/simple;
	bh=353mDw8hiS0yTKfhcZ2L/4Rs1eZNwi5pqSruXazFJqs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M1Gpg5LfV+DlWT5wjdlu2NHt4F9EpZ1CiHvZ0B/TM/uQ97V4dtubohphMm+JPjOIZf26olFoV1IeJxRn+r5Rd7KX55DWd3j45aDuCY9KkTT535+dehRQO2pgh0Nyrf4z4yUbgYfH9ienz1uamxKCNmuUEzZeiWR6A5t2t6yYZLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=orOubCRN; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="orOubCRN"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A70B84660
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 18:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.998
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzJwOW53u0z0 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 May 2024 18:20:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajvega@us.ibm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 46C8E845F2
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=us.ibm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46C8E845F2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=orOubCRN
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46C8E845F2
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 18:20:15 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AHxirl004329;
	Fri, 10 May 2024 18:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=353mDw8hiS0yTKfhcZ2L/4Rs1eZNwi5pqSruXazFJqs=;
 b=orOubCRNlZ8kbAfV9c5Pw9dYBHeK9YGxXyn8j/hf7dM5QBu9OWKb2dRVW1galIbRggxA
 LkyXtC/QNQ9QL3rLylyGMHBdfLzNnCH2w/vOTJ/qrH3ZPf0Gi493Qd6vn/pS2gfD0CqN
 8WNeTdjPkh4YZkJ/Nfp9EomZHXxoYycsZqaOMRuIt8YG4cHxfGsXvrMsJd5U7Kxh+jCr
 Tr+JygmGvqjS5idn5jCjxOhHBNWuC1xIQXZ7rZHeiPZn/Qfq7/jmbLj47c4Q1SsF2QDB
 3HVSm87fooQDLOTXIbTQ/2aStP5D7Pq0+X2DRTEDlz1uldwpH5H3zO5PDRYMlhDPTK8l Vg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y1rbu81bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 18:13:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMoEkKUWrbcHcFxlFKl+duKg3TMsNqSAbwSNgjY2Jf9G+pwAvYcvFXDseO0pUfZDxvTeiATZ4gI90e3QCEDpfXA2RXmSPasA9dsog4h23JzKKwQlbD5Unf6evMr7VhZxX9uRpp6dlszqpNGGpriLB5/icooUq/5Z5IudKlCbQ2uH+IR0c0c1kwrJVhBUxznronxcjt25aDL9Dl7jCC2CnSq7abx4gY2jVTHo2ORZjc9v8FormwtuFdyaiZbMoH9m2Sj4Tj2HVvuyJZ/xANFeVe17md7p13MqVvSN9R4bZnkT0t5SIhwjZ/qhMaqZkookWrxxfoS6UXiF6N5szskE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaRAU6M4G0fKVt72AWWREIjkMTDvIwXPIkF5zpPGWc0=;
 b=A0eiWS20kh5RHfuv4653ZQQnkxYxxJT4bAArR+igqK/EEIJw/aMf+mUFbASh2BRRfuG+/0HQjXRjjfkWYiY/E4sOQYSc3gFWLOPDEHEQ7k/3uRgJzd/Jk5WaCNQq7H+kxwNNc7X4BmCMcjpxYDrG1u0aYcNvXG3M1Vz7hBqH9IGdZrxXuur0j4oOHGCU8IMMPf8gTSywL8ETXwMAJKanFsePZ8qIoeWvQgPoGcnvS9N9lioYIl1tEBwhzUmqVeBDeQKD0J5pzJu+1h1EW89ZuFg9celz5XR7RQV/6obY5vK4hVG8ycMjCh+tD3a8/8crNjvQjp1MYqhyRkJOhP4gVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from PH0PR15MB4448.namprd15.prod.outlook.com (2603:10b6:510:84::19)
 by PH0PR15MB4704.namprd15.prod.outlook.com (2603:10b6:510:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 18:12:59 +0000
Received: from PH0PR15MB4448.namprd15.prod.outlook.com
 ([fe80::96fe:5152:ac77:216e]) by PH0PR15MB4448.namprd15.prod.outlook.com
 ([fe80::96fe:5152:ac77:216e%7]) with mapi id 15.20.7544.049; Fri, 10 May 2024
 18:12:59 +0000
From: AUGUSTO VEGA <ajvega@us.ibm.com>
To: "conferences@newsmaster.tgc.com" <conferences@newsmaster.tgc.com>,
        "contiki-developers@lists.sourceforge.net"
	<contiki-developers@lists.sourceforge.net>,
        "cphc-conf@jiscmail.ac.uk"
	<cphc-conf@jiscmail.ac.uk>,
        "csc@lists.purdue.edu" <csc@lists.purdue.edu>,
        "DAI-List@mcc.com" <DAI-List@mcc.com>,
        "discuss@ieeetcsc.org"
	<discuss@ieeetcsc.org>,
        "distributed-computing-announce@datasys.cs.iit.edu"
	<distributed-computing-announce@datasys.cs.iit.edu>,
        "editor@hpcwire.com"
	<editor@hpcwire.com>,
        "end2end-china@netarchlab.tsinghua.edu.cn"
	<end2end-china@netarchlab.tsinghua.edu.cn>,
        "grideditor@gridtoday.com"
	<grideditor@gridtoday.com>,
        "GRUPO@gsd.inesc-id.pt" <GRUPO@gsd.inesc-id.pt>,
        "hpc-announce@mcs.anl.gov" <hpc-announce@mcs.anl.gov>,
        "icec@listserver.tue.nl" <icec@listserver.tue.nl>,
        "info@autonomic-communication.org" <info@autonomic-communication.org>,
        "INVESTIGADORES@inesc-id.pt" <INVESTIGADORES@inesc-id.pt>,
        "iot-edge-cloud@comsoc.org" <iot-edge-cloud@comsoc.org>,
        "mmb@ira.uka.de"
	<mmb@ira.uka.de>,
        "multicomm@comsoc.org" <multicomm@comsoc.org>,
        "NGN@jiscmail.ac.uk" <NGN@jiscmail.ac.uk>,
        "performance@merlot.usc.edu"
	<performance@merlot.usc.edu>,
        "planning@asu.edu" <planning@asu.edu>,
        "podc-related@acm.org" <podc-related@acm.org>,
        "publicity@hipeac.net"
	<publicity@hipeac.net>,
        "remarks@psc.edu" <remarks@psc.edu>,
        "SIGCOMM-MEMBERS@acm.org" <SIGCOMM-MEMBERS@acm.org>,
        "sigcomm@postel.org"
	<sigcomm@postel.org>,
        "sigmetrics-bb@merlot.usc.edu"
	<sigmetrics-bb@merlot.usc.edu>,
        "sigplan-l@acm.uiuc.edu"
	<sigplan-l@acm.uiuc.edu>,
        "SIGSIM@acm.org" <SIGSIM@acm.org>,
        "socinfo@cs.tut.fi" <socinfo@cs.tut.fi>,
        "spectrum-webmaster@ieee.org"
	<spectrum-webmaster@ieee.org>,
        "storage-research-list@ece.cmu.edu"
	<storage-research-list@ece.cmu.edu>,
        "tccc-announce@comsoc.org"
	<tccc-announce@comsoc.org>,
        "tccn@comsoc.org" <tccn@comsoc.org>,
        "tcsc@cse.stfx.ca" <tcsc@cse.stfx.ca>,
        "tfcc@clustercomputing.org"
	<tfcc@clustercomputing.org>,
        "uksim@glam.ac.uk" <uksim@glam.ac.uk>,
        "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>,
        "webmaster@ncsa.uiuc.edu"
	<webmaster@ncsa.uiuc.edu>,
        "hpc-announce-bounces@mcs.anl.gov"
	<hpc-announce-bounces@mcs.anl.gov>,
        Socinfo <socinfo-bounces@lists.tuni.fi>,
        "fpga-list-bounces@mailman.sydney.edu.au"
	<fpga-list-bounces@mailman.sydney.edu.au>
Subject: IEEE/ACM 51st International Symposium on Computer Architecture (ISCA
 2024)
Thread-Topic: IEEE/ACM 51st International Symposium on Computer Architecture
 (ISCA 2024)
Thread-Index: AQHaowV309gSZYir9UWzxGISivGQIA==
Date: Fri, 10 May 2024 18:12:59 +0000
Message-ID: 
 <PH0PR15MB4448B74C1DD9903472553359E5E72@PH0PR15MB4448.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB4448:EE_|PH0PR15MB4704:EE_
x-ms-office365-filtering-correlation-id: c1dd6866-c50a-4794-6bf8-08dc711cd308
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|921011|38070700009;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?A2QuuM41HfE1BEkm5SmCzcWqWobN3K3E649eMNtt601LiKOZZEfXyc+r?=
 =?Windows-1252?Q?A7Jlzk1su21gHh6i75WrfhXJiR3p0UZhItf9k/XXIBvsVG4ENmMsoAx9?=
 =?Windows-1252?Q?32s9IcmrkgF3Es4BJqseepWFmfHh9wcRudeys1t+K/66RrFUs3lyUoRX?=
 =?Windows-1252?Q?PXaC29T2XJ0hF5edYGT74TqR1JQ2gUtJmVNYe/wB6+rMqntsweHIcD5L?=
 =?Windows-1252?Q?9Kl+l2g2J3DTbWMoxmOzA6kxpl3urrYiVjlhNWFeXtbjMkN0/6FIC8u8?=
 =?Windows-1252?Q?BMVcabhg4v2TidLjTHkdTGTmg3TtzP8dpAH8QW/XM6/qbMwNK1fUPoa5?=
 =?Windows-1252?Q?gymR8GXIlbJK8+jD0ijT52+7iL0Y6cj1BykJ+y1cYII3sfv1GESmBZWL?=
 =?Windows-1252?Q?W2dEIhhjIsFQJrXU5fUmb9AFfR/ESqCk2DerbU7iqM1Aj02LJWuX0sd7?=
 =?Windows-1252?Q?T2gleNj2fa6MlkTXrjbcrhaBU4hYYx+evhVu9IlWmrsZb/31xjnAq/0o?=
 =?Windows-1252?Q?Y6YkUHvqldKwmND/y6d7gvyG2ekgWZIi/xlVeA1rsNG/7ya+Pv+eZfGM?=
 =?Windows-1252?Q?EdGsfOGjYJ+eTc4rHg6/UdvVgmTeD3aJtev3etoEGxQTcIeAyJtB39Zs?=
 =?Windows-1252?Q?NH+eVxkfNLBX7X+q5RLtHVpHooby/VwNOh9qotXBc1rHy8SuIbjusK4p?=
 =?Windows-1252?Q?30SzskypH1ci6iUusuUf9NcDU0ORhUTy1KNN8YZPGlK7gQ6vsa5kG3cB?=
 =?Windows-1252?Q?VSCief3PWoFfSJlUdzgtXWkse8blMxmsijAp56NWann1yIQhn4epIm2Z?=
 =?Windows-1252?Q?QxKBOnN8AJewqG0FgIXbsIrEZS5Ym3LYxQ/r5jGt2Ky+Cvqeo40ddX6j?=
 =?Windows-1252?Q?O5dN3qTvG7l8KkqijLb5IGYA8lGGS+dhoBV8/RNa+ny+EguSYDc+Br0r?=
 =?Windows-1252?Q?Ml0ywA5r2TYTAq3//UzhnAImDhC+eAvI22iyMtFhEnIOSm0SfTZqKN/y?=
 =?Windows-1252?Q?nTum3aLdHbPZruHfcGkYjxvYs6AgZR39Abut5SORK3Ze1B/BdsqVolcr?=
 =?Windows-1252?Q?RlmDvWSUUe6JNOi/4/cPe9zSoaT5jKGo/XZcUQ7Uj8Ie8Vt/zJqovMac?=
 =?Windows-1252?Q?Hr5PETmjRaymtbXnhl9gmVlStBV+3IrFj/v9hpD+XzQgtY5bxzCXrRoV?=
 =?Windows-1252?Q?W9IDKIn5sqEnfsYlXGakMUxhGxlgSqlbaDEIeMownbWGuQsjd6IJghB0?=
 =?Windows-1252?Q?CgCuOdGPqC+YmADtYMRko6jY25dvuOH8QaAws8pxL9tNVERF0nZXmcvq?=
 =?Windows-1252?Q?7hkxxBwO0xWYUuvZyfzvwAlSKGoe0T5Bu2FYFfPkGsfxMmRIy26MwChd?=
 =?Windows-1252?Q?g1WTOpjwVMdP3uEHEBLNwEWCVUsZlaF0uHI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB4448.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?GsCg9NXGWQJZ6PEYB9L+2Omb1jBZasWXXWko1BBlSxeSzdCGMnzL+0Lg?=
 =?Windows-1252?Q?9gOcFk7IP9jtC8Z7L/B9fTRcmgUTchYjizyolpPz6gewrPTky+Bqdslz?=
 =?Windows-1252?Q?vcx21hUSzUFZvgrdA0Oy9dmFj4CxoH1RHXHD0d+2rTOGY7HvIdC0dKDh?=
 =?Windows-1252?Q?SfsEDTUdaDOmlQdU2mHYcXJcPs68Exjiz8m9odDxzm13ATOSmNWluWKj?=
 =?Windows-1252?Q?CM+OEVDYQAGuEez5vaScs2WnjBlasqs7ClWQYShOt9zlns2kjWLZEw+V?=
 =?Windows-1252?Q?n9PE8PUpZzpU7UyX+KUts0F9KtxCO9ww1hKsCrxojqLn4k3HcuISfgh5?=
 =?Windows-1252?Q?fyf73C5ip/7MVP030uUIwTogVMjwaEgxWR/0r8iJx15cKo3rhQJa+JVO?=
 =?Windows-1252?Q?MzKQfuhVAf/oWEJgLNRiBFQTzzYMU4TYE3Tdbu7OzUVHvQgVCm/bu0z7?=
 =?Windows-1252?Q?PKh2430BDAtXBoWCiv9huQLMkHlztchva0YLdRBy4rsyZt20lm+v+Ubm?=
 =?Windows-1252?Q?NKWgMwHz0iJkdYmDEnB4SeCnKksdHkeAOpYvSWHQRL2LRQXO/LE9xZB8?=
 =?Windows-1252?Q?EdmwKTjPs1/fS2LvyRMR+aH4xXD7DmdY3QoIrJICjJQ12bAPROWQBX+1?=
 =?Windows-1252?Q?p6mG1cLC2r+R+m/BwCFfC9G5r5I3MZfrG4Z6MUdPDiANMxngTYgCNFK8?=
 =?Windows-1252?Q?sHAygZ418Aaa7waILN4KiYVed3867JUQlF1t/yqxTtgnoj2/eh7rji4i?=
 =?Windows-1252?Q?GOMih3wfUjxSod1LTTh78nVX21ikeKnCRFG0Bx+ei8mQTnnNrxoaN8f0?=
 =?Windows-1252?Q?ChYpAtL0uW+2Mp52I2dA2AI7U8TPlIu/SUS/FiiKMGKRVDrOkmSjflTH?=
 =?Windows-1252?Q?oqAojwhMQf9Pdvpk/Gv85qQwW4UMIRiK4vLGbk0Veiv90e8fDJM8zyd+?=
 =?Windows-1252?Q?FJd/NQEzUL6j4XrffaIbd6BV18PzC3U2M4HxN0ObN8MvFHN0J9PFP7Qi?=
 =?Windows-1252?Q?E8cRXK+dC3LwNO6tIxJVxBVYblsUyqTqqQor6/X/WOTabP+42fmPAsYL?=
 =?Windows-1252?Q?PdiraZRpgrxPXlUdAib2FK6ylikyNMoJk14zwKlX6ccli8tSjDtLb7uF?=
 =?Windows-1252?Q?5gbWq3fn8Oi931Bn9+sFDKphMPy1pnCxoGwASGdPEcvjP9fyE4jI153e?=
 =?Windows-1252?Q?Ca4oQDcmWkGCOnKRseDELgfd5W/VarYGYW+sjY+s9O57W5hzAgeRBCox?=
 =?Windows-1252?Q?etVddtJaLDyGVnWmmI+ugCXjNsveddtFFqPe0M/Q23cranF7SnCMuR2Y?=
 =?Windows-1252?Q?0GkIoT+tv3KfcgqT1Embg9dmpPDnCmIM9ijElhBPPgo3z4GmVdbe7twA?=
 =?Windows-1252?Q?uTFt5247V/W6xUQ1Db35jOD3WHdkne5R3oiQ6IHegvrJBiVDPvUiDp9o?=
 =?Windows-1252?Q?HnftXCr8ZXPFYt29HjZh79zuipYdDad1IlcbDwoGKoSzUHb3KsSb9K45?=
 =?Windows-1252?Q?9jt/SSwjXmtFXAqljwMAKeSPyoJ4lgw2AQdamhh4QAj9XVGeEN2M2S1i?=
 =?Windows-1252?Q?7e3v8RkvZSEn49Z8H6kuUO3E6LwLek0VYojkVgGr6JdHdn8k68ltzwCJ?=
 =?Windows-1252?Q?cEsHNKLyMskUZBMqBrJsEmrDusuoLSdpW+ekWUFXmvBetazGcdqHx/6N?=
 =?Windows-1252?Q?Y3pY1aTDAYgTaEWWtdpbThXpLI+80PAB/TeO8Y6mJakMzfWgJKk4d+Wr?=
 =?Windows-1252?Q?HwdrNtQ0V9IagHKudFM=3D?=
Content-Type: text/plain; charset="Windows-1252"
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4448.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dd6866-c50a-4794-6bf8-08dc711cd308
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 18:12:59.3252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Pz0cXu0fl7fGIbC8FjMgkchmbMy+Z2Q+bR3As8SoxmMwnYipjnGWpDUmT3KvhUAm0oMiD0hZdwKAc+fAcqSYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4704
X-Proofpoint-GUID: yNNs5UfvM0uTD9SRroe9bgQ0jQ0dei32
X-Proofpoint-ORIG-GUID: yNNs5UfvM0uTD9SRroe9bgQ0jQ0dei32
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_13,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=831 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100130

***************************************************************************=
******
=A0=A0=A0=A0=A0=A0=A0 ISCA 2024 - BUENOS AIRES, ARGENTINA - CALL FOR PARTIC=
IPATION
***************************************************************************=
******
=A0
=A0=A0=A0=A0=A0=A0=A0 =3D=3D=3D> Early-Registration Deadline:=A0 May 13, 20=
24
=A0
=A0=A0=A0=A0=A0=A0=A0 =3D=3D=3D> Location:=A0 Buenos Aires (Argentina)
=A0
***************************************************************************=
******
=A0
The International Symposium on Computer Architecture (ISCA) is the premier
forum for new ideas and experimental results in computer architecture. The
conference seeks particularly forward-looking and novel submissions.
In 2024, the 51st edition of ISCA will be held in Buenos Aires, Argentina,
at the Hilton Buenos Aires during June 29 - July 3, 2024.
This is a historic event as ISCA will be held in Latin America for the first
time ever. Let=92s make history together!
=A0
For more details on ISCA 2024, please visit the main conference website at:
https://iscaconf.org/isca2024/=20

***************************************************************************=
******
