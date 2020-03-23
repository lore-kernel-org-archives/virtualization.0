From: Alexey Makhalov via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 0/5] x86/vmware: Steal time accounting support
Date: Mon, 23 Mar 2020 19:57:02 +0000
Message-ID: <20200323195707.31242-1-amakhalov@vmware.com>
References: <20200212200312.2033-1-amakhalov@vmware.com>
Reply-To: Alexey Makhalov <amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200212200312.2033-1-amakhalov@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This is a second version of the series. Changes are mentioned bellow.
Big thanks for the reviewers.

v2 changes:
  - renamed steal_time to vmw_steal_time (3rd patch) to avoid
    conflict with KVM one to fix compilation issue found by
    Borislav Petkov and kbuild test robot <lkp@intel.com>
  - added: "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>"

Best regards,
Alexey

Alexey Makhalov (5):
  x86/vmware: Make vmware_select_hypercall() __init
  x86/vmware: Remove vmware_sched_clock_setup()
  x86/vmware: Steal time clock for VMware guest
  x86/vmware: Enable steal time accounting
  x86/vmware: Use bool type for vmw_sched_clock

 Documentation/admin-guide/kernel-parameters.txt |   2 +-
 arch/x86/kernel/cpu/vmware.c                    | 229 +++++++++++++++++++++++-
 2 files changed, 222 insertions(+), 9 deletions(-)

-- 
2.14.2
