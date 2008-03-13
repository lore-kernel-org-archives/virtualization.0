From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 6/6] Guest page hinting: s390 support.
Date: Thu, 13 Mar 2008 10:42:40 +0100
Message-ID: <1205401360.26537.33.camel@localhost>
References: <20080312132132.520833247@de.ibm.com>
	 <20080312132704.474209626@de.ibm.com> <47D802A2.1030406@goop.org>
	 <1205339285.8851.13.camel@localhost> <47D8085E.9030701@goop.org>
	 <1205341164.8851.44.camel@localhost> <47D81771.5070400@goop.org>
	 <47D8373C.40105@codemonkey.ws> <47D840E3.5090902@goop.org>
	 <47D8436F.9080901@codemonkey.ws>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754811AbYCMJm6@vger.kernel.org>
In-Reply-To: <47D8436F.9080901@codemonkey.ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, akpm@osdl.org, linux-s390@vger.kernel.org, frankeh@watson.ibm.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, hugh@veritas.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2008-03-12 at 15:56 -0500, Anthony Liguori wrote:
> > Vp should never happen, since you'd never preserve a V page.  And 
> > surely it would be Pr -> Sr, since the hypervisor wouldn't push the 
> > page to backing store when you change the client state.
> 
> You're right, I meant Vp/Pp but they are invalid states.  I think one of 
> the things that keeps tripping me up is that the host can change both 
> the host and guest page states.  My initial impression was that the host 
> handled the host state and the guest handled the guest state.

In principle only the guest changes the guest state and only the host
changes the host state. The simplified state diagram shows exceptions
for Pr->Sp and Pr->Vz.

> >> Do the host states even really need visibility to the guest at all?  
> >> It may be useful for the guest to be able to distinguish between Ur 
> >> and Uz but it doesn't seem necessary.
> >
> > Well, you implicitly see the hypervisor state.  If you touch a [UV]z 
> > page then you get a fault telling you that the page has been taken 
> > away from you (I think).  And it would definitely help with debugging 
> > (seems likely there's lots of scope for race conditions if you 
> > prematurely tell the hypervisor you don't need the page any more...).
> 
> I was thinking that it may be useful to know a Ur verses a Uz when 
> allocating memory.  In this case, you'd rather allocate Ur pages verses 
> Uz to avoid the fault.  I don't read s390 arch code well, is the host 
> state explicit to the guest?

This is the second optimization you might want to think about. The other
is to avoid the page clearing for Uz.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
