From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 11:20:42 +0200
Message-ID: <200608231120.42679.ak@suse.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231106.26696.ak@suse.de> <44EC1C7C.9020304@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751476AbWHWJVH@vger.kernel.org>
In-Reply-To: <44EC1C7C.9020304@vmware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> I need to look at the kprobes code in more depth to answer completely.  
> But in general, there could be a problem if DRs are set to fire on any 
> EIP 

kprobes don't use DRs.

-Andi
