Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92ED3FE50
	for <virtualization@lists.linux.dev>; Tue,  5 Dec 2023 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hnN/yFOk"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ce403523e5so1935944b3a.3
        for <virtualization@lists.linux.dev>; Tue, 05 Dec 2023 14:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701816208; x=1702421008; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5PDjvnXiofAm+LfrZr5GVjzdYbiyiT62E/CMkJfzm4=;
        b=hnN/yFOkh9Nc13gP3LGog//8UnKKbVPPZeUofblrD3iNF/okZ1M7v0dKr3BO66uxZ8
         vd86o45YCXDljG8bja2HqYWPtVfc9MPEYRzeMMS14EfbC3bS5FhvTmoFsx3ScYljX7GL
         2AM33COSchclmjsdVvOt9XTAZqDjUc11CwbZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701816208; x=1702421008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5PDjvnXiofAm+LfrZr5GVjzdYbiyiT62E/CMkJfzm4=;
        b=lVfn7HHoDOkJLaYpc1f20pgndHVRnV5t3dKYwooT44m9oRvKGNsH4S7t46CuNtCKQ3
         0vR5OP8HH8WvVp8P/u5dJe1Na2DhGvXGMQuQJ/nTr5ltnqRWGJ0R4IUbclcqKe00SFi6
         giiYj6Ib+PVeIr1l3YwI6sCVuIlrYbHSsCEXdjK/N7lkPsrscikaHxudjfODAQ56NSv/
         fa94nGX1C3RlPiU83emou6BB3SJk5UeBBCnddNtBHUPM881XF4gele+hHrLX6EOI1i8Y
         CK0DslHo2cwB2Y3vxf0YJNUgHfsNMcyGy1YKDxxlum350Takp4LFN0IyVLiyj0HUYHdA
         qoGw==
X-Gm-Message-State: AOJu0YyH0CVYIyyNso4W91id2lgn9HkB31UgKLN4Eg7UQsZpE70puh2c
	2i/S6jHrI3/vx3kT9oLScy90fzuO9n1LPofcMpZRS8jL4ZqoMsArpbpilDLhlJB8VohleU3nHh0
	7LVJpoBVQ0Qb0rz8qwKpaL28kesa2xOaYzg==
X-Google-Smtp-Source: AGHT+IGLyjhmShxcrztf4iUASVXKLIZrQvbl2nOMjR/Yv9SysVtwrvaOGSlk/eSVNbluuvrw8muVoWkRUp1fFXY/kkM=
X-Received: by 2002:a05:6a20:1608:b0:18c:b6:ab4f with SMTP id
 l8-20020a056a20160800b0018c00b6ab4fmr4318468pzj.48.1701816207958; Tue, 05 Dec
 2023 14:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231122233058.185601-8-amakhalov@vmware.com> <20231201232452.220355-1-amakhalov@vmware.com>
 <20231201232452.220355-7-amakhalov@vmware.com> <20231204103100.GYZW2qZE9tbGMtuVgY@fat_crate.local>
 <c2519c9a-8518-403a-9bca-cb79a5f2a6e9@intel.com> <204f743d-2901-4ad2-bbcc-a7857a8644e7@broadcom.com>
In-Reply-To: <204f743d-2901-4ad2-bbcc-a7857a8644e7@broadcom.com>
From: Tim Merrifield <tim.merrifield@broadcom.com>
Date: Tue, 5 Dec 2023 16:43:16 -0600
Message-ID: <CAJfbqWyeubVofe4BHQC+a3wacwk0kMPECa8mxZ7gkzhBJ3d5LA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] x86/vmware: Add TDX hypercall support
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Alexey Makhalov <amakhalov@vmware.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, hpa@zytor.com, dave.hansen@linux.intel.co, 
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, netdev@vger.kernel.org, 
	richardcochran@gmail.com, linux-input@vger.kernel.org, 
	dmitry.torokhov@gmail.com, zackr@vmware.com, 
	linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com, namit@vmware.com, 
	timothym@vmware.com, akaher@vmware.com, jsipek@vmware.com, 
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com, 
	tzimmermann@suse.de, mripard@kernel.org, maarten.lankhorst@linux.intel.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave and Alexey,

Regarding VMware-specific checks, it may be beneficial to add some
additional checks
such as ensuring that the hypervisor vendor is VMware,
r12=3D=3DVMWARE_HYPERVISOR_MAGIC,
r10=3D=3DVMWARE_TDX_VENDOR_LEAF, r11=3D=3DVMWARE_TDX_HCALL_FUNC and r13 (co=
mmand) is
restricted to those few commands we expect to be invoked from the
kernel or drivers by VMware-specific
code.

If we add these checks, would folks be OK with exporting this function?


On Tue, Dec 5, 2023 at 3:41=E2=80=AFPM Alexey Makhalov
<alexey.makhalov@broadcom.com> wrote:
>
>
>
> On 12/5/23 1:24 PM, Dave Hansen wrote:
> > On 12/4/23 02:31, Borislav Petkov wrote:
> >> On Fri, Dec 01, 2023 at 03:24:52PM -0800, Alexey Makhalov wrote:
> >>> +#ifdef CONFIG_INTEL_TDX_GUEST
> >>> +/* __tdx_hypercall() is not exported. So, export the wrapper */
> >>> +void vmware_tdx_hypercall_args(struct tdx_module_args *args)
> >>> +{
> >>> +   __tdx_hypercall(args);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(vmware_tdx_hypercall_args);
> >> Uuuh, lovely. I'd like to see what the TDX folks think about this
> >> export first.
> >
> > I don't really like it much.  This does a generic thing (make a TDX
> > hypercall) with a specific name ("vmware_").  If you want to make an
> > argument that a certain chunk of the __tdx_hypercall() space is just fo=
r
> > VMWare and you also add a VMWare-specific check and then export *that*,
> > it might be acceptable.
> >
> > But I don't want random modules able to make random, unrestricted TDX
> > hypercalls.  That's asking for trouble.
>
> Considering exporting of __tdx_hypercall for random modules is not an
> option, what VMware specific checks you are suggesting?
>
> --
> This electronic communication and the information and any files transmitt=
ed
> with it, or attached to it, are confidential and are intended solely for
> the use of the individual or entity to whom it is addressed and may conta=
in
> information that is confidential, legally privileged, protected by privac=
y
> laws, or otherwise restricted from disclosure to anyone else. If you are
> not the intended recipient or the person responsible for delivering the
> e-mail to the intended recipient, you are hereby notified that any use,
> copying, distributing, dissemination, forwarding, printing, or copying of
> this e-mail is strictly prohibited. If you received this e-mail in error,
> please return the e-mail to the sender, delete it from your computer, and
> destroy any printed copy of it.

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.
