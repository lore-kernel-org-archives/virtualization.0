From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: [PATCH/RFC 0/4]Virtual Machine time accounting
Date: Thu, 16 Aug 2007 17:57:32 +0200
Message-ID: <46C473EC.8000309__15158.7709937759$1187279976$gmane$org@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The aim of these four patches is to introduce Virtual Machine time accounting.

[PATCH 1/4] as modern CPUs introduce a third running state, after "user" and
"system", we need a new field, "guest", in cpustat to store the time used by
the CPU to run virtual CPU. Modify /proc/stat to display this new field.

[PATCH 2/4] like for cpustat, introduce the "guest" and "cguest" fields for the
tasks. Modify signal_struct and task_struct. Modify /proc/<pid>/stat to display
these new field

[PATCH 3/3] introduce "account modifiers" mechanism in the kernel allowing a
module to modify the collected accounting for a given task. This implementation
is based on the "preempt_notifier". "account_system_time()" and
"account_user_time()" can call functions registered by a module to modify the
cputime value.

[PATCH 4/4] Modify KVM to use the "account modifiers". KVM can now measure time
consumed by a Virtual Machine on a per-cpu basis and modify kernel statistics to
report this value.

Signed-off-by: Laurent Vivier <Laurent.Vivier@bull.net>
-- 
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth
