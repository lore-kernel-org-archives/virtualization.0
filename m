From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH 4/5] Paravirt_ops drop internal patches.patch
Date: Thu, 19 Apr 2007 22:10:33 -0700
Message-ID: <46284B49.9080804@goop.org>
References: <20070420015254.6C451BFC@zach-dev2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070420015254.6C451BFC@zach-dev2.vmware.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <petr@vmware.com>, Chaz Masden <zamsden@gmail.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Some of these boot hooks do not need to be patched, in fact, it is better not
> to patch them at all and thus keep them totally private.
>   

I think I generally backed off on patching init functions and the like. 
Are these really the only ones which need adjustment?  I bet things like
the descriptor functions could be indirect/private with very little impact.

    J
