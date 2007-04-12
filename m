From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/4] Pte drop ptep_get_and_clear paravirt op.patch
Date: Thu, 12 Apr 2007 12:47:52 -0700
Message-ID: <461E8CE8.2070808@vmware.com>
References: <200704120530.l3C5Ubs0022821@zach-dev.vmware.com> <461E8D16.6060202@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965529AbXDLTuk@vger.kernel.org>
In-Reply-To: <461E8D16.6060202@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Hugh Dickins <hugh@veritas.com>, David Rientjes <rientjes@google.com>, Michel Lespinasse <walken@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   
>> In shadow mode hypervisors, ptep_get_and_clear achieves the desired
>> purpose of keeping the shadows in sync by issuing a native_get_and_clear,
>> followed by a call to pte_update, which indicates the PTE has been
>> modified.
>>
>> Direct mode hypervisors (Xen) have no need for this anyway, and will trap
>> the update using writable pagetables.
>>
>> This means no hypervisor makes use of ptep_get_and_clear; there is no
>> reason to have it in the paravirt-ops structure.  Change confusing
>> terminology about raw vs. native functions into consistent use of
>> native_pte_xxx for operations which do not invoke paravirt-ops.
>>   
>>     
>
> Looks OK to me.  Are you going to put this into the pvops queue?
>
> Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>

Yes, the rest are still undergoing feedback.  I'll kick this in and 
fixup the damage it causes.

Zach
