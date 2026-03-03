Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C93D6480
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547445; cv=pass; b=kQ9lhR1YZhGC79l0iXQk01PZG91wbgdSQ1/hcswIuCd7/sWNTWaLqk0m4hJVjfUgM7EvSVjeMbf7LR21UgvQZ6ZgtsPiti4d0VM6FnbycBGJF1NulZf7ln1k0Ch2dsbddlGOX7RVB7UGv+a/ngiqZLHJbwYTsmH7ZEW5MXXfrgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547445; c=relaxed/simple;
	bh=tW11UZ48ZLVdX7r9Xyaby54fN14d7Pwluit8BSawxiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8SmiVMjqe53WFN1XHoFUR0lKvIe2VYoWdsaWfP3XX/GOqIKEdYg+46H+pcdMIDOKD40trbelU8HW0F/tZm3I+1eMGKfpNVQu7/XVbXh450RWm8av5PckS2iq70ALLyfvs/Yk4HpL2wHj25wx9gzsYyXXN1h4BQWdG7ICxaohB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hUANKDob; arc=pass smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hUANKDob"
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-127380532eeso355679c88.1
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 06:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772547444; x=1773152244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jITH9L5syd2e6/OkEd5bc3LKGLdqIWPdvscqL5khSb8=;
        b=rXEFZy/Z02HhZPJeAwk4U+Qu5v8tFL2dxgszYPj8AuDU4MHKKyliySa4+LTvQXylWS
         khz9Bhlfkaolf/QLzgkzX6dZX+ssscGijlJm4pGcy4fjf6iPxGWSslWdCLn4U3OyHZc1
         QdMTOVirmzH8S0hc0IQd/guo0zFYHe+JReZID5Vb0igidiDbgR+FauUM8Ke2LCiBK8iu
         IPbxZjDK6tSrIUM9dMUI+jNDYoDH9lw26Ij66TEKSAYALcAVg/VTX9zOyBOuuzf8HwZY
         zVyMcByTmzx9FVukgUuvrgOD9aF1JpL8ycGXfD+BRPeGUZYjNaMAGk555OgTSd3/eHDL
         Rm4A==
X-Forwarded-Encrypted: i=2; AJvYcCWlFw7oJopclPiBFlhBXA8Bq4rwvuHBvgWAikXNSYC0aFtGlw7XneKm3AlP8RFIh7l8K5o7W1JBWO1F/Lz9NA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOnL3lB/KaF+L82SmmvKgXN+QcRZj86SjcYmd8UM7JVRKHwquS
	klO07mO4teBE5YTww68JKeE+U705V5KC4twCdcPi4ulGbNWt4zCLkvUHCL76XbUqVzfnktnXuFj
	deygniXqEfUsg4aEskgl4sOyBm++ODksCfVLq7gfnHTcqfDQYVSLbtx5MZtbUc1/ykRYW/C7TSB
	cET39pKW4Sa5D1bt2x5sFCwypD3n8n+YfA01UivXXYPaYLYq5ebdowQW9n39LaNnnH/9XpcTTOY
	GeSyriNU0RiSnUWOj8nuIKE
X-Gm-Gg: ATEYQzz7wb2x9caaaW8rq6Cv/jEGPhAxSyxK/H9jhaATy0M8BjWnqLvFAU0lC1lWbKZ
	FijpFJVRwUX+1QO6UTI4OD0hqT6Tm9gnxoO+kVoPu3EWu1XmnVDWZG3aNu3ntokB4TrRwMS3Pc/
	j3WAm3tvM8QQtXTqEEBYkP50cSvzgaxyRBbNQZymys+jogFSFwnKyJJA9VexzXfc8CieXnw3TR/
	RXYFEi5obIlYq5ID/qeIYbxLUWF9rPmGoiDXDwFXFIwI2XWR9xnawBsoRztFPuLUdbIVP/Tv0l0
	uiK9m9uEC3qh9MvYBjLTpqS1fHrfxKTKXefsuoQ452KKoDJEsKpuNzfg9RTh02U2hE4T9LF9dOh
	by8ss1jHABbGhjfs4gumsTnuh9pLavmg68Re/Io2cpvzxSKFgMBzZ0C7jarzeYa9PH2O93nFvX4
	xwJ8D2IoCYitRzrxqCnT4iBMnWA0Buclo36G5QgLFBkG+JDt2J8VIx8qU9oh4=
