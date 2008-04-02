From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [02/17][PATCH] Implement smp_call_function_mask for ia64 - V8
Date: Wed, 2 Apr 2008 16:48:03 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843ECF9E1F1__7940.54201473973$1207180593$gmane$org@orsmsx424.amr.corp.intel.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC01048240@pdsmsx415.ccr.corp.intel.com>	<47F0AB18.2010707@sgi.com>
	<47F0FCFE.5010106@goop.org> <47F1F3B1.7020308@sgi.com>
	<47F25D6B.40704@goop.org> <47F3362F.3020504@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-reply-to: <47F3362F.3020504@sgi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jes Sorensen <jes@sgi.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Carsten Otte <cotte@de.ibm.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

> > Have you looked at Jens Axboe's patches to make all this stuff a lot 
> > more arch-common?
>
> Nope, do you have a pointer?

Check your favourite archive for this Subject line:

 Generic smp_call_function(), improvements, and  smp_call_function_single()

-Tony
