From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: dm-ioband + bio-cgroup benchmarks
Date: Thu, 18 Sep 2008 21:04:18 +0900 (JST)
Message-ID: <20080918.210418.226794540.ryov__41834.4623329633$1221739915$gmane$org@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, dm-devel@redhat.com, containers@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: fernando@oss.ntt.co.jp, balbir@linux.vnet.ibm.com, xemul@openvz.org, kamezawa.hiroyu@jp.fujitsu.com, agk@sourceware.org
List-Id: virtualization@lists.linuxfoundation.org

Hi All,

I have got excellent results of dm-ioband, that controls the disk I/O
bandwidth even when it accepts delayed write requests.

In this time, I ran some benchmarks with a high-end storage. The
reason was to avoid a performance bottleneck due to mechanical factors
such as seek time.

You can see the details of the benchmarks at:
http://people.valinux.co.jp/~ryov/dm-ioband/hps/

Thanks,
Ryo Tsuruta
