From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 03/26] Xen-paravirt_ops: use paravirt_nop to consistently
 mark no-op operations
Date: Fri, 16 Mar 2007 13:00:58 -0700
Message-ID: <45FAF77A.8010607@goop.org>
References: <20070301232443.195603797@goop.org> <20070301232526.261284776@goop.org> <20070316094432.GU23174@elte.hu> <45FAE560.10401@goop.org> <20070316194904.GO10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753643AbXCPUBG@vger.kernel.org>
In-Reply-To: <20070316194904.GO10574@sequoia.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> how about __paravirt_nop_start < func < __paravirt_nop_end  and preserve
> the types?
>   

Er?  The reason for the (void *) cast is to stop gcc complaining about
mismatched pointer types.

    J
