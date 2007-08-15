From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Wed, 15 Aug 2007 19:34:27 +0200
Message-ID: <20070815173427.GM3406__30849.9721497812$1187196167$gmane$org@bingen.suse.de>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<20070815135554.GE3406@bingen.suse.de>
	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
	<20070815154243.GH3406@bingen.suse.de>
	<46C31736.2050001@redhat.com>
	<20070815163640.GJ3406@bingen.suse.de>
	<46C3283B.5090804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46C3283B.5090804@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, shai@scalemp.com, kiran@scalemp.com, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

> Maybe we could even make VSMP depend on PARAVIRT, to make it sure it is 
> completely a paravirt client.

That's the right thing to do I think. Remove the existing ifdefs
and hook vsmp in only using paravirt ops.

-Andi
