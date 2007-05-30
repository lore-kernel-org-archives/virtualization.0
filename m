From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Wed, 30 May 2007 08:38:31 -0700
Message-ID: <465D9A77.90505@goop.org>
References: <465D8F03.7000201@us.ibm.com>
	<465D8FF5.6040804@us.ibm.com>	<200705301701.23386.ak@suse.de>
	<465D9907.40406@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465D9907.40406@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Sure.  It adds a few more cycles onto native though (two memory reads,
> and some math).

As opposed to a serializing control-register read?  I think that's
probably a win.

    J
