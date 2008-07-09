From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RFC 0/4] Paravirtual spinlocks
Date: Wed, 9 Jul 2008 14:28:52 +0200
Message-ID: <20080709122852.GA30579__37726.8644668677$1215606799$gmane$org@elte.hu>
References: <20080707190749.299430659@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080707190749.299430659@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> My experiments show that using a Xen-specific lock helps guest 
> performance a bit (reduction in elapsed and system time in a kernbench 
> run), but most significantly, reduces overall physical CPU consumption 
> by 10%, and so increases overall system scalability.

that's rather impressive and looks nice, considering the fairly low 
impact.

as there were no fundamental objections in this thread i've created a 
tip/x86/paravirt-spinlocks topic branch for these patches and started 
testing them.

i based the topic branch on tip/xen-64bit, so you should be able to get 
the latest code by doing:

  git-merge tip/x86/paravirt-spinlocks

on tip/master.

	Ingo
