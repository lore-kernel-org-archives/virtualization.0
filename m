From: Alexey Makhalov <amakhalov@vmware.com>
Subject: [PATCH v3 0/3] x86/vmware guest improvements
Date: Fri, 28 Oct 2016 00:54:29 -0700
Message-ID: <20161028075432.90579-1-amakhalov__13020.8614319146$1477936107$gmane$org@vmware.com>
References: <alpine.DEB.2.20.1610272244060.4913@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.20.1610272244060.4913@nanos>
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
Cc: pv-drivers@vmware.com, virtualization@lists.linux-foundation.org, Alexey Makhalov <amakhalov@vmware.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Thanks Thomas for the valuable comments.

Changelog for the updated patchset:
v1->v2 - Update pvinfo.name.
v2->v3 - Address comments from Thomas G,
	 * Created separate function: vmware_sched_clock_setup() (patch 3/3)
	 * Updated commit descriptions for 1/3 and 3/3


Alexey Makhalov (3):
  x86/vmware: Use tsc_khz value for calibrate_cpu()
  x86/vmware: Add basic paravirt ops support
  x86/vmware: Add paravirt sched clock

 Documentation/kernel-parameters.txt |  4 +++
 arch/x86/kernel/cpu/vmware.c        | 55 +++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

-- 
2.10.1
