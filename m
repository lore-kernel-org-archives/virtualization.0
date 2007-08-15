From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Thu, 16 Aug 2007 00:47:18 +0200
Message-ID: <20070815224718.GO3406__21575.945421546$1187215032$gmane$org@bingen.suse.de>
References: <11871822163867-git-send-email-gcosta@redhat.com>
	<20070815135554.GE3406@bingen.suse.de>
	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
	<20070815154243.GH3406@bingen.suse.de>
	<46C31736.2050001@redhat.com>
	<20070815163640.GJ3406@bingen.suse.de>
	<46C3283B.5090804@redhat.com>
	<20070815164729.GU3672@sequoia.sous-sol.org>
	<46C3312D.40106@redhat.com>
	<20070815180929.GX3672@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070815180929.GX3672@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: lguest@ozlabs.org, shai@scalemp.com, kiran@scalemp.com, linux-kernel@vger.kernel.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

> between __cacheline_aligned_in_smp and other compile time bits based on
> VSMP specific INTERNODE_CACHE, etc. I think compile time the way to go.

Yes you're right they'll need an additional build option for that.
It would be too wasteful to have the big cache line for all paravirt kernels.
But it can be below paravirt ops and at least clean up the 
interrupt saving code.

-Andi
