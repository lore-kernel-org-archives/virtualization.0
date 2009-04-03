From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Fri, 3 Apr 2009 19:32:56 +0200
Message-ID: <20090403173256.GA6295@elte.hu>
References: <200904011155.20751.a.miskiewicz@gmail.com>
	<200904030222.57469.a.miskiewicz@gmail.com>
	<20090403003523.GK18394@sequoia.sous-sol.org>
	<200904030847.19674.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <200904030847.19674.a.miskiewicz@gmail.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, Tejun Heo <tj@kernel.org>, Arjan van de Ven <arjan@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@xensource.com>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Yinghai Lu <yhlu.kernel@gmail.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: virtualization@lists.linuxfoundation.org


* Arkadiusz Miskiewicz <a.miskiewicz@gmail.com> wrote:

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

aha!!

> Disabling stackprotector makes problem go away (and my build of 
> final 2.6.29 had it disabled while later builds got it enabled at 
> some moment).

Thanks a ton for that info. Could you try:

   http://people.redhat.com/mingo/tip.git/README

with stack-protector re-enabled please? This fix:

  1f23b77: x86: disable stack-protector for __restore_processor_state()

might do the trick!

	Ingo
