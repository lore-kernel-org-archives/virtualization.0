From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 0/5] Paravirt: fix export of paravirt-ops to binary
 modules
Date: Fri, 20 Apr 2007 14:25:06 -0700
Message-ID: <46292FB2.5030404@vmware.com>
References: <20070420015214.6834BBFC@zach-dev2.vmware.com>
	<200704201134.42116.ak@suse.de> <4628D64A.4070900@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4628D64A.4070900@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <petr@vmware.com>, Chaz Masden <zamsden@gmail.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
>   
>> Basic idea looks good.
>>
>> But is the 5 argument support really needed? 	I don't see any paravirt 
>> ops functions that needs it and even if there was one it still wouldn't be clear
>> if it made sense to export it.
>>     
>
> 64-bit args are passed as a pair of 32-bit args, so PAE set_pte_at*
> functions end up with 5 args.  They're used often, so they may be worth
> patching, but I'm not sure if they're worth exporting.  They are
> implicitly exported in a non-PARAVIRT build by the fact that they're
> inline functions/macros in a header.  I don't know if any modules
> actually use them.
>   

Yes, I don't know either - but we should be consistent about their 
export regardless of whether PAE is selected or not.  So we should 
either have 5 arg macros or not export set_pte_at* at all, even in 4 arg 
version.

Zach
