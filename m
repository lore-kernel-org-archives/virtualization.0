From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/5] lguest: use set_pte/set_pmd uniformly for real page
	table	entries
Date: Mon, 21 Sep 2009 11:44:41 -0700
Message-ID: <4AB7C999.1040905@goop.org>
References: <200909210723.n8L7Nmcw022125@smtp1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200909210723.n8L7Nmcw022125@smtp1.linux-foundation.org>
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
Cc: virtualization@lists.osdl.org, lguest@ozlabs.org, Matias Zabaljauregui <zabaljauregui@gmail.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/21/09 00:22, Rusty Russell wrote:
> If we're building a pte, we can use simple assigment; only use set_pte
> etc. when we're actually going to use that destination as a PTE.  I
> don't know that we'll ever run under Xen, but it's neater.
>   

I've always thought it would be a Neat Thing To Try.  If it worked, it
would show things are working as they are supposed to.

    J
