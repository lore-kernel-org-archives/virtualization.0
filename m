From: "Raharjo, Cahyo \(cahr\)" <Cahyo.Raharjo@chevron.com>
Subject: RE: [patch 1/2] Relocate VDSO ELF headers to match mapped	location
	with COMPAT_VDSO
Date: Thu, 5 Apr 2007 14:45:56 +0700
Message-ID: <8646EB4D6B054F4E8AB083CA829C4C810107364E@iddrintx1.iddri.chevrontexaco.net>
References: <20070405045825.511024444@goop.org>
	<20070405045843.333498131@goop.org>
	<4614BD10.76E4.0078.0@novell.com> <4614A5DA.9050700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <4614A5DA.9050700@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Jan Beulich <jbeulich@novell.com>
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Dear All,
In this few days, I got emails from this list. I tried to exclude thru
majordomo, but it failed.
Kindly need your help to exclude me from this list.


Thank You, =

CR


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jeremy
Fitzhardinge
Sent: Thursday, April 05, 2007 2:32 PM
To: Jan Beulich
Cc: Ingo Molnar; Andrew Morton; virtualization@lists.osdl.org; Roland
McGrath; Andi Kleen; lkml; Zachary Amsden; Eric W. Biederman
Subject: Re: [patch 1/2] Relocate VDSO ELF headers to match mapped
location with COMPAT_VDSO

Jan Beulich wrote:
> While there's a certain level of control on what DT_* may appear in =

> the vDSO, not even considering other than the above types seems =

> fragile to me. Since future additions to the set are supposedly =

> following a fixed scheme (distinguishing pointers and values via the =

> low bit when below OLD_DT_LOOS, and using sub-ranges when between =

> DT_HIOS and OLD_DT_HIOS), at least also handling those would seem like

> a good idea, as would warning about unrecognized types.
>   =


I wasn't aware of this scheme.  Where is it documented?

> Also, even though it shouldn't matter for the final result, if doing =

> things spec-conforming here you should use d_un.d_ptr.
>   =


Yes, I've already fixed that.

> In addition to Roland's remarks about missing symbol table relocation,

> I would also assume section headers, if present, should be relocated.
>   =


Yes, I suppose that's easy enough to add.

    J
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