X-Received: by 2002:a05:7022:4381:b0:11b:a3a7:65cd with SMTP id a92af1059eb24-1278fc48265mr5980445c88.12.1772547443217;
        Tue, 03 Mar 2026 06:17:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2be1ea57f34sm428893eec.11.2026.03.03.06.17.22
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2026 06:17:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3870692eb93so54733551fa.0
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 06:17:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772547441; cv=none;
        d=google.com; s=arc-20240605;
        b=KnlGfNAtHZRg6w3+7ZGnoqwlwuepXHq5uTSj3nZ7aczQbXpYem5jhyb1nsQpWJ42Jw
         hQyDlFdHQ3wkvDQeU+bpDE8KUcfb00Ld+HkiEMzrKWmnSQo5iOoM+t/abJ8CelinthFO
         cbfsF/BtfsBfUqgvBumNalFHq18uGCDxU8F48MUsrIJdL5slvokldOGuyJFBFWtFfvnO
         Qt7CCvDOclGLhilMYmuFWI9/fD2Z7axxu4flQwnXg+OWHbApOvvwAMI5KYw3jwbdCAx+
         2Fkn0cMwQ+QHvgrUu0dCf/+RhSeP+7THnkuftDhEZp9NL4HKSKdFOqyrXDzmmKNPbkii
         MrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jITH9L5syd2e6/OkEd5bc3LKGLdqIWPdvscqL5khSb8=;
        fh=5Ks3wj/ELO4Tg1mwFo0hZn9NtIFBYrHPH9pDTZzRiuA=;
        b=IESp+fa8Bk+WDF/6tMbZAXnn8V8E9KWn4ca1gPO18AggJ0GhLiWbk9pEZDRhASRurK
         koZd2DrBz1WLgYPwf9VMZ+VDdueTfqF4OeuNIk8NAV4+x3nHvK/l86iDx3CSm2JlDgqa
         U2vvV+YDZza6hPMOqQPSibj0yrBaC9Odt7G/ldGcLv8o0qd+X7bev1Q1/Be0Tt2CEdyV
         td7Tx1HqQhAHvYSqffGQVNsYesPpBbWf3mKjB2Ku/TWLPnAlVDdHuXvdcjUNGpqvoJOl
         tXTbeOhdc9RMa2Ye1VRR5NzDRtUu8gDNoTjGEJiwec1foiRAs48FdVvucheKTu0A6KiU
         PJTQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772547441; x=1773152241; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jITH9L5syd2e6/OkEd5bc3LKGLdqIWPdvscqL5khSb8=;
        b=hUANKDob97V3aluUcYoCLKYoLInbdnfAvO0Y2cfBD3DelJ1pRO/xlC2wIyG967VMrd
         XAWC0wd6YZoYKyLH/X1rCQKv6X9zaRfgCWGn4r3R2Lh322u+tdFbgGVz1Aa+cHh1weMq
         /kU3vT+yA2YNvfVj0MJU4r7WWEIJWTO64mhxA=
X-Forwarded-Encrypted: i=1; AJvYcCUptakg/45C4WtJQlySs/g6w8Zzn79NJqFK2CnxZJeYyxODc0gcawaq/HkLxAh5XQeFD9w6BJF5+T3zOrqZSA==@lists.linux.dev
X-Received: by 2002:a2e:9cd6:0:b0:389:fdb2:1068 with SMTP id 38308e7fff4ca-389ff357805mr91185211fa.34.1772547440735;
        Tue, 03 Mar 2026 06:17:20 -0800 (PST)
