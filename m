Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ACFC433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Oct 2022 11:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8750C40B64;
	Tue, 11 Oct 2022 11:59:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8750C40B64
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=Wupx2BTX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yk45VY_VTGxZ; Tue, 11 Oct 2022 11:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D6CFF40364;
	Tue, 11 Oct 2022 11:59:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D6CFF40364
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C38AC0033;
	Tue, 11 Oct 2022 11:59:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B39A6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 11:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AE15408CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 11:59:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AE15408CE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=Wupx2BTX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id spm59ldfAfdt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 11:59:07 +0000 (UTC)
X-Greylist: delayed 00:20:59 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EEC2F4005D
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu
 [18.185.115.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEC2F4005D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 11:59:06 +0000 (UTC)
Received: from 104.47.12.56_.trendmicro.com (unknown [172.21.9.250])
 by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 73C1C1012E4BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 11:38:10 +0000 (UTC)
Received: from 104.47.12.56_.trendmicro.com (unknown [172.21.183.236])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 129B31000082D;
 Tue, 11 Oct 2022 11:38:05 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1665488263.920000
X-TM-MAIL-UUID: e8466b74-f7bc-496f-aef7-3e17e0f25f43
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown
 [104.47.12.56])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 E0E281000376B; Tue, 11 Oct 2022 11:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYgTxTVTDQHAzpypnm7rqDxMvCUlKmY64i8PBB89ki4n8w+bA44CS/EDt4zoOPgmGgobCihmvmH067vwDDrjruK3ikOFXj0thu0vww9pKnGcrhrLMJmO36yjJWjnxeNPPFtq1P+yXEIAUwRzuvYq3x8zSC+z+w0EJo2jreiJek9fGaqK5I/WqrF1SQLhK1vzXa9ZFpmQWwZqOkPNMyBOCEBNFGhlvbdFNxL9Ew4oImBbVD1NnSiL7iq77MOziGYGLQdaC1Pk8jrCTi6MWOmUQy9aGOpXxM99ZjkeVfUrS1i7QnSUgcn5Mkj4E5xT1xpBTENsoJOEkCiHgjTpRlnfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnxTd3yaZUtD1eHaVhS+1BdrMgPp3bMJZDc1rrGkZpk=;
 b=YZ5R3QxTBkC/LR8Hba8S4d8THDEiWYwf1+fynbutzvNEb4hcgt5Pmc9h2RbcXw5oYT/NWyLia/561o8dA/V1+08JjzxPWCI7683SGbMdasMWxM4Z9D4hOuROU1zdwU2ZVDbwrb8wGsOz/Hf4zXHtQBiQWltx+WmruzTLgmVv/McNu6m3Rk1tIHUbk+q06px5bmXkO07g3FhULOX4QJsC4V26yLJlwaI/2kIkj3A3zqtvWffWiOZg+KDgjChDCZhu6eZos8mfLG+iItITFhc1lHtZjFzdRdyLzGRTUR+xEND/5iwub70sojf8RXc2irb2PHOcHubvm00wD16PpYfVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=opensynergy.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=opensynergy.com; dkim=none (message not signed);
 arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Igor Skalkin <Igor.Skalkin@opensynergy.com>
