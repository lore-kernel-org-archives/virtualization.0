From: Roland McGrath <roland@redhat.com>
Subject: Re: [patch 17/26] Xen-paravirt_ops: Add nosegneg capability to the vsyscall page notes
Date: Fri, 16 Mar 2007 14:26:55 -0700 (PDT)
Message-ID: <20070316212655.B6C6B1801C5@magilla.sf.frob.com>
References: <20070316091552.GH23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965962AbXCPV1F@vger.kernel.org>
In-Reply-To: Ingo Molnar's message of  Friday, 16 March 2007 10:15:52 +0100 <20070316091552.GH23174@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> > +NOTE_KERNELCAP_BEGIN(1, 1)
> > +NOTE_KERNELCAP(1, "nosegneg")
> > +NOTE_KERNELCAP_END

This should be:

NOTE_KERNELCAP_BEGIN(1, 1)
NOTE_KERNELCAP(0, "nosegneg")
NOTE_KERNELCAP_END

i.e. 1->0 in the "bit" member.  (Note the ld.so.conf.d file must have the
matching bit number for ldconfig-based lookups to do the right thing.)
Or else:

NOTE_KERNELCAP_BEGIN(1, 2)
NOTE_KERNELCAP(0, "nosegneg")
NOTE_KERNELCAP_END

i.e. 1->2 in the "mask" member.  (The mask value should be 1<<bit.)

Some pre-release glibc's (before 2.4) had a bug in the code that parses
this, and would crash parsing the correct note.  Using the wrong bit value
with nonmatching mask worked around this.  IIRC, no glibc release ever
included the buggy version of the code.  In nonbuggy glibc, the mismatched
value causes the "nosegneg" to be omitted from the directory search (under
LD_LIBRARY_PATH and default directories), though ldconfig-based lookups
will work (the most common case).


Thanks,
Roland
