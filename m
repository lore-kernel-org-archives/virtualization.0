From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/4] Virtual Machine Time Accounting
Date: Tue, 04 Aug 2009 16:16:38 +0200
Message-ID: <1249395398.7924.223.camel__46472.1842705787$1249395769$gmane$org@twins>
References: <46C99371.7070705@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C99371.7070705@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

These patches never seem to have made it onto LKML?!

On Mon, 2007-08-20 at 15:13 +0200, Laurent Vivier wrote:
> The aim of these four patches is to introduce Virtual Machine time accounting.
> 
> _Ingo_, as these patches modify files of the scheduler, could you have a look to
> them, please ?
> 
> [PATCH 1/4] as recent CPUs introduce a third running state, after "user" and
> "system", we need a new field, "guest", in cpustat to store the time used by
> the CPU to run virtual CPU. Modify /proc/stat to display this new field.
> 
> [PATCH 2/4] like for cpustat, introduce the "gtime" (guest time of the task) and
> "cgtime" (guest time of the task children) fields for the
> tasks. Modify signal_struct and task_struct. Modify /proc/<pid>/stat to display
> these new fields.
> 
> [PATCH 3/4] modify account_system_time() to add cputime to cpustat->guest if we
> are running a VCPU. We add this cputime to  cpustat->user instead of
> cpustat->system because this part of KVM code is in fact user code although it
> is executed in the kernel. We duplicate VCPU time between guest and user to
> allow an unmodified "top(1)" to display correct value. A modified "top(1)" is
> able to display good cpu user time and cpu guest time by subtracting cpu guest
> time from cpu user time. Update "gtime" and "cgtime" in signal_struct and
> task_struct accordingly.
> 
> [PATCH 4/4] Modify KVM to update guest time accounting.

Isn't this exactly what CONFIG_VIRT_CPU_ACCOUNTING is about?
