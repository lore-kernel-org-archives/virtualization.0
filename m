From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Mon, 23 Apr 2007 12:10:42 -0700
Message-ID: <462D04B2.6080008@goop.org>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de> <4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com> <4627E099.209@goop.org>	<m1d51vxxm4.fsf@ebiederm.dsl.xmission.com> <462CE027.4030302@goop.org>	<462CE1E0.9060007@zytor.com>	<m1zm4zvwfr.fsf@ebiederm.dsl.xmission.com>	<462CF5B8.4070708@xensource.com> <m1y7kivs3s.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754132AbXDWTKp@vger.kernel.org>
In-Reply-To: <m1y7kivs3s.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Chuck Ebbert <cebbert@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> If (cpu_has_pse) it may only be an additional two pages.
> INIT_MAP_BEYOND is currently mapping a lot more then that.
>   

Ah, yes.  It allocates an extra two pages for pagetables, and then maps
an extra 8MB or so.

>> Would that be necessary?  Is there any need to remap it?  Couldn't you
>> just do the straightforward phys->virt mapping and use the page where it
>> lies?
>>     
>
> Catch-22.  If the page is not mapped yet you can't use it where it lies.

Why not?  Er, except in the case where the page is needed to map itself
- but that can be dealt with with a transient fixmap mapping.

    J
