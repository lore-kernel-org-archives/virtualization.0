Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CEBC433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 18:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AF8783145;
	Thu,  3 Mar 2022 18:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h9Mpd4ox51DI; Thu,  3 Mar 2022 18:37:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A895F831C1;
	Thu,  3 Mar 2022 18:37:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81A33C001D;
	Thu,  3 Mar 2022 18:37:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 271C6C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 18:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 083DF410E7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 18:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=vt-edu.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9GxzaorZxEj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 18:37:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A169A410AC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 18:37:12 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id t14so7950511ljh.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Mar 2022 10:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20210112.gappssmtp.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=bJmBr8Wdo+QAX7LseaCe9FnqA43BElC0HUa0gUFr00Y=;
 b=Rv0jpbQ+e7ABnpP1aqXXjAIfAVJeySgPQzJK9x9f29R96tjKF1oIb2J8tfVVZQDvbe
 /geBp4MbEklRoR0yNaxIArmTShXbwYWzynp+DECCF4UJlpPZAa9ZdMR0FjsEHT/la8vM
 M2aXgwSekvCncVL+C+6MAd1kiJaKVIUxtKc/vg1ExWj8HNH/vdkurCTynpOMFuMB8Kf6
 bgzXFIXwXCGEzf11zcGuDeUiHNfHQJwZmPv5Z9XgZRIlD3ZaNYSF08I5FsGzDJviDpPG
 ayObX8zUTGPzvCzjz6hMLjFXCl8pg48EPU/a1BDgLhm8hotkuJSW76JVl5QidW2b3zou
 cQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=bJmBr8Wdo+QAX7LseaCe9FnqA43BElC0HUa0gUFr00Y=;
 b=Fca88rje42+MunMyQOuH9GUdIamJ/qvqm0IckWT6J863RN31aeibtlwZjtvZeMgTt2
 g0xTq++mbFCd9ir8A28PfF1qaHCoZZtPEMdcgyI+4XmEyjBx6oDi3fxr4mnJlp++sCVI
 53ZGA9QkZaqIa88hfPPXzo+Mgzd9dzYnFcVcmCcJ530SoTWREvyrFMOT23a0I74BrI+M
 lXESGw8blpwt712bmHIePwnTe6A1VIRygtN4MMMx9xZ/HkWRbZpBdGjyzPAwNUvjU4fo
 kEsbbWDYFNILzNYMLCpyi1eE9ZDaU1TSjTLIpAHR2m5QqCnNufLL6H5o/eJrLSxP2eex
 Znrg==
X-Gm-Message-State: AOAM531uY14Bt/mXo4JsJEe3R2/UW77WeVxPG4I+zWNhVRGHlMCpTrNh
 th9UWnbZdKg5OnFz4PBgl1bV2cNwN+a7BEt4bki5ag==
X-Google-Smtp-Source: ABdhPJz5C8dyGORdc98cMgDHhOgHcTAkQ8zl5Hq8l5Poz/HpznPtT8VkZdIqA7Thk51LCKsvSZewJ0GxCDCcIzxlRmA=
X-Received: by 2002:a2e:b896:0:b0:247:b65e:6f63 with SMTP id
 r22-20020a2eb896000000b00247b65e6f63mr4467315ljp.66.1646332630342; Thu, 03
 Mar 2022 10:37:10 -0800 (PST)
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Thu, 3 Mar 2022 13:36:32 -0500
Message-ID: <CA+Vr5cvaM=J6sPKntY50TTazcxbnJLfF=TQdvCxg5ZGV4Q-6rw@mail.gmail.com>
Subject: Call for Posters - ACM HPDC 2022
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
Content-Type: multipart/mixed; boundary="===============2688316811104936379=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2688316811104936379==
Content-Type: multipart/alternative; boundary="0000000000009d32f605d954af46"

--0000000000009d32f605d954af46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
                                      CALL FOR POSTERS
                      The 31st International ACM Symposium on
        High-Performance Parallel and Distributed Computing (HPDC=E2=80=992=
2)
             Minneapolis, Minnesota, United States, June 27 - July 1, 2022
                     http://www.hpdc.org/2022/posters/call-for-posters/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D=3D Overview =3D=3D=3D
The ACM International Symposium on High-Performance Parallel and
Distributed Computing (HPDC) will include a poster session with an
associated 2-page extended abstract, which will be included in the HPDC
2022 proceedings. The topics of interest follow the regular paper
submission and include (but are not limited to): cloud computing, cluster
computing, edge computing, big data, massively multicore, AI for systems,
and extreme-scale computing systems. Accepted posters will be given the
opportunity to present their work in a dedicated lightning-/blitz-session
(using in-person presentation or virtual presentation) during the main
conference.

