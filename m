From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt
 kernels
Date: Wed, 01 Nov 2006 15:24:44 -0800
Message-ID: <45492CBC.8020501@vmware.com>
References: <20061029024504.760769000@sous-sol.org> <20061029024606.496399000@sous-sol.org> <20061101121753.GA2205@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752558AbWKAXYq@vger.kernel.org>
In-Reply-To: <20061101121753.GA2205@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Pavel Machek wrote:
> On Sat 2006-10-28 00:00:04, Chris Wright wrote:
>   
>> Allow selected bug checks to be skipped by paravirt kernels.  The two most
>> important are the F00F workaround (which is either done by the hypervisor,
>> or not required), and the 'hlt' instruction check, which can break under
>> some hypervisors.
>>     
>
> How can hlt check break? It is hlt;hlt;hlt, IIRC, that looks fairly
> innocent to me.
>   

Not if you use tickless timers that don't generate interrupts to unhalt 
you, or if you delay ticks until the next scheduled timeout and you 
haven't yet scheduled any timeout.  Both are likely in a hypervisor.

Zach
