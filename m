From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Thu, 17 Sep 2009 17:53:33 -0700
Message-ID: <4AB2DA0D.8020606@goop.org>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com> <20090918003412.GI26034@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754002AbZIRAxd@vger.kernel.org>
In-Reply-To: <20090918003412.GI26034@sequoia.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/17/09 17:34, Chris Wright wrote:
>> One of the options that I am contemplating is to drop the code from the
>> tip tree in this release cycle, and given that this should be a low risk
>> change we can remove it from Linus's tree later in the merge cycle.
>>
>> Let me know your views on this or if you think we should do this some
>> other way.
>>     
> Typically we give time measured in multiple release cycles
> before deprecating a feature.  This means placing an entry in
> Documentation/feature-removal-schedule.txt, and potentially
> adding some noise to warn users they are using a deprecated
> feature.
>   

That's true if the feature has some functional effect on users.  But at
first sight, VMI is really just an optimisation, and a non-VMI-equipped
kernel would be completely functionally equivalent, right?

On the other hand, there could well be a performance regression which
could affect users.  However they're taking the explicit step of
withdrawing support for VMI, so I guess they can just take that in their
stride.

    J
