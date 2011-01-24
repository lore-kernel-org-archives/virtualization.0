From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/3] kvm hypervisor : Add hypercalls to support
	pv-ticketlock
Date: Mon, 24 Jan 2011 09:49:58 -0800
Message-ID: <4D3DBBC6.1000407__37357.264562934$1295894598$gmane$org@goop.org>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110119164432.GA30669@linux.vnet.ibm.com>
	<20110119171239.GB726@linux.vnet.ibm.com>
	<1295457672.28776.144.camel@laptop> <4D373340.60608@goop.org>
	<20110120115958.GB11177@linux.vnet.ibm.com>
	<4D38774B.6070704@goop.org>
	<20110121140208.GA13609@linux.vnet.ibm.com>
	<4D399CBD.10506@redhat.com>
	<20110122061417.GA7258@linux.vnet.ibm.com>
	<4D3AEF7A.1050709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D3AEF7A.1050709@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, vatsa@linux.vnet.ibm.com, Jan Beulich <JBeulich@novell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?B?QW3DqXJpY28gV2FuZw==?= <xiyou.wangcong@gmail.com>, Eric Dumazet <dada1@cosmosbay.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/22/2011 06:53 AM, Rik van Riel wrote:
> The main question that remains is whether the PV ticketlocks are
> a large enough improvement to also merge those.  I expect they
> will be, and we'll see so in the benchmark numbers.

The pathological worst-case of ticket locks in a virtual environment
isn't very hard to hit, so I expect they'll make a huge difference
there.   On lightly loaded systems (little or no CPU overcommit) then
they should be close to a no-op.

    J
