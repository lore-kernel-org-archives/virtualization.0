From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 15:32:39 +0300
Message-ID: <46CC2CE7.5000105@qumranet.com>
References: <46CBC842.4070100@vmware.com> <46CBCADF.2070400@qumranet.com> <1187763956.6174.48.camel@localhost.localdomain> <20070822103545.GG2642@bingen.suse.de> <46CC0719.2080103@qumranet.com> <20070822110810.GO32640@bingen.suse.de> <46CC0EAF.3000805@qumranet.com> <20070822112352.GQ32640@bingen.suse.de> <46CC2766.7020602@qumranet.com> <20070822131547.GS32640@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760285AbXHVMci@vger.kernel.org>
In-Reply-To: <20070822131547.GS32640@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> Ah.  But that's mostly modules, so real in-core changes should be very 
>>     
>
> Yes that's the big difference. Near all paravirt ops are concentrated
> on the core kernel, but this one affects lots of people.
>
> And why "but"? -- modules are as important as the core kernel. They're
> not second citizens.
>   

It's not being second class; simply few modules are loaded at runtime, 
so most of the code impact is on disk.  The in-code impact is small.  If 
paravirt i/o insns are worthwhile, I don't think code size is an issue.

-- 
error compiling committee.c: too many arguments to function
