From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Sat, 19 Sep 2009 18:04:57 -0700
Message-ID: <4AB57FB9.2020705@goop.org>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com> <20090919224430.GB9567@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753574AbZITBFA@vger.kernel.org>
In-Reply-To: <20090919224430.GB9567@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/19/09 15:44, Greg KH wrote:
> That sounds good to me, how intrusive are the patches to do this?  Is it
> going to be tricky to get everything merged properly in -tip for it?

They should be very local - just a matter of removing a couple of files
and dropping some config options.

    J
