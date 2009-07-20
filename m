From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [patch 00/54] [Announce] Microsoft Hyper-V drivers for Linux
Date: Mon, 20 Jul 2009 23:24:24 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0907202304180.1353@fbirervta.pbzchgretzou.qr>
References: <20090720160025.GA20249@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754082AbZGTVY2@vger.kernel.org>
In-Reply-To: <20090720160025.GA20249@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Hank Janssen <hjanssen@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Sam Ramji <sramji@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On Monday 2009-07-20 18:00, Greg Kroah-Hartman wrote:
>
>I'm happy to announce, that after many months of discussions, Microsof=
t
>has released their Hyper-V Linux drivers under the GPLv2.  Following
>this message, will be the patches that add the drivers to the
>drivers/staging/ tree, and a whole bunch of cleanups.
>
>It's taken a long road to get here, and I'd like to thank the followin=
g
>people who made this possible:
>  - Steve Hemminger for the initial prodding and extreme patience
>  - Hank Janssen for providing the code and working with me to get it
>    into a workable and semi-mergable state.  His involvement within
>    Microsoft was also invaluable.
>  - Sam Ramji for his push within Microsoft to make this happen in a
>    manner that works with the Linux community.
>  - Novell for sponsoring my work on the Linux Driver project, without
>    which, this would not have even been possible.

(Your title as Maintainer of Crap has been well earned. But crap
should not be maintained, it should be improved.)


I took a random patch to look at
(add-the-hyper-v-virtual-network-driver.patch to be precise). I think
the /hv/ subdirectory name should be expanded a little (to, say,
/hyper-v/); we're not in the Unix days anymore where space is at such
a premium that people even strip the last e off /usr. Our wireless
drivers also don't live in /wl/. And since hv does not seem to be
related to a hypervisor=C2=A0=E2=80=94 cf. sunhv.c.


As for the code=E2=80=A6 I was immediately greeted by the screaming-upp=
ercase
typedef crap jungle that is so redundant[1] yet typical in many
commercial products. One may hope that the evolution of the posted
hyper-v code brings a coding strategy breeze into the house of
Microsoft.

[1] DWORD they could have replaced by uint32_t once it became
available via C99's stdint.h. The LPCSTR crap only makes sense if you
are a lazy typist, but I would not call code doing things like LPCSTR
clean. At least it's one thing - consistent. Consistently hard to
read, though.
