From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 13:23:43 +0300
Message-ID: <46CC0EAF.3000805@qumranet.com>
References: <46CBC842.4070100@vmware.com> <46CBCADF.2070400@qumranet.com> <1187763956.6174.48.camel@localhost.localdomain> <20070822103545.GG2642@bingen.suse.de> <46CC0719.2080103@qumranet.com> <20070822110810.GO32640@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759556AbXHVKXj@vger.kernel.org>
In-Reply-To: <20070822110810.GO32640@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> I don't see why it's intrusive -- they all use the APIs, right?
>>     
>
> Yes, but it still changes them. It might have a larger impact
> on code size for example. 
>   

Only if CONFIG_PARAVIRT is defined.  And even then, all the performance 
sensitive stuff uses mmio, no?


-- 
error compiling committee.c: too many arguments to function
