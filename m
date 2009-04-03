From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Fri, 3 Apr 2009 10:36:31 -0700
Message-ID: <20090403173631.GA27148@sequoia.sous-sol.org>
References: <200904011155.20751.a.miskiewicz@gmail.com> <200904030222.57469.a.miskiewicz@gmail.com> <20090403003523.GK18394@sequoia.sous-sol.org> <200904030847.19674.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933348AbZDCRhv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200904030847.19674.a.miskiewicz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

* Arkadiusz Miskiewicz (a.miskiewicz@gmail.com) wrote:
> On Friday 03 of April 2009, Chris Wright wrote:
> > * Arkadiusz Miskiewicz (a.miskiewicz@gmail.com) wrote:
> > > What about 9ea09af3bd3090e8349ca2899ca2011bd94cda85 ?
> > >
> > > stop_machine: introduce stop_machine_create/destroy.
> >
> > That is later fixed in a0e280e0f33f6c859a235fb69a875ed8f3420388.
> >
> > Can you please verify if 2.6.29 works for you? 
> 
> I think that the guilty part is 
> CONFIG_CC_STACKPROTECTOR_ALL=y
> CONFIG_CC_STACKPROTECTOR=y

Indeed, I think you're right.  In fact...this should fix it:

From:  Joseph Cihula <joseph.cihula@intel.com>

The __restore_processor_state() fn restores %gs on resume from S3.  As
such, it cannot be protected by the stack-protector guard since %gs will
not be correct on function entry.

There are only a few other fns in this file and it should not negatively
impact kernel security that they will also have the stack-protector
guard removed (and so it's not worth moving them to another file).

Without this change, S3 resume on a kernel built with
CONFIG_CC_STACKPROTECTOR_ALL=y will fail.

Signed-off-by:  Joseph Cihula <joseph.cihula@intel.com>

--- ../linux.trees.git/arch/x86/power/Makefile	2009-03-29 
12:12:13.000000000 -0700
+++ arch/x86/power/Makefile	2009-03-30 12:21:19.000000000 -0700
@@ -1,2 +1,7 @@
+# __restore_processor_state() restores %gs after S3 resume and so 
should not
+# itself be stack-protected
+nostackp := $(call cc-option, -fno-stack-protector)
+CFLAGS_cpu_$(BITS).o	:= $(nostackp)
+
obj-$(CONFIG_PM_SLEEP)		+= cpu_$(BITS).o
obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o
