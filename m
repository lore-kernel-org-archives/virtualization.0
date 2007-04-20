From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC, PATCH 1/5] Paravirt_ops full patching.patch
Date: Fri, 20 Apr 2007 12:29:05 +1000
Message-ID: <1177036145.28587.7.camel@localhost.localdomain>
References: <20070420015224.56315BFC@zach-dev2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070420015224.56315BFC@zach-dev2.vmware.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Chaz Masden <zamsden@gmail.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-04-19 at 18:52 -0700, Zachary Amsden wrote:
> Add 5-argument handling for paravirt ops patching of PAE functions.

This seems like overkill: I don't know of any modules which frob ptes...

The rest look fine (I particularly like the getting rid of kernel_rpl:
we didn't use it everywhere anyway).

Cheers,
Rusty.