X-Received: by 2002:a2e:9cd6:0:b0:389:fdb2:1068 with SMTP id
 38308e7fff4ca-389ff357805mr91184971fa.34.1772547440157; Tue, 03 Mar 2026
 06:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260302104138.77555-1-graf@amazon.com> <aaVrsXMmULivV4Se@sgarzare-redhat>
 <aaV80wWlpjEtYCQJ@sgarzare-redhat> <17d63837-6028-475a-90df-6966329a0fc2@amazon.com>
 <aaW2FgoaXIJEymyR@sgarzare-redhat> <27dcad4e-d658-4b6b-93b2-44c64fcbeb11@amazon.com>
 <aaaqLbRNmoRHNTkh@sgarzare-redhat>
In-Reply-To: <aaaqLbRNmoRHNTkh@sgarzare-redhat>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Tue, 3 Mar 2026 14:17:07 +0000
X-Gm-Features: AaiRm52JEb6AVb0mzyIgBtpCH-MimPgZjYb76gWACsIcSJONxOy5WDbyUYProjc
Message-ID: <CAOuBmuaQwxKDJoirwtRwEP=690JcRX3Efk6z=udiOHsGr8u6ag@mail.gmail.com>
Subject: Re: [PATCH] vsock: Enable H2G override
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	eperezma@redhat.com, Jason Wang <jasowang@redhat.com>, mst@redhat.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, nh-open-source@amazon.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000944b93064c1f5cb8"

