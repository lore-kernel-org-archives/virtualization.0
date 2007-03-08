From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: hardwired VMI crap
Date: Thu, 08 Mar 2007 13:15:51 -0800
Message-ID: <45F07D07.5090003@goop.org>
References: <45EE1EA3.90803@vmware.com>	 <1173256666.24738.576.camel@localhost.localdomain>	 <45EEF966.6060902@goop.org> <Line.LNX.4.64.0703071304080.1851@d.namei>	 <45EF0CF5.5090305@goop.org> <45EF175D.6030609@vmware.com>	 <1173302503.24738.795.camel@localhost.localdomain>	 <45EF372E.7030600@goop.org>	 <1173308717.24738.898.camel@localhost.localdomain>	 <45EF49E9.7040509@vmware.com> <20070308091019.GA19460@elte.hu>	 <45EFE010.7080108@vmware.com> <1173352154.24738.1023.camel@localhost.localdomain> <45F0761C.6060107@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933332AbXCHVP4@vger.kernel.org>
In-Reply-To: <45F0761C.6060107@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pratap Subrahmanyam <pratap@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>, Daniel Hecht <dhecht@vmware.com>, Daniel Arai <arai@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> We faithfully emulate lapic, io_apic, the pit, pic, and a normal
> interrupt subsystem.

Can you not just use the apic clock driver directly then?  Do you need
to do anything special?

    J