To: virtio-dev@lists.oasis-open.org
Subject: [PATCH] virtio-mmio: Introduce virtio_mmio hotplug
Date: Tue, 11 Oct 2022 13:37:27 +0200
Message-Id: <20221011113727.13714-1-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT027:EE_|DBAPR04MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: dece9557-8cfd-456d-c09b-08daab7d019f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujHgJcKIMjt7OquIQYhlDhzrP/EH4XqdYANzIlbC3FJVIA1c5WDSrDuHl/KnfRg2nS9D6TKYMsv3wt97o/nM8MUgf8+DAZz95rPcX9s+JTgVY4QVSSbWwuIURzCNeAKcUgOFtm/oEs7j+xow7hXyVenURE9QaY604K5A4BhjhNv2gp3KrXNMjXsb18+kB3RwPj4MYzuNbGgEBAv5kzL4ipkmaCYkpgKkrM+on143eo7Mn2qP/jQ0JBbRU5EoSlp36/Z+iEA7oi+WNvvKmkpYZkcVXZpy2TTFVJknra0/v7w/HOJH21DEWkMb+fkKdjlGKcGyFlkiInxv16qAE01ItOpg0y1KAe7wThg693ZMRaZuQiUoRwkAGQ+I3Ypszv+X4jYOrnK8TI/Q3WdhecdCJnkQ2uz3Ub+JmXtzfCG+b9NfJxLbGutf8v0np5oXxZgpHPVUie6zSXwZ5nbkWhOJHWZXBgV/CUg6iTHWFAnVe4O4D5ohNzoF+VWCpR6IZzxdxFDwCVQR2I8FrAeomYNNV2uhn8GX+fv0mqdZa1yjd49n06QAk7eH8kIqrHVsl7B2o0KFK8PXcPM/CmwnCcfY2ilZ0ra/l9zO3jWsEiu8hv9TnyTwVnvO4ABVrOh9EF0SfjoHP5V169gaJ7fcq1LoY0WR1y3G+9SPP3xydsEB5qxy08dBg51+yyHPFgT6ebYbW0AHcSK77nYdoCLxO0JMeqiVYL5U0Rlu70sh+xvb08msoGyq+tSi3jgSejnPp2pbQRmYGnMdsvQCQTGTVX7PtGoAxLRL9R5X0rhmW8GTLkk=
X-Forefront-Antispam-Report: CIP:217.66.60.4; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SR-MAIL-03.open-synergy.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230022)(39830400003)(346002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(26005)(107886003)(81166007)(966005)(478600001)(40480700001)(36756003)(36860700001)(83380400001)(1076003)(186003)(2616005)(336012)(82310400005)(41300700001)(2906002)(47076005)(5660300002)(8936002)(66899015)(42186006)(316002)(6916009)(86362001)(4326008)(8676002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 11:37:41.1761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dece9557-8cfd-456d-c09b-08daab7d019f
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64; Ip=[217.66.60.4];
 Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT027.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7445
X-TM-AS-ERS: 104.47.12.56-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27194.007
X-TMASE-Result: 10--10.458900-4.000000
X-TMASE-MatchedRID: VXTBbHBSxOXNbhQS/JOWkQ7LUBXy1QPwlNnJT1Rqg3aAsoaBaA0JWWZY
 /RdXrUKNIFRhtwLpj8tcD1n1n+S8Ielt5WehodvpEd0hnp51xush9mNF8ZPJ2CdNyL66/PJhALs
 BlKV4kw1DN5fSCK7puHtBxdKLkQVYPTjlhfwX/L/9QfnpVLoxlgeK93mzhKdFuBsk5njfgGxmhC
 M8bwrCXSL637QCIVpi8vc3EUpCmrU+McQeAMc5heJMNIftzCCTYEpG2D2kcRoTMFL8shgf9+qOS
 OOdRR5a6Y6R0tHNHVgA9bvpYtJHwsQTSPZE5H8g1l+BjLM8lsqfmd9HsjZ0U3d17Y6gGqDCUK/H
 Nleb7IsZB0R4cFpbTbV+QxK+YzdJ8WGxHU0M6MWz8d6zvo5NkKdHOWsjpvKD33Nl3elSfsq8v9m
 td/2Oh/rvsV1TtS1AQY7/FJpJ6BNhaj10i6TXQCsIuzCLc2mNNkrW5favn2QJ52eMU5+ynKSwVc
 JsDkZ/8SPQ12/jbpxzj2fe/sBQDXjD8WHEp9BDfsrJIMK37At9LQinZ4QefBTJFL84IP3FlR1cT
 9YafQVGsz39UMlNSY6HM5rqDwqtKjKSUMA6sDcWwDDv5Ftz0yCE1sgBl4C60TifSoBJ5S4XwMga
 EV3XOA==
X-TMASE-XGENCLOUD: 0ed04e08-8358-447f-961a-2e08306886aa-0-0-200-0
X-TM-Deliver-Signature: 904ADB0B41AC741897EADC31B259B2D5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1665488284;
 bh=mk/bs+xlpgS4Gg7JOmHlHsTisHuEJ8mF9BW+tji+FI4=; l=4290;
 h=From:To:Date;
 b=Wupx2BTXPa10xYDCMPmE3sUEHYmGRwu69NT26dXQHnzyUKc4khVyZpIsMfxrd380T
 P0PPbPu+5tRYkW1Zq9igrVXvbSWLfnhy9NiWYjH1oVhkDW+HtxWWEVUsTHU+oa6oLB
 piqAjmjr0o7+oB/Ex6UB+xjFHn8VTo61lXUGG4mmGtDUUeJtVK18rauqapV1sqgcFI
 bjk5f57RZkQkk8CBe6sz6rZAEfmOTkzijcQPZv9joZ8yYtQObIPZYzRFOmb1nuwGJC
 BgQcJTf2bgTt1ZY0kbBDvC9V4geQhWwQ5pP/A4oeaWHVs1ZkZHHJHJjj2akgn21iLn
 8m+zhAQALwEZA==
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

As long as the virtual device is not yet running, virtual machine
manager presents the device with DeviceID set to 0.
If the driver reads zero from the DeviceID field, it should defer
the rest of the initialization process and wait for an interrupt.

As soon as the device starts, the virtual machine manager sets the
correct device ID and sends an interrupt.
The driver, when it receives an interrupt, must reread the DeviceID
and continue initialization if it is non-zero.
---
In our setup, we have a type 1 hypervisor, a Linux host with virtio
devices, and virtualised Linux/Android guests with virtio drivers.
Both the driver VM and the guest VM start at the same time, so the
"guest OS initializes virtio driver, but the virtio device is not
yet running in the host OS" situation happens all the time.
We also need the ability to start some devices manually after the
system starts.

Linux kernel patch with the implementation example:
https://lists.oasis-open.org/archives/virtio-dev/202208/msg00075.html

Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
---
 content.tex | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/content.tex b/content.tex
index e863709..b9cef85 100644
--- a/content.tex
+++ b/content.tex
@@ -1804,7 +1804,8 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     Value zero (0x0) is used to
     define a system memory map with placeholder devices at static,
     well known addresses, assigning functions to them depending
-    on user's needs.
+    on user's needs (one of the option - placeholder for the hot-plugged
+    device).
   }
   \hline
   \mmioreg{VendorID}{Virtio Subsystem Vendor ID}{0x00c}{R}{}
