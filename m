From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 12/26] Xen-paravirt_ops: Fix patch site
 clobbers to include return register
Date: Thu, 01 Mar 2007 17:18:11 -0800
Message-ID: <45E77B53.1060309@vmware.com>
References: <20070301232443.195603797@goop.org>
	<20070301232527.755495278@goop.org>
	<45E7738D.5090607@vmware.com> <45E774AB.5090103@goop.org>
	<45E77569.9010602@vmware.com> <45E776D0.9020609@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45E776D0.9020609@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   
>>> Things like what?  Do you mean the %[foo] asm parameter syntax?  I think
>>> those versions are no longer supported - Arjan posted a patch a few days
>>> ago to convert a pile of asms to this form.  Or do you mean something
>>> else?
>>>   
>>>       
>> I meant having an output in the clobber list,
>>     
>
> There's no output in the clobber list, just "memory" and "cc".  The
> paravirt_clobber() is the stuff which gets put in the .parainstructions
> section which tells the patcher what registers are expected to be
> modified at that callsite (including both temp and output registers).
>   

Ah, ok.  I didn't think gcc had grown the appropriate antlers yet to 
allow outputs in the clobber list.  But the paravirt-clobbers, yes that 
makes sense.

Zach
