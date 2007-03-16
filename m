From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 17/26] Xen-paravirt_ops: Add nosegneg
 capability to the vsyscall page notes
Date: Fri, 16 Mar 2007 14:56:24 -0700
Message-ID: <45FB1288.5080909@goop.org>
References: <20070316212655.B6C6B1801C5@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316212655.B6C6B1801C5@magilla.sf.frob.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Roland McGrath <roland@redhat.com>
Cc: Zachary Amsden <zach@vmware.com>, Jakub Jelinek <jakub@redhat.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Roland McGrath wrote:
> This should be:
>
> NOTE_KERNELCAP_BEGIN(1, 1)
> NOTE_KERNELCAP(0, "nosegneg")
> NOTE_KERNELCAP_END
>
> i.e. 1->0 in the "bit" member.  (Note the ld.so.conf.d file must have the
> matching bit number for ldconfig-based lookups to do the right thing.)
> Or else:
>
> NOTE_KERNELCAP_BEGIN(1, 2)
> NOTE_KERNELCAP(0, "nosegneg")
> NOTE_KERNELCAP_END
>
> i.e. 1->2 in the "mask" member.  (The mask value should be 1<<bit.)
>   

Thanks Roland.  I've never really understood this stuff, and I just
copied this cargo-cultishly.

I'm not quite sure what you're suggesting here though.  Do you mean one of:

NOTE_KERNELCAP_BEGIN(1, 1)
NOTE_KERNELCAP(0, "nosegneg")
NOTE_KERNELCAP_END

or

NOTE_KERNELCAP_BEGIN(1, 2)
NOTE_KERNELCAP(1, "nosegneg")
NOTE_KERNELCAP_END

is the correct thing to use?

> Some pre-release glibc's (before 2.4) had a bug in the code that parses
> this, and would crash parsing the correct note.  Using the wrong bit value
> with nonmatching mask worked around this.  IIRC, no glibc release ever
> included the buggy version of the code.  In nonbuggy glibc, the mismatched
> value causes the "nosegneg" to be omitted from the directory search (under
> LD_LIBRARY_PATH and default directories), though ldconfig-based lookups
> will work (the most common case).
>   

Are you saying that one of the corrected forms might cause old glibcs to
crash, or just ignore nosegneg?

    J