@@ -2031,7 +2032,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 The driver MUST ignore a device with \field{Version} which is not 0x2,
 although it MAY report an error.

-The driver MUST ignore a device with \field{DeviceID} 0x0,
+The driver MUST ignore a device, as long as reading from \field{DeviceID} returns 0x0,
 but MUST NOT report any error.

 Before reading from \field{DeviceFeatures}, the driver MUST write a value to \field{DeviceFeaturesSel}.
@@ -2071,9 +2072,23 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti

 The driver MUST start the device initialization by reading and
 checking values from \field{MagicValue} and \field{Version}.
-If both values are valid, it MUST read \field{DeviceID}
-and if its value is zero (0x0) MUST abort initialization and
-MUST NOT access any other register.
+If both values are valid, it MUST read \field{DeviceID}.
+
+If the value of \field{DeviceID} is zero (0x0):
+\begin{itemize}
+\item The driver MUST postpone initialisation until an interrupt arrives,
+and MUST NOT access any other register.
+
+\item When an interrupt occurs, the driver should reread \field{DeviceID}, and
+if it is non-zero, continue with further initialization.
+\begin{note}
+At this stage, (the device has not even been reset yet) driver MUST NOT access
+any other registers, including \field{InterruptStatus} and \field{InterruptACK},
+so it can not proceed with the interrupt status check and acknowledgement as described in
+\ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device},
+it can only check if a hotplug device has already started by reading \field{DeviceID}.
+\end{note}
+\end{itemize}

 Drivers not expecting shared memory MUST NOT use the shared
 memory registers.
--
2.37.2


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerklaerung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-general-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.opensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaeftspartner-gem-art-13-dsgvo/>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
