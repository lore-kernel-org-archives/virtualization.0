From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/14] x86/ticketlock: add slowpath logic
Date: Thu, 20 Jan 2011 09:58:12 +0530
Message-ID: <20110120042811.GA17034__35618.9079735943$1295497780$gmane$org@linux.vnet.ibm.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<97ed99ae9160bdb6477284b333bd6708fb7a19cb.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110117152222.GA19233@linux.vnet.ibm.com>
	<4D372DEA.1060004@goop.org>
	<20110119183914.GB7235@linux.vnet.ibm.com>
	<4D37338E.8030509@goop.org>
Reply-To: vatsa@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D37338E.8030509@goop.org>
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
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 19, 2011 at 10:55:10AM -0800, Jeremy Fitzhardinge wrote:
> On 01/19/2011 10:39 AM, Srivatsa Vaddagiri wrote:
> > I have tested quite extensively with booting a 16-vcpu guest (on a 16-pcpu host)
> > and running kernel compine (with 32-threads). Without this patch, I had
> > difficulty booting/shutting-down successfully (it would hang mid-way).
> 
> Sounds good.  But I like to test with "make -j 100-200" to really give
> things a workout.

I reran the tests with the following configuration:

Host : 16pcpus, 32GB Memory
Single KVM guest w/ 32vcpus, 16GB memory

It survived a kernel compile with 200 threads once and another time with 300
threads. 'make allyesconfig' was run before compiling the kernel. So looks
quite stable to me ..additional testing from wider community will also help.

- vasa
