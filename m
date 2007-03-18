From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: [patch 20/26] Xen-paravirt_ops: Core Xen	implementation
Date: Sun, 18 Mar 2007 00:03:10 -0700
Message-ID: <45FCE42E.1030107@goop.org>
References: <20070301232443.195603797@goop.org>	 <20070301232528.812011702@goop.org>  <20070316091411.GF23174@elte.hu> <1174122827.8897.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753105AbXCRHDL@vger.kernel.org>
In-Reply-To: <1174122827.8897.18.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Fri, 2007-03-16 at 10:14 +0100, Ingo Molnar wrote:
>   
>>> +unsigned long xen_pmd_val(pmd_t pmd)
>>> +{
>>> +	BUG();
>>> +	return 0;
>>> +}
>>>       
>> make it noret.
>>     
>
> OK, I missed this one.  How?
>
> Wondering if I've missed a trick here...

No, I don't think its terribly useful to make it noret; noret is an
interface annotation to let the caller know the function won't return. 
If I mark this noret, then the compiler will complain that it does
appear to return.

    J
