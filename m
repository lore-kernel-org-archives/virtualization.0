From: Amit Shah <amit.shah@redhat.com>
Subject: [PULL] virtio-rng: add derating factor for use by hwrng core
Date: Fri, 15 Aug 2014 10:46:35 +0530
Message-ID: <cover.1408078439.git.amit.shah@redhat.com>
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
To: torvalds@linux-foundation.org
Cc: jgarzik@bitpay.com, tytso@mit.edu, herbert@gondor.apana.org.au, kvm list <kvm@vger.kernel.org>, ricardo.neri-calderon@linux.intel.com, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, duwe@lst.de, Amit Shah <amit.shah@redhat.com>, hpa@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Linus,

Sending directly to you with the commit log changes Ted Ts'o pointed
out.  Not sure if Rusty's back after his travel, but this already has
his s-o-b.

Please pull.

The following changes since commit c9d26423e56ce1ab4d786f92aebecf859d419293:

  Merge tag 'pm+acpi-3.17-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2014-08-14 18:13:46 -0600)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/amit/virtio.git rng-queue

for you to fetch changes up to 34679ec7a0c45da8161507e1f2e1f72749dfd85c:

  virtio: rng: add derating factor for use by hwrng core (2014-08-15 10:26:01 +0530)

----------------------------------------------------------------

Amit Shah (1):
  virtio: rng: add derating factor for use by hwrng core

 drivers/char/hw_random/virtio-rng.c | 1 +
 1 file changed, 1 insertion(+)

-- 
1.9.3
