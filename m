From: Quan Xu <quan.xu04@gmail.com>
Subject: [PATCH RFC v3 0/6] x86/idle: add halt poll support
Date: Mon, 13 Nov 2017 19:01:40 +0800
Message-ID: <1510570901-6373-1-git-send-email-quan.xu0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org
Cc: peterz@infradead.org, pbonzini@redhat.com, tglx@linutronix.de, Quan Xu <quan.xu0@gmail.com>, yang.zhang.wz@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Quan Xu <quan.xu0@gmail.com>

Some latency-intensive workload have seen obviously performance
drop when running inside VM. The main reason is that the overhead
is amplified when running inside VM. The most cost I have seen is
inside idle path.

This patch introduces a new mechanism to poll for a while before
entering idle state. If schedule is needed during poll, then we
don't need to goes through the heavy overhead path.

Here is the data we get when running benchmark contextswitch to measure
the latency(lower is better):

   1. w/o patch and disable kvm dynamic poll (halt_poll_ns=0):
     3402.9 ns/ctxsw -- 199.8 %CPU

   2. w/ patch and disable kvm dynamic poll (halt_poll_ns=0):
      halt_poll_threshold=10000  -- 1151.4 ns/ctxsw -- 200.1 %CPU
      halt_poll_threshold=20000  -- 1149.7 ns/ctxsw -- 199.9 %CPU
      halt_poll_threshold=30000  -- 1151.0 ns/ctxsw -- 199.9 %CPU
      halt_poll_threshold=40000  -- 1155.4 ns/ctxsw -- 199.3 %CPU
      halt_poll_threshold=50000  -- 1161.0 ns/ctxsw -- 200.0 %CPU
      halt_poll_threshold=100000 -- 1163.8 ns/ctxsw -- 200.4 %CPU
      halt_poll_threshold=300000 -- 1159.4 ns/ctxsw -- 201.9 %CPU
      halt_poll_threshold=500000 -- 1163.5 ns/ctxsw -- 205.5 %CPU

   3. w/ kvm dynamic poll:
      halt_poll_ns=10000  -- 3470.5 ns/ctxsw -- 199.6 %CPU
      halt_poll_ns=20000  -- 3273.0 ns/ctxsw -- 199.7 %CPU
      halt_poll_ns=30000  -- 3628.7 ns/ctxsw -- 199.4 %CPU
      halt_poll_ns=40000  -- 2280.6 ns/ctxsw -- 199.5 %CPU
      halt_poll_ns=50000  -- 3200.3 ns/ctxsw -- 199.7 %CPU
      halt_poll_ns=100000 -- 2186.6 ns/ctxsw -- 199.6 %CPU
      halt_poll_ns=300000 -- 3178.7 ns/ctxsw -- 199.6 %CPU
      halt_poll_ns=500000 -- 3505.4 ns/ctxsw -- 199.7 %CPU

   4. w/patch and w/ kvm dynamic poll:

      halt_poll_ns=10000 & halt_poll_threshold=10000  -- 1155.5 ns/ctxsw -- 199.8 %CPU
      halt_poll_ns=10000 & halt_poll_threshold=20000  -- 1165.6 ns/ctxsw -- 199.8 %CPU
      halt_poll_ns=10000 & halt_poll_threshold=30000  -- 1161.1 ns/ctxsw -- 200.0 %CPU

      halt_poll_ns=20000 & halt_poll_threshold=10000  -- 1158.1 ns/ctxsw -- 199.8 %CPU
      halt_poll_ns=20000 & halt_poll_threshold=20000  -- 1161.0 ns/ctxsw -- 199.7 %CPU
      halt_poll_ns=20000 & halt_poll_threshold=30000  -- 1163.7 ns/ctxsw -- 199.9 %CPU

      halt_poll_ns=30000 & halt_poll_threshold=10000  -- 1158.7 ns/ctxsw -- 199.7 %CPU
      halt_poll_ns=30000 & halt_poll_threshold=20000  -- 1153.8 ns/ctxsw -- 199.8 %CPU
      halt_poll_ns=30000 & halt_poll_threshold=30000  -- 1155.1 ns/ctxsw -- 199.8 %CPU

   5. idle=poll
      3957.57 ns/ctxsw --  999.4%CPU

