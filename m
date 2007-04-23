From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Mon, 23 Apr 2007 09:01:59 -0700
Message-ID: <462CD877.8000302@zytor.com>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de> <4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com> <4627E099.209@goop.org> <m1d51vxxm4.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964792AbXDWQDR@vger.kernel.org>
In-Reply-To: <m1d51vxxm4.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chuck Ebbert <cebbert@redhat.com>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> 
> I happened to be looking at this stretch of code and I have realized
> that this is quite simply the wrong fix.
> 
> The problem is that it depends intimately on the details of
> alloc_bootmem_pages_low.  Essentially the problem is that when
> we are setting up the identity mappings in paging_init we assume
> the identity mappings already exist.
> 
> If there are holes in the memory map or someone changes the way
> pages are returned from alloc_bootmem_pages_low() this code
> will break again.
> 

How would holes in the memory map affect it?

	-hpa
