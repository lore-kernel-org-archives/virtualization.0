From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 14:41:14 -0700
Message-ID: <46CCAD7A.80505@vmware.com>
References: <46CBC842.4070100@vmware.com>	<20070822102217.GE2642@bingen.suse.de>	<46CC68D9.5060200@vmware.com>	<20070822175918.GB8058@bingen.suse.de>	<46CC6D63.2010204@vmware.com>	<20070822194632.GD8058@bingen.suse.de>	<46CC9FF2.3040406@vmware.com>	<20070822220451.GJ8058@bingen.suse.de> <20070822222528.7c58f1e9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934106AbXHVVqy@vger.kernel.org>
In-Reply-To: <20070822222528.7c58f1e9@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

Alan Cox wrote:
>> I still think it's preferable to change some drivers than everybody.
>>
>> AFAIK BusLogic as real hardware is pretty much dead anyways,
>> so you're probably the only primary user of it anyways.
>> Go wild on it!
>>     
>
> I don't believe anyone is materially maintaining the buslogic driver and
> in time its going to break completely.
>   

I think I was actually the last person to touch it ;)

>   
>> Well that might be. I just think it would be a mistake
>> to design paravirt_ops based on someone's short term release engineering
>> considerations.
>>     
>
> Agreed, especially as an interface where each in or out traps into the
> hypervisor is broken even for the model of virtualising hardware. 
>   

Well, it's not necessarily broken, it's just a different model.  At some 
point the cost of maintaining a whole suite of virtual drivers becomes 
greater than leveraging a bunch of legacy drivers.  If you can eliminate 
most of the performance cost of that by changing something at a layer 
below (port I/O), it is a win even if it is not a perfect solution.

But I think I've lost the argument anyways; it doesn't seem to be for 
the greater good of Linux, and there are alternatives we can take.  
Unfortunately for me, they require a lot more work.

Zach
