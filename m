From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 05 Mar 2007 17:51:25 -0800
Message-ID: <45ECC91D.1020809@vmware.com>
References: <20070305120631.GA14105@elte.hu>		<1173101297.26165.39.camel@localhost.localdomain>	<1173142644.4644.6.camel@localhost.localdomain> <45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933830AbXCFBwH@vger.kernel.org>
In-Reply-To: <45ECC076.9050209@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> I think Jan's approach is better if it works (since there's no
> compromise), but this is better if you want to get something working in
> the near term.
>   

Is Jan dynamically relinking the vdso at runtime?  Because that is what 
we will need.  Adding support for COMPAT_VDSO creates a major 
performance problem for us.  We need a way to force the VDSO to be 
enabled with a boot parameter.

Zach
