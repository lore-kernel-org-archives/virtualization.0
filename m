From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 02/28]xen: Add nosegneg capability to the vsyscall page
 notes
Date: Fri, 11 May 2007 13:25:00 -0700
Message-ID: <4644D11C.2040207@goop.org>
References: <20070511200744.4BC1A1F8512@magilla.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761482AbXEKUZX@vger.kernel.org>
In-Reply-To: <20070511200744.4BC1A1F8512@magilla.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland McGrath <roland@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Xen-devel <xen-devel@lists.xensource.com>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Zachary Amsden <zach@vmware.com>, Ulrich Drepper <drepper@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Roland McGrath wrote:
>> + * It should contain:
>> + *	hwcap 0 nosegneg
>> + * to match the mapping of bit to name that we give here.
>>     
>
> This comment still needs s/0/1/ to match the code.  Given that the actual
> bit is now defined in the macro in another file, perhaps the comment should
> say more about it than just a magic 1.
>   

Crap, I thought I had 1) understood it, and 2) fixed it.  I guess I
skipped 1 and therefore overlooked 2.

    J
