From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/paravirt: hide unused patch_default label
Date: Fri, 16 Dec 2016 10:51:50 +0100
Message-ID: <20161216095150.GQ3107@twins.programming.kicks-ass.net>
References: <20161216091700.2499520-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20161216091700.2499520-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 16, 2016 at 10:16:35AM +0100, Arnd Bergmann wrote:
> A bugfix introduced a harmless warning:
> 
> arch/x86/kernel/paravirt_patch_32.c: In function 'native_patch':
> arch/x86/kernel/paravirt_patch_32.c:71:1: error: label 'patch_default' defined but not used [-Werror=unused-label]
> 
> This puts it in the same #ifdef as its caller.
> 
> Fixes: 45dbea5f55c0 ("x86/paravirt: Fix native_patch()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

This seems to work as well and is less invasive


 arch/x86/kernel/paravirt_patch_32.c | 2 +-
 arch/x86/kernel/paravirt_patch_64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index d33ef165b1f8..553acbbb4d32 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -68,7 +68,7 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 #endif
 
 	default:
-patch_default:
+patch_default: __maybe_unused
 		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
 		break;
 
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index f4fcf26c9fce..11aaf1eaa0e4 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -80,7 +80,7 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 #endif
 
 	default:
-patch_default:
+patch_default: __maybe_unused
 		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
 		break;
