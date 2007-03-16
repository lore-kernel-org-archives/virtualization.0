From: Roland McGrath <roland@redhat.com>
Subject: Re: [patch 17/26] Xen-paravirt_ops: Add nosegneg capability to the
	vsyscall page notes
Date: Fri, 16 Mar 2007 15:20:00 -0700 (PDT)
Message-ID: <20070316222000.8186E1801C5@magilla.sf.frob.com>
References: <45FB1288.5080909@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: Jeremy Fitzhardinge's message of  Friday,
	16 March 2007 14:56:24 -0700 <45FB1288.5080909@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jakub Jelinek <jakub@redhat.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

> I'm not quite sure what you're suggesting here though.  Do you mean one o=
f:
> =

> NOTE_KERNELCAP_BEGIN(1, 1)
> NOTE_KERNELCAP(0, "nosegneg")
> NOTE_KERNELCAP_END
> =

> or
> =

> NOTE_KERNELCAP_BEGIN(1, 2)
> NOTE_KERNELCAP(1, "nosegneg")
> NOTE_KERNELCAP_END
> =

> is the correct thing to use?

Yes.  (Sorry about the typo, 1 and 0 are close enough aren't they? ;-)

> > Some pre-release glibc's (before 2.4) had a bug in the code that parses
> > this, and would crash parsing the correct note.  Using the wrong bit va=
lue
> > with nonmatching mask worked around this.  IIRC, no glibc release ever
> > included the buggy version of the code.  In nonbuggy glibc, the mismatc=
hed
> > value causes the "nosegneg" to be omitted from the directory search (un=
der
> > LD_LIBRARY_PATH and default directories), though ldconfig-based lookups
> > will work (the most common case).
> =

> Are you saying that one of the corrected forms might cause old glibcs to
> crash, or just ignore nosegneg?

Yes, the affected glibc crashed with the canonical form (the first above).
I'm not sure such a glibc exists in the wild today, maybe only in some FC5
test releases (I CC'd Jakub so he can verify that at least as far as FC).
Rik van Riel discovered that the s/0/1/ tweak sufficed for common daily use
(i.e. ld.so.cache hits), and did that temporarily when he was hacking on
Xen Linux kernels for Fedora, but reverted it after we fixed glibc.

The uncorrected form causes current (correct) glibc to ignore nosegneg =

(for cache misses).

Looking at the buggy version of the code, I think it will not crash with
the second form above, just avoid using bit 0.  (But I wouldn't swear to it
without testing it.)  The second form should certainly be fine with the
current glibc.  Just make sure that "kernelcap 1 nosegneg" is used in the
ld.so.conf.d file, to match 1 in the NOTE_KERNELCAP first arg.


Thanks,
Roland
