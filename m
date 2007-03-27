From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 1/2] Ignore stolen time in the softlockup watchdog
Date: Tue, 27 Mar 2007 09:00:49 +0200
Message-ID: <4608C121.4050309@cosmosbay.com>
References: <20070327053816.881735237@goop.org>
 <20070327054106.664262413@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965233AbXC0HAz@vger.kernel.org>
In-reply-to: <20070327054106.664262413@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Dan Hecht <dhecht@vmware.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Prarit Bhargava <prarit@redhat.com>, Chris Lalancette <clalance@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge a =E9crit :

> +static DEFINE_PER_CPU(unsigned long long, touch_timestamp);

=2E..

>  void touch_softlockup_watchdog(void)
>  {
> -	__raw_get_cpu_var(touch_timestamp) =3D jiffies;
> +	__raw_get_cpu_var(touch_timestamp) =3D sched_clock();
>  }

Not very clear if this is safe on 32bit, since this is not anymore atom=
ic.

Maybe a comment would help ?
