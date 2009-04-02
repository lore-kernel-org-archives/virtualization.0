From: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Thu, 2 Apr 2009 22:12:05 +0200
Message-ID: <200904022212.06118.a.miskiewicz@gmail.com>
References: <200904011155.20751.a.miskiewicz@gmail.com> <20090401210054.GS18394@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932760AbZDBUMX@vger.kernel.org>
In-Reply-To: <20090401210054.GS18394@sequoia.sous-sol.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 01 of April 2009, Chris Wright wrote:
> * Arkadiusz Miskiewicz (a.miskiewicz@gmail.com) wrote:
> > and this as bad commit:
> >
> > 7f7ace0cda64c99599c23785f8979a072e118058 is first bad commit
>
> Does it make any difference if you roll fwd a couple commits to:
>
> 802bf931f2688ad125b73db597ce63cc842fb27a
>
> That fixes a possible problem with the cpumask change and interrupt
> migration.

Will test.

>
> And to be clear, one commit earlier works?
>
> fae3e7fba4c664b3a15f2cf15ac439e8d754afc2

Sort of, I got werid things with this commit... after initial suspend a=
nd=20
resume it started suspending and resuming in a loop without need for an=
y=20
intervention  on my part (so I didn't have to touch for it to start res=
uming).=20
=2E.. but if it resumed and I started using keyboard it stopped suspend=
ing.

32b838b8cfa269d688889b3213e7ee37ee901f72 behaves the same way.

Any ranges or commits to test/bisect?

> thanks,
> -chris

--=20
Arkadiusz Mi=C5=9Bkiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
