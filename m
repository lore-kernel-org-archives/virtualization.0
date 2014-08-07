From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/2] rng-tools: add udev rule for virtio-rng
Date: Thu,  7 Aug 2014 18:38:58 +0530
Message-ID: <cover.1407416628.git.amit.shah@redhat.com>
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
To: jgarzik@bitpay.com
Cc: linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>, hpa@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

Hello,

I didn't find a mailing list for rng-tools, so CC'ing the kernel lists
and the last few committers.

The first patch in this series adds a udev rule to start rngd for
guests that have a virtio-rng device available.

The second patch attempts to add autoconf magic to install the udev
rule in the system dirs.  However, installing as non-root will
obviously fail.  Prefixes are also not honoured.  I don't know of a
better way, and we probably should leave this to distributions.
However, if someone has a better idea on how to expand this, please
suggest.


Amit Shah (2):
  rngd: add udev rule to source from hwrng if virtio-rng present
  Install udev rules in system-default directory

 90-virtio-rng.rules | 1 +
 Makefile.am         | 1 +
 configure.ac        | 8 ++++++++
 3 files changed, 10 insertions(+)
 create mode 100644 90-virtio-rng.rules

-- 
1.9.3
