Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5A172BD5
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357246; cv=none; b=R3GEk4kRgThXeFLZJ+UwLvvrbvvpUirdYs1YAS/u7q6hVmDGNMpOGfch4cqrjvfWlAYP1tYVakxaqcv7RLXWJOO4P5jpnmrljUlp9JjwRI8UXs2LSW+87f69y3R/pUbIt1OBRCGAxZg/bufIb6RMrJACI/9M2ks7MXBXQvSkAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357246; c=relaxed/simple;
	bh=2VX3ogYBbEGWdCn4IL0Y2X0UQbpTXpX6DyfqyEZ9x+k=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=PLLqX1g1eIt2IqFfSofHsK+d/Dhe/mieI29FY6sZ6uDgug5oo2ynQpkT1y2//u2Xa/Wog4KRVRDVgVMwgCgTIV9PW6BQGg+itKxmKWbN14OsoN3+LoF8kb5IY95I+YbH5p4KhBv/vv85Vt1uqHmM5ur4tllV9/rdrDGamGTAf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkLvSsib; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkLvSsib"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 837D061645
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 16:07:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCSQkUqmbp6i for <virtualization@lists.linux-foundation.org>;
 Fri, 10 May 2024 16:07:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=augustojv@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 79C1A61624
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79C1A61624
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GkLvSsib
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79C1A61624
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 16:07:23 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6f449ea8e37so1866434b3a.3
        for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715357243; x=1715962043; darn=lists.linux-foundation.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=emwPcP+UOomywrO19po/BfKitYx4Veia1c0y3w25eu0=;
        b=GkLvSsibvPoqAklL07Sy+9VRKHBkLiEvboWW1suPo4kWhKtnVJYCSIZ3GjfkMduwKg
         TJdHjH88BZTAGQUg3/IA+Nbp+bIbeJqIlfwXkM3tEI1KVtdTeyftE4l1aF9H+ulPdvqf
         D62Ok5HNYovrUylpAzZWZxNd2BM9XoMBkZpQcXhHRM5wUDkLDi3wVnNFleCn/A1Ezjo4
         lrg1FofRITzT68TucEGvt80FPXRip8Mu/IHJDbzglZDT3wmCV/BnPbA1RfxurfTMVyXb
         wJmSKTA3F+/wiSckdrqBP1QjiaTd2Rj+4IJk0TbQxB54ADwMercz2rsVp9GnPvGirjpk
         i/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715357243; x=1715962043;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emwPcP+UOomywrO19po/BfKitYx4Veia1c0y3w25eu0=;
        b=eUd9MxuoqLhRGgVeZ5hpkCvx5+mhnRvbD+5Ui/5BEaXrbF7I7TQcnjHQXJgXDzGAQz
         NJ/r20aSuJDkT6EBOhyixQky2q4RoTzT5mka5jfqdyLrP2SsolX7IIelaFnsdHxIEgfg
         DpmTeC7AnKhcUIisXguYR9xKHuL6EFvT9iqEjc5QvAenQLjVwUpblGTOKBc3dx/vc4p6
         Sx14YQ0KDvagTd/rYg8RDEa7kK8xH9VMSdNyq836sx4XsX67ZScqleH0F3sBbi19T7GL
         aQFIT6zqRe0U4RKhwImLSloU/Hp4soj6ChXC/0OABufRUQA8q0CobExKUHZM4gsh0LQu
         juZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/rwLKhQpIX7S9EiQtENS/+zy/fgF/BHzFhPDN4GZE2EiOOBOwWhsiJ+SHCEOj/lVJuqyQzPwagGNve6vlUlBEmSNYeVtJRyEgqJfVhDPeGIt/yys7e+qrnA==
X-Gm-Message-State: AOJu0Yw+Y1KUutclBleP8gAIONViCT7TaPZyhsnXrmC9XkfWPDKPNPve
	KIRIdTd95xvqnUtxdb3dRgOO29ByviW9o38vcp3ZCKWk2mW14fh2
