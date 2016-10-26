From: Alexey Makhalov <amakhalov@vmware.com>
Subject: [PATCH 0/3] x86/vmware guest improvements
Date: Tue, 25 Oct 2016 22:20:35 -0700
Message-ID: <20161026052038.77042-1-amakhalov__28077.4015620866$1477935970$gmane$org@vmware.com>
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
To: corbet@lwn.net, akataria@vmware.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc: time-lords@vmware.com, monitor-list@vmware.com, pv-drivers@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Alexey Makhalov <amakhalov@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

This patchset includes several VMware guest improvements:

Alexey Makhalov (3):
  x86/vmware: Use tsc_khz value for calibrate_cpu()
  x86/vmware: Add basic paravirt ops support
  x86/vmware: Add paravirt sched clock

 Documentation/kernel-parameters.txt |  4 +++
 arch/x86/kernel/cpu/vmware.c        | 51 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

-- 
2.10.1
