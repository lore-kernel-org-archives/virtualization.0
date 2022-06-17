Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6664AC43334
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 07:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0386D409D5;
	Fri, 17 Jun 2022 07:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0386D409D5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vt-edu.20210112.gappssmtp.com header.i=@vt-edu.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=FlfHKex5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1633pMvQxboP; Fri, 17 Jun 2022 07:31:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 73EB140992;
	Fri, 17 Jun 2022 07:31:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73EB140992
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45BBEC0039;
	Fri, 17 Jun 2022 07:31:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AD08C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 546E0402AF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:31:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 546E0402AF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=vt-edu.20210112.gappssmtp.com
 header.i=@vt-edu.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112
 header.b=FlfHKex5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FBCEq7PmsqMT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:31:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F17C5402A9
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F17C5402A9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:31:45 +0000 (UTC)
Received: by mail-vs1-xe34.google.com with SMTP id i186so3316184vsc.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20210112.gappssmtp.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=NgEHMiKa/NQ1V8Jl2ni2bsc1tqjylrPz+4zH0cfph6g=;
 b=FlfHKex5L6jzP0cbtbTWHHGkI9hU+UzECDqVSIonxgfagfjOKj6THsVtkGRwHJr7cp
 Qw1gzu2QXuVwDp5K1kc4jMSpAuxRWbiT8whGVK/9NDMtiQbB2a0xqciEo1J5YEyguPCE
 CQb69t0BfP3t4BGzBaSlacUbzXaV5pmK88TI4xQGMvI0dy6BuMNFyH7/6NreXMdrSAC/
 SOaMfyY7I+sng3iXBR4keXVyolDV/2Zr+hE78XYfzaq4Hu7KMW1X2daSBKjyC/P9isNf
 1jBCBQVeajxilP2WtvuqRb95gYnjZu6iAMDeHUqla15AV5rznFBZMvyE9Nnup454pmBz
 lctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=NgEHMiKa/NQ1V8Jl2ni2bsc1tqjylrPz+4zH0cfph6g=;
 b=RhbLtiQ978RDuev02BS0gy8jRfyad9NXaWBv14FFCLgAFa4PEy2Nm+5jBBVzy2P/ml
 SwzfHhnohnCtHtmvehdf4DOiYzno2APxlCAEJdRvFJ1jbnMJ7pSkp80iyH83vT1tkIDn
 +QRXb49xt6nmnfh7RJVTjd6/siM5983ucWVjImtAGnkDHztQdLvky2ay6gfV4fGZf5z3
 MaXHUsBIRFK01+AWtP8G7ConQfds63yve+c7D5FKFwykn1GklK2U6jd7pFFaDwXytq8O
 CA1hQuOn7qpv+v/T66BLH2LniZ3bEgUYUfKOTNYGaVjAAO5eyFKmypUTDR16gNoNmIUa
 WJjw==
X-Gm-Message-State: AJIora9a807oLBi2LUjDYbziuytHrHTA764dvZXfqQdlYuvb+n/FSt7w
 IFhvGZMyTd8a3NxrbAdEDApdSws31F6x2v4yp3a44w==
X-Google-Smtp-Source: AGRyM1to/7GJ8XKfAdvZxlfaKxE72oky115VdZo1a/HrWjAuyxA23FnWt840u5Pb3ZIZmgw+jFHyNxPa+K5ovIWuhJ8=
X-Received: by 2002:a67:e441:0:b0:34c:9008:4cc4 with SMTP id
 n1-20020a67e441000000b0034c90084cc4mr4015376vsm.87.1655451104609; Fri, 17 Jun
 2022 00:31:44 -0700 (PDT)
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Fri, 17 Jun 2022 03:31:08 -0400
Message-ID: <CA+Vr5cscu04ut=O22TduZ=4k1P0b71Gqas-=YrKyF_PBp+=4nQ@mail.gmail.com>
Subject: Call For Participation: ACM Workshop on Hot Topics in Storage and
 File Systems
To: tci-announce@computer.org, tcde-announce@computer.org, 
 tcpp-announce@computer.org, tcbis-announce@computer.org, 
 "HPC-MEMBERS@listserv.acm.org" <HPC-MEMBERS@listserv.acm.org>, 
 sc-workshop-attendee-cfp@group.supercomputing.org, 
 hpc-india@mailman.serc.iisc.in, hipeac.publicity@lists.ugent.be, 
 sigops-announce@listserv.acm.org, publicity@hipeac.net, 
 htcondor-users@cs.wisc.edu, dbworld@cs.wisc.edu, 
 virtualization@lists.linux-foundation.org, users@planet-lab.org, 
 infodir_sigcomm@acm.org, sigplan-l@acm.uiuc.edu, hpc-announce@mcs.anl.gov
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

[Apologies for cross-posting]

===================================================================
C A L L    F O R    O N L I N E    P A R T I C I P A T I O N
ACM Workshop on Hot Topics in Storage and File Systems (HotStorage '22)
June 27 - 28, 2022, Online
https://www.hotstorage.org/2022/
===================================================================

Program:
==================================
The full program is available at:
https://www.hotstorage.org/2022/program.html

Registration:
==================================
Registration is $20-$50, please see registration information at:
https://www.hotstorage.org/2022/attend.html

Accepter Papers:
==================================
https://www.hotstorage.org/2022/accepted.html

Keynote Talks:
==================================
Ted Tso (Google)
Steven Swanson (Univ. of California San Diego)

Conference Scope:
==================================
The HotStorage workshop provides a forum for cutting-edge storage
research, a place where researchers and industry practitioners can
discuss new opportunities and challenges in storage technology. The
program includes 19 papers and keynote talks by Ted Tso (Google) and
Steve Swanson (UCSD). The research papers propose new research
directions, explore non-traditional approaches, or report on
noteworthy or counterintuitive learnings and experience in emerging
areas. They are expected to lead to insightful discussions that will
influence future storage systems design and applications. ACM
HotStorage is designed to appeal to academic and industrial
researchers and practitioners, welcoming both students and seasoned
professionals.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
