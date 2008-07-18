From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout v2
Date: Fri, 18 Jul 2008 14:18:09 +1000
Message-ID: <200807181418.09883.rusty__6716.35475378043$1216354821$gmane$org@rustcorp.com.au>
References: <487B05CE.1050508@jp.fujitsu.com> <487DC943.5060202@goop.org>
	<487EBF1E.5030109@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <487EBF1E.5030109@jp.fujitsu.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Max Krasnyansky <maxk@qualcomm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 17 July 2008 13:40:14 Hidetoshi Seto wrote:
> Jeremy Fitzhardinge wrote:
> > Hidetoshi Seto wrote:
> >> +#ifdef CONFIG_STOP_MACHINE
> >> +extern unsigned long stopmachine_timeout;
> >> +#endif
> >
> > No externs in C files. Put it in an appropriate header.
>
> sysctl.c already has many externs... but I can fix at least
> the above.

I already patched this; checkpatch.pl warned about it :)

> > I'll do a proper review soon.
>
> Is it better to postpone v4 until your comment comes?

I think the only other real change is to make the value in ms, not seconds,
and allow a 0 value to mean "don't check".

Cheers,
Rusty.
