From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] KVM simplified virtio balloon driver
Date: Thu, 17 Jan 2008 10:32:24 +0100
Message-ID: <200801171032.26198.borntraeger__13779.8408781693$1200562622$gmane$org@de.ibm.com>
References: <20080114200357.GA18354@dmt>
	<1200525166.26281.103.camel@localhost.localdomain>
	<200801171245.59510.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801171245.59510.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 17. Januar 2008 schrieb Rusty Russell:
> Since the balloon requires Guest cooperation anyway, there seems
> little reason to force it to tell the Host when it wants to reuse a
> page.  It can simply fault it in.
Yes, thats what we do in the s390 cmm driver.

All in all the driver has similarities with cmm. I dont know, if we can 
consolidate some code.
Besides the hypervisor, we have a additional user interface: /proc/sys/vm/. 
The root user can specify the amount of pages in the balloon 
via /proc/sys/vm/cmm_pages. 

Another idea: Martin added an oom notifier to the cmm driver. Before the 
oom-killer kicks in cmm will try to free 256 pages. I think your virtio 
balloon driver should do the same - it seems to be the correct tradeoff. 

Christian
