From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Readonly GDT
Date: Tue, 09 Apr 2013 17:43:41 -0700
Message-ID: <5164B5BD.5050702@zytor.com>
References: <20130408224328.GA17641@www.outflux.net>
	<51634935.9010905@zytor.com>
	<alpine.LFD.2.02.1304091122490.21884@ionos>
	<CAGXu5jKo=11RrsvctcZjP6dusAj659O_GsaA2J2qFq-6mOeRwQ@mail.gmail.com>
	<51645D6F.7070705@zytor.com>
	<CAGXu5jKkHKw8efdPOmt-Zi99m+uMKVGKpc_DC72_ztwxnRbRRQ@mail.gmail.com>
	<51646054.3090509@zytor.com>
	<CAGXu5jJNG4o+_-kk=A2AfSRwyQE0pgaQh7YpSjnD_fB-s7U+wA@mail.gmail.com>
	<CAG7+5M3==rndLLak9cZBKKdgQMmJMpSP_jpQd8HOVGp6LhUAgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAG7+5M3==rndLLak9cZBKKdgQMmJMpSP_jpQd8HOVGp6LhUAgw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Northup <digitaleric@google.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Alex Shi <alex.shi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <borislav.petkov@amd.com>, Ingo Molnar <mingo@redhat.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

OK, thinking about the GDT here.

The GDT is quite small -- 256 bytes on i386, 128 bytes on x86-64.  As
such, we probably don't want to allocate a full page to it for only
that.  This means that in order to create a readonly mapping we have to
pack GDTs from different CPUs together in the same pages, *or* we
tolerate that other things on the same page gets reflected in the same
mapping.

However, the packing solution has the advantage of reducing address
space consumption which matters on 32 bits: even on i386 we can easily
burn a megabyte of address space for 4096 processors, but burning 16
megabytes starts to hurt.

It would be important to measure the performance impact on task switch,
though.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
