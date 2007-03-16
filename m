From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 20/26] Xen-paravirt_ops: Core Xen
	implementation
Date: Fri, 16 Mar 2007 09:57:39 -0700
Message-ID: <20070316165739.GL10574@sequoia.sous-sol.org>
References: <20070301232443.195603797@goop.org>
	<20070301232528.812011702@goop.org>
	<20070316091411.GF23174@elte.hu>
	<20070316163338.GI10574@sequoia.sous-sol.org>
	<45FAC969.6070006@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <45FAC969.6070006@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Chris Wright wrote:
> > That's been fixed, the two are built as seperate objects now.
> 
> Actually, we tried it but it causes bad kernel images with some
> binutils, so it has to be included for now.

Ah, missed that.

> >>> @@ -437,9 +437,9 @@ static unsigned long native_store_tr(voi
> >>>  
> >>>  static void native_load_tls(struct thread_struct *t, unsigned int cpu)
> >>>  {
> >>> -#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
> >>> -	C(0); C(1); C(2);
> >>> -#undef C
> >>> +	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 0] = t->tls_array[0];
> >>> +	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 1] = t->tls_array[1];
> >>> +	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 2] = t->tls_array[2];
> >>>  }
> >>>       
> >> this is a cleanup unrelated to the purpose of the patch.
> >>     
> >
> > Sure, will split out.
> >   
> 
> Already done in Rusty's cleanup patch.

Hmm, not here, I'll fix it up.

thanks,
-chris
