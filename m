From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC,
	PATCH 0/5] Paravirt: fix export of paravirt-ops to binary modules
Date: Mon, 23 Apr 2007 01:49:43 +0200
Message-ID: <200704230149.44137.ak@suse.de>
References: <20070420015214.6834BBFC@zach-dev2.vmware.com>
	<46293266.9020306@vmware.com>
	<1177285027.17026.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177285027.17026.0.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Chaz Masden <zamsden@gmail.com>, Petr Vandrovec <petr@vmware.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org


> Less exports good.  Consistency with all config options isn't a hard
> requirement: I'd be tempted not to export the pte functions.

Yes paravirt_ops should be probably split into two for internal and external
available functions. Any takers? 

-Andi