X-Google-Smtp-Source: AGHT+IHJkcQLWRnIXrq2n68ANZDu+reKtVa9vItTsbcOd9ufKfbLgPJObBrxOSwoiA4xRMlRKDDIlg==
X-Received: by 2002:a05:6a00:4b04:b0:6ea:749c:7849 with SMTP id d2e1a72fcca58-6f4e02addcfmr3714869b3a.13.1715357242477;
        Fri, 10 May 2024 09:07:22 -0700 (PDT)
Received: from smtpclient.apple ([2603:8001:3300:beea:75ae:6644:7a8:4452])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a82889sm3111874b3a.47.2024.05.10.09.07.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2024 09:07:22 -0700 (PDT)
From: Augusto Vega <augustojv@gmail.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_98DAA8EC-AD2D-484A-B631-B15F5F28ACB8";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: IEEE/ACM 51st International Symposium on Computer Architecture (ISCA
 2024)
Message-Id: <D4422C2C-DFAD-4D63-AF51-8AD1059F64E3@gmail.com>
Date: Fri, 10 May 2024 09:07:08 -0700
To: conferences@newsmaster.tgc.com,
 contiki-developers@lists.sourceforge.net,
 cphc-conf@jiscmail.ac.uk,
 csc@lists.purdue.edu,
 DAI-List@mcc.com,
 discuss@ieeetcsc.org,
 distributed-computing-announce@datasys.cs.iit.edu,
 editor@hpcwire.com,
 end2end-china@netarchlab.tsinghua.edu.cn,
 grideditor@gridtoday.com,
 GRUPO@gsd.inesc-id.pt,
 hpc-announce@mcs.anl.gov,
 icec@listserver.tue.nl,
 info@autonomic-communication.org,
 INVESTIGADORES@inesc-id.pt,
 iot-edge-cloud@comsoc.org,
 mmb@ira.uka.de,
 multicomm@comsoc.org,
 NGN@jiscmail.ac.uk,
 performance@merlot.usc.edu,
 planning@asu.edu,
 podc-related@acm.org,
 publicity@hipeac.net,
 remarks@psc.edu,
 SIGCOMM-MEMBERS@acm.org,
 sigcomm@postel.org,
 sigmetrics-bb@merlot.usc.edu,
 sigplan-l@acm.uiuc.edu,
 SIGSIM@acm.org,
 socinfo@cs.tut.fi,
 spectrum-webmaster@ieee.org,
 storage-research-list@ece.cmu.edu,
 tccc-announce@comsoc.org,
 tccn@comsoc.org,
 tcsc@cse.stfx.ca,
 tfcc@clustercomputing.org,
 uksim@glam.ac.uk,
 virtualization@lists.linux-foundation.org,
 webmaster@ncsa.uiuc.edu,
 hpc-announce-bounces@mcs.anl.gov,
 socinfo-bounces@lists.tuni.fi,
 fpga-list-bounces@mailman.sydney.edu.au
X-Mailer: Apple Mail (2.3774.500.171.1.1)


--Apple-Mail=_98DAA8EC-AD2D-484A-B631-B15F5F28ACB8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

*=
**************************************************************************=
*******************
      ISCA 2024 - BUENOS AIRES, ARGENTINA - CALL FOR PARTICIPATION
=
**************************************************************************=
********************
       =3D=3D=3D> Early-Registration Deadline:  May 13, 2024
       =3D=3D=3D> Location:  Buenos Aires (Argentina)
=
**************************************************************************=
********************

The International Symposium on Computer Architecture (ISCA) is the =
premier
forum for new ideas and experimental results in computer architecture. =
The
conference seeks particularly forward-looking and novel submissions.
In 2024, the 51st edition of ISCA will be held in Buenos Aires, =
Argentina,
at the Hilton Buenos Aires during June 29 - July 3, 2024.
This is a historic event as ISCA will be held in Latin America for the =
first
time ever. Let=E2=80=99s make history together!

For more details on ISCA 2024, please visit the main conference website:
https://iscaconf.org/isca2024/

=
**************************************************************************=
********************



