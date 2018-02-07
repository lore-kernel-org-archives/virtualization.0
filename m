From: kbuild test robot <fengguang.wu@intel.com>
Subject: [vhost:vhost 19/20] Warning: arch/x86/tools/test_get_len found
	difference at <pm_restore_gfp_mask>:ffffffff811aa5f0
Date: Wed, 7 Feb 2018 15:02:57 +0800
Message-ID: <201802071553.fDlNxEKX%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Liang Li <liang.z.li@intel.com>, virtualization@lists.linux-foundation.org, kbuild-all@01.org
List-Id: virtualization@lists.linuxfoundation.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
head:   96bcd04462b99e2c80e09f6537770a0ca6b288d0
commit: cc1d1dc07885803981520a5303ef5b130f2ca2e8 [19/20] mm: support reporting free page blocks
config: x86_64-rhel
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout cc1d1dc07885803981520a5303ef5b130f2ca2e8
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
