From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 11:50:17 +0200
Message-ID: <200608231150.17650.ak@suse.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231141.37284.ak@suse.de> <44EC2450.3060706@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964792AbWHWJuY@vger.kernel.org>
In-Reply-To: <44EC2450.3060706@vmware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> 
> And the functions they call?

Yes. But you only really need it for the actual callback, not the bulk
of stop_machine_run() (which calls scheduler and lots of other stuff)
The actual callback should be pretty limited already so it shouldn't
be a big limitation.

-Andi
