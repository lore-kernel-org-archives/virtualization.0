From: Miche Baker-Harvey <miche@google.com>
Subject: [PATCH RFC v2 0/3] Support multiple VirtioConsoles.
Date: Tue, 08 Nov 2011 11:29:49 -0800
Message-ID: <20111108192949.30618.3953.stgit@miche.sea.corp.google.com>
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
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

(Amit pointed out that the patches never went out. This is a resend of
the series meant to go out on 11/2/2011; I've marked it "v2".)  

This patchset applies to linux-next/next-20111102.

This series implements support for multiple virtio_consoles using KVM.

This patchset addresses several issues associated with trying to
establish multiple virtio consoles. 

I'm trying to start a guest via KVM that supports multiple virtual
consoles, with getty's on each, and with some being console devices.

These patches let me establish more than one VirtioConsole (I'm
running eight at the moment), and enable console output appearing on
one of them.  It still doesn't successfully generate console output on
multiple VirtioConsoles.

Let me apologise for my last patch having gotten into Linus' tree, and
leaving other people to deal with crashes.  I had meant to be asking
for guidance, but I didn't mark it as "RFC".

This series reflects the input from Konrad Rzeszutek, Amit Shah, Stephen
Boyd, and Rusty Russell.  I think we do have to limit hvc_alloc() to one
thread.

I would appreciate any comments or feedback, or accept if appropriate.

Thanks,
Miche Baker-Harvey

---

Miche Baker-Harvey (3):
      virtio_console:  Fix locking of vtermno.
      hvc_init():  Enforce one-time initialization.
      Use separate struct console structure for each hvc_console.


 drivers/char/virtio_console.c |    9 ++++++---
 drivers/tty/hvc/hvc_console.c |   33 +++++++++++++++++++++++++++++++--
 drivers/tty/hvc/hvc_console.h |    1 +
 3 files changed, 38 insertions(+), 5 deletions(-)

-- 
