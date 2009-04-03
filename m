From: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Fri, 3 Apr 2009 08:47:19 +0200
Message-ID: <200904030847.19674.a.miskiewicz@gmail.com>
References: <200904011155.20751.a.miskiewicz@gmail.com> <200904030222.57469.a.miskiewicz@gmail.com> <20090403003523.GK18394@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760140AbZDCGrk@vger.kernel.org>
In-Reply-To: <20090403003523.GK18394@sequoia.sous-sol.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 03 of April 2009, Chris Wright wrote:
> * Arkadiusz Miskiewicz (a.miskiewicz@gmail.com) wrote:
> > What about 9ea09af3bd3090e8349ca2899ca2011bd94cda85 ?
> >
> > stop_machine: introduce stop_machine_create/destroy.
>
> That is later fixed in a0e280e0f33f6c859a235fb69a875ed8f3420388.
>
> Can you please verify if 2.6.29 works for you?=20

I think that the guilty part is=20
CONFIG_CC_STACKPROTECTOR_ALL=3Dy
CONFIG_CC_STACKPROTECTOR=3Dy

Disabling stackprotector makes problem go away (and my build of final 2=
=2E6.29=20
had it disabled while later builds got it enabled at some moment).

(gcc 4.3.3 here)

> Your bisects are all
> going way back to 2.6.29-rc1.
>
> thanks,
> -chris


--=20
Arkadiusz Mi=C5=9Bkiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
