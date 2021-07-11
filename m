Return-Path: <SRS0=5BC2=MD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05E2C07E96
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 12:21:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D35E611AC
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 12:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D35E611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 232BF839E6;
	Sun, 11 Jul 2021 12:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TF81g-l0nwxl; Sun, 11 Jul 2021 12:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 732A6839DB;
	Sun, 11 Jul 2021 12:21:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A3A5C0010;
	Sun, 11 Jul 2021 12:21:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C837BC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 12:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id B7C9960687
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 12:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=podzimek.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id jp71Bwgi_ax2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 12:21:06 +0000 (UTC)
X-Greylist: delayed 00:05:02 by SQLgrey-1.8.0
Received: from charon.podzimek.org (charon.podzimek.org
 [IPv6:2a02:168:5cd0::abcd])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 02655605D4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=podzimek.org;
 s=charon; t=1626005758;
 bh=2FLlwFX3/+xUY/MLAu6Qf6iF4Brbcd3mpjWDEW8EuPM=; l=23179;
 h=From:Subject:To:Date;
 b=YQiaT3pCCbFtNM82x6ubF8aNCcpuO80lD/hN4tJzDez/m4GwLgngBqIqT+663N0UA
 S1QEMFLj/1RgTofM9+TGxbuJLuOPa+jRcbyf9OOMmIM2nGamoDZVvxeywtIz0AiDTY
 2f4cSFx1ho1QKEDCFWouYSIsH8441i68EGUC63hFMo27Hq6iRQARepd/mGPVS1eFzC
 rU5dy/2+ozQwQ4593sUNUxEjODfgw56v9TaZSEsNO37i9w0jn82sUUY/VZl+h8yz7O
 I14rvdPzTtYHIp51JfMqDbYvGUu26SrGntPEJs2TFndxIZtWnDJxLwfWMznQjnzwz7
 UZpgOac7wOB6Q==
Original-Subject: Running VMs with an eGPU and VFIO: from flaky (<= 5.12.x) to
 broken (5.13.x)
Original-From: Andrej Podzimek <andrej@podzimek.org>
Received: from charon.podzimek.org (localhost [::1])
 (AUTH: CRAM-MD5 andrej@podzimek.org, SSL: TLSv1.3, 128bits,
 TLS_AES_128_GCM_SHA256) by charon.podzimek.org with ESMTPSA
 id 00000000005E8C4F.0000000060EAE0FE.000053E0; Sun, 11 Jul 2021 14:15:58 +0200
Subject: Running VMs with an eGPU and VFIO: from flaky (<= 5.12.x) to broken
 (5.13.x)
To: virtualization@lists.linux-foundation.org
Message-ID: <3660d7f0-f166-a8e8-7782-9e2b3433d1e3@podzimek.org>
Date: Sun, 11 Jul 2021 14:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Mime-Version: 1.0
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
From: Andrej Podzimek via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Andrej Podzimek <andrej@podzimek.org>
Content-Type: multipart/mixed; boundary="===============5008915573928955118=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============5008915573928955118==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="=_charon.podzimek.org-21472-1626005758-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_charon.podzimek.org-21472-1626005758-0001-2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear virtualization mailing list,

My question may well be misplaced, because it's Thunderbolt-, eGPU- as we=
ll as NVidia-related, but I'm out of ideas where else to ask. (Should I a=
sk in a qemu- or libvirt-specific list instead? If so, please give me a h=
int.)

First, here's the configuration of the physical (host) machine:

         Command line: pcie_ports=3Dnative pci=3Dassign-busses,hpbussize=3D=
