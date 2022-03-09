Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C0C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 18:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F267611B6;
	Wed,  9 Mar 2022 18:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p-QvD_0XUeeA; Wed,  9 Mar 2022 18:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 367B060F9D;
	Wed,  9 Mar 2022 18:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0491BC001D;
	Wed,  9 Mar 2022 18:54:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75841C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 18:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54DBD4027A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 18:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=vt-edu.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jBirok-3BQGN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 18:54:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E231401B3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 18:54:40 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id r22so4560313ljd.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20210112.gappssmtp.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=II+hjCPZckoS4eTE5wCvAEDsXRUfZM8ViRYkshLuidM=;
 b=y5PXmxoBb7/M1XrbV8d2VaJwVkOZhBsgeMjSPMPmL4OjkGijrYSdMiC2lzTcEl9Jn/
 U27RHHJhviBPVDHvGLpWS521CixnKfZ9fFj2S0wH2Ys8k/ePZOiLsSj9wielCT+U+uUX
 UaOmpYNlJn86ucDMTlMgWz9SPHca8Z40bdguz8I/LXvGEk2l0YdNOTS6SWcYUyX1BNrx
 HrOqG0QHR6+8xDpkZnPHIcjPRiyw2SSBlswVoDkcC55R1yTeGtoo7K7N9JCdaJBgvwdu
 OaiC2/Q1l/12qDiuF2F3udFijltWJfVEPZHC+eUQ3xux0f4BE3kxm0/+WvaSMaXMv5NX
 y0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=II+hjCPZckoS4eTE5wCvAEDsXRUfZM8ViRYkshLuidM=;
 b=vvZ23XctWJ2w63FCGxByJMMU5AwRYxrifZvNWDjRRwUIbpbBTVAS7UvmbGq9zgCfaA
 uxezbieygFrgNmDbWXTL84PZtNKAs+oN8e3h4gXOoELroybUoMe8tLIIRRhQ3m8nj3Wq
 QAjNL0LVIQ7vnE6SvW93C9lZRfB21ej9nHEdaUYl23Frv/H6W6kywAGSwLzk9vRmdnaK
 ylby3A5FmlP1zc7PLkL1NuSV+rYtxbbX8BL4Dv50LTuJXIKmWNf5SzjU/THybkMby+yX
 kyQJZcji+0VO+tVoYc1zp4t8nNeUz+nPrtTP409vsuOqv2czv3gARopu3VwI9Pe81KnZ
 SiOA==
X-Gm-Message-State: AOAM532WftaZGU8CbaI+sM+g12Gi6va58miTt4hvBpvj9gLdU46nqaW7
 PGqL6zNB45GNCTPejyXODCEYO/pFdOO9BoLfQRtlRw==
X-Google-Smtp-Source: ABdhPJwASNTVdlEb6/P9x4je2gm+YN6nGoF0d1wiibmIDJtTx1Z8kuPiio0dWBgI8I6lm4mNOo1sStYaOH0ptqJPYnY=
X-Received: by 2002:a2e:b896:0:b0:247:b65e:6f63 with SMTP id
 r22-20020a2eb896000000b00247b65e6f63mr642383ljp.66.1646852078373; Wed, 09 Mar
 2022 10:54:38 -0800 (PST)
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Wed, 9 Mar 2022 13:54:01 -0500
Message-ID: <CA+Vr5ct3KSXShZXRz+QS666QmToABT_=X83+pXYJWmF9ZCqNLg@mail.gmail.com>
Subject: Call For Nominations: ACM HPDC Achievement Award 2022
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

Call For Nominations: ACM HPDC Achievement Award 2022

In 2012, HPDC established an annual achievement award, which is
presented to an individual who has made long-lasting, influential
contributions to the foundations or practice of the field of
high-performance parallel and distributed computing (HPDC). These
contributions may include one or more of the following:
- conceptual advances that have influenced the design or operation of
HPDC systems or applications;
- innovative techniques or tools for the design or analysis of HPDC
systems or applications;
- the design, the implementation, and the deployment of innovative
(components of) HPDC systems or applications;
- the analysis of innovative (components of) HPDC systems or applications.

In selecting the achievement award recipient, the Award Selection
Committee will place particular emphasis on seminal contributions and
a sustained record of high-impact in the field.

Past Winners:
- 2021: Rosa Badia, for her innovations in parallel task-based
programming models, workflow applications and systems, and leadership
in the high performance computing research community.
- 2020: No winner
- 2019: Geoffrey Fox, for his foundational contributions to parallel
computing, high-performance software, the interface between
applications and systems, contributions to education, and outreach to
underrepresented communities.
- 2018: Satoshi Matsuoka, for his pioneering research in the design,
implementation, and application of high performance systems and
software tools for parallel and distributed systems.
- 2017: David Abramson, for his pioneering research in the design,
implementation, and application of high performance systems and
software tools for parallel and distributed systems.
- 2016: Jack Dongarra, for his long-standing and far-reaching
contributions in high performance linear algebra and large-scale
parallel and distributed computing.
- 2015: Ewa Deelman, for her significant influence, contributions, and
distinguished use of workflow systems in high-performance computing.
- 2014: Rich Wolski, for pioneering and high-impact contributions to
grid, cloud, and parallel computing.
- 2013: Miron Livny, for his significant contribution and high impact
in the area of high-throughput computing.
- 2012: Ian Foster, for his initiative in the creation and development
of grid computing and his significant contributions to
high-performance distributed computing in support of the sciences.

Achievement Award Talk:
The award will be presented at the 31st International Symposium on
High-Performance Parallel and Distributed Computing in Minneapolis,
Minnesota, United States, June 27 - July 1, 2022. The winner should be
available to receive the award and present an achievement award talk
at the conference.

Nominations for the 2022 Award:
Candidates may nominate a colleague by sending a letter in PDF form to
dthain@nd.edu. Each nomination received will be retained and
considered by the committee for three consecutive years. The letter of
nomination should be about one page and contain:
1. The nominee's current professional affiliation(s).
2. A brief citation (thirty words or less) precisely stating the most
salient reason(s) why the nominee is qualified for the award.
3. A description of the technical contributions of the nominee and
their significance and impact.

Important Dates:
Nomination deadline: Wednesday, March 31th, 2022

2022 Award Selection Committee:
- Rosa Badia
- Jon Weissman
- Abhishek Chandra
- Ada Gavrilovska
- Devesh Tiwari
- Douglas Thain

The award selection committee is chaired by a member of the HPDC
steering committee and includes the General Chair(s) and the Program
Committee Chair(s) of the current HPDC conference, and the previous
year's award winner. An award committee member cannot be a nominator
or be selected as the winner.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
