From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 11/25] xen: Xen SMP guest support
Date: Thu, 26 Apr 2007 23:46:19 -0700
Message-ID: <46319C3B.2010300@goop.org>
References: <20070423215638.563901986@goop.org> <20070423215711.197402369@goop.org> <200704251124.48445.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755419AbXD0Gpu@vger.kernel.org>
In-Reply-To: <200704251124.48445.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Benjamin LaHaise <bcrl@kvack.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> +/* VCPUs are single-cored, and have no siblings */
>> +static void set_cpu_sibling_map(int cpu)
>>     
>
> Can you put this somewhere generic and use it everywhere? Don't want
> duplication of this code.
>   

Are there any other users?  This is a very cutdown version of the code
in kernel/smpboot.c; under Xen all CPUs are considered to be
single-cored and single-threaded, so there's not a lot to do here.

    J