--000000000000944b93064c1f5cb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 9:49=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Mon, Mar 02, 2026 at 08:04:22PM +0100, Alexander Graf wrote:
> >
> >On 02.03.26 17:25, Stefano Garzarella wrote:
> >>On Mon, Mar 02, 2026 at 04:48:33PM +0100, Alexander Graf wrote:
> >>>
> >>>On 02.03.26 13:06, Stefano Garzarella wrote:
> >>>>CCing Bryan, Vishnu, and Broadcom list.
> >>>>
> >>>>On Mon, Mar 02, 2026 at 12:47:05PM +0100, Stefano Garzarella wrote:
> >>>>>
> >>>>>Please target net-next tree for this new feature.
> >>>>>
> >>>>>On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
> >>>>>>Vsock maintains a single CID number space which can be used to
> >>>>>>communicate to the host (G2H) or to a child-VM (H2G). The
> >>>>>>current logic
> >>>>>>trivially assumes that G2H is only relevant for CID <=3D 2
> >>>>>>because these
> >>>>>>target the hypervisor.  However, in environments like Nitro
> >>>>>>Enclaves, an
> >>>>>>instance that hosts vhost_vsock powered VMs may still want
> >>>>>>to communicate
> >>>>>>to Enclaves that are reachable at higher CIDs through
> >>>>>>virtio-vsock-pci.
> >>>>>>
> >>>>>>That means that for CID > 2, we really want an overlay. By
> >>>>>>default, all
> >>>>>>CIDs are owned by the hypervisor. But if vhost registers a
> >>>>>>CID, it takes
> >>>>>>precedence.  Implement that logic. Vhost already knows which CIDs i=
t
> >>>>>>supports anyway.
> >>>>>>
> >>>>>>With this logic, I can run a Nitro Enclave as well as a
> >>>>>>nested VM with
> >>>>>>vhost-vsock support in parallel, with the parent instance able to
> >>>>>>communicate to both simultaneously.
> >>>>>
> >>>>>I honestly don't understand why VMADDR_FLAG_TO_HOST (added
> >>>>>specifically for Nitro IIRC) isn't enough for this scenario
> >>>>>and we have to add this change.  Can you elaborate a bit more
> >>>>>about the relationship between this change and
> >>>>>VMADDR_FLAG_TO_HOST we added?
> >>>
> >>>
> >>>The main problem I have with VMADDR_FLAG_TO_HOST for connect() is
> >>>that it punts the complexity to the user. Instead of a single CID
> >>>address space, you now effectively create 2 spaces: One for
> >>>TO_HOST (needs a flag) and one for TO_GUEST (no flag). But every
> >>>user space tool needs to learn about this flag. That may work for
> >>>super special-case applications. But propagating that all the way
> >>>into socat, iperf, etc etc? It's just creating friction.
> >>
> >>Okay, I would like to have this (or part of it) in the commit
> >>message to better explain why we want this change.
> >>
> >>>
> >>>IMHO the most natural experience is to have a single CID space,
> >>>potentially manually segmented by launching VMs of one kind within
> >>>a certain range.
> >>
> >>I see, but at this point, should the kernel set VMADDR_FLAG_TO_HOST
> >>in the remote address if that path is taken "automagically" ?
> >>
> >>So in that way the user space can have a way to understand if it's
> >>talking with a nested guest or a sibling guest.
> >>
> >>
> >>That said, I'm concerned about the scenario where an application
> >>does not even consider communicating with a sibling VM.
> >
> >
> >If that's really a realistic concern, then we should add a
> >VMADDR_FLAG_TO_GUEST that the application can set. Default behavior of
> >an application that provides no flags is "route to whatever you can
> >find": If vhost is loaded, it routes to vhost. If a vsock backend
>
> mmm, we have always documented this simple behavior:
> - CID =3D 2 talks to the host
> - CID >=3D 3 talks to the guest
>
> Now we are changing this by adding fallback. I don't think we should
> change the default behavior, but rather provide new ways to enable this
> new behavior.
>
> I find it strange that an application running on Linux 7.0 has a default
> behavior where using CID=3D42 always talks to a nested VM, but starting
> with Linux 7.1, it also starts talking to a sibling VM.
>
> >driver is loaded, it routes there. But the application has no say in
> >where it goes: It's purely a system configuration thing.
>
> This is true for complex things like IP, but for VSOCK we have always
> wanted to keep the default behavior very simple (as written above).
> Everything else must be explicitly enabled IMHO.
>
> >
> >
> >>Until now, it knew that by not setting that flag, it could only talk
> >>to nested VMs, so if there was no VM with that CID, the connection
> >>simply failed. Whereas from this patch onwards, if the device in the
> >>host supports sibling VMs and there is a VM with that CID, the
> >>application finds itself talking to a sibling VM instead of a nested
> >>one, without having any idea.
> >
> >
> >I'd say an application that attempts to talk to a CID that it does now
> >know whether it's vhost routed or not is running into "undefined"
> >territory. If you rmmod the vhost driver, it would also talk to the
> >hypervisor provided vsock.
>
> Oh, I missed that. And I also fixed that behaviour with commit
> 65b422d9b61b ("vsock: forward all packets to the host when no H2G is
> registered") after I implemented the multi-transport support.
>
> mmm, this could change my position ;-) (although, to be honest, I don't
> understand why it was like that in the first place, but that's how it is
> now).
>
> Please document also this in the new commit message, is a good point.
> Although when H2G is loaded, we behave differently. However, it is true
> that sysctl helps us standardize this behavior.
>
> I don't know whether to see it as a regression or not.
>
> >
> >
> >>Should we make this feature opt-in in some way, such as sockopt or
> >>sysctl? (I understand that there is the previous problem, but
> >>honestly, it seems like a significant change to the behavior of
> >>AF_VSOCK).
> >
> >
> >We can create a sysctl to enable behavior with default=3Don. But I'm
> >against making the cumbersome does-not-work-out-of-the-box experience
> >the default. Will include it in v2.
>
> The opposite point of view is that we would not want to have different
> default behavior between 7.0 and 7.1 when H2G is loaded.

