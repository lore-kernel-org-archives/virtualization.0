From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH 13/14] x86/ticketlock: add slowpath logic
Date: Thu, 20 Jan 2011 09:52:21 +0000
Message-ID: <4D3813E5020000780002D5FA__35834.9744500176$1295517172$gmane$org@vpn.id2.novell.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<97ed99ae9160bdb6477284b333bd6708fb7a19cb.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110117152222.GA19233@linux.vnet.ibm.com> <4D372DEA.1060004@goop.org>
	<20110119183914.GB7235@linux.vnet.ibm.com> <4D37338E.8030509@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D37338E.8030509@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vatsa@linux.vnet.ibm.com, Eric Dumazet <dada1@cosmosbay.com>, Xen-devel <xen-devel@lists.xensource.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xiyou.wangcong@gmail.com, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

>>> On 19.01.11 at 19:55, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> On 01/19/2011 10:39 AM, Srivatsa Vaddagiri wrote:
>> I have tested quite extensively with booting a 16-vcpu guest (on a 16-pcpu 
> host)
>> and running kernel compine (with 32-threads). Without this patch, I had
>> difficulty booting/shutting-down successfully (it would hang mid-way).
> 
> Sounds good.  But I like to test with "make -j 100-200" to really give
> things a workout.

Hmm, in my experience, heavily over-committing CPUs (e.g. a
domain with double or more the vCPU-s that the system has
pCPU-s, or the pCPU-s the domain is allowed to run on) is a
much better test for eventual problems in the spin lock code
paths.

Jan
