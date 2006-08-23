From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 11:41:37 +0200
Message-ID: <200608231141.37284.ak@suse.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231120.42679.ak@suse.de> <44EC21A3.1040905@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751500AbWHWJls@vger.kernel.org>
In-Reply-To: <44EC21A3.1040905@vmware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 23 August 2006 11:36, Zachary Amsden wrote:
> Andi Kleen wrote:
> >> I need to look at the kprobes code in more depth to answer completely.  
> >> But in general, there could be a problem if DRs are set to fire on any 
> >> EIP 
> >>     
> >
> > kprobes don't use DRs
> 
> Good to know.  But int3 breakpoints can still cause horrific breakage in 
> the stop_machine code.  I don't know a good way to disallow it.

Mark the functions as __kprobes

-Andi
