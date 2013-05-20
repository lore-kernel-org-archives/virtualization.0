From: Venkatesh Srinivas <venkateshs@google.com>
Subject: Possible bug in KVM arch/x86/kvm/emulate.c:check_cr_write()?
Date: Mon, 20 May 2013 13:08:56 -0700
Message-ID: <CAHdzE--HGb-+1L8HQ6=Zz9WcDZD0ia44vE1LDa9XB_U3RUL3sQ@mail.gmail.com>
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

Hi,

When KVM's check_cr_write() is invoked to write to %cr3, it tests that
the lower three bits of %cr3 are set to zero. On real h/w (tested on
Core2, K10), these bits are ignored; the AMD64 documentation describes
the bits as 'should', but not 'must' be zero. The Intel documentation
seems to indicate that the bits are ignored as well.

I don't know whether to call this a bug or not, but it is a divergence
from real h/w.

Thanks,
-- vs;
