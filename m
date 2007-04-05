From: Roland McGrath <roland@redhat.com>
Subject: Re: [patch 1/2] Relocate VDSO ELF headers to match mapped location
	with COMPAT_VDSO
Date: Wed,  4 Apr 2007 23:31:52 -0700 (PDT)
Message-ID: <20070405063152.9227D180064@magilla.sf.frob.com>
References: <20070405045843.333498131@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: Jeremy Fitzhardinge's message of  Wednesday,
	4 April 2007 21:58:26 -0700 <20070405045843.333498131@goop.org>
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
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Jan Beulich <JBeulich@novell.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The patch looks nice and clean.  However, it does not relocate the symbol
table(s) values.  I thought that was done in an earlier version of this I
saw, but I might be misremembering.  Though not fatal, this is a regression
from the previous CONFIG_COMPAT_VDSO behavior.  It will show up in things
like __kernel_* name display in backtraces.  If with your other patch
CONFIG_COMPAT_VDSO will become other than a rarely-used compatibility
option, then this should be fixed.  Note that with your second patch this
will also break the symbol values in the randomly-located vma vdso;
non-ancient glibc doesn't care if the vdso isn't mapped where its phdrs
say, but everything does still care that the symbol tables in an ELF file
use addresses matching the phdrs in the same file.


Thanks,
Roland
