From: Daniel Verkamp <dverkamp@chromium.org>
Subject: Regression with "arm64: KVM: Skip MMIO insn after emulation" on 4.4
	stable
Date: Wed, 27 Feb 2019 16:36:39 -0800
Message-ID: <CABVzXAnm78j6mwbNF2MWTwkBcXVmCdWYdZfXJBhiThOEK3135w__702.930979763039$1551315004$gmane$org@mail.gmail.com>
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
To: virtualization@lists.linux-foundation.org, stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

In my testing of crosvm[1] with Linux 4.4.175, I am observing failures
on a 'kevin' Chromebook (RK3399) device - the guest kernel does not
even get to the point of printing its first messages, and the host
seems to be spinning at 100% CPU in KVM_RUN.

I narrowed this down to the 4.4 stable backport of "arm64: KVM: Skip
MMIO insn after emulation" - with this patch reverted, I can boot the
guest kernel as normal again.

Unfortunately, I am unable to easily test with a newer upstream kernel
(this board is using the Chrome OS kernel with many additional patches
applied on top of 4.4), so I'm not sure if this issue was introduced
in the mainline commit or only in the stable branch.  Is it possible
that this patch has other dependencies that were missed in the
backport?  It looks like it was part of a larger series, but only this
patch got pulled for 4.4 stable.

Thanks,
-- Daniel

[1]: https://chromium.googlesource.com/chromiumos/platform/crosvm/
