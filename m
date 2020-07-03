From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 6/8] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
Date: Thu, 2 Jul 2020 20:36:07 -0400
Message-ID: <3730577a-1e14-0e3e-7f7b-0c6cb68fb1f2@redhat.com>
References: <20200702074839.1057733-7-npiggin@gmail.com>
 <202007030059.nT5quxzB%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <202007030059.nT5quxzB%lkp@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 7/2/20 12:15 PM, kernel test robot wrote:
> Hi Nicholas,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on tip/locking/core v5.8-rc3 next-20200702]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-queued-spinlocks-and-rwlocks/20200702-155158
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-allyesconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     kernel/locking/lock_events.c:61:16: warning: no previous prototype for 'lockevent_read' [-Wmissing-prototypes]
>        61 | ssize_t __weak lockevent_read(struct file *file, char __user *user_buf,
>           |                ^~~~~~~~~~~~~~
>     kernel/locking/lock_events.c: In function 'skip_lockevent':
>>> kernel/locking/lock_events.c:126:12: error: implicit declaration of function 'pv_is_native_spin_unlock' [-Werror=implicit-function-declaration]
>       126 |   pv_on = !pv_is_native_spin_unlock();
>           |            ^~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
>
> vim +/pv_is_native_spin_unlock +126 kernel/locking/lock_events.c

I think you will need to add the following into 
arch/powerpc/include/asm/qspinlock_paravirt.h:

static inline pv_is_native_spin_unlock(void)
{
     return !is_shared_processor();
}

Cheers,
Longman
