From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC] first cut at splitting up paravirt_ops
Date: Mon, 09 Jul 2007 23:40:49 -0700
Message-ID: <469329F1.4080505@goop.org>
References: <4692D076.6060204@goop.org> <4692D871.60002@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4692D871.60002@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Well, I think they are pretty good, but for the init group of ops, it 
> seems it would be clearer conceptually to group pagetable setup with 
> the MMU hooks and time init with the time operations.  Otherwise, the 
> init group gets very jumbled as we pull in new interfaces (APIC has 
> BSP and AP init functions, for example).

I tend to agree, but the main reason I grouped them is because they're 
init code, and therefore need never be exported.  Also, some are really 
just used at boot time, and don't clearly fit into any other grouping.  
I guess I could expand pv_misc_ops.

> I think that is probably the best solution; splitting the patch code 
> to deal with individual structure seems awkward.

Yes.

The only downside is that moving an op between groups requires quite a 
few places to be touched.  At least its all compile-time checked.

    J