--Apple-Mail=_98DAA8EC-AD2D-484A-B631-B15F5F28ACB8
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCAzgw
ggM0MIICHKADAgECAgoBDAd4Iz7rGHvCMA0GCSqGSIb3DQEBCwUAMEgxFTATBgNVBAMTDEF1Z3Vz
dG8gVmVnYTEiMCAGCSqGSIb3DQEJARYTYXVndXN0b2p2QGdtYWlsLmNvbTELMAkGA1UEBhMCVVMw
HhcNMjExMjEwMDA0MjIzWhcNMjYxMjEwMDA0MjIzWjBIMRUwEwYDVQQDEwxBdWd1c3RvIFZlZ2Ex
IjAgBgkqhkiG9w0BCQEWE2F1Z3VzdG9qdkBnbWFpbC5jb20xCzAJBgNVBAYTAlVTMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoBUKvVWnSJR1VxKMTDbqXPLxbuLSLZUp/I2euDPkLvAN
Uhnuk91Y2/b9xmGTAHQ/W0y+WyEf+Ux2otyN7wrFGv/pJ2EU/L7agTrWVcXjg/xoVVJJb8GYudNA
D1sRWE+PYHtoqha/7kse6CEixLzNRx7As4xmu66AIJvhc4Gb5xoxnQB5SbPp0tA7BryA/9eFQH8w
gS7R1Vvc7zDIj24ldRXiYbgVcVyghnBSLzjEmacIjTDTbnnVifdKq0hwJkZQURYPIizlZqYADKbv
rCkcJ7LNSRO4Etb3SyxiNB2R5Y4pb90yIeahi0nXCi2qJ0pjO3Z48JwRFrkhI1sV9oiCuQIDAQAB
oyAwHjAPBgkqhkiG9y8BAQoEAgUAMAsGA1UdDwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAd1SO
BK/u+xE5eSXBbmakxf7CW34YF5Jd7OV8qY8jLQyDu8OaFbEKCo1sEae0QXGdkTE/x94VznNi9jI6
3gz1w8yb7/OVtkHh5tizmK0NXEfTs3osLYD+O42L1v22Lq+Q5FsZ2wvsOLk1CHGSZ+RKiKy+4mhu
UUb1iPFqINgGyPDo8/D26y4iLdhxLjUykyNMOehDvkl/DlSb5GXLhdohfKrnxUAhEVBFkoDFqCS7
YSitA/o71aQfggsfZqB8bcZ3NkRl7kXxqG/CGoz0AwntM56AGOVGvUuULGVEMtHBrjlQD7QoDj4p
T5RPJ02UXGb0b/sd/M9XvLhwmrAEQHmGNTGCAewwggHoAgEBMFYwSDEVMBMGA1UEAxMMQXVndXN0
byBWZWdhMSIwIAYJKoZIhvcNAQkBFhNhdWd1c3RvanZAZ21haWwuY29tMQswCQYDVQQGEwJVUwIK
AQwHeCM+6xh7wjANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MDUxMDE2MDcwOFowLwYJKoZIhvcNAQkEMSIEIPn69ia5Mg3rNY347Ugr
C0DPLiZkowEN4/k3lWTnBkT8MA0GCSqGSIb3DQEBCwUABIIBAG1w59XhDx6Xq+e9K9RFTc2SzhW5
8t3TYd9h0w3IvIlhkzvgLCaHHcWE9ill/reg+VMMNiTFTfZLucVeF75vuPDrevRK18RsGh6ttTg+
oyQjlcTqi3T+sKyd4W9VNiRpIReq4mtXIHm7Aplis1o7Fg2ID1P/Nw0Rx2sYQZ/VfkJlcwEDCbyN
nMzv7XLMHeE4e0Rkd38zXi67GG8PFifPtVt6T4rdk13S19OLAJCVyE0dU14b7aTQspqGIL+XDY0n
yR+TNQDUrQVEvZAl6J0x/bYmCMnXqS1Of5xtYBwdUr3Sg59lZix3rIS0YfUvd7HOPFnln8j9uz/B
eKpYJuh4ZKMAAAAAAAA=
--Apple-Mail=_98DAA8EC-AD2D-484A-B631-B15F5F28ACB8--
