From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 1/2] Relocate VDSO ELF headers to match mapped	location
	with COMPAT_VDSO
Date: Thu, 05 Apr 2007 00:31:38 -0700
Message-ID: <4614A5DA.9050700@goop.org>
References: <20070405045825.511024444@goop.org>
	<20070405045843.333498131@goop.org>
	<4614BD10.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4614BD10.76E4.0078.0@novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <jbeulich@novell.com>
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Jan Beulich wrote:
> While there's a certain level of control on what DT_* may appear in the
> vDSO, not even considering other than the above types seems fragile to
> me. Since future additions to the set are supposedly following a fixed
> scheme (distinguishing pointers and values via the low bit when below
> OLD_DT_LOOS, and using sub-ranges when between DT_HIOS and
> OLD_DT_HIOS), at least also handling those would seem like a good
> idea, as would warning about unrecognized types.
>   =


I wasn't aware of this scheme.  Where is it documented?

> Also, even though it shouldn't matter for the final result, if doing thin=
gs
> spec-conforming here you should use d_un.d_ptr.
>   =


Yes, I've already fixed that.

> In addition to Roland's remarks about missing symbol table relocation, I
> would also assume section headers, if present, should be relocated.
>   =


Yes, I suppose that's easy enough to add.

    J