From a VMCI perspective, we only allow communication from guest to
host CIDs 0 and 2. With has_remote_cid implemented for VMCI, we end
up attempting guest to guest communication. As mentioned this does
already happen if there isn't an H2G transport registered, so we
should be handling this anyways. But I'm not too fond of the change
in behaviour for when H2G is present, so in the very least I'd
prefer if has_remote_cid is not implemented for VMCI. Or perhaps
if there was a way for G2H transport to explicitly note that it
supports CIDs that are greater than 2?  With this, it would be
easier to see this patch as preserving the default behaviour for
some transports and fixing a bug for others.

--000000000000944b93064c1f5cb8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
kKXUf8BmgVwrm4J21BIjpK/E9/meSALtIG7FIMpiIKpgHf1MRTzmYywQIWohaXxPRAEIYZK2DSMY
n+fDChhou4ePAtzo6/x8PTSWPrJbH05U1DQt9FRG7+xcvkNqnjJq+XZK0kiDDFD8BzIKO/cq3ziS
50EhbzFKXPpa46ztpJqQ+UJTJod2dB7SexAYJlBkjKlGc+niNQIDAQABo4IB2jCCAdYwDgYDVR0P
AQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEGA1UdHwQ6MDgw
NqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzLmNybDAk
BgNVHREEHTAbgRlicnlhbi1idC50YW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQWxgja/oUqPdrOSir6
U+YDJVND/DANBgkqhkiG9w0BAQsFAAOCAgEAIL+CGrIYdRkQ80Psq9FtFG65/EZQH8dFSXv3AJTk
220m3Q98q4NHh+AkBRw/pvzVQMJlRKEBKgM1qYw5FYYoC3IRpeqQ9NqnJHsEAHX2p7Hfkt3l8zd7
rT9DuQ4Tws1Fjxo4L7OcRz8NDD9f0Y+LHADvcMUHoex2PldpXkGuWd4K1eMjga8xPOrKKYYdvWYw
cX/rc+AYfo3B0OnjSWXjdsufMPVDDK23uGYfti1djyVhYG7hOCKjW3fg9QdDcVjVa4q7spoCPGnQ
HGghAH5+ZauOJU1r26oGjwR/73xvsig9pX887/zvEM5WdbTXK82mciLRR4iQB0UlV+8UxxpJzfGd
j/6onem1o3e1fTH0owcQEn59i7Ygo5cWJm0qnT7zPTS6pgkXJ4xmskj6Dcqi/hRkMlxovq3K05uN
+lgAFg6F7ugpiGTUcxngHsGMRlj8cXIhg8KZO0gBU5KthBSvioQgN2JpAyE5gUV7stnVCu8l+SAr
Oo+OqcCeAc14zE+TlRnoQVn/xF+q0zAyONDNmQO4uyl0EyLpTIYLK7wFxC6IDrz2FsEzlioH2cBJ
lUyNMZuhR7c1KUj3dr4qBG1506iDiJ5qqn2rBKJAvk0ph2Irlh+82seX1iL/wX+M+Wwkzoo34GGq
6CGv4ffBr8W+eQ2/QT4X10tgfAgSZ+Sag3gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgx+bIvtS2ArBR9RakkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
INJgsp+iimvuKp51tVU0hRENooY2OWONPcba116+vUOeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwMzE0MTcyMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHrmTB8YkIi6t3/PHsNJLtbXq3OA6CKDqUAK
WyUe1w+LlJIqMvavgnBzXWKYTixm9KrVZnKTf4n1qcQKwt4E3sRdMpKvRw/NQQ8nZIop4gGk21Je
o4xM4izjPuKZQYq50ywbDJ8B0Edc8+tQJNgxZrCq9R4G9YG/cweOpCqAi2IdRspqQkJgvAbt8yZu
JVRcGmuLdvkEZ5MRsHuDh0FDYhdHwGEY6ryh7wWUTzjJIHJZWwsk7WrNtBQvGI/OHEMbec3seMq9
AbJQfIVtlyZueyOD8d9Hu3eLOAZTcsG5hEhmfBX/zhSTrjw1E6yXr8ybBG4p2hLQSgSYZbJEpEdv
Y7I=
--000000000000944b93064c1f5cb8--
