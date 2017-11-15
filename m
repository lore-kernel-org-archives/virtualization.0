From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH RFC v3 0/6] x86/idle: add halt poll support
Date: Wed, 15 Nov 2017 16:31:31 -0500
Message-ID: <20171115213131.GB21113@char.us.oracle.com>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Quan Xu <quan.xu03@gmail.com>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 13, 2017 at 06:05:59PM +0800, Quan Xu wrote:
> From: Yang Zhang <yang.zhang.wz@gmail.com>
> 
> Some latency-intensive workload have seen obviously performance
> drop when running inside VM. The main reason is that the overhead
> is amplified when running inside VM. The most cost I have seen is
> inside idle path.

Meaning an VMEXIT b/c it is an 'halt' operation ? And then going
back in guest (VMRESUME) takes time. And hence your latency gets
all whacked b/c of this?

So if I understand - you want to use your _full_ timeslice (of the guest)
without ever (or as much as possible) to go in the hypervisor?

Which means in effect you don't care about power-saving or CPUfreq
savings, you just want to eat the full CPU for snack?

> 
> This patch introduces a new mechanism to poll for a while before
> entering idle state. If schedule is needed during poll, then we
> don't need to goes through the heavy overhead path.

Schedule of what? The guest or the host?
