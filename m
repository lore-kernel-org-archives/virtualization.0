From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [patch 2/9] lguest: the guest code
Date: Wed, 9 May 2007 15:13:45 +0300
Message-ID: <84144f020705090513q28784b69sd91cd2490514d44c@mail.gmail.com>
References: <200705090951.l499pYBV020391@shell0.pdx.osdl.net>
	 <84144f020705090316o5e3b6d89r74638ec8e4d396d4@mail.gmail.com>
	 <1178711957.7286.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756091AbXEIMOW@vger.kernel.org>
In-Reply-To: <1178711957.7286.87.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, ak@suse.de, jeremy@goop.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

On 5/9/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
>         Hmm, where would the error go?

Let it propagate: scan_devices -> lguest_bus_init -> do_initcalls. We
probably don't want to panic() if bus_register and device_register
fail there either.
