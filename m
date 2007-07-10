From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH RFC] first cut at splitting up paravirt_ops
Date: Mon, 09 Jul 2007 17:53:05 -0700
Message-ID: <4692D871.60002@vmware.com>
References: <4692D076.6060204@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4692D076.6060204@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Here's a first attempt at splitting up paravirt_ops into more specific 
> chunks.  Its pretty clunky and chunky; mostly just a lot of 
> replacement.  The grouping of ops is very first cut; I'm open to 
> suggestions about what groups should exist and what ops they each 
> should contain.
>

Well, I think they are pretty good, but for the init group of ops, it 
seems it would be clearer conceptually to group pagetable setup with the 
MMU hooks and time init with the time operations.  Otherwise, the init 
group gets very jumbled as we pull in new interfaces (APIC has BSP and 
AP init functions, for example).


> The only slightly subtle part is that I've kept the structures wrapped 
> in a paravirt_ops structure, primarily so that we can still use 
> offsetof for generating patching IDs.  The paravirt_ops is static, and 
> I extract the sub-groups with global aliases which can be individually 
> exported.

I think that is probably the best solution; splitting the patch code to 
deal with individual structure seems awkward.

Zach