Here is the data we get when running benchmark netperf:

   1. w/o patch and disable kvm dynamic poll (halt_poll_ns=0):
      29031.6 bit/s -- 76.1 %CPU

   2. w/ patch and disable kvm dynamic poll (halt_poll_ns=0):
      halt_poll_threshold=10000  -- 29021.7 bit/s -- 105.1 %CPU
      halt_poll_threshold=20000  -- 33463.5 bit/s -- 128.2 %CPU
      halt_poll_threshold=30000  -- 34436.4 bit/s -- 127.8 %CPU
      halt_poll_threshold=40000  -- 35563.3 bit/s -- 129.6 %CPU
      halt_poll_threshold=50000  -- 35787.7 bit/s -- 129.4 %CPU
      halt_poll_threshold=100000 -- 35477.7 bit/s -- 130.0 %CPU
      halt_poll_threshold=300000 -- 35730.0 bit/s -- 132.4 %CPU
      halt_poll_threshold=500000 -- 34978.4 bit/s -- 134.2 %CPU

   3. w/ kvm dynamic poll:
      halt_poll_ns=10000  -- 28849.8 bit/s -- 75.2  %CPU
      halt_poll_ns=20000  -- 29004.8 bit/s -- 76.1  %CPU
      halt_poll_ns=30000  -- 35662.0 bit/s -- 199.7 %CPU
      halt_poll_ns=40000  -- 35874.8 bit/s -- 187.5 %CPU
      halt_poll_ns=50000  -- 35603.1 bit/s -- 199.8 %CPU
      halt_poll_ns=100000 -- 35588.8 bit/s -- 200.0 %CPU
      halt_poll_ns=300000 -- 35912.4 bit/s -- 200.0 %CPU
      halt_poll_ns=500000 -- 35735.6 bit/s -- 200.0 %CPU

   4. w/patch and w/ kvm dynamic poll:

      halt_poll_ns=10000 & halt_poll_threshold=10000  -- 29427.9 bit/s -- 107.8 %CPU
      halt_poll_ns=10000 & halt_poll_threshold=20000  -- 33048.4 bit/s -- 128.1 %CPU
      halt_poll_ns=10000 & halt_poll_threshold=30000  -- 35129.8 bit/s -- 129.1 %CPU

      halt_poll_ns=20000 & halt_poll_threshold=10000  -- 31091.3 bit/s -- 130.3 %CPU
      halt_poll_ns=20000 & halt_poll_threshold=20000  -- 33587.9 bit/s -- 128.9 %CPU
      halt_poll_ns=20000 & halt_poll_threshold=30000  -- 35532.9 bit/s -- 129.1 %CPU

      halt_poll_ns=30000 & halt_poll_threshold=10000  -- 35633.1 bit/s -- 199.4 %CPU
      halt_poll_ns=30000 & halt_poll_threshold=20000  -- 42225.3 bit/s -- 198.7 %CPU
      halt_poll_ns=30000 & halt_poll_threshold=30000  -- 42210.7 bit/s -- 200.3 %CPU

   5. idle=poll
      37081.7 bit/s -- 998.1 %CPU

---
V2 -> V3:
- move poll update into arch/. in v3, poll update is based on duration of the
  last idle loop which is from tick_nohz_idle_enter to tick_nohz_idle_exit,
  and try our best not to interfere with scheduler/idle code. (This seems
  not to follow Peter's v2 comment, however we had a f2f discussion about it
  in Prague.)
- enhance patch desciption.
- enhance Documentation and sysctls.
- test with IRQ_TIMINGS related code, which seems not working so far.

V1 -> V2:
- integrate the smart halt poll into paravirt code
- use idle_stamp instead of check_poll
- since it hard to get whether vcpu is the only task in pcpu, so we
  don't consider it in this series.(May improve it in future)

---
Quan Xu (4):
  x86/paravirt: Add pv_idle_ops to paravirt ops
  KVM guest: register kvm_idle_poll for pv_idle_ops
  Documentation: Add three sysctls for smart idle poll
  tick: get duration of the last idle loop

Yang Zhang (2):
  sched/idle: Add a generic poll before enter real idle path
  KVM guest: introduce smart idle poll algorithm

 Documentation/sysctl/kernel.txt       |   35 ++++++++++++++++
 arch/x86/include/asm/paravirt.h       |    5 ++
 arch/x86/include/asm/paravirt_types.h |    6 +++
 arch/x86/kernel/kvm.c                 |   73 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/paravirt.c            |   10 +++++
 arch/x86/kernel/process.c             |    7 +++
 include/linux/kernel.h                |    6 +++
 include/linux/tick.h                  |    2 +
 kernel/sched/idle.c                   |    2 +
 kernel/sysctl.c                       |   34 +++++++++++++++
 kernel/time/tick-sched.c              |   11 +++++
 kernel/time/tick-sched.h              |    3 +
 12 files changed, 194 insertions(+), 0 deletions(-)
