Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAAAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 15:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9BAC840C1;
	Tue, 31 May 2022 15:30:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BepUfzo1msmA; Tue, 31 May 2022 15:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8CE458405D;
	Tue, 31 May 2022 15:30:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C8A9C0032;
	Tue, 31 May 2022 15:30:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3D1FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 15:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BA5860BF2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 15:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=vt-edu.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCkD9S1Ivzu7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 15:30:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B4A4605A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 15:30:26 +0000 (UTC)
Received: by mail-vs1-xe29.google.com with SMTP id q14so3124262vsr.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20210112.gappssmtp.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=MYYrWLLqQLrNdOIz28QaDyUnACbqnw2zukHx4g30418=;
 b=oqctOEC28cxpzEEzHVmWoNFV8SvBaRbPEAEvxswnbTQ7/xP9IsXYukuavVi1rReI37
 /8w3sJAASNkcSZqhGudiG9dYHrFYs6jwLlKPHRzJ8cNImCu+DAKlJwF2LslGX7ugigc+
 7GUvvk3RVCSpTSts9FYCXWWVwk0hKE9x48c8jJV23X1fLn2Pu+L889dn/OY9xmEwNek1
 hlcJmFqIFlsjRIn5yZyLN35nOhDpJzyGKp0B43tXVQmw7LMnd+jm6L5TYIONgToTq78n
 VSK7U0wLUlfrOWzKLhGLcOaJNFEBKl6OVkuMyYSWQrOyXNXp+Vr3nE+zJObqoItBHuWC
 3cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=MYYrWLLqQLrNdOIz28QaDyUnACbqnw2zukHx4g30418=;
 b=OBATZxUuYNmMUkT9SLjGrSw2zYV9ujEIMLipG1QAUrHgjJyR188rSo+xqE58bJt42A
 XjBpgrJaNdqq3QPCVivDueSbxyzsC/6IRzpAI8JdP/ZDgadojNO9p8WicsmLUo780FOd
 K7RijYGudboX9TqKilVT9UqBX56OeDD+NVWP4NlDj3ywUUfOg+QyZaioo7UjsDykTOSZ
 FZtXATQNrIhcIFR826DL0KkxZWG1YAAoeznXU2wYVI2tTpFvRB2fqXUSwfzl2WTpHjz1
 cyLQ6ZPaDHHy80bmAz36OZJXJAnH+eUUk3G6IRwd7V9fSUuR/6rMDse2VMKnecNoyzMA
 1YzA==
X-Gm-Message-State: AOAM533MtprxW53nLNENfT4WZJjQSGcHsaCDRda4wjfc2+D9UpHPSQHx
 IfVfCvAXGskQk2AKvTIYjOmuBliYYMQaq8zWo+7BHQ==
X-Google-Smtp-Source: ABdhPJwd18a/AlFJhnzdFAlfn1dQvSWFe+caVi58kcOyKouDbew7rcjZ8+ho2cIFS6PPlzxSHRAQYk3519ujKnu0QBQ=
X-Received: by 2002:a67:c399:0:b0:335:c66b:cef9 with SMTP id
 s25-20020a67c399000000b00335c66bcef9mr24708015vsj.18.1654011025175; Tue, 31
 May 2022 08:30:25 -0700 (PDT)
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Tue, 31 May 2022 11:29:49 -0400
Message-ID: <CA+Vr5ctKsZbQKqr7gcKQ4SQ8xvf-NPqvOhPeVd-GK+sWN=DQdg@mail.gmail.com>
Subject: ACM HPDC 2022 Call for Participation
To: tci-announce@computer.org, tcde-announce@computer.org, 
 tcpp-announce@computer.org, tcbis-announce@computer.org, 
 "HPC-MEMBERS@listserv.acm.org" <HPC-MEMBERS@listserv.acm.org>, 
 sc-workshop-attendee-cfp@group.supercomputing.org, 
 hpc-india@mailman.serc.iisc.in, hipeac.publicity@lists.ugent.be, 
 sigops-announce@listserv.acm.org, publicity@hipeac.net, 
 htcondor-users@cs.wisc.edu, dbworld@cs.wisc.edu, 
 virtualization@lists.linux-foundation.org, users@planet-lab.org, 
 infodir_sigcomm@acm.org, sigplan-l@acm.uiuc.edu
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

HPDC'22 Call for Participation
https://www.hpdc.org/2022/program/call-for-participation/

Overview:
The ACM International Symposium on High-Performance Parallel and
Distributed Computing (HPDC) is the premier annual conference for
presenting the latest research on the design, implementation,
evaluation, and the use of parallel and distributed systems for
high-end computing.

Registration:
HPDC'22 will be held in both in-person and virtual mode. HPDC
registrants can attend the main conference and workshops. There is a
separate workshops only registration. For more information, visit
Registration.

Highlights:
1) 3 Keynotes: Franck Cappello (Argonne National Lab), Sudhanva
Gurumurthi (AMD), Manish Parashar (University of Utah). For more
information, visit Keynote Speakers.
2) HPDC Achievement Award: Franck Cappello. For more information,
visit Achievement Award.
3) 21 research papers and 5 poster presentations across 6 sessions,
namely, {Data Centers and HPC Systems}, {HPC Memory, I/O, and Storage
Systems}, {Reliability and Scheduling}, {HPC Algorithms}, {HPC
Toolchains, Traces, and More} and {Cloud Computing and Machine
Learning}. For more information, visit Technical Sessions and Accepted
Papers/Posters.
4) This year we have 7 workshops to be held in-conjunction with
HPDC'22. For more information, visit Workshops.

Main Conference:
The 21 contributed papers accepted for the main conference will be
presented in hybrid(virtual and in-person) technical sessions on June
27, 28 and 29. Details on the presentation format to follow.

Poster Sessions:
The 5 accepted posters will be presented on the evening of June 28.
Details on the presentation format to follow.

Workshops:
The 7 workshops will be held in two sessions:

June 30: SNTA, HiPS'22, PERMAVOST, P-RECS'22
July 1: FRAME'22, EMOSS'22, FlexScience
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
