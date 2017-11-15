From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC v3 0/6] x86/idle: add halt poll support
Date: Wed, 15 Nov 2017 13:13:14 +0100
Message-ID: <20171115121314.s7hhcb6f36uasrku__34916.9534202248$1510748002$gmane$org@hirez.programming.kicks-ass.net>
References: <1510570901-6373-1-git-send-email-quan.xu0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1510570901-6373-1-git-send-email-quan.xu0@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Quan Xu <quan.xu04@gmail.com>
Cc: yang.zhang.wz@gmail.com, Quan Xu <quan.xu0@gmail.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 13, 2017 at 07:01:40PM +0800, Quan Xu wrote:
>  Documentation/sysctl/kernel.txt       |   35 ++++++++++++++++
>  arch/x86/include/asm/paravirt.h       |    5 ++
>  arch/x86/include/asm/paravirt_types.h |    6 +++
>  arch/x86/kernel/kvm.c                 |   73 +++++++++++++++++++++++++++++++++
>  arch/x86/kernel/paravirt.c            |   10 +++++
>  arch/x86/kernel/process.c             |    7 +++
>  include/linux/kernel.h                |    6 +++
>  include/linux/tick.h                  |    2 +
>  kernel/sched/idle.c                   |    2 +
>  kernel/sysctl.c                       |   34 +++++++++++++++
>  kernel/time/tick-sched.c              |   11 +++++
>  kernel/time/tick-sched.h              |    3 +
>  12 files changed, 194 insertions(+), 0 deletions(-)

You seem to have forgotten to CC me on the actual patches, but no. Not
going to happen.