0x33,realloc,hpmmiosize=3D256M,hpmmioprefsize=3D16G mem_encrypt=3Don
            lspci -tv: https://pastebin.com/raw/usBudC1y
          Motherboard: ASRock x570 Creator with BIOS 3.50
                  CPU: AMD Ryzen 3950X
               System: ArchLinux with kernel 5.12.15 / 5.13.1
       eGPU enclosure: Razer Core X Chroma
             eGPU GPU: NVidia Quadro P5000
        UEFI settings: Above 64b decoding, IOMMU and SR-IOV all *enabled*=

     Other PCIe slots:
                      GPU: AMD Radeon Pro W5700
                       M2: Two Seagate FireCuda 520 (ZP2000GM30002)
                     WiFi: Intel AX200 (factory-default)

The eGPU is configured like this in libvirt:

     <hostdev mode=3D"subsystem" type=3D"pci" managed=3D"yes">
       <source><address domain=3D"0x0000" bus=3D"0x3d" slot=3D"0x00" func=
tion=3D"0x0"/></source>
       <address type=3D"pci" domain=3D"0x0000" bus=3D"0x07" slot=3D"0x00"=
 function=3D"0x0"/>
     </hostdev>

Now the problem: Forwarding of the NVidia card inside the eGPU into virtu=
al machines was flaky up to 5.12.x (i.e., sometimes worked, sometimes did=
n't) and stopped working entirely in 5.13:

     virsh # start FreeBSD
     error: Failed to start domain 'FreeBSD'
     error: internal error: qemu unexpectedly closed the monitor: 2021-07=
-11T10:34:09.102381Z qemu-system-x86_64: -device vfio-pci,host=3D0000:3d:=
00.0,id=3Dhostdev0,bus=3Dpci.6,addr=3D0x0: vfio 0000:3d:00.0: error getti=
ng device from group 49: Invalid argument
     Verify all devices in group 49 are bound to vfio-<bus> or pci-stub a=
nd not already in use

     virsh # start Windows
     error: Failed to start domain 'Windows'
     error: internal error: qemu unexpectedly closed the monitor: qxl_sen=
d_events: spice-server bug: guest stopped, ignoring
     2021-07-11T10:34:36.163549Z qemu-system-x86_64: -device vfio-pci,hos=
t=3D0000:3d:00.0,id=3Dhostdev0,bus=3Dpci.7,addr=3D0x0: vfio_listener_regi=
on_add received unaligned region
     2021-07-11T10:34:39.432499Z qemu-system-x86_64: -device vfio-pci,hos=
t=3D0000:3d:00.0,id=3Dhostdev0,bus=3Dpci.7,addr=3D0x0: vfio_listener_regi=
on_del received unaligned region
     2021-07-11T10:34:39.567039Z qemu-system-x86_64: -device vfio-pci,hos=
t=3D0000:3d:00.0,id=3Dhostdev0,bus=3Dpci.7,addr=3D0x0: vfio 0000:3d:00.0:=
 error getting device from group 49: Invalid argument
     Verify all devices in group 49 are bound to vfio-<bus> or pci-stub a=
nd not already in use

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
With 5.12.x:

There were "lucky" and "unlucky" boots/uptimes. VMs could be started and =
restarted arbitrarily during the "lucky" uptimes and the NVidia eGPU work=
ed flawlessly. During an "unlucky" uptime, the errors above popped up eve=
ry single time and no VMs using the eGPU could be started. Restarts of th=
e eGPU did not help. The likelihood of a "lucky" uptime was roughly 1:3, =
so it took quite a few reboots to get there. :-( /o\
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
With 5.13.x:

After boot, the eGPU on Thunderbolt initially doesn't work at all. It won=
't show up in lspci, the nvidia module is not loaded etc. Switching the e=
GPU off/on won't help. Surprisingly, the only way to make it initialize (=
that I've discovered thus far) is:
     modprobe -r thunderbolt
     modprobe thunderbolt

After that^^^ the eGPU and NVidia GPU are detected, modules are loaded, n=
vidia-smi works and shows information etc., but attempts at VM startup _a=
lways_ produces the errors above. I have not seen a "lucky" uptime in >50=
 boots. :-( Also, before unloading+reloading of thunderbolt, there is sim=
ply no device 3d:00.0 anywhere on PCI (and no trace of NVidia elsewhere),=
 so that machine state is a (VM) non-starter.

What else I tried:
     * options thunderbolt start_icm=3D1  -- no change (plus admittedly I=
 have no clue what the internal connection manager means/does)
     * options vfio_iommu_type1 disable_hugepages=3D1  -- "What if the 'u=
naligned region' is related to huge pages?" No change here either. /o\
     * a huge lot of reboots, Thunderbolt disconnects/reconnects etc. Nop=
e. It won't work.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Final note: Without the extra command line tokens, namely pcie_ports=3Dna=
tive pci=3Dassign-busses,hpbussize=3D0x33,realloc,hpmmiosize=3D256M,hpmmi=
oprefsize=3D16G, the NVidia eGPU just won't work, neither on 5.12.x nor o=
n 5.13.x. Way more details about that are here:
     https://egpu.io/forums/postid/90608/
     https://bbs.archlinux.org/viewtopic.php?id=3D261303

What should I try next to debug the issue and, importantly, to keep my VM=
s working on 5.13.x and beyond? Any ideas, tips, magic kernel command lin=
e tokens etc. would be very helpful.

Cheers!
Andrej


--=_charon.podzimek.org-21472-1626005758-0001-2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
JwEwgga+MIIEpqADAgECAg8FRNZOrR7TNtUyQF0AuTYwDQYJKoZIhvcNAQELBQAwRzELMAkG
A1UEBhMCQ0gxFTATBgNVBAoTDFN3aXNzU2lnbiBBRzEhMB8GA1UEAxMYU3dpc3NTaWduIFNp
bHZlciBDQSAtIEcyMB4XDTE0MDkxOTIwMzY0OVoXDTI5MDkxNTIwMzY0OVowVjELMAkGA1UE
BhMCQ0gxFTATBgNVBAoTDFN3aXNzU2lnbiBBRzEwMC4GA1UEAxMnU3dpc3NTaWduIFBlcnNv
bmFsIFNpbHZlciBDQSAyMDE0IC0gRzIyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyzmxOYX++smhvMODqQ5KLYRyHv9oxafEHewP16iLEx6z0RaLQNwPU28BPezoZLWX24O8
qKjAhDhYXgMUK+bKMO8AsusTORmSRyohAOVyzcIxYg7MVir/d8RjjJjCb3jXtbbM6X0fM6aR
BSr+0VLW9Oyc/k1MalLhhXZiu7lo5lJj/MEhkZJdGdjcgNEZ40kWVwIOGUSFqynJL/rGbWsK
ofb3/2thNRUmlJQCaSVdafe9XmuC2ZAMBvlDBSJJ6zbQIFpjEOM4IdV/FitBikZ68mfopNC6
Hn8kJ3WYlEktVsRUM5GdYvnVX95bqRWYnJRTwYDpCRcVtBuAKTKh0K8TpwIDAQABo4ICljCC
ApIwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFPDHozKR
tevKtVh3FadOvhpdYUMlMB8GA1UdIwQYMBaAFBegzcHkQbY6WzvLRZ29HMKY+oZYMIH/BgNV
HR8EgfcwgfQwR6BFoEOGQWh0dHA6Ly9jcmwuc3dpc3NzaWduLm5ldC8xN0EwQ0RDMUU0NDFC
NjNBNUIzQkNCNDU5REJEMUNDMjk4RkE4NjU4MIGooIGloIGihoGfbGRhcDovL2RpcmVjdG9y
eS5zd2lzc3NpZ24ubmV0L0NOPTE3QTBDREMxRTQ0MUI2M0E1QjNCQ0I0NTlEQkQxQ0MyOThG
QTg2NTglMkNPPVN3aXNzU2lnbiUyQ0M9Q0g/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9i
YXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MGEGA1UdIARaMFgwVgYJYIV0
AVkBAwEGMEkwRwYIKwYBBQUHAgEWO2h0dHA6Ly9yZXBvc2l0b3J5LnN3aXNzc2lnbi5jb20v
U3dpc3NTaWduLVNpbHZlci1DUC1DUFMucGRmMIHGBggrBgEFBQcBAQSBuTCBtjBkBggrBgEF
BQcwAoZYaHR0cDovL3N3aXNzc2lnbi5uZXQvY2dpLWJpbi9hdXRob3JpdHkvZG93bmxvYWQv
MTdBMENEQzFFNDQxQjYzQTVCM0JDQjQ1OURCRDFDQzI5OEZBODY1ODBOBggrBgEFBQcwAYZC
aHR0cDovL29jc3Auc3dpc3NzaWduLm5ldC8xN0EwQ0RDMUU0NDFCNjNBNUIzQkNCNDU5REJE
MUNDMjk4RkE4NjU4MA0GCSqGSIb3DQEBCwUAA4ICAQDDeadXt3utUWj1RIxBlSgBfHTWO2q8
be+n1005mR1ojcoI2dBxsRk1k2+CxhxJuFHuTPlsCm/Ypfv++zBeANKUq8QSUbqqiqtq3RnX
K0r3FrJrUc90Wymic96X/thPICF9aQywUOWNWIyALuUXHN1jeqrvBfnDaZ7kjHFiXELuOvLN
4BLvi1zpzlMoMuyVCxlUoiGN+n9Qp0+8GXuya4wpP3c+yiPHaVpBnX1mMW96cXnaqWU663/X
ENULX1QZfM43JSSEUNCvQDTCX5LiepHzL0JHG588QvvZX6W8cEWO76A5kPWheGzXwGdZGeEA
3lz8eOhP3buskS5yi/zqR29DKLy7uY6UvvpQ3VCTG0wYtnb/w0cKWbTNbVXYarZfyS/BlDY+
vq5ANQYg7eACTC00RQ5Dr6L02JAV5dDAm0RArjyPk1G8mWhzaXt1WJm31ARP3/GCcREde/wT
HXdlVWPXUnJ83TFHhqeV2KwmcT0j5hI79H+alob+K+qg8yYNdcYWjDEg5xFHoeeparClsoEe
3D3QoeNu1fBmphx915KITQAHC3Hnc+dz5FRlafw3jfEeb3Dup2yzUkVnWdYFSLEh6Zco2dn0
tKagZyM2vGBHDlwof12TijG6jTE2FMd6Qp1vIMFsKvgWD2rZAJQyuz1VscXDoQ2xeXdUHeAz
gn7u6jCCDNowggvCoAMCAQICFHJvOTW77OIZRY9RmBP3WbTCIk32MA0GCSqGSIb3DQEBCwUA
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
och4XFSG1mEBWweZJDj5dwud3Ulg6T6BeTpZW5lEoY9RSPOQYlDzSZzTyBl2U2gMRq9RSW+t
0umFZfpcHKk2ZRSIs7lJbitbaKVGZ8qp36CA1ps/2/0Ire6Mzyi6ikzyQ6RQRLobWOvBNcRA
3tc1F9rFv9a2CcvrxogORMPOn6JcAokM3X/Grp227AlVDrZN8bQGiNnwHocuborfYipyMCDG
J/YMTYMIBQgGp8EQljAVqSrflUwZdmsx7NCmgqORB0rOUD1jpEGk3XNT1B6x1q/DKx8K/C7o
Dp6aIxl5Rs2Fp9Oy3dUF0dvnJ/IlhuDNHLxP9vg/JVEeBbP0wYxl006YXTwP0jNdmEGHWdwz
ADw6Jgqqo6+3NoW7bX3zZiyG0Ks5FyaUMZ7ZPTBs55JTPeX+G33Oa6JoMJVGqIj3Bg2r8p3D
+wD5aFlWdYq3V85nVAiGKYgeh5vfaDVtMtzIo4QQkQZqfQYyj4pLeuC14srrhT65hNW+BSDK
ZLI79ENG8lyM2XOVBftG7sCcOvElUJ+mVLS9chx3sxrpFkI/VfeBAgMBAAGjggLCMIICvjAe
BgNVHREEFzAVgRNhbmRyZWpAcG9kemltZWsub3JnMA4GA1UdDwEB/wQEAwIEsDATBgNVHSUE
DDAKBggrBgEFBQcDBDAdBgNVHQ4EFgQU7cpFmtaM509Gpv+36UD0qbaInagwHwYDVR0jBBgw
FoAU8MejMpG168q1WHcVp06+Gl1hQyUwgf8GA1UdHwSB9zCB9DBHoEWgQ4ZBaHR0cDovL2Ny
bC5zd2lzc3NpZ24ubmV0L0YwQzdBMzMyOTFCNUVCQ0FCNTU4NzcxNUE3NEVCRTFBNUQ2MTQz
MjUwgaiggaWggaKGgZ9sZGFwOi8vZGlyZWN0b3J5LnN3aXNzc2lnbi5uZXQvQ049RjBDN0Ez
MzI5MUI1RUJDQUI1NTg3NzE1QTc0RUJFMUE1RDYxNDMyNSUyQ089U3dpc3NTaWduJTJDQz1D
SD9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJp
YnV0aW9uUG9pbnQwbAYDVR0gBGUwYzBXBglghXQBWQEDAQ0wSjBIBggrBgEFBQcCARY8aHR0
cHM6Ly9yZXBvc2l0b3J5LnN3aXNzc2lnbi5jb20vU3dpc3NTaWduLVNpbHZlci1DUC1DUFMu
cGRmMAgGBgQAj3oBAzCBxgYIKwYBBQUHAQEEgbkwgbYwZAYIKwYBBQUHMAKGWGh0dHA6Ly9z
d2lzc3NpZ24ubmV0L2NnaS1iaW4vYXV0aG9yaXR5L2Rvd25sb2FkL0YwQzdBMzMyOTFCNUVC
Q0FCNTU4NzcxNUE3NEVCRTFBNUQ2MTQzMjUwTgYIKwYBBQUHMAGGQmh0dHA6Ly9vY3NwLnN3
aXNzc2lnbi5uZXQvRjBDN0EzMzI5MUI1RUJDQUI1NTg3NzE1QTc0RUJFMUE1RDYxNDMyNTAN
BgkqhkiG9w0BAQsFAAOCAQEADOc1cefp9MgK4kU/BMR5t9z+GE3Ev7lbCNYdJebSqmpZ+Yv8
MrNa06L4i2XFyXCb/IcLZTDNnB+XqgHOiOZiV9W3D5kcdhH2CvfFMbPbCfOuOW9b6HczXyww
BkC59lvg61Jsd+niqVzFmoTnXKtWgEYeFKvQAeD4g4+y3b9cZmxeIpjH04TnVnja4lfzeFGx
M0CX468nC4a4tc8e5n8UuNbcyHiqteHXMiz27DKJU5IpBMe5hZfsEC8frHFKGjdT+jdiZGJx
Jzy7OFLw0i/dAf0GWlXMbKwu1m4ljowwZ9buRwxNXj8gjs6HqNZNALC4OSu65JYqJ84689hi
gyctPjCCE10wggtFoAMCAQICAQMwDQYJKoZIhvcNAQENBQAwdTELMAkGA1UEBhMCQ0gxEDAO
BgNVBAgMB1rDvHJpY2gxEDAOBgNVBAcMB1rDvHJpY2gxFTATBgNVBAoMDHBvZHppbWVrLm9y
ZzELMAkGA1UECwwCQ0ExHjAcBgNVBAMMFVBvZHppbWVrIFRoaXJkIENBIFJTQTAeFw0yMDEy
MTIwNTQ3MTdaFw0yMTEyMjIwNTQ3MTdaMHMxCzAJBgNVBAYTAkNIMRAwDgYDVQQIDAdaw7xy
aWNoMRAwDgYDVQQHDAdaw7xyaWNoMRUwEwYDVQQKDAxwb2R6aW1lay5vcmcxDzANBgNVBAsM
BlBlb3BsZTEYMBYGA1UEAwwPQW5kcmVqIFBvZHppbWVrMIIIIjANBgkqhkiG9w0BAQEFAAOC
CA8AMIIICgKCCAEA0ydv4tdblMNqtIEPIQ0AHkq/EnHYeGiZq16T9DMdwht4XfmgkeYaJJIf
JmRTH2r9+Jl7SGq9n/aShT0DeWsw4ZHcdRE1Mn6oziS9fVkhUU9qHagKbfvh8326zfodqaYZ
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
4gtGqL++P3iviOfw5uQEAoVHMBkV/s/dj0syCJL7t6K/NflAomgPO95QtBzoWV4Eu3+T6B+j
4/gtRDcQmIMLixqZBkLypvqggdyRCj64811nz0T27OhYOog5xt0D/HdKf1pTBUH4HafIgpd2
FNpr3P7h8lUCAwEAAaOCAfgwggH0MB0GA1UdDgQWBBSmNKVppytd1zvuoeYhZXAVGYuYjDAf
BgNVHSMEGDAWgBRSrBnMfyjS8iUnSpp1rdcD1Kv7IDAOBgNVHQ8BAf8EBAMCBPAwDAYDVR0T
AQH/BAIwADAqBgNVHSUBAf8EIDAeBggrBgEFBQcDBAYIKwYBBQUHAwIGCCsGAQUFBwMDMCEG
A1UdEQEB/wQXMBWBE2FuZHJlakBwb2R6aW1lay5vcmcwgdAGCCsGAQUFBwEBBIHDMIHAMDgG
CCsGAQUFBzAChixodHRwczovL2NhLnBvZHppbWVrLm9yZy9wb2R6aW1lazMtcnNhLWNhLmNy
dDA3BggrBgEFBQcwAoYraHR0cDovL2NhLnBvZHppbWVrLm9yZy9wb2R6aW1lazMtcnNhLWNh
LmNydDAlBggrBgEFBQcwAYYZaHR0cHM6Ly9vY3NwLnBvZHppbWVrLm9yZzAkBggrBgEFBQcw
AYYYaHR0cDovL29jc3AucG9kemltZWsub3JnMHIGA1UdHwRrMGkwM6AxoC+GLWh0dHBzOi8v
Y2EucG9kemltZWsub3JnL3BvZHppbWVrMy1yc2EtY3JsLnBlbTAyoDCgLoYsaHR0cDovL2Nh
LnBvZHppbWVrLm9yZy9wb2R6aW1lazMtcnNhLWNybC5wZW0wDQYJKoZIhvcNAQENBQADgggB
ABrjxk0wGvBJz4t4awB9Q4Ptoa+iF6ppIdHBmiwFXaOGT6m6PmPF9F33G+grHUtlJ7a58iq2
X7q4hFUKqXfDtXUHZV/BHTfHpnyIFXMmH7SV10mxOpYvGYVtZxPZT/ROkG3gxaIvOKuxJkQN
p5LNq9Yl7vM4Nn1ePdElJhcfrf74fXH8lx4S9mTTrn49K+4Lu+/aNsz8X1AQ8dSHPP0IVTjf
uY9aMKE5mdU33fA3I+qDJeJ6pN9e1d+TN4TvWn86K7SAoiOZP/soKcOH2OtdVtZSkdbXFskY
Zgea2WJrj3X29m9fGJvvA5SsMXRVEH4VcosTzI73UP/yK6szkL4CvI8yH5Rb2Obsbd0pBGM4
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
trXZIw16NqQ4zrztXO9eMZDFWRkAAAAAAAA=
--=_charon.podzimek.org-21472-1626005758-0001-2--

--===============5008915573928955118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5008915573928955118==--
