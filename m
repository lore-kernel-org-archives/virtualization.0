From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Wed, 15 Aug 2007 17:42:44 +0200
Message-ID: <20070815154243.GH3406__43369.9556779631$1187189440$gmane$org@bingen.suse.de>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<20070815135554.GE3406@bingen.suse.de>
	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 15, 2007 at 11:18:25AM -0300, Glauber de Oliveira Costa wrote:
> > Didn't we agree this should be a pvops client?
> >
> > -Andi
> >
> No. I exposed my reasoning, asked you back, but got no answer.
> I'll do it again:
> 
> This operations are just manipulating bits, and are doing no
> privileged operations at all. Nothing that can be paravirtualized, in

It's talking to a Hypervisor. That is privileged enough.
Please do that change. If you add so many more ifdefs it's your
duty to keep the overall number low.

Various other paravirt ops also do things which are not strictly
privileged.

-Andi
