From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 13/14] x86/ticketlock: add slowpath logic
Date: Wed, 17 Nov 2010 00:56:00 -0800
Message-ID: <4CE398A0.3040105__37326.6022223563$1289984195$gmane$org@goop.org>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com><cover.1289940821.git.jeremy.fitzhardinge@citrix.com>	<97ed99ae9160bdb6477284b333bd6708fb7a19cb.1289940821.git.jeremy.fitzhardinge@citrix.com>	<4CE3A1060200007800022B04@vpn.id2.novell.com>
	<4CE397C8.9040901@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE397C8.9040901@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Xen-devel <xen-devel@lists.xensource.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xiyou.wangcong@gmail.com, Eric Dumazet <dada1@cosmosbay.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/17/2010 12:52 AM, Jeremy Fitzhardinge wrote:
> But, yes, %z0 sounds interesting.  Is it documented anywhere?  I think
> I've tried to use it in the past and run into gcc bugs.
This one: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=39590

Should be OK in this case because there's no 64-bit values to be seen...

    J
