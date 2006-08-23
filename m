From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 02:01:02 -0700
Message-ID: <44EC194E.6080606@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain> <1156319788.2829.12.camel@laptopd505.fenrus.org> <44EC1563.90206@vmware.com> <200608231050.13272.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751459AbWHWJBE@vger.kernel.org>
In-Reply-To: <200608231050.13272.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> Yes, after discussion with Rusty, it appears that beefing up 
>> stop_machine_run is the right way to go.  And it has benefits for 
>> non-paravirt code as well, such as allowing plug-in kprobes or oprofile 
>> extension modules to be loaded without having to deal with a debug 
>> exception or NMI during module load/unload.
>>     
>
> I'm still unclear where you think those debug exceptions will come from

kprobes set in the stop_machine code - which is probably a really bad 
idea, but nothing today actively stops kprobes from doing that.