=3D=3D=3D Submission Guidelines =3D=3D=3D
We invite authors to submit poster contributions in the form of a two-page
extended abstract and a poster draft. Abstracts should be formatted in the
ACM Proceedings Style and submitted via the poster submission web site (to
be announced). Each submission should include a title, all author names and
affiliations, notes whether any of the authors are students, and an
indication of which author is corresponding/presenting the material. Poster
abstracts will be reviewed by the poster program committee through a
single-blind process and will be evaluated based on the following criteria:
=E2=80=A2 Submissions must describe new and interesting ideas related to HP=
DC
topics of interest
=E2=80=A2 Submissions can present work in progress, but authors are strongl=
y
encouraged to include preliminary experimental results, if available
=E2=80=A2 Student submissions meeting the above criteria will be given pref=
erence

=3D=3D=3D Poster Chair =3D=3D=3D
Dong Li, University of California, Merced, USA

=3D=3D=3D Poster PC Members =3D=3D=3D
Bogdan Nicolae, Argonne National Lab, USA
Min Si, Facebook, USA
Kento Sato, RIKEN Center for Computational Science (RIKEN R-CCS), Japan

=3D=3D=3D Submission =3D=3D=3D
Submissions are now open here (hpdc22-posters.hotcrp.com).

=3D=3D=3D Deadlines (Times are AOE) =3D=3D=3D
Abstracts due: April 4th, 2022
Author notifications: April 19th, 2022
Camera-ready Upload: April 21st, 2022
Poster date: June 27th, 2022

--0000000000009d32f605d954af46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALL FOR POSTERS<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The 31st Internatio=
nal ACM Symposium on<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 High-Performance Parall=
el and Distributed Computing (HPDC=E2=80=9922)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Minneapolis, Minnesota, United States, June 27 - Ju=
ly 1, 2022<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0<a href=3D"http://www.hpdc.org/2022/posters/call-for-poste=
rs/" target=3D"_blank">http://www.hpdc.org/2022/posters/call-for-posters/</=
a><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>=3D=3D=3D Overview =3D=3D=3D<br>The A=
CM International Symposium on High-Performance Parallel and Distributed Com=
puting (HPDC) will include a poster session with an associated 2-page exten=
ded abstract, which will be included in the HPDC 2022 proceedings.=C2=A0The=
 topics of interest follow the regular paper submission and include (but ar=
e not limited to): cloud computing, cluster computing, edge computing, big =
data, massively multicore, AI for systems, and extreme-scale computing syst=
ems.=C2=A0Accepted posters will be given the opportunity to present their w=
ork in a dedicated lightning-/blitz-session (using in-person presentation o=
r virtual presentation) during the main conference.<br><br>=3D=3D=3D Submis=
sion Guidelines =3D=3D=3D<br>We invite authors to submit poster contributio=
ns in the form of a two-page extended abstract and a poster draft. Abstract=
s should be formatted in the ACM Proceedings Style and submitted via the po=
ster submission web site (to be=C2=A0announced). Each submission should inc=
lude a title, all author names and affiliations, notes whether any of the a=
uthors are students, and an indication of which author is corresponding/pre=
senting the material. Poster abstracts will be=C2=A0reviewed by the poster =
program committee through a single-blind process and will be evaluated base=
d on the following criteria:<br><span style=3D"white-space:pre-wrap">	</spa=
n>=E2=80=A2 Submissions must describe new and interesting ideas related to =
HPDC topics of interest<br><span style=3D"white-space:pre-wrap">	</span>=E2=
=80=A2 Submissions can present work in progress, but authors are strongly e=
ncouraged to include preliminary experimental results, if available<br><spa=
n style=3D"white-space:pre-wrap">	</span>=E2=80=A2 Student submissions meet=
ing the above criteria will be given preference<br><br>=3D=3D=3D Poster Cha=
ir =3D=3D=3D<br>Dong Li, University of California, Merced, USA<br><br>=3D=
=3D=3D Poster PC Members =3D=3D=3D<br>Bogdan Nicolae, Argonne National Lab,=
 USA=C2=A0<br>Min Si, Facebook, USA=C2=A0<br>Kento Sato, RIKEN Center for C=
omputational Science (RIKEN R-CCS), Japan=C2=A0<br><br>=3D=3D=3D Submission=
 =3D=3D=3D<br>Submissions are now open here (<a href=3D"http://hpdc22-poste=
rs.hotcrp.com/" target=3D"_blank">hpdc22-posters.hotcrp.com</a>).<br><br>=
=3D=3D=3D Deadlines (Times are AOE) =3D=3D=3D<br>Abstracts due:<span style=
=3D"white-space:pre-wrap">	</span>April 4th, 2022<br>Author notifications:<=
span style=3D"white-space:pre-wrap">	</span>April 19th, 2022<br>Camera-read=
y Upload:<span style=3D"white-space:pre-wrap">	</span>April 21st, 2022<br>P=
oster date:<span style=3D"white-space:pre-wrap">	</span>June 27th, 2022<br>=
</div>

--0000000000009d32f605d954af46--

--===============2688316811104936379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2688316811104936379==--
