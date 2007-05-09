From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 2/9] lguest: the guest code
Date: Wed, 09 May 2007 22:32:53 +1000
Message-ID: <1178713973.7286.102.camel@localhost.localdomain>
References: <200705090951.l499pYBV020391@shell0.pdx.osdl.net>
	 <84144f020705090316o5e3b6d89r74638ec8e4d396d4@mail.gmail.com>
	 <1178711957.7286.87.camel@localhost.localdomain>
	 <84144f020705090513q28784b69sd91cd2490514d44c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756941AbXEIMdW@vger.kernel.org>
In-Reply-To: <84144f020705090513q28784b69sd91cd2490514d44c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, ak@suse.de, jeremy@goop.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-05-09 at 15:13 +0300, Pekka Enberg wrote:
> Hi Rusty,
> 
> On 5/9/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >         Hmm, where would the error go?
> 
> Let it propagate: scan_devices -> lguest_bus_init -> do_initcalls. We
> probably don't want to panic() if bus_register and device_register
> fail there either.

Hi Pekka,

	Hey, thanks, I didn't realize that do_initcalls() now takes some note
when an initcall fails.  But I'm pretty sure a local error message is
more informative than "initcall at 0xc0123408: returned with error code
2" etc.

	And I agree about the panic: bus_register and device_register should
panic for us if they fail this early in boot.  But I don't think they
do...

Thanks,
Rusty.
